//
//  NSDictionary+SortByValueArr.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-26.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "NSDictionary+SortByValueArr.h"

@implementation NSDictionary (SortByValueArr)

- (NSMutableArray *)sortDictionaryWithValueArr:(NSArray *)valueArray
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self];
    
    NSArray *arr = [dic allKeys];
    NSMutableArray *keyArr = [[NSMutableArray alloc] init];
    
#warning 此处可以进行算法优化
    for (NSString *value in valueArray) {
        for (NSString *key in arr) {
            if ([value isEqualToString:[dic objectForKey:key]]) {
                [keyArr addObject:key];
                break;
            }
        }
    }
    
    return keyArr;
}

@end
