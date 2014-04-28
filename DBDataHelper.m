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
        
        NSMutableDictionary *dicTemp6 = [[NSMutableDictionary alloc] init];
        
        for (NSString *keyTempForNum in dicTemp5) {
            NSString *numStr = [dicTemp5 objectForKey:keyTempForNum];
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.numberStyle = NSNumberFormatterDecimalStyle;
            NSString *string = [formatter stringFromNumber:[NSNumber numberWithFloat:[numStr floatValue]]];
            [dicTemp6 setObject:string forKey:keyTempForNum];
        }
        
        [rightTableDic setObject:dicTemp6 forKey:key];
    }
    
    NSDictionary *titleLeftRight = [NSDictionary dictionaryWithObjectsAndKeys:headTitleKeyArr,@"headTitleKey", headTitleValueArr, @"headTitleValue", leftTableDic,@"leftTable", rightTableDic,@"rightTable", nil];
    
//    NSLog(@"%@", titleLeftRight);
    //按照楼层排序
//    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:titleLeftRight];
//    NSArray *sortArray = [NSArray arrayWithArray:
//                          [DBDataHelper QuickSort:titleLeftRight
//                                        andKeyArr:[NSMutableArray arrayWithArray:[leftTableDic allKeys]]
//                                       andSortKey:[headTitleKeyArr objectAtIndex:0]
//                                       StartIndex:0
//                                         EndIndex:leftTableDic.count]];
//    [DBDataHelper getSumNum:sortArray andDataDic:dataDic];
//    [dataDic setObject:sortArray forKey:@"sortArrKey"];
    
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
        if (key.length == 8) {
            if ([key2 isEqualToString:[key substringToIndex:5]])
            {
                [dicTemp2 removeObjectForKey:@"MFPCODE"];
            }
            else
            {
                key2 = [key substringToIndex:5];
            }
        }
        else
        {
            [dicTemp2 removeObjectForKey:@"MFPCODE"];
        }
        
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
    
    NSInteger length = mfCode.length;
    
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
    
    if (chinese == nil) {
        NSLog(@"------------%@", mfCode);
    }
    
    return chinese;
}

+ (NSString *)getChineseWithKey:(NSString *)key andSecondKey:(NSString *)secKey andThirdKey:(NSString *)thirKey
{
    //获取document文件夹中文件路径
    NSString *path = [SQLDataSearch getPlistPath:@"店名中文映射.plist"];
    
    //获取沙盒中文件路径
//    NSString *path = [SQLDataSearch getPlistPath:@"店名中文映射" andType:@"plist"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSDictionary *dic2 = [NSDictionary dictionaryWithDictionary:[dic objectForKey:thirKey]];
    NSDictionary *dic3 = [NSDictionary dictionaryWithDictionary:[dic2 objectForKey:secKey]];
    NSDictionary *dic4 = [NSDictionary dictionaryWithDictionary:[dic3 objectForKey:key]];
    
    NSString *chinese = [dic4 objectForKey:@"MFCNAME"];
    
    return chinese;
}

+ (NSArray *)QuickSort:(NSDictionary *)dic andKeyArr:(NSMutableArray *)list andSortType:(SortType)sortType andSortKey:(NSString *)key StartIndex:(NSInteger)startIndex EndIndex:(NSInteger)endIndex
{
    //当开始位置与停止位置一样时，停止排序，并将排好序的关键值数组返回
    if(startIndex >= endIndex)
    {
        //加入数据的合算结果
        //NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:[DBDataHelper getSumNum:list andDataDic:dic]];
        
        //NSArray *arr = [dataDic objectForKey:@"sum"];
        
        //NSLog(@"sum: %@", arr);
        
        return list;
    }
    
//    NSMutableDictionary *leftDataDic = [NSMutableDictionary dictionaryWithDictionary:[dic objectForKey:@"leftTable"]];
    NSMutableDictionary *rightDataDic = [NSMutableDictionary dictionaryWithDictionary:[dic objectForKey:@"rightTable"]];
    
//    NSArray *headTitleKey = [NSArray arrayWithArray:[dic objectForKey:@"headTitleKey"]];
//    NSString *firstHeadKey = [headTitleKey objectAtIndex:0];
    
    NSDictionary *sortDic = [NSDictionary dictionaryWithDictionary:rightDataDic];
    
    //获取在当前startIndex下，获取对应的同一行中，我们想要排序所依赖的关键值
    NSString *tempKey = [list objectAtIndex:startIndex];//获取当前同一行的关键值
    //获取当前同一行中，关键值对应所在的表所映射的数据字典
    NSDictionary *tempDic = [NSDictionary dictionaryWithDictionary:[sortDic objectForKey:tempKey]];
    //获取所需要排序的关键字对应的值
    NSString *tempStr = [tempDic objectForKey:key];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *num = [formatter numberFromString:tempStr];
    float tempFloat = [num floatValue];
           
    NSInteger tempIndex = startIndex; //临时索引 处理交换位置(即下一个交换的对象的位置)
    
    for(NSInteger i = startIndex + 1 ; i <= endIndex ; i++){
        
        NSString *tempKey2 = [list objectAtIndex:i];
        NSDictionary *tempDic2 = [NSDictionary dictionaryWithDictionary:[sortDic objectForKey:tempKey2]];
        NSString *tempStr2 = [tempDic2 objectForKey:key];
        NSNumber *num2 = [formatter numberFromString:tempStr2];
        float tempFloat2 = [num2 floatValue];
        
        //按照从大到小排序
        if (sortType == numBigToSmall) {
            if(tempFloat < tempFloat2){
                
                tempIndex = tempIndex + 1;
                
                [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:i];
                
            }
        }
        else if (sortType == numSmallToBig)
        {
            if(tempFloat > tempFloat2){
                
                tempIndex = tempIndex + 1;
                
                [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:i];
                
            }
        }
        
    }
    
    [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:startIndex];
    [self QuickSort:dic andKeyArr:list andSortType:sortType andSortKey:key StartIndex:startIndex EndIndex:tempIndex-1];
    [self QuickSort:dic andKeyArr:list andSortType:sortType andSortKey:key StartIndex:tempIndex+1 EndIndex:endIndex];
    
    
    return list;
}

+(void)QuickSort:(NSMutableArray *)list andSortType:(SortType)sortType StartIndex:(NSInteger)startIndex EndIndex:(NSInteger)endIndex
{
    
    if(startIndex >= endIndex)return;
    
    NSNumber * temp = [list objectAtIndex:startIndex];
    NSInteger tempIndex = startIndex; //临时索引 处理交换位置(即下一个交换的对象的位置)
    
    for(NSInteger i = startIndex + 1 ; i <= endIndex ; i++){
        
        NSNumber *t = [list objectAtIndex:i];
        
        if (sortType == numSmallToBig) {
            if([temp intValue] > [t intValue]){
                
                tempIndex = tempIndex + 1;
                
                [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:i];
                
            }
        }
        else if(sortType == numBigToSmall)
        {
            if([temp intValue] < [t intValue]){
                
                tempIndex = tempIndex + 1;
                
                [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:i];
                
            }
        }
        
        
    }
    
    [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:startIndex];
    [self QuickSort:list andSortType:sortType StartIndex:startIndex EndIndex:tempIndex-1];
    [self QuickSort:list andSortType:sortType StartIndex:tempIndex+1 EndIndex:endIndex];
    
}



+ (NSMutableDictionary *)getSumNum:(NSDictionary *)dic
{
    NSArray *headTitleKey = [dic objectForKey:@"headTitleKey"];
    //NSArray *headTitleValue = [dic objectForKey:@"headTitleValue"];
    NSMutableDictionary *leftDataDic = [dic objectForKey:@"leftTable"];
    NSMutableDictionary *rightDataDic = [dic objectForKey:@"rightTable"];
    NSArray *arr = [leftDataDic allKeys];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSMutableDictionary *sumNumDic = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < arr.count; i ++) {
        NSString *lineKey = [arr objectAtIndex:i];
        
//        NSDictionary *leftTemp = [leftDataDic objectForKey:lineKey];
        NSDictionary *rightTemp = [rightDataDic objectForKey:lineKey];
        
        for (int j = 1; j < headTitleKey.count; j ++) {
            NSString *keyTemp = [headTitleKey objectAtIndex:j];
            NSString *dataTempStr = [rightTemp objectForKey:keyTemp];
//            if (j == 1) {
//                if ([keyTemp isEqualToString:@"MFID"]) {
//                    [sumNumDic setObject:@"--" forKey:keyTemp];
//                }
//            }
//            
            if (i == 0) {
                [sumNumDic setObject:dataTempStr forKey:keyTemp];
            }
            else
            {
                NSNumber *num1 = [formatter numberFromString:dataTempStr];
                float dataTemp = [num1 floatValue];
                float sumTemp = [[formatter numberFromString:[sumNumDic objectForKey:keyTemp]] floatValue];
                sumTemp = dataTemp + sumTemp;
                
                NSString *sumTempStr = [formatter stringFromNumber:[NSNumber numberWithFloat:sumTemp]];
                [sumNumDic setObject:sumTempStr forKey:keyTemp];
            }
        }
    }
    
    //根据具体的数据具体分析，看是否是需要平均数，或者是一些其他的计算方式
    for (int i = 0; i < sumNumDic.count; i++) {
        NSString *key = [[sumNumDic allKeys] objectAtIndex:i];
        if ([key isEqualToString:@"PX"]||[key isEqualToString:@"THL"]|[key isEqualToString:@"MLL"]) {
            NSString *sumStr = [sumNumDic objectForKey:key];
            float sumNum = [[formatter numberFromString:sumStr] floatValue];
            float avage = sumNum/arr.count;
            [sumNumDic setObject:[formatter stringFromNumber:[NSNumber numberWithFloat:avage]] forKey:key];
        }
        
        if ([key isEqualToString:@"KDJ"]) {
            NSString *XSSL = [sumNumDic objectForKey:@"XSSR"];
            NSString *JYDS = [sumNumDic objectForKey:@"JYDS"];
            
            float XSSL_float = [[formatter numberFromString:XSSL] floatValue];
            float JYDS_float = [[formatter numberFromString:JYDS] floatValue];
            float KDJ_float = XSSL_float/JYDS_float;
            [sumNumDic setObject:[formatter stringFromNumber:[NSNumber numberWithFloat:KDJ_float]] forKey:key];
        }
        
        if ([key isEqualToString:@"BDJ"]) {
            NSString *XSSL = [sumNumDic objectForKey:@"XSSR"];
            NSString *JYBS = [sumNumDic objectForKey:@"JYBS"];
            
            float XSSL_float = [[formatter numberFromString:XSSL] floatValue];
            float JYBS_float = [[formatter numberFromString:JYBS] floatValue];
            float BDJ_float = XSSL_float/JYBS_float;
            [sumNumDic setObject:[formatter stringFromNumber:[NSNumber numberWithFloat:BDJ_float]] forKey:key];
            
//            NSLog(@"---XSSL---%f", XSSL_float);
//            NSLog(@"---JYBS---%f", JYBS_float);
//            NSLog(@"---BDJ---%f", BDJ_float);
//            
//            NSLog(@"---sum---%@", sumNumDic);
        }
    }
    
    //NSLog(@"%@", addSumDic);
    
    return sumNumDic;
}

@end
