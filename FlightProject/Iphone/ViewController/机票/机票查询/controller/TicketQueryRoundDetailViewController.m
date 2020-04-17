//
//  TicketQueryRoundDetailViewController.m
//  FlightProject
//
//  Created by longcd on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TicketQueryRoundDetailViewController.h"
#import "TicketQueryViewController.h"

@implementation TicketQueryRoundDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    if (self.queryDataModel._flightType == RoundTypeGo) {
        self.flightsInfoArray = [NSMutableArray arrayWithObjects:@"",@"", nil];
    }
    else {
        [self getOtherFlightData];
    }
}

-(void)onOtherPaseredResult:(NSDictionary *)resultDic
{
    self.queryTicket= [QueryFlightTicket QueryFlightTicket:resultDic];
    self.queryTicket = self.queryTicket;
    self.dataArray = (NSMutableArray *)self.queryTicket._firstFlightInfo;
    self.filterDataArray = self.dataArray;
    self.sortArrayBy = TimeAesc;
    [self.myTable reloadData];
}

-(void) searchTicket
{
    TicketQueryDataModel * dataModel = [[TicketQueryDataModel alloc] init];

    dataModel._fromCity = self.queryDataModel._toCity;
    dataModel._toCity = self.queryDataModel._fromCity;
    dataModel._startDate = self.queryDataModel._arriveDate;
    dataModel._arriveDate = self.queryDataModel._startDate;
    dataModel._flightType = self.queryDataModel._flightType;
    dataModel._transitCity = self.queryDataModel._transitCity;
    
    self.queryDataModel = dataModel;
    [dataModel release];
    
    TicketQueryDataModelElem * dptDataModel = self.queryDataModel._fromCity;
    TicketQueryDataModelElem * dstDataModel = self.queryDataModel._toCity;
    TicketQueryDataModelElem * goDataModel = self.queryDataModel._startDate;

    ASIFormDataRequest * theRequest = [InterfaceClass queryFlightTicketWithDeparture:dptDataModel._nameCode arrival:dstDataModel._nameCode transitCity:@"" startDate:goDataModel._nameCode returnDate:@"" flightType:@"1"]; 
    
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onOtherPaseredResult:) Delegate:self needUserType:Default];
   // [SendRequstCatchQueue shareSendRequstCatchQueue].currentViewController = [NSString stringWithFormat:@"%@",[self class]];

}
-(void)getOtherFlightData
{
    NSLog(@"%s",__FUNCTION__);
    self.title =[NSString stringWithFormat:@"%@-%@",self.queryDataModel._toCity._nameStr,self.queryDataModel._fromCity._nameStr];
    self.filterDataArray = nil;
    [self.myTable reloadData];
    
    self.searchDate = self.queryDataModel._arriveDate._nameCode;

    // 20121207 zxt 修改
    self.bottomView._dateLabel.text = self.queryDataModel._arriveDate._nameCode;
    self.bottomView._weekLabel.text = [NSDate getWeekDayLongStr:self.queryDataModel._arriveDate._nameCode];
    
    NSString * nowDay = [NSDate dateafterDay:[NSDate dateFromString:[NSDate dateCode:[NSDate date]]] day:Delay_Days type:1]; //2012-01-01
    NSArray * nowDayArray = [nowDay componentsSeparatedByString:@"-"];
    NSString * lastDay =  [NSString stringWithFormat:@"%4d-%@-%@",[[nowDayArray objectAtIndex:0] intValue]+1,[nowDayArray objectAtIndex:1],[nowDayArray objectAtIndex:2]];
    if ([self.searchDate isEqualToString:lastDay]) {
        self.bottomView._nextButton.enabled = NO;
        self.bottomView._nextLabel.textColor = FontColor1C7CBC;
        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomRight2.png"];
    }
    else {
        self.bottomView._nextButton.enabled = YES;
        self.bottomView._nextLabel.textColor = FontColorFFFFFF;
        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomRight1.png"];
    }
    
    if ([self.searchDate isEqualToString:[NSDate dateCode:[NSDate date]]]) {
        self.bottomView._proButton.enabled = NO;
        self.bottomView._proLabel.textColor = FontColor1C7CBC;
        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft2.png"];
    }
    else {
        self.bottomView._proButton.enabled = YES;
        self.bottomView._proLabel.textColor = FontColorFFFFFF;
        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft1.png"];
    }

    [self searchTicket];
    
    self.filterView = nil;
}

@end
