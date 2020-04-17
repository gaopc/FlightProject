//
//  HotelGuaranteeIntroductionCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelGuaranteeIntroductionCell.h"

@implementation HotelGuaranteeIntroductionCell
@synthesize guaranteePrice,descrip;
- (void)dealloc
{
    self.guaranteePrice = nil;
    self.descrip = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UISubLabel labelWithTitle:@"该酒店需要信用卡担保" frame:CGRectMake(25,5,200,15) font:FontSize30 color:FontColor454545 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"担保金额" frame:CGRectMake(185,40,55,20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(238, 48, 6, 7) image:[UIImage imageNamed:@"cabinListRMB.png"]]];
        self.guaranteePrice = [UISubLabel labelWithTitle:@"800" frame:CGRectMake(245,38,70,20) font:FontSize48 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        [self addSubview:self.guaranteePrice];
        self.descrip = [UISubLabel labelWithTitle:nil frame:CGRectMake(25,65,290,20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft autoSize:YES];
        [self addSubview:self.descrip];
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
