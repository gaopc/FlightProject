//
//  TicketQueryConnectDetailViewController.m
//  FlightProject
//
//  Created by longcd on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
// 用于中转
#import "TicketQueryConnectDetailViewController.h"
#import "TicketQueryViewController.h"

@implementation TicketQueryConnectDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    if (self.queryDataModel._flightType == ConnectTypeFirst) {
        [self.bottomView setHidden:NO];
        self.flightsInfoArray = [NSMutableArray arrayWithObjects:@"",@"", nil];
    }
    else {
        [self.bottomView setHidden:YES];
        [self getOtherFlightData];
    }
}

-(void)getOtherFlightData
{
    NSLog(@"%s",__FUNCTION__);
    self.title =[NSString stringWithFormat:@"%@-%@",self.queryDataModel._transitCity._nameStr,self.queryDataModel._toCity._nameStr];
    self.dataArray = (NSMutableArray *)self.queryTicket._secondFlightInfo;
    self.filterDataArray = self.dataArray;
    self.sortArrayBy = TimeAesc;
    [self.myTable reloadData];
    self.filterView = nil;
}
@end
