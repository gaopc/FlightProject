//
//  CarSubmitOrderViewController.h
//  FlightProject
//
//  Created by longcd on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberCarCell.h"
#import "MemberHotelCell.h"
#import "SubmitOrderCarInfo.h"
#import "RecommendClass.h"

@interface CarSubmitOrderViewController : RootViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *myTable;
    UIButton *bottomButton;
//    RecommendClass * recommend;
}
//@property (nonatomic,retain) NSArray * _hotelList;
//@property (nonatomic,retain) NSArray  * _ticketList;
@property (nonatomic,retain) SubmitOrderCarInfo * queryDataModel;
@end
