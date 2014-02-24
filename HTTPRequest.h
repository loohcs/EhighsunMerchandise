//
//  HTTPRequest.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-19.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block_fun)(NSMutableData *datas,float progressNum);

@interface HTTPRequest : NSObject
{
    NSMutableData *receiveData;
    Block_fun block_data;
    long long AllLength;
}

//初始化方法
-(HTTPRequest *)initWithURlString:(NSString *)urlStr;
//block方法
-(void)setBlock:(Block_fun) aBlock;

@end
