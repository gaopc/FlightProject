//
//  YearMonthView.m
//  FlightProject
//
//  Created by longcd on 12-11-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "YearMonthView.h"

@implementation YearMonthView
@synthesize yearArray,delegate;
@synthesize monthArray,selectedYearRow,selectedMonthRow,selectMonth,selectYear;
-(void)dealloc
{
	self.yearArray = nil;
	self.monthArray = nil;
	self.delegate = nil;
	self.selectMonth = nil;
    self.selectYear = nil;
    
	[super dealloc];
}

-(id)initWithFrame:(CGRect)frame Title:(NSString *) title  array:(NSArray *)array selectYear:(NSString *)year selectMonth:(NSString *)month
{
	if (self == [super initWithFrame:frame]) {
        self.selectYear = year;
        self.selectMonth = month;
		[self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) image:[UIImage imageNamed:@"CustomScorllViewYM.png"]]];
		[self addSubview: [ UISubLabel labelWithTitle:title frame:CGRectMake(0, 5, frame.size.width, 20) font:FontSize20 color:FontColor909090 alignment:NSTextAlignmentCenter] ];
		NSString * year = [NSString stringWithFormat:@"%@%@",[[NSDate dateCode:[NSDate date]] substringToIndex:4],@"年"];
		self.yearArray = array;
		if ([self.selectYear isEqualToString:year]) {
			NSMutableArray *marray = [NSMutableArray array];
			NSString * month =[[NSDate dateCode:[NSDate date]] substringWithRange:NSMakeRange(5, 2)];
			for (int i=[month intValue]; i<=12; i++) {
				[marray addObject:[NSString stringWithFormat:@"%02d月",i]];
			}
			//self.selectMonth = [NSString stringWithFormat:@"%@月",month];
			self.monthArray = marray;
		}else {
			self.monthArray = [NSArray arrayWithObjects:@"01月", @"02月",@"03月",@"04月",@"05月",@"06月",@"07月",@"08月",@"09月",@"10月",@"11月",@"12月",nil];
			
		}
		[self creatMonthView];
		[self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:50 title:nil frame:CGRectMake(45.0f, frame.size.height - 40, 113.0f, 34.0f) backImage:[UIImage imageNamed:@"TicketQueryConnectCancel.png"] target:self action:@selector(noButton)]];
		[self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:51 title:nil frame:CGRectMake(184.0f, frame.size.height - 40, 113.0f, 34.0f) backImage:[UIImage imageNamed:@"TicketQueryConnectSure.png"] target:self action:@selector(yesButton)]];
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
	yearTable = [[CustomTableView alloc] initWithFrame:CGRectMake(37, 30, 120, 114)];
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
	[monthTable removeFromSuperview];
	monthTable = [[CustomTableView alloc] initWithFrame:CGRectMake(162, 30, 120, 114)];
        monthTable.selectedStr = self.selectMonth;
	monthTable.dataArray = self.monthArray;
	monthTable.backgroundColor = [UIColor clearColor];
	monthTable.delegate = self;
	monthTable.dataSource = self;
	
	[self addSubview:monthTable];
	[monthTable release];
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
	//	if (tableView == yearTable) {
	//		self.selectedYearRow = [indexStr intValue];
	//	} 
	if (tableView == yearTable) {
                self.selectYear = [yearTable.dataArray objectAtIndex:[indexStr intValue]];;
		self.selectedYearRow = [indexStr intValue];
		
		NSString * year = [NSString stringWithFormat:@"%@%@",[[NSDate dateCode:[NSDate date]] substringToIndex:4],@"年"];
		if ([self.selectYear isEqualToString:year]) {
			NSMutableArray *marray = [NSMutableArray array];
			NSString * month =[[NSDate dateCode:[NSDate date]] substringWithRange:NSMakeRange(5, 2)];
			for (int i=[month intValue]; i<=12; i++) {
				[marray addObject:[NSString stringWithFormat:@"%02d月",i]];
			}
			if (![marray containsObject:self.selectMonth]) {
			    self.selectMonth = [NSString stringWithFormat:@"%@月",month];
			}
			

			self.monthArray = marray;
		}else {
			self.monthArray = [NSArray arrayWithObjects:@"01月", @"02月",@"03月",@"04月",@"05月",@"06月",@"07月",@"08月",@"09月",@"10月",@"11月",@"12月",nil];
			
		}
		[self creatMonthView];
	}  
	else  if (tableView == monthTable){
                self.selectMonth =  [monthTable.dataArray objectAtIndex:[indexStr intValue]];
		self.selectedMonthRow = [indexStr intValue];
	}
}

-(void) yesButton
{
	if (self.delegate && [self.delegate respondsToSelector:@selector(sureButtonClick:)]) {
		
		NSString * yearStr = [self.yearArray objectAtIndex:self.selectedYearRow];
		yearStr = [[yearStr substringToIndex:4] substringFromIndex:2];
		NSString * monthStr = [self.monthArray objectAtIndex:self.selectedMonthRow];
		monthStr = [monthStr substringToIndex:2] ;
		
		NSString * instance = [NSString stringWithFormat:@"%@/%@",monthStr,yearStr];
		[self.delegate performSelector:@selector(sureButtonClick:) withObject:instance];
	}
}
-(void) noButton
{
	if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClick)]) {
		[self.delegate performSelector:@selector(cancelButtonClick)];
	}
}


@end
