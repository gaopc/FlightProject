//
//  CheckedViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckedViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>
{
	
}
@property (nonatomic, retain) UITableView *c_tableView;
@property(nonatomic, retain) NSMutableArray *checkedArray;
@property (nonatomic, retain) NSString *checkedTitle;
@property (nonatomic, retain) NSString *topTitle;
@property (nonatomic) int filterHotelType;
@property (nonatomic) int popType;
@property (nonatomic, retain) HotelRequestPara *hotelRequestPara;
@end
