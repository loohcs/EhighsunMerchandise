//
//  NSArray+SortArrayByOtherArray.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-26.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SortArrayByOtherArray)

//通过一个特定的value数组，然后根据数组值相对应的字典中的键值，将键值进行排列，得到新的数组

- (NSArray *)sortArrayWithArray:(NSArray *)arr;

@end
