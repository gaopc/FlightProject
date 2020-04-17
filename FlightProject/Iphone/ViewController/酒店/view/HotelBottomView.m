//
//  HotelBottomView.m
//  FlightProject
//
//  Created by green kevin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelBottomView.h"

@implementation HotelBottomView
@synthesize startDayLabel,endDayLabel,mapImgView,listImgView,mapButton,listButton,delegate;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		self.backgroundColor = [UIColor clearColor];
		bottomView = [UIImageView ImageViewWithFrame:self.bounds image:[UIImage imageNamed:@"HotelListbottom.png"]];
		[self addSubview:bottomView];
		
		startDayLabel = [UISubLabel labelWithTitle:@"2012-09-03 周四入住" frame:CGRectMake(15.0f, 18.0f, 130.0f, 18.5f) font:FontSize24 alignment:NSTextAlignmentLeft];
		startDayLabel.textColor = FontColorFFFFFF;
		
		[self addSubview:startDayLabel];
		
		endDayLabel = [UISubLabel labelWithTitle:@"2012-09-05 周六离店" frame:CGRectMake(150.0f, 18.0f, 130.0f, 18.5f) font:FontSize24 alignment:NSTextAlignmentLeft];
		endDayLabel.textColor = FontColorFFFFFF;
		[self addSubview:endDayLabel];
		
		self.mapImgView = [UIImageView ImageViewWithFrame:CGRectMake(285.0f, 16.0f, 21.0f, 20.5f) image:[UIImage imageNamed:@"HotelMapIcon.png"]];
		self.mapImgView.hidden = NO;
		self.mapImgView.tag = 200;
		[self addSubview:self.mapImgView];
		
		self.listImgView = [UIImageView ImageViewWithFrame:CGRectMake(285.0f, 16.0f, 21.0f, 20.5f) image:[UIImage imageNamed:@"HotelListIcon.png"]];
		self.listImgView.hidden = YES;
		self.listImgView.tag = 201;
		[self addSubview:self.listImgView];
		
		self.mapButton = [UIButton buttonWithType:UIButtonTypeCustom tag:100 title:@"" frame:CGRectMake(260.0f, 5.0f, 60.0f,  40.0f) backImage:nil target:self action:@selector(map:)];
		self.mapButton.hidden = NO;
		[self addSubview:self.mapButton];
		
		self.listButton = [UIButton buttonWithType:UIButtonTypeCustom tag:101 title:@"" frame:CGRectMake(260.0f, 5.0f,  60.0f,  40.0f) backImage:nil target:self action:@selector(map:)];
		self.listButton.hidden = YES;
		[self addSubview:self.listButton];
		
		
	}
	return self;
}

//地图
-(void)map:(id)sender
{
	
	if (delegate) 
	{
		[delegate mapClick:sender];
	}
}



- (void) dealloc {
	
	
        self.delegate = nil;
	self.listImgView = nil;
	self.mapImgView = nil;
	self.mapButton = nil;
	self.listButton = nil;
	self.startDayLabel = nil;
	self.endDayLabel = nil;
	[super dealloc];	
}

@end
