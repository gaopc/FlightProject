//
//  VDatePickerViewController.m
//  FlightProject
//
//  Created by green kevin on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DatePickerViewController.h"

#import "TicketQueryViewController.h"
@interface DatePickerViewController ()
//返回当前月
- (void)returnMonth :(id)sender;
@end

@implementation DatePickerViewController
@synthesize dateType,startDateTicketQueryDataModel,backDateTicketQueryDataModel,delayDays,allowShowMonths,isAppointment,pushBackDay;
@synthesize allowShowDays;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
    UIButton  * rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 7, 52, 30) backImage:[UIImage imageNamed:@"ReturnsCurrentMonth.png"] target:self action:@selector(returnMonth:)];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
   

    if (self.delayDays == 0) {
        self.delayDays = 3;
     }
	
    if (self.allowShowMonths == 0) {
        self.allowShowMonths = 12;
     }
//    NSString *tempDate = nil;
    if (self.dateType == StarDate) {
	    //崔立东 201212-21调整与进入前标题一直
	    if (isAppointment==1) {
		   self.title = @"开始时间";
	    }else {
		    self.title = @"出发日期";
	    }
        tempDate = [[NSString alloc] initWithString:self.startDateTicketQueryDataModel._nameCode];
    }
    
    if (self.dateType == BackDate) {
	    if (isAppointment==1) {
		    self.title = @"结束时间";
	    }else {
		    self.title = @"返回日期";
	    }
        
        tempDate = [[NSString alloc] initWithString:self.backDateTicketQueryDataModel._nameCode];
    }
    
//    calendarView = [[[CalendarView alloc] initWithNSDate:[NSDate dateFromString:tempDate] allowShowMonths:self.allowShowMonths withDayCount:0 withPushBackDay:self.pushBackDay ] autorelease];
//    calendarView.delegate=self;
//    [self.view addSubview:calendarView];
    
	// Do any additional setup after loading the view.
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.allowsSelection = YES;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    currentDateStr = [[NSString alloc] initWithString:[dateFormatter stringFromDate:[NSDate date]]];
    [dateFormatter release];
}

- (void)viewDidAppear:(BOOL)animated
{
    int rowIndex = [self compareMonth:tempDate];
    if (rowIndex != 0) {
        NSIndexPath *lastRow = [NSIndexPath indexPathForRow:rowIndex inSection:0];
        [myTable scrollToRowAtIndexPath:lastRow
                       atScrollPosition:UITableViewScrollPositionBottom
                               animated:YES];
    }
}

-(void)dealloc
{
    self.startDateTicketQueryDataModel = nil;
    self.backDateTicketQueryDataModel = nil;
    [currentDateStr release];
    [tempDate release];
    [super dealloc];
}

-(void)calendarView:(CalendarView *)acalendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [acalendarView markDates:dates];
    }
}

-(void)calendarView:(CalendarView *)acalendarView dateSelected:(NSDate *)date {
    
 
    //NSLog(@"Selected date = %@ , china = %@, en = %@ ,WeekDay = %@",date,[currentDate dateStr:date] ,[currentDate dateCode:date],[currentDate getWeekDay:date]);
    
    NSString *dateStr = [NSDate dateFormateTicketQuery:date];
    NSString *dateCode =[NSDate dateCode:date];
    NSString *dateafterMonth = [NSDate dateafterDay:[[NSDate date] dateafterMonth:12] day:0 type:1];

    if (self.dateType == StarDate) {
        self.startDateTicketQueryDataModel._nameStr = dateStr;
        self.startDateTicketQueryDataModel._nameCode = dateCode;
//        self.startDateTicketQueryDataModel._isUserChoose = TRUE;

        //compare 逐字比较
        if ((!self.backDateTicketQueryDataModel._isUserChoose)&&([self.backDateTicketQueryDataModel._nameCode compare:dateCode] <0 )) {
            if ([[NSDate dateafterDay:date day:self.delayDays type:1] compare:dateafterMonth] > 0) {
                self.backDateTicketQueryDataModel._nameStr = [NSDate dateafterDay:[[NSDate date] dateafterMonth:12] day:0 type:3];
                self.backDateTicketQueryDataModel._nameCode = [NSDate dateafterDay:[[NSDate date] dateafterMonth:12] day:0 type:1];
            }
            else {
                self.backDateTicketQueryDataModel._nameStr = [NSDate dateafterDay:date day:self.delayDays type:3];
                self.backDateTicketQueryDataModel._nameCode = [NSDate dateafterDay:date day:self.delayDays type:1];
                //            self.backDateTicketQueryDataModel._isUserChoose = FALSE;
            }
        }
    }
    else if (self.dateType == BackDate) {
        self.backDateTicketQueryDataModel._nameStr = dateStr;
        self.backDateTicketQueryDataModel._nameCode = dateCode;
//        self.backDateTicketQueryDataModel._isUserChoose = TRUE;
    
        if ((!self.startDateTicketQueryDataModel._isUserChoose)&&([self.startDateTicketQueryDataModel._nameCode compare:dateCode] >0)) {
            self.startDateTicketQueryDataModel._nameStr = dateStr;
            self.startDateTicketQueryDataModel._nameCode = dateCode;
//            dateStr = [NSDate dateafterDay:date day:-self.delayDays type:3];
//            if ([dateStr compare:[NSDate dateFormateTicketQuery:[NSDate date]]] <0) {
//                dateStr = [NSDate dateFormateTicketQuery:[NSDate date]];
//                dateCode = [NSDate dateCode:[NSDate date]];
//            }
//            self.startDateTicketQueryDataModel._nameStr = dateStr;
//            self.startDateTicketQueryDataModel._nameCode = dateCode;
//            self.startDateTicketQueryDataModel._isUserChoose = FALSE;
        }
    }
	
    [NavigationController popViewControllerAnimated:YES];
   
}

//返回当前月
- (void)returnMonth :(id)sender {
	
//	[calendarView returnsCurrentMonth];
    
    NSIndexPath *lastRow = [NSIndexPath indexPathForRow:0 inSection:0];
    [myTable scrollToRowAtIndexPath:lastRow
                   atScrollPosition:UITableViewScrollPositionBottom
                           animated:YES];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allowShowMonths + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *newDate = currentDateStr;
    if (indexPath.row > 0) {
        newDate = [self addMonths:indexPath.row withMonth:currentDateStr];
    }
    float lastBlock = [[NSDate dateFromString:newDate] numDaysInMonth]+([[NSDate dateFromString:newDate] firstWeekDayInMonth]) - 1;
    int numRows = ceilf(lastBlock/7);
    return CalendarViewTopBarHeight + numRows*(CalendarViewDayHeight+2 + 2)+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    NSString * identifier = [NSString stringWithFormat:@"identifier%d", row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *newDate = currentDateStr;
        if (indexPath.row > 0) {
            newDate = [self addMonths:row withMonth:currentDateStr];
        }
        CalendarView *calendarView = [[CalendarView alloc] initWithNSDate:[NSDate dateFromString:newDate] allowShowMonths:self.allowShowMonths withDayCount:self.allowShowDays withPushBackDay:self.pushBackDay withSelectDate:[NSDate dateFromString:tempDate]] ;
        calendarView.delegate=self;
        [cell addSubview:calendarView];
        [calendarView release];
    }
    return cell;
}

- (NSString *)addMonths:(int)addNum withMonth:(NSString *)month
{
    NSString *newMonth = nil;
    NSArray *arr = [month componentsSeparatedByString:@"-"];
    int days = 0;
    if ([arr[2] intValue] > 28) {
        days = 28;
    }
    else {
        days = [arr[2] intValue];
    }
    int num = [arr[1] intValue] + addNum;
    if (num > 12) {
        newMonth = [NSString stringWithFormat:@"%d-%d-%d", [arr[0] intValue] + (num + 1)/13, (num + 1)%13, days];
    }
    else {
        newMonth = [NSString stringWithFormat:@"%@-%d-%d", arr[0], num, days];
    }
    return newMonth;
}

- (int)compareMonth:(NSString *)date
{
    int result = 0;
    if ([[NSDate dateFromString:date] year] == [[NSDate dateFromString:currentDateStr] year]) {
        result = [[NSDate dateFromString:date] month] - [[NSDate dateFromString:currentDateStr] month];
    }
    else if ([[NSDate dateFromString:date] year] > [[NSDate dateFromString:currentDateStr] year]) {
        int yearNum = [[NSDate dateFromString:date] year] - [[NSDate dateFromString:currentDateStr] year];
        int monthNum = [[NSDate dateFromString:date] month] - [[NSDate dateFromString:currentDateStr] month];
        result = 12*yearNum + monthNum;
    }
    else {
        result = 0;
    }
    return result;
}
@end
