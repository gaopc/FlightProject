//
//  StationInfoCell.m
//  FlightProject
//
//  Created by green kevin on 13-1-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "StationInfoCell.h"

@implementation StationInfoCell
@synthesize bgView,stationNameLabel,departureTimeLabel,arrivalTimeLabel,stopTimeLabel,mileageLabel,stationNumLabel,days,numLabel,thatDayLabel,stationsDay1View,thatDayLabel1,stationsDay2View;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		
		self.bgView = [[UIView alloc] initWithFrame:CGRectMake(12, 0, 296, 55)];
		self.bgView.backgroundColor = FontColorDDECF6;
		self.bgView.hidden = YES;
		[self addSubview:self.bgView];
		
		
		UIImageView *lineImageView=[UIImageView ImageViewWithFrame:CGRectMake(20.0f, 0.0f, ViewWidth-40, 1.0f)];
		lineImageView.image=[UIImage imageNamed:@"TicketQueryDottedLine.png"];
		[self addSubview:lineImageView];
		
		[self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(18, 21, 15, 15.5) image:[UIImage imageNamed:@"trainIcon3.png"]]];
		
		self.numLabel =  [UISubLabel labelWithTitle:@"" frame:CGRectMake(18, 24.5, 14.0f, 10.0f) font:FontSize24 color:FontColor1C7CBC alignment:NSTextAlignmentCenter];
		[self addSubview:self.numLabel];
		
		self.stationNameLabel =  [UISubLabel labelWithTitle:@"" frame:CGRectMake(38.0f, 15.0f, 110.0f, 25.0f) font:FontSize28 color:FontColor333333 alignment:NSTextAlignmentLeft];
		[self addSubview:self.stationNameLabel];
		
		self.arrivalTimeLabel =  [UISubLabel labelWithTitle:@"08:20" frame:CGRectMake(ViewWidth-200, 15.0f, 50.0f, 25.0f) font:FontSize28 color:FontColor333333 alignment:NSTextAlignmentCenter];
		[self addSubview:self.arrivalTimeLabel];
		
		self.departureTimeLabel =  [UISubLabel labelWithTitle:@"08:20" frame:CGRectMake(ViewWidth-155, 15.0f, 50.0f, 25.0f) font:FontSize28 color:FontColor333333 alignment:NSTextAlignmentCenter];
		[self addSubview:self.departureTimeLabel];
		
		
		
		self.stopTimeLabel =  [UISubLabel labelWithTitle:@"10" frame:CGRectMake(ViewWidth-100, 10.0f, 25.0f, 35.0f) font:FontBlodSize38 color:FontColor1C7CBC alignment:NSTextAlignmentCenter];
		[self addSubview:self.stopTimeLabel];
		
		[self addSubview:[UISubLabel labelWithTitle:@"分" frame:CGRectMake(ViewWidth-77, 18.0f, 12.0f, 20.0f) font:FontBlodSize26 color:FontColor1C7CBC alignment:NSTextAlignmentLeft]];
		
		
		self.mileageLabel =  [UISubLabel labelWithTitle:@"2344" frame:CGRectMake(ViewWidth-52, 15.0f, 39.0f, 25.0f) font:FontSize28 color:FontColor333333 alignment:NSTextAlignmentCenter];
		[self addSubview:self.mileageLabel];
		
		
		self.stationsDay1View=[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-150, 38.0f, 38.5f, 13.5f)];
		self.stationsDay1View.hidden = YES;
		self.stationsDay1View.image = [UIImage imageNamed:@"StationsDay.png"];
		
		self.stationsDay2View=[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-195, 38.0f, 38.5f, 13.5f)];
		self.stationsDay2View.hidden = YES;
		self.stationsDay2View.image = [UIImage imageNamed:@"StationsDay.png"];
		
		
		self.thatDayLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(0.0f, 0.0f, 38.5f, 13.5f) font:FontSize20 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
		[self.stationsDay1View addSubview:self.thatDayLabel];
		[self addSubview:self.stationsDay1View];
		
		
		self.thatDayLabel1 = [UISubLabel labelWithTitle:@"" frame:CGRectMake(0.0f, 0.0f, 38.5f, 13.5f) font:FontSize20 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
		[self.stationsDay2View addSubview:self.thatDayLabel1];
		[self addSubview:self.stationsDay2View];
		
		
		
	}
	//self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.backgroundColor = [UIColor clearColor];
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

-(void)dealloc
{
	self.stationNameLabel = nil;
	self.departureTimeLabel = nil;
	self.arrivalTimeLabel = nil;
	self.stopTimeLabel = nil;
	self.mileageLabel = nil;
	self.stationNumLabel = nil;
	self.days = nil;
	self.numLabel = nil;
	self.stationsDay1View = nil;
	self.bgView = nil;
	self.thatDayLabel = nil;
	self.thatDayLabel1 = nil;
	[super dealloc];
}

@end
