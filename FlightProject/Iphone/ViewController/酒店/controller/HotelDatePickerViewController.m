//
//  HotelDatePickerViewController.m
//  FlightProject
//
//  Created by green kevin on 12-11-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelDatePickerViewController.h"
#import "TicketQueryViewController.h"
@interface HotelDatePickerViewController ()
//返回当前月
- (void)returnMonth :(id)sender;
@end

@implementation HotelDatePickerViewController
@synthesize dateType,startDateTicketQueryDataModel,backDateTicketQueryDataModel,allowShowMonths,pushBackDay,allowShowdays;

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
	
	tempDate = nil;
	if (self.dateType == StarDate) {
		self.title = @"入住日期";
        tempDate = [[NSString alloc] initWithString:self.startDateTicketQueryDataModel._nameCode];
		
	}
	if (self.dateType == BackDate) {
		self.title = @"离店日期";
        tempDate = [[NSString alloc] initWithString:self.backDateTicketQueryDataModel._nameCode];
	}
//	calendarView = [[[CalendarView alloc] initWithNSDate:[NSDate dateFromString:tempDate] allowShowMonths:self.allowShowMonths withDayCount:self.allowShowdays withPushBackDay:self.pushBackDay] autorelease];
//	calendarView.delegate=self;
//	if (self.dateType == BackDate)
//		calendarView.backDay = 1;
//	
//	[self.view addSubview:calendarView];
	
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
	
	if (self.dateType == StarDate) {
		self.startDateTicketQueryDataModel._nameStr = dateStr;
		self.startDateTicketQueryDataModel._nameCode = dateCode;
		
		//compare 逐字比较
		if ([self.backDateTicketQueryDataModel._nameCode compare:dateCode] <=0 ) {
			self.backDateTicketQueryDataModel._nameStr = [NSDate dateafterDay:date day:PushBackOneDay type:3];
			self.backDateTicketQueryDataModel._nameCode = [NSDate dateafterDay:date day:PushBackOneDay type:1];
			
		}
	}
	else if (self.dateType == BackDate) {
		self.backDateTicketQueryDataModel._nameStr = dateStr;
		self.backDateTicketQueryDataModel._nameCode = dateCode;
		
		if ([self.startDateTicketQueryDataModel._nameCode compare:dateCode] >=0) {
			self.startDateTicketQueryDataModel._nameStr =[NSDate dateafterDay:date day:PushBackNOneDay type:3]; // dateStr;
			self.startDateTicketQueryDataModel._nameCode = [NSDate dateafterDay:date day:PushBackNOneDay type:1];//dateCode;
			
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
    NSDate *dateafterDay=[NSDate dateafterDay:[NSDate date] day:self.allowShowdays];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *afterDay = [dateFormatter stringFromDate:dateafterDay];
    [dateFormatter release];
    return [self compareMonth:afterDay] + 1;
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
        CalendarView *calendarView = [[CalendarView alloc] initWithNSDate:[NSDate dateFromString:newDate] allowShowMonths:self.allowShowMonths withDayCount:self.allowShowdays withPushBackDay:self.pushBackDay withSelectDate:[NSDate dateFromString:tempDate]] ;
        calendarView.delegate=self;
        if (self.dateType == BackDate)
            calendarView.backDay = 1;
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
        newMonth = [NSString stringWithFormat:@"%d-%d-%d", [arr[0] intValue] + num/12, num%12, days];
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
