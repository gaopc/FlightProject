//
//  HotelListViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelListViewController.h"
#import "HotelListCell.h"

#import "InterfaceClass.h"
#import "ASIFormDataRequest.h"
#import "HotelFilterViewController.h"
#import "HotelQueryDataResponse.h"
#import "RoomHomeViewController.h"
#import "HotelInquiryDataResponse.h"
#import "HotelHomeViewController.h"
#import "CustomAnnotation.h"
@interface HotelListViewController ()
- (void)loadDataSource;
//加载酒店详情数据
- (void)loadHotelInfoSource;
//加载酒店筛选数据
- (void)loadHotelFilterDataSource;
//加载第一次请求数据

- (void)setAnnotation;
- (void)pushHotelFilterVC;

@end

@implementation HotelListViewController
@synthesize h_tableView = _h_tableView;
@synthesize mapView = _mapView;
@synthesize listView = _listView;
@synthesize bottomView = _bottomView;
@synthesize hotelRequestPara = _hotelRequestPara;
@synthesize hotelInfo,hotelListArray,byStar,byPrice,cityTitle;
@synthesize filterHoteDictionary,hoteNameDictionary,hoteInquiryNameDictionary;
@synthesize queryDataModel,currentDataModelElem;
@synthesize isfromRecomend,lcdRate,lcdValue,lcdActivityId,tempView,specialOfferNumber,isSpecialOffer,totalPage,number,isLastPage;

- (void)loadView{
	
	[super loadView];
	
	_listView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
	
	UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 35)];
	//星级
	starButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"HotelStarNone.png"] target:self action:@selector(starOrder:)];
	[headView addSubview : starButton];
	//筛选
	filterButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth/3, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListFilterNone.png"] target:self action:@selector(filterOrder:)];
	[headView addSubview : filterButton];
	//价格
	priceButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth/3*2, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListPriceNone.png"] target:self action:@selector(priceOrder:)];
	[headView addSubview : priceButton];
	
	[self.listView addSubview:headView];
	[headView release];
	
	_h_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,40.0f,ViewWidth,ViewHeight-118.0f) style:UITableViewStylePlain];  
	self.h_tableView.backgroundColor = [UIColor clearColor];
	self.h_tableView.dataSource = self;
	self.h_tableView.delegate = self;
        self.h_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.listView addSubview:self.h_tableView];
	
	[self isrefreshHeaderView];

	_mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, ViewHeight - 75.0f)];
	self.mapView.delegate = self;

	_bottomView = [[HotelBottomView alloc] initWithFrame:CGRectMake(0.0f, ViewHeight-85.0f, ViewWidth, 41.0f)];
	self.bottomView.delegate = self;
	self.bottomView.startDayLabel.text = [NSString stringWithFormat:@"%@ %@%@",self.queryDataModel._startDate._nameCode,[[[self.queryDataModel._startDate._nameStr componentsSeparatedByString:@"-"] objectAtIndex:0] substringToIndex:2],@"入住"];
	self.bottomView.endDayLabel.text = [NSString stringWithFormat:@"%@ %@%@",self.queryDataModel._arriveDate._nameCode,[[[self.queryDataModel._arriveDate._nameStr componentsSeparatedByString:@"-"] objectAtIndex:0] substringToIndex:2],@"离店"];
	[self.listView addSubview:self.bottomView];

	self.tempView = self.listView;
	
//	[self.view insertSubview:self.tempView atIndex:0];
    [self.view addSubview:self.tempView];
}


- (void)isrefreshHeaderView
{
	if (self.isfromRecomend) {
		if (_refreshHeaderView) {
			self.h_tableView.contentSize = CGSizeMake(ViewWidth, self.h_tableView.contentSize.height-65.0f);
			[_refreshHeaderView removeFromSuperview];
			_refreshHeaderView = nil;
		}

	}
	else {
		if (!_refreshHeaderView) {
			_refreshHeaderView = [[EGORefreshTableHeaderView alloc] init]; 
			_refreshHeaderView.delegate = self;
			_refreshHeaderView.backgroundColor= [UIColor clearColor];
			[self.h_tableView addSubview:_refreshHeaderView];
			[_refreshHeaderView refreshLastUpdatedDate];
		}
	}
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	if (self.isSpecialOffer)
		self.title =  @"今日特价";
	else
		self.title =  self.queryDataModel._fromCity._nameStr;
	
	
	
	UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 0, 52, 30) backImage:[UIImage imageNamed:@"backPre.png"] target:self action:@selector(backHome:)];
	leftButton.tag = 101;
	UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
	self.navigationItem.leftBarButtonItem = leftBar;
	[leftBar release];
	
	pageIndex = 1;
	self.byStar = @"";
	self.byPrice = @"";
	// Do any additional setup after loading the view.
	
	if (!self.hotelRequestPara) {
		_hotelRequestPara = [[HotelRequestPara alloc]init];
		self.hotelRequestPara._cityCode = self.queryDataModel._fromCity._nameCode;
		self.hotelRequestPara._checkInDate = self.queryDataModel._startDate._nameCode;
		self.hotelRequestPara._checkOutDate = self.queryDataModel._arriveDate._nameCode;
		self.hotelRequestPara._hotelName =@"";
		self.hotelRequestPara._highestPrice =@"0";
		self.hotelRequestPara._lowestPrice =@"0";
		self.hotelRequestPara._star = 0;
		self.hotelRequestPara._hotelBrandID =@"0";
		self.hotelRequestPara._longitude =@"";
		self.hotelRequestPara._latitude =@"";
		self.hotelRequestPara._pageIndex = pageIndex;
		self.hotelRequestPara._byStar =self.byStar;
		self.hotelRequestPara._byPrice = @"";
		self.hotelRequestPara._administrativeArea =@"";
		self.hotelRequestPara._businessArea =@"";
		self.hotelRequestPara._isSpecialOffer = self.isSpecialOffer;
		self.hotelRequestPara._hotelArea = @"地区";
		self.hotelRequestPara._priceName = @"房价";
		self.hotelRequestPara._starName = @"星级";
		self.hotelRequestPara._hotelBrandName = @"品牌";
	}
	
	[self loadFitstDataSource];
	
	
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
	// Release any retained subviews of the main view.
}

- (void) dealloc {
	
	
	self.cityTitle=nil;
	self.h_tableView = nil;
	
	self.mapView.delegate = nil;
	self.bottomView.delegate = nil;
	self.h_tableView.delegate = nil;
	self.h_tableView.dataSource = nil;
	
	self.mapView = nil;
	self.listView = nil;
	self.specialOfferNumber = nil;
	[_listView release];
	[_mapView release];
	
	self.tempView = nil;
	
	self.hotelListArray = nil;
	self.filterHoteDictionary = nil;
	self.hoteNameDictionary = nil;
	self.hoteInquiryNameDictionary = nil;
	self.queryDataModel = nil;
	self.currentDataModelElem = nil;
	[_h_tableView release];

	self.hotelInfo = nil;
	self.isfromRecomend = FALSE;
	self.hotelRequestPara._pageIndex = 1;
	self.hotelRequestPara._star = 0;
//	self.hotelRequestPara._longitude = @"";
//	self.hotelRequestPara._latitude = @"";
	self.hotelRequestPara._lowestPrice = @"0";
	self.hotelRequestPara._highestPrice = @"0";
	self.hotelRequestPara._hotelBrandID = @"0";
	
	self.hotelRequestPara._hotelBrandName = @"品牌";
	self.hotelRequestPara._priceName = @"房价";
	self.hotelRequestPara._starName = @"星级";

	
	[super dealloc];
}

-(void) backHome:(UIButton *)sender
{
	if (isSelectMap) {
		
		[self mapClick:sender];
		
	}else {
		[NavigationController popViewControllerAnimated:YES];
	}
	
}

//加载酒店详情数据
- (void)loadHotelInfoSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass hotelInformation:self.hotelInfo._hotelId withCheckInDate:self.queryDataModel._startDate._nameCode withCheckOutDate:self.queryDataModel._arriveDate._nameCode withLcdRate:self.lcdRate withLcdValue:self.lcdValue withUserId:[UserInfo sharedUserInfo].userID];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onHotelInfoResult:) Delegate:self needUserType:Default];
	
}

//加载数据
- (void)loadDataSource
{
	
	self.hotelRequestPara._isSpecialOffer = self.self.isSpecialOffer;
	ASIFormDataRequest * theRequest = [InterfaceClass queryHotel:self.hotelRequestPara];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryHotelPaseredResult:) Delegate:self needUserType:Default];
	
}


//加载酒店筛选数据
- (void)loadHotelFilterDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass filterHotel:self.queryDataModel._fromCity._nameCode];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredFilterResult:) Delegate:self needUserType:Default];
	
}


//加载数据
- (void)loadFitstDataSource
{
	[self.h_tableView reloadData];
	 _refreshHeaderView.frame=CGRectMake(0.0f, self.h_tableView.contentSize.height, self.h_tableView.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}



//加载成功
- (void)onqueryHotelPaseredResult:(NSDictionary *)dic
{
	hotelDataResponse = [HotelQueryDataResponse hotelQuery:dic];
	if (pageIndex==1)
		self.hotelListArray = hotelDataResponse._hotelQueryInfoArray;
	else
		[self.hotelListArray addObjectsFromArray:hotelDataResponse._hotelQueryInfoArray];
	
	[self.h_tableView reloadData];
	self.number = (int)[hotelDataResponse._number intValue];
	if (self.number%HOTEL_NUMBER_PAGE==0){
		self.totalPage = self.number/HOTEL_NUMBER_PAGE;
		
	}else{
		self.totalPage = (self.number/HOTEL_NUMBER_PAGE)+1;
	}

	if ((![self.hotelRequestPara._byStar isEqualToString:@""] || ![self.hotelRequestPara._byPrice isEqualToString:@""]) && self.number <= HOTEL_NUMBER_PAGE ) {
		
		self.isfromRecomend = YES;
		[self isrefreshHeaderView];
		
		if (self.isLastPage) {
			self.h_tableView.contentSize = CGSizeMake(ViewWidth, self.h_tableView.contentSize.height-65.0f);
			
		}
		return;
	}else{
		if(self.isfromRecomend)
		{
			self.isfromRecomend = FALSE;
			[self isrefreshHeaderView];
			self.isLastPage = FALSE;
		}
	}

	
	if(pageIndex == self.totalPage && self.totalPage != 1)
	{
		self.isfromRecomend = YES;
		[self isrefreshHeaderView];
		self.isLastPage = YES;
		return;
	}
	
	_refreshHeaderView.frame=CGRectMake(0.0f, self.h_tableView.contentSize.height, self.h_tableView.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}


//加载成功
- (void)onHotelInfoResult:(NSDictionary *)dic 
{
	
	hotelDataResponse = [HotelQueryDataResponse hotelInformation:dic withHotelInfo:self.hotelInfo];
	
	if (hotelDataResponse._roomTypeArray.count>0) {
		RoomHomeViewController *roomHomeVC = [[RoomHomeViewController alloc] init];
		roomHomeVC.hotelInfo = hotelDataResponse._hotelInfo;
		roomHomeVC.picUrlArray = hotelDataResponse._picUrlArray;
		roomHomeVC.roomListArray = hotelDataResponse._roomTypeArray;
		roomHomeVC.startDay = self.queryDataModel._startDate._nameCode;
		roomHomeVC.endDay = self.queryDataModel._arriveDate._nameCode;
		roomHomeVC.cityName = self.queryDataModel._fromCity._nameStr;
		
		roomHomeVC.lcdRate = self.lcdRate;
		roomHomeVC.lcdValue = self.lcdValue;
		roomHomeVC.lcdActivityId = self.lcdActivityId;
		[NavigationController pushViewController:roomHomeVC animated:YES];
		[roomHomeVC release];
	}
	
}

//加载成功
- (void)onPaseredFilterResult:(NSDictionary *)dic
{
	
	NSString *cityKeyWord = [[NSUserDefaults standardUserDefaults]  objectForKey:keyCitylKeyWord];
	if (![self.cityTitle isEqualToString:cityKeyWord]) {
		[[NSUserDefaults standardUserDefaults] setObject:self.cityTitle forKey:keyCitylKeyWord];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	inquiryDataResponse = [HotelInquiryDataResponse inquiryHotel:dic];
	self.hoteNameDictionary = inquiryDataResponse._hoteNameDictionary;
	self.filterHoteDictionary = inquiryDataResponse._filterHoteDictionary;
	self.hoteInquiryNameDictionary = inquiryDataResponse._hoteInquiryNameDictionary;
	
	hotelHomeVC.hoteNameDictionary = inquiryDataResponse._hoteNameDictionary;
	hotelHomeVC.filterHoteDictionary = inquiryDataResponse._filterHoteDictionary;
	hotelHomeVC.hoteInquiryNameDictionary = inquiryDataResponse._hoteInquiryNameDictionary;
	
	[self pushHotelFilterVC];
	
	
	
}

- (void)pushHotelFilterVC
{
	HotelFilterViewController * hotelFilterVC = [[HotelFilterViewController alloc] init];
	hotelFilterVC->hotelListVC = self;
	hotelFilterVC.hoteNameDictionary = self.hoteNameDictionary;
	hotelFilterVC.filterHoteDictionary = self.filterHoteDictionary;
	hotelFilterVC.hoteInquiryNameDictionary = self.hoteInquiryNameDictionary;
	if ([self.hotelRequestPara._hotelArea isEqualToString:@""]) {
		
		self.hotelRequestPara._hotelArea = @"地区";
	}
	if (!hotelFilterVC.hotelRequestPara) {
		
		hotelFilterVC.hotelRequestPara = [[HotelRequestPara alloc]init];
	}
	
	hotelFilterVC.hotelRequestPara._hotelArea = self.hotelRequestPara._hotelArea;
	hotelFilterVC.hotelRequestPara._cityCode = self.queryDataModel._fromCity._nameCode;
	hotelFilterVC.hotelRequestPara._checkInDate = self.queryDataModel._startDate._nameCode;
	hotelFilterVC.hotelRequestPara._checkOutDate = self.queryDataModel._arriveDate._nameCode;
	hotelFilterVC.hotelRequestPara._hotelName =self.hotelRequestPara._hotelName;
	hotelFilterVC.hotelRequestPara._highestPrice =self.hotelRequestPara._highestPrice;
	hotelFilterVC.hotelRequestPara._lowestPrice =self.hotelRequestPara._lowestPrice;
	hotelFilterVC.hotelRequestPara._star = self.hotelRequestPara._star;
	hotelFilterVC.hotelRequestPara._hotelBrandID =self.hotelRequestPara._hotelBrandID;
	hotelFilterVC.hotelRequestPara._longitude =self.hotelRequestPara._longitude;
	hotelFilterVC.hotelRequestPara._latitude =self.hotelRequestPara._latitude;
	hotelFilterVC.hotelRequestPara._pageIndex = self.hotelRequestPara._pageIndex;
	hotelFilterVC.hotelRequestPara._byStar =self.hotelRequestPara._byStar;
	hotelFilterVC.hotelRequestPara._byPrice = self.hotelRequestPara._byPrice;
	hotelFilterVC.hotelRequestPara._administrativeArea =self.hotelRequestPara._administrativeArea;
	hotelFilterVC.hotelRequestPara._businessArea = self.hotelRequestPara._businessArea;
	hotelFilterVC.hotelRequestPara._isSpecialOffer = self.isSpecialOffer;
	hotelFilterVC.hotelRequestPara._hotelArea = self.hotelRequestPara._hotelArea;
	hotelFilterVC.hotelRequestPara._priceName = self.hotelRequestPara._priceName;
	hotelFilterVC.hotelRequestPara._starName = self.hotelRequestPara._starName;
	hotelFilterVC.hotelRequestPara._hotelBrandName = self.hotelRequestPara._hotelBrandName;
	//hotelFilterVC.hotelRequestPara = self.hotelRequestPara;
	[NavigationController pushViewController:hotelFilterVC animated:YES];
	[hotelFilterVC release];
}

-(void)starOrder:(UIButton *)sender
{
	static BOOL sortDese = FALSE;
	sortDese = !sortDese;
	

	pageIndex = 1;
	self.hotelRequestPara._pageIndex = pageIndex;
	self.hotelRequestPara._byPrice = @"";
	self.hotelRequestPara._byStar = @"";
//	self.hotelRequestPara._star = 0;
	[filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
	[priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceNone.png"] forState:UIControlStateNormal];
	if (sortDese) {
		self.hotelRequestPara._byStar = @"ByStarDesc";
		[sender setBackgroundImage:[UIImage imageNamed:@"HotelStarDown.png"] forState:UIControlStateNormal];
	}
	else {
		self.hotelRequestPara._byStar = @"ByStar";
		[sender setBackgroundImage:[UIImage imageNamed:@"HotelStarUp.png"] forState:UIControlStateNormal];
	}


	[self loadDataSource];
	
	
}

-(void)priceOrder:(UIButton *)sender
{
	
	pageIndex = 1;

	self.hotelRequestPara._pageIndex = pageIndex;
	self.hotelRequestPara._byPrice = @"ByPrice";
	self.hotelRequestPara._byStar = @"";
	
	[starButton setBackgroundImage:[UIImage imageNamed:@"HotelStarNone.png"] forState:UIControlStateNormal];
	[filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
	[sender setBackgroundImage:[UIImage imageNamed:@"TicketListPriceUp.png"] forState:UIControlStateNormal];
	
	[self loadDataSource];
	
}


-(void)filterOrder:(UIButton *)sender
{
	pageIndex = 1;

	self.hotelRequestPara._pageIndex = pageIndex;
	self.hotelRequestPara._byPrice = @"";
	self.hotelRequestPara._byStar = @"";
	//self.hotelRequestPara._hotelName = @"";
	[starButton setBackgroundImage:[UIImage imageNamed:@"HotelStarNone.png"] forState:UIControlStateNormal];
	[priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceNone.png"] forState:UIControlStateNormal];
	[sender setBackgroundImage:[UIImage imageNamed:@"TicketListFilter.png"] forState:UIControlStateNormal];
	
	if (self.filterHoteDictionary.count==0) 
		[self loadHotelFilterDataSource];
	else 
		[self pushHotelFilterVC];
	
	
	
}


-(void)mapClick:(id)sender//点击地图按钮
{
        UIButton *button = (UIButton *)sender;
	[UIView beginAnimations:@"flipping view" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	if (self.tempView) {
		[self.tempView removeFromSuperview];
	}

	switch (button.tag) {
		case 100:
			
			[self.bottomView viewWithTag:100].hidden=YES;
			[self.bottomView viewWithTag:101].hidden=NO;
			
			[self.bottomView viewWithTag:200].hidden=YES;
			[self.bottomView viewWithTag:201].hidden=NO;
			
			[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft
					       forView:self.view cache:YES];
			
			UIView *_maptempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight+ViewStartY)];
			[_maptempView insertSubview:self.mapView atIndex:0];
			[_maptempView addSubview:self.bottomView];
			self.tempView = _maptempView;
			[self.view addSubview:self.tempView];
			[_maptempView release];
			isSelectMap = TRUE;			
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(map:)];
			
			[UIView commitAnimations];
			
			break;
		case 101:
			
			[self.bottomView viewWithTag:100].hidden=NO;
			[self.bottomView viewWithTag:101].hidden=YES;
			
			[self.bottomView viewWithTag:200].hidden=NO;
			[self.bottomView viewWithTag:201].hidden=YES;
			
			[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight
					       forView:self.view cache:YES];
			
			UIView *_listempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight+ViewStartY)];
			[_listempView insertSubview:self.listView atIndex:0];
			[_listempView addSubview:self.bottomView];
			self.tempView = _listempView;
			[self.view addSubview:self.tempView];
			[_listempView release];
			isSelectMap = FALSE;
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(list:)];
			
			[UIView commitAnimations];
			
			
			break;
		default:
			break;
	}
	
	
	
	
}

-(void)map:(id)sender
{
	[self setAnnotation];
}

-(void)list:(id)sender
{
	[self.h_tableView reloadData];
	
	if(self.isLastPage)
	{
		self.isfromRecomend = YES;
		[self isrefreshHeaderView];
		self.h_tableView.contentSize = CGSizeMake(ViewWidth, self.h_tableView.contentSize.height-65.0f);
		return;
	}
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	
	MKAnnotationView *pinView = nil;
	
	static NSString *AnnotationHotelViewID = @"annotationHotelViewID";
	pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationHotelViewID];
	if (pinView == nil) {
		pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotation.title] autorelease];
	}
	else {
		pinView.annotation = annotation;
	}
	pinView.selected = YES;
	pinView.canShowCallout  = TRUE;
	CustomAnnotation* temp = annotation;
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[rightButton addTarget:self
			action:@selector(showDetails:)
	      forControlEvents:UIControlEventTouchUpInside];
	rightButton.tag = temp.tag;
	pinView.rightCalloutAccessoryView = rightButton;
	
	return pinView;
}

- (void)showDetails:(UIButton *)sender
{
	// the detail view does not want a toolbar so hide it
	self.hotelInfo =  [self.hotelListArray objectAtIndex:sender.tag];
	[self loadHotelInfoSource];
}

//- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//	if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
//		BMKPinAnnotationView *newAnnotation = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"] autorelease];   
//		newAnnotation.pinColor = BMKPinAnnotationColorRed;   
//		newAnnotation.animatesDrop = YES;
//		newAnnotation.draggable = NO;
//		newAnnotation.selected = NO;
//		
//		return newAnnotation;   
//	}
//	return nil;
//}

//- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
//{
//	NSLog(@"当点击annotation view弹出的泡泡时，调用此接口");
//	//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)setAnnotation
{
	CLLocationCoordinate2D center;
	
	double subLongitude = 0;
	double subLatitude = 0;
	NSArray* array = [NSArray arrayWithArray:self.mapView.annotations];
	[self.mapView removeAnnotations:array];
	
	for (int i = 0; i < self.hotelListArray.count; i++) 
	{
		HotelInfo *hotelData = [self.hotelListArray objectAtIndex:i];
		
		center.longitude = [hotelData._longitude doubleValue];
		center.latitude = [hotelData._latitude doubleValue]; 
		
		CustomAnnotation* item = [[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake([hotelData._latitude doubleValue], [hotelData._longitude doubleValue])];
		item.title = hotelData._hotelName;
		item.subtitle = hotelData._address;
		item.tag = i;
		[self.mapView addAnnotation:item];
		[item release];
		subLongitude += center.longitude;
		subLatitude += center.latitude;
	}
	
	CLLocationCoordinate2D centerOff = CLLocationCoordinate2DMake(subLatitude/self.hotelListArray.count, subLongitude/self.hotelListArray.count);
	
	MKCoordinateSpan span = MKCoordinateSpanMake(0.2, 0.2);
	MKCoordinateRegion regin = MKCoordinateRegionMake(centerOff, span);
	[self.mapView setRegion:[self.mapView regionThatFits:regin] animated:YES];
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
	if ([self.specialOfferNumber intValue]>0 && !self.isSpecialOffer)
		return [self.hotelListArray count]+1;
	else
		return [self.hotelListArray count];
	
	
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return 80.0f;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if ([self.specialOfferNumber intValue]>0 && !self.isSpecialOffer) {
		
		if (indexPath.row == 0) {
		
			static NSString * identifier = @"TJidentifier";
			HotelTJListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
			if (cell == nil) {
				
				cell = [[[HotelTJListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
				cell.backgroundColor = [UIColor clearColor];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				
			}
			
			cell.number.text =[NSString stringWithFormat:@"%@ 家",self.specialOfferNumber];
			
			return cell;
		}else{
			static NSString * identifier = @"identifier";
			HotelListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
			if (cell == nil) {
				cell = [[[HotelListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
				cell.backgroundColor = [UIColor clearColor];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				
			}
			
			HotelInfo *ahotelInfo = nil;
			ahotelInfo = (HotelInfo *)[self.hotelListArray objectAtIndex:(indexPath.row-1)];
			cell.hotelName.text = ahotelInfo._hotelName;
			cell.rating.text = [NSString stringWithFormat:@"%@ %.1f",@"点评 : ",ahotelInfo._rating];
			cell.districtName.text = ahotelInfo._districtName;
			int ilowestPrice = 0 ;
			if ((int) ahotelInfo._lowestPrice *100%100 ==0)
				ilowestPrice = (int)(ahotelInfo._lowestPrice);
			else
				ilowestPrice = (int)(ahotelInfo._lowestPrice) + 1;
			
			cell.lowestPrice.text = [NSString stringWithFormat:@"%d",ilowestPrice];
			cell.returnLcdFee.text =[NSString stringWithFormat:@"%@%@",@"返",[NSString stringWithFormat:@"%3d",(int)(ahotelInfo._returnLcdFee)]];
			if ((int)ahotelInfo._returnLcdFee == 0) {
				cell._returnLcdView.hidden = YES;
			}
			else {
				cell._returnLcdView.hidden = NO;
			}
			
			if (ahotelInfo._dropFee==0)
				cell.lowerImageView.hidden = YES;
			else
				cell.lowerImageView.hidden = NO;
			
			[cell.hotelImageView setUrlString:ahotelInfo._picUrl];
			if(ahotelInfo._diamond){
				[cell drawDiamondCodeView:ahotelInfo._starCode];
			}else{
				[cell drawStarCodeView:ahotelInfo._starCode];
			}
			// Configure the cell...
			
			return cell;
			
		}
	}else{
	
		static NSString * identifier = @"identifier";
		HotelListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
		if (cell == nil) {
			cell = [[[HotelListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
			cell.backgroundColor = [UIColor clearColor];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
		}
		
		HotelInfo *ahotelInfo = nil;
		ahotelInfo = (HotelInfo *)[self.hotelListArray objectAtIndex:indexPath.row];
		cell.hotelName.text = ahotelInfo._hotelName;
		cell.rating.text = [NSString stringWithFormat:@"%@ %.1f",@"点评 : ",ahotelInfo._rating];
		cell.districtName.text = ahotelInfo._districtName;
		int ilowestPrice = 0 ;
		if ((int) ahotelInfo._lowestPrice *100%100 ==0) 
			ilowestPrice = (int)(ahotelInfo._lowestPrice);
		else 
			ilowestPrice = (int)(ahotelInfo._lowestPrice) + 1;
		
		cell.lowestPrice.text = [NSString stringWithFormat:@"%d",ilowestPrice];
		cell.returnLcdFee.text =[NSString stringWithFormat:@"%@%@",@"返",[NSString stringWithFormat:@"%3d",(int)(ahotelInfo._returnLcdFee)]]; 
		if ((int)ahotelInfo._returnLcdFee == 0) {
			cell._returnLcdView.hidden = YES;
		}
		else {
			cell._returnLcdView.hidden = NO;
		}
		
		if (ahotelInfo._dropFee==0) 
			cell.lowerImageView.hidden = YES;
		else 
			cell.lowerImageView.hidden = NO;

		[cell.hotelImageView setUrlString:ahotelInfo._picUrl];
		if(ahotelInfo._diamond){
			[cell drawDiamondCodeView:ahotelInfo._starCode];
		}else{
			[cell drawStarCodeView:ahotelInfo._starCode];
		}
		// Configure the cell...
		
		return cell;
		}
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	[self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 0, 300, 74)];
	
	if ([self.specialOfferNumber intValue]>0 && !self.isSpecialOffer) {
		
		if (indexPath.row == 0) {
			[self loadHotelTJListDataSource];
		}else{
			self.hotelInfo = (HotelInfo *)[self.hotelListArray objectAtIndex:(indexPath.row-1)];
			[self loadHotelInfoSource];
		}
		
	}else{
		self.hotelInfo = (HotelInfo *)[self.hotelListArray objectAtIndex:indexPath.row];
		[self loadHotelInfoSource];
	}
	

}


//加载旅店查询网络数据

- (void)loadHotelTJListDataSource
{
	
	self.hotelRequestPara._pageIndex = 1;
	self.hotelRequestPara._byStar = @"";
	self.hotelRequestPara._byPrice = @"";
	//self.hotelRequestPara._hotelName =@"";
	self.hotelRequestPara._isSpecialOffer = TRUE;
	
	ASIFormDataRequest * theRequest = [InterfaceClass queryHotel:self.hotelRequestPara];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredHotelListResult:) Delegate:self needUserType:Default];
	
}


//加载成功
- (void)onPaseredHotelListResult:(NSDictionary *)dic
{
	HotelQueryDataResponse *hotelQueryDR = [HotelQueryDataResponse hotelQuery:dic];
	
	if (hotelQueryDR._hotelQueryInfoArray.count>0) {
		
		HotelListViewController * HotelListVC = [[HotelListViewController alloc] init];

		HotelListVC.queryDataModel = self.queryDataModel;
		if ([hotelQueryDR._number intValue]<=HOTEL_NUMBER_PAGE) {
			HotelListVC.isfromRecomend = TRUE;
		}
		HotelListVC.isSpecialOffer = self.hotelRequestPara._isSpecialOffer;
		HotelListVC.specialOfferNumber = hotelQueryDR._specialOfferNumber;
		HotelListVC.lcdValue = hotelQueryDR._lcdValue;
		HotelListVC.lcdRate = hotelQueryDR._lcdRate;
		HotelListVC.lcdActivityId = hotelQueryDR._lcdActivityId;
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



#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate －－上拉涮新委托方法

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:4.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}




#pragma mark -
#pragma mark Data Source Loading / Reloading －－上拉涮新相关

//实现上拖的方法
- (void)reloadTableViewDataSource
{
	if (self.hotelListArray.count%HOTEL_NUMBER_PAGE==0) {
		pageIndex++;
		self.hotelRequestPara._pageIndex = pageIndex;
		[self loadDataSource];
		
		reloading = YES;
	}

}

//还原方法
- (void)doneLoadingTableViewData{
	reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.h_tableView];
}

#pragma mark -
#pragma mark UIScrollViewDelegate －－上拉涮新相关

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

@end
