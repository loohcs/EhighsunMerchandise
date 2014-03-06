//
//  DBDataHelper.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-25.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "DBDataHelper.h"

@implementation DBDataHelper

+ (NSDictionary *)getData:(NSArray *)arr andValueArrName:(NSString *)name
{
    //获取表头的key数组，以及对应的值数组
    //其中的key是指在数据库中的显示名称，而值则是相对应的实际名称
    NSString *pathStr = [SQLDataSearch getPlistPath:@"TitleInfo.plist"];
    NSDictionary *dicTemp = [NSDictionary dictionaryWithContentsOfFile:pathStr];
    NSDictionary *dicTemp1 = [dicTemp objectForKey:@"SQL中数据简写与实际名称对应"];
    NSDictionary *dicTemp2 = [dicTemp1 objectForKey:name];
    NSArray *headTitleValueArr = [dicTemp objectForKey:name];
    NSArray *headTitleKeyArr = [dicTemp2 sortDictionaryWithValueArr:headTitleValueArr];
    
    NSString *leftTitleKey = [headTitleKeyArr objectAtIndex:0];
    
    NSMutableArray *leftTableArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *rightTableDic = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *dicTemp3 in arr) {
        NSString *leftTableStr = [dicTemp3 objectForKey:leftTitleKey];
        [leftTableArr addObject:leftTableStr];
        
        NSMutableDictionary *dicTemp4 = [NSMutableDictionary dictionaryWithDictionary:dicTemp3];
        NSString *key = [dicTemp4 objectForKey:leftTitleKey];
        [dicTemp4 removeObjectForKey:leftTitleKey];
        [rightTableDic setObject:dicTemp4 forKey:key];
    }
    
    NSDictionary *titleLeftRight = [NSDictionary dictionaryWithObjectsAndKeys:headTitleKeyArr,@"headTitleKey", headTitleValueArr, @"headTitleValue", leftTableArr,@"leftTable", rightTableDic,@"rightTable", nil];
    
    NSLog(@"%@", titleLeftRight);
    
    return titleLeftRight;
}

+ (NSMutableDictionary *)getChineseName:(NSArray *)arr
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *dicTemp in arr) {
        
        //获取店铺最详细编码
        NSString *key = [dicTemp objectForKey:@"MFCODE"];
        NSMutableDictionary *dicTemp2 = [NSMutableDictionary dictionaryWithDictionary:dicTemp];
        [dicTemp2 removeObjectForKey:@"MFCODE"];
        
        //获取店铺所在楼层编码
        NSString *key2 = [dicTemp objectForKey:@"MFPCODE"];
        [dicTemp2 removeObjectForKey:@"MFPCODE"];
        
        //获取店铺所在商城编码
        NSString *key3 = [dicTemp objectForKey:@"MFFCODE"];
        [dicTemp2 removeObjectForKey:@"MFFCODE"];
        
        
        //获取第一级的字典，关键字是店铺的商城编码
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithDictionary:[dic objectForKey:key3]];
        //获取第一级的字典，关键字是店铺的楼层编码
        NSMutableDictionary *dic3 = [NSMutableDictionary dictionaryWithDictionary:[dic2 objectForKey:key2]];
        
        //将店铺的详细编码以及具体信息加入到该楼层中
        [dic3 setObject:dicTemp2 forKey:key];
        
        //将更新的楼层信息加入到商城中
        [dic2 setObject:dic3 forKey:key2];
        
        //将更新之后的商城信息加入到整个信息表中
        [dic setObject:dic2 forKey:key3];
    }
    
    return dic;
}

+ (NSString *)getChineseWithCode:(NSString *)mfCode
{
    NSString *chinese;
    
    int length = mfCode.length;
    
    switch (length) {
        case 2:
            chinese = [DBDataHelper getChineseWithKey:mfCode andSecondKey:@"0" andThirdKey:mfCode];
            break;
        case 3:
            chinese = [DBDataHelper getChineseWithKey:mfCode andSecondKey:@"0" andThirdKey:mfCode];
            break;
        case 5:
            chinese = [DBDataHelper getChineseWithKey:mfCode andSecondKey:[mfCode substringToIndex:3] andThirdKey:[mfCode substringToIndex:3]];
            break;
        case 8:
            chinese = [DBDataHelper getChineseWithKey:mfCode andSecondKey:[mfCode substringToIndex:5] andThirdKey:[mfCode substringToIndex:3]];
            break;
        default:
            break;
    }
    
    return chinese;
}

+ (NSString *)getChineseWithKey:(NSString *)key andSecondKey:(NSString *)secKey andThirdKey:(NSString *)thirKey
{
    NSString *path = [SQLDataSearch getPlistPath:@"店名中文映射.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSDictionary *dic2 = [NSDictionary dictionaryWithDictionary:[dic objectForKey:thirKey]];
    NSDictionary *dic3 = [NSDictionary dictionaryWithDictionary:[dic2 objectForKey:secKey]];
    NSDictionary *dic4 = [NSDictionary dictionaryWithDictionary:[dic3 objectForKey:key]];
    
    NSString *chinese = [dic4 objectForKey:@"MFCNAME"];
    
    return chinese;
}


@end
