


//
//  OrderTicketToPerchViewController.m
//  FlightProject
//
//  Created by 高鹏程 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderTicketToPerchViewController.h"

#import "AppDelegate.h"
#import "TicketOrderInfoViewController.h"
#import "RecommendClass.h"
#import "DataClass.h"
#import "GetConfiguration.h"

@interface OrderTicketToPerchViewController ()
@property (nonatomic,retain)PayForSuccessViewController *paySuccessVC;
@end


@implementation OrderTicketToPerchViewController

@synthesize myField;
@synthesize myMode, requestURL, requestTimes, requestApplication, unionPayResult;
@synthesize myDelegate;
@synthesize orderInfoData, queryDataModel, isExpend;
@synthesize headerView, centerView;
@synthesize textFieldArray,keyboardbar;
@synthesize paySuccessVC;
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
    myDelegate.payResultDelegate = nil;

    self.orderInfoData = nil;
    self.queryDataModel = nil;

    self.orderInfoData = nil;

    self.myField = nil;
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    
    myDelegate.payResultDelegate = nil;
    self.paySuccessVC = nil;
    [super dealloc];
}

-(void) assignedHeaderView:(FlightInfo * ) info sigleView:(FlightSingleInfo *)singleInfo hardView:(FlightHardInfo *)hardInfo index:(NSInteger)i
{
    singleInfo._fromTime.text = [info._startDate substringFromIndex:11];
    
    singleInfo._fromCity.text = self.queryDataModel._fromCity._nameStr;
    singleInfo._toCity.text = self.queryDataModel._toCity._nameStr;
    singleInfo._flightTypeImage.image  = nil;
    
    if (self.queryDataModel._flightType == ConnectTypeSecond ) {
        if (i == 0) {
            singleInfo._fromCity.text = self.queryDataModel._fromCity._nameStr;
            singleInfo._toCity.text = self.queryDataModel._transitCity._nameStr;
            singleInfo._flightTypeImage.image  = [UIImage imageNamed:@"一程.png"];
        }
        else {
            singleInfo._fromCity.text = self.queryDataModel._transitCity._nameStr;
            singleInfo._toCity.text = self.queryDataModel._toCity._nameStr;
            singleInfo._flightTypeImage.image  = [UIImage imageNamed:@"二程.png"];
        }
    }
    else if (self.queryDataModel._flightType == RoundTypeBack) {
        if (i == 0) {
            singleInfo._fromCity.text = self.queryDataModel._toCity._nameStr;
            singleInfo._toCity.text = self.queryDataModel._fromCity._nameStr;
            singleInfo._flightTypeImage.image  = [UIImage imageNamed:@"去程.png"];
        }
        else {
            singleInfo._fromCity.text = self.queryDataModel._fromCity._nameStr;
            singleInfo._toCity.text = self.queryDataModel._toCity._nameStr;
            singleInfo._flightTypeImage.image  = [UIImage imageNamed:@"返程.png"];
        }
    }
    
    singleInfo._toTime.text = [info._endTime substringFromIndex:11];
    singleInfo._fromDate.text = [info._startDate substringToIndex:10];
    singleInfo._companyImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[info._flightNo substringToIndex:2]]];
    singleInfo._flightNo.text = [NSString stringWithFormat:@"%@%@",info._airline,info._flightNo];
    singleInfo._flightCabinName.text = [NSString stringWithFormat:@"%@(%@)",info._selectedCabin._cabinTypeName,info._selectedCabin._cabinCode];
    
    hardInfo._planType.text = info._planeType;
    hardInfo._fromDate.text = [info._startDate substringToIndex:10];
    hardInfo._companyImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[info._flightNo substringToIndex:2]]];
    hardInfo._flightNo.text =  [NSString stringWithFormat:@"%@%@",info._airline,info._flightNo];
    hardInfo._fromCity.text = self.queryDataModel._fromCity._nameStr;
    hardInfo._toCity.text = self.queryDataModel._toCity._nameStr;
    hardInfo._flightTypeImage.image  = nil;
    
    if (self.queryDataModel._flightType == ConnectTypeSecond ) {
        if (i == 0) {
            hardInfo._fromCity.text = self.queryDataModel._fromCity._nameStr;
            hardInfo._toCity.text = self.queryDataModel._transitCity._nameStr;
            hardInfo._flightTypeImage.image  = [UIImage imageNamed:@"一程.png"];
        }
        else {
            hardInfo._fromCity.text = self.queryDataModel._transitCity._nameStr;
            hardInfo._toCity.text = self.queryDataModel._toCity._nameStr;
            hardInfo._flightTypeImage.image  = [UIImage imageNamed:@"二程.png"];
        }
    }  
    else if (self.queryDataModel._flightType == RoundTypeBack) {
        if (i == 0) {
            hardInfo._fromCity.text = self.queryDataModel._toCity._nameStr;
            hardInfo._toCity.text = self.queryDataModel._fromCity._nameStr;
            hardInfo._flightTypeImage.image  = [UIImage imageNamed:@"去程.png"];
        }
        else {
            hardInfo._fromCity.text = self.queryDataModel._fromCity._nameStr;
            hardInfo._toCity.text = self.queryDataModel._toCity._nameStr;
            hardInfo._flightTypeImage.image  = [UIImage imageNamed:@"返程.png"];
        }
    }
    
    hardInfo._fromterminal.text = [NSString stringWithFormat:@"%@%@",info._startAirport,info._startTerminal];
    hardInfo._fromTime.text = [info._startDate substringFromIndex:11];
    
    hardInfo._toterminal.text = [NSString stringWithFormat:@"%@%@",info._endAirport,info._endTerminal];
    hardInfo._toTime.text = [info._endTime substringFromIndex:11];
    hardInfo._flightCabinName.text = [NSString stringWithFormat:@"%@(%@)",info._selectedCabin._cabinTypeName,info._selectedCabin._cabinCode];
}

-(void) initHeaderView
{
    singleInfos = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 40)];
    hardInfos = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 90)];
    for (int i = 0; i < [self.orderInfoData._flightsInfoArray  count]; i++) {
        FlightSingleInfo * singleInfo = [[FlightSingleInfo alloc] initWithFrame:CGRectMake(0, i*40, ViewWidth, 40)];
        FlightHardInfo * hardInfo = [[FlightHardInfo alloc] initWithFrame:CGRectMake(0, i*90, ViewWidth, 90)];
        CGRect singleRect = singleInfos.frame;
        CGRect hardRect = hardInfos.frame;
        singleRect.size.height = 40 + i*40;
        hardRect.size.height = 90 + i*90;
        singleInfos.frame= singleRect;
        hardInfos.frame = hardRect;
        [singleInfos addSubview:singleInfo];
        [hardInfos addSubview:hardInfo];
        [singleInfo release];
        [hardInfo release];
        
        FlightInfo * info = [self.orderInfoData._flightsInfoArray objectAtIndex:i];
        [self assignedHeaderView:info sigleView:singleInfo hardView:hardInfo index:i];
    }
    
    [self.view addSubview:hardInfos];
    [self.view addSubview:singleInfos];
    [singleInfos release];
    [hardInfos release];
    singleInfos.hidden = YES;
    hardInfos.hidden = YES;
    self.headerView = singleInfos;
}
-(void) initCenterView
{
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(10, self.headerView.frame.size.height, 300, ViewHeight - 44 - self.headerView.frame.size.height - 20)];
    view2.backgroundColor = [UIColor clearColor];
    
    UIImageView * center1 = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, view2.frame.size.width, 7) image:[UIImage imageNamed:@"CenterView1.png"]];
    UIImageView * center2 = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, view2.frame.size.width, view2.frame.size.height) image:[UIImage imageNamed:@"CenterView2.png"]];
    UIImageView * footerShadow = [UIImageView ImageViewWithFrame:CGRectMake(0, view2.frame.size.height-5, view2.frame.size.width, 7) image:[UIImage imageNamed:@"CenterView3.png"]];
    
    [view2 addSubview:center2];
    [view2 addSubview:center1];
    [view2 addSubview:footerShadow];
    
    center2.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [view2 addSubview:[UIButton buttonWithTag:0 image:[UIImage imageNamed:@"抽屉.png"] title:nil  imageEdge:UIEdgeInsetsMake(0, (120-54) /2, 30-10, (120-54) /2)  frame:CGRectMake((view2.frame.size.width-120) / 2, 0, 120, 30) font:nil color:nil target:self action:@selector(expendHeaderView:)]];
    self.centerView = view2;
    
    [view2 release];
    [self.view addSubview:self.centerView];
}

- (void)computePrice
{
    int adultNum = self.orderInfoData._adlutCount;
    int clildNum = self.orderInfoData._childCount;
    for (int i = 0; i < [self.orderInfoData._flightsInfoArray count]; i++) 
    {
        FlightInfo * info = [self.orderInfoData._flightsInfoArray objectAtIndex:i];
        
        if (i == 0) {
            goPrice =  [info._selectedCabin._ticketPrice intValue]  *adultNum;
            arrPrice =  0;
            oneAirportPrice = [info._fuelTaxForAdult intValue] * adultNum + [info._fuelTaxForChild intValue] * clildNum + [info._airportTaxForAdult intValue] * adultNum + [info._airportTaxForChild intValue] * clildNum;
        }
        else {
            arrPrice =  [info._selectedCabin._ticketPrice intValue] *adultNum;
            twoAirportPrice = [info._fuelTaxForAdult intValue] * adultNum + [info._fuelTaxForChild intValue] * clildNum + [info._airportTaxForAdult intValue] * adultNum + [info._airportTaxForChild intValue] * clildNum;
        }
        
        if (self.orderInfoData._childCount > 0) {  // zxt 修改 20121207
            if (i == 0) {
                goPrice += [[self.orderInfoData._orderInfo._ticketPriceForChild objectAtIndex:i] intValue]*clildNum;
            }
            else {
                arrPrice += [[self.orderInfoData._orderInfo._ticketPriceForChild objectAtIndex:i] intValue]*clildNum;
            }
        }
    }

    totalAirportPrice = oneAirportPrice + twoAirportPrice;
    if (self.orderInfoData._isBuyInsurance) {
        insurancePrice = [self.orderInfoData._flightsInfoArray count] * (adultNum + clildNum) * [[GetConfiguration shareGetConfiguration]._insurance intValue];
    }
    else {
        insurancePrice = 0;
    }
    
    totalPrice = goPrice + arrPrice + totalAirportPrice + insurancePrice;
    lcdPrice = [orderInfoData._orderInfo._availableLcdCurrency intValue];
    ticketCount = [self.orderInfoData._flightsInfoArray count] * (adultNum + clildNum);
}

-(void)expendHeaderView:(UIButton *)sender
{
    self.isExpend = !self.isExpend;
    if (self.isExpend) {
        self.headerView = hardInfos;
        [sender setImage:[UIImage imageNamed:@"抽屉2.png"] forState:UIControlStateNormal];
    }
    else
    {
        self.headerView = singleInfos;
        [sender setImage:[UIImage imageNamed:@"抽屉.png"] forState:UIControlStateNormal];
    }
}
-(void)setHeaderView:(UIView *)_headerView
{
    if (headerView != _headerView) {
        
        [headerView release];
        [headerView setHidden:YES];
        headerView = [_headerView retain];
        [headerView setHidden:NO];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        self.centerView.frame = CGRectMake(10, self.headerView.frame.size.height, 300, ViewHeight - self.headerView.frame.size.height-20);
        [UIView commitAnimations];
    }
}

- (void)viewDidLoad
{

    [super viewDidLoad];
   // Do any additional setup after loading the view.
    
    UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 0, 52, 30) backImage:nil target:nil action:nil];
    UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    self.title = @"订单确认";
    isSelect = NO;
    isAllPayment = NO;
    flightNum = [self.orderInfoData._flightsInfoArray count];
    userID = [UserInfo sharedUserInfo].userID;
    orderID = self.orderInfoData._orderInfo._orderId;
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    [self computePrice];

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
    //return 2;
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return flightNum;
    }
    else if (section == 1){
        
        if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
            return 1;
        }
        else {
            return 2;
        }
        
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
        return 105;
    }
    else 
    {
        if (isAllPayment) {
            return 70;
        }
        else {
            NSArray *paymentArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._payment];
            return 25+45*[paymentArray count]+5;
        }
    }
}

-(void) orderTicketToPerchCell:(OrderTicketToPerchCell *  )cell :(FlightInfo *)info :(NSInteger )i
{
    if ([myTable numberOfRowsInSection:0] == i + 1) {
        cell.lineView.hidden = YES;
    }else {
        cell.lineView.hidden = NO;
    }
    if ([myTable numberOfRowsInSection:0] > 1) 
    {
        if (i == 0)
        {
            cell._stateName.text = @"去程";
        }
        else {
            cell._stateName.text = @"返程";
        }
    }

    cell.departureDate.text = [info._startDate substringFromIndex:11];
    
    cell.departureCity.text = self.queryDataModel._fromCity._nameStr;
    cell.arrCity.text = self.queryDataModel._toCity._nameStr;
    cell._stateName.text = @"单程";
    
    if (self.queryDataModel._flightType == ConnectTypeSecond ) {
        if (i == 0) {
            cell.departureCity.text = self.queryDataModel._fromCity._nameStr;
            cell.arrCity.text = self.queryDataModel._transitCity._nameStr;
            cell._stateName.text = @"第一航程";
        }
        else {
            cell.departureCity.text = self.queryDataModel._transitCity._nameStr;
            cell.arrCity.text = self.queryDataModel._toCity._nameStr;
            cell._stateName.text = @"第二航程";
        }
    }
    else if (self.queryDataModel._flightType == RoundTypeBack) {
        if (i == 0) {
            cell.departureCity.text = self.queryDataModel._toCity._nameStr;
            cell.arrCity.text = self.queryDataModel._fromCity._nameStr;
            cell._stateName.text = @"去程";
        }
        else {
            cell.departureCity.text = self.queryDataModel._fromCity._nameStr;
            cell.arrCity.text = self.queryDataModel._toCity._nameStr;
            cell._stateName.text = @"返程";
        }
    }

    cell.arrDate.text = [info._endTime substringFromIndex:11];
    cell.departureTime.text = [info._startDate substringToIndex:10];
    cell.companyView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[info._flightNo substringToIndex:2]]];
    cell.companyName.text = [NSString stringWithFormat:@"%@%@",info._airline, info._flightNo];
    cell.roomLab.text = [NSString stringWithFormat:@"%@(%@)",info._selectedCabin._cabinTypeName,info._selectedCabin._cabinCode];
    
}
-(void) orderTicketToPerchDoubleCell:(OrderTicketToPerchDoubleCell *  )cell :(FlightInfo *)info :(NSInteger )i
{
    if ([myTable numberOfRowsInSection:0] == i + 1) {
        cell.lineView.hidden = YES;
    }else {
        cell.lineView.hidden = NO;
    }
    if ([myTable numberOfRowsInSection:0] > 1) 
    {
        if (i == 0)
        {
            cell._stateName.text = @"去程";
        }
        else {
            cell._stateName.text = @"返程";
        }
    }

    cell.planModels.text = [NSString stringWithFormat:@"机型：%@", info._planeType];
    cell.departureTime.text = [info._startDate substringToIndex:10];
    cell.companyView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[info._flightNo substringToIndex:2]]];
    cell.companyName.text =  [NSString stringWithFormat:@"%@%@",info._airline, info._flightNo];
    cell.departureCity.text = self.queryDataModel._fromCity._nameStr;
    cell.arrCity.text = self.queryDataModel._toCity._nameStr;
    cell._stateName.text = @"单程";
    
    if (self.queryDataModel._flightType == ConnectTypeSecond ) {
        if (i == 0) {
            cell.departureCity.text = self.queryDataModel._fromCity._nameStr;
            cell.arrCity.text = self.queryDataModel._transitCity._nameStr;
            cell._stateName.text = @"第一航程";
        }
        else {
            cell.departureCity.text = self.queryDataModel._transitCity._nameStr;
            cell.arrCity.text = self.queryDataModel._toCity._nameStr;
            cell._stateName.text = @"第二航程";
        }
    }  
    else if (self.queryDataModel._flightType == RoundTypeBack) {
        if (i == 0) {
            cell.departureCity.text = self.queryDataModel._toCity._nameStr;
            cell.arrCity.text = self.queryDataModel._fromCity._nameStr;
            cell._stateName.text = @"去程";
        }
        else {
            cell.departureCity.text = self.queryDataModel._fromCity._nameStr;
            cell.arrCity.text = self.queryDataModel._toCity._nameStr;
            cell._stateName.text = @"返程";
        }
    }

    cell.airport1.text = [NSString stringWithFormat:@"%@%@",info._startAirport,info._startTerminal];
    cell.departureDate.text = [info._startDate substringFromIndex:11];
    
    cell.airport2.text = [NSString stringWithFormat:@"%@%@",info._endAirport,info._endTerminal];
    cell.arrDate.text = [info._endTime substringFromIndex:11];
    cell.roomLab.text = [NSString stringWithFormat:@"%@(%@)",info._selectedCabin._cabinTypeName,info._selectedCabin._cabinCode];
}
-(void) orderTicketPriceCell:(OrderTicketPriceCell *  )cell  :(NSInteger )i
{
    NSLog(@"返畅达币%@", orderInfoData._orderInfo._returnLcdCurrency);
    cell.returnCoinLab.text = orderInfoData._orderInfo._returnLcdCurrency;
    cell.totalMoneyCoinLab.text = [NSString stringWithFormat:@"%d", totalPrice];
    
    if (isSelect) {
        [cell.moveButton setBackgroundImage:[UIImage imageNamed:@"抽屉2.png"] forState:UIControlStateNormal];
    }else {
        [cell.moveButton setBackgroundImage:[UIImage imageNamed:@"抽屉.png"] forState:UIControlStateNormal];
    }
    
    if ([self.orderInfoData._flightsInfoArray count] == 1) {
        cell.ticketLab.text = [NSString stringWithFormat:@"票价：￥%d（%d张）", goPrice, ticketCount];
        cell.fuelLab.text = [NSString stringWithFormat:@"机建燃油费：￥%d（%d份）", totalAirportPrice, ticketCount];
    }
    else if ([self.orderInfoData._flightsInfoArray count] == 2)
    {
        
        if (self.queryDataModel._flightType == RoundTypeBack) {
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
        else {
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
    }

    if (self.orderInfoData._isBuyInsurance) {
        cell.insuranceLab.text = [NSString stringWithFormat:@"保险：￥%d（%d份）", insurancePrice, ticketCount];
    }else {
        cell.insuranceLab.text = [NSString stringWithFormat:@"保险：￥0（0份）"];
    }

}
-(void) orderTicket3Cell:(OrderTicket3Cell *  )cell  :(NSInteger )i
{
    NSArray *paymentArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._payment];
    cell._backGroundView.frame = CGRectMake(10, 0, ViewWidth - 20, 25+paymentArray.count*45);
    
//    for (int i = 0; i < paymentArray.count; i ++)
//    {
//        if (i>5) {
//            break;
//        }
//        PayUIButton *button = (PayUIButton *)[cell viewWithTag:[[paymentArray objectAtIndex:i] intValue]];
//        button.hidden = NO;
//        button.frame = CGRectMake(0, 25+i*45, ViewWidth, 45);
//    }
    
    NSMutableArray * btnArr = [NSMutableArray array];
    for (int i = 0; i < paymentArray.count; i ++)
    {
        if (i>5) {
            break;
        }
        PayUIButton *button = (PayUIButton *)[cell viewWithTag:[[paymentArray objectAtIndex:i] intValue]];
        button.hidden = NO;
        if ([btnArr count]==0) {
            [btnArr addObject:button];
        }
        else
        {
            NSUInteger insertIndex = [btnArr count];
            for (int i = 0; i < btnArr.count; i ++) {
                PayUIButton *elem = (PayUIButton *)[btnArr objectAtIndex:i];
                if (elem._level > button._level) {
                    insertIndex = i;
                    break;
                }
            }
            [btnArr insertObject:button atIndex:insertIndex];
        }
    }
    for (int i = 0; i < btnArr.count; i ++) {
        PayUIButton *elemBtn = (PayUIButton *)[btnArr objectAtIndex:i];
        elemBtn.frame = CGRectMake(0, 25+i*45, ViewWidth, 45);
    }

    
//    for (int i = 0; i < paymentArray.count; i ++) {
//        
//        UIButton *button = (UIButton *)[cell viewWithTag:[[paymentArray objectAtIndex:i] intValue]];
//        button.hidden = NO;
//        
//        if (i == 0) {
//            button.frame = CGRectMake(20, 27, 136, 33);
//        }
//        else if (i == 1) {
//            button.frame = CGRectMake(164, 27, 136, 33);
//        }
//        else if (i == 2) {
//            button.frame = CGRectMake(20, 75, 136, 33);
//        }
//        else if (i == 3) {
//            button.frame = CGRectMake(164, 75, 136, 33);
//        }
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (!isSelect) 
        {
            NSString * identifier = @"identifier1";
            OrderTicketToPerchCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketToPerchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            FlightInfo * info = [self.orderInfoData._flightsInfoArray objectAtIndex:indexPath.row];
            [self orderTicketToPerchCell:cell :info:indexPath.row];
            return cell;
        }
        else 
        {
            NSString * identifier = @"identifier11";
            OrderTicketToPerchDoubleCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketToPerchDoubleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                [cell.ruleButton addTarget:self action:@selector(ruleInfo:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.ruleButton.tag =  indexPath.row;
            FlightInfo * info = [self.orderInfoData._flightsInfoArray objectAtIndex:indexPath.row];
            [self orderTicketToPerchDoubleCell :cell :info:indexPath.row];
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
                
                [cell.cellButton addTarget:self action:@selector(moveViewRight:) forControlEvents:UIControlEventTouchUpInside];
                [cell.moveButton addTarget:self action:@selector(moveViewDown:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            if ([[UserInfo sharedUserInfo].userID isEqualToString:@""] || [orderInfoData._orderInfo._returnLcdCurrency intValue] == 0) {
                cell._returnLcdView.hidden = YES;
            }
            else {
                cell._returnLcdView.hidden = NO;
            }
            [self orderTicketPriceCell:cell :indexPath.row];
            return cell;
        }
        else {
            NSString * identifier = @"identifier22";
            OrderTicketPrice2Cell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketPrice2Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                self.textFieldArray = [NSArray arrayWithObjects:cell.coinFiled, nil];
            }
            actualPriceLab = cell.remainderLab;
            actualPriceLab.text = [NSString stringWithFormat:@"%d", totalPrice];
            cell.coinFiled.delegate = self;
            self.myField = cell.coinFiled ;
            
            cell.ownCoinLab.text = [NSString stringWithFormat:@"可使用 %@ 畅达币", orderInfoData._orderInfo._availableLcdCurrency];
            return cell;
        }
    }
    else if (indexPath.section == 2)
    {
        if (isAllPayment)
        {
            NSString * identifier = @"identifier4";
            OrderTicketPayCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.payButton addTarget:self action:@selector(payCDCoin:) forControlEvents:UIControlEventTouchUpInside];
            }
            return cell;
        }
        else 
        {
            NSString * identifier = @"identifier3";
            OrderTicket3Cell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicket3Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.leftButton._button addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
                [cell.rightButton._button addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
                [cell.cardButton._button addTarget:self action:@selector(clickCardButton:) forControlEvents:UIControlEventTouchUpInside];
                [cell.weixinButton._button addTarget:self action:@selector(clickWeixinButton:) forControlEvents:UIControlEventTouchUpInside];
                [cell.telButton._button addTarget:self action:@selector(clickTelButton:) forControlEvents:UIControlEventTouchUpInside];
//                [cell.otherButton addTarget:self action:@selector(moveOtherView:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, self.orderInfoData._orderInfo._payment.count*45+20, ViewWidth - 20, 10) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
            }
            [self orderTicket3Cell:cell :indexPath.row];
            return cell;
        }   
    }
    return nil;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell点击事件");
//    [self.myField resignFirstResponder];
    [self.keyboardbar HiddenKeyBoard];
}

#pragma mark - textFild delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.keyboardbar == nil) {
        KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
        self.keyboardbar = _keyboardbar;
        [_keyboardbar release];
    }
    [keyboardbar showBar:textField];  //显示工具条 
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    actualPriceLab.text = [NSString stringWithFormat:@"%d", totalPrice];
    textField.text = @"0";
    if (isAllPayment) {
        isAllPayment = !isAllPayment;
        
        [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
    }
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * temp = [textField.text stringByReplacingCharactersInRange:range withString:string];
    temp = [NSString stringWithFormat:@"%d",[temp intValue]];

    if (lcdPrice > totalPrice) {
        if ([temp intValue] >= totalPrice) {
            if (!isAllPayment) {
                isAllPayment = !isAllPayment;
                
                [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
            }
            
            textField.text = [NSString stringWithFormat:@"%d", totalPrice];
            actualPriceLab.text = @"0";
            if ([temp intValue] > totalPrice) {
                [UIAlertView alertViewWithMessage:@"您使用的畅达币超出了应支付的当前票价！" :@"提示"];
            }
            return NO;
        }
        
        if ([temp intValue] < totalPrice && isAllPayment) {
            isAllPayment = !isAllPayment;
            
            [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    else{
        if ([temp intValue] >= lcdPrice) {
            
            textField.text = [NSString stringWithFormat:@"%d", lcdPrice];
            actualPriceLab.text = [NSString stringWithFormat:@"%d",  (totalPrice - lcdPrice)];
            if ([temp intValue] > lcdPrice) {
                [UIAlertView alertViewWithMessage:@"您没有这么多的可用畅达币！" :@"提示"];
            }
            return NO;
        }
    }
    actualPriceLab.text = [NSString stringWithFormat:@"%d",  (totalPrice - [temp intValue])];
    textField.text = temp;
    return NO;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 123) {
        if (buttonIndex == 1) {
            NSString * URLString = [NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id333206289?mt=8"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
        }
    }
    else  if (alertView.tag == 124) {
    }
    else if (alertView.tag == 71) {
        if (buttonIndex == 1) {
            [[ActivityTimerView shareTimerView] hiddenTimerView];
            [[ActivityTimerView shareTimerView] stopTimerView];
            
            NSArray *paymentArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._payment];
            NSArray *payInfoArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._paymentInfo];
            if (paymentArray.count == payInfoArray.count) {
                NSString *payMesage = [payInfoArray objectAtIndex:[paymentArray indexOfObject:@"4"]];
                if (payMesage.length > 0) {
                    
                    [UIAlertView alertViewWithMessage:payMesage];
                    return;
                }
            }
            
            [self callTel:@"400-6858-999"];
        }
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        NSString * actualPrice = [NSString stringWithFormat:@"%d",[actualPriceLab.text intValue]];
        NSString * lcdCoinPrice =  [NSString stringWithFormat:@"%d",[myField.text intValue]];
        
        if ([[UserInfo sharedUserInfo].userID isEqualToString:@""])
        {
            actualPrice = [NSString stringWithFormat:@"%d",totalPrice];
            lcdCoinPrice = @"0";
        }
        
        OrderByCardPayViewController *orderPay = [[OrderByCardPayViewController alloc] init];
        orderPay.cardPayMoney = actualPrice;
        orderPay.lcdCurrency = lcdCoinPrice;
        orderPay.orderId = self.orderInfoData._orderInfo._orderId;
        orderPay._flightArriveCode = self.queryDataModel._toCity._nameCode;
        orderPay._flightArriveDateCode = self.queryDataModel._arriveDate._nameCode;
        orderPay.telephone = self.orderInfoData._contactorPhone;
//        NSInteger returnLcd = 0;
//        for (FlightInfo * info in self.orderInfoData._flightsInfoArray) {
//            returnLcd += [info._selectedCabin._returnLcdFee intValue];
//        }
        orderPay.returnLcd = self.orderInfoData._orderInfo._returnLcdCurrency;
        
        [NavigationController pushViewController:orderPay animated:YES];
        [orderPay release];
    }
    else if (buttonIndex == 1)
    {
        [self callTel:@"400-6858-999"];
    }
}

#pragma mark - self

- (void)payCDCoin:(id)sender
{
    if ([GetConfiguration shareGetConfiguration]._umeng) {
        [MobClick event:@"LcdPay"];
    }
    NSLog(@"畅达币支付！");
    if ([ActivityTimerView shareTimerView]._isAactivation) {
        [[ActivityTimerView shareTimerView] hiddenTimerView];
    }

    myDelegate.payResultDelegate = nil;
    NSString * lcdCoinPrice =  [NSString stringWithFormat:@"%d",[myField.text intValue]];
        
    ASIFormDataRequest * theRequest = [InterfaceClass payLcdCoin:[UserInfo sharedUserInfo].userID withOrderId:self.orderInfoData._orderInfo._orderId withPayCoin:lcdCoinPrice];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getPayCDCoinResult:) Delegate:self needUserType:NoMember];
}

- (void)getPayCDCoinResult:(NSDictionary * )dic
{
    if ([[dic objectForKey:@"statusCode"] intValue] == 0 || [[dic objectForKey:@"statusCode"] intValue] == 1 || [[dic objectForKey:@"statusCode"] intValue] == 3) {
        [self paySuccessFul:dic];
    }
    else {
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
    }
}

- (void)moveViewDown:(id)sender
    {
    NSLog(@"抽屉按钮点击！");
//    [self.myField resignFirstResponder];
    [self.keyboardbar HiddenKeyBoard];

    isSelect = !isSelect;

    NSMutableArray *arryCell = [[NSMutableArray alloc] init];
    for (int i = 0; i < [myTable numberOfRowsInSection:0]; i ++) {
        [arryCell addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [arryCell addObject:[NSIndexPath indexPathForRow:0 inSection:1]];
    [myTable reloadRowsAtIndexPaths:arryCell withRowAnimation:UITableViewRowAnimationFade];
    [arryCell release];
}

- (void)moveViewRight:(id)sender
{
//    [self.myField resignFirstResponder];
    [self.keyboardbar HiddenKeyBoard];
    myDelegate.payResultDelegate = nil;
    NSLog(@"VIEW 右测切换！");
    
    OrderTicketInfoViewController *orderTicketInfoVC = [[OrderTicketInfoViewController alloc] init];
    orderTicketInfoVC.totalPrice = totalPrice;
    orderTicketInfoVC.orderInfoData = self.orderInfoData;
    if (self.queryDataModel._flightType == RoundTypeBack) {
        orderTicketInfoVC.flyTpye = @"1";
    }
    else if(self.queryDataModel._flightType == ConnectTypeSecond){
        orderTicketInfoVC.flyTpye = @"2";
    }
    else{
        orderTicketInfoVC.flyTpye = @"0";
    }
    [self.navigationController pushViewController:orderTicketInfoVC animated:YES];
    [orderTicketInfoVC release];
}

- (void)moveOtherView:(id)sender
{
    NSLog(@"其他方式支付");

    myDelegate.payResultDelegate = nil;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self 
                                                    cancelButtonTitle:@"取消" 
                                               destructiveButtonTitle:@"信用卡支付" 
                                                    otherButtonTitles:@"拨打客服电话预订", nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}

- (void)clickLeftButton:(UIButton *)sender
{
    if ([ActivityTimerView shareTimerView]._isAactivation) {
        [[ActivityTimerView shareTimerView] hiddenTimerView];
    }
    if ([GetConfiguration shareGetConfiguration]._umeng) {
        [MobClick event:@"AlixPay"];
    }
    
    NSArray *paymentArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._payment];
    NSArray *payInfoArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._paymentInfo];
    if (paymentArray.count == payInfoArray.count) {
        NSString *payMesage = [payInfoArray objectAtIndex:[paymentArray indexOfObject:[NSString stringWithFormat:@"%d", sender.tag]]];
        if (payMesage.length > 0) {
            
            [UIAlertView alertViewWithMessage:payMesage];
            return;
        }
    }
    
    NSLog(@"左侧支付按钮");
    self.myMode = Alix;
    myDelegate.payResultDelegate = self;
    [self orderPay:@"0"];
}

- (void)clickRightButton:(UIButton *)sender
{
    if ([ActivityTimerView shareTimerView]._isAactivation) {
        [[ActivityTimerView shareTimerView] hiddenTimerView];
    }
    if ([GetConfiguration shareGetConfiguration]._umeng) {
        [MobClick event:@"UnionPay"];
    }
    
    NSArray *paymentArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._payment];
    NSArray *payInfoArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._paymentInfo];
    if (paymentArray.count == payInfoArray.count) {
        NSString *payMesage = [payInfoArray objectAtIndex:[paymentArray indexOfObject:[NSString stringWithFormat:@"%d", sender.tag]]];
        if (payMesage.length > 0) {
            
            [UIAlertView alertViewWithMessage:payMesage];
            return;
        }
    }
    
    NSLog(@"右侧支付按钮");
    self.myMode = Union;
    myDelegate.payResultDelegate = nil;
    [self orderPay:@"1"];
}
- (void)clickWeixinButton:(UIButton *)sender
{
    NSArray *paymentArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._payment];
    NSArray *payInfoArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._paymentInfo];
    if (paymentArray.count == payInfoArray.count) {
        NSString *payMesage = [payInfoArray objectAtIndex:[paymentArray indexOfObject:[NSString stringWithFormat:@"%d", sender.tag]]];
        if (payMesage.length > 0) {
            
            [UIAlertView alertViewWithMessage:payMesage];
            return;
        }
    }
    
    NSLog(@"微信支付按钮");
    self.myMode = Weixin;
    myDelegate.payResultDelegate = self;
    [self orderPay:@"5"];
    //    [WeiXinExport sendPay_Demo:nil];

}
- (void)clickTelButton:(UIButton *)sender
{
    if ([ActivityTimerView shareTimerView]._isAactivation) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"电话支付无法参加活动，是否继续支付" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        alert.tag = 71;
        [alert show];
        [alert release];
        return;
    }
    
    NSArray *paymentArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._payment];
    NSArray *payInfoArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._paymentInfo];
    if (paymentArray.count == payInfoArray.count) {
        NSString *payMesage = [payInfoArray objectAtIndex:[paymentArray indexOfObject:[NSString stringWithFormat:@"%d", sender.tag]]];
        if (payMesage.length > 0) {
            
            [UIAlertView alertViewWithMessage:payMesage];
            return;
        }
    }
    
    [self callTel:@"400-6858-999"];
}

- (void)clickCardButton:(UIButton *)sender
{
    NSArray *paymentArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._payment];
    NSArray *payInfoArray = [NSArray arrayWithArray:self.orderInfoData._orderInfo._paymentInfo];
    if (paymentArray.count == payInfoArray.count) {
        NSString *payMesage = [payInfoArray objectAtIndex:[paymentArray indexOfObject:[NSString stringWithFormat:@"%d", sender.tag]]];
        if (payMesage.length > 0) {
            
            [UIAlertView alertViewWithMessage:payMesage];
            return;
        }
    }
    
    NSString * actualPrice = [NSString stringWithFormat:@"%d",[actualPriceLab.text intValue]];
    NSString * lcdCoinPrice =  [NSString stringWithFormat:@"%d",[myField.text intValue]];
    
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""])
    {
        actualPrice = [NSString stringWithFormat:@"%d",totalPrice];
        lcdCoinPrice = @"0";
    }
    
    OrderByCardPayViewController *orderPay = [[OrderByCardPayViewController alloc] init];
    orderPay.isCAFlight = [self isFlightNumCA];
    orderPay.cardPayMoney = actualPrice;
    orderPay.lcdCurrency = lcdCoinPrice;
    orderPay.orderId = self.orderInfoData._orderInfo._orderId;
    orderPay._flightArriveCode = self.queryDataModel._toCity._nameCode;
    orderPay._flightArriveDateCode = self.queryDataModel._arriveDate._nameCode;
    orderPay.telephone = self.orderInfoData._contactorPhone;
    orderPay.returnLcd = self.orderInfoData._orderInfo._returnLcdCurrency;
    
    [NavigationController pushViewController:orderPay animated:YES];
    [orderPay release];
}

- (void)ruleInfo:(UIButton *)sender
{
    NSLog(@"退改签规则");
    selectFlightInfoIndex = sender.tag;
    FlightInfo * info = [self.orderInfoData._flightsInfoArray objectAtIndex:sender.tag];
    if (info._selectedCabin._rule == nil) {
        ASIFormDataRequest * theRequest = [InterfaceClass searchRule:[info._flightNo substringToIndex:2] withCabin: info._selectedCabin._cabinCode withTime:[info._startDate substringToIndex:11] withSpecialFlightNum:info._selectedCabin._specialFlightNum];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onRulePaseredResult:) Delegate:self needUserType:Default];
    }
    else {
        [UIAlertView alertViewWithMessage:info._selectedCabin._rule :@"退改签规则"];
    }

}
- (void)onRulePaseredResult:(NSDictionary *)relustDic
{
    FlightInfo * info = [self.orderInfoData._flightsInfoArray objectAtIndex:selectFlightInfoIndex];
    CabinInfo * cabin = info._selectedCabin;
    cabin._rule = [NSString stringWithFormat:@"%@",[relustDic objectForKey:@"rule"]];
    [UIAlertView alertViewWithMessage:cabin._rule :@"退改签规则"];
}
- (void)orderPay:(NSString *)payType
{
    NSString * actualPrice = [NSString stringWithFormat:@"%d",[actualPriceLab.text intValue]];
    NSString * lcdCoinPrice =  [NSString stringWithFormat:@"%d",[myField.text intValue]];
    
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""])
    {
        actualPrice = [NSString stringWithFormat:@"%d",totalPrice];
        lcdCoinPrice = @"0";
    }
    
    ASIFormDataRequest * theRequest = [InterfaceClass getMessageState:[UserInfo sharedUserInfo].userID withOrderId:self.orderInfoData._orderInfo._orderId withPayMoney:actualPrice withPayCoin:lcdCoinPrice withPayType:payType];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getMessageStateResult:) Delegate:self needUserType:NoMember];
}

- (void)getMessageStateResult:(NSDictionary *)dic
{
    NSString * orderInfo  = nil;
    if ([[dic objectForKey:@"statusCode"] intValue] == 0) {
        orderInfo  = [NSString stringWithFormat:@"%@",[dic objectForKey:@"packets"]];
        if ([orderInfo length] <10) {
            orderInfo = nil;
        }
    }
    
    if (self.myMode == Alix) {
        if (orderInfo) {
            NSString *appScheme = @"FlightProject";
            [[AlipaySDK defaultService] payOrder:orderInfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                
                self.myMode = AlixPayEnd;
                self.requestURL =  resultDic;

                NSString * resultData = [NSString stringWithFormat:@"resultStatus={%@};memo={%@};result={%@}",[resultDic objectForKey:@"resultStatus"],[resultDic objectForKey:@"memo"],[resultDic objectForKey:@"result"]];
                NSLog(@"%@",resultData);
                
                ASIFormDataRequest * theRequest = [InterfaceClass getOrdersState:[UserInfo sharedUserInfo].userID withOrderId:self.orderInfoData._orderInfo._orderId withTimes:[NSString stringWithFormat:@"%d",++requestTimes] withPayType:@"0" withPackets:resultData];
                
                if ([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]] intValue] != 9000) {
                    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
                }
                else {
                    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getOrdersStateResult:) Delegate:self needUserType:Default];
                }
            }];
        }

        
//        if (orderInfo) {
//            NSString *appScheme = @"FlightProject"; 
//            AlixPay * alixpay = [AlixPay ];
//            int ret = [alixpay pay:orderInfo applicationScheme:appScheme];
//            if (ret == kSPErrorAlipayClientNotInstalled) {
//                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
//                                                                     message:@"您还没有安装支付宝客户端，请安装后进行支付。\n点击确定，立即安装。" 
//                                                                    delegate:self 
//                                                           cancelButtonTitle:@"取消" 
//                                                           otherButtonTitles:@"确定",nil];
//                [alertView setTag:123];
//                [alertView show];
//                [alertView release];
//            }
//            else if (ret == kSPErrorSignError) {
//                NSLog(@"签名错误！");
//            }
//        }
        
        return;
    }
    if (self.myMode == Union) {
        if (orderInfo) {
//            //[UPPayPlugin test:orderInfo SystemProvide:@"00000001" SPID:@"0001" withViewController:self Delegate:self];
//            [UPPayPlugin startPay:orderInfo SystemProvide:@"10941000" SPID:@"0190" withViewController:self Delegate:self];
//            [UPPayPlugin startPay:orderInfo sysProvide:nil spId:nil mode:UPPayMode viewController:self delegate:self];
            [UPPayPlugin startPay:orderInfo mode:UPPayMode viewController:self delegate:self];

        }
        return;
    }
    if (self.myMode == Weixin)
    {
        [WeiXinExport sendPay:dic];
    }
}
-(void)weixinPayResp:(PayResp *)resp//微信支付结果通知
{
    NSString * reutrnResp = resp.returnKey;
    NSLog(@"weixinPayResp:%@",reutrnResp);
    reutrnResp = @"failure";
    if (resp.errCode == WXSuccess)
    {
        reutrnResp = @"success";
    }
    
    self.myMode = WeixinEnd;
    self.requestURL =  resp;


    ASIFormDataRequest * theRequest = [InterfaceClass getOrdersState:[UserInfo sharedUserInfo].userID withOrderId:self.orderInfoData._orderInfo._orderId withTimes:[NSString stringWithFormat:@"%d",++requestTimes] withPayType:@"5" withPackets:reutrnResp];
    if (resp.errCode == WXSuccess) {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getOrdersStateResult:) Delegate:self needUserType:Default];
    }
    else {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
    }
}

- (void)parseURL:(NSDictionary *)resultDic application:(UIApplication *)application {
    self.myMode = AlixPayEnd;
    self.requestURL =  resultDic;
    self.requestApplication = application;
    NSString * resultData = [NSString stringWithFormat:@"resultStatus={%@};memo={%@};result={%@}",[resultDic objectForKey:@"resultStatus"],[resultDic objectForKey:@"memo"],[resultDic objectForKey:@"result"]];
    NSLog(@"%@",resultData);
    
    ASIFormDataRequest * theRequest = [InterfaceClass getOrdersState:[UserInfo sharedUserInfo].userID withOrderId:self.orderInfoData._orderInfo._orderId withTimes:[NSString stringWithFormat:@"%d",++requestTimes] withPayType:@"0" withPackets:resultData];
    
    if ([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]] intValue] != 9000) {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
    }
    else {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getOrdersStateResult:) Delegate:self needUserType:Default];
    }
}
//- (void)parseURL:(NSURL *)url application:(UIApplication *)application
//{
//    self.myMode = AlixPayEnd;
//    self.requestURL =  url;
//    self.requestApplication = application;
//    NSString * urlStr = [[NSString stringWithFormat:@"%@",url] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",urlStr);
//    NSRange range = [urlStr rangeOfString:@"?"];
//    NSString * query = [urlStr substringFromIndex:range.location+1];
//    NSLog(@"%@",query);
//    NSDictionary * alixDic = [query JSONValue];
//    NSDictionary * data = [alixDic objectForKey:@"memo"];
//    NSString * resultStatus = [data objectForKey:@"ResultStatus"];
//    NSString * memo = [data objectForKey:@"memo"];
//    NSString * result = [data objectForKey:@"result"];
////    result = [result stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
////    result = [result stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
////    result = [result stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];
//    NSString * resultData = [NSString stringWithFormat:@"resultStatus={%@};memo={%@};result={%@}",resultStatus,memo,result];
//    NSLog(@"%@",resultData);
//
//    ASIFormDataRequest * theRequest = [InterfaceClass getOrdersState:[UserInfo sharedUserInfo].userID withOrderId:self.orderInfoData._orderInfo._orderId withTimes:[NSString stringWithFormat:@"%d",++requestTimes] withPayType:@"0" withPackets:resultData];
//    
//    if ([resultStatus intValue] != 9000) {
//        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
//    }
//    else {
//       [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getOrdersStateResult:) Delegate:self needUserType:Default];
//    }  
//}

-(void)UPPayPluginResult:(NSString*)result  // 银联支付结果回调
{    
    self.myMode = UnionPayEnd;
    self.unionPayResult = result;
    NSLog(@"UPPayPluginResult: %@",result);
    
    ASIFormDataRequest * theRequest = [InterfaceClass getOrdersState:[UserInfo sharedUserInfo].userID withOrderId:self.orderInfoData._orderInfo._orderId withTimes:[NSString stringWithFormat:@"%d",++requestTimes] withPayType:@"1" withPackets:result];
    if ([self.unionPayResult isEqualToString:@"success"]) {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getOrdersStateResult:) Delegate:self needUserType:Default];
    }
    else {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
    }
}

- (void)getOrdersStateResult:(NSDictionary *)dic
{
    if ((self.myMode == UnionPayEnd)  || (self.myMode == AlixPayEnd) || (self.myMode == WeixinEnd)) {

        GetPaymentInfoResphonse * paymentInfo = [GetPaymentInfoResphonse GetPaymentInfoResphonse:dic];
        
        if([paymentInfo.result isEqualToString:@"1"]){
            if (requestTimes == 1) {
                sleep(5);
            }
            else if (requestTimes == 2) {
                sleep(3);
            }
            else if (requestTimes < 11)  {
                sleep(2);
            }
            else {
                [self paySuccessFul:dic];
                return;
            }
            if (self.myMode == AlixPayEnd) {
                [self parseURL:requestURL application:requestApplication];
            }
            else if (self.myMode == UnionPayEnd) {
                [self UPPayPluginResult:self.unionPayResult];
            }
            else if (self.myMode == WeixinEnd) {
                [self weixinPayResp:requestURL];
            }
        }
        else {
            if ([paymentInfo.result isEqualToString:@"0"]||[paymentInfo.result isEqualToString:@"3"]) {
                [self paySuccessFul:dic];
            }
            else {
                [UIAlertView alertViewWithMessage:paymentInfo.message tag:0 delegate:nil];
            }
        }
        return;
        }
}
-(void) paySuccessFul:(NSDictionary *)dic
{
    
    
    myDelegate.payResultDelegate = nil;
    
    NSString * _cityName = self.queryDataModel._toCity._nameStr;
    NSString * _hotelCode = [DataClass selectFromHotelCityListWithCityName:self.queryDataModel._toCity._nameStr];
    NSString * _carCode = [DataClass selectFromCarRentalListWithCityName:self.queryDataModel._toCity._nameStr];
    
    SubmitOrderCarInfo * tempDataModel = nil;
    TicketQueryDataModel * tempHotelDataModel = nil;
    
    NSString * startDate = self.queryDataModel._arriveDate._nameCode; //[info._endTime substringToIndex:10];
    
    if (_hotelCode) {
        tempHotelDataModel = [[TicketQueryDataModel alloc] init];
        tempHotelDataModel._fromCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:_cityName  code:_hotelCode ];
        tempHotelDataModel._startDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateFormateTicketQuery:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"]] code:startDate ]; 
        tempHotelDataModel._arriveDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:1 type:3] code:[NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:1 type:1] ]; 
    }
    
    if (_carCode) {
        tempDataModel = [[SubmitOrderCarInfo alloc] init];
        tempDataModel._cityCode = _carCode;
        tempDataModel._toCityCode =_carCode;
        tempDataModel._fromDate =  [NSString stringWithFormat:@"%@ 10:00",[NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:1 type:1]] ;
        tempDataModel._toDate =  [NSString stringWithFormat:@"%@ 10:00",[NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:2 type:1]] ;
    }
    self.paySuccessVC = [[[PayForSuccessViewController alloc] init]  autorelease];
    paySuccessVC._messageTitle = [dic objectForKey:@"message"];
    paySuccessVC._CAFlight = [self isFlightNumCA];
    paySuccessVC._orderId = orderID;
//    NSInteger returnLcd = 0;
//    for (FlightInfo * info in self.orderInfoData._flightsInfoArray) {
//        returnLcd += [info._selectedCabin._returnLcdFee intValue];
//    }

    paySuccessVC._carQuery = tempDataModel;
    paySuccessVC._hotelQuery = tempHotelDataModel;
    [tempDataModel release];
    [tempHotelDataModel release];
    paySuccessVC._whoPaySuccess = Ticket;
    
    
    if ([ActivityTimerView shareTimerView]._isAactivation) {
         [self paySecondReturnPayCoin];
    }
    else
    {
        if ([[UserInfo sharedUserInfo].userID isEqualToString:@""] || [self.orderInfoData._orderInfo._returnLcdCurrency intValue] == 0) {
            paySuccessVC._message =@"重要提示：\n相关信息会发送短信与您确认。";
        }
        else {
            paySuccessVC._message =[NSString stringWithFormat:@"重要提示：\n1.相关信息会发送短信与您确认\n2.客户起飞后会返还%@个畅达币到您的畅达币账户。",self.orderInfoData._orderInfo._returnLcdCurrency] ;
        }
        
        [NavigationController pushViewController:self.paySuccessVC animated:YES];
        [self.paySuccessVC release];
    }
  
}

- (BOOL)isFlightNumCA
{
    BOOL isCA = NO;
    for (int i = 0; i < [self.orderInfoData._flightsInfoArray count]; i ++) {
        
        FlightInfo *cellDataInfo = [self.orderInfoData._flightsInfoArray objectAtIndex:i];
        NSLog(@"所选航班号：%@-%d", [cellDataInfo._flightNo substringToIndex:2], i);
        if ([[cellDataInfo._flightNo substringToIndex:2] isEqualToString:@"CA"]) {
            isCA = YES;
        }
    }
    return isCA;
}

- (void)paySecondReturnPayCoin
{
    ASIFormDataRequest * theRequest = [InterfaceClass paySecondReturnPayCoin:self.orderInfoData._orderInfo._orderId];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getReturnPayCoinResult:) Delegate:self needUserType:Default];
}

- (void)getReturnPayCoinResult:(NSDictionary *)dic
{
    
    NSString *activityLcd = [dic objectForKey:@"returnLcdCurrency"];
    if ([self.orderInfoData._orderInfo._returnLcdCurrency intValue] == 0) {
        paySuccessVC._message =@"重要提示：\n相关信息会发送短信与您确认。";
    }
    else {
        paySuccessVC._message =[NSString stringWithFormat:@"重要提示：\n1.相关信息会发送短信与您确认\n2.客户起飞后会返还%@个畅达币到您的畅达币账户。",self.orderInfoData._orderInfo._returnLcdCurrency] ;
    }
    paySuccessVC._retainLcdNum = activityLcd;
    paySuccessVC._actitySecond = [ActivityTimerView shareTimerView]._activitySecond;
    paySuccessVC._isActivity = YES;
//    paySuccessVC._message =[NSString stringWithFormat:@"重要提示：\n1.恭喜您，总计用时%@秒，多赚%d个畅达币！", [ActivityTimerView shareTimerView]._activitySecond, [self.orderInfoData._orderInfo._returnLcdCurrency intValue] + [activityLcd intValue]];
    
    [[ActivityTimerView shareTimerView] stopTimerView];
    [NavigationController pushViewController:self.paySuccessVC animated:YES];
    [self.paySuccessVC release];
}
@end
