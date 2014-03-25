//
//  SQLDataSearch.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-26.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ServiceHelper.h"

@interface SQLDataSearch : NSObject

@property (nonatomic, strong) ServiceHelper *helper;

+ (NSMutableArray *)getUsrInfo;//获取用户信息

//获取起始时间和截止时间
+ (void)getDateStr:(NSString *)startTime andEndTime:(NSString *)endTime;


//获取存储关键字的文件地址,沙盒中docment文件夹
+ (NSString *)getPlistPath:(NSString *)fileName;

//获取存储关键字的文件地址，直接在工程中
+ (NSString *)getPlistPath:(NSString *)fileName andType:(NSString *)type;

+ (NSArray *)getTitle:(NSString *)titleKey;

//同步请求
+ (NSDictionary *)SyncGetDataWith:(NSString *)ws_name andServiceNameSpace:(NSString *)ws_namespace andMethod:(NSString *)method andParams:(NSArray *)params andPageTitle:(NSString *)pageTitle;

@end
