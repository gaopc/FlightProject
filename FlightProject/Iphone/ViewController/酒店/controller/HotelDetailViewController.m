//
//  HotelDetailViewController.m
//  FlightProject
//
//  Created by admin on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelDetailViewController.h"
#import "HotelQueryDataResponse.h"
#import "HotelPassengerDataResponse.h"
#import "SubmitOrderHotel.h"
#import "InterfaceClass.h"
#import "PayForSuccessViewController.h"
#import "DataClass.h"
#import "RecommendClass.h"
#import "HotelQueryCreditCard.h"
#import "NSDate+convenience.h"

@interface HotelDetailViewController ()

@end

@implementation HotelDetailViewController
@synthesize onHotelQueryCreditCard,hotelInfo,hotelRoomType,checkInDate,checkOutDate,passInfoArray,creditCardInfo,lcdValue,lcdRate,lcdActivityId;
@synthesize roomCount,connectorMobile,retentionTime;
@synthesize checkCity,_ticketList,_carList;
- (void)dealloc
{
    bottomButton = nil;
    self.onHotelQueryCreditCard = nil;
    self.hotelInfo = nil;
    self.hotelRoomType = nil;
    self.checkInDate = nil;
    self.checkOutDate = nil;
    self.passInfoArray = nil;
    self.roomCount = nil;
    self.connectorMobile = nil;
    self.retentionTime = nil;
    self.creditCardInfo = nil;
    self.checkCity = nil;
    self._ticketList = nil;
    self._carList = nil;
    self.lcdValue = nil;
    self.lcdRate = nil;
	self.lcdActivityId = nil;
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
    self.title = @"订单确认";
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, ViewWidth, ViewHeight-44-15-50) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
    
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, ViewHeight-44-50-5, 300, 5) image:[UIImage imageNamed:@"分割线.png"]]];
    
    bottomButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(92, ViewHeight-44-50+5, 136, 33) backImage:[UIImage imageNamed:@"提交订单.png"] target:self action:@selector(bottomClick:)];
    [self.view addSubview:bottomButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - Table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return [self.passInfoArray count];
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return 100;
                break;
            case 1:
                return 290;
                break;
                
            default:
                return 0;
                break;
        }
    }
    else if (indexPath.section == 1){
        return 25;
    }
    else if (indexPath.section == 2){
        return 45;
    }
    else {
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = [NSString stringWithFormat:@"identifier%d%d", indexPath.section, indexPath.row];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) 
        {
            MemberHotelDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberHotelDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            int aTotalPrice;
            (((int)(self.hotelRoomType._totalPrice*100))%100)?(aTotalPrice = (int)self.hotelRoomType._totalPrice+1):(aTotalPrice = (int)self.hotelRoomType._totalPrice);
            //cell._hotelInfo.text = [NSString stringWithFormat:@"%@:%@￥%d+%@",self.hotelInfo._hotelName,self.hotelRoomType._type,aTotalPrice,self.hotelRoomType._breakfast];
            //cell._hotelInfo.text = [NSString stringWithFormat:@"%@:%@",self.hotelInfo._hotelName,self.hotelRoomType._type];
            cell._hotelInfo.text = [NSString stringWithFormat:@"%@:%@￥%d",self.hotelInfo._hotelName,self.hotelRoomType._type,aTotalPrice];
//            cell._hotelInfo.text = self.hotelInfo._hotelName;
            int aLcdCurrency=0;
            int atotalPrice=0;
            (((int)([self.onHotelQueryCreditCard.lcdCurrency floatValue]*100))%100)?(aLcdCurrency = (int)[self.onHotelQueryCreditCard.lcdCurrency floatValue]+1):(aLcdCurrency = (int)[self.onHotelQueryCreditCard.lcdCurrency floatValue]);
            (((int)([self.onHotelQueryCreditCard.totalPrice floatValue]*100))%100)?(atotalPrice = (int)[self.onHotelQueryCreditCard.totalPrice floatValue]+1):(atotalPrice = (int)[self.onHotelQueryCreditCard.totalPrice floatValue]);
            cell._lcdCurrency.text = [NSString stringWithFormat:@"返 %d",aLcdCurrency];
            cell._totelMoney.text = [NSString stringWithFormat:@"%d",atotalPrice];
            if ([[UserInfo sharedUserInfo].userID isEqualToString:@""] || aLcdCurrency == 0) { // zxt 20121029 添加非会员预订显示效果
                cell._returnLcdView.hidden = YES;
            }
            return cell;
        }
        else {
            MemberHotelInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberHotelInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell._hotelName.text = self.hotelInfo._hotelName;
                cell._hotelAddress.text = self.hotelInfo._address;
                cell._checkInDate.text = self.checkInDate;
                cell._checkOutDate.text = self.checkOutDate;
            }
            return cell;
        }
    }
    else if (indexPath.section == 1)
    {
        NSLog(@"%d",[self.passInfoArray count]);
        MemberHotelPeopleInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[MemberHotelPeopleInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell._peopleName.text = ((HotelPersonnelInfo*)[self.passInfoArray objectAtIndex:indexPath.row])._name;
        }
        return cell;
    }
    else if (indexPath.section == 2)
    {
        MemberHotelTelePhoneCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[MemberHotelTelePhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell._telNum.text = self.connectorMobile;
        }
        return cell;
    }
    else
    {
        MemberEndCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[MemberEndCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell点击事件");
}

#pragma mark - self click

- (void)bottomClick:(id)sender
{
    SubmitOrderHotel *submitOrderHotel = [[SubmitOrderHotel alloc] init];
    submitOrderHotel._userId = [UserInfo sharedUserInfo].userID;
    submitOrderHotel._roomCount = self.roomCount;
    submitOrderHotel._guestNames = @"";
    for(int i =0;i<[self.passInfoArray count];i++)
    {
        if(i!=0)
        {
            submitOrderHotel._guestNames = [submitOrderHotel._guestNames stringByAppendingString:@"&"];
        }
        submitOrderHotel._guestNames = [submitOrderHotel._guestNames stringByAppendingString:(NSString*)(((HotelPersonnelInfo*)[self.passInfoArray objectAtIndex:i])._name)];
    }
    submitOrderHotel._connectorMobile = self.connectorMobile;
    
    if([[self.retentionTime componentsSeparatedByString:@"次日"] count] == 1)//18:00-21:00情况
    {
        self.retentionTime = [self.retentionTime stringByReplacingOccurrencesOfString:@"次日" withString:@""];
        NSArray *array = [self.retentionTime componentsSeparatedByString:@"-"];
        submitOrderHotel._arriveTimeEarly = [NSString stringWithFormat:@"%@ %@",self.checkInDate,[array objectAtIndex:0]];
        submitOrderHotel._arriveTimeLate = [NSString stringWithFormat:@"%@ %@",self.checkInDate,[array objectAtIndex:1]];
    }
    else if([[self.retentionTime componentsSeparatedByString:@"次日"] count] == 2)//22:00-次日1:00情况
    {
        self.retentionTime = [self.retentionTime stringByReplacingOccurrencesOfString:@"次日" withString:@""];
        NSArray *array = [self.retentionTime componentsSeparatedByString:@"-"];
        NSDate *date = [NSDate dateFromString:self.checkInDate];
        NSDate *aDate = [NSDate dateafterDay:date day:1];
        submitOrderHotel._arriveTimeEarly = [NSString stringWithFormat:@"%@ %@",self.checkInDate,[array objectAtIndex:0]];
        submitOrderHotel._arriveTimeLate = [NSString stringWithFormat:@"%@ %@",[NSDate dateCode:aDate],[array objectAtIndex:1]];
    }
    else//次日1:00-次日4:00情况
    {
        self.retentionTime = [self.retentionTime stringByReplacingOccurrencesOfString:@"次日" withString:@""];
        NSArray *array = [self.retentionTime componentsSeparatedByString:@"-"];
        NSDate *date = [NSDate dateFromString:self.checkInDate];
        NSDate *aDate = [NSDate dateafterDay:date day:1];
        submitOrderHotel._arriveTimeEarly = [NSString stringWithFormat:@"%@ %@",[NSDate dateCode:aDate],[array objectAtIndex:0]];
        submitOrderHotel._arriveTimeLate = [NSString stringWithFormat:@"%@ %@",[NSDate dateCode:aDate],[array objectAtIndex:1]];
    }
    
    submitOrderHotel._roomTypeId = self.hotelRoomType._roomTypeId;
    submitOrderHotel._hotelId = self.hotelInfo._hotelId;
    submitOrderHotel._checkInDate = self.checkInDate;
    submitOrderHotel._checkOutDate = self.checkOutDate;
    submitOrderHotel._totalPrice = self.onHotelQueryCreditCard.totalPrice;
    submitOrderHotel._lcdCurrency = self.hotelRoomType._totalLcdFee;//self.onHotelQueryCreditCard.lcdCurrency;// zxt 20130628 王鹏建议网站手机端统一，提交单个房间返还畅达币数量
    submitOrderHotel._vouchMoney = self.onHotelQueryCreditCard.money;
    submitOrderHotel._vouchSetType = [NSString stringWithFormat:@"%@",self.onHotelQueryCreditCard.vouchSetType];
    if([self.onHotelQueryCreditCard.vouchSetType isEqualToString:@"0"])
    {
        submitOrderHotel._username = @"";
        submitOrderHotel._idCard = @"";
        submitOrderHotel._bankIdCard = @"";
        submitOrderHotel._bankId = @"";
        submitOrderHotel._validityDate = @"";
        submitOrderHotel._cVV2Code = @"";
    }
    else
    {
        submitOrderHotel._username = self.creditCardInfo._username;
        submitOrderHotel._idCard = self.creditCardInfo._idCard;
        submitOrderHotel._bankIdCard = self.creditCardInfo._bankIdCard;
        submitOrderHotel._bankId =self.creditCardInfo._bankId;
        submitOrderHotel._validityDate = self.creditCardInfo._validityDate;
        submitOrderHotel._cVV2Code = self.creditCardInfo._cVV2Code;
    }
    
    
    submitOrderHotel._guestType = self.hotelRoomType._guestType;
    submitOrderHotel._ratePlanId = [NSString stringWithFormat:@"%d",self.hotelRoomType._ratePlanId];
    submitOrderHotel._breakfast = self.hotelRoomType._breakfast;
    submitOrderHotel._userType = @"04";
    submitOrderHotel._lcdRate = self.lcdRate;
    submitOrderHotel._lcdValue = self.lcdValue;
    submitOrderHotel._lcdActivityId = self.lcdActivityId;
    
    ASIFormDataRequest * theRequest = [InterfaceClass submitOrderHotel:submitOrderHotel];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSubmitOrderHotelPaseredResult:) Delegate:self needUserType:NoMember];
    [submitOrderHotel release];
    
}

-(void)onSubmitOrderHotelPaseredResult:(NSDictionary*)resultDic
{
//    if(![resultDic objectForKey:@"statusCode"])
//    {
//        [UIAlertView alertViewWithMessage:[resultDic objectForKey:@"message"]];
//    }
//    NSLog(@"%@",[resultDic objectForKey:@"updateTime"]);
    // 成功
    
    NSString * _hotelName = self.checkCity;
    NSString * _checkOutDate = self.checkOutDate;
    NSString * _carCode = [DataClass selectFromCarRentalListWithCityName:_hotelName];
    NSString * _ticketCityCode = [DataClass selectFromAirportCityListWithCityName:_hotelName];

    
    TicketQueryDataModel * tempDataModel = nil;
    SubmitOrderCarInfo * tempCarDataModel = nil;
    NSString * startDate = _checkOutDate;
    if (_ticketCityCode) {
        tempDataModel = [[TicketQueryDataModel alloc] init];
        tempDataModel._fromCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:_hotelName  code:_ticketCityCode ];
        tempDataModel._startDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateFormateTicketQuery:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"]] code:startDate ];   
        tempDataModel._arriveDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:Delay_Days type:3] code:[NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:Delay_Days type:1] ]; 
        tempDataModel._flightType = 1;
        tempDataModel._transitCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:@""  code:@""  ];
    }
    
    if (_carCode) {
        tempCarDataModel = [[SubmitOrderCarInfo alloc] init];
        tempCarDataModel._cityCode =_carCode;
        tempCarDataModel._toCityCode =_carCode;
        tempCarDataModel._fromDate =  [NSString stringWithFormat:@"%@ 10:00",[NSDate dateafterDay:[NSDate dateFromString:self.checkInDate withFormat:@"yyyy-MM-dd"] day:1 type:1]] ;
        tempCarDataModel._toDate =  [NSString stringWithFormat:@"%@ 10:00",[NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:2 type:1]] ;
    }
    
    PayForSuccessViewController *successVC = [[PayForSuccessViewController alloc] init];
    successVC._messageTitle = [resultDic objectForKey:@"message"];
    
    successVC._orderId = [resultDic objectForKey:@"orderId"];
    successVC._message = [NSString stringWithFormat:@"重要提示：\n到达酒店时，持有效证件，报预订时填写的入住人姓名办理入住。\n您可以致电400-6858-999取消订单。"];
    successVC._carQuery = tempCarDataModel;
    successVC._ticketQuery = tempDataModel;
    successVC._whoPaySuccess = Hotel;
    [tempDataModel release];
    [tempCarDataModel release];
    [NavigationController pushViewController:successVC animated:YES];
    [successVC release];

}


@end
