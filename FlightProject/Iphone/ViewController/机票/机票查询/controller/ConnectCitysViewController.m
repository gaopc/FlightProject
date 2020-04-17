//
//  ConnectCitysViewController.m
//  FlightProject
//
//  Created by longcd on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ConnectCitysViewController.h"
#import "TicketQueryViewController.h"

@interface ConnectCitysViewController ()

@end

@implementation ConnectCitysViewController
@synthesize dataArray,queryDataModel,connectRequest;
-(void)dealloc
{
    self.dataArray = nil;
    self.queryDataModel = nil;
    self.connectRequest = nil;
    [super dealloc];
}

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
    self.title = @"中转城市";
	// Do any additional setup after loading the view.
    
    UITableView * myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 290, 30)];
        label.tag = 99;
        label.textAlignment = UITextAlignmentLeft;
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor blackColor];
        [cell.contentView addSubview:label];
        [label release];
    }
    UILabel * textLabel = (UILabel *)[cell viewWithTag:99];
    TransitCity * city = [self.dataArray objectAtIndex:indexPath.row];

    textLabel.text = city._name ;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketQueryDataModelElem * dptDataModel = self.queryDataModel._fromCity;
    TicketQueryDataModelElem * dstDataModel = self.queryDataModel._toCity;
    TicketQueryDataModelElem * goDataModel = self.queryDataModel._startDate;
    //TicketQueryDataModelElem * backDataModel = self.queryDataModel._arriveDate;
    
    NSString * returnDate = @"";
    
    TransitCity * city = [self.dataArray objectAtIndex:indexPath.row];
    self.queryDataModel._transitCity._nameStr = city._name;
    self.queryDataModel._transitCity._nameCode = city._code;
    
    ASIFormDataRequest * theRequest = [InterfaceClass queryFlightTicketWithDeparture:dptDataModel._nameCode arrival:dstDataModel._nameCode transitCity:city._code startDate:goDataModel._nameCode returnDate:returnDate flightType:[NSString stringWithFormat:@"%d",1]];
    
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredResult:) Delegate:self];
}
-(void)onPaseredResult:(NSDictionary *)resultDic
{
    [DataClass insertIntoFlight_Search_HistoryWithArray:[NSArray arrayWithObjects:[NSArray arrayWithObjects:self.queryDataModel._fromCity._nameCode, self.queryDataModel._fromCity._nameStr,self.queryDataModel._toCity._nameCode,self.queryDataModel._toCity._nameStr,nil], nil]];
    
    QueryFlightTicket *queryTicket= [QueryFlightTicket QueryFlightTicket:resultDic];
    TicketQueryConnectDetailViewController * ticketDetailVC = [[TicketQueryConnectDetailViewController alloc] init];
    
    ticketDetailVC.queryTicket = queryTicket;
    ticketDetailVC.dataArray = (NSMutableArray *) queryTicket._firstFlightInfo;
    ticketDetailVC.filterDataArray = ticketDetailVC.dataArray;
    ticketDetailVC.queryDataModel = self.queryDataModel;
    ticketDetailVC.title = [NSString stringWithFormat:@"%@-%@",self.queryDataModel._fromCity._nameStr,self.queryDataModel._transitCity._nameStr];

    [NavigationController pushViewController:ticketDetailVC animated:YES];
    [ticketDetailVC release];
    
//    if ([queryTicket._isDirect boolValue]) {
//        TicketQueryConnectDetailViewController * ticketDetailVC = [[TicketQueryConnectDetailViewController alloc] init];
//        ticketDetailVC.queryTicket = queryTicket;
//        [NavigationController pushViewController:ticketDetailVC animated:YES];
//        [ticketDetailVC release];
//    }
//    else {
//        if ([queryTicket._transitCity count]>0) {
//            UIAlertView * alert = [UIAlertView alertViewWithMessage:@"是否中转"  addSure:@"确定" addCancle:@"取消"];
//            alert.delegate = self;
//            [alert show];
//            return;
//        }
//        else {
//            [UIAlertView alertViewWithMessage:@"没有到达的航班"];
//        }
//    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
