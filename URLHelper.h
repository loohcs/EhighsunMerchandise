//
//  URLHelper.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-20.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLHelper : NSObject

+ (NSURL *)getUrlWithString:(NSString *)str andArgument:(NSDictionary *)dic;

@end
