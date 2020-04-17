//
//  MemberOrderStateViewController.m
//  FlightProject
//
//  Created by admin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberOrderStateViewController.h"

@interface MemberOrderStateViewController ()

@end

@implementation MemberOrderStateViewController
@synthesize orderState;
@synthesize orderDataInfo;
@synthesize _notLoginUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.orderDataInfo = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44-5) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.allowsSelection = YES;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


#pragma mark - Table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return flightCount;
    }
    else if (section == 1){
        return 2;
    }
    else if (section == 2){
        return passengersCount;
    }
    else if (section == 3){
        return 1;
    }
    else if (section == 4){
        return 3;
    }
    else {
        return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (!isSelect) {
            return 50;
        }else
            return 100;
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            return 105;
        }else {
            return 20;
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row >= [self.orderDataInfo._ticketInfo count]) {
            return 70;
        }
        
        if (contactType == 0) {
            return 70;
        }
        else if (contactType == 1){
            return 110;
        }
        else {
            return 150;
        }
    }
    else if (indexPath.section == 3)
    {
        if ([self.orderDataInfo._flightType intValue] != 2) {
            return 60;
        }
        else {
            return 85;
        }
    }
    else if (indexPath.section == 4)
    {
        if (indexPath.row == 0) {
            return 70;
        }
        else if (indexPath.row == 1)
        {
            if ([self.orderDataInfo._getItineraryType intValue] == 0) {
                return 60;
            }
            else if ([self.orderDataInfo._getItineraryType intValue] == 1){
                return 100;
            }
            else {
                return 80;
            }
        }
        else {
            return 70;
        }
    }
    else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (!isSelect) 
        {
            NSString * identifier = [NSString stringWithFormat:@"identifier11%d", indexPath.row];
            OrderTicketToPerchCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketToPerchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if ([self.orderDataInfo._flightInfo count] > 1 && indexPath.row == 0) {
                    cell.lineView.hidden = NO;
                }else{
                    cell.lineView.hidden = YES;
                }
            }
            [self setFlightinfo1Info:cell indexPath:indexPath];
            return cell;
        }
        else 
        {
            NSString * identifier = [NSString stringWithFormat:@"identifier12%d", indexPath.row];
            OrderTicketToPerchDoubleCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketToPerchDoubleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                [cell.ruleButton addTarget:self action:@selector(ruleInfo:) forControlEvents:UIControlEventTouchUpInside];
                cell.ruleButton.tag =  indexPath.row;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if ([self.orderDataInfo._flightInfo count] > 1 && indexPath.row == 0) {
                    cell.lineView.hidden = NO;
                }else{
                    cell.lineView.hidden = YES;
                }
            }
            [self setFlightinfo2Info:cell indexPath:indexPath];
            return cell;
        }
    }
    
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            NSString * identifier = @"identifier2";
            OrderTicketPriceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.cellButton.enabled = NO;
                cell._arrowView.hidden = YES;
                [cell.moveButton addTarget:self action:@selector(moveViewDown:) forControlEvents:UIControlEventTouchUpInside];
            }
	    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""] || [self.orderDataInfo._returnLcdCurrency intValue] ==0) {
			cell._returnLcdView.hidden = YES;
		}
		else {
			cell._returnLcdView.hidden = NO;
	    }
            [self orderTicketPriceCell:cell :indexPath.row];
            return cell;
        }else {
            NSString * identifier = @"identifier22";
            MemberOrderDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
    }
    else if (indexPath.section == 2)
    {
        NSString * identifier = @"identifier3";
        MemberOrderPersonCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            
            if (indexPath.row >= [self.orderDataInfo._ticketInfo count]) {
                contactType = 0;
            }
            
            cell = [[[MemberOrderPersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier type:contactType] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell._returnTicket1 addTarget:self action:@selector(goBackTicket:) forControlEvents:UIControlEventTouchUpInside];
            cell._returnTicket1.tag = [[NSString stringWithFormat:@"1%d",indexPath.row] intValue];
            
            [cell._returnTicket2 addTarget:self action:@selector(goBackTicket:) forControlEvents:UIControlEventTouchUpInside];
            cell._returnTicket2.tag = [[NSString stringWithFormat:@"2%d",indexPath.row] intValue];
            
            [cell._phoneButton1 addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
            [cell._phoneButton2 addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self setTicketStateInfo:cell indexPath:indexPath type:contactType];
        return cell;
    }
    else if (indexPath.section == 3) {
        
        NSString *identifier = [NSString stringWithFormat:@"identifier51%d", indexPath.row];
        if ([self.orderDataInfo._flightType intValue] != 2) {
            OrderTicketWaitManCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketWaitManCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (self.orderDataInfo._pickInfo.count > 0) {
                MemberOrderDetailFlightPickResponse *pickInfo = [self.orderDataInfo._pickInfo objectAtIndex:0];
                cell._waiterName.text = pickInfo._pickName;
                cell._waiterPhone.text = pickInfo._pickPhone;
            }
            return cell;
        }
        else {
            OrderTicketDoubleWaitManCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketDoubleWaitManCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            if (self.orderDataInfo._pickInfo.count == 1) {
                
                MemberOrderDetailFlightPickResponse *pickInfo = [self.orderDataInfo._pickInfo objectAtIndex:0];
                
                if ([pickInfo._pickType intValue] == 0) {
                    cell._waiterName.text = pickInfo._pickName;
                    cell._waiterPhone.text = pickInfo._pickPhone;
                }
                else if ([pickInfo._pickType intValue] == 1) {
                    cell._waiterName1.text = pickInfo._pickName;
                    cell._waiterPhone1.text = pickInfo._pickPhone;
                }
            }
            else if (self.orderDataInfo._pickInfo.count == 2) {
                
                MemberOrderDetailFlightPickResponse *pickInfo = [self.orderDataInfo._pickInfo objectAtIndex:0];
                MemberOrderDetailFlightPickResponse *pickInfo1 = [self.orderDataInfo._pickInfo objectAtIndex:1];
                
                if ([pickInfo._pickType intValue] == 0) {
                    cell._waiterName.text = pickInfo._pickName;
                    cell._waiterPhone.text = pickInfo._pickPhone;
                    
                    cell._waiterName1.text = pickInfo1._pickName;
                    cell._waiterPhone1.text = pickInfo1._pickPhone;
                }
                else if ([pickInfo._pickType intValue] == 1) {
                    cell._waiterName1.text = pickInfo._pickName;
                    cell._waiterPhone1.text = pickInfo._pickPhone;
                    
                    cell._waiterName.text = pickInfo1._pickName;
                    cell._waiterPhone.text = pickInfo1._pickPhone;
                }
            }
            return cell;
        }
    }
    else if (indexPath.section == 4)
    {
        NSString * identifier = [NSString stringWithFormat:@"identifier3%d", indexPath.row];
        if (indexPath.row == 0) 
        {
            OrderTicketPhoneCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
             cell.telNum.text = self.orderDataInfo._telephone;
            return cell;
        }
        else if (indexPath.row == 1)
        {
//            MemberOrderItineraryCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (cell == nil)
//            {
//                cell = [[[MemberOrderItineraryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            }
//            
//            if ([self.orderDataInfo._getItineraryType intValue] == 0) {
//                    cell._areaView.frame = CGRectMake(10, 0, 300, 60);
//                    cell._itineraryLabel.text = @"不需要行程单";
//                    cell._mapButton.hidden = YES;
//                    cell._mailAddressLabel.frame = CGRectMake(30, 12, 240, 20);
//                    cell._mailAddressLabel.text = @"行程单";
//                    cell._mailAddressLabel.font = FontSize22;
//                
//                    cell._itineraryLabel.frame = CGRectMake(45, 38, 200, 20);
//                    cell._iconView.frame = CGRectMake(30, 41, 12, 15);
//                }else  if ([self.orderDataInfo._getItineraryType intValue] == 1){
//                    cell._areaView.frame = CGRectMake(10, 0, 300, 80);
//                    cell._itineraryLabel.text = @"免费邮寄";
//                    cell._mailAddressLabel.text = self.orderDataInfo._postAddress;
//                }else {
//                    cell._areaView.frame = CGRectMake(10, 0, 300, 60);
//                    cell._iconView.image = [UIImage imageNamed:@"终端机icon.png"];
//                    cell._iconView.frame = CGRectMake(27, 15, 15, 15);
//                    cell._itineraryLabel.text = @"终端机打印";
//                    cell._mapButton.hidden = NO;
//                    [cell._mapButton addTarget:self action:@selector(moveTo:) forControlEvents:UIControlEventTouchUpInside];
//                    cell._mailAddressLabel.frame = CGRectMake(45, 38, 240, 20);
//                    
//                    if ([self.orderDataInfo._autoPrint intValue] == 0) {
//                        cell._mailAddressLabel.text = @"行程单已打印";
//                    }
//                    else if ([self.orderDataInfo._autoPrint intValue] == 1)
//                    {
//                        cell._mailAddressLabel.text = @"行程单未打印";
//                    }
//                    else if ([self.orderDataInfo._autoPrint intValue] == 2)
//                    {
//                        cell._mailAddressLabel.text = @"行程单部分打印";
//                    }
//                }
            
            OrderTicketAddresCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketAddresCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            if ([self.orderDataInfo._getItineraryType intValue] == 0) {
                cell.ticketType.text = @"行程单";
                cell.ticketState.text = @"不需要行程单";
                cell.areaView.frame = CGRectMake(10, 0, 300, 60);
                cell.positionButton.hidden = YES;
                cell.ticketState.hidden = NO;
                cell.ticketAddress.hidden = YES;
                cell.addView.hidden = NO;
            }else  if ([self.orderDataInfo._getItineraryType intValue] == 1){
                cell.ticketType.text = @"行程单";
                cell.ticketState.text = @"免费邮寄";
                cell.ticketAddress.text = self.orderDataInfo._postAddress;
                cell.areaView.frame = CGRectMake(10, 0, 300, 100);
                cell.positionButton.hidden = YES;
                cell.ticketState.hidden = NO;
                cell.ticketAddress.hidden = NO;
                cell.addView.hidden = NO;
            }else {
                cell.ticketType.text = @"行程单";
                cell.ticketState.text = @"终端机打印";
                [cell.positionButton addTarget:self action:@selector(moveTo:) forControlEvents:UIControlEventTouchUpInside];
                cell.areaView.frame = CGRectMake(10, 0, 300, 80);
                cell.positionButton.hidden = NO;
                cell.ticketState.hidden = NO;
                cell.ticketAddress.hidden = YES;
                cell.addView.hidden = NO;
                
                if ([self.orderDataInfo._autoPrint intValue] == 0) {
                    cell._ifPrint.text = @"行程单已打印";
                }
                else if ([self.orderDataInfo._autoPrint intValue] == 1)
                {
                    cell._ifPrint.text = @"行程单未打印";
                }
                else if ([self.orderDataInfo._autoPrint intValue] == 2)
                {
                    cell._ifPrint.text = @"行程单部分打印";
                }

            }
            return cell;
        }
        else if (indexPath.row == 2)
        {
            OrderTicketServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.moreButton addTarget:self action:@selector(moreInfo:) forControlEvents:UIControlEventTouchUpInside];
                
                
            }
            if ([self.orderDataInfo._isAcceptService boolValue]) {
                    cell.serviceState.text = @"已选取服务";
                }else {
                    cell.serviceState.text = @"未选取服务";
                }
            return cell;
        }
    }
    else {
        NSString * identifier = @"identifier4";
        MemberOrdercancelCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[MemberOrdercancelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell._allCancelButton addTarget:self action:@selector(clickAllCancel:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
    return nil;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell点击事件");
}


#pragma mark - self
- (void)moveViewDown:(id)sender
{
    NSLog(@"抽屉按钮点击！");
    
    isSelect = !isSelect;
    
    NSMutableArray *arryCell = [[NSMutableArray alloc] init];
    for (int i = 0; i < [myTable numberOfRowsInSection:0]; i ++) {
        [arryCell addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [arryCell addObject:[NSIndexPath indexPathForRow:0 inSection:1]];
    [myTable reloadRowsAtIndexPaths:arryCell withRowAnimation:UITableViewRowAnimationFade];
    [arryCell release];
}

- (void)ruleInfo:(UIButton *)sender
{
    MemberOrderDetailFlightInfoResponse *flightDataInfo = [self.orderDataInfo._flightInfo objectAtIndex:sender.tag];
    NSString *ruleMessage = [NSString stringWithFormat:@"%@", flightDataInfo._rules];
//    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"退改签规则"
//                                                   message:ruleMessage
//                                                  delegate:nil
//                                         cancelButtonTitle:@"确定"
//                                         otherButtonTitles:nil];
//    [alert show];
//    [alert release];
    [UIAlertView alertViewWithMessage:ruleMessage :@"退改签规则"];
}

- (void)moveTo:(id)sender
{
    DevicePositionMapViewController * devicePositionVC = [[DevicePositionMapViewController alloc] init];
    [self.navigationController pushViewController:devicePositionVC animated:YES];
    [devicePositionVC release];
}

- (void)moreInfo:(id)sender
{
    [UIAlertView alertViewWithMessage:ServiceText :@"自动降价说明"];
}

- (void)clickAllCancel:(id)sender
{
    
}

- (void)goBackTicket:(UIButton *)sender
{
    NSString *selectButton = [[NSString stringWithFormat:@"%d", sender.tag] substringToIndex:1];
    NSString *selectRow = [[NSString stringWithFormat:@"%d", sender.tag] substringFromIndex:1];
    NSLog(@"%@-%@", selectRow, selectButton);
    MemberOrderDetailTicketNumberResponse *tickesInfo = [self.orderDataInfo._ticketInfo objectAtIndex:[selectRow intValue]];
    selectTicketNum = [tickesInfo._number objectAtIndex:[selectButton intValue] - 1];
    
    if (self._notLoginUser) {
        ASIFormDataRequest * theRequest = [InterfaceClass queryTicketNumberInformation:selectTicketNum];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGoBackTicketResult:) Delegate:self needUserType:Default];
    }
    else {
        ASIFormDataRequest * theRequest = [InterfaceClass queryTicketNumberInformation:selectTicketNum];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGoBackTicketResult:) Delegate:self needUserType:Member];
    }
    
}

- (void)onGoBackTicketResult:(NSDictionary *)dic
{
    TicketNumberInfoResponse *numberInfo = [TicketNumberInfoResponse setTicketNumberInfo:dic];
    numberInfo._ticketNum = selectTicketNum;
    
    MemberOrderReturnViewController *orderReturnVC = [[MemberOrderReturnViewController alloc] init];
    orderReturnVC.ticketNumberInfo = numberInfo;
    orderReturnVC._notLoginUser = self._notLoginUser;
    [NavigationController pushViewController:orderReturnVC animated:YES];
    [orderReturnVC release];
}

- (void)initData
{
    contactType = 0;
    isSelect = NO;
    userID = [UserInfo sharedUserInfo].userID;
    orderID = self.orderDataInfo._orderId;
    passengersCount = [self.orderDataInfo._passengersInfo count];
    flightCount = [self.orderDataInfo._flightInfo count];
    ticketCount = flightCount * passengersCount;
    
    for (MemberOrderDetailPassengersInfoResponse *item in self.orderDataInfo._passengersInfo) {
        if ([item._type intValue] == 0) {
            adultCount ++;
        }
        else {
            childCount ++;
        }
    }
    
    for (int i = 0; i < [self.orderDataInfo._flightInfo count]; i ++) {
        MemberOrderDetailFlightInfoResponse *flightDataInfo = [self.orderDataInfo._flightInfo objectAtIndex:i];
        if (i == 0){
            goPrice = [flightDataInfo._adultInfo._ticketPrice intValue]*adultCount + [flightDataInfo._childInfo._ticketPrice intValue]*childCount;
            oneAirportPrice = ([flightDataInfo._adultInfo._fuelTax intValue] + [flightDataInfo._adultInfo._airportTax intValue])*adultCount + ([flightDataInfo._childInfo._fuelTax intValue] + [flightDataInfo._childInfo._airportTax intValue])*childCount;
        }
        else {
            arrPrice = [flightDataInfo._adultInfo._ticketPrice intValue]*adultCount + [flightDataInfo._childInfo._ticketPrice intValue]*childCount;
            twoAirportPrice = ([flightDataInfo._adultInfo._fuelTax intValue] + [flightDataInfo._adultInfo._airportTax intValue])*adultCount + ([flightDataInfo._childInfo._fuelTax intValue] + [flightDataInfo._childInfo._airportTax intValue])*childCount;
        }
    }
    
    totalAirportPrice = oneAirportPrice + twoAirportPrice;
    if ([self.orderDataInfo._isBuyInsurance boolValue]) {
        insurancePrice = flightCount * passengersCount * [[GetConfiguration shareGetConfiguration]._insurance intValue];
    }
    else {
        insurancePrice = 0;
    }
    
    totalPrice = [self.orderDataInfo._ticketPrice intValue];

    MemberOrderDetailTicketNumberResponse *ticketsInfo = [self.orderDataInfo._ticketInfo objectAtIndex:0];
    contactType = [ticketsInfo._number count];
    
    if (contactType == 0) {
        ticketCount = flightCount * passengersCount;
    }
    else {
        MemberOrderDetailTicketNumberResponse *ticketInfo = [self.orderDataInfo._ticketInfo objectAtIndex:0];
        ticketCount = [ticketInfo._number count] * [self.orderDataInfo._ticketInfo count];
    }
    
    if ([self.orderState intValue] == 0) {
        myOrderState = NoPay;
        self.title = @"待支付订单";
    }
    else if ([self.orderState intValue] == 1){
        myOrderState = Payments;
        self.title = @"支付中订单";
    }
    else if ([self.orderState intValue] == 2){
        myOrderState = HaveTicket;
        self.title = @"已出票订单";
    }
    else if ([self.orderState intValue] == 3){
        myOrderState = HaveRefund;
        self.title = @"有退票订单";
    }
    else if ([self.orderState intValue] == 4){
        myOrderState = TicketUsed;
        self.title = @"已使用订单";
    }
    else if ([self.orderState intValue] == 5){
        myOrderState = TicketRefund;
        self.title = @"已退票订单";
    }
    else if ([self.orderState intValue] == 6){
        myOrderState = TicketCanceled;
        self.title = @"已取消订单";
    }
}
-(void) setFlightinfo1Info: (OrderTicketToPerchCell *  )tempTableViewCell indexPath: (NSIndexPath *)indexPath
{
    MemberOrderDetailFlightInfoResponse *cellDataInfo = [self.orderDataInfo._flightInfo objectAtIndex:indexPath.row];
    tempTableViewCell.departureCity.text = cellDataInfo._departure;
    tempTableViewCell.arrCity.text = cellDataInfo._arrival;
    tempTableViewCell.departureDate.text = [NSString stringWithFormat:@"%@", cellDataInfo._startTime];
    tempTableViewCell.arrDate.text = [NSString stringWithFormat:@"%@", cellDataInfo._endTime];
    tempTableViewCell.companyName.text = [NSString stringWithFormat:@"%@%@", cellDataInfo._airline, cellDataInfo._flightNo];
    tempTableViewCell.departureTime.text = [NSString stringWithFormat:@"%@", cellDataInfo._departureDate];
    tempTableViewCell.roomLab.text = [NSString stringWithFormat:@"%@(%@)", cellDataInfo._cabinType, cellDataInfo._cabinCode];
    tempTableViewCell.companyView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [cellDataInfo._flightNo substringToIndex:2]]];
    
    if ([self.orderDataInfo._flightType intValue] == 2) {
        if (indexPath.row == 0) {
            tempTableViewCell._stateName.text = @"去程";
        }else {
            tempTableViewCell._stateName.text = @"返程";
        }
    }
    else if ([self.orderDataInfo._flightType intValue] == 3)
    {
        if (indexPath.row == 0) {
            tempTableViewCell._stateName.text = @"第一航程";
        }else {
            tempTableViewCell._stateName.text = @"第二航程";
        }
    }
}

-(void) setFlightinfo2Info: (OrderTicketToPerchDoubleCell *  )tableViewCell indexPath: (NSIndexPath *)indexPath
{
    MemberOrderDetailFlightInfoResponse *cellDataInfo = [self.orderDataInfo._flightInfo objectAtIndex:indexPath.row];
    tableViewCell.departureTime.text = [NSString stringWithFormat:@"%@", cellDataInfo._departureDate];
    tableViewCell.companyName.text = [NSString stringWithFormat:@"%@%@",cellDataInfo._airline, cellDataInfo._flightNo];
    tableViewCell.companyView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [cellDataInfo._flightNo substringToIndex:2]]];
    tableViewCell.planModels.text = [NSString stringWithFormat:@"机型: %@", cellDataInfo._planeType];
    tableViewCell.departureCity.text = cellDataInfo._departure;
    tableViewCell.arrCity.text = cellDataInfo._arrival;
    tableViewCell.departureDate.text = [NSString stringWithFormat:@"%@", cellDataInfo._startTime];
    tableViewCell.arrDate.text = [NSString stringWithFormat:@"%@", cellDataInfo._endTime];
    tableViewCell.airport1.text = [NSString stringWithFormat:@"%@%@", cellDataInfo._startAirport, cellDataInfo._startTerminal];
    tableViewCell.airport2.text = [NSString stringWithFormat:@"%@%@", cellDataInfo._endAirport, cellDataInfo._endTerminal];
    tableViewCell.roomLab.text = [NSString stringWithFormat:@"%@(%@)", cellDataInfo._cabinType, cellDataInfo._cabinCode];
    
    if ([self.orderDataInfo._flightType intValue] == 2) {
        if (indexPath.row == 0) {
            tableViewCell._stateName.text = @"去程";
        }else {
            tableViewCell._stateName.text = @"返程";
        }
    }
    else if ([self.orderDataInfo._flightType intValue] == 3)
    {
        if (indexPath.row == 0) {
            tableViewCell._stateName.text = @"第一航程";
        }else {
            tableViewCell._stateName.text = @"第二航程";
        }
    }
}

-(void) setTicketStateInfo: (MemberOrderPersonCell *)tableViewCell indexPath: (NSIndexPath *)indexPath  type:(NSInteger)type
{
    if ([self.orderDataInfo._ticketInfo count] == 0 || indexPath.row >= [self.orderDataInfo._ticketInfo count]) {
        MemberOrderDetailPassengersInfoResponse *ticketsInfo = [self.orderDataInfo._passengersInfo objectAtIndex:indexPath.row];
        tableViewCell._personName.text = ticketsInfo._name;
        switch ([ticketsInfo._type intValue]) {
            case 0:
            {
                tableViewCell._personType.text = @"成人票";
                tableViewCell._cerNum.text = ticketsInfo._certNum;
                switch ([ticketsInfo._certType intValue]) {
                    case 0:
                        tableViewCell._cerType.text = @"身份证";
                        break;
                    case 1:
                        tableViewCell._cerType.text = @"护照";
                        break;
                    case 9:
                        tableViewCell._cerType.text = @"其他";
                        break;
                    default:
                        break;
                }
                break;
            }
            case 1:
            {
                tableViewCell._personType.text = @"儿童票";
                tableViewCell._cerType.text = @"生日";
                tableViewCell._cerNum.text = ticketsInfo._birthday;
                break;
            }
            default:
                break;
        }
        return;
    }
    
    MemberOrderDetailTicketNumberResponse *ticketsInfo = [self.orderDataInfo._ticketInfo objectAtIndex:indexPath.row];
    tableViewCell._personName.text = ticketsInfo._name;
    switch ([ticketsInfo._type intValue]) {
        case 0:
        {
            tableViewCell._personType.text = @"成人票";
            tableViewCell._cerNum.text = ticketsInfo._certNum;
            switch ([ticketsInfo._certType intValue]) {
                case 0:
                    tableViewCell._cerType.text = @"身份证";
                    break;
                case 1:
                    tableViewCell._cerType.text = @"护照";
                    break;
                case 9:
                    tableViewCell._cerType.text = @"其他";
                    break;
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            tableViewCell._personType.text = @"儿童票";
            tableViewCell._cerType.text = @"生日";
            tableViewCell._cerNum.text = ticketsInfo._birthday;
            break;
        }
        default:
            break;
    }
    
    if ([ticketsInfo._number count] == 1) {
        tableViewCell._ticketNum1.text = [NSString stringWithFormat:@"%@", [ticketsInfo._number objectAtIndex:0]];
        tableViewCell._ticketState1.text = [self setTableViewCellState:[ticketsInfo._state objectAtIndex:0]];
        if ([[ticketsInfo._state objectAtIndex:0] intValue] == 0) {
            tableViewCell._returnTicket1.hidden = NO;
        }
        else if ([[ticketsInfo._state objectAtIndex:0] intValue] == 4){
            tableViewCell._phoneButton1.hidden = NO;
        }
    }
    else if ([ticketsInfo._number count] == 2)
    {
        if ([self.orderDataInfo._flightType intValue] == 2) {
            tableViewCell._ticketNum1.text = [NSString stringWithFormat:@"%@(去)", [ticketsInfo._number objectAtIndex:0]];
            tableViewCell._ticketNum2.text = [NSString stringWithFormat:@"%@(返)", [ticketsInfo._number objectAtIndex:1]];
        }
        else {
            tableViewCell._ticketNum1.text = [NSString stringWithFormat:@"%@(一)", [ticketsInfo._number objectAtIndex:0]];
            tableViewCell._ticketNum2.text = [NSString stringWithFormat:@"%@(二)", [ticketsInfo._number objectAtIndex:1]];
        }
        
        tableViewCell._ticketState1.text = [self setTableViewCellState:[ticketsInfo._state objectAtIndex:0]];
        if ([[ticketsInfo._state objectAtIndex:0] intValue] == 0) {
            tableViewCell._returnTicket1.hidden = NO;
        }
        else if ([[ticketsInfo._state objectAtIndex:0] intValue] == 4){
            tableViewCell._phoneButton1.hidden = NO;
        }
        
        tableViewCell._ticketState2.text = [self setTableViewCellState:[ticketsInfo._state objectAtIndex:1]];
        if ([[ticketsInfo._state objectAtIndex:1] intValue] == 0) {
            tableViewCell._returnTicket2.hidden = NO;
        }
        else if ([[ticketsInfo._state objectAtIndex:1] intValue] == 4){
            tableViewCell._phoneButton2.hidden = NO;
        }
    }
}

- (NSString *)setTableViewCellState:(NSString *)type
{
    NSString *ticketState = @"";
    switch ([type intValue]) {
        case 0:
            ticketState = @"未使用";
            break;
        case 1:
            ticketState = @"已退票";
            break;
        case 2:
            ticketState = @"已使用";
            break;
        case 3:
            ticketState = @"已升舱";
            break;
        case 4:
            ticketState = @"联系客服";
            break;
        default:
            break;
    }
    return ticketState;
}

-(void) orderTicketPriceCell:(OrderTicketPriceCell *  )cell  :(NSInteger )i
{
    cell.returnCoinLab.text = self.orderDataInfo._returnLcdCurrency;
    cell.totalMoneyCoinLab.text = [NSString stringWithFormat:@"%d", totalPrice];
    
    if (isSelect) {
        [cell.moveButton setBackgroundImage:[UIImage imageNamed:@"抽屉2.png"] forState:UIControlStateNormal];
    }else {
        [cell.moveButton setBackgroundImage:[UIImage imageNamed:@"抽屉.png"] forState:UIControlStateNormal];
    }
    
    if ([self.orderDataInfo._flightType intValue] == 1) {
        cell.ticketLab.text = [NSString stringWithFormat:@"票价：￥%d（%d张）", goPrice, ticketCount];
        cell.fuelLab.text = [NSString stringWithFormat:@"机建燃油费：￥%d（%d份）", totalAirportPrice, ticketCount];
    }
    else if ([self.orderDataInfo._flightType intValue] == 2)
    {
        cell.ticketLab.text = [NSString stringWithFormat:@"去程票价：￥%d（%d张）", goPrice, ticketCount/2];
        cell.arrMoneyLab.text = [NSString stringWithFormat:@"返程票价：￥%d（%d张）", arrPrice, ticketCount/2];
        cell.fuelLab.text = [NSString stringWithFormat:@"去程机建燃油费：￥%d（%d份）", oneAirportPrice, ticketCount/2];
        cell.twoFuelLab.text = [NSString stringWithFormat:@"返程机建燃油费：￥%d（%d份）", twoAirportPrice, ticketCount/2];
        
        cell.arrMoneyLab.hidden = NO;
        cell.twoFuelLab.hidden = NO;
        
        cell.ticketLab.frame = CGRectMake(135, 20, 200, 20);
        cell.arrMoneyLab.frame = CGRectMake(135, 33, 200, 20);
        cell.fuelLab.frame = CGRectMake(135, 46, 200, 20);
        cell.twoFuelLab.frame = CGRectMake(135, 59, 200, 20);
        cell.insuranceLab.frame = CGRectMake(135, 72, 200, 20);
    }
    else if ([self.orderDataInfo._flightType intValue] == 3)
    {
        cell.ticketLab.text = [NSString stringWithFormat:@"一程票价：￥%d（%d张）", goPrice, ticketCount/2];
        cell.arrMoneyLab.text = [NSString stringWithFormat:@"二程票价：￥%d（%d张）", arrPrice, ticketCount/2];
        cell.fuelLab.text = [NSString stringWithFormat:@"一程机建燃油费：￥%d（%d份）", oneAirportPrice, ticketCount/2];
        cell.twoFuelLab.text = [NSString stringWithFormat:@"二程机建燃油费：￥%d（%d份）", twoAirportPrice, ticketCount/2];
        
        cell.arrMoneyLab.hidden = NO;
        cell.twoFuelLab.hidden = NO;
        
        cell.ticketLab.frame = CGRectMake(135, 20, 200, 20);
        cell.arrMoneyLab.frame = CGRectMake(135, 33, 200, 20);
        cell.fuelLab.frame = CGRectMake(135, 46, 200, 20);
        cell.twoFuelLab.frame = CGRectMake(135, 59, 200, 20);
        cell.insuranceLab.frame = CGRectMake(135, 72, 200, 20);
    }

    if ([self.orderDataInfo._isBuyInsurance boolValue]) {
        cell.insuranceLab.text = [NSString stringWithFormat:@"保险：￥%d（%d份）", insurancePrice, ticketCount];
    }else {
        cell.insuranceLab.text = [NSString stringWithFormat:@"保险：￥0（0份）"];
    }    
}


- (void)phoneClick
{
    [self callTel:@"400-6858-999"];
}
@end

