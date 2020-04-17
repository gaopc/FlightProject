//
//  HotelFilterCell.m
//  FlightProject
//
//  Created by green kevin on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelFilterCell.h"

@implementation HotelFilterCell

@synthesize name,inquiryBgView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		self.inquiryBgView=[UIImageView ImageViewWithFrame:CGRectMake(10.0, 0.0f, 300.0f, 45.0f)];
		self.inquiryBgView.image=[UIImage imageNamed:@"HotelFilterCellBg2.png"];
		[self.contentView addSubview:self.inquiryBgView];
		
		self.name = [UISubLabel labelWithTitle:@"" frame:CGRectMake(40.0, 10.0f, 200.0f, 25.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
		self.name.textColor = FontColor333333;
		[self.contentView addSubview:self.name];
		

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
	
        self.name = nil;
	self.inquiryBgView = nil;

	[super dealloc];	
}

@end

