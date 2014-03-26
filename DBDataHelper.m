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
    
    //获取本地文件路径
//    NSString *pathStr = [SQLDataSearch getPlistPath:@"TitleInfo.plist"];
    
    //获取沙盒中文件路径
    NSString *pathStr = [SQLDataSearch getPlistPath:@"TitleInfo" andType:@"plist"];
    
    
    NSDictionary *dicTemp = [NSDictionary dictionaryWithContentsOfFile:pathStr];
    NSDictionary *dicTemp1 = [dicTemp objectForKey:@"SQL中数据简写与实际名称对应"];
    NSDictionary *dicTemp2 = [dicTemp1 objectForKey:name];
    NSArray *headTitleValueArr = [dicTemp objectForKey:name];//获取表头文件的显示文件数组
    //获取表头文件的编码数组
    NSArray *headTitleKeyArr = [dicTemp2 sortDictionaryWithValueArr:headTitleValueArr];
    //获取左边表格的关键字
    NSString *leftTitleKey = [headTitleKeyArr objectAtIndex:0];
    
    NSString *lineKey;//每一行的关键字
    
    
    
    if ([name isEqualToString:@"会员分析"]) {
        lineKey = [headTitleKeyArr objectAtIndex:1];
    }
    else lineKey = [headTitleKeyArr objectAtIndex:0];
    
    NSMutableDictionary *leftTableDic = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *rightTableDic = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *dicTemp3 in arr) {
        NSString *leftTableStr = [NSString stringWithString:[dicTemp3 objectForKey:leftTitleKey]];
        NSDictionary *dicTemp4 = [NSDictionary dictionaryWithObjectsAndKeys:leftTableStr,leftTitleKey, nil];
        [leftTableDic setObject:dicTemp4 forKey:[dicTemp3 objectForKey:lineKey]];
        
        NSMutableDictionary *dicTemp5 = [NSMutableDictionary dictionaryWithDictionary:dicTemp3];
        NSString *key = [dicTemp5 objectForKey:lineKey];
        [dicTemp5 removeObjectForKey:leftTitleKey];
        [rightTableDic setObject:dicTemp5 forKey:key];
    }
    
    NSDictionary *titleLeftRight = [NSDictionary dictionaryWithObjectsAndKeys:headTitleKeyArr,@"headTitleKey", headTitleValueArr, @"headTitleValue", leftTableDic,@"leftTable", rightTableDic,@"rightTable", nil];
    
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
    //获取document文件夹中文件路径
//    NSString *path = [SQLDataSearch getPlistPath:@"店名中文映射.plist"];
    
    //获取沙盒中文件路径
    NSString *path = [SQLDataSearch getPlistPath:@"店名中文映射" andType:@"plist"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSDictionary *dic2 = [NSDictionary dictionaryWithDictionary:[dic objectForKey:thirKey]];
    NSDictionary *dic3 = [NSDictionary dictionaryWithDictionary:[dic2 objectForKey:secKey]];
    NSDictionary *dic4 = [NSDictionary dictionaryWithDictionary:[dic3 objectForKey:key]];
    
    NSString *chinese = [dic4 objectForKey:@"MFCNAME"];
    
    return chinese;
}

//+ (NSArray *)BubbleSort:(NSDictionary *)dataDic andSortKey:(NSString *)sortKey
//{
//    NSMutableArray *sortArray = [NSMutableArray array];
//    
//    NSMutableDictionary *leftDataDic = [NSMutableDictionary dictionaryWithDictionary:[dataDic objectForKey:@"leftTable"]];
//    NSMutableDictionary *rightDataDic = [NSMutableDictionary dictionaryWithDictionary:[dataDic objectForKey:@"rightTable"]];
//    
//    NSMutableArray *list = [NSMutableArray arrayWithArray:[leftDataDic allKeys]];
//    
//    for (int j = 1; j<= [list count]; j++) {
//        
//        for(int i = 0 ;i < j ; i++){
//            
//            if(i == [list count]-1) return list;
//            
//            NSInteger a1 = [[list objectAtIndex:i] intValue];
//            NSInteger a2 = [[list objectAtIndex:i+1] intValue];
//            
//            if(a1 > a2){
//                [list exchangeObjectAtIndex:i withObjectAtIndex:i+1];
//            }
//            
//        }
//        
//    }
//    
//    return  sortArray;
//}


+ (NSArray *)QuickSort:(NSDictionary *)dic andKeyArr:(NSMutableArray *)list andSortKey:(NSString *)key StartIndex:(NSInteger)startIndex EndIndex:(NSInteger)endIndex
{
    NSMutableDictionary *leftDataDic = [NSMutableDictionary dictionaryWithDictionary:[dic objectForKey:@"leftTable"]];
    NSMutableDictionary *rightDataDic = [NSMutableDictionary dictionaryWithDictionary:[dic objectForKey:@"rightTable"]];
    
    NSArray *headTitleKey = [NSArray arrayWithArray:[dic objectForKey:@"headTitleKey"]];
    NSString *firstHeadKey = [headTitleKey objectAtIndex:0];
    
    NSDictionary *sortDic;
    if ([firstHeadKey isEqualToString:key]) {
        sortDic = [NSDictionary dictionaryWithDictionary:leftDataDic];
    }
    else
    {
        sortDic = [NSDictionary dictionaryWithDictionary:rightDataDic];
    }
    
    if(startIndex >= endIndex) return list;
    
    //获取在当前startIndex下，获取对应的同一行中，我们想要排序所依赖的关键值
    NSString *tempKey = [list objectAtIndex:startIndex];//获取当前同一行的关键值
    //获取当前同一行中，关键值对应所在的表所映射的数据字典
    NSDictionary *tempDic = [NSDictionary dictionaryWithDictionary:[sortDic objectForKey:tempKey]];
    //获取所需要排序的关键字对应的值
    NSString *tempStr = [tempDic objectForKey:key];
    float tempFloat = [tempStr floatValue];
    
    NSInteger tempIndex = startIndex; //临时索引 处理交换位置(即下一个交换的对象的位置)
    
    
    
    for(NSInteger i = startIndex + 1 ; i <= endIndex ; i++){
        
        NSString *tempKey2 = [list objectAtIndex:i];
        NSDictionary *tempDic2 = [NSDictionary dictionaryWithDictionary:[sortDic objectForKey:tempKey2]];
        NSString *tempStr2 = [tempDic2 objectForKey:key];
        float tempFloat2 = [tempStr2 floatValue];
        
        //按照从大到小排序
        if(tempFloat < tempFloat2){
            
            tempIndex = tempIndex + 1;
            
            [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:i];
            
        }
        
    }
    
    [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:startIndex];
    [DBDataHelper QuickSort:dic andKeyArr:list andSortKey:key StartIndex:startIndex EndIndex:tempIndex-1];
    [DBDataHelper QuickSort:dic andKeyArr:list andSortKey:key StartIndex:tempIndex+1 EndIndex:endIndex];
    
    
    return list;
}

@end
