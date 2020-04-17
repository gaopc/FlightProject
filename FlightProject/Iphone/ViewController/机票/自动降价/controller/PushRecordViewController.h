//
//  PushRecordViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PushDetailInfo;
@interface PushRecordViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>

{
	
}
@property(nonatomic, retain) NSMutableArray *pushRecordArray;
@property (nonatomic,retain) UITableView *p_tableView;
@property (nonatomic,retain) NSString *ticketPrice;
@end
