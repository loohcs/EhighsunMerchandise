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
    
    UIBarButtonItem *righttBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.rightBarButtonItem = righttBarBtn;
 
    self.revealSideViewController.panInteractionsWhenClosed = PPRevealSideInteractionNavigationBar|PPRevealSideInteractionNone;
    
    _mySideTV = [[SideTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self initWithTableView];
    
    [self.revealSideViewController preloadViewController:self.mySideTV forSide:PPRevealSideDirectionTop];
    [self.revealSideViewController preloadViewController:self.mySideTV forSide:PPRevealSideDirectionLeft];
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
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"首页", @"海印主页",@"购物卡销售", @"会员分析",@"结算分析", @"销售客单", @"销售对比", nil];
    
    _mySideTV.titles = [NSMutableArray arrayWithArray:array];
    _mySideTV.viewControllers = [[NSMutableArray alloc] initWithObjects:homeNavi, highsunNavi, shoppingNavi, memberNavi, finalNavi, saleCustomsNavi, saleCompareNavi, nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
