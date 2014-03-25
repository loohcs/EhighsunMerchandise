//
//  MemberAnalyseViewController.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "MemberAnalyseViewController.h"

@interface MemberAnalyseViewController ()

@end

@implementation MemberAnalyseViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //判断是否时间进行了修改，如果修改了，则我们需要重新下载数据，并同时将isTimeChanged复原成NO
    NSString *isTimeChanged = [defaults objectForKey:@"isTimeChanged"];
    
    if ([isTimeChanged isEqualToString:@"YES"]) {
        [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
        NSArray *params = [NSArray arrayWithArray:[SQLDataSearch getUsrInfo]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_VipMember" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetVipMemberData" andParams:params andPageTitle:@"会员分析"]];
        [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
        
        self.dataDic = dic;
        self.pageTitle = @"会员分析";
        
        [defaults setObject:@"NO" forKey:@"isTimeChanged"];
    }
    
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
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_VipMember" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetVipMemberData" andParams:params andPageTitle:@"会员分析"]];
        [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
        
        self.dataDic = dic;
        self.pageTitle = @"会员分析";
    }
    
    self.navigationItem.title = self.pageTitle;
    self.view.backgroundColor = [UIColor cyanColor];

    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackSideTV)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"日期" style:UIBarButtonItemStyleDone target:self action:@selector(logOutSystem)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;

    
    NSArray *headArr = [NSArray arrayWithArray:[self.dataDic objectForKey:@"headTitleKey"]];
    NSMutableDictionary *leftDic = [NSMutableDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"leftTable"]];
//    NSMutableArray *leftKeys = [NSMutableArray arrayWithArray:[leftDic allKeys]];
    NSDictionary *rightDic = [NSDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"rightTable"]];
    
    _customTableView = [[CustomTableView alloc] initWithHeadDataKeys:headArr andHeadDataTitle:@"会员分析" andLeftData:leftDic andRightData:rightDic andSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-84) andScrollMethod:kScrollMethodWithRight];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    
    return YES;
    
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    [_customTableView fitWithScreenRotation:toInterfaceOrientation];
}

//下拉刷新跟加载的方法
#pragma mark -
#pragma mark UIScrollView PullDelegate
- (void)scrollView:(UIScrollView*)scrollView loadWithState:(LoadState)state
{
    if (state == PullDownLoadState)
    {
        [self performSelector:@selector(PullDownLoadEnd) withObject:nil afterDelay:3];
    }
    else
    {
        [self performSelector:@selector(PullUpLoadEnd) withObject:nil afterDelay:3];
    }
}

//下拉
- (void)PullDownLoadEnd
{
    [self.activityView startAnimating];
    
    rightFlag = 0;
    middleFlag = 0;

}

//加载
- (void)PullUpLoadEnd
{
    [self.activityView startAnimating];
    

}


@end
