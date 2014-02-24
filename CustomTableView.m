//
//  CustomTableView.m
//  Custom
//
//  Created by tan on 13-1-22.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import "CustomTableView.h"

@implementation CustomTableView

@synthesize leftScrollView = _leftScrollView;
@synthesize leftTableView = _leftTableView;
@synthesize rightScrollView = _rightScrollView;
@synthesize rightTableView = _rightTableView;
@synthesize dataArray = _dataArray;
@synthesize trDictionary = _trDictionary;
@synthesize leftDataKeys = _leftDataKeys;
@synthesize rightDataKeys = _rightDataKeys;


- (id)initWithData:(NSArray *)dArray size:(CGSize)size scrollMethod:(ScrollMethod)sm leftDataKeys:(NSArray *)leftDataKeys headDataKeys:(NSArray *)headDataKeys{
    if (self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)]) {
        //data
        self.dataArray = [NSArray arrayWithArray:dArray];//存放所有的数据
        
        //存放左边的数据，同时也是关键字，我们将通过左边的关键字，在dataArray中查找出同一行中右边的数据
        self.leftDataKeys = [NSArray arrayWithArray:leftDataKeys];
        
        //存放表头的文字信息，如果有必要，我们也将通过表头的关键字，查找这一列的所有数据
        self.headDataKeys = [NSArray arrayWithArray:headDataKeys];
        
        self.size = size;
        float leftWidth = 0;//左边tableview的宽度
        float rightWidth = 0;//右边tableview的宽度

        leftWidth = kTableViewTitleWidth;
        
        for (NSString *trKey in _headDataKeys) {
            rightWidth += kTableViewTitleWidth;
        }
        
        //因为在_headDataKeys 中包括第一列的title，所以我们在计算完成之后需要减去一个width
        rightWidth -= kTableViewTitleWidth;
        
        //scrollview
        float leftScrollWidth = 0;
        float rightScrollWidth = 0;
        @try {
            if (sm == kScrollMethodWithLeft) {
                if (rightWidth > size.width) {
                    @throw [NSException exceptionWithName:@"width small" reason:@"" userInfo:nil];
                }
                rightScrollWidth = rightWidth;
                leftScrollWidth = size.width - rightScrollWidth;
            } else if (sm == kScrollMethodWithRight) {
                if (leftWidth > size.width) {
                    @throw [NSException exceptionWithName:@"width small" reason:@"" userInfo:nil];
                }
                leftScrollWidth = leftWidth;
                rightScrollWidth = size.width - leftScrollWidth;
            } else {
                leftScrollWidth = rightScrollWidth = size.width / 2.0 ;
            }
        }
        @catch (NSException *exception) {
            NSLog(@"ERROR:%@", exception.name);
            NSAssert(false, @"width small");
        }
        
        //TODO: 建立3种tableView，以及2个scrollView
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -20, kTableViewTitleWidth, kTableViewTitleHeight)];
        titleLabel.backgroundColor = [UIColor yellowColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = [_headDataKeys objectAtIndex:0];
        titleLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:titleLabel];
        
        //表头的tableView，通过普通的tableView旋转90度之后得到的横向tableView
        UITableView *headTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kTableViewTitleWidth, rightScrollWidth)];
        headTableView.delegate = self;
        headTableView.dataSource = self;
        [headTableView.layer setAnchorPoint:CGPointMake(0.0, 0.0)];
        headTableView.transform = CGAffineTransformMakeRotation(M_PI/-2);//旋转90度
        headTableView.frame = CGRectMake(kTableViewTitleWidth, 0, rightWidth, kTableViewTitleHeight);
        self.headTableView = headTableView;
        [headTableView release];
        

        //scrollView 主要用来承载tableView，使左边和右边的tableView可以正常滑动
        UIScrollView *leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, leftScrollWidth, size.height)];
        [leftScrollView setShowsHorizontalScrollIndicator:FALSE];
        [leftScrollView setShowsVerticalScrollIndicator:FALSE];
        self.leftScrollView = leftScrollView;
        [leftScrollView release];
        
        UIScrollView *rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(leftScrollWidth, 0, rightScrollWidth, size.height)];
        [rightScrollView setShowsHorizontalScrollIndicator:FALSE];
        [rightScrollView setShowsVerticalScrollIndicator:FALSE];
        rightScrollView.delegate = self;
        self.rightScrollView = rightScrollView;
        [rightScrollView release];
        
        //tableView
        UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, size.height)];
        leftTableView.delegate = self;
        leftTableView.dataSource = self;
        [leftTableView setShowsHorizontalScrollIndicator:NO];
        [leftTableView setShowsVerticalScrollIndicator:NO];
        self.leftTableView = leftTableView;
        [leftTableView release];
        
        UITableView *rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, rightWidth, size.height)];
        rightTableView.delegate = self;
        rightTableView.dataSource = self;
        [rightTableView setShowsHorizontalScrollIndicator:NO];
        [rightTableView setShowsVerticalScrollIndicator:NO];
        self.rightTableView = rightTableView;
        [rightTableView release];

        [self.leftScrollView addSubview:_leftTableView];
        [self.leftScrollView setContentSize:_leftTableView.frame.size];
        
        [self.rightScrollView addSubview:_rightTableView];
        [self.rightScrollView setContentSize:_rightTableView.frame.size];
        self.rightScrollView.bounces = NO;
        
        self.headTableView.showsVerticalScrollIndicator = NO;
        self.headTableView.bounces = NO;
        
        [self addSubview:_leftScrollView];
        [self addSubview:_rightScrollView];
        [self addSubview:_headTableView];
    }
    return self;
}

- (void)dealloc {
    [_headTableView release];
    [_leftTableView release];
    [_leftScrollView release];
    [_rightTableView release];
    [_rightScrollView release];
    [_dataArray release];
    [_trDictionary release];
    [_leftDataKeys release];
    [_rightDataKeys release];
    [super dealloc];
}

#pragma mark - Custom TableView Content

- (UIView *)viewWithLeftContent:(NSInteger)index {
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, _leftTableView.frame.size.width, kTableViewCellHeight)] autorelease];
    view.backgroundColor = [UIColor cyanColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kTableViewTitleWidth, kTableViewCellHeight)];
            label.contentMode = UIViewContentModeCenter;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [_leftDataKeys objectAtIndex:index];
            label.font = [UIFont systemFontOfSize:10.0];
            [view addSubview:label];
            [label release];
    
    return view;
}

- (UIView *)viewWithRightContent:(NSInteger)index {
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, _rightTableView.frame.size.width, kTableViewCellHeight)] autorelease];
    NSDictionary *rowDict = [_dataArray objectAtIndex:index];
    @try {
        float x = 0.0;
        for (int i = 1; i < _headDataKeys.count; i++) {
            
            NSString *key = [_headDataKeys objectAtIndex:i];
            NSString *value = [rowDict objectForKey:key];
            
            // TODO: 初始化内部label 可以自定义
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, kTableViewTitleWidth, kTableViewCellHeight)];
            label.contentMode = UIViewContentModeCenter;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = value;
            label.font = [UIFont systemFontOfSize:10.0];
            [view addSubview:label];
            [label release];
            
            x += kTableViewTitleWidth;
        }
    }
    @catch (NSException *exception) {
        
    }
    return view;
}

- (UIView *)viewWithHeadContent:(NSInteger)index
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, kTableViewTitleWidth, kTableViewTitleHeight)] autorelease];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kTableViewTitleWidth, kTableViewTitleHeight)];
    label.backgroundColor = [UIColor redColor];
    @try {
        NSString *title = [self.headDataKeys objectAtIndex:index+1];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.userInteractionEnabled = YES;
        [view addSubview:label];
        view.userInteractionEnabled = YES;
        [label release];
    }
    @catch (NSException *exception) {
        
    }
    @finally {

    }

    return view;
}

#pragma mark - TableView DataSource Methods

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: SimpleTableIdentifier] autorelease];
    }
    
    //通过判断tableView来添加各自对应的view
    UIView *view;
    if ([tableView isEqual:_leftTableView]) {
        view = [self viewWithLeftContent:indexPath.row];
    }
    else if([tableView isEqual:_rightTableView]){
        view = [self viewWithRightContent:indexPath.row];
    }
    else if([tableView isEqual:_headTableView])
    {
        view = [self viewWithHeadContent:indexPath.row];
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    
    //释放每一行中的view，避免内存浪费
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    
    [cell.contentView addSubview:view];
    CGRect frame = cell.frame;
    frame.size = view.frame.size;
    cell.frame = frame;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    @try {
        if ([tableView isEqual:_headTableView ]||[tableView isEqual:_rightDataKeys]) {
            return _headDataKeys.count-1;
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

    return _dataArray.count;
}

#pragma mark - TableView Delegate Methods


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    @try {
        if ([tableView isEqual:_headTableView]) {
            return kTableViewTitleWidth;
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    return kTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_leftTableView]) {
        
        //TODO: 实现在点击左边表单的单行表格时，需要执行跳转的页面
        NSLog(@"选择了左边的表单第%d行", indexPath.row+1);
        
        [self.rightTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else if([tableView isEqual:_rightTableView]){
        [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else if([tableView isEqual:_headTableView])
    {
        [self.headTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //确定三个tableView在移动时候各自的关系
    if ([scrollView isEqual:_leftTableView]) {
        //在左边的leftTableView在上下移动的时候，同时会带动右边的rightTableView的移动
        self.rightTableView.contentOffset = _leftTableView.contentOffset;
        
        //在右边rightTableView移动的时候，上方headTableView需要保持与右边的tableView位置的一致，此时_rightScrollView.contentOffset.x=0
        self.headTableView.contentOffset = CGPointMake(0, _rightScrollView.contentOffset.x);
    }
    else {
        //在右边rightTableView在左右移动的时候，同时headTableView也需要出现左右移动的效果，但是headTableView实际是初始的tableView旋转了90度之后得到的，因此要左右滑动，实际上是上下移动
        self.headTableView.contentOffset = CGPointMake(0, _rightScrollView.contentOffset.x);
        self.leftTableView.contentOffset = _rightTableView.contentOffset;
    }
}

- (void)fitWithScreenRotation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //根据方向的不同，首先获得屏幕大小，然后根据大小重新定义页面中的所有view.fram
    self.size = [GetScreenSize getScreenSize:toInterfaceOrientation];
    
    self.frame = CGRectMake(0, 0, self.size.width, self.size.height);
    CGRect frame = self.frame;
    frame.origin = CGPointMake(0, 84);
    self.frame = frame;
    
    self.leftScrollView.frame = CGRectMake(0, 0, kTableViewTitleWidth, self.size.height-20-44-20);
    self.leftScrollView.contentSize = CGSizeMake(self.leftScrollView.contentSize.width, self.size.height-20-44-20);
    self.rightScrollView.frame = CGRectMake(kTableViewTitleWidth, 0, self.size.width-kTableViewTitleWidth, self.size.height-20-44-20);
    self.rightScrollView.contentSize = CGSizeMake(self.rightScrollView.contentSize.width, self.size.height-20-44-20);
    
    self.leftTableView.frame = CGRectMake(0, 0, self.size.width, self.size.height-20-44-20);
    
    self.rightTableView.frame = CGRectMake(0, 0, self.rightScrollView.contentSize.width, self.size.height-20-44-20);
    
    
    self.headTableView.frame = CGRectMake(kTableViewTitleWidth, 0, self.rightScrollView.contentSize.width, kTableViewTitleHeight);
    
    
}

@end
