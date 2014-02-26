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


#import "ServiceHelper.h"
#import "BasicViewController.h"
//#import "WebServiceHelper.h"

@interface LoginViewController : BasicViewController<UITextFieldDelegate, ServiceHelperDelegate>

@property (nonatomic, strong) ServiceHelper *helper;
@property (nonatomic, strong) UITextField *nameText;
@property (nonatomic, strong) UITextField *passwardText;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *passWard;
@property (nonatomic, assign) BOOL isRememberPassward;
@property (nonatomic, assign) CGSize size;


@end
