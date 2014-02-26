//
//  DBDataHelper.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-25.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "DBDataHelper.h"

@implementation DBDataHelper

+ (NSDictionary *)getData:(NSArray *)arr
{
    NSDictionary *oneLineDic = [arr objectAtIndex:0];
    NSMutableArray *headTitleArr = [NSMutableArray arrayWithArray:[oneLineDic allKeys]];
    [headTitleArr removeObject:@"CLASS1"];
    
    NSString *leftTableKey = @"CLASS2";

    NSMutableArray *rightTitleArr = [NSMutableArray arrayWithArray:headTitleArr];
    [rightTitleArr removeObject:@"CLASS1"];
    [rightTitleArr removeObject:@"CLASS2"];
    
    NSMutableArray *leftTableArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *rightTableDic = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *dicTemp in arr) {
        NSString *leftTableStr = [dicTemp objectForKey:leftTableKey];
        [leftTableArr addObject:leftTableStr];
        
        NSMutableDictionary *dicTemp2 = [NSMutableDictionary dictionaryWithDictionary:dicTemp];
        [dicTemp2 removeObjectForKey:@"CLASS1"];
        NSString *key = [dicTemp2 objectForKey:@"CLASS2"];
        [dicTemp2 removeObjectForKey:@"CLASS2"];
        [rightTableDic setObject:dicTemp2 forKey:key];
    }
    
    NSDictionary *titleLeftRight = [NSDictionary dictionaryWithObjectsAndKeys:headTitleArr,@"headTitle", leftTableArr,@"leftTable", rightTableDic,@"rightTable", nil];
    
    NSLog(@"%@", titleLeftRight);
    
    return titleLeftRight;
}

@end
