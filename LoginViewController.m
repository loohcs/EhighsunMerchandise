//
//  LoginViewController.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "LoginViewController.h"

#import "DBDataHelper.h"

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

#pragma mark -- 主要是一些按钮输入框的初始化，以及一些特定的属性初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.isRememberPassward = NO;
    
    self.navigationItem.title = @"欢迎进入海印百货通";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.size = [GetScreenSize getScreenSize:self.interfaceOrientation];
    
    _helper=[[ServiceHelper alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"default userID = %@", [defaults objectForKey:@"userID"]);
    NSLog(@"default passward = %@", [defaults objectForKey:@"passward"]);
    
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
    if ([[defaults objectForKey:@"isRememberPassward"] isEqualToString:@"YES"]) {
        registerBtn.backgroundColor = [UIColor cyanColor];
        _passwardText.text = [defaults objectForKey:@"passward"];
        _nameText.text = [defaults objectForKey:@"userID"];
        _isRememberPassward = YES;
    }
    [self.view addSubview:registerBtn];
    
    
    [DateHelper getDateNow];
    
}


#pragma mark -- 屏幕中一些按钮的响应动作
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
    [_nameText resignFirstResponder];
    [_passwardText resignFirstResponder];
    
    _userName = _nameText.text;
    _passWard = _passwardText.text;
    
    
    
    
    //将用户名和密码以参数的形式传到服务器端，在服务器端监测是否是合法的用户名以及密码，合法返回字符串@“YES”，非法@“NO”
    //???: 在将用户名以及密码传送到服务器端时，是否应该加密？
    //如何进行加密，服务器端如何解密，这个是后期工作，现在以明文的方式传输
    
    BOOL isSuccessLog = [self isLogInDBWith:_userName andPassword:_passWard];
    
    if (isSuccessLog) {
        NSLog(@"登录成功！！！");
//        UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"登录成功" message:@"欢迎光临海印集团" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        successAlertView.tag = 100;
        
//        [successAlertView show];
        
        //TODO: 验证用户名与密码，如果成功则请求基础数据，否则提示输入错误
        if (self.isRememberPassward == YES) {
            //TODO: 进入记住密码状态，则需要将用户名与密码记录在本地数据中，方便下次登录
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([[defaults objectForKey:@"isRememberPassward"] isEqualToString:@"YES"]) {
                [defaults setObject:_nameText.text forKey:@"userID"];
                [defaults setObject:_passwardText.text forKey:@"passward"];
                [defaults setObject:@"VYbSBDuFOPVd" forKey:@"primaryUserKey"];
                
                JBCalendarDate *JBCalDate = [JBCalendarDate dateFromNSDate:[NSDate date]];
                NSString *date = [NSString stringWithFormat:@"%ld-%ld-%ld", JBCalDate.year, JBCalDate.month, JBCalDate.day];
                [defaults setObject:date forKey:@"startTime"];
                [defaults setObject:date forKey:@"endTime"];
                
            }
        }
        
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeVC];
        PPRevealSideViewController *revealSideVC = [[PPRevealSideViewController alloc] initWithRootViewController:homeNavi];
        [self presentViewController:revealSideVC animated:YES completion:nil];

        //跳转到主页，主要显示操作按钮，不需要请求数据
        /**(2)调用无参数的webservice**/
//        [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
//
//        /********[--如果无法解析，请启用以下两句--]**********
//         NSString* xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
//         [result.xmlParse setDataSource:xml];
//         ****/
//        
//        ServiceArgs *args=[[ServiceArgs alloc] initWithWebServiceName:@"WS_ManaFrame" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"GetManaFrameData" andParams:Nil];
//        ServiceResult *result=[ServiceHelper syncService:args];
//        //    ServiceResult *result=[ServiceHelper syncMethodName:@"TestConnectOracle"];
//        NSLog(@"同步请求xml=%@\n",result);
//        NSLog(@"----------同步请求xml=%@\n",result.xmlString);
//        NSArray *arr=[result.xmlParse soapXmlSelectNodes:@"//ManaFrameData"];
//        NSLog(@"解析xml结果=%@\n",arr);
//        [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
        
        
        
    }
    else
    {
        UIAlertView *failAlertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"您的密码输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [failAlertView show];
        failAlertView.tag = 200;
    }
}

- (BOOL)isLogInDBWith:(NSString *)userID andPassword:(NSString *)password
{
    NSMutableArray *params = [[NSMutableArray alloc] init];
    
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userID", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:password,@"passWard", nil]];
    

    ServiceArgs *args1=[[ServiceArgs alloc] initWithWebServiceName:@"WS_LogIn" andServiceNameSpace:DefaultWebServiceNamespace andMethod:@"LogIn" andParams:params];

    
    NSLog(@"soap=%@\n",args1.soapMessage);
    ServiceResult *result=[ServiceHelper syncService:args1];
    NSLog(@"xml=%@\n",[result.request responseString]);
    NSArray *arr=[result.xmlParse childNodesToArray];
    NSLog(@"解析xml结果=%@\n",arr);
//    [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
    
    NSDictionary *dic = [arr lastObject];
    NSString *strTemp = [dic objectForKey:@"LogInResponse"];
    if ([strTemp isEqualToString:@"true"]) {
        return YES;
    }
    else{
        return NO;
    }
}

#pragma mark -- alertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"登录成功"]) {
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeVC];
        PPRevealSideViewController *revealSideVC = [[PPRevealSideViewController alloc] initWithRootViewController:homeNavi];
        [self presentViewController:revealSideVC animated:YES completion:nil];
    }
}

- (void)registerBtnAction:(UIButton *)sender
{
    //通过isRemberPassward来判断是否需要记住密码
    //如果已经是记住密码了，点击时取消记住密码状态
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (_isRememberPassward) {
        sender.backgroundColor = [UIColor clearColor];
        _isRememberPassward = NO;
        [defaults setObject:@"NO" forKey:@"isRememberPassward"];
    }
    //如果不是记住密码，则点击时进入记住密码状态
    else
    {
        //TODO: 进入记住密码状态，则需要将用户名与密码记录在本地数据中，方便下次登录
        
        [defaults setObject:@"YES" forKey:@"isRememberPassward"];
        
        sender.backgroundColor = [UIColor cyanColor];
        _isRememberPassward = YES;
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//TODO: 响应屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.size = [GetScreenSize getScreenSize:toInterfaceOrientation];
}



@end
