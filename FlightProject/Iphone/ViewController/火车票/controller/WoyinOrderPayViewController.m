//
//  WoyinOrderPayViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 15-6-4.
//
//

#import "WoyinOrderPayViewController.h"
#import "PayForSuccessViewController.h"


@interface WoyinOrderPayViewController ()<UPPayPluginDelegate,UIAlertViewDelegate>
{
    int requestTimes;
}
@property(nonatomic,retain)NSString * _UPPayPluginResult;
@end

@implementation WoyinOrderPayViewController
@synthesize _UPPayPluginResult;
- (void)dealloc
{
    self._UPPayPluginResult = nil;
    [super dealloc];
}
-(void)loadView
{
    [super loadView];
    UILabel * label = [UILabel labelWithTitle:@"列车开车前2小时外所购车票请您在25分钟内完成支付，开车前2小时内所购车票请您在5分钟内完成支付，否则订单会被自动取消!" frame:CGRectMake(10, ViewHeight-44-100, ViewWidth-20, 100) font:FontSize26 color:[UIColor colorWithWhite:0.2 alpha:1] alignment:NSTextAlignmentLeft];
    [label sizeToFit];
    [self.view addSubview:label];
    
    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"Trainpay.png"] frame:CGRectMake((ViewWidth-175)/2, ViewHeight-44-70+(70-38)/2, 175, 38) font:nil color:nil target:self action:@selector(pay)]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单确认";
    UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 0, 52, 30) backImage:nil target:nil action:nil];
    UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
}
-(void)pay
{
//    [self paySuccessFul:nil];
//    return;
//    [UPPayPlugin startPay:@"201506141015239854738" mode:UPPayMode viewController:self delegate:self];

    ASIFormDataRequest * theRequest = [InterfaceClass confirmTicketWithID:self._orderItem._orderId];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getconfirmTicketResult:) Delegate:self needUserType:NoMember];
}
-(void)getconfirmTicketResult:(NSDictionary *)result
{
    NSString * orderInfo  = nil;
    if ([[result objectForKey:@"statusCode"] intValue] == 0) {
        orderInfo  = [NSString stringWithFormat:@"%@",[result objectForKey:@"tn"]];
        if ([orderInfo length] <10) {
            orderInfo = nil;
        }
    }
    if (orderInfo) {
        [UPPayPlugin startPay:orderInfo mode:UPPayMode viewController:self delegate:self];
    }
}
-(void)UPPayPluginResult:(NSString*)result  // 银联支付结果回调
{
    NSLog(@"UPPayPluginResult: %@",result);
    requestTimes = 0;
    self._UPPayPluginResult = result;
    [self findOrderPayStatusInfo];
}
-(void)findOrderPayStatusInfo
{
    requestTimes ++;
    ASIFormDataRequest * theRequest = [InterfaceClass findOrderPayStatusInfoWithID:self._orderItem._orderId];
    if ([self._UPPayPluginResult isEqualToString:@"success"]) {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(findOrderPayStatusInfoResult:) Delegate:self needUserType:Default];
    }
    else {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
    }
}
-(void)findOrderPayStatusInfoResult:(NSDictionary *)result
{
    NSString * payStatus = [NSString stringWithFormat:@"%@",[result objectForKey:@"payStatus"] ];
    NSString * message = [NSString stringWithFormat:@"%@",[result objectForKey:@"message"] ];
    
    if([payStatus isEqualToString:@"1"]){
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
            [self paySuccessFul:result];
//            [UIAlertView alertViewWithMessage:message tag:0 delegate:nil];
            return;
        }
        [self findOrderPayStatusInfo];
    }
    else if ([payStatus isEqualToString:@"2"]) {
        [self paySuccessFul:result];
    }
    else {
        [UIAlertView alertViewWithMessage:message tag:0 delegate:nil];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) paySuccessFul:(NSDictionary *)resultDic
{
    NSString * _cityName = self._orderItem._toStation;
    NSLog(@"城市：%@", _cityName);
    NSString * _hotelCode = [DataClass selectFromHotelCityListWithCityName:_cityName];
    NSString * _carCode = [DataClass selectFromCarRentalListWithCityName:_cityName];
    
    NSLog(@"酒店：%@", _hotelCode);
    NSLog(@"租车：%@", _carCode);
    
    SubmitOrderCarInfo * tempDataModel = nil;
    TicketQueryDataModel * tempHotelDataModel = nil;
    NSString * startDate = self._orderItem._startDate;
    NSLog(@"时间：%@", startDate);
    
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
    
    PayForSuccessViewController *paySuccessVC = [[PayForSuccessViewController alloc] init];
    paySuccessVC._messageTitle = [resultDic objectForKey:@"message"];
    paySuccessVC._orderId = self._orderItem._orderId;
    paySuccessVC._trainData = self._orderItem;
    paySuccessVC._CAFlight = NO;
    
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
        paySuccessVC._message = [NSString stringWithFormat:@"取票单号：%@ \n您可以凭相关证件和取票单号到火车票售票窗口取票\n如需退票请拨打客服电话 4000133368", [resultDic objectForKey:@"ticketNo"]];
    }
    else {
        paySuccessVC._message = [NSString stringWithFormat:@"取票单号：%@ \n您可以凭相关证件和取票单号到火车票售票窗口取票\n如需退票请拨打客服电话 4000133368", [resultDic objectForKey:@"ticketNo"]];
    }
    
    paySuccessVC._carQuery = tempDataModel;
    paySuccessVC._hotelQuery = tempHotelDataModel;
    [tempDataModel release];
    [tempHotelDataModel release];
    paySuccessVC._whoPaySuccess = Train;
    [NavigationController pushViewController:paySuccessVC animated:YES];
    [paySuccessVC release];
}
@end
