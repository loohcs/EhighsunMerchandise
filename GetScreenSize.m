//
//  GetScreenSize.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-28.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "GetScreenSize.h"

@implementation GetScreenSize

+ (CGSize)getScreenSize:(UIInterfaceOrientation)orientation
{
    CGSize size = CGSizeZero;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if (UIDeviceOrientationIsPortrait(orientation)) {
        NSLog(@"现在是竖屏方向");
        size = CGSizeMake(width, height);
    }
    
    else if (UIDeviceOrientationIsLandscape(orientation)) {
        NSLog(@"现在是横屏方向");
        size = CGSizeMake(height, width);
    }
    
    return size;
}

@end
