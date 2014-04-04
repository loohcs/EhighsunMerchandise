//
//  JBViewController.m
//  JBCalendar
//
//  Created by YongbinZhang on 7/9/13.
//  Copyright (c) 2013 YongbinZhang
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "JBViewController.h"

#import "JBCalendarLogic.h"

#import "JBUnitView.h"
#import "JBUnitGridView.h"

#import "JBSXRCUnitTileView.h"


@interface JBViewController () <JBUnitGridViewDelegate, JBUnitGridViewDataSource, JBUnitViewDelegate, JBUnitViewDataSource>

@property (nonatomic, retain) JBUnitView *unitView;
@property (nonatomic, retain) UITableView *tableView;

- (void)selectorForButton;

@end

@implementation JBViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.dateType = StartDateSelect;
    }
    
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SQLDataSearch getDateStr:_startTimeLabel.text andEndTime:_endTimeLabel.text];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_startTimeLabel.text forKey:@"startTime"];
    [defaults setObject:_endTimeLabel.text forKey:@"endTime"];
    [defaults setObject:@"YES" forKey:@"isTimeChanged"];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        
    [self.view setUserInteractionEnabled:YES];
    
    self.navigationItem.title = @"日期选择";
    
    JBCalendarDate *JBCalDate = [JBCalendarDate dateFromNSDate:[NSDate date]];
    NSLog(@"%ld-%ld-%ld", (long)JBCalDate.year, (long)JBCalDate.month, (long)JBCalDate.day);
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    //开始日期
    UIImageView *startImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT-180, 300, 40)];
    UIImage *startImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"startTime" ofType:@"png"]];
    startImageView.image = startImage;
    startImageView.userInteractionEnabled = YES;
    
    UILabel *startLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 40)];
    startLabel.backgroundColor = [UIColor clearColor];
    startLabel.text = @"开始日期:";
    [startImageView addSubview:startLabel];
    startLabel.userInteractionEnabled = YES;
    
    _startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 40)];
    _startTimeLabel.backgroundColor = [UIColor clearColor];
    _startTimeLabel.tag = 1000;
    _startTimeLabel.userInteractionEnabled = YES;
    NSString *startTime = [defaults objectForKey:@"startTime"];
    if (startTime != Nil) {
        _startTimeLabel.text = startTime;
        _startTimeLabel.textColor = [UIColor redColor];
    }
    else
    {
        _startTimeLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)JBCalDate.year, (long)JBCalDate.month, (long)JBCalDate.day];
        [defaults setObject:_startTimeLabel.text forKey:@"startTime"];
    }
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getTypeOfDate:)];
    [_startTimeLabel addGestureRecognizer:tapGR];

    [startImageView addSubview:_startTimeLabel];
    

    
    [self.view addSubview:startImageView];
    
    
    
    //截止日期
    UIImageView *endImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT-140, 300, 40)];
    UIImage *endImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"endTime" ofType:@"png"]];
    endImageView.image = endImage;
    endImageView.userInteractionEnabled = YES;
    
    UILabel *endLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 40)];
    endLabel.backgroundColor = [UIColor clearColor];
    endLabel.text = @"截止日期:";
    [endImageView addSubview:endLabel];
    
    _endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 40)];
    _endTimeLabel.tag = 1001;
    _endTimeLabel.userInteractionEnabled = YES;
    _endTimeLabel.backgroundColor = [UIColor clearColor];
    
    NSString *endTime = [defaults objectForKey:@"endTime"];
    if (endTime != Nil) {
        _endTimeLabel.text = endTime;
    }
    else
    {
        _endTimeLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)JBCalDate.year, (long)JBCalDate.month, (long)JBCalDate.day];
        [defaults setObject:_endTimeLabel.text forKey:@"endTime"];
    }
    UITapGestureRecognizer *tapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getTypeOfDate:)];
    [_endTimeLabel addGestureRecognizer:tapGR2];
    [endImageView addSubview:_endTimeLabel];
    [self.view addSubview:endImageView];
    
    //  Example 1.1:
    self.unitView = [[JBUnitView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) UnitType:UnitTypeMonth SelectedDate:[NSDate date] AlignmentRule:JBAlignmentRuleTop Delegate:self DataSource:self];
    self.unitView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.unitView];

    
}

//- (void)rightBtnDone
//{
//    NSLog(@"%@", _startTimeLabel.text);
//    NSLog(@"%@", _endTimeLabel.text);
//    
//    [SQLDataSearch getDateStr:_startTimeLabel.text andEndTime:_endTimeLabel.text];
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:_startTimeLabel.text forKey:@"startTime"];
//    [defaults setObject:_endTimeLabel.text forKey:@"endTime"];
//    [defaults setObject:@"YES" forKey:@"isTimeChanged"];
//    
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Class Extensions
- (void)selectorForButton
{
//    [self.unitView selectDate:[NSDate date]];
}

#pragma mark -
#pragma mark - JBUnitGridViewDelegate
/**************************************************************
 *@Description:获取当前UnitGridView中UnitTileView的高度
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:当前unitGridView中UnitTileView的高度
 **************************************************************/
- (CGFloat)heightOfUnitTileViewsInUnitGridView:(JBUnitGridView *)unitGridView
{
    return 46.0f;
}


/**************************************************************
 *@Description:获取当前UnitGridView中UnitTileView的宽度
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:当前UnitGridView中UnitTileView的宽度
 **************************************************************/
- (CGFloat)widthOfUnitTileViewsInUnitGridView:(JBUnitGridView *)unitGridView
{
    return 46.0f;
}


//  ------------选中了当前月份或周之外的时间--------------
/**************************************************************
 *@Description:选中了当前Unit的上一个Unit中的时间点
 *@Params:
 *  unitGridView:当前unitGridView
 *  date:选中的时间点
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView selectedOnPreviousUnitWithDate:(JBCalendarDate *)date
{
    
}

/**************************************************************
 *@Description:选中了当前Unit的下一个Unit中的时间点
 *@Params:
 *  unitGridView:当前unitGridView
 *  date:选中的时间点
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView selectedOnNextUnitWithDate:(JBCalendarDate *)date
{
    
}

#pragma mark -
#pragma mark - JBUnitGridViewDataSource
/**************************************************************
 *@Description:获得unitTileView
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:unitTileView
 **************************************************************/
- (JBUnitTileView *)unitTileViewInUnitGridView:(JBUnitGridView *)unitGridView
{
    return [[JBSXRCUnitTileView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 46.0f, 46.0f)];
}

/**************************************************************
 *@Description:设置unitGridView中的weekdaysBarView
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:weekdaysBarView
 **************************************************************/
- (UIView *)weekdaysBarViewInUnitGridView:(JBUnitGridView *)unitGridView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weekdaysBarView"]];
    return imageView;
}


/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件的数量
 *@Params:
 *  unitGridView:当前unitGridView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView NumberOfEventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSInteger eventCount))completedBlock
{
    completedBlock(calendarDate.day);
}

/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件
 *@Params:
 *  unitGridView:当前unitGridView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView EventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSArray *events))completedBlock
{
    completedBlock(nil);
}


#pragma mark -
#pragma mark - JBUnitViewDelegate
/**************************************************************
 *@Description:获取当前UnitView中UnitTileView的高度
 *@Params:
 *  unitView:当前unitView
 *@Return:当前UnitView中UnitTileView的高度
 **************************************************************/
- (CGFloat)heightOfUnitTileViewsInUnitView:(JBUnitView *)unitView
{
    return 46.0f;
}

/**************************************************************
 *@Description:获取当前UnitView中UnitTileView的宽度
 *@Params:
 *  unitView:当前unitView
 *@Return:当前UnitView中UnitTileView的宽度
 **************************************************************/
- (CGFloat)widthOfUnitTileViewsInUnitView:(JBUnitView *)unitView
{
    return 46.0f;
}


/**************************************************************
 *@Description:更新unitView的frame
 *@Params:
 *  unitView:当前unitView
 *  newFrame:新的frame
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView UpdatingFrameTo:(CGRect)newFrame
{
    //???: 因为存在导航栏和状态栏，日历的位置因此也向下移动了64，所以表格的位置也需要下移64
    self.tableView.frame = CGRectMake(0.0f, newFrame.size.height+64, self.view.bounds.size.width, self.view.bounds.size.height - newFrame.size.height);
}

/**************************************************************
 *@Description:重新设置unitView的frame
 *@Params:
 *  unitView:当前unitView
 *  newFrame:新的frame
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView UpdatedFrameTo:(CGRect)newFrame
{
    //NSLog(@"OK");
}

#pragma mark -
#pragma mark - JBUnitViewDataSource
/**************************************************************
 *@Description:获得unitTileView
 *@Params:
 *  unitView:当前unitView
 *@Return:unitTileView
 **************************************************************/
- (JBUnitTileView *)unitTileViewInUnitView:(JBUnitView *)unitView
{    
    return [[JBSXRCUnitTileView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 46.0f, 46.0f)];
}

/**************************************************************
 *@Description:设置unitView中的weekdayView
 *@Params:
 *  unitView:当前unitView
 *@Return:weekdayView
 **************************************************************/
- (UIView *)weekdaysBarViewInUnitView:(JBUnitView *)unitView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weekdaysBarView"]];
    return imageView;
}

/**************************************************************
 *@Description:选择某一天
 *@Params:
 *  unitView:当前unitView
 *  date:选择的日期
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView SelectedDate:(NSDate *)date
{
    JBCalendarDate *JBCalDate = [JBCalendarDate dateFromNSDate:date];
    NSLog(@"JBCalDate: %@", JBCalDate);

//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
//    NSDate *startTime = [formatter dateFromString:_startTimeLabel.text];
//    NSDate *endTime = [formatter dateFromString:_endTimeLabel.text];
//    NSLog(@"%@", endTime);
//    NSLog(@"--%@", _startTimeLabel.text);
    
    NSArray *startTimeArr = [[NSArray alloc] initWithArray:[_startTimeLabel.text componentsSeparatedByString:@"-"]];
    NSLog(@"startTimeArr:%@", startTimeArr);
    
    NSArray *endTimeArr = [[NSArray alloc] initWithArray:[_endTimeLabel.text componentsSeparatedByString:@"-"]];
    NSLog(@"endTimeArr:%@", endTimeArr);
    
    JBCalendarDate *JBCalEndTime = [JBCalendarDate dateWithYear:[[endTimeArr objectAtIndex:0] integerValue]
                                                          Month:[[endTimeArr objectAtIndex:1] integerValue]
                                                            Day:[[endTimeArr objectAtIndex:2] integerValue]];
    NSLog(@"EndTime:%@", JBCalEndTime);
    JBCalendarDate *JBCalStartTime = [JBCalendarDate dateWithYear:[[startTimeArr objectAtIndex:0] integerValue]
                                                            Month:[[startTimeArr objectAtIndex:1] integerValue]
                                                              Day:[[startTimeArr objectAtIndex:2] integerValue]];
    NSLog(@"StartTime:%@", JBCalStartTime);
    
//    JBCalendarDate *JBCalEndTime = [JBCalendarDate dateFromNSDate:endTime];
//    NSLog(@"EndTime:%@", JBCalEndTime);
//    JBCalendarDate *JBCalStartTime = [JBCalendarDate dateFromNSDate:startTime];
//    NSLog(@"StartTime:%@", JBCalStartTime);
    
    if ([JBCalDate compare:JBCalEndTime] == NSOrderedSame) {
        
    }
    
//    NSDate *isEndTime = [date laterDate:endTime];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //TODO: 加入日期判断，使截止日期大于初始日期，且小于今天
    if (_dateType == StartDateSelect) {
        
        
        if ([JBCalDate compare:JBCalEndTime] == NSOrderedAscending || [JBCalDate compare:JBCalEndTime] == NSOrderedSame) {
            
#warning -- mark 
            
            
            
            _startTimeLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)JBCalDate.year, (long)JBCalDate.month, (long)JBCalDate.day];
            [defaults setObject:_startTimeLabel.text forKey:@"startTime"];
        }
        
        NSLog(@"-----startTime-------%@", _startTimeLabel.text);
        NSLog(@"--------date------%@", JBCalDate);
        
    }
    else if (_dateType == EndDateSelect)
    {
        if ([JBCalDate compare:JBCalStartTime] == NSOrderedDescending && ([JBCalDate compare:[JBCalendarDate dateFromNSDate:[NSDate date]]] == NSOrderedAscending || [JBCalDate compare:[JBCalendarDate dateFromNSDate:[NSDate date]]] == NSOrderedSame)) {
            _endTimeLabel.text = [NSString stringWithFormat:@"%lu-%lu-%lu", (unsigned long)JBCalDate.year, (unsigned long)JBCalDate.month, (unsigned long)JBCalDate.day];
            
            [defaults setObject:_endTimeLabel.text forKey:@"endTime"];
            
            NSLog(@"-----endTime-------%@", _endTimeLabel.text);
            NSLog(@"--------date------%@", JBCalDate);
        }
        
    }
    
    
    
    //_startTimeLabel.text = [NSString stringWithFormat:@"%lu-%lu-%lu", (unsigned long)date.year, (unsigned long)date.month, (unsigned long)date.day];
}


- (void)getTypeOfDate:(UITapGestureRecognizer *)tapGR
{
    if (tapGR.view.tag == 1000) {
        _dateType = StartDateSelect;
        
        _startTimeLabel.textColor = [UIColor redColor];
        _endTimeLabel.textColor = [UIColor blackColor];
    }
    else if(tapGR.view.tag == 1001)
    {
        _dateType = EndDateSelect;
        
        _startTimeLabel.textColor = [UIColor blackColor];
        _endTimeLabel.textColor = [UIColor redColor];
    }
}

/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件的数量
 *@Params:
 *  unitView:当前unitView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView NumberOfEventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSInteger eventCount))completedBlock
{
    completedBlock(calendarDate.day);
}

/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件
 *@Params:
 *  unitView:当前unitView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView EventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSArray *events))completedBlock
{
    completedBlock(nil);
}



@end
