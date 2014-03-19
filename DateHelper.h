//
//  DateHelper.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-3-7.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateHelper : NSObject

+ (NSString *)getDateNow;


+(NSString *)changDateWithString:(NSString *)aString;
+(NSString*)NSDateToNSString:(NSDate*)date withFormatter:(NSDateFormatter*)formatter;


@end
