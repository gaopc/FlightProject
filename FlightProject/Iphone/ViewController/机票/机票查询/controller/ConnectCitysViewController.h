//
//  ConnectCitysViewController.h
//  FlightProject
//
//  Created by longcd on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketQueryConnectDetailViewController.h"
#import "QueryFlightTicket.h"


@interface ConnectCitysViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) NSArray * dataArray;
@property (nonatomic,retain) TicketQueryDataModel * queryDataModel;
@property (nonatomic,retain)SearchConnectFlightsBriefInfoRequest * connectRequest;
@end
