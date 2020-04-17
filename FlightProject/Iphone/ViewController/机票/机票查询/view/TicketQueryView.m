//
//  TicketQueryView.m
//  FlightProject
//
//  Created by green kevin on 12-6-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TicketQueryView.h"

#import "TicketQueryViewController.h"

@implementation TicketQueryView
@synthesize myTable;
@synthesize dataArray;
@synthesize city;
@synthesize timeRange;
@synthesize connectCitys;
@synthesize connectRequest;
@synthesize briefInfoRequest;
@synthesize navigationController;

-(void)dealloc
{
    self.dataArray = nil;
    self.myTable = nil;
    self.city = nil;
    self.timeRange = nil;
    self.connectCitys = nil;
    self.connectRequest = nil;
    self.briefInfoRequest = nil;
    self.navigationController = nil;
    [super dealloc];
}
-(NSString *)dateStr:(NSDate*)date
{
    NSDateFormatter* format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    NSString* time = [format stringFromDate: date]; // [NSDate date]
    [format release];
    return time;
}
-(NSString *)dateCode:(NSDate*)date
{
    NSDateFormatter* format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString* time = [format stringFromDate: date]; // [NSDate date]
    [format release];
    return time;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        NSMutableArray * tempArray = [NSMutableArray arrayWithObjects:[TicketQueryDataModel TicketQueryDataModelWithStr:@"出发城市:" detailStr:@"北京" code:@"PEK" ],[TicketQueryDataModel TicketQueryDataModelWithStr:@"到达城市:"  detailStr:@"上海" code:@"SHA" ],[TicketQueryDataModel TicketQueryDataModelWithStr:@"出发日期:"  detailStr:[self dateStr:[NSDate date]] code:[self dateCode:[NSDate date] ]],[TicketQueryDataModel TicketQueryDataModelWithStr:@"起飞时段:"  detailStr:@"不限" code:@"00" ], [TicketQueryDataModel TicketQueryDataModelWithStr:@"航空公司:"  detailStr:@"不限" code:@"" ],  nil];
        self.dataArray = tempArray;
        
        myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 365) style:UITableViewStylePlain];
        myTable.delegate = self;
        myTable.dataSource = self;
        myTable.backgroundColor = [UIColor clearColor];
        [myTable setContentOffset:CGPointMake(0.0, 0.0) animated:NO];
        [myTable reloadData];
		[self addSubview:myTable];
        [myTable release];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    return [self.dataArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    TicketQueryCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[TicketQueryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    [[cell.contentView viewWithTag:99] removeFromSuperview];
    if (indexPath.row == [self.dataArray count]) {
        cell.titleLable.text = @"";
        cell.detailLable.text = @"";
        if ([cell.contentView viewWithTag:99] == nil) {
            [cell.contentView addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:99 title:@"查询" frame:CGRectMake(0, 7, 320, 30) backImage:nil  target:self action:@selector(searchTicket:)]];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    TicketQueryDataModel * model = [self.dataArray objectAtIndex:indexPath.row];
    cell.titleLable.text = model._nameStr;
    cell.detailLable.text = model._nameDetailStr;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1) {
        CityListViewController * citylistVC = [[CityListViewController alloc] init];
        [self.navigationController pushViewController:citylistVC animated:YES];
        citylistVC.ticketQueryDataModel = [self.dataArray objectAtIndex:indexPath.row];
        [citylistVC release];
    }
    
   if(indexPath.row == 2){// 启程日期
       DatePickerViewController * datePickerVC = [[DatePickerViewController alloc] init];
       [self.navigationController pushViewController:datePickerVC animated:YES];
       datePickerVC.dateType = StarDate;
       datePickerVC.startDateTicketQueryDataModel = [self.dataArray objectAtIndex:indexPath.row];
       datePickerVC.backDateTicketQueryDataModel= [self.dataArray count]==5?nil:[self.dataArray objectAtIndex:3];
       [datePickerVC release];
   }
   
    if(indexPath.row == 3){
        if ([self.dataArray count] == 5) { // 起飞时段
            FlyTimeRangeViewController * flyTimeRangeVC = [[FlyTimeRangeViewController alloc] init];
            [self.navigationController pushViewController:flyTimeRangeVC animated:YES];
            flyTimeRangeVC.ticketQueryDataModel = [self.dataArray objectAtIndex:indexPath.row];;
            [flyTimeRangeVC release];
        }
        else {// 返程日期
            DatePickerViewController * datePickerVC = [[DatePickerViewController alloc] init];
            [self.navigationController pushViewController:datePickerVC animated:YES];
            datePickerVC.dateType = BackDate;
            datePickerVC.startDateTicketQueryDataModel = [self.dataArray objectAtIndex:2];
            datePickerVC.backDateTicketQueryDataModel = [self.dataArray objectAtIndex:indexPath.row];
            [datePickerVC release];
        }
    }

    if(indexPath.row == 4){
        if ([self.dataArray count] == 5) {// 航空公司
            FlightCompanyViewController * flightCompanyVC = [[FlightCompanyViewController alloc] init];
            [self.navigationController pushViewController:flightCompanyVC animated:YES];
            flightCompanyVC.ticketQueryDataModel = [self.dataArray objectAtIndex:indexPath.row];
            [flightCompanyVC release];
        }
        else {// 起飞时段
            FlyTimeRangeViewController * flyTimeRangeVC = [[FlyTimeRangeViewController alloc] init];
            [self.navigationController pushViewController:flyTimeRangeVC animated:YES];
            flyTimeRangeVC.ticketQueryDataModel = [self.dataArray objectAtIndex:indexPath.row];;
            [flyTimeRangeVC release];
        }
    }

    if(indexPath.row == 5 && [self.dataArray count] == 6){// 航空公司
        FlightCompanyViewController * flightCompanyVC = [[FlightCompanyViewController alloc] init];
        [self.navigationController pushViewController:flightCompanyVC animated:YES];
        flightCompanyVC.ticketQueryDataModel = [self.dataArray objectAtIndex:indexPath.row];
        [flightCompanyVC release];
    }
}
-(SearchFlightsBriefInfoRequest *)buildSearchFlightsBriefInfoRequest
{
    TicketQueryDataModel * dptDataModel = [self.dataArray objectAtIndex:0];
    TicketQueryDataModel * dstDataModel = [self.dataArray objectAtIndex:1];
    SearchFlightsBriefInfoRequest *briefRequest  = [[[SearchFlightsBriefInfoRequest alloc] init] autorelease];
    briefRequest.terminalId = [TerminalId TerminalId];
    briefRequest.dptCity = dptDataModel._nameCode ;
    briefRequest.dstCity = dstDataModel._nameCode ;
    
    if ([self.dataArray count]==5) {
        flightType = SingleType;
        briefRequest.flightType = @"01";	// 01-单程;02-往返
        
        TicketQueryDataModel * startDateDataModel = [self.dataArray objectAtIndex:2];
        TicketQueryDataModel * timeRangeDataModel = [self.dataArray objectAtIndex:3];
        briefRequest.departureDate =[NSString stringWithFormat:@"%@ %@",startDateDataModel._nameCode,timeRangeDataModel._nameCode] ;
        
        briefRequest.returnDate = @"";
        
        TicketQueryDataModel * airLineDataModel = [self.dataArray objectAtIndex:4];
        briefRequest.airLine = airLineDataModel._nameCode;
    }
    else
    {
        flightType = RoundType;
        briefRequest.flightType = @"01";
        
        TicketQueryDataModel * startDateDataModel = [self.dataArray objectAtIndex:2];
        TicketQueryDataModel * timeRangeDataModel = [self.dataArray objectAtIndex:4];
        briefRequest.departureDate = [NSString stringWithFormat:@"%@ %@",startDateDataModel._nameCode,timeRangeDataModel._nameCode] ;
        
        TicketQueryDataModel * backDateDataModel = [self.dataArray objectAtIndex:3];
        briefRequest.returnDate = [NSString stringWithFormat:@"%@ %@",backDateDataModel._nameCode,timeRangeDataModel._nameCode] ;
        
        TicketQueryDataModel * airLineDataModel = [self.dataArray objectAtIndex:5];
        briefRequest.airLine = airLineDataModel._nameCode;
    }
    
    briefRequest.isDirect = @"1";		// 直达
    return briefRequest;
}
-(SearchConnectFlightsBriefInfoRequest *)buildSearchConnectFlightsBriefInfoRequest
{
    TicketQueryDataModel * dptDataModel = [self.dataArray objectAtIndex:0];
    TicketQueryDataModel * dstDataModel = [self.dataArray objectAtIndex:1];
    SearchConnectFlightsBriefInfoRequest *connectBriefRequest  = [[[SearchConnectFlightsBriefInfoRequest alloc] init] autorelease];
    connectBriefRequest.terminalId = [TerminalId TerminalId];
    connectBriefRequest.dptCity = dptDataModel._nameCode ;
    connectBriefRequest.arrCity = dstDataModel._nameCode ;
    
    if ([self.dataArray count]==5) {
        TicketQueryDataModel * startDateDataModel = [self.dataArray objectAtIndex:2];
        TicketQueryDataModel * timeRangeDataModel = [self.dataArray objectAtIndex:3];
        connectBriefRequest.departureDate =[NSString stringWithFormat:@"%@ %@",startDateDataModel._nameCode,timeRangeDataModel._nameCode] ;
    }
    else
    {
        TicketQueryDataModel * startDateDataModel = [self.dataArray objectAtIndex:2];
        TicketQueryDataModel * timeRangeDataModel = [self.dataArray objectAtIndex:4];
        connectBriefRequest.departureDate = [NSString stringWithFormat:@"%@ %@",startDateDataModel._nameCode,timeRangeDataModel._nameCode] ;
    }
    return connectBriefRequest;
}
-(NSArray *)getConnectCityWithFrom:(NSString *)fromCity addArr:(NSString *)arrCity
{
    NSArray * array = [DataClass selectConnectCitysFormDirectCityWithFrom:fromCity addArr:arrCity];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array) {
        [mArray addObject:[NSArray arrayWithObjects:[elem objectAtIndex:0],[DataClass selectCityNameFromCitysWithCode:[elem objectAtIndex:0]]==nil? @"未知城市" :[DataClass selectCityNameFromCitysWithCode:[elem objectAtIndex:0]], nil ]];
    }
    return mArray;
}
-(BOOL)hasDirectCityWithFrom:(NSString *)fromCity addArr:(NSString *)arrCity
{
    return [DataClass  selectFormDirectCityWithFrom:fromCity addArr:arrCity];
}
-(void)searchTicket:(id)sender
{
    TicketQueryDataModel * dptDataModel = [self.dataArray objectAtIndex:0];
    TicketQueryDataModel * dstDataModel = [self.dataArray objectAtIndex:1];
    
    if ([dptDataModel._nameCode isEqualToString: dstDataModel._nameCode]) {
        [UIAlertView alertViewWithMessage:@"出发城市和到达城市相同，请重新选择！"];
        return;
    }
    
    if (![self hasDirectCityWithFrom: dptDataModel._nameCode addArr:dstDataModel._nameCode]) 
    {
        self.connectCitys = [self getConnectCityWithFrom:dptDataModel._nameCode addArr:dstDataModel._nameCode];
        NSLog(@"%@",self.connectCitys);
        if ([self.connectCitys count]>0) 
        {
            UIAlertView * alert = [UIAlertView alertViewWithMessage:@"是否中转"  addSure:@"确定" addCancle:@"取消"];
            alert.delegate = self;
            [alert show];
            return;
        }
        else {
            [UIAlertView alertViewWithMessage:@"没有到达的航班"];
            return;
        }
    }
    self.briefInfoRequest = [self buildSearchFlightsBriefInfoRequest];
    NSMutableURLRequest * theRequest = [InterfaceClass getFlightBriefInfo:self.briefInfoRequest];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest withSelector:@selector(onPaseredResult:) withDelegate :self];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        self.connectRequest = [self buildSearchConnectFlightsBriefInfoRequest];
        ConnectCitysViewController * connectCitysVC = [[ConnectCitysViewController alloc] init];
        connectCitysVC.dataArray = self.connectCitys;
        connectCitysVC.connectRequest =  self.connectRequest;
        [self.navigationController pushViewController:connectCitysVC animated:YES];
        [connectCitysVC release];
    }
}

-(void)onPaseredResult:(NSArray *)resultArray
{
    SearchFlightsBriefInfoResponse * instance = [SearchFlightsBriefInfoResponse searchFlightsBriefInfoResponseWithArray:resultArray];
    NSArray * array = instance.flightsBriefInfo;
    if (array) {
        if ([self.dataArray count] == 5) {
            TicketQueryDetailViewController * ticketDetailVC = [[TicketQueryDetailViewController alloc] init];
            [self.navigationController pushViewController:ticketDetailVC animated:YES];
            ticketDetailVC.dataArray = array;
            NSMutableArray * mArray = [NSMutableArray array];
            for (FlightsBriefInfo * briefInfo in array) {
                [mArray addObject:[SearchFlightsBriefInfoResponse searchFlightsBriefInfoWithBriefInfo:briefInfo]];
            }
            ticketDetailVC.dataStrArray = mArray;
            [ticketDetailVC release];
        }
        else if ([self.dataArray count] == 6) {
            TicketQueryRoundDetailViewController * ticketDetailVC = [[TicketQueryRoundDetailViewController alloc] init];
            [self.navigationController pushViewController:ticketDetailVC animated:YES];
            ticketDetailVC.briefInfoRequest  = self.briefInfoRequest;
            ticketDetailVC.dataArray = array;
            NSMutableArray * mArray = [NSMutableArray array];
            for (FlightsBriefInfo * briefInfo in array) {
                [mArray addObject:[SearchFlightsBriefInfoResponse searchFlightsBriefInfoWithBriefInfo:briefInfo]];
            }
            ticketDetailVC.dataStrArray = mArray;
            [ticketDetailVC release];
        }
    }
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