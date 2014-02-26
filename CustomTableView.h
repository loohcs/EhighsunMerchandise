//
//  CustomTableView.h
//  Custom
//
//  Created by tan on 13-1-22.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kScrollMethodWithLeft = 0,//左边滚动
    kScrollMethodWithRight,//右边滚动
    kScrollMethodWithAll
}ScrollMethod;

#define kTableViewCellHeight 40.0
#define kTableViewTitleWidth 60.0
#define kTableViewTitleHeight 20.0

@interface CustomTableView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *headTableView;
@property (nonatomic, retain) UITableView *leftTableView;
@property (nonatomic, retain) UITableView *rightTableView;
@property (nonatomic, retain) UIScrollView *leftScrollView;
@property (nonatomic, retain) UIScrollView *rightScrollView;
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSDictionary *trDictionary;
@property (nonatomic, retain) NSArray *leftDataKeys;
@property (nonatomic, retain) NSArray *rightDataKeys;
@property (nonatomic, retain) NSArray *headDataKeys;

@property (nonatomic, assign) CGFloat startDragContentOffsetX;
@property (nonatomic, assign) CGFloat endDragContentOffsetX;

@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) CGPoint presentPoint;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) NSDictionary *rightDataDic;

//传递的leftDataKeys rightDataKeys我们是经过了判断的，他们每个长度不能在kScrollMethodWithLeft 和 kScrollMethodWithRight模式下不能越界,具体参看代码
- (id)initWithData:(NSArray *)dArray size:(CGSize)size scrollMethod:(ScrollMethod)sm leftDataKeys:(NSArray *)leftDataKeys headDataKeys:(NSArray *)headDataKeys;


- (id)initWithHeadDataKeys:(NSArray *)headDataKeys andLeftDataKeys:(NSArray *)leftDataKeys andRightData:(NSDictionary *)rightDataDic andSize:(CGSize)size andScrollMethod:(ScrollMethod)sm;

- (void)fitWithScreenRotation:(UIInterfaceOrientation)toInterfaceOrientation;

@end
