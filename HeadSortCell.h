//
//  HeadSortCell.h
//  EhighsunMerchandise
//
//  Created by loohcs on 14-4-14.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadSortCell : UITableViewCell

@property (nonatomic, strong) UIImageView *sortImageView;//进行排序选择的下拉表单中得cell视图
@property (nonatomic, strong) UILabel *sortKeyLabel;//显示进行排序的关键字，如按照“销售金额”排序，则显示“销售金额”
@property (nonatomic, strong) UIImageView *sortTypeImage;//显示排序的类型，从小到大，从大到小

@end
