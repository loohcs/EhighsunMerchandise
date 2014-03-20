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
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[SQLDataSearch SyncGetDataWith:@"WS_HighsunHome" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetHighsunHomeData" andParams:params andPageTitle:@"主页"]];
        [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
        
        self.dataDic = dic;
        self.pageTitle = @"主页";
    }

    
    self.navigationItem.title = @"主页";
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackSideTV)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"日期" style:UIBarButtonItemStyleDone target:self action:@selector(logOutSystem)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    NSArray *headArr = [NSArray arrayWithArray:[self.dataDic objectForKey:@"headTitleKey"]];
    NSMutableArray *leftKeys = [NSMutableArray arrayWithArray:[self.dataDic objectForKey:@"leftTable"]];
    NSDictionary *rightDic = [NSDictionary dictionaryWithDictionary:[self.dataDic objectForKey:@"rightTable"]];
    
    _customTableView = [[CustomTableView alloc] initWithHeadDataKeys:headArr andHeadDataTitle:@"主页" andLeftDataKeys:leftKeys andRightData:rightDic andSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-84) andScrollMethod:kScrollMethodWithRight];
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

//TODO: 中间按钮响应的方法
-(void)middleButtonAction
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"popover_background_os7@2x" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 100, 120)];
    imageView.image = image;
    [middleView setBackgroundView:imageView];
    
    UIButton *homePage = [UIButton buttonWithType:UIButtonTypeCustom];
    homePage.frame = CGRectMake(5, 20, 100, 20);
    homePage.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [homePage setTitle:@"按照时间排序" forState:UIControlStateNormal];
    [homePage addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:homePage];
    
    UIButton *eachOther = [UIButton buttonWithType:UIButtonTypeCustom];
    eachOther.frame = CGRectMake(5, 45, 100, 20);
    eachOther.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [eachOther setTitle:@"按照" forState:UIControlStateNormal];
    [eachOther addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:eachOther];
    
    UIButton *myWeibo = [UIButton buttonWithType:UIButtonTypeCustom];
    myWeibo.frame = CGRectMake(5, 70, 100, 20);
    myWeibo.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [myWeibo setTitle:@"我的微博" forState:UIControlStateNormal];
    [myWeibo addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:myWeibo];
    
    UIButton *aroundWeibo = [UIButton buttonWithType:UIButtonTypeCustom];
    aroundWeibo.frame = CGRectMake(5, 95, 100, 20);
    aroundWeibo.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [aroundWeibo setTitle:@"公共微博" forState:UIControlStateNormal];
    [aroundWeibo addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:aroundWeibo];
    
    
    //中间的弹出框与右边的弹出框相互斥
    if (middleFlag == 0 && flag == 0) {
        [self.view addSubview:middleView];
        middleView.hidden = NO;
        middleFlag = 1;
        flag = 1;
    }
    else
        if (middleFlag == 0 && flag == 1)
        {
            [rightView removeFromSuperview];
            rightFlag = 0;
            [self.view addSubview:middleView];
            middleView.hidden = NO;
            middleFlag = 1;
            
        }
        else
            if(middleFlag == 1)
            {
                [middleView removeFromSuperview];
                middleView.hidden = YES;
                middleFlag = 0;
                flag = 0;
            }
    
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


@end
