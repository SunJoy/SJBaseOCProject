//
//  AddressChoicePickerView.m
//  Wujiang
//
//  Created by zhengzeqin on 15/5/27.
//  Copyright (c) 2015年 com.injoinow. All rights reserved.
//  make by 郑泽钦 分享

#import "AddressChoicePickerView.h"

@interface AddressChoicePickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHegithCons;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (strong, nonatomic) AreaObject *locate;
@property (strong, nonatomic) NSString *areaFilePath;
//区域 数组
@property (strong, nonatomic) NSArray *regionArr;
//省 数组
@property (strong, nonatomic) NSArray *provinceArr;
//城市 数组
@property (strong, nonatomic) NSArray *cityArr;
//区县 数组
@property (strong, nonatomic) NSArray *areaArr;

//自定义 数组
@property (strong, nonatomic) NSArray *customArr;

@property (assign, nonatomic) JYChoiceType choiceType;

@end
@implementation AddressChoicePickerView

- (instancetype)initAreaArrFilePath:(NSString*)filePath{
    
    if (self = [super init]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"AddressChoicePickerView" owner:nil options:nil]firstObject];
        self.frame = [UIScreen mainScreen].bounds;
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
//        self.regionArr = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Area.plist" ofType:nil]];
        if (!filePath) {
            self.provinceArr = [[NSArray alloc] initWithContentsOfFile:filePath];
        }else{
            self.provinceArr = [[NSArray alloc] initWithContentsOfFile:filePath];
        }

//        self.provinceArr = self.regionArr[0][@"provinces"];
        self.cityArr = self.provinceArr[0][@"LIST"];
        self.areaArr = self.cityArr[0][@"LIST"];
//        self.locate.region = self.regionArr[0][@"region"];
        self.locate.province = self.provinceArr[0][@"AREANAME"];
        self.locate.city = self.cityArr[0][@"AREANAME"];
        if (self.areaArr.count) {
            self.locate.area = self.areaArr[0];
        }else{
            self.locate.area = @"";
        }
        [self customView];
    }
    return self;
}

- (instancetype)init{
    
    if (self = [super init]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"AddressChoicePickerView" owner:nil options:nil]firstObject];
        self.frame = [UIScreen mainScreen].bounds;
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
        self.regionArr = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AreaPlist.plist" ofType:nil]];
        self.provinceArr = self.regionArr[0][@"provinces"];
        self.cityArr = self.provinceArr[0][@"cities"];
        self.areaArr = self.cityArr[0][@"areas"];
        self.locate.region = self.regionArr[0][@"region"];
        self.locate.province = self.provinceArr[0][@"province"];
        self.locate.city = self.cityArr[0][@"city"];
        if (self.areaArr.count) {
            self.locate.area = self.areaArr[0];
        }else{
            self.locate.area = @"";
        }
        [self customView];
    }
    return self;


}

- (void)customView {
    self.contentViewHegithCons.constant = 0;
    [self layoutIfNeeded];
}

- (void)setCoustomArr:(NSArray *)customArr choiceType:(JYChoiceType)choiceType {
    _customArr = customArr;
    _choiceType = choiceType;
    switch (choiceType) {
        case JYChoiceType_Product:
            self.locate.customTitle = self.customArr[0][@"productName"];
            self.locate.customCode = self.customArr[0][@"productCode"];
            break;
        case JYChoiceType_String:
            self.locate.customTitle = self.customArr[0];
            break;
        case JYChoiceType_Others:
            self.locate.customTitle = self.customArr[0][@"DICNAME"];
            self.locate.customCode = self.customArr[0][@"DICVALUE"];
            break;
    }
    self.locate.index = 0;
    [self.pickView reloadAllComponents];
}



- (void)setAreaFilePath:(NSString *)areaFilePath {
    _areaFilePath = areaFilePath;
    [self initBaseDataArr];
}

- (void)initBaseDataArr {
    if (_areaFilePath) {
        self.provinceArr = [[NSArray alloc] initWithContentsOfFile:_areaFilePath];
        self.cityArr = self.provinceArr[0][@"LIST"];
        self.areaArr = self.cityArr[0][@"LIST"];
        self.locate.province = self.provinceArr[0][@"AREANAME"];
        self.locate.city = self.cityArr[0][@"AREANAME"];
        if (self.areaArr.count) {
            self.locate.area = self.areaArr[0][@"AREANAME"];
            self.locate.customCode = self.areaArr[0][@"AREACODE"];
        }else{
            self.locate.area = @"";
        }
    }else{
        self.regionArr = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AreaPlist.plist" ofType:nil]];
        self.provinceArr = self.regionArr[0][@"provinces"];
        self.cityArr = self.provinceArr[0][@"cities"];
        self.areaArr = self.cityArr[0][@"areas"];
        self.locate.region = self.regionArr[0][@"region"];
        self.locate.province = self.provinceArr[0][@"province"];
        self.locate.city = self.cityArr[0][@"city"];
        if (self.areaArr.count) {
            self.locate.area = self.areaArr[0];
        }else{
            self.locate.area = @"";
        }
    }
    [self customView];
    [self.pickView reloadAllComponents];
}

#pragma mark - setter && getter

- (AreaObject *)locate{
    if (!_locate) {
        _locate = [[AreaObject alloc]init];
    }
    return _locate;
}

#pragma mark - action

//选择完成
- (IBAction)finishBtnPress:(UIButton *)sender {
    if (self.block) {
        self.block(self,sender,self.locate);
    }
    [self hide];
}

//隐藏
- (IBAction)dissmissBtnPress:(UIButton *)sender {
    
    [self hide];
}

#pragma  mark - function

- (UIViewController *)appRootViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (void)show{
//    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
//    UIView *topView = [win.subviews firstObject];
//    [topView addSubview:self];
    [[self appRootViewController].view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentViewHegithCons.constant = 250;
        [self layoutIfNeeded];
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.contentViewHegithCons.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (_customArr) {
        return 1;
    }
    if (!_areaFilePath){
        return 0;
    }
    
//    return 4;
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_customArr) {
        return _customArr.count;
    }
    switch (component) {
        case 0:
            return self.provinceArr.count;
            break;
        case 1:
            return self.cityArr.count;
            break;
        case 2:
            if (self.areaArr.count) {
                return self.areaArr.count;
                break;
            }
        case 3:
            
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (_customArr) {
        switch (_choiceType) {
            case JYChoiceType_Product:
                return [[_customArr objectAtIndex:row] objectForKey:@"productName"];
                break;
            case JYChoiceType_String:
                return [_customArr objectAtIndex:row];
                break;
            case JYChoiceType_Others:
                return [[_customArr objectAtIndex:row] objectForKey:@"DICNAME"];
                break;
        }
        return [[_customArr objectAtIndex:row] objectForKey:@"DICNAME"];
    }
    switch (component) {
        case 0:
//            return [[self.regionArr objectAtIndex:row] objectForKey:@"region"];
            return [[self.provinceArr objectAtIndex:row] objectForKey:@"AREANAME"];
            break;
        case 1:
            return [[self.cityArr objectAtIndex:row] objectForKey:@"AREANAME"];
            break;
        case 2:
            if (self.areaArr.count) {
                return [[self.areaArr objectAtIndex:row] objectForKey:@"AREANAME"];
                break;
            }
        case 3:
            
        default:
            return  @"";
            break;
    }
}
#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (_customArr) {
        switch (_choiceType) {
            case JYChoiceType_Product:
                self.locate.customTitle = self.customArr[row][@"productName"];
                self.locate.customCode = self.customArr[row][@"productCode"];
                break;
            case JYChoiceType_String:
                self.locate.customTitle = self.customArr[row];
                break;
            case JYChoiceType_Others:
                self.locate.customTitle = self.customArr[row][@"DICNAME"];
                self.locate.customCode = self.customArr[row][@"DICVALUE"];
                break;
        }
        self.locate.index = row;
        return;
    }
    
    switch (component) {
        case 0:{
            self.cityArr = self.provinceArr[row][@"LIST"];
            [self.pickView reloadComponent:1];
            [self.pickView selectRow:0 inComponent:1 animated:YES];
            
            
            self.areaArr = [[self.cityArr objectAtIndex:0] objectForKey:@"LIST"];
            [self.pickView reloadComponent:2];
            [self.pickView selectRow:0 inComponent:2 animated:YES];
            
//            self.locate.region = self.regionArr[row][@"region"];
            self.locate.province = self.provinceArr[row][@"AREANAME"];
            self.locate.city = self.cityArr[0][@"AREANAME"];
            if (self.areaArr.count) {
                self.locate.area = self.areaArr[0][@"AREANAME"];
                self.locate.customCode = self.areaArr[0][@"AREACODE"];
            }else{
                self.locate.area = @"";
            }

            
            break;
        }
        case 1:
        {
            self.areaArr = [[self.cityArr objectAtIndex:row] objectForKey:@"LIST"];
            [self.pickView reloadComponent:2];
            [self.pickView selectRow:0 inComponent:2 animated:YES];
            
            self.locate.city = self.cityArr[row][@"AREANAME"];
            if (self.areaArr.count) {
                self.locate.area = self.areaArr[0][@"AREANAME"];
                self.locate.customCode = self.areaArr[0][@"AREACODE"];
            }else{
                self.locate.area = @"";
            }

            break;
        }
        case 2:{
            if (self.areaArr.count) {
                self.locate.area = self.areaArr[row][@"AREANAME"];
                self.locate.customCode = self.areaArr[row][@"AREACODE"];
            }else{
                self.locate.area = @"";
            }
            break;
        }
        case 3:{

            break;
        }
        default:
            break;
    }
}


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com