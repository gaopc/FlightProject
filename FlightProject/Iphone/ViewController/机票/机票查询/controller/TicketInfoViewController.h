//
//  TicketInfoViewController.h
//  FlightProject
//
//  Created by longcd on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataClass.h"

#import "QueryFlightTicket.h"

@class TicketQueryDataModel;
@protocol TicketInfoViewControllerDelegate <NSObject>

-(void)getOtherFlightData;

@end

@interface TicketInfoViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    NSInteger selectCabinIndex;
}
@property (nonatomic,assign) id <TicketInfoViewControllerDelegate> delegate;

@property (nonatomic,retain) UITableView * myTable;

@property (nonatomic,retain) NSMutableArray * flightsInfoArray;

@property (nonatomic,retain) NSArray * dataArray;

@property (nonatomic,retain) FlightInfo * queryTicket;
@property (nonatomic,retain) TicketQueryDataModel * queryDataModel;

@property (nonatomic,retain) NSIndexPath * selectedCellIndexPath;

@property (nonatomic,assign) BOOL isExtend;

@property (nonatomic,retain) NSString * _fromWeather;
@property (nonatomic,retain) NSString * _toWeather;
@property (nonatomic,retain) NSString * _selectAirportCode;
@property (nonatomic,retain) NSString * _selectAirportName;
@end


