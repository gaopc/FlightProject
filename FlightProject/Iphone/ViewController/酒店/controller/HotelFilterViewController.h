//
//  HotelFilterViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelQueryDataResponse.h"
@class HotelListViewController;
@interface HotelFilterViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>
{
	UIButton *submitButton;
@public	
	HotelListViewController *hotelListVC;
	
}

@property (nonatomic, retain) UITableView *h_tableView;
@property(nonatomic, retain) NSMutableArray *hotelListArrat;


@property (nonatomic, retain) NSMutableDictionary *filterHoteDictionary;
@property (nonatomic, retain) NSMutableDictionary *hoteNameDictionary;
@property (nonatomic, retain) NSMutableDictionary *hoteInquiryNameDictionary;

@property (nonatomic, strong) HotelRequestPara *hotelRequestPara;


@end
