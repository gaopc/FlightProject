//
//  HotelInformationViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberHotelCell.h"
#import "GetOrderHotelList.h"

@interface HotelInformationViewController : RootViewController<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
{
    UITableView *myTable;
    UIButton *bottomButton;
    UIImageView *lineView;
}
@property (nonatomic, retain) HotelModel *_hotelDetailInfo;
@end
