//
//  FinalSumViewController.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "FinalSumViewController.h"

@interface FinalSumViewController ()

@end

@implementation FinalSumViewController

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
    
    self.navigationItem.title = @"结算汇总";
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackSideTV)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:@selector(logOutSystem)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    NSMutableArray *headKeys = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *leftKeys = [NSMutableArray arrayWithCapacity:0];
    
    headKeys = [NSMutableArray arrayWithArray:[SQLDataSearch getTitle:@"结算汇总"]];
    
    for (int i = 0; i < 50; i++) {
        NSString *key = [NSString stringWithFormat:@"test_%d", i];
        
        //添加左边tableView的数据的key
        [leftKeys addObject:key];
    }
    
    
    NSMutableArray *dArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 50; i ++) {
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithCapacity:0];
//        for (NSString *key in headKeys) {
//            [data setValue:[NSString stringWithFormat:@"%@ %d", key, i] forKey:key];
//        }
        for (int j = 0; j < headKeys.count; j++) {
            NSString *key = [headKeys objectAtIndex:j];
            [data setValue:[NSString stringWithFormat:@"%@ %d-%d", key, i, j] forKey:key];
        }

        [dArray addObject:data];
    }
    
    _customTableView = [[CustomTableView alloc] initWithData:dArray size:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-84) scrollMethod:kScrollMethodWithRight leftDataKeys:leftKeys headDataKeys:headKeys];
    CGRect frame = _customTableView.frame;
    frame.origin = CGPointMake(0, 84);
    _customTableView.frame = frame;
    [self.view addSubview:_customTableView];
}

//TODO: 导航栏上左右两边的动作响应
- (void)goBackSideTV
{
    NSLog(@"返回");
    
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

- (void)logOutSystem
{
    NSLog(@"退出");
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

@end
