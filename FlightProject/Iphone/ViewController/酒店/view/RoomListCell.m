//
//  RoomListCell.m
//  FlightProject
//
//  Created by green kevin on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoomListCell.h"

@implementation RoomListCell
@synthesize roomView = _roomView;
@synthesize hotelImageView = _hotelImageView;
@synthesize roomName,roomPrice,roomReturnLcdFee,roomRuleButton,roomButton,_isExtend,delegate,_returnLcdView,roomNoButton;

@synthesize breakfastLabel,networkLabel,areaLabel,floorLabel,bedTypeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		self._isExtend = FALSE;
		[self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, 300, 55) image:[UIImage imageNamed:@"cabinListCell.png"]]];
		//名字
		self.roomName = [UISubLabel labelWithTitle:@"" frame:CGRectMake(15, 5, 155, 40) font: FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft ];
		self.roomName.lineBreakMode = UILineBreakModeTailTruncation;
		self.roomName.numberOfLines = 0;
		self.roomPrice.backgroundColor = [UIColor redColor];
		[self addSubview:self.roomName];
		
		[self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-150, 18, 7, 7) image:[UIImage imageNamed:@"cabinListRMB.png"]]];
		//价格
		self.roomPrice = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-140, 7, 60, 20) font:FontSize42 color:FontColorFF8813  alignment:NSTextAlignmentLeft];
		
		[self  addSubview:self.roomPrice];
		
		UIView * view = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth-140, 34, 50.0f, 20.0f)];
		self._returnLcdView = view;
		[view release];
		
		//返畅达币
		self.roomReturnLcdFee = [UISubLabel labelWithTitle:@"" frame:CGRectMake(0, 0, 100, 20) font: FontSize24 color:FontColorFF6113 alignment:NSTextAlignmentLeft];
		[self._returnLcdView addSubview:self.roomReturnLcdFee];
		
		UIImageView *cabinReturnLcdImage = [UIImageView ImageViewWithFrame:CGRectMake(30, 5, 12, 12) image:[UIImage imageNamed:@"cabinCdb.png"] ];
		[self._returnLcdView addSubview:cabinReturnLcdImage];
		
		[self addSubview:self._returnLcdView];
		
		//预订按钮
		self.roomButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(240, 17, 60, 23) backImage:[UIImage imageNamed:@"cabinButton.png"] target:self action:@selector(preordain:)];
		[self addSubview:self.roomButton];
		
		self.roomNoButton = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-80, 17, 60, 23) image:[UIImage imageNamed:@"cabinNoButton.png"] ];
		self.roomNoButton.hidden = YES;
		[self addSubview:self.roomNoButton];

		
		//点击展开视图按钮
		
		self.roomRuleButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(10, 0, ViewWidth-100, 55) backImage:nil target:self action:@selector(detail:)];
		
		[self addSubview:self.roomRuleButton];
		
		
		_roomView = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 55.0f, ViewWidth-20, 80.0f)];
		self.roomView.hidden = YES;
		[self.contentView addSubview:self.roomView];
		
		_hotelImageView = [[AsyncImageView alloc]initWithFrame:CGRectMake(10.0f, 5.0f, 70.0f, 69.0f)];
		self.hotelImageView.defaultImage = 1;
		[self.roomView addSubview:self.hotelImageView];
		
		
		UIImageView *breakfastImg = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-220, 5.0f, 20.0f, 20.0f) image:[UIImage imageNamed:@"breakfastImg.png"]];
		[self.roomView addSubview: breakfastImg];
		
		self.breakfastLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-190, 5.0f, 55.0f, 20.0f) font:FontSize24  alignment:NSTextAlignmentLeft];
		self.breakfastLabel.textColor = FontColor454545;
		[self.roomView addSubview:self.breakfastLabel];
		
		UIImageView *networkImg = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-120, 5.0f, 20.0f, 20.0f) image:[UIImage imageNamed:@"networkImg.png"]];
		networkImg.backgroundColor = [UIColor redColor];
		[self.roomView addSubview: networkImg];
		
		self.networkLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-90, 5.0f, 55.0f, 20.0f) font:FontSize26  alignment:NSTextAlignmentLeft];
		
		self.networkLabel.textColor = FontColor454545;
		[self.roomView addSubview:self.networkLabel];
		
		
		UIImageView *areaImg = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-220, 30.0f, 20.0f, 20.0f) image:[UIImage imageNamed:@"areaImg.png"]];
		
		[self.roomView addSubview: areaImg];
		
		self.areaLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-190, 30.0f, 70.0f, 20.0f) font:FontSize26  alignment:NSTextAlignmentLeft];
		self.areaLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.areaLabel.numberOfLines = 1;
		self.areaLabel.textColor = FontColor454545;
		[self.roomView addSubview:self.areaLabel];
		
		UIImageView *floorImg = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-120, 30.0f, 20.0f, 20.0f) image:[UIImage imageNamed:@"floorImg.png"]];
		
		[self.roomView addSubview: floorImg];
		
		self.floorLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-90, 30.0f, 70.0f, 20.0f) font:FontSize26  alignment:NSTextAlignmentLeft];
		self.floorLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.floorLabel.numberOfLines = 1;
		self.floorLabel.textColor = FontColor454545;
		[self.roomView addSubview:self.floorLabel];
		
		UIImageView *bedTypeImg = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-220, 55.0f, 20.0f, 20.0f) image:[UIImage imageNamed:@"bedType.png"]];
		
		[self.roomView addSubview: bedTypeImg];
		
		self.bedTypeLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-190, 55.0f, 160.0f, 20.0f) font:FontSize26  alignment:NSTextAlignmentLeft];
		
		self.bedTypeLabel.textColor = FontColor454545;
		[self.roomView addSubview:self.bedTypeLabel];
		
		
		
	}
	self.backgroundColor = [UIColor clearColor];
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}



//预订
-(void)preordain:(id)sender
{
	
	if (delegate) 
	{
		[delegate preordainClick:sender];
	}
}

//详情
-(void)detail:(id)sender
{
	
	if (delegate) 
	{
		[delegate detailClick:sender];
	}
}



- (void) dealloc {
	
	self.roomName = nil;
	self.roomPrice = nil;
	self.roomReturnLcdFee = nil;
	self.breakfastLabel = nil;
	self.networkLabel = nil;
	self.areaLabel = nil;
	self.floorLabel = nil;
	self.bedTypeLabel = nil;
	self._returnLcdView = nil;
        self.delegate = nil;
	self.roomView = nil;
	self.roomButton = nil;
	self.roomNoButton =nil;
	self.roomRuleButton = nil;
	self.hotelImageView = nil;
	[_roomView release];
	[_hotelImageView release];
	[super dealloc];	
}

@end
