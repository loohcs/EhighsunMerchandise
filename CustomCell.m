//
//  CustomCell.m
//  IbokanProjects
//
//  Created by 1007 on 13-11-12.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)Cell reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:Cell reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _imageViewVC = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
        _VCNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 200, 30)];
        
        _shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 260, 40)];
        
        [_selectView addSubview:_imageViewVC];
        [_selectView addSubview:_VCNameLabel];
        [self addSubview:_selectView];
        [self addSubview:_shadowView];
    }
    return self;
}

+ (NSString *)getSidePngNamePlist
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"侧边栏按钮" ofType:@"plist"];
    return path;
}

+ (NSString *)getPngName:(NSString *)value
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[CustomCell getSidePngNamePlist]];
    
    NSDictionary *pngNameDic = [dic objectForKey:@"pngName"];
    NSString *pngName = [pngNameDic objectForKey:value];
    
    
    return pngName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
