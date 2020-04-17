//
//  OrderTicketInfoViewController.h
//  FlightProject
//
//  Created by 高鹏程 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTicketToPerchCell.h"
#import "OrderTicketInfoCell.h"
#import "TicketOrderInfoViewController.h"
#import "DevicePositionMapViewController.h"
#import "GetConfiguration.h"

@class OrderInfoDataModel ;

@interface OrderTicketInfoViewController : RootViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *myTable;
    int insurancePrice;
}

@property (nonatomic,retain) OrderInfoDataModel * orderInfoData;
@property (assign) int totalPrice;
@property (nonatomic, retain) NSString *flyTpye; //0：单程     1：往返    2：联程
@end
