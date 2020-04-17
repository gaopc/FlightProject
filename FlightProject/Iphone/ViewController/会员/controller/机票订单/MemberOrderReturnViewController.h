//
//  MemberOrderReturnViewController.h
//  FlightProject
//
//  Created by admin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketNumberInfoResponse.h"
#import "MemberOrderDetailCell.h"
#import "MemberOrderViewController.h"


@interface MemberOrderReturnViewController : RootViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate,CustomUISwitchDelegate>
{
    UITableView *myTable;
    CGSize lableViewSize;
    UIButton *normalReturn;
    UIButton *lcdReturn;
}

@property (nonatomic, retain) TicketNumberInfoResponse *ticketNumberInfo;
@property (assign) BOOL _notLoginUser;
@end
