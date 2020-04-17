//
//  HotelSearchCell.m
//  FlightProject
//
//  Created by green kevin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelInquiryCell.h"

@implementation HotelInquiryCell
@synthesize name;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		inquiryBgView=[UIImageView ImageViewWithFrame:CGRectMake(10.0, 5.0f, 300.0f, 50.0f)];
		inquiryBgView.image=[UIImage imageNamed:@"HotelFilterCellBg4.png"];
		[self.contentView addSubview:inquiryBgView];
		
		self.name = [UISubLabel labelWithTitle:@"" frame:CGRectMake(45.0, 16.0f, 80.0f, 25.0f) font:FontSize36 alignment:NSTextAlignmentLeft];
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
	[super dealloc];	
}

@end
