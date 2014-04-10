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
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImage *bgImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg" ofType:@"png"]];
    _imageView.image = bgImage;
    [self.view addSubview:_imageView];

    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg" ofType:@"png"]]];
    
    self.size = [GetScreenSize getScreenSize:self.interfaceOrientation];
    
    _helper=[[ServiceHelper alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"default userID = %@", [defaults objectForKey:@"userID"]);
    NSLog(@"default passward = %@", [defaults objectForKey:@"passward"]);
    
    //用户名
//    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 100, 50, 30)];
//    nameLable.font = [UIFont systemFontOfSize:13];
//    nameLable.text = @"用户名:";
//    nameLable.backgroundColor = [UIColor cyanColor];
//    [self.view addSubview:nameLable];
    _userNameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT/2, 290, 40)];
    UIImage *nameImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"user" ofType:@"png"]];
    _userNameImageView.image = nameImage;
    _userNameImageView.userInteractionEnabled = YES;
    
    _nameText = [[UITextField alloc] initWithFrame:CGRectMake(60, 5, 200, 30)];
    _nameText.font = [UIFont systemFontOfSize:13];
    _nameText.placeholder = @"请输入用户名";
    _nameText.delegate = self;
    _nameText.userInteractionEnabled = YES;
    [_userNameImageView addSubview:_nameText];
    
    [self.view addSubview:_userNameImageView];

    //密码
//    UILabel *passwardLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 160, 50, 30)];
//    passwardLable.font = [UIFont systemFontOfSize:13];
//    passwardLable.text = @"密  码:";
//    passwardLable.backgroundColor = [UIColor cyanColor];
//    [self.view addSubview:passwardLable];
    
    _passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT/2+50, 290, 40)];
    UIImage *passwordImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"password" ofType:@"png"]];
    _passwordImageView.image = passwordImage;
    _passwordImageView.userInteractionEnabled = YES;
    
    _passwardText = [[UITextField alloc] initWithFrame:CGRectMake(60, 5, 200, 30)];
    _passwardText.font = [UIFont systemFontOfSize:13];
    _passwardText.placeholder = @"请输入您的密码";
    _passwardText.secureTextEntry = YES;
    _passwardText.delegate = self;
    _passwardText.userInteractionEnabled = YES;
    [_passwordImageView addSubview:_passwardText];
    [self.view addSubview:_passwordImageView];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _loginBtn.frame = CGRectMake(15, SCREEN_HEIGHT/2+100, 290, 40);
    [_loginBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"logIn" ofType:@"png"]]forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_loginBtn];
    
    _registePassword = [[UIImageView alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2+150, 30, 30)];
    if ([[defaults objectForKey:@"isRememberPassward"] isEqualToString:@"YES"]) {
        _registePassword.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"select" ofType:@"png"]];
        _passwardText.text = [defaults objectForKey:@"passward"];
        _nameText.text = [defaults objectForKey:@"userID"];
        _isRememberPassward = YES;
    }
    else
    {
        _registePassword.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"disSelect" ofType:@"png"]];
    }
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerBtnAction)];
    [_registePassword addGestureRecognizer:tapGR];
    _registePassword.userInteractionEnabled = YES;
    [self.view addSubview:_registePassword];
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _registerBtn.frame = CGRectMake(60, SCREEN_HEIGHT/2+150, 80, 30);
    [_registerBtn setTitle:@"记住密码" forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    if ([[defaults objectForKey:@"isAutoLogIn"] isEqualToString:@"YES"]) {
////        _registerBtn.backgroundColor = [UIColor cyanColor];
//        _passwardText.text = [defaults objectForKey:@"passward"];
//        _nameText.text = [defaults objectForKey:@"userID"];
//        _isAutoLogIn = YES;
//    }
    [self.view addSubview:_registerBtn];
    
    _autoLogIn = [[UIImageView alloc] initWithFrame:CGRectMake(160, SCREEN_HEIGHT/2+150, 30, 30)];
    if ([[defaults objectForKey:@"isAutoLogIn"] isEqualToString:@"YES"]) {
        _autoLogIn.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"select" ofType:@"png"]];
    }
    else
    {
        _autoLogIn.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"disSelect" ofType:@"png"]];
    }
    UITapGestureRecognizer *tapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(autoLogInAction)];
    [_autoLogIn addGestureRecognizer:tapGR2];
    _autoLogIn.userInteractionEnabled = YES;
    [self.view addSubview:_autoLogIn];
    
    _autoLogBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _autoLogBtn.frame = CGRectMake(190, SCREEN_HEIGHT/2+150, 80, 30);
    [_autoLogBtn setTitle:@"自动登录" forState:UIControlStateNormal];
    [_autoLogBtn addTarget:self action:@selector(autoLogInAction) forControlEvents:UIControlEventTouchUpInside];
    if ([[defaults objectForKey:@"isAutoLogIn"] isEqualToString:@"YES"]) {
        
    }
    [self.view addSubview:_autoLogBtn];
    
    [DateHelper getDateNow];
    
}


#pragma mark -- 屏幕中一些按钮的响应动作
//点击输入框，弹出键盘，同时将用户名，密码输入框上移
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _userNameImageView.frame = CGRectMake(15, SCREEN_HEIGHT/2-130, 290, 40);
    _passwordImageView.frame = CGRectMake(15, SCREEN_HEIGHT/2-80, 290, 40);
    _loginBtn.frame = CGRectMake(15, SCREEN_HEIGHT/2-30, 290, 40);
    _registerBtn.frame = CGRectMake(60, SCREEN_HEIGHT/2+20, 80, 30);
    _registePassword.frame = CGRectMake(30, SCREEN_HEIGHT/2+20, 30, 30);
    _autoLogBtn.frame = CGRectMake(190, SCREEN_HEIGHT/2+20, 80, 30);
    _autoLogIn.frame = CGRectMake(160, SCREEN_HEIGHT/2+20, 30, 30);
    
    _imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg2" ofType:@"jpg"]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _userNameImageView.frame = CGRectMake(15, SCREEN_HEIGHT/2, 290, 40);
    _passwordImageView.frame = CGRectMake(15, SCREEN_HEIGHT/2+50, 290, 40);
    _loginBtn.frame = CGRectMake(15, SCREEN_HEIGHT/2+100, 290, 40);
    _registerBtn.frame = CGRectMake(60, SCREEN_HEIGHT/2+150, 80, 30);
    _registePassword.frame = CGRectMake(30, SCREEN_HEIGHT/2+150, 30, 30);
    _autoLogBtn.frame = CGRectMake(190, SCREEN_HEIGHT/2+150, 80, 30);
    _autoLogIn.frame = CGRectMake(160, SCREEN_HEIGHT/2+150, 30, 30);
    
    _imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg" ofType:@"png"]];
}

//点击空白处回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

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
    
//#warning --park 进行加入合算表格的测试
//    FinalSumViewController *finalSumVC = [[FinalSumViewController alloc] init];
//    UINavigationController *finalSumNavi = [[UINavigationController alloc] initWithRootViewController:finalSumVC];
//    [self presentViewController:finalSumNavi animated:YES completion:^{
//        
//    }];
    
    
    //将用户名和密码以参数的形式传到服务器端，在服务器端监测是否是合法的用户名以及密码，合法返回字符串@“YES”，非法@“NO”
    //???: 在将用户名以及密码传送到服务器端时，是否应该加密？
    //如何进行加密，服务器端如何解密，这个是后期工作，现在以明文的方式传输
    
    BOOL isSuccessLog = [self isLogInDBWith:_userName andPassword:_passWard];
    
    if (isSuccessLog) {
        NSLog(@"登录成功！！！");
//        UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"登录成功" message:@"欢迎光临海印集团" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        successAlertView.tag = 100;
        
//        [successAlertView show];
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //TODO: 验证用户名与密码，如果成功则请求基础数据，否则提示输入错误
        if (self.isRememberPassward == YES) {
            //TODO: 进入记住密码状态，则需要将用户名与密码记录在本地数据中，方便下次登录
            
            if ([[defaults objectForKey:@"isRememberPassward"] isEqualToString:@"YES"]) {
                [defaults setObject:_nameText.text forKey:@"userID"];
                [defaults setObject:_passwardText.text forKey:@"passward"];
                [defaults setObject:@"VYbSBDuFOPVd" forKey:@"primaryUserKey"];
                
//                JBCalendarDate *JBCalDate = [JBCalendarDate dateFromNSDate:[NSDate date]];
//                NSString *date = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)JBCalDate.year, (long)JBCalDate.month, (long)JBCalDate.day];
//                [defaults setObject:date forKey:@"startTime"];
//                [defaults setObject:date forKey:@"endTime"];
                
            }
            
        }
        
#warning --mark 记录关键字，方便后面页面的数据请求
        [defaults setObject:@"VYbSBDuFOPVd" forKey:@"primaryUserKey"];
        
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeVC];
        
        //TODO: 加入侧滑栏
//        PPRevealSideViewController *revealSideVC = [[PPRevealSideViewController alloc] initWithRootViewController:homeNavi];
//        [self presentViewController:revealSideVC animated:YES completion:nil];
        
        //取消侧滑栏
        [self presentViewController:homeNavi animated:YES completion:nil];

        
        //跳转到主页，主要显示操作按钮，不需要请求数据
        /**(2)调用无参数的webservice**/
//        [self showLoadingAnimatedWithTitle:@"正在同步请求数据..."];
//
//        /********[--如果无法解析，请启用以下两句--]**********
//         NSString* xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
//         [result.xmlParse setDataSource:xml];
//         ****/
//
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
            [dic writeToFile:path atomically:YES];
        }
        else {
            [fileManager createFileAtPath:path contents:nil attributes:Nil];
            [dic writeToFile:path atomically:YES];
        }
       //NSLog(@"%@", dic);
        
        [self hideLoadingSuccessWithTitle:@"同步完成，获得数据!" completed:nil];
        
        
        
    }
    else
    {
        UIAlertView *failAlertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"您的用户名或密码输入错误，请检查之后重新登入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [failAlertView show];
        failAlertView.tag = 200;
        
        
//        MemberAnalyseViewController *memberVC = [[MemberAnalyseViewController alloc] init];
//        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:memberVC];
//        [self presentViewController:navi animated:YES completion:Nil];
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

- (void)registerBtnAction
{
    //通过isRemberPassward来判断是否需要记住密码
    //如果已经是记住密码了，点击时取消记住密码状态
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (_isRememberPassward) {
        _registePassword.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"disSelect" ofType:@"png"]];
        _isRememberPassward = NO;
        [defaults setObject:@"NO" forKey:@"isRememberPassward"];
    }
    //如果不是记住密码，则点击时进入记住密码状态
    else
    {
        //TODO: 进入记住密码状态，则需要将用户名与密码记录在本地数据中，方便下次登录
        
        [defaults setObject:@"YES" forKey:@"isRememberPassward"];
        _registePassword.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"select" ofType:@"png"]];
        _isRememberPassward = YES;
    }
    
}

- (void)autoLogInAction
{
    //通过isAutoLog来判断是否需要自动登录
    //如果已经是自动登录了，点击时取消自动登录状态
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (_isAutoLogIn) {
        _autoLogIn.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"disSelect" ofType:@"png"]];
        _isAutoLogIn = NO;
        [defaults setObject:@"NO" forKey:@"isAutoLogIn"];
    }
    //如果不是自动登录了，点击时启动自动登录状态
    else
    {
        //TODO: 进入自动登录了
        
        [defaults setObject:@"YES" forKey:@"isAutoLogIn"];
        _autoLogIn.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"select" ofType:@"png"]];
        _isAutoLogIn = YES;
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
