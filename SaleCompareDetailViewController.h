//
//  SaleCompareDetailViewController.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-2-27.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleCompareDetailViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) CustomTableView *customTableView;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSString *pageTitle;
@property (nonatomic, strong) UITableView *sortTableView;
@property (nonatomic, assign) int flag;

- (id)initWithDataDic:(NSDictionary *)dic andTitle:(NSString *)title;


@end
