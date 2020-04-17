//
//  TrainListViewController.h
//  FlightProject
//
//  Created by admin on 13-1-6.
//
//

#import <UIKit/UIKit.h>
#import "TrainListViewCell.h"
#import "TrainListInfo.h"
#import "TrainTicketInfoViewController.h"
#import "MyRegex.h"
#import "NSDate+convenience.h"
#import "RecommendClass.h"
#import "AirlineTicketView.h"

@interface TrainListFilterView : UIView

@property (nonatomic,retain) NSMutableArray * _orderStates;
@property (nonatomic,retain) NSMutableArray * _selectOrderStates;
@property (nonatomic,retain) NSArray * _selectRangeMonth;
@property (nonatomic,retain) UIView * _view2;
@property (nonatomic,retain) UIImageView * _buttonView;
@property (nonatomic,assign) id delegate;
@end


@interface TrainListViewController : RootViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *myTable;
    UIButton * timeButton;
    UIButton * filterButton;
    UIButton * priceButton;
    
    int cellSelect;
    BOOL priceDese;
    BOOL sortDese;
    int selectButton; //0未选中，1左侧选中，2右侧选中
    RecommendClass * recommend;
}

@property (nonatomic ,retain) NSMutableArray *data;
@property (nonatomic, retain) NSMutableArray * filterDataArray;
@property (nonatomic, retain) TrainListFilterView * filterView;
@property (nonatomic, retain) TrainListInfo *selectRowData;
@property (nonatomic, retain) NSString *searchType;

//崔立东 添加
@property(nonatomic,retain) NSString *startStation;
@property(nonatomic,retain) NSString *endStation;
@property (nonatomic,retain) TicketQueryDataModel * _ticketQuery;
@property (nonatomic,retain) QueryFlightTicket  * _ticketList;
@property (nonatomic,retain) NSArray  * _recommendsecRow;
@property (nonatomic,retain) id _seconInstance;
@property (nonatomic, retain) AirlineTicketView *airlineTicketView;

@end
