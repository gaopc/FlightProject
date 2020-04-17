//
//  TicketQueryDetailViewController.h
//  FlightProject
//
//  Created by longcd on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketInfoViewController.h"
#import "QueryFlightTicket.h"
#import "QueryFlightTicketDetail.h"
#import "DoubleSlider.h"

@interface BottomView : UIView

@property (nonatomic,retain) UIImageView *  _leftImageView;
@property (nonatomic,retain) UIImageView *  _rightImageView;
@property (nonatomic,retain) UISubLabel * _proLabel;
@property (nonatomic,retain) UISubLabel * _nextLabel;
@property (nonatomic,retain) UISubLabel * _dateLabel;
@property (nonatomic,retain) UISubLabel * _weekLabel;

@property (nonatomic,retain) UIButton * _proButton;
@property (nonatomic,retain) UIButton * _nextButton;

@end


@interface FilterView : UIView
{
    DoubleSlider * flightTimeSlider;
}
@property (nonatomic,retain) NSMutableArray * _timeRange;
@property (nonatomic,retain) NSMutableArray * _startAirport;
@property (nonatomic,retain) NSMutableArray * _endAirport;
@property (nonatomic,retain) NSMutableArray * _airlines;

@property (nonatomic,retain) NSMutableArray * _selectTimeRange;
@property (nonatomic,retain) NSMutableArray * _selectStartAirport;
@property (nonatomic,retain) NSMutableArray * _selectEndAirport;
@property (nonatomic,retain) NSMutableArray * _selectAirlines;

@property (nonatomic,retain) UIButton * _FilterDownButton;

@property (nonatomic,retain) UIView * _view1;
@property (nonatomic,retain) UIView * _view2;
@property (nonatomic,retain) UIView * _view3;
@property (nonatomic,retain) UIView * _view4;

@property (nonatomic,assign) id delegate;

@end

typedef enum {
    TimeDesc,
    TimeAesc,
    PriceDesc,
    PriceAesc,
    Filter
} SortArrayBy;

@interface TicketQueryDetailViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,TicketInfoViewControllerDelegate>
{
    UIButton * timeButton;
    UIButton * filterButton;
    UIButton * priceButton;
    int selectButton;
    BOOL sortDese;
}

@property (nonatomic,retain) UITableView * myTable;
@property (nonatomic,retain) NSMutableArray * dataArray;
@property (nonatomic,retain) NSMutableArray * filterDataArray;

@property (nonatomic,retain)QueryFlightTicket * queryTicket;
@property (nonatomic,retain) TicketQueryDataModel * queryDataModel;
@property (nonatomic,retain) FlightInfo * selectedFlightInfo;
@property (nonatomic,retain) FilterView * filterView;
@property (nonatomic,retain) BottomView * bottomView;

@property (nonatomic,retain) NSMutableArray * flightsInfoArray;

@property (nonatomic,retain) NSString * searchDate;

@property (nonatomic,assign) SortArrayBy sortArrayBy;

-(void)pushTickeInfoVC;
-(void)sortDateArray;
@end
