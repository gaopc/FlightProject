//
//  OrderHotelLisViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetOrderHotelList.h"
#import "EGORefreshTableHeaderView.h"
#import "CarHotelLiFilterView.h"


@interface OrderHotelLisViewController : RootViewController <UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    UIButton * timeButton;
    UIButton * filterButton;
    UIButton * priceButton;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL reloading;
	int pageIndex;
    
    BOOL sortTimeDese;
    BOOL sortPriceDese;
    int  selectButton;
    BOOL loadMore;//筛选订单后，如果有加载更多按钮，点击按钮时加载更多数据后对得到的所有数据进行筛选，此时为YES；没有筛选订单，直接加载更多，此时代码加载完数据后还会去执行筛选方法，此时为NO
}
@property (nonatomic,retain)UITableView *myTable;
@property (nonatomic,retain)GetOrderHotelList *getOrderHotelList;
@property (nonatomic,retain)CarHotelLiFilterView *hotelLiFilterView;
@property (nonatomic,retain)GetOrderHotelList *currentHotelList;//存储当前排完序或筛选后的列表
@property (assign) BOOL _dataIsFull;
@property (nonatomic,assign)int pageIndex;
@property (nonatomic,assign) BOOL isfromRecomend;
-(void) reloadTableViewDataSource; 
-(void) doneLoadingTableViewData;
@end
