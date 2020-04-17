//
//  HotelFilterNextViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelFilterNextViewController :  RootViewController<UITableViewDelegate,UITableViewDataSource>

{
}

@property (nonatomic, retain) UITableView *h_tableView;
@property(nonatomic, retain) NSMutableArray *hotelListArrat;


@property (nonatomic, retain) NSMutableDictionary *filterHoteDictionary;
@property (nonatomic, retain) NSMutableDictionary *hoteNameDictionary;
@property (nonatomic, retain) HotelRequestPara *hotelRequestPara;

@end