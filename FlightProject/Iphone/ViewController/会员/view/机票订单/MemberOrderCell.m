//
//  MemberOrderCell.m
//  FlightProject
//
//  Created by admin on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberOrderCell.h"

@implementation MemberOrderCell

@synthesize _stateImageV, _company1ImageV, _company2ImageV;
@synthesize _startDate, _startAirport, _endAirport, _flightNo1, _flightNo2, _startTime1, _startTime2, _planeType, _ticketPrice;

- (void)dealloc
{
    self._stateImageV = nil;
    self._company1ImageV = nil;
    self._company2ImageV = nil;
    self._startAirport = nil;
    self._endAirport = nil;
    self._flightNo1 = nil;
    self._flightNo2 = nil;
    self._startTime1 = nil;
    self._startTime2 = nil;
    self._planeType = nil;
    self._ticketPrice = nil;
    self._startDate = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 100, 75) image:[UIImage imageNamed:@"TicketListLeft.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 90, 0, 80, 75) image:[UIImage imageNamed:@"TicketListRight.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 52, ViewWidth - 120, 1) image:[UIImage imageNamed:@"TicketListxuxian.png"]]];
        
        self._company1ImageV = [UIImageView ImageViewWithFrame:CGRectMake(20, 13, 15, 15) image:[UIImage imageNamed:@"CZ.png"]];
        self._company2ImageV = [UIImageView ImageViewWithFrame:CGRectMake(20, 33, 15, 15) image:[UIImage imageNamed:@"EU.png"]];
        
        self._flightNo1 = [UISubLabel labelWithTitle:@"MU5162" frame:CGRectMake(40, 8, 70, 20) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._flightNo2 = [UISubLabel labelWithTitle:@"MU5162" frame:CGRectMake(40, 28, 70, 20) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._startAirport = [UISubLabel labelWithTitle:@"乌鲁木齐" frame:CGRectMake((ViewWidth - 140)/2, 9, 70, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self._endAirport = [UISubLabel labelWithTitle:@"鄂尔多斯" frame:CGRectMake((ViewWidth - 140)/2, 29, 70, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self._startTime1 = [UISubLabel labelWithTitle:@"2012-08-20" frame:CGRectMake(ViewWidth - 100 - 70, 10, 70, 20) font:FontSize20 color:FontColor333333 alignment:NSTextAlignmentRight];
        self._startTime2 = [UISubLabel labelWithTitle:@"2012-08-20" frame:CGRectMake(ViewWidth - 100 - 70, 30, 70, 20) font:FontSize20 color:FontColor333333 alignment:NSTextAlignmentRight];
        
        self._startDate = [UISubLabel labelWithTitle:@"2012-08-18 提交" frame:CGRectMake(20, 54, 150, 20) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        self._planeType = [UISubLabel labelWithTitle:@"往返" frame:CGRectMake(ViewWidth - 100 - 40, 54, 40, 20) font:FontSize20 color:FontColor696969 alignment:NSTextAlignmentRight];
        self._stateImageV = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 80, 52, 52, 20) image:[UIImage imageNamed:@"待支付.png"]];
        
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 85, 29, 8, 8) image:[UIImage imageNamed:@"TicketListRMB.png"]]];
        self._ticketPrice =   [UISubLabel labelWithTitle:@"2379" frame:CGRectMake(ViewWidth - 75, 20, 60, 20) font:FontBlodSize42 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._startTime1];
        [self addSubview:self._startTime2];
        [self addSubview:self._stateImageV];
        [self addSubview:self._startDate];
        [self addSubview:self._startAirport];
        [self addSubview:self._endAirport];
        [self addSubview:self._company1ImageV];
        [self addSubview:self._company2ImageV];
        [self addSubview:self._flightNo1];
        [self addSubview:self._flightNo2];
        [self addSubview:self._planeType];
        [self addSubview:self._ticketPrice];
        
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end
