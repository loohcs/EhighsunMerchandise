//
//  DBDataHelper.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-25.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    numSmallToBig = 0,//按照从小到大排序
    numBigToSmall//按照从大到小排序
}SortType;

@interface DBDataHelper : NSObject

//@property (nonatomic, assign) SortType *sortType;

+ (NSDictionary *)getData:(NSArray *)arr andValueArrName:(NSString *)name;

+ (NSMutableDictionary *)getChineseName:(NSArray *)arr;

+ (NSString *)getChineseWithCode:(NSString *)mfCode;

+ (NSArray *)QuickSort:(NSDictionary *)dic andKeyArr:(NSMutableArray *)list andSortType:(SortType)sortType andSortKey:(NSString *)key StartIndex:(NSInteger)startIndex EndIndex:(NSInteger)endIndex;


+(void)QuickSort:(NSMutableArray *)list andSortType:(SortType)sortType StartIndex:(NSInteger)startIndex EndIndex:(NSInteger)endIndex;

+ (NSMutableDictionary *)getSumNum:(NSDictionary *)dic;

@end
