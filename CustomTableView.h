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

//表格每一行的高度
#define kTableViewCellHeight 40.0

//表格每一列的宽度
#define kTableViewTitleWidth 60.0
//标题栏的高度
#define kTableViewTitleHeight 20.0

@interface CustomTableView : UIView <UITableViewDataSource, UITableViewDelegate, PullDelegate>

@property (nonatomic, retain) UIScrollView *headScrollView;//标题滚动栏
@property (nonatomic, retain) UITableView *headTableView;//标题的表格

@property (nonatomic, retain) UIScrollView *sumScrollView;
@property (nonatomic, retain) UITableView *sumTableView;

@property (nonatomic, retain) UITableView *leftTableView;//左边表格
@property (nonatomic, retain) UITableView *rightTableView;//右边表格
@property (nonatomic, retain) UIScrollView *leftScrollView;//左边的滚动页
@property (nonatomic, retain) UIScrollView *rightScrollView;//右边的滚动页

//又来存放当前页面的名字，主要用于数据请求以及点击页面中某一行跳转时，需要请求的数据的依据,比如在销售对比页，那么点击左边的表格，我们将要执行的操作时进入销售对比的详细页，即从每一层的销售情况，进入到每一层中每一个店铺的销售情况。实际上就是实现一种阶梯型的页面转化，具体的组织结构将会存在本地的plist文件中
@property (nonatomic, retain) NSString *pageFlag;

@property (nonatomic, retain) NSArray *dataArray;//存放所有数据的数组
@property (nonatomic, retain) NSDictionary *trDictionary;//用来存放数据的字典

@property (nonatomic, retain) NSArray *leftDataKeys;//存放左边的表格关键字，即表头关键字的第一个
@property (nonatomic, retain) NSDictionary *leftDataDic;//存放左边表格的所有数据

//存放右边表格的关键字，与表头的关键字相同（第一列为左边表格的关键字）
@property (nonatomic, retain) NSArray *rightDataKeys;
@property (nonatomic, strong) NSDictionary *rightDataDic;//存放右边表格的数据

@property (nonatomic, retain) NSArray *headDataKeys;//存放表头的关键字
@property (nonatomic, retain) NSArray *headDataValues;//存放表头的名字，用来显示以及确定每列数据的顺序

@property (nonatomic, retain) NSDictionary *sumDataDic;

@property (nonatomic, assign) CGFloat startDragContentOffsetX;//确定滚动页的起始位置
@property (nonatomic, assign) CGFloat endDragContentOffsetX;//确定滚动页的最终位置

@property (nonatomic, assign) CGPoint lastPoint;//拖动页面时手指的前一时刻位置
@property (nonatomic, assign) CGPoint presentPoint;//拖动页面时手指的当前位置

@property (nonatomic, assign) CGSize size;



//传递的leftDataKeys rightDataKeys我们是经过了判断的，他们每个长度不能在kScrollMethodWithLeft 和 kScrollMethodWithRight模式下不能越界,具体参看代码
/**********************************************************
 传递的参数各自含义：
 headDataKeys:数据库中每一列的上面标题显示，如TQSR，我们将根据这个值来获取准确的每一行中的数据
 headDataTitle:整个页面的名称，也可以说是该页面的名称，如：从主页跳转到“销售对比”页面，那么“销售对比”就是headDataTitle，同时我们根据这个title去获得实际上再该页面中我们应该显示的
 leftDataKeys:左边表格的值，其中每一行的值也是右边表格同一行字典数据的键值
 rightDataDic:右边表格的值，其中每一行的数据是一个字典，同时这个字典里面的数据也是字典，键值与标题的key相对应
 size:获取屏幕的大小，主要是根据当前的手机大小，以及屏幕方向决定
 scrollMethod:决定屏幕托业的主要方法
 **********************************************************/
- (id)initWithHeadDataKeys:(NSArray *)headDataKeys
          andHeadDataTitle:(NSString *)headDataTitle
           andLeftData:(NSDictionary *)leftDataDic
              andRightData:(NSDictionary *)rightDataDic
                   andSize:(CGSize)size
           andScrollMethod:(ScrollMethod)sm;

//加入排序
- (void)changeDataWithSortArr:(NSArray *)sortArr;

//改变时间后需要刷新数据
- (void)changeDataWithNewTime:(NSDictionary *)dic;

- (void)changeSumData:(NSDictionary *)dic;

- (void)fitWithScreenRotation:(UIInterfaceOrientation)toInterfaceOrientation;

@end
