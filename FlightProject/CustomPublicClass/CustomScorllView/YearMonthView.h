//
//  YearMonthView.h
//  FlightProject
//
//  Created by longcd on 12-11-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomScorllView.h"
#import "NSDate+convenience.h"
@protocol YearMonthViewDelegate <NSObject>

-(void)sureButtonClick:(id) instance;
-(void)cancelButtonClick;

@end

@interface YearMonthView : UIView<CustomTableViewDelegate,CustomTableViewDataSource>
{
    CustomTableView *yearTable;
    CustomTableView *monthTable;
}

@property (nonatomic,retain) NSArray * yearArray;
@property (nonatomic,assign) id <YearMonthViewDelegate> delegate;
@property (nonatomic,retain) NSArray * monthArray;
@property(nonatomic,assign) NSInteger  selectedYearRow;
@property(nonatomic,assign) NSInteger  selectedMonthRow;
@property (nonatomic,retain) NSString * selectYear;
@property (nonatomic,retain) NSString * selectMonth;

-(id)initWithFrame:(CGRect)frame Title:(NSString *) title  array:(NSArray *)array selectYear:(NSString *)year selectMonth:(NSString *)month;

@end
