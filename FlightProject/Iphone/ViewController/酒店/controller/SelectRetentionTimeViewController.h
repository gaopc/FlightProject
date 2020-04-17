//
//  SelectRetentionTimeViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotelOrdersViewController;
@interface SelectRetentionTimeViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    @public HotelOrdersViewController* hotelOrdersViewController;
}
@property (nonatomic,retain) UITableView *myTableView;
@property (nonatomic,retain) NSArray *timeArray;
@property (nonatomic,assign) NSInteger selectTimeRow;
@property (nonatomic,assign) NSInteger selectNowTimeRow;
@property (nonatomic,assign) BOOL checkIsNowDate;

@end
