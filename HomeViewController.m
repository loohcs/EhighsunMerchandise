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
    
    [self.revealSideViewController preloadViewController:self.mySideTV forSide:PPRevealSideDirectionTop];
    [self.revealSideViewController preloadViewController:self.mySideTV forSide:PPRevealSideDirectionLeft];
    
    UIButton *highsunHomeVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    highsunHomeVCBtn.frame = CGRectMake(60, 80, 100, 100*0.618);
    [highsunHomeVCBtn setTitle:@"海印主页" forState:UIControlStateNormal];
    [highsunHomeVCBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:highsunHomeVCBtn];
    
    UIButton *shoppingCardVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    shoppingCardVCBtn.frame = CGRectMake(180, 80, 100, 100*0.618);
    [shoppingCardVCBtn setTitle:@"购物卡销售" forState:UIControlStateNormal];
    [shoppingCardVCBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shoppingCardVCBtn];
    
    UIButton *memberAnalyseVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    memberAnalyseVCBtn.frame = CGRectMake(60, 180, 100, 100*0.618);
    [memberAnalyseVCBtn setTitle:@"会员分析" forState:UIControlStateNormal];
    [memberAnalyseVCBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:memberAnalyseVCBtn];
    
    UIButton *finalSumVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    finalSumVCBtn.frame = CGRectMake(180, 180, 100, 100*0.618);
    [finalSumVCBtn setTitle:@"结算汇总" forState:UIControlStateNormal];
    [finalSumVCBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finalSumVCBtn];
    
    UIButton *saleCustomsListVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saleCustomsListVCBtn.frame = CGRectMake(60, 280, 100, 100*0.618);
    [saleCustomsListVCBtn setTitle:@"销售客单" forState:UIControlStateNormal];
    [saleCustomsListVCBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saleCustomsListVCBtn];
    
    UIButton *saleCompareVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saleCompareVCBtn.frame = CGRectMake(180, 280, 100, 100*0.618);
    [saleCompareVCBtn setTitle:@"销售对比" forState:UIControlStateNormal];
    [saleCompareVCBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saleCompareVCBtn];
}

//TODO: 导航栏上左右两边的动作响应
- (void)goBackSideTV
{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

- (void)logOutSystem
{
    
}

- (void)initWithTableView
{
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

@end
