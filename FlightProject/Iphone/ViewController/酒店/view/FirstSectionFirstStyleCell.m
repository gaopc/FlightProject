//
//  FirstSectionFirstStyleCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstSectionFirstStyleCell.h"
#import "Header.h"
@implementation FirstSectionFirstStyleCell
@synthesize hotelName,checkInDate,checkOutDate,singlePrice;
- (void)dealloc
{
    self.hotelName = nil;
    self.checkInDate = nil;
    self.checkOutDate = nil;
    self.singlePrice = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.hotelName = [UISubLabel labelWithTitle:nil frame:CGRectMake(25,5,ViewWidth-20,15) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self.checkInDate = [UISubLabel labelWithTitle:nil frame:CGRectMake(25,18,70,20) font:FontSize22 color:FontColor2685CF alignment:NSTextAlignmentLeft];
        self.checkOutDate = [UISubLabel labelWithTitle:nil frame:CGRectMake(112,18,70,20) font:FontSize22 color:FontColor2685CF alignment:NSTextAlignmentLeft];
        self.singlePrice = [UISubLabel labelWithTitle:nil frame:CGRectMake(255,12,60,30) font:FontBlodSize48 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self.hotelName];
        [self addSubview:self.checkInDate];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(95, 24, 12, 10) image:[UIImage imageNamed:@"cabinArrows.png"]]];
        [self addSubview:self.checkOutDate];
        [self addSubview:[UISubLabel labelWithTitle:@"单间总价 :" frame:CGRectMake(188,17,55,20) font:FontSize22 color:FontColor767676 alignment:NSTextAlignmentCenter]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(245, 25, 6, 7) image:[UIImage imageNamed:@"cabinListRMB.png"]]];
        [self addSubview:self.singlePrice];
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
