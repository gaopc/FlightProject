//
//  YearMonthDayView.m
//  FlightProject
//
//  Created by longcd on 12-11-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "YearMonthDayView.h"
#import "NSDate+convenience.h"

@implementation YearMonthDayView
@synthesize yearArray,delegate;
@synthesize monthArray,selectedYearRow,selectedMonthRow;
@synthesize dayArray,selectedDayRow;
@synthesize selectYear,selectMonth,selectDay;
-(void)dealloc
{
    self.yearArray = nil;
    self.monthArray = nil;
    self.dayArray = nil;
    self.delegate = nil;
    
    self.selectYear = nil;
    self.selectMonth = nil;
    self.selectDay = nil;
    
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame Title:(NSString *) title  array:(NSArray *)array selectYear:(NSString *)year selectMonth:(NSString *)month selectDay:(NSString *)day
{
    if (self == [super initWithFrame:frame]) {
        self.selectYear = year;
        self.selectMonth = month;
        self.selectDay = day;
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) image:[UIImage imageNamed:@"CustomScorllViewYMD.png"]]];
        
        [self addSubview: [ UISubLabel labelWithTitle:title frame:CGRectMake(0, 5, frame.size.width, 20) font:FontSize20 color:FontColor909090 alignment:NSTextAlignmentCenter] ];
        self.yearArray = array;
        self.monthArray = [NSArray arrayWithObjects:@"01月", @"02月",@"03月",@"04月",@"05月",@"06月",@"07月",@"08月",@"09月",@"10月",@"11月",@"12月",nil];
        [self creatMonthView];
        
        NSMutableArray * _dayArray = [NSMutableArray array];
        for (int i=1; i<32; i++) {
            [_dayArray addObject:[NSString stringWithFormat:@"%02d日",i]];
        }
        self.dayArray = _dayArray;
        [self creatDayView];
        
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:50 title:nil frame:CGRectMake(174.0f, frame.size.height - 40, 113.0f, 34.0f) backImage:[UIImage imageNamed:@"TicketQueryConnectSure.png"] target:self action:@selector(yesButton)]];
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:51 title:nil frame:CGRectMake(35.0f, frame.size.height - 40, 113.0f, 34.0f) backImage:[UIImage imageNamed:@"TicketQueryConnectCancel.png"] target:self action:@selector(noButton)]];
    }
    return self;
}
-(void)setYearArray:(NSArray *)_yearArray
{
    if (yearArray != _yearArray) {
        [yearArray release];
        yearArray = nil;
        yearArray = [_yearArray retain];
        [self creatYearView];
    }
}
-(void)creatYearView
{
    self.selectedYearRow = 0;
    yearTable = [[CustomTableView alloc] initWithFrame:CGRectMake(40, 31, 93, 105)];
    yearTable.selectedStr = self.selectYear;
    yearTable.dataArray = self.yearArray;
    yearTable.backgroundColor = [UIColor clearColor];
    yearTable.delegate = self;
    yearTable.dataSource = self;
    
    [self addSubview:yearTable];
    [yearTable release];
}
-(void) creatMonthView
{

    self.selectedMonthRow = 0;
    monthTable = [[CustomTableView alloc] initWithFrame:CGRectMake(135, 31, 68, 105)];
    monthTable.selectedStr = self.selectMonth;
    monthTable.dataArray = self.monthArray;
    monthTable.backgroundColor = [UIColor clearColor];
    monthTable.delegate = self;
    monthTable.dataSource = self;
    
    [self addSubview:monthTable];
    [monthTable release];
}
-(void) creatDayView
{
    self.selectedDayRow = 0;
    [dayTable removeFromSuperview];
    dayTable = [[CustomTableView alloc] initWithFrame:CGRectMake(205, 31, 90, 105)];
    dayTable.selectedStr = self.selectDay;
    dayTable.dataArray = self.dayArray;
    dayTable.backgroundColor = [UIColor clearColor];
    dayTable.delegate = self;
    dayTable.dataSource = self;
    
    [self addSubview:dayTable];
    [dayTable release];
}
-(float)heightForRow:(CustomTableView *)tableView
{
    return 30.0f;
}

-(NSInteger)numberOfRows:(CustomTableView *)tableView
{
    return [tableView.dataArray count];
}
-(NSString *)customTableView:(CustomTableView *)tableView titleForHeaderInRow:(NSInteger)row
{
    NSString * instance = [tableView.dataArray objectAtIndex:row];
    if ([instance isKindOfClass:[NSString class]]){
        return  [tableView.dataArray objectAtIndex:row];
    }
    return nil;
}
-(void)customTableView:(CustomTableView *)tableView didSelectIndex:(NSString *)indexStr
{
    if (tableView == yearTable) {
        self.selectYear = [yearTable.dataArray objectAtIndex:[indexStr intValue]];
        self.selectedYearRow = [indexStr intValue];
        if (self.selectedMonthRow == 1) {
            NSString * yearStr = [[self.yearArray objectAtIndex:self.selectedYearRow] substringToIndex:4];
            NSString * monthStr = [[self.monthArray objectAtIndex:self.selectedMonthRow] substringToIndex:2];
            NSString * dateTimeStr = [NSString stringWithFormat:@"%@-%@-01 11:11:11",yearStr,monthStr];
            NSDate * dateTime = [NSDate dateFromString:dateTimeStr withFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSInteger dayCount = [dateTime numDaysInMonth];
            if (dayCount != [self.dayArray count]) {
                NSMutableArray * _dayArray = [NSMutableArray array];
                for (int i=1; i< dayCount+1; i++) {
                    [_dayArray addObject:[NSString stringWithFormat:@"%02d日",i]];
                }
                self.dayArray = _dayArray;
                [self creatDayView];
            }
        }
    }    
    else  if (tableView == monthTable){
        self.selectMonth = [monthTable.dataArray objectAtIndex:[indexStr intValue]];
        if (self.selectedMonthRow != [indexStr intValue]) {
            self.selectedMonthRow = [indexStr intValue];
            
            NSString * yearStr = [[self.yearArray objectAtIndex:self.selectedYearRow] substringToIndex:4];
            NSString * monthStr = [[self.monthArray objectAtIndex:self.selectedMonthRow] substringToIndex:2];
            NSString * dateTimeStr = [NSString stringWithFormat:@"%@-%@-01 11:11:11",yearStr,monthStr];
            NSDate * dateTime = [NSDate dateFromString:dateTimeStr withFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSInteger dayCount = [dateTime numDaysInMonth];
            if (dayCount != [self.dayArray count]) {
                NSMutableArray * _dayArray = [NSMutableArray array];
                for (int i=1; i< dayCount+1; i++) {
                    [_dayArray addObject:[NSString stringWithFormat:@"%02d日",i]];
                }
                self.dayArray = _dayArray;
                [self creatDayView];

            }
        }
    }
    else {
        self.selectDay = [dayTable.dataArray objectAtIndex:[indexStr intValue]];
        self.selectedDayRow = [indexStr intValue];
    }
}
-(void) yesButton
{  
    if (self.delegate && [self.delegate respondsToSelector:@selector(sureButtonClick:)]) {
        
        NSString * yearStr = [self.yearArray objectAtIndex:self.selectedYearRow];
        yearStr = [yearStr substringToIndex:4] ;
        NSString * monthStr = [self.monthArray objectAtIndex:self.selectedMonthRow];
        monthStr = [monthStr substringToIndex:2] ;
        NSString * dayStr = [self.dayArray objectAtIndex:self.selectedDayRow];
        dayStr = [dayStr substringToIndex:2] ;
        
        NSString * instance = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
        [self.delegate performSelector:@selector(sureButtonClick:) withObject:instance];
    }
}
-(void) noButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClick)]) {
        [self.delegate performSelector:@selector(cancelButtonClick)];
    }
}

- (void)tableViewPosition:(NSString *)year withMonth:(NSString *)month withDay:(NSString *)day
{
    int currentYearValue = [[NSDate date] year];
    int yearInterval = 100;
    int startYear = yearInterval - (currentYearValue - [year intValue]);
    
    [yearTable scrollToRow:startYear];
    [monthTable scrollToRow:[month intValue] - 1];
    [dayTable scrollToRow:[day intValue] - 1];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
