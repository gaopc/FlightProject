//
//  HotelGuaranteeSelectCardCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelGuaranteeSelectCardCell.h"

@implementation HotelGuaranteeSelectCardCell
@synthesize selectCard;
- (void)dealloc
{
    self.selectCard = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 7) image:[UIImage imageNamed:@"头带黑边.png"]]];
         [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 7, ViewWidth - 20, 48) image:[UIImage imageNamed:@"中间.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"信用卡信息" frame:CGRectMake(25, 20, 80, 20) font:FontSize30 color:FontColor454545 alignment:NSTextAlignmentLeft]];
        self.selectCard = [UIButton customButtonTitle:nil image:nil frame:CGRectMake(ViewWidth - 145, 15, 120, 30) target:nil action:nil];
        [self addSubview:self.selectCard];
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
