//
//  AppDelegate.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Reachability  *hostReach;
}


@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) BOOL isReachable;
@property (strong, nonatomic) PPRevealSideViewController *revealSideVC;

@end
