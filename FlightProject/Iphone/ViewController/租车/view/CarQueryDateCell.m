//
//  CarQueryDateCell.m
//  FlightProject
//
//  Created by longcd on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarQueryDateCell.h"

@implementation CarQueryDateCell
@synthesize _toDataButton,_fromDataButton,_toDataOneLabel,_toDataTwoLabel,_fromDataOneLabel,_fromDataTwoLabel;
@synthesize _fromTimeLabel,_toTimeLabel;
-(void)dealloc
{
    self._toDataButton = nil;
    self._fromDataButton = nil;
    self._toDataOneLabel = nil;
    self._toDataTwoLabel = nil;
    self._fromDataOneLabel = nil;
    self._fromDataTwoLabel = nil;
    self._fromTimeLabel = nil;
    self._toTimeLabel = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth - 20, 90) image:[UIImage imageNamed:@"TicketQueryCenter.png"]]];

        [self addSubview:[UISubLabel labelWithTitle:@"取车时间" frame: CGRectMake(10, 0, 120, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        [self addSubview:[UISubLabel labelWithTitle:@"还车时间" frame: CGRectMake(ViewWidth - 150, 0, 120, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        
        self._fromDataButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(20, 20, 100, 60) backImage:nil target:nil action:nil];
        self._fromDataOneLabel = [UISubLabel labelWithTitle:@"周五09月" frame: CGRectMake(20, 20, 30, 40) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self._fromDataTwoLabel = [UISubLabel labelWithTitle:@"28" frame: CGRectMake(40, 20, 70, 40) font:FontBlodSize80 color:FontColor333333 alignment:NSTextAlignmentCenter];
        
        self._toDataButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(ViewWidth - 140, 20, 100, 60) backImage:nil target:nil action:nil];
        self._toDataOneLabel = [UISubLabel labelWithTitle:@"周五09月" frame: CGRectMake(ViewWidth - 140, 20, 30, 40) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self._toDataTwoLabel = [UISubLabel labelWithTitle:@"30" frame: CGRectMake(ViewWidth - 120, 20, 70, 40) font:FontBlodSize80 color:FontColor333333 alignment:NSTextAlignmentCenter];
        
        self._fromTimeLabel = [UISubLabel labelWithTitle:@"00:00" frame: CGRectMake(10, 60, 120, 20) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self._toTimeLabel = [UISubLabel labelWithTitle:@"11:11" frame: CGRectMake(ViewWidth - 150, 60, 120, 20) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentCenter];
        
        [self addSubview:self._fromDataButton];
        [self addSubview:self._toDataButton];
        [self addSubview:self._fromDataOneLabel];
        [self addSubview:self._fromDataTwoLabel];
        [self addSubview:self._toDataOneLabel];
        [self addSubview:self._toDataTwoLabel];
        [self addSubview:self._fromTimeLabel];
        [self addSubview:self._toTimeLabel];
        
        [self addSubview:[UISubLabel labelWithTitle:@"日" frame: CGRectMake(100, 35, 20, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        [self addSubview:[UISubLabel labelWithTitle:@"日" frame: CGRectMake(ViewWidth - 60, 35, 20, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter]];

         [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 80.0f, ViewWidth - 20, 18.0f) image:[UIImage imageNamed:@"TicketQueryShadow.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(120, (95-13) / 2, 8, 13) image:[UIImage imageNamed:@"CellArrow.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 40, (95-13) / 2, 8, 13) image:[UIImage imageNamed:@"CellArrow.png"]]];
        
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
