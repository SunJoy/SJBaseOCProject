//
//  AddressChoicePickerView.h
//  Wujiang
//
//  Created by zhengzeqin on 15/5/27.
//  Copyright (c) 2015年 com.injoinow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaObject.h"

//TextField默认类型文本的Tag
typedef NS_ENUM(NSInteger, JYChoiceType) {
    JYChoiceType_Product = 0,
    JYChoiceType_String,
    JYChoiceType_Others
};

@class AddressChoicePickerView;
typedef void (^AddressChoicePickerViewBlock)(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate);
@interface AddressChoicePickerView : UIView

@property (copy, nonatomic)AddressChoicePickerViewBlock block;

- (void)setCoustomArr:(NSArray*)customArr choiceType:(JYChoiceType)choiceType;

- (void)setAreaFilePath:(NSString*)areaFilePath;
- (void)show;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com