//
//  HotelHomeViewController.m
//  FlightProject
//
//  Created by longcd on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelHomeViewController.h"
#import "TicketQueryViewController.h"
#import "CityListViewController.h"
#import "HotelDatePickerViewController.h"
#import "HotelInquiryViewController.h"
#import "HotelInquiryDataResponse.h"
#import "HotelListViewController.h"
#import "HotelQueryDataResponse.h"
#import "NSDate+convenience.h"
#import "HotelCollectViewController.h"
static NSString *kViewKey = @"viewKey";
@interface HotelHomeViewController ()
//加载本地数据
- (void)loadLocalDataSource;
//加载网络数据
- (void)loadDataSource;

- (void)pushHotelInquiryVC;


//城市视图
- (UIView *)initCityView;
//关键字查询视图
- (UIView *)initSearchView;

//日期视图
- (UIView *)initDateView;

- (UIView *)initButtonView;
//加载旅店查询网络数据

- (void)loadHotelListDataSource;
@end

@implementation HotelHomeViewController
@synthesize h_tableView = _h_tableView;
@synthesize queryDataModel=_queryDataModel;
@synthesize hotelRequestPara = _hotelRequestPara;
@synthesize dataSourceArray,cityView,searchView,dateView,buttonView,filterHoteDictionary,hoteNameDictionary,hoteInquiryNameDictionary;
@synthesize server,isCollect;



- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if (self.queryDataModel || self.filterHoteDictionary) {
		[self loadLocalDataSource];
		[self.h_tableView reloadData];
	}
}

- (void)loadView{
	
	
	
	[super loadView];
	
	NSString *cityKeyWord = [[NSUserDefaults standardUserDefaults]  objectForKey:keyCitylKeyWord];
	if (cityKeyWord) {
		[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:keyCitylKeyWord];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	
	_h_tableView = [[UITableView alloc] initWithFrame:CGRectMake(10.0f ,5.0,ViewWidth-20,ViewHeight-44.0f) style:UITableViewStylePlain];  
	self.h_tableView.backgroundColor = [UIColor clearColor];
	self.h_tableView.dataSource = self;
	self.h_tableView.delegate = self;
	self.h_tableView.showsVerticalScrollIndicator= NO;
        self.h_tableView.separatorColor = [UIColor clearColor];
	
	[self.view addSubview:self.h_tableView];
	
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, self.h_tableView.frame.size.width, 28.0f)];
	[topView setImage:[UIImage imageNamed:@"appointmentFrameTop.png"]];
	self.h_tableView.tableHeaderView = topView;
	
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	//self.navigationItem.rightBarButtonItem = nil;
	self.title = @"酒店预订";
	
	UIButton  * rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 7, 57, 30) backImage:[UIImage imageNamed:@"CollectButtonRight.png"] target:self action:@selector(hotelCollect:)];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
	self.navigationItem.rightBarButtonItem = rightBar;
	[rightBar release];
	
	[self loadLocalDataSource];
	
	if (!self.hotelRequestPara) {
		
		_hotelRequestPara = [[HotelRequestPara alloc]init];
		self.hotelRequestPara._cityCode = self.queryDataModel._fromCity._nameCode;
		self.hotelRequestPara._checkInDate = self.queryDataModel._startDate._nameCode;;
		self.hotelRequestPara._checkOutDate =  self.queryDataModel._arriveDate._nameCode;;
		self.hotelRequestPara._hotelName =@"";
		self.hotelRequestPara._highestPrice =@"0";
		self.hotelRequestPara._lowestPrice =@"0";
		self.hotelRequestPara._star = 0;
		self.hotelRequestPara._hotelBrandID =@"0";
		self.hotelRequestPara._longitude =@"";
		self.hotelRequestPara._latitude =@"";
		self.hotelRequestPara._pageIndex = 1;
		self.hotelRequestPara._byStar =@"";
		self.hotelRequestPara._byPrice =@"";
		self.hotelRequestPara._administrativeArea =@"";
		self.hotelRequestPara._businessArea =@"";
		self.hotelRequestPara._isSpecialOffer = FALSE;
		self.hotelRequestPara._hotelArea = @"";
		self.hotelRequestPara._priceName = @"房价";
		self.hotelRequestPara._starName = @"星级";
		self.hotelRequestPara._hotelBrandName = @"品牌";
	}
	
}


- (void)viewDidUnload
{
	[super viewDidUnload];

	
	// Release any retained subviews of the main view.
}

- (void) dealloc {
	
	
	self.queryDataModel = nil;
        self.cityView = nil;
        self.searchView = nil;
        self.dateView = nil;
        self.buttonView = nil;
	self.h_tableView = nil;
	
	self.server = nil;
	self.hotelRequestPara = nil;
	self.dataSourceArray = nil;
	self.hoteNameDictionary = nil;
	self.filterHoteDictionary = nil;
	self.hoteInquiryNameDictionary = nil;
	[super dealloc];
	
}



//加载数据
- (void)loadLocalDataSource
{
	//设置页面展示UIView
	self.dataSourceArray = [NSArray arrayWithObjects:
				[NSDictionary dictionaryWithObjectsAndKeys:
				 [self initCityView], kViewKey,
				 nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 [self initSearchView], kViewKey,
				 nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				 [self initDateView], kViewKey,
				 nil],
				[NSDictionary dictionaryWithObjectsAndKeys:
				  [self initButtonView], kViewKey,
				 nil],
				
				nil] ;
}

//加载旅店查询网络数据
- (void)loadDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass filterHotel:self.queryDataModel._fromCity._nameCode];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onfilterHotelPaseredResult:) Delegate:self needUserType:Default];
	
}


//返回处理
- (void)onfilterHotelPaseredResult:(NSDictionary *)dic
{
	hotelInquiryData = [HotelInquiryDataResponse inquiryHotel:dic];
	self.hoteNameDictionary =  hotelInquiryData._hoteNameDictionary;
	self.hoteInquiryNameDictionary =  hotelInquiryData._hoteInquiryNameDictionary;
	self.filterHoteDictionary = hotelInquiryData._filterHoteDictionary;
	NSString *cityKeyWord = [[NSUserDefaults standardUserDefaults]  objectForKey:keyCitylKeyWord];
	if (![self.queryDataModel._fromCity._nameStr isEqualToString:cityKeyWord]) {
		[[NSUserDefaults standardUserDefaults] setObject:self.queryDataModel._fromCity._nameStr forKey:keyCitylKeyWord];
	        [[NSUserDefaults standardUserDefaults] synchronize];
	}
        [self pushHotelInquiryVC];
}

- (void)pushHotelInquiryVC
{
	HotelInquiryViewController * hotelInquiryVC = [[HotelInquiryViewController alloc] init];
	hotelInquiryVC->hotelHomeVC = self;
	hotelInquiryVC.cityTitle =  self.queryDataModel._fromCity._nameStr;
	hotelInquiryVC.hoteNameDictionary = self.hoteInquiryNameDictionary;
	hotelInquiryVC.filterHoteDictionary = self.filterHoteDictionary;
	//HotelInquiryVC.hotelRequestPara._hotelArea = self.hotelRequestPara._hotelArea;
	hotelInquiryVC.hotelRequestPara = self.hotelRequestPara;
	[NavigationController pushViewController:hotelInquiryVC animated:YES];
	[hotelInquiryVC release];
}


//加载旅店查询网络数据

- (void)loadHotelListDataSource
{
	self.hotelRequestPara._pageIndex = 1;
	self.hotelRequestPara._byStar = @"";
	self.hotelRequestPara._byPrice = @"";
	self.hotelRequestPara._isSpecialOffer = FALSE;
	ASIFormDataRequest * theRequest = [InterfaceClass queryHotel:self.hotelRequestPara];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredHotelListResult:) Delegate:self needUserType:Default];
	
}


//加载成功
- (void)onPaseredHotelListResult:(NSDictionary *)dic
{
	hotelQueryDR = [HotelQueryDataResponse hotelQuery:dic];
	
	if (hotelQueryDR._hotelQueryInfoArray.count>0) {
		
		HotelListViewController * HotelListVC = [[HotelListViewController alloc] init];
		
		HotelListVC->hotelHomeVC = self;
		HotelListVC.queryDataModel = self.queryDataModel;
		
		if ([hotelQueryDR._number intValue]<=HOTEL_NUMBER_PAGE) {
			HotelListVC.isfromRecomend = TRUE;
		}
		HotelListVC.isSpecialOffer = self.hotelRequestPara._isSpecialOffer;
		HotelListVC.specialOfferNumber = hotelQueryDR._specialOfferNumber;
		HotelListVC.lcdValue = hotelQueryDR._lcdValue;
		HotelListVC.lcdActivityId = hotelQueryDR._lcdActivityId;
		HotelListVC.lcdRate = hotelQueryDR._lcdRate;
		HotelListVC.hotelListArray = hotelQueryDR._hotelQueryInfoArray;
		HotelListVC.hotelRequestPara = self.hotelRequestPara;
		HotelListVC.hoteNameDictionary= self.hoteNameDictionary;
		HotelListVC.filterHoteDictionary = self.filterHoteDictionary;
		HotelListVC.hoteInquiryNameDictionary = self.hoteInquiryNameDictionary;
		[NavigationController pushViewController:HotelListVC animated:YES];
		[HotelListVC release];
	}else {
		[UIAlertView alertViewWithMessage:@"未查询到您搜索的酒店" :@"提示"];
	}
	
}

#pragma mark - 自定义方法
//城市视图
- (UIView *)initCityView
{

	UIView *_cityView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.h_tableView.frame.size.width, 70.0f)];
	
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0, self.cityView.frame.size.width, self.cityView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"TicketQueryCenter.png"]];
	[_cityView addSubview:centerView];
	
	UIImageView *cityImgView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 15.0f, 23.0f, 35.0f)];
	[cityImgView setImage:[UIImage imageNamed:@"CityIcon.png"]];
	[_cityView addSubview:cityImgView];
	
	UISubLabel *checkCityTitleLabel = [UISubLabel labelWithTitle:@"入住城市" frame:CGRectMake(ViewWidth-200, 0.0f, 60.0f, 15.0f) font:FontSize22 alignment:NSTextAlignmentCenter];
	checkCityTitleLabel.textColor = FontColor909090;
	
	[_cityView addSubview:checkCityTitleLabel];
	
	
	checkCityLabel = [UISubLabel labelWithTitle:@"北京" frame:CGRectMake(40.0f, 25.0f, ViewWidth-100, 30.0f) font:FontBlodSize42 alignment:NSTextAlignmentCenter];
	checkCityLabel.textColor = FontColor333333;
	[_cityView addSubview:checkCityLabel];
	
	//城市点击按钮
	UIButton *checkCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
	checkCityButton.frame = CGRectMake(50.0f, 25.0f, ViewWidth-120, 30.0f);
	checkCityButton.backgroundColor = [UIColor clearColor];
	[checkCityButton addTarget:self action:@selector(city:) forControlEvents:UIControlEventTouchUpInside];
	[_cityView addSubview:checkCityButton];
	
	UIImageView *iconView=[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-40, 28.0f, 8.0f, 13.0f)];
	iconView.image=[UIImage imageNamed:@"CellArrow.png"];
	[_cityView addSubview:iconView];
	
	UIImageView *lineImageView=[UIImageView ImageViewWithFrame:CGRectMake(10.0f, 66.0f, ViewWidth-40, 1.0f)];
	lineImageView.image=[UIImage imageNamed:@"TicketQueryDottedLine.png"];
	[_cityView addSubview:lineImageView];
	
	_cityView.tag=kViewTag;	
	self.cityView = _cityView;
	[_cityView release];
	
	self.hotelRequestPara._cityCode = self.queryDataModel._fromCity._nameCode;
	checkCityLabel.text = self.queryDataModel._fromCity._nameStr;
	NSString *cityKeyWord = [[NSUserDefaults standardUserDefaults]  objectForKey:keyCitylKeyWord];
	if (![self.queryDataModel._fromCity._nameStr isEqualToString:cityKeyWord] && !self.isCollect) {
		
		self.hotelRequestPara._hotelArea = @"";
		self.hotelRequestPara._hotelName = @"";
		self.hotelRequestPara._administrativeArea =@"";
		self.hotelRequestPara._businessArea =@"";
		self.hotelRequestPara._longitude = @"";
		self.hotelRequestPara._latitude = @"";
		self.hotelRequestPara._isSpecialOffer = FALSE;
		self.filterHoteDictionary = nil;
		self.hoteNameDictionary = nil;
		self.hoteInquiryNameDictionary = nil;
	}
	
	return self.cityView;
}


//关键字查询视图
- (UIView *)initSearchView
{

	UIView *_searchView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.h_tableView.frame.size.width, 70.0f)];
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0, self.searchView.frame.size.width, self.searchView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"TicketQueryCenter.png"]];
	[_searchView addSubview:centerView];
	
	UIImageView *searchImgView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 15.0f, 35.0f, 35.5f)];
	[searchImgView setImage:[UIImage imageNamed:@"HotelIcon.png"]];
	[_searchView addSubview:searchImgView];
	
	UISubLabel *searchTitleLabel = [UISubLabel labelWithTitle:@"查找关键词" frame:CGRectMake(ViewWidth-200, 3.0f, 70.0f, 15.0f) font:FontSize22 alignment:NSTextAlignmentCenter];
	searchTitleLabel.textColor = FontColor909090;
	[_searchView addSubview:searchTitleLabel];
	
	searchLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(50.0f, 25.0f, ViewWidth-120, 30.0f) font:FontBlodSize42 alignment:NSTextAlignmentCenter];
	searchLabel.textColor = FontColor909090;
	
	
	[_searchView addSubview:searchLabel];
	
	//酒店名地址点击按钮
	UIButton *checkCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
	checkCityButton.frame = CGRectMake(50.0f, 5.0f, ViewWidth-120, 60.0f);
	checkCityButton.backgroundColor = [UIColor clearColor];
	[checkCityButton addTarget:self action:@selector(searchHotel:) forControlEvents:UIControlEventTouchUpInside];
	[_searchView addSubview:checkCityButton];
	
	UIImageView *iconView=[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-40, 28.0f, 8.0f, 13.0f)];
	iconView.image=[UIImage imageNamed:@"CellArrow.png"];
	[_searchView addSubview:iconView];
	
	
	UIImageView *lineImageView=[UIImageView ImageViewWithFrame:CGRectMake(10.0f, 69.0f, ViewWidth-40, 1.0f)];
	lineImageView.image=[UIImage imageNamed:@"TicketQueryDottedLine.png"];
	[_searchView addSubview:lineImageView];
	
	_searchView.tag=kViewTag;
	
	self.searchView = _searchView;
	[_searchView release];
	
	
	if ([self.hotelRequestPara._hotelArea isEqualToString:@"地区"]) {
		self.hotelRequestPara._hotelArea = @"";
		
	}
	if ([self.hotelRequestPara._hotelArea isEqualToString:@""] && [self.hotelRequestPara._hotelName isEqualToString:@""]) {
		searchLabel.text = @"酒店名、地址等";
		searchLabel.font = FontBlodSize32;
		searchLabel.textColor = FontColor909090;
		
	}else if (self.hotelRequestPara._hotelArea == NULL && self.hotelRequestPara._hotelName == NULL) {
		searchLabel.text = @"酒店名、地址等";
		searchLabel.font = FontBlodSize32;
		searchLabel.textColor = FontColor909090;
		
	}else {
		
		if (![self.hotelRequestPara._hotelName isEqualToString:@""] ) {
			searchLabel.text = self.hotelRequestPara._hotelName;
		}
		if (![self.hotelRequestPara._hotelArea isEqualToString:@""] ) {
			searchLabel.text = self.hotelRequestPara._hotelArea;
		}
		searchLabel.font = FontBlodSize32;
		searchLabel.textColor = FontColor333333;
	}
	
	return self.searchView;
}
//日期视图
- (UIView *)initDateView
{

	UIView *_dateView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.h_tableView.frame.size.width, 70.0f)];
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0, self.dateView.frame.size.width, self.dateView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"TicketQueryCenter.png"]];
	[_dateView addSubview:centerView];
	
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, dateView.frame.size.height, self.dateView.frame.size.width,18.0f)];
	[bottom setImage:[UIImage imageNamed:@"TicketQueryShadow.png"]];
	[_dateView addSubview:bottom];
	
	UISubLabel *startDateLabel= [UISubLabel labelWithTitle:@"入住日期" frame:CGRectMake(40.0f, 5.0f, 80.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	startDateLabel.textColor = FontColor909090;
	[_dateView addSubview:startDateLabel];
	
	startWeekLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(20.0f, 22.0f, 35.0f, 50.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
	startWeekLabel.textColor = FontColor333333;
	[_dateView addSubview:startWeekLabel];
	
	
	startDayLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(40.0f, 22.0f, 70.0f, 50.0f) font:FontBlodSize80 alignment:NSTextAlignmentCenter];
	startDayLabel.textColor = FontColor333333;
	[_dateView addSubview:startDayLabel];
	
	UISubLabel *dayTitleLabel = [UISubLabel labelWithTitle:@"日" frame:CGRectMake(100.0f, 43.0f, 15.0f, 25.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
	dayTitleLabel.textColor = FontColor333333;
	[_dateView addSubview:dayTitleLabel];
	
	UIImageView *iconView=[UIImageView ImageViewWithFrame:CGRectMake(130.0f, 28.0f, 8.0f, 13.0f)];
	iconView.image=[UIImage imageNamed:@"CellArrow.png"];
	[_dateView addSubview:iconView];
	
	//入住日期点击按钮
	UIButton *startDayButton = [UIButton buttonWithType:UIButtonTypeCustom];
	startDayButton.frame = CGRectMake(20.0f, 10.0f, 115.0f, 55.0f);
	startDayButton.backgroundColor = [UIColor clearColor];
	startDayButton.tag = 200;
	[startDayButton addTarget:self action:@selector(data:) forControlEvents:UIControlEventTouchUpInside];
	[_dateView addSubview:startDayButton];
	
	
	UISubLabel *endDateLabel = [UISubLabel labelWithTitle:@"离店日期" frame:CGRectMake(ViewWidth-130, 5.0f, 80.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	endDateLabel.textColor = FontColor909090;
	[_dateView addSubview:endDateLabel];
	
	endWeekLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-150, 22.0f, 35.0f, 50.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
	endWeekLabel.textColor = FontColor333333;
	[_dateView addSubview:endWeekLabel];

	endDayLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-130, 22.0f, 70.0f, 50.0f) font:FontBlodSize80 alignment:NSTextAlignmentCenter];
	endDayLabel.textColor = FontColor333333;
	[_dateView addSubview:endDayLabel];
	
	UISubLabel *dayTitle1Label = [UISubLabel labelWithTitle:@"日" frame:CGRectMake(ViewWidth-70, 43.0f, 15.0f, 25.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
	dayTitle1Label.textColor = FontColor333333;
	[_dateView addSubview:dayTitle1Label];
	
	iconView=[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-40, 28.0f, 8.0f, 13.0f)];
	iconView.image=[UIImage imageNamed:@"CellArrow.png"];
	[_dateView addSubview:iconView];
	
	//退房日期点击按钮
	UIButton *endDayButton = [UIButton buttonWithType:UIButtonTypeCustom];
	endDayButton.frame = CGRectMake(ViewWidth-155, 10.0f, 115.0f, 55.0f);
	endDayButton.backgroundColor = [UIColor clearColor];
	endDayButton.tag = 201;
	[endDayButton addTarget:self action:@selector(data:) forControlEvents:UIControlEventTouchUpInside];
	[_dateView addSubview:endDayButton];
	_dateView.tag=kViewTag;
	
	
	self.dateView = _dateView;
	[_dateView release];
		

	startWeekLabel.text = [[self.queryDataModel._startDate._nameStr componentsSeparatedByString:@"-"] objectAtIndex:0];
	startDayLabel.text =  [[self.queryDataModel._startDate._nameStr componentsSeparatedByString:@"-"] objectAtIndex:1];
	
	endWeekLabel.text =  [[self.queryDataModel._arriveDate._nameStr componentsSeparatedByString:@"-"] objectAtIndex:0];
	endDayLabel.text = [[self.queryDataModel._arriveDate._nameStr componentsSeparatedByString:@"-"] objectAtIndex:1];
	
	self.hotelRequestPara._checkInDate = self.queryDataModel._startDate._nameCode;
	self.hotelRequestPara._checkOutDate =  self.queryDataModel._arriveDate._nameCode;
	
	return self.dateView;
}

- (UIView *)initButtonView
{	

	 // create the UIButtons with various background images
		UIView *_buttonView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.h_tableView.frame.size.width, 70.0f)];
		UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(40.0f, 25.0f, ViewWidth-94, 45.0f) backImage:[UIImage imageNamed:@"WhenRealQuery.png"] target:self action:@selector(queryHotel:)];
		[_buttonView addSubview:searchButton];
		_buttonView.tag = kViewTag;
	
	self.buttonView = _buttonView;
	[_buttonView release];
		
	return self.buttonView;
}


- (void)city :(id)sender {  // zxt 20121027 修改 
	
	NSArray * array =  [DataClass selectFromHotelCityList];
	if ([GetConfiguration shareGetConfiguration].needUpdateHotelCityList || [array count] == 0) {
        GetBasicInfoFromServer *serverInfo = [[GetBasicInfoFromServer alloc] init];
		self.server = serverInfo;
        [serverInfo release];
		self.server.cityDelegate = self;
		[self.server getHotelCityList];
	}
	else
	{
		[self didCityInfoResult:array];
	}
}

- (void)didCityInfoResult:(NSArray *)cityArray
{
	CityListViewController * citylistVC = [[CityListViewController alloc] init];
    citylistVC.citysArray = cityArray;
	citylistVC.cityType = HotelCityList;
	citylistVC.delegate = self;
        citylistVC.title = @"入住城市";
	currentDataModelElem = self.queryDataModel._fromCity;
	[NavigationController pushViewController:citylistVC animated:YES];
	[citylistVC release];
}

-(void)didSelectedCityFinshed:(id)city // zxt 20121027 添加  选择完城市的代理方法
{  
	HotelCitys * _city = (HotelCitys *)city;
	currentDataModelElem._nameStr = _city._city_name;
	currentDataModelElem._nameCode = _city._city_code;
	[_h_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)searchHotel :(id)sender {
	
	NSString *cityKeyWord = [[NSUserDefaults standardUserDefaults]  objectForKey:keyCitylKeyWord];
	if (![self.queryDataModel._fromCity._nameStr isEqualToString:cityKeyWord] || self.filterHoteDictionary.count == 0) {
		[self loadDataSource];
		
	}else{ 
		[self pushHotelInquiryVC];
	}
	
}

- (void) queryHotel :(id)sender {
	
	int dayInterval = [NSDate dayInterval:[NSDate dateFromString:self.queryDataModel._startDate._nameCode] withEndDay:[NSDate dateFromString:self.queryDataModel._arriveDate._nameCode]];
	if (dayInterval>PushBackTwentyDay) {
		
		actionSheet = [[UIActionSheet alloc] initWithTitle:@"如果您需要入住酒店超过20天，请您致电400-6858-999，我们会竭诚为您服务。"
							  delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拨打400-6858-999" otherButtonTitles:nil];
		actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
		[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
		[actionSheet release];
		
	}else {
		[self loadHotelListDataSource];
	}
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		[self callTel:@"400-6858-999"];		
	}
	
}

- (void)data :(id)sender {
	
	UIButton *button = (UIButton *)sender;
	HotelDatePickerViewController * datePickerVC = [[HotelDatePickerViewController alloc] init];
	switch (button.tag) {
		case 200:
			datePickerVC.allowShowdays = PushBackOneHundredAndEightyDay; //允许访问180天
			datePickerVC.dateType = StarDate;
			datePickerVC.pushBackDay = PushBackZeroDay;
			
			break;
		case 201:
			datePickerVC.allowShowdays = PushBackTwoHundredDay; //允许访问200天
			datePickerVC.dateType = BackDate;
			datePickerVC.pushBackDay = PushBackOneDay;
			break;
		default:
			break;
	}
	
	datePickerVC.startDateTicketQueryDataModel = self.queryDataModel._startDate;
	datePickerVC.backDateTicketQueryDataModel= self.queryDataModel._arriveDate;
	
	[NavigationController pushViewController:datePickerVC animated:YES];
	[datePickerVC release];
	
	
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
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{		
	
	return 70.0f;
	
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell = nil;
	static NSString *tHotelHomeCellID_ID = @"HotelHomeCellID";
	cell = [self.h_tableView dequeueReusableCellWithIdentifier:tHotelHomeCellID_ID];
        if (cell == nil)
        {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tHotelHomeCellID_ID] autorelease];
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
	//	if (indexPath.row==3) {
	//		UIButton *button = [[self.dataSourceArray objectAtIndex: indexPath.section] valueForKey:kViewKey];
	//		[cell.contentView addSubview:button];
	//	}else {
	UIView *view = [[self.dataSourceArray objectAtIndex: indexPath.row] valueForKey:kViewKey];
	[cell.contentView addSubview:view];
	//	}
	
	cell.backgroundColor = [UIColor clearColor];

	
	// Configure the cell...
	
	return cell;
}


- (void)hotelCollect:(id)sender
{
	self._VCType = Member;
	if (self.isLogin) {
		[self loginSuccessFul];
	}
}

- (void)loginSuccessFul
{
	HotelCollectViewController *collectVC = [[HotelCollectViewController alloc] init];
	collectVC->hotelHomeVC = self;
	[NavigationController pushViewController:collectVC animated:YES];
	[collectVC release];
}

@end
