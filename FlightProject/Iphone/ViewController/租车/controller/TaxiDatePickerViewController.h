//
//  TaxiDatePickerViewController.h
//  FlightProject
//
//  Created by longcd mac mini 04 on 12-10-25.
//
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"
#import "NSDate+convenience.h"
#import "CustomScorllView.h"

@class  TaxiHomeDataModelElem ;

@protocol TaxiDatePickerViewControllerDelegate <NSObject>

-(void) didSelectedDateTimeFinshed:(id)object;

@end

@interface TaxiDatePickerViewController : RootViewController
<CalendarViewDelegate,CustomScorllViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UIView * upView;
    UIView * downView ;
//    CalendarView * calendarView ;
    CustomScorllView * customScorllView ;
    UIButton * currentButton;
    UITableView *myTable;
    NSString *currentDateStr;
    NSString *tempDate;
    int showMonths;
    int showDays;
}

@property (nonatomic,assign) TypeDate dateType ;
@property (nonatomic,retain) TaxiHomeDataModelElem * startDateTicketQueryDataModel;
@property (nonatomic,retain) TaxiHomeDataModelElem * backDateTicketQueryDataModel;
@property (nonatomic,assign) id delegate; 
@property (nonatomic,assign) int pushBackDay; 
@property (nonatomic,retain) NSString * startTimeRange;
@property (nonatomic,retain) NSString * backTimeRange;
@property (nonatomic,retain) NSString * _startDateName;
@property (nonatomic,retain) NSString * _backDateName;
@property (nonatomic,retain) NSString * _startDateCode;
@property (nonatomic,retain) NSString * _backDateCode;
@end
