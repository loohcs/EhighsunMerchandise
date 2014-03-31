//
//  SaleCompareViewController.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-1-22.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleCompareViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) CustomTableView *customTableView;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSString *pageTitle;
@property (nonatomic, strong) UITableView *sortTableView;
@property (nonatomic, assign) int flag;

@property (nonatomic, strong) NSString *primaryKey;//用来标记获得的楼层id

- (id)initWithDataDic:(NSDictionary *)dic andTitle:(NSString *)title;

@end
