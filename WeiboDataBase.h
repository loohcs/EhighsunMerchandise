//
//  WeiboDataBase.h
//  Weibo_Test-0001
//
//  Created by 1007 on 13-11-29.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@class WeiBoContext;

@interface WeiboDataBase : NSObject

+ (BOOL)createDBTable;
+ (BOOL)addWithData:(NSDictionary *)data;

+ (void)findOneData:(NSString *)dataID;
+ (NSMutableArray *)findAll;

+ (BOOL)deleteDataByID:(int)aID;
+ (BOOL)updateWithData:(NSDictionary *)data andDBID:(NSInteger)ID;


+ (NSString *)getPathDB;


@end
