//
//  BasicViewController.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-23.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "BasicViewController.h"
#import "UIColor+TPCategory.h"
//#import "NSString+TPCategory.h"
//#import "UIImage+TPCategory.h"
@interface BasicViewController (){
    AnimateLoadView *_loadView;
    AnimateErrorView *_errorView;
    AnimateErrorView *_successView;
}
@end


@implementation BasicViewController



-(void)dealloc{
    [super dealloc];
    if(_loadView){
        [_loadView release],_loadView=nil;
    }
    if(_errorView){
        [_errorView release],_errorView=nil;
    }
    if(_successView){
        [_successView release],_successView=nil;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
//    if (IOS7)
//    {
//        self.edgesForExtendedLayout = UIRectEdgeNone;               //视图控制器，四条边不指定
//        self.extendedLayoutIncludesOpaqueBars = YES;                 //不透明的操作栏
//        self.modalPresentationCapturesStatusBarAppearance = YES;
//        self.modalPresentationCapturesStatusBarAppearance = YES;
//        self.automaticallyAdjustsScrollViewInsets = YES;
//        self.navigationController.navigationBar.translucent = YES;
//        self.tabBarController.tabBar.translucent = YES;
//        
//    }
//    else
//    {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    }
//    
//    self.navigationController.navigationBar.translucent = NO;
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(version >= 7.0){
        
        UIImage *image =[UIImage imageNamed:@"navi.png"];
        image = [image stretchableImageWithLeftCapWidth:2 topCapHeight:20];
        
        
        //        UIImage *image = [UIImage imageNamed:@"navigationbar_background.png"];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
    }else if (version >= 5.0) {
        UIImage *image =[UIImage imageNamed:@"navi-320.jpg"];
//        image = [image stretchableImageWithLeftCapWidth:2 topCapHeight:20];
        
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }else{
        //调用这个方法，就会异步去调用DrawRac方法
        [self.navigationController.navigationBar setNeedsDisplay];
    }

    
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"navi" ofType:@"png"]] forBarMetrics:UIBarMetricsDefault];
    

    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 60, 30);
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goBackVC) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back" ofType:@"png"]] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    [rightBtn setTitle:@"日期" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(getSearchDate) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"date" ofType:@"png"]] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    _alertView = [[UIAlertView alloc] initWithTitle:@"很抱歉。。。" message:@"数据中暂时没有数据，敬请期待下一版本" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancle", nil];
}

- (void)goBackVC
{
    NSLog(@"返回");
    
    if ([self.navigationItem.title isEqualToString:@"海印百货通"]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
        
        //    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
    }
    
}

- (void)getSearchDate
{
    NSLog(@"********************************%@", self.navigationItem.title);
    
    if ([self.navigationItem.title isEqualToString:@"日期选择"]) {
        //[_rightItemBtn setTitle:@"确定"];
        //self.navigationItem.rightBarButtonItem = _rightItemBtn;
        [self showLoadingAnimatedWithTitle:@"正在重新获取数据，请稍等!"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"YES" forKey:@"isTimeChanged"];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [self hideLoadingSuccessWithTitle:@"日期更新成功，新的数据已加载，请您查看！" completed:nil];
    }
    else
    {
        
        JBViewController *JBVC = [[JBViewController alloc] init];
        [self.navigationController pushViewController:JBVC animated:YES];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 动画提示
-(AnimateErrorView*) errorView {
    
    if (!_errorView) {
        _errorView=[[AnimateErrorView alloc] initWithFrame:CGRectMake(0, -40, self.view.bounds.size.width, 40)];
        _errorView.backgroundColor=[UIColor redColor];
        [_errorView setErrorImage:[UIImage imageNamed:@"notice_error_icon.png"]];
    }
    return _errorView;
}

-(AnimateLoadView*) loadingView {
    if (!_loadView) {
        _loadView=[[AnimateLoadView alloc] initWithFrame:CGRectMake(0, -40, self.view.bounds.size.width, 40)];
    }
    return _loadView;
}
-(AnimateErrorView*) successView {
    if (!_successView) {
        _successView=[[AnimateErrorView alloc] initWithFrame:CGRectMake(0, -40, self.view.bounds.size.width, 40)];
        _successView.backgroundColor=[UIColor colorFromHexRGB:@"51c345"];
        [_successView setErrorImage:[UIImage imageNamed:@"notice_success_icon.png"]];
    }
    return _successView;
}
-(void) showLoadingAnimatedWithTitle:(NSString*)title{
    [self showLoadingAnimated:^(AnimateLoadView *errorView) {
        errorView.labelTitle.text=title;
    }];
}
-(void) showLoadingAnimated:(void (^)(AnimateLoadView *errorView))process{
    AnimateLoadView *loadingView = [self loadingView];
    if (process) {
        process(loadingView);
    }
    [self.view addSubview:loadingView];
    [self.view bringSubviewToFront:loadingView];
    [loadingView.activityIndicatorView startAnimating];
    CGRect r=loadingView.frame;
    r.origin.y=62;
    [UIView animateWithDuration:0.5f animations:^{
        loadingView.frame=r;
    }];
}

-(void) hideLoadingViewAnimated:(void (^)(AnimateLoadView *hideView))complete{
    
    AnimateLoadView *loadingView = [self loadingView];
    CGRect r=loadingView.frame;
    r.origin.y=-r.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        loadingView.frame=r;
    } completion:^(BOOL finished) {
        [loadingView.activityIndicatorView stopAnimating];
        [loadingView removeFromSuperview];
        if (complete) {
            complete(loadingView);
        }
    }];
}


-(void) showErrorViewAnimated:(void (^)(AnimateErrorView *errorView))process{
    AnimateErrorView *errorView = [self errorView];
    if (process) {
        process(errorView);
    }
    [self.view addSubview:errorView];
    [self.view bringSubviewToFront:errorView];
    CGRect r=errorView.frame;
    r.origin.y=2;
    [UIView animateWithDuration:0.5f animations:^{
        errorView.frame=r;
    }];
}
-(void) hideErrorViewAnimatedWithDuration:(NSTimeInterval)duration completed:(void (^)(AnimateErrorView *errorView))complete;{
    AnimateErrorView *errorView = [self errorView];
    CGRect r=errorView.frame;
    r.origin.y=-r.size.height;
    [UIView animateWithDuration:duration animations:^{
        errorView.frame=r;
    } completion:^(BOOL finished) {
        [errorView removeFromSuperview];
        if (complete) {
            complete(errorView);
        }
    }];
}
-(void) hideErrorViewAnimated:(void (^)(AnimateErrorView *errorView))complete{
    [self hideErrorViewAnimatedWithDuration:0.5f completed:complete];
}
-(void) showErrorViewWithHide:(void (^)(AnimateErrorView *errorView))process completed:(void (^)(AnimateErrorView *errorView))complete{
    [self showErrorViewAnimated:process];
    [self performSelector:@selector(hideErrorViewAnimated:) withObject:complete afterDelay:2.0f];
}
-(void) hideLoadingFailedWithTitle:(NSString*)title completed:(void (^)(AnimateErrorView *errorView))complete{
    [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
        [self showErrorViewWithHide:^(AnimateErrorView *errorView) {
            errorView.labelTitle.text=title;
        } completed:complete];
    }];
}
-(void) showSuccessViewAnimated:(void (^)(AnimateErrorView *errorView))process{
    AnimateErrorView *errorView = [self successView];
    if (process) {
        process(errorView);
    }
    [self.view addSubview:errorView];
    [self.view bringSubviewToFront:errorView];
    CGRect r=errorView.frame;
    r.origin.y=2;
    [UIView animateWithDuration:0.5f animations:^{
        errorView.frame=r;
    }];
}
-(void) hideSuccessViewAnimated:(void (^)(AnimateErrorView *errorView))complete{
    AnimateErrorView *errorView = [self successView];
    CGRect r=errorView.frame;
    r.origin.y=-r.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        errorView.frame=r;
    } completion:^(BOOL finished) {
        [errorView removeFromSuperview];
        if (complete) {
            complete(errorView);
        }
    }];
}
-(void) showSuccessViewWithHide:(void (^)(AnimateErrorView *errorView))process completed:(void (^)(AnimateErrorView *errorView))complete{
    [self showSuccessViewAnimated:process];
    [self performSelector:@selector(hideSuccessViewAnimated:) withObject:complete afterDelay:2.0f];
}
-(void) hideLoadingSuccessWithTitle:(NSString*)title completed:(void (^)(AnimateErrorView *errorView))complete{
    [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
        [self showSuccessViewAnimated:^(AnimateErrorView *errorView) {
            errorView.labelTitle.text=title;
        }];
        [self performSelector:@selector(hideSuccessViewAnimated:) withObject:complete afterDelay:2.0f];
    }];
}

@end
