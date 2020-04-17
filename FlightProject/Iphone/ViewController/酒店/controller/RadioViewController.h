//
//  RadioViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RadioViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>
{
	
}

@property (nonatomic, retain) UITableView *r_tableView;
@property(nonatomic, retain) NSMutableArray *radioArray;
@property (nonatomic, retain) NSString *radioTitle;
@property (nonatomic, retain) NSString *topTitle;
@property (nonatomic) int filterHotelType;
@property (nonatomic) int popType;

@property (nonatomic, retain) HotelRequestPara *hotelRequestPara;

@end
