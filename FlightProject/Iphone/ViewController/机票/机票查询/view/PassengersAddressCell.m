//
//  PassengersAddressCell.m
//  FlightProject
//
//  Created by lidong  cui on 12-10-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PassengersAddressCell.h"

@implementation PassengersAddressCell

@synthesize btnView = _btnView;
@synthesize mainPostAddress = _mainPostAddress;
@synthesize mainView = _mainView;
@synthesize passView = _passView;
@synthesize postAddress = _postAddress;
@synthesize delegate,radioButton,editButton,mainName,mainPostCode,name,postCode;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		
		_passView = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 5.0f,  ViewWidth - 20, 145.0f)];
		
		passengersBgView=[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth - 20, 145.0f)];
		passengersBgView.image=[UIImage imageNamed:@"PassengerCell.png"];
		[self.passView addSubview:passengersBgView];
		
		radioImgView=[UIImageView ImageViewWithFrame:CGRectMake(15.0f, 60.0f, 25.0f, 25.0f)];
		radioImgView.image=[UIImage imageNamed:@"Radio_A.png"];
		[self.passView addSubview:radioImgView];
		
		self.btnView=[UIImageView ImageViewWithFrame:CGRectMake(15.0f, 60.0f, 25.0f, 25.0f)];
		self.btnView.image=[UIImage imageNamed:@"Radio_B.png"];
		[self.passView addSubview:self.btnView];
		self.btnView.hidden =YES;
		
                UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"收件人:" frame:CGRectMake(50.0f, 15.0f, 80.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
                titleLabel1.textColor = FontColor333333;
                [self.passView addSubview:titleLabel1];
		
		self.name = [UISubLabel labelWithTitle:@"" frame:CGRectMake(120.0, 15.0f, 80.0f, 20.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
		self.name.textColor = FontColor333333;
		[self.passView addSubview:self.name];
		
		
                UISubLabel *titleLabel2 = [UISubLabel labelWithTitle:@"邮政编码:" frame:CGRectMake(50.0f, 45.0f, 80.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
                titleLabel2.textColor = FontColor333333;
		[self.passView addSubview:titleLabel2];
		
		self.postCode = [UISubLabel labelWithTitle:@"" frame:CGRectMake(120.0, 45.0f, 160.0f, 20.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
		self.postCode.textColor = FontColor333333;
		[self.passView addSubview:self.postCode];
		
                UISubLabel *titleLabel3 = [UISubLabel labelWithTitle:@"详细地址:" frame:CGRectMake(50.0f, 80.0f, 80.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
                titleLabel3.textColor = FontColor333333;
                [self.passView addSubview:titleLabel3];
		
		_postAddress = [[UISubTextView alloc] initWithFrame:CGRectMake(120.0, 70.0f, ViewWidth - 150, 63.0f)];
		self.postAddress.textColor = FontColor333333;
		self.postAddress.editable = YES;
		self.postAddress.delegate = self;
		self.postAddress.font = FontSize30;
		self.postAddress.backgroundColor = [UIColor clearColor];
		[self.passView addSubview:self.postAddress];
		
		
	        UISubLabel *titleLabel4 = [UISubLabel labelWithTitle:@"编辑资料" frame:CGRectMake(ViewWidth - 120, 15.0f, 85.0f, 25.0f) font:FontBlodSize38 alignment:NSTextAlignmentLeft];
	        titleLabel4.textColor = FontColor2B8DD0;
	        [self.passView addSubview:titleLabel4];
		
	        UIImageView *iconView=[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 35, 20.0f, 8.0f, 13.0f)];
	        iconView.image=[UIImage imageNamed:@"CellArrow.png"];
	        [self.passView addSubview:iconView];
		
                self.editButton =[UIButton buttonWithType:UIButtonTypeCustom];
		self.editButton.frame = CGRectMake(200.0f, 10.0f, 100.0f, 30);
		self.editButton.backgroundColor = [UIColor clearColor];
                [self.editButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
                [self.passView addSubview:self.editButton];
		
		[self.contentView addSubview:self.passView];
		
		_mainView = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 5.0f,  ViewWidth - 20, 145.0f)];
		
		self.mainView.hidden = YES;
		passengersBgView=[UIImageView ImageViewWithFrame:CGRectMake(00.0f, 0.0f, ViewWidth - 20, 145.0f)];
		passengersBgView.image=[UIImage imageNamed:@"PassengerCell.png"];
		[self.mainView addSubview:passengersBgView];
		
		
		titleLabel1 = [UISubLabel labelWithTitle:@"收件人:" frame:CGRectMake(20.0f, 15.0f, 80.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
		titleLabel1.textColor = FontColor333333;
		[self.mainView addSubview:titleLabel1];
		
		self.mainName = [UISubLabel labelWithTitle:@"" frame:CGRectMake(90.0, 15.0f, 80.0f, 20.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
		self.mainName.textColor = FontColor333333;
		[self.mainView addSubview:self.mainName];
		
		
		titleLabel2 = [UISubLabel labelWithTitle:@"邮政编码:" frame:CGRectMake(20.0f, 45.0f, 80.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
		titleLabel2.textColor = FontColor333333;
		[self.mainView addSubview:titleLabel2];
		
		self.mainPostCode = [UISubLabel labelWithTitle:@"" frame:CGRectMake(90.0, 45.0f, 160.0f, 20.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
		self.mainPostCode.textColor = FontColor333333;
		[self.mainView addSubview:self.mainPostCode];
		
		
		titleLabel3 = [UISubLabel labelWithTitle:@"详细地址:" frame:CGRectMake(20.0f, 80.0f, 80.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
		titleLabel3.textColor = FontColor333333;
		[self.mainView addSubview:titleLabel3];
		
		
		_mainPostAddress = [[UISubTextView alloc] initWithFrame:CGRectMake(90.0, 70.0f, ViewWidth - 135, 63.0f)];
		self.mainPostAddress.textColor = FontColor333333;
		self.mainPostAddress.font = FontSize30;
		self.mainPostAddress.editable = YES;
		self.mainPostAddress.delegate = self;
		self.mainPostAddress.backgroundColor = [UIColor clearColor];
		[self.mainView addSubview:self.mainPostAddress];
		
		titleLabel4 = [UISubLabel labelWithTitle:@"编辑资料" frame:CGRectMake(ViewWidth - 120, 15.0f, 85.0f, 25.0f) font:FontBlodSize38 alignment:NSTextAlignmentLeft];
		titleLabel4.textColor = FontColor2B8DD0;
		[self.mainView addSubview:titleLabel4];
		
		iconView=[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 35, 20.0f, 8.0f, 13.0f)];
		iconView.image=[UIImage imageNamed:@"CellArrow.png"];
		[self.mainView addSubview:iconView];
		
		[self.contentView addSubview:self.mainView];
		
	}
	self.backgroundColor = [UIColor clearColor];
	return self;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	return NO;
	
}

//点击单选按钮
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

-(void)dealloc
{
	self.passView = nil;
	self.mainView = nil;
	self.mainPostAddress = nil;
	self.name = nil;
	self.postCode = nil;
	self.postAddress = nil;
	
	[_mainView release];
	[_mainPostAddress release];
	[_passView release];
	[_postAddress release];

	[super dealloc];
}


@end



