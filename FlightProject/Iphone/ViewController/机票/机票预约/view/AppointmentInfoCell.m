//
//  AppointmentInfoCell.m
//  FlightProject
//
//  Created by green kevin on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppointmentInfoCell.h"

@implementation AppointmentInfoCell
@synthesize describeLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
	   // self.backgroundColor = [UIColor redColor];
	    
        // Initialization code
            describeImg=[UIImageView ImageViewWithFrame:CGRectMake(10.0f, 0.0f, ViewWidth - 20, 100.0f)];
	    describeImg.image=[UIImage imageNamed:@"CellBg.png"];

	    [self.contentView addSubview:describeImg];
	    
	    self.describeLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(20.0f, 0.0f, ViewWidth - 40, 100.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
	    self.describeLabel.textColor = FontColor454545;
	    [self.contentView addSubview:self.describeLabel];
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
	
	self.describeLabel = nil;
	[super dealloc];
	
}

@end
