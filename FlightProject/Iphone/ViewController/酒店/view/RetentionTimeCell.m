//
//  RetentionTimeCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RetentionTimeCell.h"

@implementation RetentionTimeCell
@synthesize retentionTime,selectTime;
- (void)dealloc
{
    self.retentionTime = nil;
    self.selectTime = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, 300, 65) image:[UIImage imageNamed:@"中间.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 65, 300, 7) image:[UIImage imageNamed:@"尾.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 13, 277, 37) image:[UIImage imageNamed:@"输入框.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"房间保留时间:" frame:CGRectMake(30, 22, 110, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        
        self.retentionTime = [UISubLabel labelWithTitle:@"11:00--14:30" frame:CGRectMake(127, 22, 180, 20) font:FontSize30 color:FontColor3B3B3B alignment:NSTextAlignmentLeft];
        [self addSubview:self.retentionTime];
        
        self.selectTime = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"航班动态列表下级.png"] frame:CGRectMake(120, 16, 173, 30) target:nil action:nil];
        [self.selectTime setImageEdgeInsets:UIEdgeInsetsMake(9,168 , 9, 0)];
        [self addSubview:self.selectTime];
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
