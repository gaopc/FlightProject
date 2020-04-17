//
//  DepreciateInfoViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DepreciateInfoViewController.h"
#import "PushRecordViewController.h"
#import "AutomaticallyDataResponse.h"
@interface DepreciateInfoViewController ()
- (NSString *) disCalculated:(NSString *)discount;
@end

@implementation DepreciateInfoViewController
@synthesize automaticallyInfo;
@synthesize pushDetailArray;

- (void)loadView{
	
	[super loadView];
	
	UIImageView *autoTopImg=[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, 156.0f)];
	autoTopImg.image=[UIImage imageNamed:@"AutoDepreciateTop.png"];
	[self.view addSubview:autoTopImg];
	
	
	//航空公司小图标
	smallIcons=[UIImageView ImageViewWithFrame:CGRectMake(7.0f, 8.0f, 15.0f, 15.0f)];
	smallIcons.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[self.automaticallyInfo._flightNo substringToIndex:2]]];
	[self.view addSubview:smallIcons];
	//航空公司
	airlineLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(25.0f, 5.0f, 100.0f, 22.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
	airlineLabel.textColor = FontColor333333;
	airlineLabel.text = [NSString stringWithFormat:@"%@%@",self.automaticallyInfo._airline,self.automaticallyInfo._flightNo];
	[self.view addSubview:airlineLabel];
	//机型
	planeTypeLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(150.0f, 5.0f, 80.0f, 22.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
	planeTypeLabel.textColor = FontColor333333;
	planeTypeLabel.text = [NSString stringWithFormat:@"%@%@",@"机型: ",self.automaticallyInfo._planeType];
	[self.view addSubview:planeTypeLabel];
	//时间
	createDateLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth - 85, 5.0f, 80.0f, 20.0f) font:FontSize24 alignment:NSTextAlignmentRight];
	createDateLabel.textColor = FontColor333333;
	createDateLabel.text = self.automaticallyInfo._startDate;
	[self.view addSubview:createDateLabel];
	
	
	//起飞城市
	departureLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(25.0f, 35.0f, 100.0f, 25.0f) font:FontSize40 alignment:NSTextAlignmentCenter];
	departureLabel.textColor = FontColor000000;
	departureLabel.text = self.automaticallyInfo._departure;
	[self.view addSubview:departureLabel];
	
	//起飞时间
	startTimeLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(25.0f, 58.0f, 100.0f, 25.0f) font:FontSize40 alignment:NSTextAlignmentCenter];
	startTimeLabel.textColor = FontColor000000;
	startTimeLabel.text = self.automaticallyInfo._startTime;
	[self.view addSubview:startTimeLabel];
	
	NSString *startAirport = self.automaticallyInfo._startAirport;
	startAirport = [startAirport stringByAppendingString:self.automaticallyInfo._startTerminal];
	
	
	//起飞机场
	startAirportLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(15.0f, 85.0f, 125.0f, 22.0f) font:FontSize22 alignment:NSTextAlignmentCenter];
	startAirportLabel.textColor = FontColor636363;
	startAirportLabel.text = startAirport; //self.automaticallyInfo._startAirport;
	[self.view addSubview:startAirportLabel];
	
	//箭头
	UIImageView *arrowIcons=[UIImageView ImageViewWithFrame:CGRectMake((ViewWidth - 24)/2, 58.0f, 24.0f, 21.0f)];
	arrowIcons.image=[UIImage imageNamed:@"cabinArrows.png"];
	[self.view addSubview:arrowIcons];
	
	
	
	//降落城市
	arrivalLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth - 140, 35.0f, 100.0f, 25.0f) font:FontSize40 alignment:NSTextAlignmentCenter];
	arrivalLabel.textColor = FontColor000000;
	arrivalLabel.text = self.automaticallyInfo._arrival;
	[self.view addSubview:arrivalLabel];
	
	//降落时间
	endTimeLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth - 140, 58.0f, 100.0f, 25.0f) font:FontSize40 alignment:NSTextAlignmentCenter];
	endTimeLabel.textColor = FontColor000000;
	endTimeLabel.text = self.automaticallyInfo._endTime;
	[self.view addSubview:endTimeLabel];
	
	NSString *endAirport = self.automaticallyInfo._endAirport;
	endAirport = [endAirport stringByAppendingString:self.automaticallyInfo._endTerminal];
	
	//降落机场
	endAirportLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth - 150, 85.0f, 120.0f, 22.0f) font:FontSize22 alignment:NSTextAlignmentCenter];
	endAirportLabel.textColor = FontColor636363;
	endAirportLabel.text = endAirport;
	[self.view addSubview:endAirportLabel];
	
	
	//舱位
	
	NSString *cabin=self.automaticallyInfo._cabin;
	cabin=[cabin stringByAppendingString:@"("];
	cabin=[cabin stringByAppendingString:self.automaticallyInfo._cabinCode];
	cabin=[cabin stringByAppendingString:@")"];
	
	cabinLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(5.0f, 112.0f, 145.0f, 25.0f) font:FontBlodSize38 alignment:NSTextAlignmentCenter];
	cabinLabel.textColor = FontColor636363;
	
	cabinLabel.text = cabin; //self.automaticallyInfo._cabin;
	[self.view addSubview:cabinLabel];
	
	//人民币标示
	UISubLabel *flagLabel1 = [UISubLabel labelWithTitle:@"￥" frame:CGRectMake(160.0f, 123.0f, 10.0f, 10.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
	flagLabel1.textColor = FontColor636363;
	[self.view addSubview:flagLabel1];
	
	long origin_x = 123.0f;
	//总金额
	ticketPriceLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth - 147, 112.0f, 95.0f, 25.0f) font:FontBlodSize38 alignment:NSTextAlignmentLeft];
	ticketPriceLabel.textColor = FontColor636363;
	ticketPriceLabel.text =  [NSString stringWithFormat:@"%@",self.automaticallyInfo._ticketPrice];
	[self.view addSubview:ticketPriceLabel];
	
	origin_x+=ticketPriceLabel.frame.size.width;
	
	//折扣
//	NSString *discount=@"(";
//	discount = [discount stringByAppendingString:[NSString stringWithFormat:@"%d",[self.automaticallyInfo._discount intValue]/10]];
//	discount = [discount stringByAppendingString:@")折"];
	
	NSString *discount = [self disCalculated:self.automaticallyInfo._discount];
	
	discountLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, 110.0f, 50.0f, 30.0f) font:FontBlodSize26 alignment:NSTextAlignmentCenter];
	discountLabel.textColor = FontColor636363;
	discountLabel.text = discount;
	[self.view addSubview:discountLabel];
	
	
	UIImageView *autoCenterImg=[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 146.0f, ViewWidth, 66.0f)];
	autoCenterImg.image=[UIImage imageNamed:@"AutoDepreciateGoodBg.png"];
	[self.view addSubview:autoCenterImg];
	
	UISubLabel *titleLabel = [UISubLabel labelWithTitle:@"当前推送价格" frame:CGRectMake(10.0f, 150.0f, 120.0f, 22.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel.textColor = FontColor2985DF;
	[self.view addSubview:titleLabel];
	
	//推送舱位类型
	
	origin_x = 10.0f;
	
	NSString *pushCabin=self.automaticallyInfo._pushCabin;
	pushCabin=[pushCabin stringByAppendingString:@"("];
	pushCabin=[pushCabin stringByAppendingString:self.automaticallyInfo._pushCabinCode];
	pushCabin=[pushCabin stringByAppendingString:@")"];
	
	pushCabinLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(10.0f, 170.0f, 120.0f, 30.0f) font:FontSize36 alignment:NSTextAlignmentLeft];
	pushCabinLabel.textColor = FontColor333333;
	pushCabinLabel.text = pushCabin; //self.automaticallyInfo._pushCabin;
	[self.view addSubview:pushCabinLabel];
	
	origin_x += pushCabinLabel.frame.size.width;
	//人民币标示
	UISubLabel *flagLabel2 = [UISubLabel labelWithTitle:@"￥" frame:CGRectMake(origin_x, 184.0f, 10.0f, 10.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	flagLabel2.textColor = FontColor333333;
	[self.view addSubview:flagLabel2];
	
	origin_x += flagLabel2.frame.size.width+1.0f;
	
	//推送总金额
	pushPriceLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, 170.0f, 50.0f, 30.0f) font:FontBlodSize38 alignment:NSTextAlignmentLeft];
	pushPriceLabel.textColor = FontColor333333;
	pushPriceLabel.backgroundColor = [UIColor clearColor];
	pushPriceLabel.text = [NSString stringWithFormat:@"%@",self.automaticallyInfo._pushPrice];
	[self.view addSubview:pushPriceLabel];
	
	origin_x += pushPriceLabel.frame.size.width;
	
	//推送折扣
//	NSString *pushDiscount=@"(";
//	pushDiscount = [pushDiscount stringByAppendingString:[NSString stringWithFormat:@"%d",[self.automaticallyInfo._discount intValue]/10]];
//	pushDiscount = [pushDiscount stringByAppendingString:@")折"];
	
	NSString *pushDiscount = [self disCalculated:self.automaticallyInfo._pushDiscount];
	
	pushDiscountLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, 170.0f, 45.0f, 30.0f) font:FontBlodSize26 alignment:NSTextAlignmentLeft];
	pushDiscountLabel.textColor = FontColor696969;
	pushDiscountLabel.text = pushDiscount;
	[self.view addSubview:pushDiscountLabel];
	
	origin_x += pushDiscountLabel.frame.size.width + 10;
	
	//人民币标示
	UISubLabel *flagLabel3 = [UISubLabel labelWithTitle:@"省" frame:CGRectMake(origin_x, 176.0f, 19.0f, 17.0f) font:FontBlodSize38 alignment:NSTextAlignmentLeft];
	flagLabel3.textColor = FontColorF94C00;
	[self.view addSubview:flagLabel3];
	origin_x += flagLabel3.frame.size.width;
	//人民币标示
	UISubLabel *flagLabel4 = [UISubLabel labelWithTitle:@"￥" frame:CGRectMake(origin_x, 183.0f, 10.0f, 10.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
	flagLabel4.textColor = FontColorF94C00;
	[self.view addSubview:flagLabel4];
	origin_x += flagLabel4.frame.size.width;
	savingLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x+1, 170.0f, 100.0f, 30.0f) font:FontBlodSize38 alignment:NSTextAlignmentLeft];
	savingLabel.textColor = FontColorF94C00;
	savingLabel.text = [NSString stringWithFormat:@"%d",([self.automaticallyInfo._savingPrice intValue])];
	[self.view addSubview:savingLabel];
	
	callButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"" frame:CGRectMake((ViewWidth - 250)/2, ViewHeight-210.0f, 250.0f, 45.0f) backImage:[UIImage imageNamed:@"AutoDepreciateCall.png"] target:self action:@selector(call:)];
	[self.view addSubview:callButton];
	
	if ([self.automaticallyInfo._type boolValue]) {
		[callButton setBackgroundImage:[UIImage imageNamed:@"AutoDepreciateNoCall.png"] forState:UIControlStateNormal];
		callButton.userInteractionEnabled = NO;
	}
	
	pushRecordButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(10.0f, ViewHeight-130.0f, ViewWidth - 20, 48.5) backImage:[UIImage imageNamed:@"MemberRegisterButton.png"] target:self action:@selector(push:)];
	[pushRecordButton setTitleColor:[UIColor colorWithWhite:1 alpha:1] forState:UIControlStateNormal];
	[pushRecordButton setTitleColor:[UIColor colorWithWhite:1 alpha:1] forState:UIControlStateHighlighted];
	[pushRecordButton.titleLabel  setFont:[UIFont boldSystemFontOfSize: 17.5f]];
	[self.view addSubview:pushRecordButton];
	
	UISubLabel *pushTitle = [UISubLabel labelWithTitle:@"查看推送记录" frame:CGRectMake(33.0f, ViewHeight-122.0f, 150.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	pushTitle.textColor = FontColor333333;
	[self.view addSubview:pushTitle];
	
	
}
// 计算自动降价折扣
- (NSString *) disCalculated:(NSString *)discount
{
	NSString *fd  = @"";
	float _discount = [discount floatValue]/100;
	if(_discount < 1.0){
		fd = [NSString stringWithFormat:@"(%.1f%@)",_discount*10,@"折"];
	}else if(_discount > 1.0){
		fd = [NSString stringWithFormat:@"%@%@", discount, @"%"];
		
	}else if(_discount == 1.0){
		fd = [NSString stringWithFormat:@"(%@)",@"全价"];
	}
	return fd;
}

-(void)call:(id)sender
{
    [self callTel:@"400-6858-999"];	
}


-(void)push:(id)sender
{
	PushRecordViewController * pushRecordVC = [[PushRecordViewController alloc] init];
	pushRecordVC.pushRecordArray = self.pushDetailArray;
	pushRecordVC.ticketPrice = self.automaticallyInfo._ticketPrice;
	[NavigationController pushViewController:pushRecordVC animated:YES];
	[pushRecordVC release];
}


- (void)dealloc
{
	self.automaticallyInfo = nil;
	self.pushDetailArray = nil;
	[super dealloc];
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"自动降价推送内容";
	
	
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

@end
