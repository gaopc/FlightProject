//
//  SetRoomCountSectionCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SetRoomCountSectionCell.h"

@implementation SetRoomCountSectionCell
@synthesize roomCount,drawerButton,addRoomButton,reduceButton;

- (void)dealloc
{
    self.roomCount = nil;
    self.drawerButton = nil;
    self.reduceButton = nil;
    self.addRoomButton = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth-20, 7) image:[UIImage imageNamed:@"头带黑边.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 7, ViewWidth-20, 73) image:[UIImage imageNamed:@"中间.png"]]];
        self.drawerButton = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"抽屉.png"] frame:CGRectMake(ViewWidth-187, 0, 54, 10) target:nil action:nil];
        self.roomCount = [UISubLabel labelWithTitle:@"1" frame:CGRectMake(ViewWidth-114, 33, 45, 28) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentCenter];
        self.reduceButton = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"减房间.png"] frame:CGRectMake(ViewWidth-145, 33, 30, 28) target:nil action:nil];
        self.addRoomButton = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"加房间.png"] frame:CGRectMake(ViewWidth-68, 33, 30, 28) target:nil action:nil];
        
        [self addSubview:self.drawerButton];
        [self addSubview:[UISubLabel labelWithTitle:@"选择房间数量" frame:CGRectMake(25, 36, 100, 18) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        [self addSubview:self.reduceButton];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-114, 33, 45, 28) image:[UIImage imageNamed:@"房间数.png"]]];
        [self addSubview:self.roomCount];
        [self addSubview:self.addRoomButton];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 79, ViewWidth-43, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
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
