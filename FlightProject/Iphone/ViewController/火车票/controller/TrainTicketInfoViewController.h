//
//  TrainTicketInfoViewController.h
//  FlightProject
//
//  Created by green kevin on 13-1-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TrainListInfo;
@interface TrainTicketInfoViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>
{
	int rowday2;
	int rowday3;
	int rowday4;
	int indexstar;
	int indexend;
	
	int indexDay1;
	int indexDay2;
	int indexDay3;
}

@property (nonatomic,retain)NSString * fromStation; //出发车站
@property (nonatomic,retain)NSString * toStation; //到达车站
@property (nonatomic,retain)NSString * searchType; //查询类型

@property (nonatomic,retain)UISubLabel * fromStationLabel; //出发车站
@property (nonatomic,retain)UISubLabel * toStationLabel;   //到达车站
@property (nonatomic,retain)UISubLabel * fromTimeLabel;    //开始时间
@property (nonatomic,retain)UISubLabel * toTimeLabel;      //结束时间
@property (nonatomic,retain)UISubLabel * thatDayLabel;     //是否是当天
@property (nonatomic,retain)UISubLabel * mileageLabel;     //里程
@property (nonatomic,retain)UISubLabel * durationLabel;    //历时



@property (nonatomic,retain)UITableView * s_tableView;//车站详情数组
@property (nonatomic,retain)NSMutableArray * stationInfoArray;//车站详情数组
@property (nonatomic,retain)TrainListInfo * trainListInfo;//详情

@property (nonatomic,retain)NSMutableDictionary *ticketPriceDict;
@property (nonatomic,retain)UIView * ticketPriceViewA;//票价ViewA
@property (nonatomic,retain)UIView * ticketPriceViewB;//票价ViewB

@end
