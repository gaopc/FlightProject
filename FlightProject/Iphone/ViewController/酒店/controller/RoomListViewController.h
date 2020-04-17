//
//  RoomListViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "RoomListCell.h"
@class HotelQueryDataResponse;

@interface RoomListViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,RoomListDelegate>
{
	NSInteger selectCabinIndex;
	UIView *markValueView;
	
}

@property (nonatomic,retain) NSString * lcdRate; //畅达币返点率
@property (nonatomic,retain) NSString * lcdValue; //畅达币返值
@property (nonatomic,retain) NSString * lcdActivityId; //畅达币有效天数

@property (nonatomic,retain) UITableView * r_tableView;
@property (nonatomic,retain) NSMutableArray * roomListArray;
@property (nonatomic,retain) HotelInfo * hotelInfo;

@property (nonatomic,retain) NSIndexPath * selectedCellIndexPath;
@property (nonatomic,assign) BOOL isExtend;
@property (nonatomic,retain) UIView *hotelView;
@property (nonatomic,retain) UIView *markValueView;


@property (nonatomic, retain) NSString *startDay;
@property (nonatomic, retain) NSString *endDay;
@property (nonatomic, retain) NSString *cityName;

@property (nonatomic,retain) HotelRoomType * selectRoomType;

-(void)preordainClick:(id)sender;//点击预订按钮
-(void)detailClick:(id)sender;//点击详情按钮

@end
