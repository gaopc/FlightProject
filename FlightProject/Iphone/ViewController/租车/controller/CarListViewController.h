//
//  CarListViewController.h
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarListCell.h"
#import "EGORefreshTableHeaderView.h"
#import "CarPassengerViewController.h"
#import "CarPassengerListViewController.h"
#import "CarPassengerViewController.h"

@interface CarListViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL reloading;
	int pageIndex;
    UITableView * myTable;
}
@property (nonatomic,retain) SubmitOrderCarInfo * queryDataModel;
@property (nonatomic,retain) CarModelDetail * selectedCarDetail;
@property (nonatomic,retain) NSMutableArray * carListDataArray;
@property (nonatomic,assign) BOOL isfromRecomend;
@end
