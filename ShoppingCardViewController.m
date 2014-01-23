//
//  ShoppingCardViewController.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "ShoppingCardViewController.h"

@interface ShoppingCardViewController ()

@end

@implementation ShoppingCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = @"购物卡销售";
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIScrollView *floorScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 60, SCREEN_HEIGHT)];
    floorScrollView.contentSize = CGSizeMake(60, SCREEN_HEIGHT*2);
    floorScrollView.pagingEnabled = NO;
    floorScrollView.bounces = YES;
    
    UITableView *floorTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 60, SCREEN_HEIGHT)];
    
    [floorScrollView addSubview:floorTableView];
    
    
    [self.view addSubview:floorScrollView];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
