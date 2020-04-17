//
//  WoyinOrderDetailViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 15-6-5.
//
//

#import "WoyinOrderDetailViewController.h"
#import "PayForSuccessViewController.h"

@interface WoyinOrderDetailViewController ()<UIAlertViewDelegate,UPPayPluginDelegate>
{
    int requestTimes;
}
@property(nonatomic,retain)NSString * _UPPayPluginResult;

@end

@implementation WoyinOrderDetailViewController
@synthesize _UPPayPluginResult;
- (void)dealloc
{
    self._UPPayPluginResult = nil;
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     订单状态: 待支付1
     出票中2
     已出票3
     出票失败4
     已取消5
     */
    switch ([self._orderItem._orderStatus intValue]) {
        case 1:
        {
            self.title = @"待支付";
            [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"取消订单.png"] frame:CGRectMake((ViewWidth-(136*2+10))/2, ViewHeight-44-100+(100-38)/2 + 25, 136, 33) font:nil color:nil target:self action:@selector(cancel)]];
            [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"Trainpay.png"] frame:CGRectMake((ViewWidth-(136*2+10))/2+136+10, ViewHeight-44-100+(100-38)/2 + 25, 136, 33) font:nil color:nil target:self action:@selector(pay)]];
            
            [self.view addSubview:[UILabel labelWithTitle:@"列车开车前2小时外所购车票请您在25分钟内完成支付，开车前2小时内所购车票请您在5分钟内完成支付，否则订单会被自动取消!" frame:CGRectMake(10, ViewHeight-44-100 + 5, ViewWidth-20, 50) font:FontSize26 color:[UIColor colorWithWhite:0.2 alpha:1] alignment:NSTextAlignmentLeft autoSize:YES]];
        }
            break;
        case 2:
        {
            self.title = @"出票中";
        }
            break;
        case 3:
        {
            self.title = @"已出票";
            [self.view addSubview:[UILabel labelWithTitle:@"如需退票请拨打客服电话4000133368，如给您带来不便，敬请谅解，谢谢！" frame:CGRectMake(10, ViewHeight-44-50, ViewWidth-20, 50) font:FontSize26 color:[UIColor colorWithWhite:0.2 alpha:1] alignment:NSTextAlignmentLeft autoSize:YES]];
        }
            break;
        case 4:
        {
            self.title = @"出票失败";
            [self.view addSubview:[UILabel labelWithTitle:@"很抱歉给您带来的不变，请拨打客服电话4000133368由专人为您处理" frame:CGRectMake(10, ViewHeight-44-50, ViewWidth-20, 50) font:FontSize26 color:[UIColor colorWithWhite:0.2 alpha:1] alignment:NSTextAlignmentLeft autoSize:YES]];
        }
            break;
        case 5:
        {
            self.title = @"已取消";
        }
            break;
        case 7:
        {
            self.title = @"有退票";
            [self.view addSubview:[UILabel labelWithTitle:@"如需退票请拨打客服电话4000133368，如给您带来不便，敬请谅解，谢谢！" frame:CGRectMake(10, ViewHeight-44-45, ViewWidth-20, 50) font:FontSize26 color:[UIColor colorWithWhite:0.2 alpha:1] alignment:NSTextAlignmentLeft autoSize:YES]];
        }
            break;
        case 8:
        {
            self.title = @"已退票";
        }
            break;
        default:
            break;
    }
}
-(void)pay
{
//    [self paySuccessFul:nil];
//    return;
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

-(void)cancel
{
    ASIFormDataRequest * theRequest = [InterfaceClass cancelOrderInfoWithID:self._orderItem._orderId];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(oncancelOrderInfoResult:) Delegate:self needUserType:Member];
}
-(void)oncancelOrderInfoResult:(NSDictionary *)result
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil
                                                   message:[NSString stringWithFormat:@"%@",[result objectForKey:@"message"]]
                                                  delegate:nil
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    NSString * statusCode = [NSString stringWithFormat:@"%@",[result objectForKey:@"statusCode"]];
    if ([statusCode intValue]==0) {
        self._orderItem._orderStatus = @"5";
        alert.delegate = self;
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
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
