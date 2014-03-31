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
        _flag = 0;
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
    
//    self.navigationItem.title = self.pageTitle;
    self.view.backgroundColor = [UIColor cyanColor];

    
//    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackSideTV)];
//    self.navigationItem.leftBarButtonItem = leftBarBtn;
//    
//    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"日期" style:UIBarButtonItemStyleDone target:self action:@selector(logOutSystem)];
//    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(0, 0, 60, 30);
//    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(goBackSideTV) forControlEvents:UIControlEventTouchUpInside];
//    [leftBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back" ofType:@"png"]] forState:UIControlStateNormal];
//    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItem = leftBarBtn;
//    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 60, 30);
//    [rightBtn setTitle:@"日期" forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(goBackSideTV) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"date" ofType:@"png"]] forState:UIControlStateNormal];
//    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightBarBtn;

    
    NSArray *headArr = [NSArray arrayWithArray:[self.dataDic objectForKey:@"headTitleKey"]];
    NSMutableDictionary *leftDic = [NSMutableDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"leftTable"]];
//    NSMutableArray *leftKeys = [NSMutableArray arrayWithArray:[leftDic allKeys]];
    NSDictionary *rightDic = [NSDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"rightTable"]];
    
    
#warning mark -- 在添加结算汇总的表单时，此处将会关系到结算行的位置
    _customTableView = [[CustomTableView alloc] initWithHeadDataKeys:headArr andHeadDataTitle:@"会员分析" andLeftData:leftDic andRightData:rightDic andSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-84) andScrollMethod:kScrollMethodWithRight];
    CGRect frame = _customTableView.frame;
    frame.origin = CGPointMake(0, 84);
    _customTableView.frame = frame;
    [self.view addSubview:_customTableView];
    
    _flag = 0;
    
    //middle
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    UIButton *middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    middleButton.frame = CGRectMake(0, 0, 155, 43);
    [middleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [middleButton addTarget:self action:@selector(middleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:middleButton];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150-34, 44)];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    label.text = self.pageTitle;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.tintColor = [UIColor grayColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment =1;
    [middleButton addSubview:label];
    self.navigationItem.titleView = titleView;
    
    _sortTableView = [[UITableView alloc] initWithFrame:CGRectMake(90, 60, 140, 120) style:UITableViewStylePlain];
//    _sortTableView.backgroundColor = [UIColor grayColor];
    _sortTableView.delegate = self;
    _sortTableView.dataSource = self;
}

//TODO: 导航栏上左右两边的动作响应
//- (void)goBackSideTV
//{
//    NSLog(@"返回");
//    
////    [self.navigationController popToRootViewControllerAnimated:YES];
//    
//    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
//}
//
//- (void)logOutSystem
//{
//    JBViewController *JBVC = [[JBViewController alloc] init];
//    [self.navigationController pushViewController:JBVC animated:YES];
//}

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


//TODO: 中间按钮响应的方法
-(void)middleButtonAction
{
    _flag = (_flag + 1)%2;
    if (_flag == 1) {
        [self.view addSubview:_sortTableView];
    }
    else
    {
        [_sortTableView removeFromSuperview];
    }
    
}

#pragma mark -- TableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray *arr = [_dataDic objectForKey:@"headTitleKey"];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 30.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    NSLog(@"%s", __func__);
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"CellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSArray *arr = [_dataDic objectForKey:@"headTitleValue"];
    cell.textLabel.text = [arr objectAtIndex:indexPath.section];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *arr = [_dataDic objectForKey:@"headTitleKey"];
    NSString *key = [arr objectAtIndex:indexPath.section];
    
    NSDictionary *leftData = [_dataDic objectForKey:@"leftTable"];
    NSMutableArray *leftDataArr = [NSMutableArray arrayWithArray:[leftData allKeys]];
    
    NSArray *sortArr = [DBDataHelper QuickSort:_dataDic andKeyArr:leftDataArr andSortKey:key StartIndex:0 EndIndex:leftDataArr.count-1];
    [_customTableView changeDataWithSortArr:sortArr];
    [_customTableView.leftTableView reloadData];
    [_customTableView.rightTableView reloadData];
    
    [_customTableView reloadInputViews];
    
    [_sortTableView removeFromSuperview];
    
    _flag = _flag++%2;
}


- (void)viewDidDisappear:(BOOL)animated
{
    [_customTableView removeFromSuperview];
}

@end
