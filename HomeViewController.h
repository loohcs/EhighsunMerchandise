//
//  HomeViewController.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"
#import "SideTableViewController.h"
@interface HomeViewController : BasicViewController

@property (nonatomic, strong) UITextField *nameText;
@property (nonatomic, strong) UITextField *passwardText;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *passWard;
@property (nonatomic, assign) BOOL isRememberPassward;
@property (nonatomic, strong) SideTableViewController *mySideTV;//侧边栏显示tabBar
@property (nonatomic, assign) CGSize size;


@property (nonatomic, strong) UIButton *highsunHomeVCBtn;
@property (nonatomic, strong) UIButton *shoppingCardVCBtn;
@property (nonatomic, strong) UIButton *memberAnalyseVCBtn;
@property (nonatomic, strong) UIButton *finalSumVCBtn;
@property (nonatomic, strong) UIButton *saleCustomsListVCBtn;
@property (nonatomic, strong) UIButton *saleCompareVCBtn;

@property (nonatomic, strong) UILabel *highsunHomeLabel;
@property (nonatomic, strong) UILabel *shoppingCardLabel;
@property (nonatomic, strong) UILabel *memberAnalyseLabel;
@property (nonatomic, strong) UILabel *finalSumLabel;
@property (nonatomic, strong) UILabel *saleCustomsListLabel;
@property (nonatomic, strong) UILabel *saleCompareLabel;

@end
