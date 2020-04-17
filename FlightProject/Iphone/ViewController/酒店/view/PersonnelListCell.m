//
//  PersonnelListCell.m
//  FlightProject
//
//  Created by green kevin on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PersonnelListCell.h"

@implementation PersonnelListCell
@synthesize name;
@synthesize btnView = _btnView;
@synthesize delegate,choiceImgView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		passengersBgView=[UIImageView ImageViewWithFrame:CGRectMake(10.0, 5.0f, 300.0f, 63.0f)];
		passengersBgView.image=[UIImage imageNamed:@"PassengerCell.png"];
		[self.contentView addSubview:passengersBgView];
		
		self.choiceImgView=[UIImageView ImageViewWithFrame:CGRectMake(20.0f, 28.0f, 15.0f, 14.5f)];
		self.choiceImgView.image=[UIImage imageNamed:@"Choice_A.png"];
		[self.contentView addSubview:self.choiceImgView];
		
		self.btnView=[UIImageView ImageViewWithFrame:CGRectMake(20.0f, 28.0f, 15.0f, 14.5f)];
		self.btnView.image=[UIImage imageNamed:@"Choice_B.png"];
		[self.contentView addSubview:self.btnView];
		
		self.btnView.hidden =YES;
		
		self.name = [UISubLabel labelWithTitle:@"" frame:CGRectMake(45.0, 22.0f, 200.0f, 25.0f) font:FontSize36 alignment:NSTextAlignmentLeft];
		
		self.name.textColor = FontColor696969;
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


//点击编辑按钮
-(void)edit:(id)sender
{
	if (delegate) 
	{
		[delegate editClick:sender];
	}
}

- (void) dealloc {
	self.name = nil;
	self.btnView = nil;
	self.choiceImgView = nil;
	[super dealloc];
	
}

@end
