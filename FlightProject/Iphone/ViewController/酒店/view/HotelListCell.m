//
//  HotelListCell.m
//  FlightProject
//
//  Created by green kevin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelListCell.h"

@implementation HotelListCell
@synthesize hotelImageView = _hotelImageView;
@synthesize lowerImageView,returnLcdImage,lowestPrice,returnLcdFee,hotelName,rating,districtName;
@synthesize _returnLcdView,markValueView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		
		leftImageView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 0.0f, ViewWidth-100, 75.0f) image:[UIImage imageNamed:@"TicketListLeft.png"]];
		[self.contentView addSubview:leftImageView];
		
		rightImageView = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-90, 0.0f, 80.0f, 75.0f) image:[UIImage imageNamed:@"TicketListRight.png"]];
		[self.contentView addSubview:rightImageView];
		
		_hotelImageView = [[AsyncImageView alloc]initWithFrame:CGRectMake(14.0f, 2.5f, 70.0f, 68.0f)];
		self.hotelImageView.defaultImage = 1;
		[self.contentView addSubview:self.hotelImageView];
		
		self.hotelName =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(95.0f, 13.0f, 125.0f, 18.0f) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
		[self.contentView addSubview:self.hotelName];
		
		self.lowerImageView = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-35, 0.0f, 20.0f, 20.0f) image:[UIImage imageNamed:@"TicketListLower.png"]];
		self.lowerImageView.hidden = YES;
		[self.contentView addSubview:lowerImageView];
		
		
		
		UIImageView *lineImageView=[UIImageView ImageViewWithFrame:CGRectMake(95.0f, 52.0f, ViewWidth-195, 1.0f)];
		lineImageView.image=[UIImage imageNamed:@"HotelSmallLine.png"];
		[self.contentView addSubview:lineImageView];
		
		self.rating =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(100.0f, 55.0f, 60.0f, 16.0f) font:FontSize22 color:FontColor454545 alignment:NSTextAlignmentLeft];
		
		[self.contentView addSubview:self.rating];
		
		
		self.districtName =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-140, 55.0f, 45.0f, 16.0f) font:FontSize22 color:FontColor454545 alignment:NSTextAlignmentLeft];
		
		[self.contentView addSubview:self.districtName];
		
		//人民币标示
		UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"￥" frame:CGRectMake(ViewWidth-85, 30.0f, 10.0f, 10.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
		titleLabel1.textColor = FontColorFF8813;
		[self.contentView addSubview:titleLabel1];
		//245, 20, 70, 20 font:FontSize48 color:FontColorFF8813
		self.lowestPrice =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-75, 20.0f, 70.0f, 20.0f) font:FontSize48 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
		[self.contentView addSubview:lowestPrice];
		
//		UISubLabel *titleLabel2 = [UISubLabel labelWithTitle:@"起" frame:CGRectMake(291.0f, 30.0f, 12.0f, 10.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
//		titleLabel2.textColor = FontColorFF8813;
//		[self.contentView addSubview:titleLabel2];
		
		UIView * view = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth-90, 52.0f, 50.0f, 20.0f)];
		self._returnLcdView = view;
		[view release];
		
		self.returnLcdImage = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 20.0f) image:[UIImage imageNamed:@"TicketListReturnCdb.png"]];
		[self._returnLcdView addSubview:self.returnLcdImage];
		
		self.returnLcdFee =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(0.0f, 0.0f, 50.0f, 16.0f) font:FontSize24 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
		[self._returnLcdView addSubview:self.returnLcdFee];
		
		[self.contentView addSubview:self._returnLcdView];

	}
    self.backgroundColor = [UIColor clearColor];
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

-(void)drawStarCodeView:(int) markValue{
	
	if (self.markValueView)
		[self.markValueView removeFromSuperview];
	
	self.markValueView= [[UIView alloc] initWithFrame:CGRectMake(95.0f, 34, 75, 18 )];
	
	for (int i=0; i<5; i++) {
		
		if (markValue>=1) {
			
		        UIImageView *starGreenImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*14.5, 0, 13, 13)];
			starGreenImg.image = [UIImage imageNamed:@"Star_Golden.png"]; //选中			
			[self.markValueView addSubview:starGreenImg];
			[starGreenImg release];
			markValue--;
			continue;
			
	        }else {
			UIImageView *starWhiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*14.5, 0, 13, 13)];
			starWhiteImg.image = [UIImage imageNamed:@"Star_Gray.png"];
			[self.markValueView addSubview:starWhiteImg];
			[starWhiteImg release];
			
		}
	}
	[self.contentView addSubview:self.markValueView];
	[self.markValueView release];
	
}


-(void)drawDiamondCodeView:(int) markValue{
	
	if (self.markValueView)
		[self.markValueView removeFromSuperview];
	
	self.markValueView= [[UIView alloc] initWithFrame:CGRectMake(95.0f, 35, 75, 18 )];
	
	for (int i=0; i<5; i++) {
		
		if (markValue>=1) {
			
		        UIImageView *starGreenImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*13.5, 0, 12, 11)];
			starGreenImg.image = [UIImage imageNamed:@"Diamond_Golden.png"]; //选中
			[self.markValueView addSubview:starGreenImg];
			[starGreenImg release];
			markValue--;
			continue;
			
	        }else {
			UIImageView *starWhiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*13.5, 0, 12, 11)];
			starWhiteImg.image = [UIImage imageNamed:@"Diamond_Gray.png"];
			[self.markValueView addSubview:starWhiteImg];
			[starWhiteImg release];
			
		}
	}
	[self.contentView addSubview:self.markValueView];
	[self.markValueView release];
	
}


- (void) dealloc {
	
	
	self.hotelImageView = nil;
	[_hotelImageView release];
	self.lowerImageView = nil;
	self.returnLcdImage = nil;
	self.lowestPrice = nil;
	self.returnLcdFee = nil;
	self.hotelName = nil;
	self.rating = nil;
	self.districtName = nil;
        self._returnLcdView = nil;
	self.markValueView = nil;
	[super dealloc];
	
}

@end




@implementation HotelTJListCell
@synthesize title,number,tjImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		
		leftImageView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 0.0f, 220.0f, 75.0f) image:[UIImage imageNamed:@"TicketListLeft.png"]];
		[self.contentView addSubview:leftImageView];
		
		rightImageView = [UIImageView ImageViewWithFrame:CGRectMake(230.0f, 0.0f, 80.0f, 75.0f) image:[UIImage imageNamed:@"TicketListRight.png"]];
		[self.contentView addSubview:rightImageView];
		
		tjImageView = [[UIImageView alloc]initWithFrame:CGRectMake(14.0f, 2.5f, 70.0f, 68.0f)];
		tjImageView.image = [UIImage imageNamed:@"SpecialOffer.png"];

		[self.contentView addSubview:self.tjImageView];
		self.title =   [UISubLabel labelWithTitle:@"今日特价酒店" frame:CGRectMake(95.0f, 25.0f, 125.0f, 22.0f) font:FontSize36 color:FontColorFF1515 alignment:NSTextAlignmentLeft];
		
		[self.contentView addSubview:self.title];
		
		self.number =   [UISubLabel labelWithTitle:@"" frame:CGRectMake(230.0f, 25.0f, 75.0f, 22.0f) font:FontSize38 color:FontColorFF1515 alignment:NSTextAlignmentCenter];
		[self.contentView addSubview:number];
		

		
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
	self.title = nil;
	self.number = nil;
	self.tjImageView = nil;

	[super dealloc];
	
}

@end
