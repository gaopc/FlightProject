//
//  RadioViewCell.m
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RadioViewCell.h"

@implementation RadioViewCell
@synthesize btnView = _btnView;
@synthesize name;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
	    
	    radioImgView=[UIImageView ImageViewWithFrame:CGRectMake(15.0f, 10.0f, 25.0f, 25.0f)];
	    radioImgView.image=[UIImage imageNamed:@"Radio_A.png"];
	    [self.contentView addSubview:radioImgView];
	    
	    self.btnView=[UIImageView ImageViewWithFrame:CGRectMake(15.0f, 10.0f, 25.0f, 25.0f)];
	    self.btnView.image=[UIImage imageNamed:@"Radio_B.png"];
	    [self.contentView addSubview:self.btnView];
	    self.btnView.hidden =YES;
	    
	    
	    self.name = [UISubLabel labelWithTitle:@"" frame:CGRectMake(60.0, 10.0f, 200.0f, 20.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
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
	self.btnView = nil;
	[super dealloc];
	
}

@end
