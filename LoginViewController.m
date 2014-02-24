//
//  LoginViewController.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "LoginViewController.h"



@interface LoginViewController ()

@end

@implementation LoginViewController

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
	// Do any additional setup after loading the view.
    self.isRememberPassward = NO;
    
    self.navigationItem.title = @"欢迎进入海印百货通";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.size = [GetScreenSize getScreenSize:self.interfaceOrientation];
    
    _helper=[[ServiceHelper alloc] init];
    
    //用户名
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 100, 50, 30)];
    nameLable.font = [UIFont systemFontOfSize:13];
    nameLable.text = @"用户名:";
    nameLable.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:nameLable];
    
    _nameText = [[UITextField alloc] initWithFrame:CGRectMake(120, 100, 150, 30)];
    _nameText.font = [UIFont systemFontOfSize:13];
    _nameText.backgroundColor = [UIColor cyanColor];
    _nameText.delegate = self;
    [self.view addSubview:_nameText];

    //密码
    UILabel *passwardLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 160, 50, 30)];
    passwardLable.font = [UIFont systemFontOfSize:13];
    passwardLable.text = @"密  码:";
    passwardLable.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:passwardLable];
    
    
    _passwardText = [[UITextField alloc] initWithFrame:CGRectMake(120, 160, 150, 30)];
    _passwardText.font = [UIFont systemFontOfSize:13];
    _passwardText.backgroundColor = [UIColor cyanColor];
    _passwardText.secureTextEntry = YES;
    _passwardText.delegate = self;
    [self.view addSubview:_passwardText];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake(60, 220, 50, 30);
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginBtn];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    registerBtn.frame = CGRectMake(120, 220, 80, 30);
    [registerBtn setTitle:@"记住密码" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
}


//点击空白处回收键盘
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    [super touchesBegan:touches withEvent:event];
    [_nameText resignFirstResponder];
    [_passwardText resignFirstResponder];
}

//点击回车键回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)loginBtnAction
{
    NSLog(@"登陆！！！");
    //TODO: 验证用户名与密码，如果成功则请求基础数据，否则提示输入错误
    _userName = _nameText.text;
    _passWard = _passwardText.text;
    
    if (_userName&&_passWard) {
        NSLog(@"登录成功！！！");
        UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"登录成功" message:@"欢迎光临海印集团" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        successAlertView.tag = 100;
        [successAlertView show];
    }
    else
    {
        UIAlertView *failAlertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"您的密码输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [failAlertView show];
        failAlertView.tag = 200;
    }
    
    
    NSLog(@"----------Test Connet WebService Success!");
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.3.7:8000/WebServices/WS_VipMember.asmx?op=Test"]];
//    [webView loadRequest:request];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"WS_VipMember",@"WS_Name", @"TestTemp",@"Method_Name", nil];
    NSURL *url = [URLHelper getUrlWithString:HOST_HTTP andArgument:dic];
    NSLog(@"-----------%@", url);
    NSURLRequest *requestTest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestTest];
    
    webView.delegate = self;
    [self.view addSubview:webView];
    
    [NSURLConnection connectionWithRequest:requestTest delegate:self];
    
    
//    WebServiceHelper* service = [[WebServiceHelper alloc]initWebService:@"login"];
//    [service addParameterForString:@"username" value:_userName];
//    [service addParameterForString:@"password" value:_passWard];
//    service.delegate = self;
//    [service startASynchronous];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

//-(void)requestFinished:(WebServiceHelper *)request
//{
//    NSString* result = [request getSimpleResult];
//    NSArray *array = [result componentsSeparatedByString:@"{h}"];
//    NSString* code = [array objectAtIndex:0];
//    if(code.intValue == 1)
//    {
////        NSString* userinfo = [array objectAtIndex:1];
////        UserModel* model = [[UserModel alloc]initWithXmlData:userinfo];
////        [AppManager sharedManager].currentUserModel = model;
////        [model release];
////        [WToast showWithText:@"登陆成功！"];
////        [LoginController hideLoginController];
//        
//        NSLog(@"登录成功");
//        
//    }
//    else if(code.intValue == -1)
//    {
////        [WToast showWithText:@"请核对账号密码后登陆。"];
//        
//        NSLog(@"请核对账号密码后登陆。");
//    }
//    else {
////        [WToast showWithText:@"系统繁忙！请稍后登陆。"];
//        
//        NSLog(@"系统繁忙！请稍后登陆。");
//    }
//}
//
//
//-(void)requestFailed:(WebServiceHelper *)request
//{
////    [WToast showWithText:@"系统繁忙！请稍后登陆。"];
//    NSLog(@"%@",request.error.debugDescription);
//    
//}


#pragma mark -- WebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"+++++++++");
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


#pragma mark -- alertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%s", __func__);
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeVC];
    PPRevealSideViewController *revealSideVC = [[PPRevealSideViewController alloc] initWithRootViewController:homeNavi];
    //[self presentViewController:revealSideVC animated:YES completion:nil];
}

- (void)registerBtnAction:(UIButton *)sender
{
    NSLog(@"记住密码！！！");
    
    //通过isRemberPassward来判断是否需要记住密码
    //如果已经是记住密码了，点击时取消记住密码状态
    if (_isRememberPassward) {
        sender.backgroundColor = [UIColor clearColor];
        _isRememberPassward = NO;
    }
    //如果不是记住密码，则点击时进入记住密码状态
    else
    {
        //TODO: 进入记住密码状态，则需要将用户名与密码记录在本地数据中，方便下次登录
        sender.backgroundColor = [UIColor cyanColor];
        _isRememberPassward = YES;
    }
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
    self.size = [GetScreenSize getScreenSize:toInterfaceOrientation];
}


//同步请求
- (void)SyncClick:(id)sender {
    /**(1)调用其它的webservice并有参数**
     NSMutableArray *params=[NSMutableArray array];
     [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"道道香食府",@"userName", nil]];
     [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"123456",@"passWord", nil]];
     ServiceArgs *args1=[[[ServiceArgs alloc] init] autorelease];
     args1.serviceURL=@"http://117.27.136.236:9000/WebServer/Phone/PHoneWebServer.asmx";
     args1.serviceNameSpace=@"http://www.race.net.cn";
     args1.methodName=@"EnterpriseLogin";
     args1.soapParams=params;
     NSLog(@"soap=%@\n",args1.soapMessage);
     ServiceResult *result=[ServiceHelper syncService:args1];
     NSLog(@"xml=%@\n",[result.request responseString]);
     ***/
    
    /**(2)调用无参数的webservice**/
    [self showLoadingAnimatedWithTitle:@"正在同步..."];
    ServiceResult *result=[ServiceHelper syncMethodName:@"TestConnectOracle"];
    NSLog(@"同步请求xml=%@\n",result);
    NSLog(@"----------同步请求xml=%@\n",result.xmlString);
    /********[--如果无法解析，请启用以下两句--]**********
     NSString* xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
     [result.xmlParse setDataSource:xml];
     ****/
    NSArray *arr=[result.xmlParse soapXmlSelectNodes:@"//Test"];
    NSLog(@"解析xml结果=%@\n",arr);
    [self hideLoadingSuccessWithTitle:@"同步完成!" completed:nil];
    
}
//异步请求deletegated
- (void)asyncDelegatedClick:(id)sender {
    [self showLoadingAnimatedWithTitle:@"正在执行异步请求deletegated,请稍等..."];
    [_helper asynServiceMethodName:@"getForexRmbRate" delegate:self];
}
//异步请求block
- (void)asyncBlockClick:(id)sender {
    NSLog(@"异步请求block\n");
    [self showLoadingAnimatedWithTitle:@"正在执行异步block请求,请稍等..."];
    [_helper asynServiceMethodName:@"getForexRmbRate" success:^(ServiceResult *result) {
        BOOL boo=strlen([result.xmlString UTF8String])>0?YES:NO;
        if (boo) {
            [self hideLoadingSuccessWithTitle:@"block请求成功!" completed:nil];
        }else{
            [self hideLoadingFailedWithTitle:@"block请求失败!" completed:nil];
        }
        NSArray *arr=[result.xmlParse soapXmlSelectNodes:@"//ForexRmbRate"];
        NSLog(@"解析xml结果=%@\n",arr);
        
        
        
    } failed:^(NSError *error, NSDictionary *userInfo) {
        NSLog(@"error=%@\n",[error description]);
        [self hideLoadingFailedWithTitle:@"block请求失败!" completed:nil];
    }];
}
//队列请求
- (void)queueClick:(id)sender {
    ServiceHelper *helper=[ServiceHelper sharedInstance];
    
    
    
    //添加队列1
    ASIHTTPRequest *request1=[ServiceHelper commonSharedRequest:[ServiceArgs serviceMethodName:@"getForexRmbRate"]];
    [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"request1",@"name", nil]];
    [helper addQueue:request1];
    //添加队列2
    ServiceArgs *args1=[[ServiceArgs alloc] init];
    args1.serviceURL=@"http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx";
    args1.serviceNameSpace=@"http://WebXml.com.cn/";
    args1.methodName=@"getDatabaseInfo";
    ASIHTTPRequest *request2=[ServiceHelper commonSharedRequest:args1];
    [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"request2",@"name", nil]];
    [helper addQueue:request2];
    
    [self showLoadingAnimatedWithTitle:@"正在执行队列请求,请稍等..."];
    //执行队列
    [helper startQueue:^(ServiceResult *result) {
        NSString *name=[result.userInfo objectForKey:@"name"];
        NSLog(@"%@请求成功，xml=%@",name,result.xmlString);
    } failed:^(NSError *error, NSDictionary *userInfo) {
        NSString *name=[userInfo objectForKey:@"name"];
        NSLog(@"%@请求失败，失败原因:%@",name,[error description]);
    } complete:^(NSArray *results) {
        NSLog(@"排队列请求完成！\n");
        [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
            [self showSuccessViewWithHide:^(AnimateErrorView *errorView) {
                errorView.labelTitle.text=@"排队列请求完成！";
            } completed:nil];
        }];
    }];
}
#pragma mark -
#pragma mark ServiceHelperDelegate Methods
-(void)finishSoapRequest:(ServiceResult*)result{
    
    NSArray *arr=[result.xmlParse soapXmlSelectNodes:@"//TestTemp"];
    NSLog(@"解析xml结果=%@\n",arr);
    BOOL boo=strlen([result.xmlString UTF8String])>0?YES:NO;
    if (boo) {
        [self hideLoadingSuccessWithTitle:@"deletegated请求成功!" completed:nil];
    }else{
        [self hideLoadingFailedWithTitle:@"deletegated请求失败!" completed:nil];
    }
}
-(void)failedSoapRequest:(NSError*)error userInfo:(NSDictionary*)dic{
    NSLog(@"error=%@\n",[error description]);
    [self hideLoadingFailedWithTitle:@"deletegated请求失败!" completed:nil];
}

@end
