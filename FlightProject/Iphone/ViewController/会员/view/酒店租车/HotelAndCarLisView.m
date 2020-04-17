//
//  HotelAndCarLisView.m
//  FlightProject
//
//  Created by 月 小 on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelAndCarLisView.h"
//#import "Header.h"

@implementation HotelAndCarLisView
@synthesize myTable,delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView * headView = [[UIView alloc] init];
        headView.frame = CGRectMake(0, 0, ViewWidth, 35);
        
        timeButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, 107, 35) backImage:[UIImage imageNamed:@"TicketListTimeNone.png"] target:self action:@selector(timeButton:)];
        filterButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(107, 0, 106, 35) backImage:[UIImage imageNamed:@"TicketListFilterNone.png"] target:self action:@selector(filterButton:)];
        priceButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(213, 0, 106, 35) backImage:[UIImage imageNamed:@"TicketListPriceNone.png"] target:self action:@selector(priceButton:)];
        
        [headView addSubview : timeButton];
        [headView addSubview : filterButton];
        [headView addSubview : priceButton];
        
        UITableView * tempTable = [[UITableView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height + 5, ViewWidth, 44-headView.frame.size.height - 5) style:UITableViewStylePlain];
        tempTable.backgroundColor = [UIColor clearColor];
        tempTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTable.dataSource = self.delegate;
        tempTable.delegate = self.delegate;
        self.myTable =tempTable;
        
        [self addSubview:tempTable];
        [tempTable release];
        [self addSubview:headView];
        [headView release];
    }
    return self;
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
