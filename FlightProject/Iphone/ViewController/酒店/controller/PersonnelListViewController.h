//
//  PersonnelListViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonnelListCell.h"
#import "HotelPassengerDataResponse.h"

@class HotelOrdersViewController;
@interface PersonnelListViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,PersonnelListDelegate>

{
	UIButton *passengerAddButton; //新增乘机人;
	UIButton *submitButton; //添加乘机人;
	HotelPassengerDataResponse *passengerInfoData;
//	NSMutableDictionary *stateDictionary;
	
@public	
	
	HotelOrdersViewController *memberVC;
	BOOL isRequestList;
}
@property (nonatomic,retain) NSMutableArray * passengersInfoArray;
@property (nonatomic,retain) UITableView *p_tableView;
@property (retain) NSMutableDictionary *stateDictionary;
@property (nonatomic,assign) int sourceType;
@property (nonatomic,assign) int surplusRoom; //房间数量;
@property (nonatomic,retain) HotelPersonnelInfo *hotelPersonnelInfo;

@end
