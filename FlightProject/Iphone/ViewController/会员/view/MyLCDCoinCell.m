//
//  MyLCDCoinCell.m
//  FlightProject
//
//  Created by lidong  cui on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyLCDCoinCell.h"

@implementation MyLCDCoinCell
@synthesize lcdBgView,typeLabel,content,amountLabel,dateLabel,amountFlagLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		
		
		
		self.lcdBgView=[UIImageView ImageViewWithFrame:CGRectMake(12.0, 0.0f, ViewWidth - 24, 53.0f)];
		
		[self.contentView addSubview: self.lcdBgView];
		
		self.typeLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(10, 0.0f, (ViewWidth-20.0f)/4, 53.0f) font:FontSize26 alignment:NSTextAlignmentCenter];
		self.typeLabel.textColor = FontColor696969;
		
		[self.contentView addSubview: self.typeLabel];
		
		
		
		self.content = [UISubLabel labelWithTitle:@"" frame:CGRectMake((ViewWidth-20.0f)/4 + 10, 0.0f, (ViewWidth-20.0f)/4, 53.0f) font:FontSize26 alignment:NSTextAlignmentCenter];
		self.content.textColor = FontColor696969;
		
		[self.contentView addSubview:self.content];
		
		
		self.amountFlagLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake((ViewWidth-20.0f)/2 + 5, 0.0f, (ViewWidth-20.0f)/8, 53.0f) font:FontSize26 alignment:NSTextAlignmentRight];
		
		[self.contentView addSubview: self.amountFlagLabel];
		
		self.amountLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake((ViewWidth-20.0f)/2  + (ViewWidth-20.0f)/8 + 5, 0.0f, (ViewWidth-20.0f)/8, 53.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
		self.amountLabel.textColor = FontColor696969;
		
		[self.contentView addSubview: self.amountLabel];
		
		
		
		self.dateLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake((ViewWidth-20.0f)*3/4 + 5, 0.0f, (ViewWidth-20.0f)/4, 53.0f) font:FontSize26 alignment:NSTextAlignmentCenter];
		self.dateLabel.textColor = FontColor696969;
		
		[self.contentView addSubview:self.dateLabel];
		
		
	}
    self.backgroundColor = [UIColor clearColor];
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

- (void)dealloc
{
	
	self.lcdBgView = nil;
	self.typeLabel = nil;
	self.amountFlagLabel = nil;
	self.content = nil;
	self.amountLabel = nil;
	self.dateLabel = nil;
	[super dealloc];
}

@end
