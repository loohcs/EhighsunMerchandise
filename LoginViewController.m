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
}


#pragma mark -- alertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%s", __func__);
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeVC];
    PPRevealSideViewController *revealSideVC = [[PPRevealSideViewController alloc] initWithRootViewController:homeNavi];
    [self presentViewController:revealSideVC animated:YES completion:nil];
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

@end
