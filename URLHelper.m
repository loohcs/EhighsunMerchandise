//
//  URLHelper.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-20.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "URLHelper.h"

@implementation URLHelper

+ (NSURL *)getUrlWithString:(NSString *)str andArgument:(NSDictionary *)dic
{
    NSString *webService_name = [dic objectForKey:@"WS_Name"];
    NSString *method_name = [dic objectForKey:@"Method_Name"];
    
//    NSString *argumentStr = [webService_name stringByAppendingFormat:@".asmx?op=%@", method_name];
    NSString *argumentStr = [webService_name stringByAppendingFormat:@".asmx?op=%@", method_name];
    
    NSString *urlStr = [str stringByAppendingFormat:@"/%@", argumentStr];
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
//    NSLog(@"%@", url);
    
    return url;
}

@end
