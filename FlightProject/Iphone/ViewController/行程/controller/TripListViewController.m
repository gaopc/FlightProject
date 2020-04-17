//
//  TripListViewController.m
//  FlightProject
//
//  Created by gaopengcheng on 15-11-5.
//
//

#import "TripListViewController.h"
#import "TripForTicketTableViewCell.h"
#import "TripModel.h"
#import "FlightTrendsDetailViewController.h"
#import "TripMapViewController.h"

@interface TripListViewController ()

@end

@implementation TripListViewController
@synthesize _ticketArr, _hotelArr, _flightNum;

- (void)dealloc
{
    self._flightNum = nil;
    self._ticketArr = nil;
    self._hotelArr = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"行程";
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, ViewWidth, ViewHeight - 44 - 5) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
    
    showLab = [UILabel labelWithTitle:@"您目前还没有未出发行程，快去预订吧~" frame:CGRectMake(0, 100, ViewWidth, 30) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentCenter];
    showLab.hidden = YES;
    [self.view addSubview:showLab];
    
    [self getTripForTicketData];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self._ticketArr.count + self._hotelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
    if (self._ticketArr.count > 0 && indexPath.row < self._ticketArr.count) {
        
        TripForTicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[TripForTicketTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        TripModel *ticketModel = [self._ticketArr objectAtIndex:indexPath.row];
        
        cell._fromCity.text = ticketModel._departureCity;
        cell._toCity.text = ticketModel._arrivalCity;
        cell._companyImageV.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[ticketModel._flightNo substringToIndex:2]]];
        cell._flightNo.text = [NSString stringWithFormat:@"%@%@", ticketModel._airline, ticketModel._flightNo];
        cell._startTime.text = [ticketModel._startDate substringWithRange:NSMakeRange(11, 5)];
        cell._fromAirport.text = [NSString stringWithFormat:@"%@%@", ticketModel._startAirport, ticketModel._startTerminal];
        cell._arrivlTime.text = [ticketModel._endTime substringWithRange:NSMakeRange(11, 5)];
        cell._toAirport.text = [NSString stringWithFormat:@"%@%@", ticketModel._endAirport, ticketModel._endTerminal];
        cell._planType.text = [NSString stringWithFormat:@"机型: %@", ticketModel._planeType];
        cell._startDate.text = [NSString stringWithFormat:@"%@", [ticketModel._startDate substringToIndex:11]];
        cell._cabinType.text = [NSString stringWithFormat:@"%@", ticketModel._cabinType];
        
        cell._fromWearther.urlString = ticketModel._departureWeather;
        cell._toWearther.urlString = ticketModel._arrivalWeather;
        return cell;
    }
    else {
        
        TripForHotelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[TripForHotelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        TripHotelModel *hotelModel = [self._hotelArr objectAtIndex:indexPath.row - self._ticketArr.count];
        cell._hotelNameLab.text = hotelModel.hotelName;
        cell._roomTypeLab.text = hotelModel.roomTypeName;
        cell._hotelAddressLab.text = hotelModel.hotelAddress;
        cell._checkInDateLab.text = [NSString stringWithFormat:@"入住时间：%@", hotelModel.checkInDate];
        cell._checkOutDateLab.text = [NSString stringWithFormat:@"离店时间：%@", hotelModel.checkOutDate];
        cell._peopleNameLab.text = [NSString stringWithFormat:@"入住旅客：%@", hotelModel.peopleName];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self._ticketArr.count > 0 && indexPath.row < self._ticketArr.count) {
        
        TripModel *ticketModel = [self._ticketArr objectAtIndex:indexPath.row];
        self._flightNum = ticketModel._flightNo;
        
        ASIFormDataRequest * theRequest = [InterfaceClass getFlightDynamicByFlightNoWithUserId:[UserInfo sharedUserInfo].userID?[UserInfo sharedUserInfo].userID:@"" flightNo:ticketModel._flightNo];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onFlightPaseredResult:) Delegate:self needUserType:Default];
    }
    else {
        
        TripHotelModel *hotelModel = [self._hotelArr objectAtIndex:indexPath.row - self._ticketArr.count];
        TripMapViewController *mapVC = [[TripMapViewController alloc] init];
        mapVC.title = hotelModel.hotelName;
        mapVC._Lat = hotelModel._lat;
        mapVC._lon = hotelModel._lon;
        mapVC._address = hotelModel.hotelAddress;
        [self.navigationController pushViewController:mapVC animated:YES];
        [mapVC release];
    }
}

- (void)getTripForTicketData
{
    ASIFormDataRequest * theRequest = [InterfaceClass getTripForTicket:[UserInfo sharedUserInfo].userID];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onTicketPaseredResult:) Delegate:self needUserType:Default];
}

- (void)getTripForHotelData
{
    ASIFormDataRequest * theRequest = [InterfaceClass getTripForHotel:[UserInfo sharedUserInfo].userID];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onHotelPaseredResult:) Delegate:self needUserType:Default];
}

- (void)onTicketPaseredResult:(NSDictionary *)dic
{
    self._ticketArr = [TripModel getTripForTicketModel:dic];
    [self getTripForHotelData];
}

- (void)onHotelPaseredResult:(NSDictionary *)dic
{
    self._hotelArr = [TripHotelModel getTripForHotelModel:dic];
    
    if (self._ticketArr.count == 0 && self._hotelArr.count == 0) {
        showLab.hidden = NO;
    }
    else
        [myTable reloadData];
}

- (void)onFlightPaseredResult:(NSDictionary *)dic
{
    FlightTrendsDetailViewController * flightTrendsDetailVC = [[FlightTrendsDetailViewController alloc] init];
    flightTrendsDetailVC.flightDynamic = (GetFlightDynamicByFlightNo*)[GetFlightDynamicByFlightNo GetFlightDynamicByFlightNo:dic];
    flightTrendsDetailVC.flightNum = self._flightNum;
    
    [NavigationController pushViewController:flightTrendsDetailVC animated:YES];
    [flightTrendsDetailVC release];
}
@end
