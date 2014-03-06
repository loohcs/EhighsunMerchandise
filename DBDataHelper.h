//
//  DBDataHelper.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-25.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBDataHelper : NSObject

+ (NSDictionary *)getData:(NSArray *)arr andValueArrName:(NSString *)name;

+ (NSMutableDictionary *)getChineseName:(NSArray *)arr;

+ (NSString *)getChineseWithCode:(NSString *)mfCode;

@end
