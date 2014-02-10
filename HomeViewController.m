//
//  HomeViewController.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

static bool isLogin = NO;

- (void)viewWillAppear:(BOOL)animated
{
    if (!isLogin) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:NO completion:nil];
        isLogin = YES;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = @"海印百货通";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackSideTV)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:@selector(logOutSystem)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
 
    self.revealSideViewController.panInteractionsWhenClosed = PPRevealSideInteractionNavigationBar|PPRevealSideInteractionNone;
    
    _mySideTV = [[SideTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self initWithTableView];
    //预加载侧边栏
    [self.revealSideViewController preloadViewController:self.mySideTV forSide:PPRevealSideDirectionTop];
    [self.revealSideViewController preloadViewController:self.mySideTV forSide:PPRevealSideDirectionLeft];
    

    //添加屏幕按钮以及定义响应方法
    _highsunHomeVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _highsunHomeVCBtn.backgroundColor = [UIColor cyanColor];
    [_highsunHomeVCBtn setTitle:@"海印主页" forState:UIControlStateNormal];
    [_highsunHomeVCBtn addTarget:self action:@selector(highsunHomeVCAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_highsunHomeVCBtn];
    
    _shoppingCardVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _shoppingCardVCBtn.backgroundColor = [UIColor cyanColor];
    [_shoppingCardVCBtn setTitle:@"购物卡销售" forState:UIControlStateNormal];
    [_shoppingCardVCBtn addTarget:self action:@selector(shoppingCardVCAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shoppingCardVCBtn];
    
    _memberAnalyseVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _memberAnalyseVCBtn.backgroundColor = [UIColor cyanColor];
    [_memberAnalyseVCBtn setTitle:@"会员分析" forState:UIControlStateNormal];
    [_memberAnalyseVCBtn addTarget:self action:@selector(memberAnalyseVCAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_memberAnalyseVCBtn];
    
    _finalSumVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _finalSumVCBtn.backgroundColor = [UIColor cyanColor];
    [_finalSumVCBtn setTitle:@"结算汇总" forState:UIControlStateNormal];
    [_finalSumVCBtn addTarget:self action:@selector(finalSumVCAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_finalSumVCBtn];
    
    _saleCustomsListVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _saleCustomsListVCBtn.backgroundColor = [UIColor cyanColor];
    [_saleCustomsListVCBtn setTitle:@"销售客单" forState:UIControlStateNormal];
    [_saleCustomsListVCBtn addTarget:self action:@selector(saleCustomsListVCAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saleCustomsListVCBtn];
    
    _saleCompareVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _saleCompareVCBtn.backgroundColor = [UIColor cyanColor];
    [_saleCompareVCBtn setTitle:@"销售对比" forState:UIControlStateNormal];
    [_saleCompareVCBtn addTarget:self action:@selector(saleCompareVCAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saleCompareVCBtn];
    
    
    //获取当前的屏幕大小，即确定屏幕方向
    [self resignBtnFram:self.interfaceOrientation];
}

//TODO: 导航栏上左右两边的动作响应
- (void)goBackSideTV
{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

- (void)logOutSystem
{
    //崩溃测试，点击退出会马上使程序崩溃，但是不会出现闪退现象，会跳出警示框
//    [self performSelector:@selector(aaaa)];
}

- (void)highsunHomeVCAction
{
    HighsunHomeViewController *highsunHomeVC = [[HighsunHomeViewController alloc] init];
    [self.navigationController pushViewController:highsunHomeVC animated:YES];
}

- (void)shoppingCardVCAction
{
    ShoppingCardViewController *shoppingVC = [[ShoppingCardViewController alloc] init];
    [self.navigationController pushViewController:shoppingVC animated:YES];
}

- (void)memberAnalyseVCAction
{
    MemberAnalyseViewController *memberVC = [[MemberAnalyseViewController alloc] init];
    [self.navigationController pushViewController:memberVC animated:YES];
}

- (void)finalSumVCAction
{
    FinalSumViewController *finalVC = [[FinalSumViewController alloc] init];
    [self.navigationController pushViewController:finalVC animated:YES];
}

- (void)saleCustomsListVCAction
{
    SaleCustomsListViewController *saleCustomsVC = [[SaleCustomsListViewController alloc] init];
    [self.navigationController pushViewController:saleCustomsVC animated:YES];
}

- (void)saleCompareVCAction
{
    SaleCompareViewController *saleCompareVC = [[SaleCompareViewController alloc] init];
    [self.navigationController pushViewController:saleCompareVC animated:YES];
}

- (void)initWithTableView
{
    //添加各个viewController 到侧滑栏中的
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNavi =[[UINavigationController alloc] initWithRootViewController:homeVC];
    
    HighsunHomeViewController *highsunVC = [[HighsunHomeViewController alloc] init];
    UINavigationController *highsunNavi = [[UINavigationController alloc] initWithRootViewController:highsunVC];
    
    ShoppingCardViewController *shoppingVC = [[ShoppingCardViewController alloc] init];
    UINavigationController *shoppingNavi = [[UINavigationController alloc] initWithRootViewController:shoppingVC];
    
    MemberAnalyseViewController *memberVC = [[MemberAnalyseViewController alloc] init];
    UINavigationController *memberNavi = [[UINavigationController alloc] initWithRootViewController:memberVC];
    
    FinalSumViewController *finalVC = [[FinalSumViewController alloc] init];
    UINavigationController *finalNavi = [[UINavigationController alloc] initWithRootViewController:finalVC];
    
    SaleCustomsListViewController *saleCustomsVC = [[SaleCustomsListViewController alloc] init];
    UINavigationController *saleCustomsNavi = [[UINavigationController alloc] initWithRootViewController:saleCustomsVC];
    
    SaleCompareViewController *saleCompareVC = [[SaleCompareViewController alloc] init];
    UINavigationController *saleCompareNavi = [[UINavigationController alloc] initWithRootViewController:saleCompareVC];
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"首页", @"海印主页",@"购物卡销售", @"会员分析",@"结算汇总", @"销售客单", @"销售对比", nil];
    
    _mySideTV.titles = [NSMutableArray arrayWithArray:array];
    _mySideTV.viewControllers = [[NSMutableArray alloc] initWithObjects:homeNavi, highsunNavi, shoppingNavi, memberNavi, finalNavi, saleCustomsNavi, saleCompareNavi, nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- scrollView delegate
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    
    return YES;
    
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.size = [GetScreenSize getScreenSize:toInterfaceOrientation];
    [self resignBtnFram:toInterfaceOrientation];
}

//根据屏幕方向重新定义按钮的位置
- (void)resignBtnFram:(UIInterfaceOrientation)orientation
{
    self.size = [GetScreenSize getScreenSize:orientation];
    CGFloat width = 100;
    CGFloat height = 100*0.618;
    CGFloat distanceX = 0;
    CGFloat distanceY = 0;
    if (UIDeviceOrientationIsPortrait(orientation)) {
        distanceX = (self.size.width-width*2)/3;
        distanceY = (self.size.height-20-44-height*0.618*3)/4;
        
        _highsunHomeVCBtn.frame = CGRectMake(distanceX, distanceY+32, width, height);
        _shoppingCardVCBtn.frame = CGRectMake(width+distanceX*2, distanceY+32, width, height);
        _memberAnalyseVCBtn.frame = CGRectMake(distanceX, height+distanceY*2+32, width, height);
        _finalSumVCBtn.frame = CGRectMake(width+distanceX*2, height+distanceY*2+32, width, height);
        _saleCustomsListVCBtn.frame = CGRectMake(distanceX, height*2+distanceY*3+32, width, height);
        _saleCompareVCBtn.frame = CGRectMake(width+distanceX*2, height*2+distanceY*3+32, width, height);
    }
    else if(UIDeviceOrientationIsLandscape(orientation))
    {
        distanceX = (self.size.width-width*3)/4;
        distanceY = (self.size.height-20-44-height*0.618*2)/3;
        
        _highsunHomeVCBtn.frame = CGRectMake(distanceX, distanceY+32, width, height);
        _shoppingCardVCBtn.frame = CGRectMake(width+distanceX*2, distanceY+32, width, height);
        _memberAnalyseVCBtn.frame = CGRectMake(width*2+distanceX*3, distanceY+32, width, height);
        _finalSumVCBtn.frame = CGRectMake(distanceX, height+distanceY*2+32, width, height);
        _saleCustomsListVCBtn.frame = CGRectMake(width+distanceX*2, height+distanceY*2+32, width, height);
        _saleCompareVCBtn.frame = CGRectMake(width*2+distanceX*3, height+distanceY*2+32, width, height);
    }

}

@end
