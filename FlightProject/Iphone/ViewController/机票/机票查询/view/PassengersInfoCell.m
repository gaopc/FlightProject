//
//  PassengersInfoCell.m
//  FlightProject
//
//  Created by 崔立东 on 12-9-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  添加乘机人列表
//

#import "PassengersInfoCell.h"

@implementation PassengersInfoCell
@synthesize name,identification;
@synthesize btnView = _btnView;
@synthesize delegate,editButton,choiceImgView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		
		passengersBgView=[UIImageView ImageViewWithFrame:CGRectMake(10.0, 5.0f, ViewWidth - 20, 63.0f)];
		passengersBgView.image=[UIImage imageNamed:@"PassengerCell.png"];
		[self.contentView addSubview:passengersBgView];
		
		self.choiceImgView=[UIImageView ImageViewWithFrame:CGRectMake(20.0f, 28.0f, 15.0f, 14.5f)];
		self.choiceImgView.image=[UIImage imageNamed:@"Choice_A.png"];
		[self.contentView addSubview:self.choiceImgView];
		
		self.btnView=[UIImageView ImageViewWithFrame:CGRectMake(20.0f, 28.0f, 15.0f, 14.5f)];
		self.btnView.image=[UIImage imageNamed:@"Choice_B.png"];
		[self.contentView addSubview:self.btnView];
		
		self.btnView.hidden =YES;
		
		self.name = [UISubLabel labelWithTitle:@"" frame:CGRectMake(45.0, 22.0f, 80.0f, 25.0f) font:FontSize36 alignment:NSTextAlignmentLeft];
		
		self.name.textColor = FontColor696969;
		[self.contentView addSubview:self.name];
		
		self.identification = [UISubLabel labelWithTitle:@"" frame:CGRectMake(125.0, 22.0f, 165.0f, 25.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
		self.identification.textColor = FontColor696969;
		[self.contentView addSubview:self.identification];
		
		UIImageView *iconView=[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 29, 28.0f, 8.0f, 13.0f)];
		iconView.image=[UIImage imageNamed:@"CellArrow.png"];
		[self.contentView addSubview:iconView];
		
		self.editButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(200.0, 18.0f, ViewWidth - 220, 30.0f) backImage:nil target:self action:@selector(edit:)];

		[self.contentView addSubview:self.editButton];
		

	}
    self.backgroundColor = [UIColor clearColor];
	return self;
}


//点击编辑按钮
-(void)edit:(id)sender
{
	if (delegate) 
	{
		[delegate editClick:sender];
	}
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	
	[super touchesMoved:touches withEvent:event];
}
-(void)dealloc{
	[_btnView release];
	[super dealloc];
}

@end


