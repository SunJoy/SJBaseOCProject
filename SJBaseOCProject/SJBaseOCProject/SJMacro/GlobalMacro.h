//
//  GlobalMacro.h
//  LoanInternal
//
//  Created by McIntosh on 15/8/28.
//  Copyright (c) 2015年 捷越联合. All rights reserved.
//

#ifndef LoanInternal_GlobalMacro_h
#define LoanInternal_GlobalMacro_h

typedef void(^RetureValueBlock)(id returnValue);
typedef void(^ErrorValueBlock)(id errorValue);
typedef void(^FailureValueBlock)();
typedef void(^NetWorkBlock)(BOOL netConnectState);

typedef NS_ENUM(int, RefreshType) {
    HeaderRefreshType = 0,
    FooterRefreshType
};

//cell的类型
typedef NS_ENUM(int, JYCustomerCellType) {
    CustomerCellType_Title = 0,
    CustomerCellType_TextField,
    CustomerCellType_TextFieldN,
    CustomerCellType_Type,
    CustomerCellType_Others
};
typedef NS_ENUM(int, JYCalculateCellType) {
    JYCalculateCellType_Type = 0,
    JYCalculateCellType_ContentTitle,
    JYCalculateCellType_Calculate,
    JYCalculateCellType_Content,
    JYCalculateCellType_DefaultContent,
    JYCalculateCellType_TextFieldN
};

typedef enum {
    ItemVCType_AddNewItem,  // 来自新增进件
    ItemVCType_AddSaveItem, // 来待传进件
    ItemVCType_MyItem       // 来自我的任务
}ItemVCType;

//TextField默认类型文本的Tag
typedef NS_ENUM(NSInteger, JYTextFieldType) {
    JYTextFieldType_CustName = 0,
    JYTextFieldType_CardNumber,
    JYTextFieldType_PhoneNumber,
    JYTextFieldType_MinLoans,
    JYTextFieldType_MaxLoans,
    JYTextFieldType_MaxMonthRepayment,
    JYTextFieldType_MaxRepaymentTime,
    JYTextFieldType_ApproveMoney,
    JYTextFieldType_Others
};

//基础数据类型
typedef enum : NSUInteger {
    JYBaseDicType_AddInto = 0,   //添加进件中所用的基础类型
    JYBaseDicType_Reservation,   //添加预约中所用的基础类型
    JYBaseDicType_Calculate     //贷前试算中所用的基础类型
} JYBaseDictionaryType;

typedef NS_ENUM(int, JYSearchType) {
    JYSearchType_IntoList = 0,
    JYSearchType_ReservationList
};

#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#define iPhone4         CGRectGetHeight([[UIScreen mainScreen] bounds])==480
#define iPhone5         CGRectGetHeight([[UIScreen mainScreen] bounds])==568
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4S (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0)
#define IS_IPHONE_5 (IS_IPHONE && ([[UIScreen mainScreen] bounds].size.height == 568.0) && ((IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale) || !IS_OS_8_OR_LATER))
#define IS_STANDARD_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0  && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale)
#define IS_ZOOMED_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale > [UIScreen mainScreen].scale)
#define IS_STANDARD_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_ZOOMED_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale < [UIScreen mainScreen].scale)

//颜色
#define JYRGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define JYRGB(r,g,b)      JYRGBA(r,g,b,1)

#define JYColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//app 主配宏
#define JYMainColor      JYRGB(37,113,201)  //主配颜色

// 去除调用代理方法的警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do {\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#endif
