//
//  SaleCompareViewController.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "SaleCompareViewController.h"

@interface SaleCompareViewController ()

@end

@implementation SaleCompareViewController

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
    
    self.navigationItem.title = @"销售对比";
    self.view.backgroundColor = [UIColor cyanColor];

    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackSideTV)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:@selector(logOutSystem)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    NSMutableArray *headKeys = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *leftKeys = [NSMutableArray arrayWithCapacity:0];
    
    headKeys = [NSMutableArray arrayWithArray:[SQLDataSearch getTitle:@"销售对比"]];
    
    for (int i = 0; i < 50; i++) {
        NSString *key = [NSString stringWithFormat:@"test_%d", i];
        
        //添加左边tableView的数据的key
        [leftKeys addObject:key];
    }
    
    
    NSMutableArray *dArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 50; i ++) {
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithCapacity:0];
        for (int j = 0; j < headKeys.count; j++) {
            NSString *key = [headKeys objectAtIndex:j];
            [data setValue:[NSString stringWithFormat:@"%@ %d-%d", key, i, j] forKey:key];
        }
//        for (NSString *key in headKeys) {
//            [data setValue:[NSString stringWithFormat:@"%@ %d", key, i] forKey:key];
//        }
        [dArray addObject:data];
    }
    
    CustomTableView *view = [[CustomTableView alloc] initWithData:dArray size:CGSizeMake(self.view.frame.size.width, SCREEN_HEIGHT-84) scrollMethod:kScrollMethodWithRight leftDataKeys:leftKeys headDataKeys:headKeys];
    CGRect frame = view.frame;
    frame.origin = CGPointMake(0, 84);
    view.frame = frame;
    [self.view addSubview:view];
}

//TODO: 导航栏上左右两边的动作响应
- (void)goBackSideTV
{
    NSLog(@"返回");
    
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

- (void)logOutSystem
{
    NSLog(@"退出");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
