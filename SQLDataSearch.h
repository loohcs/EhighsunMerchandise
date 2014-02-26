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

+ (NSArray *)getTitle:(NSString *)titleKey;

//同步请求
+ (NSDictionary *)SyncGetDataWith:(NSString *)ws_name andServiceNameSpace:(NSString *)ws_namespace andMethod:(NSString *)method andParams:(NSArray *)params;

@end
