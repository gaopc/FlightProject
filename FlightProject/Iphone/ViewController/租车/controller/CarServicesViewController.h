//
//  CarServicesViewController.h
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryCarService.h"
#import "CarSubmitOrderViewController.h"
#import "CarPassengerListViewController.h"
@interface CarServicesViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTable;
}
@property (nonatomic,retain) SubmitOrderCarInfo * queryDataModel;
@property (nonatomic,retain) CarModelDetail * carDetail;
@property (nonatomic,retain)QueryCarServiceResponse *carService;
@property (nonatomic,retain) NSMutableArray * isSelectedServiceArray;
@end
