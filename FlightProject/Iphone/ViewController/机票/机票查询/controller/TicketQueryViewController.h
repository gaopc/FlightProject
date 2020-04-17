//
//  TicketQueryViewController.h
//  FlightProject
//
//  Created by longcd on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketQueryCell.h"
#import "CityListViewController.h"
#import "DatePickerViewController.h"
#import "InterfaceClass.h"
#import "SendRequstCatchQueue.h"
#import "InterfaceClass.h"
#import "SendRequstCatchQueue.h"

#import "TicketQueryDetailViewController.h"
#import "TicketQueryConnectDetailViewController.h"
#import "TicketQueryRoundDetailViewController.h"
#import "DataClass.h"
#import "TicketHomeViewController.h"

#import "QueryFlightTicket.h"
#import "UIAlertSubView.h"
#import "GetBasicInfoFromServer.h"

@interface TicketQueryDataModelElem : NSObject
@property (nonatomic,retain) NSString * _nameStr;
@property (nonatomic,retain) NSString * _nameCode;
@property (nonatomic,assign) BOOL _isUserChoose;
+(TicketQueryDataModelElem *)TicketQueryDataModelElemWithStr:(NSString *)str  code:(NSString *)code;
@end

@interface TicketQueryDataModel  : NSObject
@property (nonatomic,retain) TicketQueryDataModelElem * _startDate;
@property (nonatomic,retain) TicketQueryDataModelElem * _arriveDate;
@property (nonatomic,retain) TicketQueryDataModelElem * _fromCity;
@property (nonatomic,retain) TicketQueryDataModelElem * _toCity;
@property (nonatomic,retain) TicketQueryDataModelElem * _transitCity;
@property (nonatomic,assign) FlightType _flightType;
@end

// 机票查询类
@interface TicketQueryViewController : RootViewController <UITableViewDelegate,UITableViewDataSource,TicketHomeViewControllerDelegate,UIAlertSubViewDelegate,CityListDelegate>
{
    UITableView * myTable;
    NSMutableArray * dataArray;
    FlightType flightType;   // 单程  往返  联程 标志
    NSDate *currentDate; 
    TicketQueryDataModelElem *currentDataModelElem;
    UIAlertSubView * alertSubView;
    UIButton * depButton;
    UIButton * arriveButton;
    BOOL  animateFinished;
}

@property (nonatomic,retain) UITableView * myTable;
@property (nonatomic,retain) QueryFlightTicket * queryTicket;
@property (nonatomic,retain) TicketQueryDataModel * queryDataModel;
@property (nonatomic,retain) NSArray * historyRecord;
@property (nonatomic,retain) NSArray * curentRecord;
@property (nonatomic, retain) NSString *buttonSelect;
@property (nonatomic, retain) GetBasicInfoFromServer *server;
@end
