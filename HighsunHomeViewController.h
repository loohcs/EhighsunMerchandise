//
//  HighsunHomeViewController.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighsunHomeViewController : BasicViewController
{
    UITableView *middleView;
    int middleFlag;//标志中间的弹出框是否存在
    UITableView *rightView;
    int rightFlag;//标志右边的弹出框是否存在
    NSMutableArray *_array;
    int flag;//标志是否有弹出框存在
}

@property (nonatomic, strong) CustomTableView *customTableView;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSString *pageTitle;



- (id)initWithDataDic:(NSDictionary *)dic andTitle:(NSString *)title;

@end
