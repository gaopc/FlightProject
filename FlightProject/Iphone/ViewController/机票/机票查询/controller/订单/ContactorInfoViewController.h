//
//  ContactorInfoViewController.h
//  FlightProject
//
//  Created by longcd on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//联系人信息

#import <UIKit/UIKit.h>
#import "GetContactorInfosResponse.h"

@class TicketOrderInfoData;
@interface ContactorInfoViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTable;
}
@property (nonatomic,retain) NSMutableArray * dataArray;
@property (nonatomic,retain) TicketOrderInfoData * ticketOrderInfoData;
@property (nonatomic,assign) int currentIndex;
@end
