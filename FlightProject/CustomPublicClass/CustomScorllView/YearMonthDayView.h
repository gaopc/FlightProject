//
//  YearMonthDayView.h
//  FlightProject
//
//  Created by longcd on 12-11-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomScorllView.h"

@protocol YearMonthDayViewDelegate <NSObject>

-(void)sureButtonClick:(id) instance;
-(void)cancelButtonClick;

@end

@interface YearMonthDayView : UIView<CustomTableViewDelegate,CustomTableViewDataSource>
{
    CustomTableView *yearTable;
    CustomTableView *monthTable;
    CustomTableView *dayTable;
}

@property (nonatomic,retain) NSArray * yearArray;
@property (nonatomic,assign) id <YearMonthDayViewDelegate> delegate;



@property (nonatomic,retain) NSArray * monthArray;
@property (nonatomic,retain) NSArray * dayArray;
@property(nonatomic,assign) NSInteger  selectedYearRow;
@property(nonatomic,assign) NSInteger  selectedMonthRow;
@property(nonatomic,assign) NSInteger  selectedDayRow;
@property (nonatomic,retain) NSString * selectYear;
@property (nonatomic,retain) NSString * selectMonth;
@property (nonatomic,retain) NSString * selectDay;

-(id)initWithFrame:(CGRect)frame Title:(NSString *) title  array:(NSArray *)array selectYear:(NSString *)year selectMonth:(NSString *)month selectDay:(NSString *)day ;
- (void)tableViewPosition:(NSString *)year withMonth:(NSString *)month withDay:(NSString *)day;
@end
