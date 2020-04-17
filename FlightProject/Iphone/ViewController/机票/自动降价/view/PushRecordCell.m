//
//  PushRecordCell.m
//  FlightProject
//
//  Created by 崔立东 on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  历史推送纪录Cell
//

#import "PushRecordCell.h"

@implementation PushRecordCell
@synthesize dateLabel,priceLabel,savingLabel,priceDiscount;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		
		long origin_x = 20.0f;
		
		self.dateLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, 15.0f, 70.0f, 25.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
		self.dateLabel.textColor = FontColor333333;
		[self.contentView addSubview:dateLabel];
		
		origin_x+= dateLabel.frame.size.width+10.0f;
		
		UISubLabel *flagLabel1 = [UISubLabel labelWithTitle:@"￥" frame:CGRectMake(origin_x, 24.0f, 10.0f, 10.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
		flagLabel1.textColor = FontColor333333;
		[self.contentView addSubview:flagLabel1];
		
		origin_x+= flagLabel1.frame.size.width+3.0f;
		
		
		self.priceLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, 10.0f, 50.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
		self.priceLabel.textColor = FontColor454545;
		[self.contentView addSubview:self.priceLabel];
		
		origin_x+= self.priceLabel .frame.size.width;
		
		self.priceDiscount = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, 10.0f, 50.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
		self.priceDiscount.textColor = FontColor454545;
		[self.contentView addSubview:self.priceDiscount];
		
		origin_x+= self.priceDiscount.frame.size.width+10.0f;
		
		UISubLabel *flagLabel3 = [UISubLabel labelWithTitle:@"可省￥" frame:CGRectMake(origin_x, 20.0f, 35.0f, 15.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
		flagLabel3.textColor = FontColorFF8813;
		[self.contentView addSubview:flagLabel3];
		
		origin_x+= flagLabel3.frame.size.width;
		
		self.savingLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, 10.0f, 70.0f, 30.0f) font:FontBlodSize38 alignment:NSTextAlignmentLeft];
		self.savingLabel.textColor = FontColorFF8813;
		[self.contentView addSubview:self.savingLabel];
		
		UIImageView *lineImageView=[UIImageView ImageViewWithFrame:CGRectMake(20.0f, 52.0f, ViewWidth - 40, 1.0f)];
		lineImageView.image=[UIImage imageNamed:@"TicketQueryDottedLine.png"];
		[self.contentView addSubview:lineImageView];
		
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
	
	
	
        self.dateLabel = nil;
	self.priceLabel = nil;
	self.priceDiscount = nil;
	self.savingLabel = nil;
	
	[super dealloc];
	
}

@end
