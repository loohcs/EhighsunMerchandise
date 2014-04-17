//
//  QuickSortTest.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-4-14.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "QuickSortTest.h"

@implementation QuickSortTest

+(void)QuickSort:(NSMutableArray *)list StartIndex:(NSInteger)startIndex EndIndex:(NSInteger)endIndex
{
    
    if(startIndex >= endIndex)return;
    
    NSNumber * temp = [list objectAtIndex:startIndex];
    NSInteger tempIndex = startIndex; //临时索引 处理交换位置(即下一个交换的对象的位置)
    
    for(NSInteger i = startIndex + 1 ; i <= endIndex ; i++){
        
        NSNumber *t = [list objectAtIndex:i];
        
        if([temp intValue] > [t intValue]){
            
            tempIndex = tempIndex + 1;
            
            [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:i];
            
        }
        
    }
    
    [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:startIndex];
    [self QuickSort:list StartIndex:startIndex EndIndex:tempIndex-1];
    [self QuickSort:list StartIndex:tempIndex+1 EndIndex:endIndex];
    
}


@end
