//
//  HotelHomeViewController.h
//  FlightProject
//
//  Created by longcd on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetBasicInfoFromServer.h"
@class TicketQueryDataModel;
@class HotelInquiryDataResponse;
@class HotelQueryDataResponse;
@class TicketQueryDataModelElem;
@interface HotelHomeViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,CityListDelegate,UIActionSheetDelegate>
{
//	UIView *cityView; //入住城市
//	UIView *searchView; //查询
//	UIView *dateView; //酒店预订时间
//	UIView *buttonView; //查询按钮
	
	NSArray	*dataSourceArray;
	
	UISubLabel *checkCityLabel; //入住城市
	UISubLabel * startWeekLabel;//入住周
	UISubLabel * startDayLabel;//入住日 
	UISubLabel * endWeekLabel;//退房周
	UISubLabel * endDayLabel;//退房日 
	UISubLabel *searchLabel; //查找名称
	HotelInquiryDataResponse *hotelInquiryData;
        HotelQueryDataResponse *hotelQueryDR;
        TicketQueryDataModelElem * currentDataModelElem; // zxt 20121027
	
	UIActionSheet *actionSheet;
	
}


@property (nonatomic, retain) UITableView *h_tableView;
@property (nonatomic, retain) NSArray *dataSourceArray;

@property (nonatomic,retain) TicketQueryDataModel * queryDataModel;

@property (nonatomic,retain) UIView *cityView;
@property (nonatomic,retain) UIView *searchView;
@property (nonatomic,retain) UIView *dateView;
@property (nonatomic,retain) UIView *buttonView;

@property (nonatomic, retain) HotelRequestPara *hotelRequestPara;

@property (nonatomic, retain) NSMutableDictionary *filterHoteDictionary;
@property (nonatomic, retain) NSMutableDictionary *hoteNameDictionary;
@property (nonatomic, retain) NSMutableDictionary *hoteInquiryNameDictionary;

@property (nonatomic, retain) GetBasicInfoFromServer *server;

@property (nonatomic,assign) BOOL isCollect;


@end
