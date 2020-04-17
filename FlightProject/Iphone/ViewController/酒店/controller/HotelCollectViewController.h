//
//  HotelCollectViewController.h
//  FlightProject
//
//  Created by z1 on 13-6-26.
//
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "HotelCollectDataResponse.h"
#import "EGORefreshTableHeaderView.h"
@class TicketQueryDataModel;
@class TicketQueryDataModelElem;
@class HotelHomeViewController;

@interface HotelCollectViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate>
{
	HotelCollectDataResponse *hotelCollectDataResponse;
	int pageIndex;
	TicketQueryDataModelElem * currentDataModelElem; // zxt 20121027
	
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL reloading;
	
	
	
	
	
@public
	HotelHomeViewController *hotelHomeVC;
}
@property (nonatomic, retain) HotelCollectDataResponse *hotelCollectDataResponse;
@property (nonatomic, retain) UITableView *h_tableView;
@property (nonatomic, retain) NSMutableArray *hotelListArray;
@property (nonatomic, retain) HotelCollect *hotelCollect;

@property (nonatomic,retain) TicketQueryDataModel * queryDataModel;
@property (nonatomic,retain) UISubLabel *promptlable;
@property (assign) BOOL _dataIsFull;
@property (nonatomic,assign)int pageIndex;


@property (nonatomic,assign) BOOL isfromRecomend;

-(void) reloadTableViewDataSource;
-(void) doneLoadingTableViewData;


@end
