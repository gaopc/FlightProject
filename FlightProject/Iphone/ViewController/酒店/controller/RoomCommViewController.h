//
//  RoomCommViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
@class HotelQueryDataResponse;
@interface RoomCommViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate>
{
	HotelQueryDataResponse *hotelDataResponse;
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL reloading;
	int pageIndex;
	
}

@property (nonatomic, retain) UITableView *c_tableView;
@property(nonatomic, retain) NSMutableArray *hotelCommArray;
@property(nonatomic, retain)  UISubLabel *noCommTitleLabel;
@property(nonatomic, retain) HotelInfo *hotelInfo;

-(void) reloadTableViewDataSource; 
-(void) doneLoadingTableViewData;

@end
