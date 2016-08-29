//
//  ApiMacro.h
//  LoanInternal
//
//  Created by McIntosh on 15/8/24.
//  Copyright (c) 2015年 捷越联合. All rights reserved.
//

#ifndef LoanInternal_ApiMacro_h
#define LoanInternal_ApiMacro_h

// 接口地址
/*
 loanAppServer
 loan
 */

//生产环境
#define APP_SERVER_API             @"http://mmmm/aaaa/"



#define DEBUG_MODE NO

// 登录
#define API_POST_LOGIN              APP_SERVER_API@"api/befloan/APPBizRest/appLogin/v1/"
// 进件管理、获取账户所管理的进件接口
#define API_POST_INTOLIST           APP_SERVER_API@"api/befloan/APPBizRest/queryCustIntoList/v1/"
// 获取产品类型接口，调用一次，存成文件
#define API_POST_ITEMINFO           APP_SERVER_API@"api/befloan/APPBizRest/getProductRelationInfo/v1/"



#endif
