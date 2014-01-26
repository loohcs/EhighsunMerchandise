//
//  SQLDataSearch.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-26.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "SQLDataSearch.h"

@implementation SQLDataSearch

+ (NSString *)getPlistPath
{
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [str stringByAppendingPathComponent:@"TitleInfo.plist"];
    
    return path;
}

+ (NSArray *)getTitle:(NSString *)titleKey
{
    //TODO:根据titleKey我们可以从数据库中得到我们具体需要的各种不同title，比如说在结算的页面，我们传入“结算汇总”，这样我们就可以得到结算汇总页面需要的表头：供应商名次，本期应结，本期销售，上期结余，月末应付，费用累计
    
    NSString *path = [SQLDataSearch getPlistPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *titleArray = [dic objectForKey:titleKey];
        return titleArray;
    }
    else
    {
        return nil;
    }
}

+ (NSMutableDictionary *)getFloor:(NSString *)floorKey
{
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (int i = 0; i < 50; i++) {
        NSString *str = [NSString stringWithFormat:@"%@_%d", floorKey, i];
        [dataDic setValue:str forKey:floorKey];
    }
    return dataDic;
}

+ (NSMutableDictionary *)getShopCheck:(NSString *)checkKey
{
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    return dataDic;
}

@end
