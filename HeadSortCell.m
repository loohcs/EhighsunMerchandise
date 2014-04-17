//
//  HeadSortCell.m
//  EhighsunMerchandise
//
//  Created by loohcs on 14-4-14.
//  Copyright (c) 2014年 loohcs. All rights reserved.
//

#import "HeadSortCell.h"

@implementation HeadSortCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //_sortImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 140, 30)];
        //UIImage *sortBG = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sort_bg" ofType:@"png"]];
        //_sortImageView.image = sortBG;
        
        _sortKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 20)];
        _sortKeyLabel.backgroundColor = [UIColor clearColor];
        _sortKeyLabel.userInteractionEnabled = YES;
        
        _sortTypeImage = [[UIImageView alloc] initWithFrame:CGRectMake(105, 5, 10, 20)];
        UIImage *sortTypeImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"arrow_down" ofType:@"png"]];
        _sortTypeImage.image = sortTypeImage;
        
        [self addSubview:_sortKeyLabel];
        [self addSubview:_sortTypeImage];
        //[self addSubview:_sortImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
