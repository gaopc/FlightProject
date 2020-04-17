//
//  HotelAndCarLisView.h
//  FlightProject
//
//  Created by 月 小 on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelAndCarLisView : UIView
{
    UIButton * timeButton;
    UIButton * filterButton;
    UIButton * priceButton;
}
@property(nonatomic,retain)UITableView *myTable;
@property(nonatomic,assign)id delegate;
@end
