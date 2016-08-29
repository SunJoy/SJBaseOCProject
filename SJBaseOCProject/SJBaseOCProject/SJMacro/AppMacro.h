//
//  AppMacro.h
//  LoanInternal
//
//  Created by McIntosh on 15/8/24.
//  Copyright (c) 2015年 捷越联合. All rights reserved.
//

#ifndef LoanInternal_AppMacro_h
#define LoanInternal_AppMacro_h


// 登录时需要传递的一些常量
#define PTID            @"捷越贷款APP"
#define CID             @"000000"
#define LOGINKEY        @"JYLHAPP001"
#define AESKey          @"abcdnnnnnn123456"
#define APP_FOLDERKEY   @"JYLHAPPfky"

//folder path
#define APP_DOCUMENT_DATA_IMAGE         @"images"
#define APP_DOCUMENT_DATA_INTO          @"into_att"
#define APP_DOCUMENT_DATA_THUMNAIL      @"thumbnails"
#define APP_DOCUMENT_DATA_LOG           @"logs"
#define APP_DOCUMENT_DATA_VOICE         @"voices"
#define APP_DOCUMENT_DATA_LOCALVOICE    @"local_voices"
#define APP_DOCUMENT_DATA_DB            @"db.sqlite"
#define APP_DOCUMENT_DATA_DICTIONARY    @"dictionary_data"
//---

#define APP_UPDATE_VERSION  @"isNewVersionJY"
#define NAV_ICON_HEIGHT 27

#define UPDATEAPP_ALERT_TAG  99
#define PUSHTOHOME_ALERT_TAG 777

#define PickerTag_Card          17777
#define PickerTag_Product       17778
#define PickerTag_Gender        17779
#define PickerTag_LoansUsed     17780
#define PickerTag_LoanPeriods   17781  //选择期限
#define PickerTag_RepaymentWay  17782  //还款方式
#define PickerTag_Urgent        17783  //是否加急
#define PickerTag_Lendstructure 17784  //放款机构



#define REFRESH_HEADER_MYTASK      @"refreshheader_mytask"        //记录我的任务头部刷新时间
#define REFRESH_HEADER_INTOM       @"refreshheader_intom"         //记录进件管理头部刷新时间
#define REFRESH_HEADER_RESERVATION @"refreshheader_reservation"   //记录预约客户头部刷新时间


// 缓存版本号
#define APP_DataVersion     @"appDataVersion"
//数据字典获取 证件类型的编码
#define APP_IDTYPE          @"IDTYPE"
//数据字典获取 贷款产品的编码
#define APP_LOAN_PRODUCT    @"C_CL_LOAN_PRODUCT"
//数据字典获取 借款用途
#define APP_LOANPURPOSE     @"LOANPURPOSE"
//数据字典获取 性别
#define APP_SEX             @"SEX"
//数据字典获取 还款方式
#define APP_REPAYMENTWAY    @"CM_REPAYMENTWAY"
//数据字典获取 还款日
#define APP_LOAN_DATE       @"DQ_LOAN_DATE_CALCULATION"
//本地数据字典获取产品类型
#define APP_LOCAL_PTYPE     @"LOCAL_attTypeList"
//放款机构字典
#define APP_LOANFUNDS       @"LOANFUNDS"
//压缩图片大小
#define APP_PNG_SIZE        @"APP_PNG_SIZE"


#define MAX_COUNT         18 // 选择图片最大数默认是9
#define MAX_SELECT_COUNT  18 //多选最大选择数

#define APP_RefreshTime   5  //刷新间隔时间

#define JYAPP_RequestTimeOut 10  //请求超时时间


#define APP_SELECT_TOUCHID @"APP_BOOL_TOUCHID" //存储TouchID开关选项

// 去除调用代理方法的警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do {\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//weakself
#define WEAKSELF_SC __weak __typeof(&*self)weakSelf_SC = self;



#endif
