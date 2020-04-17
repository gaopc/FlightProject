//
//  PassengersInfoViewController.h
//  FlightProject
//
//  Created by longcd on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//乘机人信息

#import <UIKit/UIKit.h>
#import "PassengersInfoCell.h"
#import "PassengerInfoDataResponse.h"

@class PassengerInfoDataResponse;
@class TicketOrderInfoViewController;
@class MemberHomeViewController;

@interface PassengersInfoViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,PassengersInfoDelegate>
{
	UIButton *passengerAddButton; //新增乘机人;
	UIButton *submitButton; //添加乘机人;
	PassengerInfoDataResponse *passengerInfoData;
	NSMutableDictionary *stateDictionary;
	
@public	
	TicketOrderInfoViewController *memberVC;
	MemberHomeViewController *memberVC1;
	
    BOOL isRequestList;
}
@property (nonatomic,retain) NSMutableArray * passengersInfoArray;
@property (nonatomic,retain) UITableView *p_tableView;
@property (retain) NSMutableDictionary *stateDictionary;
@property (nonatomic,retain) UISubLabel *promptlable;

@property (nonatomic,assign) int sourceType;
@property (nonatomic,assign) int surplusTicket; //剩余票数
@property (nonatomic,retain) NSDate *currentYear;
@property (nonatomic,retain) NSDate *currentYearBack;
@property (nonatomic,retain) PassengerInfoItem *delPassInfoItem;
@property (nonatomic, retain) NSString *certDay;

//点击编辑按钮
-(void)editClick:(id)sender;

@end
