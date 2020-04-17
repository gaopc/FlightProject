//
//  HotelListViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "TicketQueryViewController.h"
#import "HotelBottomView.h"
#import "MapKit/MapKit.h"
@class HotelQueryDataResponse;
@class HotelInquiryDataResponse;
@class HotelHomeViewController;
#define HOTEL_NUMBER_PAGE 20
@interface HotelListViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,MKMapViewDelegate,HotelBottomDelegate>
{
	UIButton *starButton;
	UIButton *filterButton;
	UIButton *priceButton;
	
	HotelQueryDataResponse *hotelDataResponse;
	HotelInquiryDataResponse *inquiryDataResponse;
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL isSelectMap;
	BOOL reloading;
	int pageIndex;
	
	
@public	
	HotelHomeViewController *hotelHomeVC;
	
}
@property (nonatomic, retain) UITableView *h_tableView;
@property (nonatomic, retain) NSMutableArray *hotelListArray;
@property (nonatomic, retain) NSMutableDictionary *filterHoteDictionary;
@property (nonatomic, retain) NSMutableDictionary *hoteNameDictionary;
@property (nonatomic, retain) NSMutableDictionary *hoteInquiryNameDictionary;

@property (nonatomic, retain) NSString *byStar;
@property (nonatomic, retain) NSString *byPrice;
@property (nonatomic, retain) NSString *cityTitle;
@property (nonatomic, retain) HotelInfo *hotelInfo;
@property (nonatomic, retain) HotelRequestPara *hotelRequestPara;

@property (nonatomic, retain) UIView *tempView;

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) UIView *listView;
@property (nonatomic, retain) HotelBottomView *bottomView;

@property (nonatomic,retain) TicketQueryDataModel * queryDataModel;
@property (nonatomic,retain) TicketQueryDataModelElem * currentDataModelElem;

@property (nonatomic,assign) BOOL isfromRecomend;

@property (nonatomic,assign) BOOL isSpecialOffer;
@property (nonatomic,assign) BOOL isLastPage;
@property (nonatomic,assign) int totalPage;
@property (nonatomic,assign) int number;
@property (nonatomic,retain) NSString * lcdRate; //畅达币返点率
@property (nonatomic,retain) NSString * lcdValue; //畅达币返值
@property (nonatomic,retain) NSString * lcdActivityId; //畅达币有效天数
@property (nonatomic,retain) NSString * specialOfferNumber; //今日特价酒店数量

-(void) reloadTableViewDataSource; 
-(void) doneLoadingTableViewData;
- (void)loadFitstDataSource;
//传递数据请求
-(void)mapClick:(id)sender;//点击地图按钮
-(void)isrefreshHeaderView;

@end
