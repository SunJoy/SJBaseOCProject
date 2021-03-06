//
//  LocationManager.m
//  NewProject
//
//  Created by dumeng on 22/9/14.
//  Copyright (c) 2014 eidolonstudio. All rights reserved.
//

#import "LocationManager.h"
#import "WGS84TOGCJ02.h"

#define YXPositioningNumber 5 //定位次数，目前设为5次，提高精准度

@interface LocationManager (){
    int positioningNumber;  //定位次数
}

@property(nonatomic,strong) NSTimer* timer;
- (void)getAddress;

@end

@implementation LocationManager

+ (LocationManager*) sharedInstance
{
    static LocationManager *_singleton = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

- (id)init
{
    self = [super init];
    _latitude = 0.0f;
    _longitude = 0.0f;
    _address = @"";
    _city = @"";
    _province = @"";
    _street = @"";
    _county = @"";

    return self;
}

- (BOOL)pictureGPS
{
    NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
    NSString *firstStr = [u objectForKey:@"vc_pictureGPS"];
    if (firstStr&&[firstStr isEqualToString:@"yes"]) {
        return YES;
    }
    return NO;
}

- (void)requestLocation
{
    if([CLLocationManager locationServicesEnabled])
    {
        if (!_locationManager) {
            [CLLocationManager locationServicesEnabled];
            _locationManager = [[CLLocationManager alloc]init];
            [_locationManager setDelegate:self];
            [_locationManager setDistanceFilter:kCLDistanceFilterNone];
            [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
            
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [_locationManager requestAlwaysAuthorization];
            }
            
        }
        positioningNumber = 0;
        [_locationManager startUpdatingLocation];
    }
    else
    {
        self.latitude = 0.0f;
        self.longitude = 0.0f;
    }
}


-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status

{
    if (status == kCLAuthorizationStatusDenied) {
//        UIAlertView *tempA = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//        
//        [tempA show];
    }
    else if(status == kCLAuthorizationStatusRestricted)
    {
        UIAlertView *tempA = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位服务无法使用" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        
        [tempA show];
    }
    else if(status == kCLAuthorizationStatusNotDetermined)
    {
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [_locationManager requestAlwaysAuthorization];
        }
    }
    else
    {
        NSLog(@"定位 %f    %f",manager.location.coordinate.longitude,manager.location.coordinate.latitude);
        self.latitude = manager.location.coordinate.latitude;
        self.longitude = manager.location.coordinate.longitude;
        [self getAddress];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    
    //NSLog(@"定位===%f===%f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude);
    CLLocationCoordinate2D coord;
    if (![WGS84TOGCJ02 isLocationOutOfChina:currentLocation.coordinate]){
        coord = [WGS84TOGCJ02 transformFromWGSToGCJ:[currentLocation coordinate]];
        
    }else{
        coord = currentLocation.coordinate;
    }
    
    if (positioningNumber>=YXPositioningNumber) {
        [manager stopUpdatingLocation];
    }
    
    //self.lab.text=[NSString stringWithFormat:@"latitude:%f,longitude:%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude];
    self.latitude = coord.latitude;
    self.longitude = coord.longitude;
    
    if(self.timer)
        [self.timer invalidate];
    
    
    [self getAddress];
    positioningNumber++;
}

- (void)getAddress
{
    if(self.longitude>0.0001 && self.latitude>0.0001)
    {

        CLLocation *location = [[CLLocation alloc]initWithLatitude:self.latitude longitude:self.longitude];
//        CLLocation *location = [[CLLocation alloc]initWithLatitude:36.40 longitude:117.00];

        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
        [geocoder  reverseGeocodeLocation:location completionHandler:
     
         ^(NSArray *placemarks, NSError *error)
     
         {
             NSString *str = @"";
         
             for (CLPlacemark *placemark in placemarks)
             
             {
                 NSDictionary *addressDic=placemark.addressDictionary;
                 /*NSString *name=[addressDic objectForKey:@"Name"];
                 NSString *state=[addressDic objectForKey:@"State"];
                 NSString *city=[addressDic objectForKey:@"City"];
                 NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
                 NSString *street=[addressDic objectForKey:@"Street"];
                 */
                 self.province = [addressDic objectForKey:@"State"];
                 self.city = [addressDic objectForKey:@"City"];
                 self.county = [addressDic objectForKey:@"SubLocality"];
                 self.street = [addressDic objectForKey:@"Street"];
                 //NSArray * a = placemark.areasOfInterest;
                 NSArray *FormattedAddressLines=[addressDic objectForKey:@"FormattedAddressLines"];
                 //NSString *Thoroughfare=[addressDic objectForKey:@"Thoroughfare"];
                 
                 if([FormattedAddressLines count]>0)
                     str = FormattedAddressLines[0];
                 else
                 {
                     str = [NSString stringWithFormat:@"%@%@",placemark.subLocality,placemark.thoroughfare];
                     if (placemark.subThoroughfare!= nil)
                     {
                 
                         str = [str stringByAppendingString:placemark.subThoroughfare];
                 
                     }
                 }
                 //NSLog(@"address==:%@,%@",self.address,addressDic);
             }
             if([str length]>0)
                 self.address = str;
             else
                 self.address = @"";
             //NSLog(@"address:%@",self.address);
         }];
    }
}

- (void)stop
{
    if(self.timer)
        [self.timer invalidate];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"locationManager failure！");
    [manager stopUpdatingLocation];
    self.longitude = 0.0f;
    self.latitude = 0.0f;
    self.address = @"";
    if(self.timer)
        [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(requestLocation) userInfo:nil repeats:NO];
}

@end
