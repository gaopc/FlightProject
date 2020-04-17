//
//  HotelDatePickerViewController.h
//  FlightProject
//
//  Created by green kevin on 12-11-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"
#import "NSDate+convenience.h"

@class TicketQueryDataModelElem;
@interface HotelDatePickerViewController : RootViewController<CalendarViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
//	CalendarView * calendarView;
	NSDate *currentDate;
    UITableView *myTable;
    NSString *currentDateStr;
    NSString *tempDate;
}
@property (nonatomic,assign) TypeDate dateType ;
@property (nonatomic,assign) int allowShowMonths;
@property (nonatomic,assign) int allowShowdays;
@property (nonatomic,assign) int pushBackDay;

@property (nonatomic,retain) TicketQueryDataModelElem * startDateTicketQueryDataModel;
@property (nonatomic,retain) TicketQueryDataModelElem * backDateTicketQueryDataModel;
@end
