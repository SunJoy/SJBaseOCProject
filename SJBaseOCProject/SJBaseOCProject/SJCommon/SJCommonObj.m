//
//  SJCommonObj.m
//  SJBaseOCProject
//
//  Created by McIntosh on 8/29/16.
//  Copyright © 2016 McIntosh. All rights reserved.
//

#import "SJCommonObj.h"

@implementation SJCommonObj


+ (SJCommonObj*) sharedInstance
{
    static SJCommonObj *_singleton = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

@end
