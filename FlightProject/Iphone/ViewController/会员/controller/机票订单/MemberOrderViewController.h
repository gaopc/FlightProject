//
//  MemberOrderViewController.h
//  FlightProject
//
//  Created by admin on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberOrderCell.h"
#import "MemberOrderPayViewController.h"
#import "MemberOrderStateViewController.h"
#import "MemberOrderInfo.h"
#import "MemberOrderDetailResponse.h"
#import "DoubleSlider.h"
#import "EGORefreshTableHeaderView.h"

@class OrderInfoDataModel;
@class TicketQueryDataModel;

@interface OrderListFilterView : UIView
{
    DoubleSlider * flightTimeSlider;
}

@property (nonatomic,retain) NSMutableArray * _orderStates;
@property (nonatomic,retain) NSMutableArray * _selectOrderStates;
@property (nonatomic,retain) NSArray * _selectRangeMonth;
@property (nonatomic,retain) UIView * _view1;
@property (nonatomic,retain) UIView * _view2;
@property (nonatomic,retain) UIImageView * _buttonView;

@property (nonatomic,assign) id delegate;

- (void)setTicketOrderTime:(int)index;
@end

@interface MemberOrderViewController :RootViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    UITableView *myTable;
    
    UIButton * timeButton;
    UIButton * filterButton;
    UIButton * priceButton;
    OrderInfoDataModel *orderInfoData;
    TicketQueryDataModel *ticketQueryData;
    
    NSUInteger cellSelect;
    BOOL priceDese;
    BOOL sortDese;
    int selectButton;
    BOOL loadMore;//筛选订单后，如果有加载更多按钮，点击按钮时加载更多数据后对得到的所有数据进行筛选，此时为YES；没有筛选订单，直接加载更多，此时代码加载完数据后还会去执行筛选方法，此时为NO
    
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL reloading;
	int pageIndex;
}

@property (nonatomic ,retain) NSMutableArray *data;
@property (nonatomic,retain) NSMutableArray * filterDataArray;
@property (nonatomic,retain) OrderListFilterView * filterView;
@property (assign) BOOL _dataIsFull;
@property (nonatomic,assign)int pageIndex;
@property (nonatomic,assign) BOOL isfromRecomend;
@property (nonatomic,retain) NSString* totalPage;
@end
