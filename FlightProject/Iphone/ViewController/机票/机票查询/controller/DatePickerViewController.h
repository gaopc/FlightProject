//
//  VDatePickerViewController.h
//  FlightProject
//
//  Created by green kevin on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"
#import "NSDate+convenience.h"

@class TicketQueryDataModelElem;

@interface DatePickerViewController : RootViewController<CalendarViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
//    CalendarView * calendarView;
    NSDate *currentDate;
    UITableView *myTable;
    NSString *tempDate;
    NSString *currentDateStr;
}
@property (nonatomic,assign) TypeDate dateType ;
@property (nonatomic,assign) int delayDays;
@property (nonatomic,assign) int allowShowMonths;//允许选中月份
@property (nonatomic,assign) int allowShowDays;//允许选中天数

@property (nonatomic,assign) int pushBackDay;//添加延期日期
@property (nonatomic,assign) int isAppointment; //机票预约
@property (nonatomic,retain) TicketQueryDataModelElem * startDateTicketQueryDataModel;
@property (nonatomic,retain) TicketQueryDataModelElem * backDateTicketQueryDataModel;
@end
