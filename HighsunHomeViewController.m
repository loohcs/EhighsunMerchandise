//
//  HighsunHomeViewController.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "HighsunHomeViewController.h"

@interface HighsunHomeViewController ()

@end

@implementation HighsunHomeViewController

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
    [self.alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_HighsunHome" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetHighsunHomeData" andParams:params andPageTitle:@"主页"]];
        [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
        
        self.dataDic = dic;
        self.pageTitle = @"主页";
    }

    
//    self.navigationItem.title = self.pageTitle;
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackSideTV)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"日期" style:UIBarButtonItemStyleDone target:self action:@selector(getSearchDate)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    _flag = 0;
    
    //middle
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    UIButton *middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    middleButton.frame = CGRectMake(0, 0, 155, 43);
    [middleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [middleButton addTarget:self action:@selector(middleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:middleButton];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 155-34, 44)];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:21];
    label.text = @"商场";
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment =1;
    [middleButton addSubview:label];
    self.navigationItem.titleView = titleView;
    
    _sortTableView = [[UITableView alloc] initWithFrame:CGRectMake(110, 70, 100, 120) style:UITableViewStylePlain];
    _sortTableView.delegate = self;
    _sortTableView.dataSource = self;
    _sortTableView.hidden = YES;
    [self.view addSubview:_sortTableView];
    
    NSArray *headArr = [NSArray arrayWithArray:[self.dataDic objectForKey:@"headTitleKey"]];
//    NSMutableArray *leftKeys = [NSMutableArray arrayWithArray:[self.dataDic objectForKey:@"leftTable"]];
    NSDictionary *leftDic = [NSDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"leftTable"]];
    NSDictionary *rightDic = [NSDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"rightTable"]];
    
    _customTableView = [[CustomTableView alloc] initWithHeadDataKeys:headArr andHeadDataTitle:@"主页" andLeftData:leftDic andRightData:rightDic andSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-84) andScrollMethod:kScrollMethodWithRight];
    
    
    CGRect frame = _customTableView.frame;
    frame.origin = CGPointMake(0, 84);
    _customTableView.frame = frame;
    [self.view addSubview:_customTableView];
}

//TODO: 导航栏上左右两边的动作响应
- (void)goBackSideTV
{
    NSLog(@"返回");
//    self.tabBarController
//    [self.navigationController popViewControllerAnimated:YES];
    
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

- (void)getSearchDate
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
    
    return NO;
    
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    [_customTableView fitWithScreenRotation:toInterfaceOrientation];
//    [self.view setNeedsDisplay];
}

//TODO: 中间按钮响应的方法
-(void)middleButtonAction
{
    _flag = (_flag + 1)%2;
    if (_flag == 1) {
        _sortTableView.hidden = NO;
    }
    else
    {
        _sortTableView.hidden = YES;
    }
    
}

#pragma mark -- TableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray *arr = [_dataDic objectForKey:@"headTitleValue"];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60.0;
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
    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *arr = [_dataDic objectForKey:@"headTitleKey"];
    NSString *key = [arr objectAtIndex:indexPath.row];
    
    NSDictionary *leftData = [_dataDic objectForKey:@"leftTable"];
    NSMutableArray *leftDataArr = [NSMutableArray arrayWithArray:[leftData allKeys]];
    
    NSArray *sortArr = [DBDataHelper QuickSort:_dataDic andKeyArr:leftDataArr andSortKey:key StartIndex:0 EndIndex:arr.count];
    [_customTableView changeDataWithSortArr:sortArr];
    [_customTableView.leftTableView reloadData];
    [_customTableView.rightTableView reloadData];
    

}



@end
