//
//  WeiboDataBase.m
//  Weibo_Test-0001
//
//  Created by 1007 on 13-11-29.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "WeiboDataBase.h"

#import "FMDatabase.h"

@implementation WeiboDataBase

#pragma mark -- 通过数据库来存取数据
+ (NSString *)getPathDB
{
    NSLog(@"%s", __func__);
    
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[pathArr lastObject] stringByAppendingPathComponent:@"WeiBoDB.sqlite"];
    
    return path;
}

//???: 创建表
+ (BOOL)createDBTable
{
    NSLog(@"%s", __func__);
    
#pragma mark -- 使用FMDB第三方类库来实现数据的打开
    FMDatabase *db = [FMDatabase databaseWithPath:[WeiboDataBase getPathDB]];
    if (![db open]) {
        NSLog(@"打开数据库失败！");
        return NO;
    }
    
#pragma mark -- 使用FMDB第三方类库来实现数据的创建
    BOOL isSuccess = [db executeUpdate:@"create table if not exists WeiboDataBases(id integer primary key autoincrement, mid integer, idstr text, userIDstr text, userName text, created_at text, text text, source text, favorited bool, truncated bool, thumbnail_pic blob, bmiddle_pic blob, original_pic blob, retweeted_status_id text, reposts_count integer, comments_count integer, attitudes_count integer)"];
    
    if (isSuccess) {
        NSLog(@"表创建成功！");
    }
    
    [db close];
    
    return isSuccess;
    
}

+ (BOOL)addWithData:(NSDictionary *)data
{
    NSLog(@"%s", __func__);

    FMDatabase *db = [FMDatabase databaseWithPath:[WeiboDataBase getPathDB]];
    
    if (![db open]) {
        NSLog(@"数据库打开失败！");
        return NO;
    }
    
//    BOOL isSucess = [db executeUpdate:@"insert into WeiboDataBases(id, mid, idstr, userIDstr,userName, created_at, text, source, favorited, truncated, retweeted_status_id, reposts_count, comments_count, attitudes_count) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",[NSNumber numberWithInteger:weibo.ID], [NSNumber numberWithInteger:weibo.MID], weibo.idstr, weibo.userInfo.userIDstr,weibo.userInfo.name, weibo.created_at, weibo.text, weibo.source, [NSNumber numberWithBool:weibo.favorited], [NSNumber numberWithBool:weibo.truncated], [NSNumber numberWithInt:weibo.retweetedWeibo.ID], [NSNumber numberWithInteger:weibo.reposts_count], [NSNumber numberWithInteger:weibo.comments_count], [NSNumber numberWithInteger:weibo.attitudes_count]];
    
    BOOL isSuccess = YES;
    
    [db close];
    return isSuccess;
}

+ (BOOL)updateWithData:(NSDictionary *)data andDBID:(NSInteger)ID
{
    NSLog(@"%s", __func__);
    
    FMDatabase *db = [FMDatabase databaseWithPath:[WeiboDataBase getPathDB]];
    
    if (![db open]) {
        NSLog(@"数据库打开失败！");
        return NO;
    }
    
//    BOOL isSucess = [db executeUpdate:@"update WeiboDataBases set id = ?, mid = ?, idstr = ?,userIDstr = ?,userName = ?, created_at = ?, text = ?, source = ?, favorited = ?, truncated = ?, retweeted_status_id = ?, reposts_count = ?, comments_count = ?, attitudes_count = ? where id = ?", [NSNumber numberWithInteger:weibo.ID], [NSNumber numberWithInteger:weibo.MID], weibo.idstr, weibo.userInfo.userIDstr, weibo.userInfo.name, weibo.created_at, weibo.text, weibo.source, [NSNumber numberWithBool:weibo.favorited], [NSNumber numberWithBool:weibo.truncated], weibo.retweeted_status, [NSNumber numberWithInteger:weibo.reposts_count], [NSNumber numberWithInteger:weibo.comments_count], [NSNumber numberWithInteger:weibo.attitudes_count], [NSNumber numberWithInteger:ID]];
    
    BOOL isSuccess = YES;
    
    [db close];
    
    return isSuccess;
}

+ (void)findOneData:(NSString *)dataID
{

    FMDatabase *db = [FMDatabase databaseWithPath:[WeiboDataBase getPathDB]];
    
    if (![db open]) {
        NSLog(@"数据库打开失败！");
        
    }
    
    FMResultSet *rs = [db executeQuery:@"select * from WeiboDataBases where id = ?", dataID];
    
    while ([rs next]) {

    }
    
}

+ (NSMutableArray *)findAll
{
    NSLog(@"%s", __func__);
    
    __autoreleasing NSMutableArray *array = [NSMutableArray new];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[WeiboDataBase getPathDB]];
    
    if (![db open]) {
        NSLog(@"数据库打开失败！");
        return NO;
    }
    
    FMResultSet *rs = [db executeQuery:@"select * from WeiboDataBases"];
    
    while ([rs next]) {
        
    }
    
    [db close];
    
    return array;
    
}

+ (BOOL)deleteDataByID:(int)aID
{
    NSLog(@"%s", __func__);
    
    FMDatabase *db = [FMDatabase databaseWithPath:[WeiboDataBase getPathDB]];
    
    if (![db open]) {
        NSLog(@"数据库打开失败！");
    }
    
    BOOL isSuccess = [db executeUpdate:@"delete from WeiboDataBases where id = ?", [NSNumber numberWithInt:aID]];
    
    if (isSuccess) {
        NSLog(@"删除成功！");
    }
    
    [db close];
    
    return YES;
    
}


@end
