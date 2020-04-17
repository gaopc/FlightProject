//
//  AppointmentSettingViewController.m
//  FlightProject
//
//  Created by 崔立东 on 12-9-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  预约设置
//

#import "AppointmentSettingViewController.h"
#import "CityListViewController.h"
#import "TicketQueryViewController.h"
#import "DatePickerViewController.h"
#import "TicketAppointmentDataResponse.h"
#import "TicketAppointmentViewController.h"


#define kViewTag 1
static NSString *kViewKey = @"viewKey";
@interface AppointmentSettingViewController ()
- (void)loadDataSource;
@end

@implementation AppointmentSettingViewController
@synthesize queryDataModel=_queryDataModel;
@synthesize s_tableView = _s_tableView;
@synthesize dataSourceArray;
@synthesize cityView,dateView,flightTimeView,smsView,saleView;
@synthesize buttonSelect, server;

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if (self.queryDataModel) {
	   [self loadDataSource];
	   [self.s_tableView reloadData];
	}
}

- (void)loadView{
	
	[super loadView];
	self.title=@"添加机票预约";
	
	long origin_y = 3.0f;
	
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y, ViewWidth-10.0f, 28.0f)];
	[topView setImage:[UIImage imageNamed:@"appointmentFrameTop.png"]];
	[self.view addSubview:topView];
	
	origin_y += topView.frame.size.height;
	
	_s_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,origin_y,ViewWidth,ViewHeight-150.0f) style:UITableViewStylePlain];  
	self.s_tableView.backgroundColor = [UIColor clearColor];
	self.s_tableView.dataSource = self;
	self.s_tableView.delegate = self;
	self.s_tableView.showsVerticalScrollIndicator=YES;
        self.s_tableView.separatorColor = [UIColor clearColor];
		
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y, 310.0f, self.s_tableView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"TicketQueryCenter.png"]];
	[self.view addSubview:centerView];
	
	[self.view addSubview:self.s_tableView];
	
	origin_y+= self.s_tableView.frame.size.height;
	
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y, 310.0f, 18.0f)];
	[bottom setImage:[UIImage imageNamed:@"TicketQueryShadow.png"]];
	[self.view addSubview:bottom];
	
	//提交预约按钮
	submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(50.0f, ViewHeight-100.0f, 225.5f, 45.0f) backImage:[UIImage imageNamed:@"SubmitAppointmentButton.png"] target:self action:@selector(appointment:)];
	[self.view addSubview:submitButton];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
   
	buttonSelect = @"0";
	_queryDataModel = [[TicketQueryDataModel alloc] init];
	
	self.queryDataModel._fromCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:@"北京"  code:@"PEK" ];
	self.queryDataModel._toCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:@"上海"  code:@"SHA" ];
	//self.queryDataModel._startDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[NSDate dateFormateTicketQuery:[NSDate date]] code:[NSDate dateCode:[NSDate date] ]];
	
	self.queryDataModel._startDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate date] day:PushBackOneDay type:3] code: [NSDate dateafterDay:[NSDate date] day:PushBackOneDay type:1]];
	self.queryDataModel._arriveDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate date] day:PushBackEightDay type:3] code: [NSDate dateafterDay:[NSDate date] day:PushBackEightDay type:1]];

	
	//初始化起飞时间段和短信接收时间段底部图片
	timePeriodArray = [[NSMutableArray alloc] init];
	for (int i=0; i<=24; i++) {
		NSString* tempTimeStr = [NSString stringWithFormat:@"bottom_%d.png",i];
		[timePeriodArray addObject:tempTimeStr];
		
		
	}
	//初始化舱位折扣段底部图片
	saleArray =  [[NSMutableArray alloc] init];
	for (int i=4; i<=8; i++) {
		NSString* tempSaleStr = [NSString stringWithFormat:@"saleBottom_%d.png",i];
		[saleArray addObject:tempSaleStr];
		
		
	}

	[self loadDataSource];
	[_s_tableView reloadData];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	self.s_tableView = nil;
	// Release any retained subviews of the main view.
}


- (void) dealloc {
     
	self.server = nil;
	self.buttonSelect = nil;
	self.queryDataModel = nil;
	self.dataSourceArray = nil;
	[_queryDataModel release];
	[super dealloc];
	
}


//加载数据
- (void)loadDataSource
{
	//设置页面展示UIView
	self.dataSourceArray = [NSArray arrayWithObjects:
				[NSDictionary dictionaryWithObjectsAndKeys:
				 self.cityView, kViewKey,
				 nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 self.dateView, kViewKey,
				 nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 self.flightTimeView, kViewKey,
				 nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 self.smsView, kViewKey,
				 nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 self.saleView, kViewKey,
				 nil],
				
				nil] ;
}


//城市视图
- (UIView *)cityView
{
	if (cityView == nil)
	{
		cityView = [[[UIView alloc]initWithFrame:CGRectMake(10.0f, 0.0f, self.s_tableView.frame.size.width-20.0f, 70.0f)]autorelease];
		UISubLabel *sallyCityTitleLabel = [UISubLabel labelWithTitle:@"出发城市" frame:CGRectMake(45.0f, 0.0f, 60.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
		sallyCityTitleLabel.textColor = FontColor909090;
		[cityView addSubview:sallyCityTitleLabel];
		
		UISubLabel *arriveCityTitleLabel = [UISubLabel labelWithTitle:@"到达城市" frame:CGRectMake(210.0f, 0.0f, 60.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
		arriveCityTitleLabel.textColor = FontColor909090;
		[cityView addSubview:arriveCityTitleLabel];


		sallyCityViewLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(15.0f, 17.0f, 90.0f, 45.0f) font:FontBlodSize42 alignment:NSTextAlignmentCenter];
		sallyCityViewLabel.backgroundColor = [UIColor clearColor];
		sallyCityViewLabel.textColor = FontColor333333;
		[cityView addSubview:sallyCityViewLabel];
		
		[cityView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(110.0f, 34.0f, 8.0f, 13.0f) image:[UIImage imageNamed:@"CellArrow.png"]]];
		
		//出发城市点击按钮
		UIButton *sallyCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
		sallyCityButton.frame = CGRectMake(0.0f, 15.0f, 115.0f, 45.0f);
		sallyCityButton.backgroundColor = [UIColor clearColor];
		sallyCityButton.tag = 100;
		[sallyCityButton addTarget:self action:@selector(city:) forControlEvents:UIControlEventTouchUpInside];
		[cityView addSubview:sallyCityButton];
		
		
		
//		UIImageView *goAndBackImageView=[UIImageView ImageViewWithFrame:CGRectMake(120.0f, 6.0f, 54.0f, 54.0f)];
//		goAndBackImageView.image=[UIImage imageNamed:@"TicketQueryChange.png"];
//		[cityView addSubview:goAndBackImageView];
		
		UIButton *exchangeButton = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"TicketQueryChange.png"] frame:CGRectMake(128, 10.0f, 54.0f, 54.0f) target:self action:@selector(exchangeCity) ];
		[cityView addSubview:exchangeButton];
		
		arriveCityViewLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(183.0f, 17.0f, 90.0f, 45.0f) font:FontBlodSize42 alignment:NSTextAlignmentCenter];
		arriveCityViewLabel.textColor = FontColor333333;
		arriveCityViewLabel.backgroundColor = [UIColor clearColor];
		[cityView addSubview:arriveCityViewLabel];
		
		[cityView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(280.0f, 34.0f, 8.0f, 13.0f) image:[UIImage imageNamed:@"CellArrow.png"]]];
		
		//到达城市点击按钮
		UIButton *arriveCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
		arriveCityButton.frame = CGRectMake(180.0f, 15.0f, 115.0f, 45.0f);
		arriveCityButton.backgroundColor = [UIColor clearColor];
		arriveCityButton.tag = 101;
		[arriveCityButton addTarget:self action:@selector(city:) forControlEvents:UIControlEventTouchUpInside];
		[cityView addSubview:arriveCityButton];
		
		cityView.tag=kViewTag;		
	}
	
	sallyCityViewLabel.text = self.queryDataModel._fromCity._nameStr;
	arriveCityViewLabel.text = self.queryDataModel._toCity._nameStr;
	
	
	UIImageView *lineImageView=[UIImageView ImageViewWithFrame:CGRectMake(10.0f, 71.0f, 280.0f, 1.0f)];
	lineImageView.image=[UIImage imageNamed:@"TicketQueryDottedLine.png"];
	[cityView addSubview:lineImageView];
	
	return cityView;
}



- (void)city :(id)sender {
	UIButton *button = (UIButton *)sender;
	self.buttonSelect = [NSString stringWithFormat:@"%ld", (long)button.tag];
    
    NSArray * array =  [DataClass selectFromAirportCityList];
    if ( [GetConfiguration shareGetConfiguration].needUpdateAirportCityInfo || [array count] == 0) {
        GetBasicInfoFromServer * basicInfoFromserver = [[GetBasicInfoFromServer alloc] init] ;
        self.server = basicInfoFromserver;
        [basicInfoFromserver release];
        self.server.cityDelegate = self;
        [self.server getAirportCityInfo];
    }
    else {
        [self didCityInfoResult:array];
    }
//       array = [DataClass selectFromHotelCityList];
//
//    array = [DataClass selectFromCarRentalList];


	switch (button.tag) {
		case 100:
            currentDataModelElem = self.queryDataModel._fromCity; // zxt 20121027
			break;
		case 101:
            currentDataModelElem = self.queryDataModel._toCity; // zxt 20121027
			break;
		default:
			break;
	}
	
	
}
-(void)didSelectedCityFinshed:(id)city
{
    Citys * _city = (Citys *)city;
    currentDataModelElem._nameCode = _city._city_code;
    currentDataModelElem._nameStr = _city._city_name;
    [_s_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
}


-(void)exchangeCity
{
	TicketQueryDataModelElem * oneDataModel = self.queryDataModel._fromCity;
	TicketQueryDataModelElem * tempDataModel = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:oneDataModel._nameStr code:oneDataModel._nameCode];
	self.queryDataModel._fromCity = self.queryDataModel._toCity;
	self.queryDataModel._toCity = tempDataModel;

	sallyCityViewLabel.text = self.queryDataModel._fromCity._nameStr;
	arriveCityViewLabel.text = self.queryDataModel._toCity._nameStr;
}

//日期视图
- (UIView *)dateView
{
	if (dateView == nil)
	{
		dateView = [[[UIView alloc]initWithFrame:CGRectMake(10.0f, 0.0f, self.s_tableView.frame.size.width-20.0f, 100.0f)]autorelease];
		dateView.tag=kViewTag;
		UISubLabel *startDateLabel= [UISubLabel labelWithTitle:@"开始时间" frame:CGRectMake(40.0f, 5.0f, 60.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
		startDateLabel.textColor = FontColor909090;
		[dateView addSubview:startDateLabel];
		
		startWeekLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(20.0f, 22.0f, 35.0f, 50.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
		startWeekLabel.textColor = FontColor333333;
		[dateView addSubview:startWeekLabel];
		
		
		startDayLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(50.0f, 22.0f, 50.0f, 50.0f) font:FontBlodSize80 alignment:NSTextAlignmentLeft];
		startDayLabel.textColor = FontColor333333;
		[dateView addSubview:startDayLabel];
		
		UISubLabel *dayTitleLabel = [UISubLabel labelWithTitle:@"日" frame:CGRectMake(95.0f, 43.0f, 15.0f, 25.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
		dayTitleLabel.textColor = FontColor333333;
		[dateView addSubview:dayTitleLabel];
		
		[dateView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(110.0f, 34.0f, 8.0f, 13.0f) image:[UIImage imageNamed:@"CellArrow.png"]]];
		
		//开始日期点击按钮
		UIButton *startDayButton = [UIButton buttonWithType:UIButtonTypeCustom];
		startDayButton.frame = CGRectMake(20.0f, 10.0f, 115.0f, 55.0f);
		startDayButton.backgroundColor = [UIColor clearColor];
		startDayButton.tag = 200;
		[startDayButton addTarget:self action:@selector(data:) forControlEvents:UIControlEventTouchUpInside];
		[dateView addSubview:startDayButton];
		
		
		UISubLabel *endDateLabel = [UISubLabel labelWithTitle:@"结束时间" frame:CGRectMake(205.0f, 5.0f, 60.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
		endDateLabel.textColor = FontColor909090;
		[dateView addSubview:endDateLabel];
		
		endWeekLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(190.0f, 22.0f, 35.0f, 50.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
		endWeekLabel.textColor = FontColor333333;
		[dateView addSubview:endWeekLabel];
		

		
		endDayLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(220.0f, 22.0f, 50.0f, 50.0f) font:FontBlodSize80 alignment:NSTextAlignmentLeft];
		endDayLabel.textColor = FontColor333333;
		[dateView addSubview:endDayLabel];
		
		dayTitleLabel = [UISubLabel labelWithTitle:@"日" frame:CGRectMake(265.0f, 43.0f, 15.0f, 25.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
		dayTitleLabel.textColor = FontColor333333;
		[dateView addSubview:dayTitleLabel];
		
		[dateView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(280.0f, 34.0f, 8.0f, 13.0f) image:[UIImage imageNamed:@"CellArrow.png"]]];
		
		
		//结束日期点击按钮
		UIButton *endDayButton = [UIButton buttonWithType:UIButtonTypeCustom];
		endDayButton.frame = CGRectMake(165.0f, 10.0f, 115.0f, 55.0f);
		endDayButton.backgroundColor = [UIColor clearColor];
		endDayButton.tag = 201;
		[endDayButton addTarget:self action:@selector(data:) forControlEvents:UIControlEventTouchUpInside];
		[dateView addSubview:endDayButton];

		
	}
	startWeekLabel.text = [[self.queryDataModel._startDate._nameStr componentsSeparatedByString:@"-"] objectAtIndex:0];
	startDayLabel.text =  [[self.queryDataModel._startDate._nameStr componentsSeparatedByString:@"-"] objectAtIndex:1];

	endWeekLabel.text =  [[self.queryDataModel._arriveDate._nameStr componentsSeparatedByString:@"-"] objectAtIndex:0];
	endDayLabel.text = [[self.queryDataModel._arriveDate._nameStr componentsSeparatedByString:@"-"] objectAtIndex:1];
	
	UIImageView *lineImageView=[UIImageView ImageViewWithFrame:CGRectMake(10.0f, 71.0f, 280.0f, 1.0f)];
	lineImageView.image=[UIImage imageNamed:@"TicketQueryDottedLine.png"];
	[dateView addSubview:lineImageView];
	
	return dateView;
}

- (void)data :(id)sender {
	
	UIButton *button = (UIButton *)sender;
	DatePickerViewController * datePickerVC = [[DatePickerViewController alloc] init];
	datePickerVC.delayDays = PushBackSixDay;
	switch (button.tag) {
		case 200:
			datePickerVC.dateType = StarDate;
			datePickerVC.pushBackDay = PushBackOneDay;
			break;
		case 201:
			datePickerVC.dateType = BackDate;
			datePickerVC.pushBackDay = PushBackEightDay;
			break;
		default:
			break;
	}
	datePickerVC.isAppointment = 1;
	datePickerVC.allowShowMonths = AllowShowThreeMonths;
	datePickerVC.startDateTicketQueryDataModel = self.queryDataModel._startDate;
	datePickerVC.backDateTicketQueryDataModel= self.queryDataModel._arriveDate;
	
	[NavigationController pushViewController:datePickerVC animated:YES];
	[datePickerVC release];
	
	
}


//飞行时间段视图
- (UIView *)flightTimeView
{
	if (flightTimeView == nil)
	{
		flightTimeView = [[[UIView alloc]initWithFrame:CGRectMake(10.0f, 0.0f, self.s_tableView.frame.size.width-20.0f, 100.0f)]autorelease];
		flightTimeView.tag=kViewTag;	
		UISubLabel *flightLabel= [UISubLabel labelWithTitle:@"起飞时段" frame:CGRectMake(10.0f, 5.0f, 80.0f, 20.0f) font:[UIFont systemFontOfSize:13.0f] alignment:NSTextAlignmentLeft];
		[flightTimeView addSubview:flightLabel];
		UIView *tempView = [[[UIView alloc]initWithFrame:CGRectMake(10.0f, 25.0f, 280.0f, 65.0f)]autorelease];
		flightTimeSlider =[[[DoubleSlider alloc]initWithFrame:tempView.bounds WithArray:timePeriodArray withMinimumValue:6.0 withMaximumValue:24.0 withMinimumRange:2.0 withIntervalNumber:2 withElementNumber:10]autorelease];
                [tempView addSubview:flightTimeSlider];
                [flightTimeView addSubview:tempView];
		UIImageView *lineImageView=[UIImageView ImageViewWithFrame:CGRectMake(10.0f, 99.0f, 280.0f, 1.0f)];
		lineImageView.image=[UIImage imageNamed:@"TicketQueryDottedLine.png"];
		[flightTimeView addSubview:lineImageView];
	}
	return flightTimeView;
}
	
//短信接收时间段视图
- (UIView *)smsView
{
	if (smsView == nil)
	{
		smsView = [[[UIView alloc]initWithFrame:CGRectMake(10.0f, 0.0f, self.s_tableView.frame.size.width-20.0f, 100.0f)]autorelease];
		smsView.tag=kViewTag;	
		UISubLabel *smsLabel= [UISubLabel labelWithTitle:@"接收短信时段" frame:CGRectMake(10.0f, 5.0f, 100.0f, 20.0f) font:[UIFont systemFontOfSize:13.0f] alignment:NSTextAlignmentLeft];
		[smsView addSubview:smsLabel];
                UIView *tempView = [[[UIView alloc]initWithFrame:CGRectMake(10.0f, 25.0f, 280.0f, 65.0f)]autorelease];
                smsTimeSlider =[[[DoubleSlider alloc]initWithFrame:tempView.bounds WithArray:timePeriodArray withMinimumValue:0.0 withMaximumValue:24.0 withMinimumRange:2.0 withIntervalNumber:3 withElementNumber:9]autorelease];
                [tempView addSubview:smsTimeSlider];
                [smsView addSubview:tempView];
		UIImageView *lineImageView=[UIImageView ImageViewWithFrame:CGRectMake(10.0f, 99.0f, 280.0f, 1.0f)];
		lineImageView.image=[UIImage imageNamed:@"TicketQueryDottedLine.png"];
		[smsView addSubview:lineImageView];
		
	}
	return smsView;
}


//舱位折扣视图
- (UIView *)saleView
{
	if (saleView == nil)
	{
		saleView = [[[UIView alloc]initWithFrame:CGRectMake(10.0f, 0.0f,self.s_tableView.frame.size.width-20.0f, 100.0f)]autorelease];
		saleView.tag=kViewTag;	
		UISubLabel *saleLocationLabel= [UISubLabel labelWithTitle:@"舱位折扣" frame:CGRectMake(10.0f, 5.0f, 80.0f, 20.0f) font:[UIFont systemFontOfSize:13.0f] alignment:NSTextAlignmentLeft];
		[saleView addSubview:saleLocationLabel];
		
		UIView *tempView = [[[UIView alloc]initWithFrame:CGRectMake(5.0f, 25.0f, 280.0f, 75.0f)]autorelease];
		saleSlider =[[[SingleSlider alloc]initWithFrame:tempView.bounds WithArray:saleArray withMinimumValue:4.0 withMaximumValue:8.0 withMinimumRange:6.0 withElementNumber:5]autorelease];
		[tempView addSubview:saleSlider];
		[saleView addSubview:tempView];
		UIImageView *lineImageView=[UIImageView ImageViewWithFrame:CGRectMake(10.0f, 99.0f, 280.0f, 1.0f)];
		lineImageView.image=[UIImage imageNamed:@"TicketQueryDottedLine.png"];
		[saleView addSubview:lineImageView];

	}
	return saleView;
}


- (void)appointment:(id)sender {
	
	if ([self.queryDataModel._fromCity._nameStr isEqualToString:self.queryDataModel._toCity._nameStr]) {
		[UIAlertView alertViewWithMessage:@"出发城市和到达城市相同，请重新选择。" :@"提示"];
		return;
	}
	int dayInterval = [NSDate dayInterval:[NSDate dateFromString:self.queryDataModel._startDate._nameCode] withEndDay:[NSDate dateFromString:self.queryDataModel._arriveDate._nameCode]];
	if (dayInterval > PushBackSevenDay) {
		[UIAlertView alertViewWithMessage:@"开始日期和结束日期范围在七天内。" :@"提示"];
		return;
	}
	
	flyPeriod = (int)(flightTimeSlider.selectedMinimumValue + 0.5f);
	endPeriod = (int)(flightTimeSlider.selectedMaximumValue + 0.5f);
	smsTime = (int)(smsTimeSlider.selectedMinimumValue + 0.5f);
	endSmsTime = (int)(smsTimeSlider.selectedMaximumValue + 0.5f);
	cabinDiscount = (int)(saleSlider.mumValue + 0.5f);
        
	ASIFormDataRequest * theRequest = [InterfaceClass addReservation:[UserInfo sharedUserInfo].userID withCabinDiscount:[NSString stringWithFormat:@"%d",cabinDiscount] withDeparture:self.queryDataModel._fromCity._nameCode  withArrival:self.queryDataModel._toCity._nameCode withStarteDate:self.queryDataModel._startDate._nameCode withEndDate:self.queryDataModel._arriveDate._nameCode withFlyPeriod:[NSString stringWithFormat:@"%02d%@",flyPeriod,@":00"] withEndPeriod:[NSString stringWithFormat:@"%02d%@",endPeriod,@":00"] withSmsTime:[NSString stringWithFormat:@"%02d%@",smsTime,@":00"] withEndSmsTime:[NSString stringWithFormat:@"%02d%@",endSmsTime,@":00"]]; 
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onaddReservationPaseredResult:) Delegate:self needUserType:Member];
	
	
}

//返回处理
- (void)onaddReservationPaseredResult:(NSDictionary *)dic
{
	appointmentData = [TicketAppointmentDataResponse addReservation:dic];
	[UIAlertView alertViewWithMessage:appointmentData._message];
	
	[NavigationController popViewControllerAnimated:YES];
	[ticketAppointmentVC againQuoteDataSource];
	
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
	// Return the number of rows in the section.
	return [self.dataSourceArray count];
	//return 2;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{		
	if (indexPath.row == 0 || indexPath.row == 1) {
		return 70.0f;
	}else {
		return 100.0f;
	}
	
	
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell = nil;
	static NSString *tAppointmentCell_ID = @"AppointmentCellID";
	cell = [self.s_tableView dequeueReusableCellWithIdentifier:tAppointmentCell_ID];
        if (cell == nil)
        {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tAppointmentCell_ID] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
	else
	{
		// the cell is being recycled, remove old embedded controls
		UIView *viewToRemove = nil;
		viewToRemove = [cell.contentView viewWithTag:kViewTag];
		if (viewToRemove)
			[viewToRemove removeFromSuperview];
	}
	
	UIView *view = [[self.dataSourceArray objectAtIndex: indexPath.row] valueForKey:kViewKey];
	[cell.contentView addSubview:view];
	
	cell.backgroundColor = [UIColor clearColor];

	// Configure the cell...
	
	return cell;
}

- (void)didCityInfoResult:(NSArray *)cityArray
{
    CityListViewController * citylistVC = [[CityListViewController alloc] init];
    citylistVC.citysArray = cityArray;
    citylistVC.cityType = AirportCityList;
    citylistVC.delegate = self;
	switch ([self.buttonSelect intValue]) {
		case 100:
            currentDataModelElem = self.queryDataModel._fromCity; // zxt 20121027
			citylistVC.title = @"出发城市";
			break;
		case 101:
            currentDataModelElem = self.queryDataModel._toCity; // zxt 20121027
			citylistVC.title = @"到达城市";
			break;
		default:
			break;
	}
	
	[NavigationController pushViewController:citylistVC animated:YES];
	[citylistVC release];

}
@end
