//
//  TicketQueryView.h
//  FlightProject
//
//  Created by green kevin on 12-6-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketQueryCell.h"
#import "CityListViewController.h"
#import "FlyTimeRangeViewController.h"
#import "FlightCompanyViewController.h"
#import "DatePickerViewController.h"
#import "InterfaceClass.h"
#import "SendRequstCatchQueue.h"
#import "InterfaceClass.h"
#import "SendRequstCatchQueue.h"
#import "SearchFlightsBriefInfoResponse.h"
#import "TicketQueryDetailViewController.h"
#import "TicketQueryConnectDetailViewController.h"
#import "TicketQueryRoundDetailViewController.h"
#import "DataClass.h"
#import "ConnectCitysViewController.h"




@interface TicketQueryView : UIView <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView * myTable;
    NSMutableArray * dataArray;
    FlightType flightType;   // 单程  往返  联程 标志
    
}
@property (nonatomic,retain) NSMutableArray * dataArray;
@property (nonatomic,retain) UITableView * myTable;
@property (nonatomic,retain) Citys * city;
@property (nonatomic,retain) TimeRange * timeRange;
@property (nonatomic,retain)NSArray * connectCitys; // 中转城市集
@property (nonatomic,retain)SearchConnectFlightsBriefInfoRequest * connectRequest;
@property (nonatomic,retain)SearchFlightsBriefInfoRequest * briefInfoRequest;
@property (nonatomic,retain) UINavigationController * navigationController;

-(NSString *)dateStr:(NSDate*)date;
-(NSString *)dateCode:(NSDate*)date;
@end
