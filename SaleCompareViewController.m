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

@synthesize flag = _flag;

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
//        [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
        NSArray *params = [NSArray arrayWithArray:[SQLDataSearch getUsrInfo]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_SaleCompare" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetSaleCompareData" andParams:params andPageTitle:@"销售对比"]];
//        [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
        
        self.dataDic = dic;
        self.pageTitle = @"销售对比";
        
        [_customTableView changeDataWithNewTime:dic];
        [_customTableView changeSumData:[DBDataHelper getSumNum:dic]];
        
        [_customTableView.leftTableView reloadData];
        [_customTableView.rightTableView reloadData];
        [_customTableView.sumTableView reloadData];
        
        [self.view reloadInputViews];
        
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
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_SaleCompare" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetSaleCompareData" andParams:params andPageTitle:@"销售对比"]];
        [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
        
        self.dataDic = dic;
        
        self.sortTypeDic = [[NSMutableDictionary alloc] init];
        [self.sortTypeDic setObject:[NSString stringWithFormat:@"%d", numSmallToBig] forKey:[[dic objectForKey:@"headTitleKey"] objectAtIndex:0]];
        
        self.pageTitle = @"销售对比";
    }
    
    self.navigationItem.title = self.pageTitle;
    self.view.backgroundColor = [UIColor cyanColor];

//    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackSideTV)];
//    self.navigationItem.leftBarButtonItem = leftBarBtn;
//    
//    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"日期" style:UIBarButtonItemStyleDone target:self action:@selector(logOutSystem)];
//    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    NSArray *headArr = [NSArray arrayWithArray:[self.dataDic objectForKey:@"headTitleKey"]];
    NSDictionary *leftDic = [NSDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"leftTable"]];
    NSDictionary *rightDic = [NSDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"rightTable"]];
    
    
    
//    _customTableView = [[CustomTableView alloc] initWithHeadDataKeys:headArr andHeadDataTitle:self.pageTitle andLeftData:leftDic andRightData:rightDic andSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-84) andScrollMethod:kScrollMethodWithRight];
//
//    CGRect frame = _customTableView.frame;
//    frame.origin = CGPointMake(0, 84);
//    _customTableView.frame = frame;
    
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(version >= 7.0)
    {
        _customTableView = [[CustomTableView alloc] initWithHeadDataKeys:headArr andHeadDataTitle:@"销售对比" andLeftData:leftDic andRightData:rightDic andSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-84-40) andScrollMethod:kScrollMethodWithRight];
        CGRect frame = _customTableView.frame;
        //在IOS7中视图的初始位置是在屏幕的左上角，因此需要下移20（状态栏）+44（导航栏）+20（表头，因为要旋转所以需要下移）+20（空出来预留给时间，搜索栏）
        frame.origin = CGPointMake(0, 20+44+20);
        _customTableView.frame = frame;
    }
    else if (version >= 5.0)
    {
        _customTableView = [[CustomTableView alloc] initWithHeadDataKeys:headArr andHeadDataTitle:@"销售对比" andLeftData:leftDic andRightData:rightDic andSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-44-40) andScrollMethod:kScrollMethodWithRight];
        CGRect frame = _customTableView.frame;
        //在IOS5，IOS6中视图的初始位置是在屏幕的导航栏下面，因此只需要下移20（表头，因为要旋转所以需要下移）+20（空出来预留给时间，搜索栏）
        frame.origin = CGPointMake(0, 20);
        _customTableView.frame = frame;
        
    }else{
        //调用这个方法，就会异步去调用DrawRac方法
        
    }
    
    
    
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
    
    _flag = 0;
    
    //middle
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    UIButton *middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    middleButton.frame = CGRectMake(0, 0, 155, 43);
    [middleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [middleButton addTarget:self action:@selector(middleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:middleButton];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 155-34, 44)];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.pageTitle;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment =1;
    [middleButton addSubview:label];
    self.navigationItem.titleView = titleView;
    
    NSUInteger index[] = {0, 0};
    _lastSelectCell = [[NSIndexPath alloc] initWithIndexes:index length:2];
    
    _sortScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(90, 60, 140, headArr.count*30+20)];
    _sortScrollView.contentSize = CGSizeMake(140, 120);
    _sortScrollView.delegate = self;
    _sortScrollView.userInteractionEnabled = YES;
    _sortScrollView.bounces = NO;
    
    
    _sortTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 15, 130, headArr.count*30) style:UITableViewStylePlain];
    _sortTableView.backgroundColor = [UIColor clearColor];
    [_sortTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    _sortTableView.delegate = self;
    _sortTableView.dataSource = self;
    
    UIImageView *sortImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 140, headArr.count*30+20)];
    UIImage *sortBG = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sort_bg" ofType:@"png"]];
    sortImageView.image = sortBG;
    sortImageView.userInteractionEnabled = YES;
//    [sortImageView addSubview:_sortTableView];
    
    self.sortTypeDic = [[NSMutableDictionary alloc] init];
    [self.sortTypeDic setObject:[NSString stringWithFormat:@"%d", numSmallToBig] forKey:[headArr objectAtIndex:0]];
//    for (NSString *key in headArr) {
//        [self.sortTypeDic setObject:[NSString stringWithFormat:@"%d", numSmallToBig] forKey:key];
//    }
    
    [_sortScrollView addSubview:sortImageView];
    [_sortScrollView addSubview:_sortTableView];
}

//收到通知的时候要触发的方法
-(void)didReceiveNotification:(id)sender
{
    [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
    
    @try {
        NSNotification *noti=(NSNotification *)sender;
        NSDictionary *notiInfo = [noti userInfo];
        NSLog(@"%@", notiInfo);
        NSLog(@"------------- 收到通知");
        
        NSString *pageTitleNext = [notiInfo objectForKey:@"pageTitle"];
        NSString *str = [NSString stringWithString:[notiInfo objectForKey:@"leftTableKey"]];
        
        
        NSMutableArray *params = [[NSMutableArray alloc] initWithArray:[SQLDataSearch getUsrInfo]];
        NSDictionary *key = [NSDictionary dictionaryWithObjectsAndKeys:str,@"primaryKey", nil];
        self.primaryKey = str;
        [params addObject:key];
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_SaleCompare" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetSaleCompareDataDetail" andParams:params andPageTitle:pageTitleNext]];
        
        NSDictionary *leftTable = [dic objectForKey:@"leftTable"];
        if (leftTable.count == 0 ) {
            [self.alertView setMessage:@"对不起，可能由于服务器原因暂时没有数据，请检查网络后再试！"];
            [self.alertView show];
        }
        else{
            SaleCompareDetailViewController *saleCompareDetailVC = [[SaleCompareDetailViewController alloc] initWithDataDic:dic andTitle:@"柜组销售分析"];
            [saleCompareDetailVC getTitleKey:str];
            [self.navigationController pushViewController:saleCompareDetailVC animated:YES];
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

#pragma mark -- 按钮的响应动作
//TODO: 导航栏上左右两边的动作响应
//- (void)goBackSideTV
//{
//    NSLog(@"返回");
//    
////    [self.navigationController popToRootViewControllerAnimated:YES];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

    [_customTableView fitWithScreenRotation:toInterfaceOrientation];
}

//TODO: 中间按钮响应的方法
-(void)middleButtonAction
{
    _flag = (_flag + 1)%2;
    if (_flag == 1) {
        //_sortScrollView.contentSize = CGSizeMake(140, 30*self.sortTypeDic.count);
        [self.view addSubview:_sortScrollView];
    }
    else
    {
        [_sortScrollView removeFromSuperview];
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _flag = _flag % 2;
    if (_flag == 0) {
        [_sortScrollView removeFromSuperview];
        _flag ++;
    }
}


#pragma mark -- TableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [_dataDic objectForKey:@"headTitleKey"];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 30.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"CellIdentify";
    HeadSortCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[HeadSortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.backgroundColor = [UIColor clearColor];
    NSArray *arr = [_dataDic objectForKey:@"headTitleValue"];
    cell.sortKeyLabel.text = [arr objectAtIndex:indexPath.row];
    
    NSString *typeStr = [self.sortTypeDic objectForKey:[[_dataDic objectForKey:@"headTitleKey"] objectAtIndex:indexPath.row]];
    int type = -1;
    if (typeStr == nil) {
        type = -1;
    }
    else {
        type = [typeStr intValue];
    }
                         
    if (type == 0) {
        cell.sortTypeImage.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"arrow_up" ofType:@"png"]];
    }
    else if(type == 1)
    {
        cell.sortTypeImage.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"arrow_down" ofType:@"png"]];
    }
    else
    {
        [cell.sortImageView removeFromSuperview];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *arr = [_dataDic objectForKey:@"headTitleKey"];
    NSString *key = [arr objectAtIndex:indexPath.row];
    
    NSDictionary *leftData = [_dataDic objectForKey:@"leftTable"];
    NSMutableArray *leftDataArr = [NSMutableArray arrayWithArray:[leftData allKeys]];
    
    NSString *sortTypeStr = [self.sortTypeDic objectForKey:key];
    if (sortTypeStr == nil) {
        sortTypeStr = @"1";
    }
    SortType sortType = [sortTypeStr intValue];
    NSArray *sortArr = [DBDataHelper QuickSort:_dataDic andKeyArr:leftDataArr andSortType:sortType andSortKey:key StartIndex:0 EndIndex:leftDataArr.count-1];
    
    [self.sortTypeDic removeAllObjects];
    self.sortTypeDic = [[NSMutableDictionary alloc] init];
    
    if (sortType == numBigToSmall) {
        sortType = numSmallToBig;
        
        [self.sortTypeDic setObject:[NSString stringWithFormat:@"%d", sortType] forKey:key];
    }
    else
    {
        sortType = numBigToSmall;
        [self.sortTypeDic setObject:[NSString stringWithFormat:@"%d", sortType] forKey:key];

    }
    
    [_customTableView changeDataWithSortArr:sortArr];
    [_customTableView.leftTableView reloadData];
    [_customTableView.rightTableView reloadData];
    
    [_customTableView reloadInputViews];
    
    //获取当前选择的cell，以及前一次选择的cell
    //改变选择的cell的字体颜色，以及添加箭头表示排序方法
    HeadSortCell *cell = [[HeadSortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentify"];
    cell = (HeadSortCell *)[_sortTableView cellForRowAtIndexPath:indexPath];
    cell.sortKeyLabel.textColor = [UIColor whiteColor];
    NSString *typeStr = [self.sortTypeDic objectForKey:[arr objectAtIndex:indexPath.row]];
    int type = -1;
    if (typeStr == nil) {
        type = -1;
    }
    else {
        type = [typeStr intValue];
    }
    
    //根据获取的排序方法确定箭头方向
    if (type == 0) {
        cell.sortTypeImage.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"arrow_up" ofType:@"png"]];
    }
    else if(type == 1)
    {
        cell.sortTypeImage.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"arrow_down" ofType:@"png"]];
    }
    [cell addSubview:cell.sortTypeImage];
    
    
    if (![indexPath isEqual:_lastSelectCell]) {
        HeadSortCell *cellLast = [[HeadSortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentify"];
        cellLast = (HeadSortCell *)[_sortTableView cellForRowAtIndexPath:_lastSelectCell];
        cellLast.sortKeyLabel.textColor = [UIColor blackColor];
        [cellLast.sortTypeImage removeFromSuperview];
        _lastSelectCell = indexPath;
    }
    
    
    
    [_sortTableView reloadData];
    
    [_sortScrollView removeFromSuperview];
    
    _flag = 0;
}



@end
