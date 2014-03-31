//
//  CustomCell.h
//  IbokanProjects
//
//  Created by 1007 on 13-11-12.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic, retain) UIImageView *imageViewVC;
@property (nonatomic, retain) UIImageView *shadowView;
@property (nonatomic, retain) UIImageView *selectView;
@property (nonatomic,retain) UILabel *VCNameLabel;

- (id)initWithStyle:(UITableViewCellStyle)Cell reuseIdentifier:(NSString *)reuseIdentifier;
+ (NSString *)getSidePngNamePlist;
+ (NSString *)getPngName:(NSString *)value;

@end
