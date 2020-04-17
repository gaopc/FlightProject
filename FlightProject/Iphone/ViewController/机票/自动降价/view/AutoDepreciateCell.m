//
//  AutoDepreciateCell.m
//  FlightProject
//
//  Created by 崔立东 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  自动降价列表Cell
//

#import "AutoDepreciateCell.h"

@implementation AutoDepreciateCell

@synthesize flightLabel,arriveLabel,flightNOLabel,arriveDateLabel,pushTimeLabel,submitDateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		long origin_x = 20.0f;
		long origin_y = 5.0f;
		
		flightSmallIcons=[UIImageView ImageViewWithFrame:CGRectMake(origin_x, origin_y+7.0f, 11.0f, 12.0f)];
		flightSmallIcons.image=[UIImage imageNamed:@"flightSmallIcon.png"];
		[self.contentView addSubview:flightSmallIcons];
		
		origin_x+= flightSmallIcons.frame.size.width+5.0f;
		
		self.flightLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, origin_y, 60.0f, 25.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
		self.flightLabel.textColor = FontColor333333;
		[self.contentView addSubview:self.flightLabel];
		
		origin_x+= flightLabel.frame.size.width;
		
		self.flightNOLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, origin_y, 55.0f, 25.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
		self.flightNOLabel.textColor = FontColor333333;
		[self.contentView addSubview:self.flightNOLabel];
		
		origin_x+= flightNOLabel.frame.size.width+12.0f;
		
		self.pushTimeLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, origin_y, 35.0f, 35.0f) font:FontBlodSize56 alignment:NSTextAlignmentCenter];
        self.pushTimeLabel.adjustsFontSizeToFitWidth = YES;
		self.pushTimeLabel.textColor = FontColor1C7CBC;
		[self.contentView addSubview:self.pushTimeLabel];
		
		origin_x+= pushTimeLabel.frame.size.width;
		
		origin_y+=12.0f;
		
		UISubLabel *font1Label = [UISubLabel labelWithTitle:@"次" frame:CGRectMake(origin_x, origin_y+2.0f, 12.0f, 15.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
		font1Label.textColor = FontColor1C7CBC;
		[self.contentView addSubview:font1Label];
		
		origin_x+= font1Label.frame.size.width+15.0f;
		
		self.submitDateLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, origin_y, 70.0f, 15.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
        self.submitDateLabel.adjustsFontSizeToFitWidth = YES;
		self.submitDateLabel.textColor = FontColor333333;
		[self.contentView addSubview:self.submitDateLabel];
		
		
		origin_x = 20.0f;
		origin_y = 5.0f;
		origin_y+= flightSmallIcons.frame.size.height+8.0f;
		
		arriveSmallIcons=[UIImageView ImageViewWithFrame:CGRectMake(origin_x, origin_y+7.0f, 11.0f, 12.0f)];
		arriveSmallIcons.image=[UIImage imageNamed:@"arriveSmallIcon.png"];
		[self.contentView addSubview:arriveSmallIcons];
		
		origin_x+= arriveSmallIcons.frame.size.width+5.0f;
		
		self.arriveLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, origin_y, 60.0f, 25.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
		self.arriveLabel.textColor = FontColor333333;
		[self.contentView addSubview:self.arriveLabel];
		
		origin_x+= flightLabel.frame.size.width;
		
		self.arriveDateLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, origin_y, 70.0f, 25.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
        self.arriveDateLabel.adjustsFontSizeToFitWidth = YES;
		self.arriveDateLabel.textColor = FontColor333333;
		[self.contentView addSubview:self.arriveDateLabel];
		
		UIImageView *lineImageView=[UIImageView ImageViewWithFrame:CGRectMake(20.0f, 52.0f, ViewWidth - 40, 1.0f)];
		lineImageView.image=[UIImage imageNamed:@"TicketQueryDottedLine.png"];
		[self.contentView addSubview:lineImageView];
		
		UIImageView *iconView=[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 25, 18.0f, 8.0f, 13.0f)];
		iconView.image=[UIImage imageNamed:@"CellArrow.png"];
		[self.contentView addSubview:iconView];
		
	}
    self.backgroundColor = [UIColor clearColor];
	return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}


- (void) dealloc {
	
	
	
        self.flightLabel = nil;
	self.arriveLabel = nil;
	self.flightNOLabel = nil;
	self.arriveDateLabel = nil;
	self.pushTimeLabel = nil;
	self.submitDateLabel = nil;
	
	[super dealloc];
	
}

@end
