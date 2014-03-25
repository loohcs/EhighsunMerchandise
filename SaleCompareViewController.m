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
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_SaleCompare" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetSaleCompareData" andParams:params andPageTitle:@"销售对比"]];
        [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
        
        self.dataDic = dic;
        self.pageTitle = @"销售对比";
    }
    
    self.navigationItem.title = self.pageTitle;
    self.view.backgroundColor = [UIColor cyanColor];

    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackSideTV)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"日期" style:UIBarButtonItemStyleDone target:self action:@selector(logOutSystem)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    NSArray *headArr = [NSArray arrayWithArray:[self.dataDic objectForKey:@"headTitleKey"]];
    NSDictionary *leftDic = [NSDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"leftTable"]];
    NSDictionary *rightDic = [NSDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"rightTable"]];
    
    _customTableView = [[CustomTableView alloc] initWithHeadDataKeys:headArr andHeadDataTitle:self.pageTitle andLeftData:leftDic andRightData:rightDic andSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-84) andScrollMethod:kScrollMethodWithRight];

    CGRect frame = _customTableView.frame;
    frame.origin = CGPointMake(0, 84);
    _customTableView.frame = frame;
    [self.view addSubview:_customTableView];
    
    //1,通知，注册监听者
    NSNotificationCenter *notiCenter=[NSNotificationCenter defaultCenter];//拿到通知中心的对象，然后去注册
    //获取document文件夹中的plist
//    NSString *path = [SQLDataSearch getPlistPath:@"TitleInfo.plist"];
    
    //获取沙盒中的plist文件
    NSString *path = [SQLDataSearch getPlistPath:@"TitleInfo" andType:@"plist"];
    
    NSDictionary *pageTitle = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"组织结构"];
    NSDictionary *pageTitle2 = [pageTitle objectForKey:@"海印又一城"];
    NSString *pageTitle3 = [pageTitle2 objectForKey:self.pageTitle];
    [notiCenter addObserver:self
                   selector:@selector(didReceiveNotification:)
                       name:pageTitle3
                     object:nil];//注册监听者完毕
}

//收到通知的时候要触发的方法
-(void)didReceiveNotification:(id)sender
{
    NSNotification *noti=(NSNotification *)sender;
    NSDictionary *notiInfo = [noti userInfo];
    NSLog(@"%@", notiInfo);
    NSLog(@"------------- 收到通知");
    
    NSString *pageTitleNext = [notiInfo objectForKey:@"pageTitle"];
    NSString *str = [NSString stringWithString:[notiInfo objectForKey:@"leftTableKey"]];
    
    
    NSMutableArray *params = [[NSMutableArray alloc] initWithArray:[SQLDataSearch getUsrInfo]];
    NSDictionary *key = [NSDictionary dictionaryWithObjectsAndKeys:str,@"primaryKey", nil];
    [params addObject:key];
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_SaleCompare" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetSaleCompareDataDetail" andParams:params andPageTitle:pageTitleNext]];
    
    SaleCompareDetailViewController *saleCompareDetailVC = [[SaleCompareDetailViewController alloc] initWithDataDic:dic andTitle:@"柜组销售分析"];
    [self.navigationController pushViewController:saleCompareDetailVC animated:YES];
}

#pragma mark -- 按钮的响应动作
//TODO: 导航栏上左右两边的动作响应
- (void)goBackSideTV
{
    NSLog(@"返回");
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)logOutSystem
{
    JBViewController *JBVC = [[JBViewController alloc] init];
    [self.navigationController pushViewController:JBVC animated:YES];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

    [_customTableView fitWithScreenRotation:toInterfaceOrientation];
}




@end
