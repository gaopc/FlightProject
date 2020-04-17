//
//  CarInformationViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberCarCell.h"
#import "MemberHotelCell.h"
#import "GetOrderCarInformation.h"
#import "SubmitOrderCar.h"

@interface CarInformationViewController : RootViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *myTable;
    UIButton *bottomButton;
    UIImageView *lineView;
}
@property (nonatomic, retain) GetOrderCarInformation *_carInfoData;
@property (nonatomic, retain) NSString *_ids;
@property (assign) BOOL _notLoginUser;
@end
