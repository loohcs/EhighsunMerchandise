//
//  FinalSumViewController.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "FinalSumViewController.h"

@interface FinalSumViewController ()

@end

@implementation FinalSumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithDataDic:(NSDictionary *)dic andTitle:(NSString *)title
{
    if (self = [super init]) {
        self.dataDic = [NSDictionary dictionaryWithDictionary:dic];
        self.pageTitle = [NSString stringWithString:title];
    }
    return self;
}

#pragma mark -- 一些按钮的初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //    NSLog(@"----------------------------------------------------\n%@", self.dataDic);
    
    if (self.dataDic.count ==0) {
        [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
        NSArray *params = [NSArray arrayWithArray:[SQLDataSearch getUsrInfo]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_FinalSum" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetFinalSumData" andParams:params andPageTitle:@"结算汇总"]];
        [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
        
        self.dataDic = dic;
        self.pageTitle = @"结算汇总";
    }
    
    self.navigationItem.title = self.pageTitle;
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackSideTV)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:@selector(logOutSystem)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    
    NSArray *headArr = [NSArray arrayWithArray:[self.dataDic objectForKey:@"headTitleKey"]];
    NSMutableArray *leftKeys = [NSMutableArray arrayWithArray:[self.dataDic objectForKey:@"leftTable"]];
    NSDictionary *rightDic = [NSDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"rightTable"]];
    
    _customTableView = [[CustomTableView alloc] initWithHeadDataKeys:headArr andHeadDataTitle:@"结算汇总" andLeftDataKeys:leftKeys andRightData:rightDic andSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-84) andScrollMethod:kScrollMethodWithRight];
    CGRect frame = _customTableView.frame;
    frame.origin = CGPointMake(0, 84);
    _customTableView.frame = frame;
    [self.view addSubview:_customTableView];
}

//TODO: 导航栏上左右两边的动作响应
- (void)goBackSideTV
{
    NSLog(@"返回");
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)logOutSystem
{
    NSLog(@"退出");
}

- (NSDictionary *)getData:(NSDictionary *)dic
{
    self.dataDic = [NSDictionary dictionaryWithDictionary:dic];
    return self.dataDic;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    
    return YES;
    
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

    [_customTableView fitWithScreenRotation:toInterfaceOrientation];
}

@end
