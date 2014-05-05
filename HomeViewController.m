//
//  HomeViewController.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "HomeViewController.h"

#import "JBViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
//#warning mark -- 下面的是获取店名的方法
//        [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"primaryUserKey",@"VYbSBDuFOPVd", nil];
//        NSArray *params = [NSArray arrayWithObjects:dic, nil];
//        ServiceArgs *args=[[ServiceArgs alloc] initWithWebServiceName:@"WS_ManaFrame" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetManaFrameData" andParams:params];
//        ServiceResult *result=[ServiceHelper syncService:args];
//        //    ServiceResult *result=[ServiceHelper syncMethodName:@"TestConnectOracle"];
//        NSLog(@"同步请求xml=%@\n",result);
//        NSLog(@"----------同步请求xml=%@\n",result.xmlString);
//        NSArray *arr=[result.xmlParse soapXmlSelectNodes:@"//ManaFrameData"];
//        
//        NSLog(@"%@", arr);
//        
//        NSDictionary *dicTest = [DBDataHelper getChineseName:arr];
//        
//        NSString *path = [SQLDataSearch getPlistPath:@"店名中文映射.plist"];
//        NSFileManager *file = [NSFileManager defaultManager];
//        if (![file fileExistsAtPath:path]) {
//            [dicTest writeToFile:path atomically:YES];
//        }
    }
    return self;
}

static bool isLogin = NO;

//在第一次打开程序的时候，我们需要进入登陆页面
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *isAutoLog = [defaults objectForKey:@"isAutoLogIn"];
    
    if ([isAutoLog isEqualToString:@"YES"]) {
        //网络监测
        AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDlg.isReachable)
        {
            //NSLog(@"网络已连接11111111111");//执行网络正常时的代码
        }
        else
        {
            //NSLog(@"网络连接异常2222222222");//执行网络异常时的代码
        }
        
        
        isLogin = YES;
    }
    else if (!isLogin)
    {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:NO completion:nil];
        [loginVC release];
        isLogin = YES;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = @"海印百货通";
    
    
    
    //[self showLoadingAnimatedWithTitle:@"test"];
    
    //[self.view bringSubviewToFront:self.loadingView];
    
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//    NSString *naviBackImagePath = [[NSBundle mainBundle] pathForResource:@"yh_03" ofType:@"png"];
//    UIImage *naviBackImage = [UIImage imageWithContentsOfFile:naviBackImagePath];
//    imageView.image = naviBackImage;
//    [self.navigationItem setTitleView:imageView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(0, 0, 60, 30);
//    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(goBackSideTV) forControlEvents:UIControlEventTouchUpInside];
//    [leftBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back" ofType:@"png"]] forState:UIControlStateNormal];
//    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItem = leftBarBtn;
//    [leftBarBtn release];
//    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 60, 30);
//    [rightBtn setTitle:@"日期" forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"date" ofType:@"png"]] forState:UIControlStateNormal];
//    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightBarBtn;
//    [rightBarBtn release];
 
    
    //TODO: 加载侧滑栏
//    self.revealSideViewController.panInteractionsWhenClosed = PPRevealSideInteractionNavigationBar|PPRevealSideInteractionNone;
//    
//    _mySideTV = [[SideTableViewController alloc] initWithStyle:UITableViewStylePlain];
//    [self initWithTableView];
//    
//    //预加载侧边栏
//    [self.revealSideViewController preloadViewController:self.mySideTV forSide:PPRevealSideDirectionTop];
//    [self.revealSideViewController preloadViewController:self.mySideTV forSide:PPRevealSideDirectionLeft];
    
    
    
    //添加屏幕按钮以及定义响应方法
    //海印主页，跳转到商场选择界面
//    _highsunHomeVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    _highsunHomeVCBtn.backgroundColor = [UIColor clearColor];
//    NSString *highsunHomeIcon = [[NSBundle mainBundle] pathForResource:@"shoppingCard" ofType:@"png"];
//    UIImage *highsunHomeImage = [UIImage imageWithContentsOfFile:highsunHomeIcon];
//    [_highsunHomeVCBtn setBackgroundImage:highsunHomeImage forState:UIControlStateNormal];
//    [highsunHomeImage release];
//    //    [_shoppingCardVCBtn setTitle:@"购物卡销售" forState:UIControlStateNormal];
//    
//    _shoppingCardLabel = [[UILabel alloc] init];
//    _shoppingCardLabel.text = @"购物卡销售";
//    [self.view addSubview:_shoppingCardLabel];
//    
//    [_shoppingCardVCBtn addTarget:self action:@selector(shoppingCardVCAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_shoppingCardVCBtn];
    
    
    
    //购物卡销售界面按钮
//    _shoppingCardVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
////    _shoppingCardVCBtn.backgroundColor = [UIColor cyanColor];
//    _shoppingCardVCBtn.backgroundColor = [UIColor clearColor];
//    NSString *shopCardIcon = [[NSBundle mainBundle] pathForResource:@"shoppingCard" ofType:@"png"];
//    UIImage *shopCardBtnImage = [UIImage imageWithContentsOfFile:shopCardIcon];
//    [_shoppingCardVCBtn setBackgroundImage:shopCardBtnImage forState:UIControlStateNormal];
//    [shopCardBtnImage release];
////    [_shoppingCardVCBtn setTitle:@"购物卡销售" forState:UIControlStateNormal];
//    
//    _shoppingCardLabel = [[UILabel alloc] init];
//    _shoppingCardLabel.text = @"购物卡销售";
//    [self.view addSubview:_shoppingCardLabel];
//    
//    [_shoppingCardVCBtn addTarget:self action:@selector(shoppingCardVCAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_shoppingCardVCBtn];
    
    
    
    //会员分析界面按钮
//    _memberAnalyseVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
////    _memberAnalyseVCBtn.backgroundColor = [UIColor cyanColor];
//    _memberAnalyseVCBtn.backgroundColor = [UIColor clearColor];
//    NSString *memberAnaIcon = [[NSBundle mainBundle] pathForResource:@"memberAnalyse" ofType:@"png"];
//    UIImage *memberAnaBtnImage = [UIImage imageWithContentsOfFile:memberAnaIcon];
//    [_memberAnalyseVCBtn setBackgroundImage:memberAnaBtnImage forState:UIControlStateNormal];
//    [memberAnaBtnImage release];
////    [_memberAnalyseVCBtn setTitle:@"会员分析" forState:UIControlStateNormal];
//    
//    _memberAnalyseLabel = [[UILabel alloc] init];
//    _memberAnalyseLabel.text = @"会员分析";
//    [self.view addSubview:_memberAnalyseLabel];
//    
//    [_memberAnalyseVCBtn addTarget:self action:@selector(memberAnalyseVCAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_memberAnalyseVCBtn];
    
    //结算汇总界面按钮
//    _finalSumVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
////    _finalSumVCBtn.backgroundColor = [UIColor cyanColor];
//    _finalSumVCBtn.backgroundColor = [UIColor clearColor];
//    NSString *finalSumIcon = [[NSBundle mainBundle] pathForResource:@"finalSumVC" ofType:@"png"];
//    UIImage *finalSumBtnImage = [UIImage imageWithContentsOfFile:finalSumIcon];
//    [_finalSumVCBtn setBackgroundImage:finalSumBtnImage forState:UIControlStateNormal];
//    [finalSumBtnImage release];
////    [_finalSumVCBtn setTitle:@"结算汇总" forState:UIControlStateNormal];
//    
//    _finalSumLabel = [[UILabel alloc] init];
//    _finalSumLabel.text = @"结算汇总";
//    [self.view addSubview:_finalSumLabel];
//    
//    [_finalSumVCBtn addTarget:self action:@selector(finalSumVCAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_finalSumVCBtn];
    
    //销售客单
    _saleCustomsListVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    _saleCustomsListVCBtn.backgroundColor = [UIColor cyanColor];
    _saleCustomsListVCBtn.backgroundColor = [UIColor clearColor];
    NSString *saleCusListIcon = [[NSBundle mainBundle] pathForResource:@"saleCustomList" ofType:@"png"];
    UIImage *saleCusListBtnImage = [UIImage imageWithContentsOfFile:saleCusListIcon];
    [_saleCustomsListVCBtn setBackgroundImage:saleCusListBtnImage forState:UIControlStateNormal];
    [saleCusListBtnImage release];
//    [_saleCustomsListVCBtn setTitle:@"销售客单" forState:UIControlStateNormal];
    
    _saleCustomsListLabel = [[UILabel alloc] init];
    _saleCustomsListLabel.text = @"销售客单";
    [self.view addSubview:_saleCustomsListLabel];
    
    [_saleCustomsListVCBtn addTarget:self action:@selector(saleCustomsListVCAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saleCustomsListVCBtn];
    
    //销售对比
    _saleCompareVCBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    _saleCompareVCBtn.backgroundColor = [UIColor cyanColor];
    _saleCompareVCBtn.backgroundColor = [UIColor clearColor];
    NSString *saleCompareIcon = [[NSBundle mainBundle] pathForResource:@"saleCompare" ofType:@"png"];
    UIImage *saleCompareBtnImage = [UIImage imageWithContentsOfFile:saleCompareIcon];
    [_saleCompareVCBtn setBackgroundImage:saleCompareBtnImage forState:UIControlStateNormal];
    [saleCompareBtnImage release];
//    [_saleCompareVCBtn setTitle:@"销售对比" forState:UIControlStateNormal];
    
    _saleCompareLabel = [[UILabel alloc] init];
    _saleCompareLabel.text = @"销售对比";
    [self.view addSubview:_saleCompareLabel];
    
    [_saleCompareVCBtn addTarget:self action:@selector(saleCompareVCAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saleCompareVCBtn];
    
    
    //获取当前的屏幕大小，即确定屏幕方向
    [self resignBtnFram:self.interfaceOrientation];
    
    //如果是自动登录，那么在直接显示主页的时候也需要更新店铺名
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *isAutoLog = [defaults objectForKey:@"isAutoLogIn"];
    
    if ([isAutoLog isEqualToString:@"YES"]) {
        NSMutableArray *params = [[NSMutableArray alloc] init];
        [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"VYbSBDuFOPVd",@"primaryUserKey", nil]];
        ServiceArgs *args=[[ServiceArgs alloc] initWithWebServiceName:@"WS_ManaFrame" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetManaFrameData" andParams:params];
        NSLog(@"%@", args.soapMessage);
        ServiceResult *result=[ServiceHelper syncService:args];
        NSLog(@"同步请求xml=%@\n",result);
        NSLog(@"----------同步请求xml=%@\n",result.xmlString);
        NSArray *arr=[result.xmlParse soapXmlSelectNodes:@"//ManaFrameData"];
        NSLog(@"解析xml结果=%@\n",arr);
        
        NSDictionary *dic = [DBDataHelper getChineseName:arr];
        
        //在document文件里面
        NSString *path = [SQLDataSearch getPlistPath:@"店名中文映射.plist"];
        
        //        NSString *path = [SQLDataSearch getPlistPath:@"店名中文映射" andType:@"plist"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path]) {
            if (dic.count != 0) {
                [dic writeToFile:path atomically:YES];
            }
        }
        else {
            [fileManager createFileAtPath:path contents:nil attributes:Nil];
            [dic writeToFile:path atomically:YES];
        }

    }


}

////TODO: 导航栏上左右两边的动作响应
//- (void)goBackSideTV
//{
//    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
//}
//
//- (void)selectDate
//{
//    //崩溃测试，点击退出会马上使程序崩溃，但是不会出现闪退现象，会跳出警示框
////    [self performSelector:@selector(aaaa)];
//    
//    JBViewController *JBVC = [[JBViewController alloc] init];
//    [self.navigationController pushViewController:JBVC animated:YES];
//}

- (void)highsunHomeVCAction
{
    [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
    
    NSArray *params = [NSArray arrayWithArray:[SQLDataSearch getUsrInfo]];
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_HighsunHome" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetHighsunHomeData" andParams:params andPageTitle:@"主页"]];
    [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
    
    
    HighsunHomeViewController *highsunHomeVC = [[HighsunHomeViewController alloc] initWithDataDic:dic andTitle:@"主页"];
    [self.navigationController pushViewController:highsunHomeVC animated:YES];
    [highsunHomeVC release];
    
}

- (void)shoppingCardVCAction
{
    [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
    NSArray *params = [NSArray arrayWithArray:[SQLDataSearch getUsrInfo]];
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_ShoppingCard" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetShoppingCardData" andParams:params andPageTitle:@"购物卡销售"]];
    [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
    
    ShoppingCardViewController *shoppingVC = [[ShoppingCardViewController alloc] initWithDataDic:dic andTitle:@"购物卡销售"];
    [self.navigationController pushViewController:shoppingVC animated:YES];
    [shoppingVC release];
}

- (void)memberAnalyseVCAction
{
    [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
    
    NSArray *params = [NSArray arrayWithArray:[SQLDataSearch getUsrInfo]];
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_VipMember" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetVipMemberData" andParams:params andPageTitle:@"会员分析"]];
    
    [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
    
    MemberAnalyseViewController *memberVC = [[MemberAnalyseViewController alloc] initWithDataDic:dic andTitle:@"会员分析"];
    [self.navigationController pushViewController:memberVC animated:YES];
    [memberVC release];
}

- (void)finalSumVCAction
{
    [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
    
    NSArray *params = [NSArray arrayWithArray:[SQLDataSearch getUsrInfo]];
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_FinalSum" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetFinalSumData" andParams:params andPageTitle:@"结算汇总"]];
    [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
    
    FinalSumViewController *finalVC = [[FinalSumViewController alloc] initWithDataDic:dic andTitle:@"结算汇总"];
    [self.navigationController pushViewController:finalVC animated:YES];
    [finalVC release];
}

- (void)saleCustomsListVCAction
{
    [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
    
    @try {
        NSArray *params = [NSArray arrayWithArray:[SQLDataSearch getUsrInfo]];
        
        NSDictionary *dic = [SQLDataSearch SyncGetDataWith:@"WS_SaleCustomsList" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetSaleCustomsListData" andParams:params andPageTitle:@"销售客单"];
        
        
        //当请求回来的数据为空的时候弹出警示栏，避免因为空数据引起的崩溃
        NSDictionary *leftTable = [dic objectForKey:@"leftTable"];
        if (leftTable.count == 0 ) {
            [self.alertView setMessage:@"对不起，可能由于网络原因暂时没有数据，请检查网络后再试！"];
            [self.alertView show];
            
            [self hideLoadingSuccessWithTitle:@"没有数据！" completed:nil];
        }
        else{
            SaleCustomsListViewController *saleCustomsVC = [[SaleCustomsListViewController alloc] initWithDataDic:dic andTitle:@"销售客单"];
            [self.navigationController pushViewController:saleCustomsVC animated:YES];
            [saleCustomsVC release];
            
            [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
        }
        
        
        
    }
    @catch (NSException *exception) {
        [self.alertView setMessage:@"对不起，暂时没有数据，请检查网络后再试！"];
        [self.alertView show];
    }
    @finally {
        
    }
    
    
}

- (void)saleCompareVCAction
{
    [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
    
    @try {
        NSArray *params = [NSArray arrayWithArray:[SQLDataSearch getUsrInfo]];
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_SaleCompare" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetSaleCompareData" andParams:params andPageTitle:@"销售对比"]];
        
        //当请求回来的数据为空的时候弹出警示栏，避免因为空数据引起的崩溃
        NSDictionary *leftTable = [dic objectForKey:@"leftTable"];
        if (leftTable.count == 0 ) {
            [self.alertView setMessage:@"对不起，可能由于服务器原因暂时没有数据，请检查网络后再试！"];
            [self.alertView show];
        }
        else{
            SaleCompareViewController *saleCompareVC = [[SaleCompareViewController alloc] initWithDataDic:dic andTitle:@"销售对比"];
            [self.navigationController pushViewController:saleCompareVC animated:YES];
            [saleCompareVC release];
        }
            }
    @catch (NSException *exception) {
        [self.alertView setMessage:@"对不起，暂时没有数据，请检查网络后再试！"];
        [self.alertView show];
    }
    @finally {
        
    }
    
    
    [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];

    
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
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"首页", @"海印主页",@"销售客单", @"会员分析",@"销售对比", @"购物卡销售", @"结算汇总", nil];
    
    _mySideTV.titles = [NSMutableArray arrayWithArray:array];
    _mySideTV.viewControllers = [[[NSMutableArray alloc] initWithObjects:homeNavi, highsunNavi, saleCustomsNavi, memberNavi, saleCompareNavi, shoppingNavi, finalNavi, nil] autorelease];
    
    [homeVC release];
    [homeNavi release];
    [highsunVC release];
    [highsunNavi release];
    [shoppingVC release];
    [shoppingNavi release];
    [memberVC release];
    [memberNavi release];
    [saleCompareVC release];
    [saleCompareNavi release];
    [saleCustomsVC release];
    [saleCustomsNavi release];
    
    [array release];
}

- (void)dealloc
{
    [super dealloc];
    
    [_mySideTV release];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
//    [self.mySideTV release];
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
        
//        _highsunHomeVCBtn.frame = CGRectMake(distanceX, distanceY+32, width, height);
//        _shoppingCardVCBtn.frame = CGRectMake(width+distanceX*2, distanceY+32, width, height);
//        _memberAnalyseVCBtn.frame = CGRectMake(distanceX, height+distanceY*2+32, width, height);
//        _finalSumVCBtn.frame = CGRectMake(width+distanceX*2, height+distanceY*2+32, width, height);
//        _saleCustomsListVCBtn.frame = CGRectMake(distanceX, height*2+distanceY*3+32, width, height);
//        _saleCompareVCBtn.frame = CGRectMake(width+distanceX*2, height*2+distanceY*3+32, width, height);
        
//        _highsunHomeVCBtn.frame = CGRectMake(distanceX, distanceY+32, height, height);
//        _saleCustomsListVCBtn.frame = CGRectMake(width+distanceX*2, distanceY+32, height, height);
//        _memberAnalyseVCBtn.frame = CGRectMake(distanceX, height+distanceY*2+32, height, height);
//        _saleCompareVCBtn.frame = CGRectMake(width+distanceX*2, height+distanceY*2+32, height, height);
//        _shoppingCardVCBtn.frame = CGRectMake(distanceX, height*2+distanceY*3+32, height, height);
//        _finalSumVCBtn.frame = CGRectMake(width+distanceX*2, height*2+distanceY*3+32, height, height);
        
        /********************************************/
        /***********下面的是6个按钮都存在时的坐标*********/
//        _highsunHomeVCBtn.frame = CGRectMake(distanceX, distanceY, height, height);
//        _saleCustomsListVCBtn.frame = CGRectMake(width+distanceX*2, distanceY, height, height);
//        _memberAnalyseVCBtn.frame = CGRectMake(distanceX, height+distanceY*2, height, height);
//        _saleCompareVCBtn.frame = CGRectMake(width+distanceX*2, height+distanceY*2, height, height);
//        _shoppingCardVCBtn.frame = CGRectMake(distanceX, height*2+distanceY*3, height, height);
//        _finalSumVCBtn.frame = CGRectMake(width+distanceX*2, height*2+distanceY*3, height, height);
//        
//        _highsunHomeLabel.frame = CGRectMake(distanceX, distanceY+60, 80, 30);
//        _saleCustomsListLabel.frame = CGRectMake(width+distanceX*2, distanceY+60, 80, 30);
//        _memberAnalyseLabel.frame = CGRectMake(distanceX, height+distanceY*2+60, 80, 30);
//        _saleCompareLabel.frame = CGRectMake(width+distanceX*2, height+distanceY*2+60, 80, 30);
//        _shoppingCardLabel.frame = CGRectMake(distanceX, height*2+distanceY*3+60, 100, 30);
//        _finalSumLabel.frame = CGRectMake(width+distanceX*2, height*2+distanceY*3+60, 80, 30);
        
        //****************************************/
        //下面是只有三个有数据的按钮存在
        _saleCustomsListVCBtn.frame = CGRectMake(60, distanceY, height, height);
        //_memberAnalyseVCBtn.frame = CGRectMake(120, distanceY, height, height);
        _saleCompareVCBtn.frame = CGRectMake(180, distanceY, height, height);


        _saleCustomsListLabel.frame = CGRectMake(60, distanceY+60, 80, 30);
        //_memberAnalyseLabel.frame = CGRectMake(120, distanceY+60, 80, 30);
        _saleCompareLabel.frame = CGRectMake(180, distanceY+60, 80, 30);

        
    }
    else if(UIDeviceOrientationIsLandscape(orientation))
    {
        distanceX = (self.size.width-width*3)/4;
        distanceY = (self.size.height-20-44-height*0.618*2)/3;
        
//        _highsunHomeVCBtn.frame = CGRectMake(distanceX, distanceY+32, width, height);
//        _shoppingCardVCBtn.frame = CGRectMake(width+distanceX*2, distanceY+32, width, height);
//        _memberAnalyseVCBtn.frame = CGRectMake(width*2+distanceX*3, distanceY+32, width, height);
//        _finalSumVCBtn.frame = CGRectMake(distanceX, height+distanceY*2+32, width, height);
//        _saleCustomsListVCBtn.frame = CGRectMake(width+distanceX*2, height+distanceY*2+32, width, height);
//        _saleCompareVCBtn.frame = CGRectMake(width*2+distanceX*3, height+distanceY*2+32, width, height);
        
        _highsunHomeVCBtn.frame = CGRectMake(distanceX, distanceY+32, width, height);
        _saleCustomsListVCBtn.frame = CGRectMake(width+distanceX*2, distanceY+32, width, height);
        _memberAnalyseVCBtn.frame = CGRectMake(width*2+distanceX*3, distanceY+32, width, height);
        _saleCompareVCBtn.frame = CGRectMake(distanceX, height+distanceY*2+32, width, height);
        _shoppingCardVCBtn.frame = CGRectMake(width+distanceX*2, height+distanceY*2+32, width, height);
        _finalSumVCBtn.frame = CGRectMake(width*2+distanceX*3, height+distanceY*2+32, width, height);
    }

}


@end
