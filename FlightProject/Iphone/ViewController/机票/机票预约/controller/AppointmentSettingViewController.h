//
//  AppointmentSettingViewController.h
//  FlightProject
//
//  Created by 崔立东 on 12-9-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  预约设置
//

#import <UIKit/UIKit.h>
#import "DoubleSlider.h"
#import "SingleSlider.h"
#import "GetBasicInfoFromServer.h"
@class TicketQueryDataModel;
@class TicketAppointmentDataResponse;
@class TicketAppointmentViewController;
@class TicketQueryDataModelElem;
@interface AppointmentSettingViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,CityListDelegate>
{
	UIView *cityView; //城市视图
	UIView *dateView; //时间视图
	UIView *flightTimeView; //飞行时间段视图
	UIView *smsView; //接收短信时间段视图
	UIView *saleView; //折扣视图
	
	UISubLabel *sallyCityViewLabel; //出发城市
	UISubLabel *arriveCityViewLabel;  //到达城市
	UISubLabel * startWeekLabel;//开始周
	UISubLabel * startDayLabel;//开始日 
	UISubLabel * endWeekLabel;//结束周
	UISubLabel * endDayLabel;//结束日 
	
	DoubleSlider *flightTimeSlider;  //起飞时段双向滑动栏
	DoubleSlider *smsTimeSlider;     //短信接收时段双向滑动栏
	SingleSlider *saleSlider;   //仓位折扣滑动栏
	
	int flyPeriod; //起飞时间段
	int endPeriod; //降落时间段
	int smsTime;  //短信接收起时段
	int endSmsTime;//短信接收结束时段
	int cabinDiscount;//int 舱位折扣,折扣选择只包含整数折扣(3-9和、全价共计7个)价格 应低于全价,此处5表示5折以下
	
	UIButton *submitButton; //预约提交按钮
	NSArray *dataSourceArray;	
	NSMutableArray* timePeriodArray; //时间段数组
	NSMutableArray* saleArray;       //折扣数组
	
	TicketAppointmentDataResponse *appointmentData;
	
	@public
	TicketAppointmentViewController *ticketAppointmentVC;
		
    TicketQueryDataModelElem * currentDataModelElem; // zxt 20121027
    
}
@property (nonatomic, retain) UITableView *s_tableView;;

@property (nonatomic, retain) NSArray *dataSourceArray;
@property (nonatomic, retain, readonly) UIView *cityView;
@property (nonatomic, retain, readonly) UIView *dateView;
@property (nonatomic, retain, readonly) UIView *flightTimeView;
@property (nonatomic, retain, readonly) UIView *smsView;
@property (nonatomic, retain, readonly) UIView *saleView;

@property (nonatomic,retain) TicketQueryDataModel * queryDataModel;

@property (nonatomic, retain) NSString *buttonSelect;
@property (nonatomic, retain) GetBasicInfoFromServer *server;

@end
