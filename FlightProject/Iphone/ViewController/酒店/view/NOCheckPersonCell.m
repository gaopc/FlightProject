//
//  NOCheckPersonCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NOCheckPersonCell.h"

@implementation NOCheckPersonCell

- (void)dealloc
{
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, 300, 50) image:[UIImage imageNamed:@"中间.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 5, 277, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"您需要添加入住人" frame:CGRectMake(30, 10, 150, 18) font:FontSize30 color:FontColorFF6113 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(23, 49, 270, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
