//
//  LoginViewController.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"
#import "SideTableViewController.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameText;
@property (nonatomic, strong) UITextField *passwardText;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *passWard;
@property (nonatomic, assign) BOOL isRememberPassward;

@end
