//
//  HighsunHomeViewController.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "HighsunHomeViewController.h"

@interface HighsunHomeViewController ()

@end

@implementation HighsunHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    
    //TODO: 根据当前的网络状态执行不同的代码
    //在本项目中主要的内容就是数据的获取与加载，因此本部分的功能也可以放在appDelegate里面，并实现数据的传输或者从服务器请求新的数据
    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDlg.isReachable)
    {
        NSLog(@"网络已连接");//执行网络正常时的代码
    }
    else
    {
        NSLog(@"网络连接异常");//执行网络异常时的代码
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接异常" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = @"海印百货通";
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackSideTV)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:@selector(logOutSystem)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    NSMutableArray *headKeys = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *leftKeys = [NSMutableArray arrayWithCapacity:0];

    headKeys = [NSMutableArray arrayWithArray:[SQLDataSearch getTitle:@"主页"]];
    
    for (int i = 0; i < 50; i++) {
        NSString *key = [NSString stringWithFormat:@"test_%d", i];

        //添加左边tableView的数据的key
        [leftKeys addObject:key];
    }

    NSMutableArray *dArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 50; i ++) {
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithCapacity:0];
//        for (NSString *key in headKeys) {
//            [data setValue:[NSString stringWithFormat:@"%@ %d", key, i] forKey:key];
//        }
        for (int j = 0; j < headKeys.count; j++) {
            NSString *key = [headKeys objectAtIndex:j];
            [data setValue:[NSString stringWithFormat:@"%@ %d-%d", key, i, j] forKey:key];
        }

        [dArray addObject:data];
    }
    
    CGSize size = [GetScreenSize getScreenSize:self.interfaceOrientation];
    _customTableView = [[CustomTableView alloc] initWithData:dArray size:CGSizeMake(size.width, size.height-84) scrollMethod:kScrollMethodWithRight leftDataKeys:leftKeys headDataKeys:headKeys];
    CGRect frame = _customTableView.frame;
    frame.origin = CGPointMake(0, 84);
    _customTableView.frame = frame;
    [self.view addSubview:_customTableView];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    
    return NO;
    
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    [_customTableView fitWithScreenRotation:toInterfaceOrientation];
//    [self.view setNeedsDisplay];
}


@end
