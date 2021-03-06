//
//  SaleCompareDetailViewController.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-27.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "SaleCompareDetailViewController.h"

@interface SaleCompareDetailViewController ()

@end

@implementation SaleCompareDetailViewController

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
        [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
        NSMutableArray *params = [NSMutableArray arrayWithArray:[SQLDataSearch getUsrInfo]];
        [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.primaryKey,@"primaryKey", nil]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_SaleCompare" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetSaleCompareDataDetail" andParams:params andPageTitle:@"柜组销售分析"]];
        [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
        
        self.dataDic = dic;
        self.pageTitle = @"柜组销售分析";
        
        [_customTableView changeDataWithNewTime:dic];
        
        [_customTableView.leftTableView reloadData];
        [_customTableView.rightTableView reloadData];
        
        [self.view reloadInputViews];
        
        [defaults setObject:@"NO" forKey:@"isTimeChanged"];
    }
}

//获得本页面显示的所有数据所属于的楼层id
- (void)getTitleKey:(NSString *)key
{
    self.primaryKey = key;
}

#pragma mark -- 一些按钮的初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //    NSLog(@"----------------------------------------------------\n%@", self.dataDic);
    
    
    /******************************
     当从侧边栏推送出来本页面的时候，并没有数据，因此必须在此时判断时候已经取得了数据，否则就要重新从服务器中取得数据，来初始化页面数据。
     同时，我们可以在侧边栏中对页面进行初始化的时候就获得数据，但是这样会浪费很大内存以及流量，所以将数据请求放在页面显示时，可以避免内存浪费
     ******************************/
    if (self.dataDic.count ==0) {
        [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
        NSMutableArray *params = [NSMutableArray arrayWithArray:[SQLDataSearch getUsrInfo]];
        [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.primaryKey,@"primaryKey", nil]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_SaleCompare" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetSaleCompareDataDetail" andParams:params andPageTitle:@"柜组销售分析"]];
        [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
        
        self.dataDic = dic;
        self.sortTypeDic = [[NSMutableDictionary alloc] init];
        [self.sortTypeDic setObject:[NSString stringWithFormat:@"%d", numSmallToBig] forKey:[[dic objectForKey:@"headTitleKey"] objectAtIndex:0]];
        
        self.pageTitle = @"柜组销售分析";
        
        [_customTableView changeDataWithNewTime:dic];
        [_customTableView changeSumData:[DBDataHelper getSumNum:dic]];
        
        [_customTableView.leftTableView reloadData];
        [_customTableView.rightTableView reloadData];
        
        [_customTableView.sumTableView reloadData];
        
        [self.view reloadInputViews];
    }
    
    self.navigationItem.title = self.pageTitle;
    self.view.backgroundColor = [UIColor cyanColor];
    
//    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackSideTV)];
//    self.navigationItem.leftBarButtonItem = leftBarBtn;
//    
//    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:@selector(logOutSystem)];
//    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    NSArray *headArr = [NSArray arrayWithArray:[self.dataDic objectForKey:@"headTitleKey"]];
    NSDictionary *leftDic = [NSDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"leftTable"]];
    NSDictionary *rightDic = [NSDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"rightTable"]];
    
//    _customTableView = [[CustomTableView alloc] initWithHeadDataKeys:headArr andHeadDataTitle:self.pageTitle andLeftData:leftDic andRightData:rightDic andSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-84) andScrollMethod:kScrollMethodWithRight];
//    CGRect frame = _customTableView.frame;
//    frame.origin = CGPointMake(0, 84);
//    _customTableView.frame = frame;
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(version >= 7.0)
    {
        _customTableView = [[CustomTableView alloc] initWithHeadDataKeys:headArr andHeadDataTitle:@"柜组销售分析" andLeftData:leftDic andRightData:rightDic andSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-84-40) andScrollMethod:kScrollMethodWithRight];
        CGRect frame = _customTableView.frame;
        //在IOS7中视图的初始位置是在屏幕的左上角，因此需要下移20（状态栏）+44（导航栏）+20（表头，因为要旋转所以需要下移）+20（空出来预留给时间，搜索栏）
        frame.origin = CGPointMake(0, 84);
        _customTableView.frame = frame;
    }
    else if (version >= 5.0)
    {
        _customTableView = [[CustomTableView alloc] initWithHeadDataKeys:headArr andHeadDataTitle:@"柜组销售分析" andLeftData:leftDic andRightData:rightDic andSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-44-40) andScrollMethod:kScrollMethodWithRight];
        CGRect frame = _customTableView.frame;
        //在IOS5，IOS6中视图的初始位置是在屏幕的导航栏下面，因此只需要下移20（表头，因为要旋转所以需要下移）+20（空出来预留给时间，搜索栏）
        frame.origin = CGPointMake(0, 20);
        _customTableView.frame = frame;
        
    }else{
        //调用这个方法，就会异步去调用DrawRac方法
        
    }
    
    
    
    [self.view addSubview:_customTableView];
    
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
    _sortScrollView.contentSize = CGSizeMake(140, 125);
    _sortScrollView.delegate = self;
    _sortScrollView.userInteractionEnabled = YES;
    _sortScrollView.bounces = NO;
    
    
    _sortTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 15, 140, headArr.count*30) style:UITableViewStylePlain];
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
    
    [_sortScrollView addSubview:sortImageView];
    [_sortScrollView addSubview:_sortTableView];
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

//TODO: 中间按钮响应的方法
-(void)middleButtonAction
{
    _flag = (_flag + 1)%2;
    if (_flag == 1) {
        [self.view addSubview:_sortScrollView];
    }
    else
    {
        [_sortScrollView removeFromSuperview];
    }
    
}

#pragma mark -- TableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 30.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    NSLog(@"%s", __func__);
    NSArray *arr = [_dataDic objectForKey:@"headTitleKey"];
    return arr.count;
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
    
    HeadSortCell *cell = [[HeadSortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentify"];
    cell = (HeadSortCell *)[_sortTableView cellForRowAtIndexPath:indexPath];
    cell.sortKeyLabel.textColor = [UIColor whiteColor];
//    [cell addSubview:cell.sortTypeImage];
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
        [cell.sortTypeImage removeFromSuperview];
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
