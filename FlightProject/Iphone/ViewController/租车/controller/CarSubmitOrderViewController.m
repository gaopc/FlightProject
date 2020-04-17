//
//  CarSubmitOrderViewController.m
//  FlightProject
//
//  Created by longcd on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarSubmitOrderViewController.h"
#import "PayForSuccessViewController.h"
#import "RecommendClass.h"
#import "DataClass.h"
@interface CarSubmitOrderViewController ()

@end

@implementation CarSubmitOrderViewController
//@synthesize _hotelList,_ticketList;
@synthesize queryDataModel;
- (void)dealloc
{
    bottomButton = nil;
    self.queryDataModel = nil;
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
    self.title = @"租车订单";
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, ViewWidth, ViewHeight-44-15-50) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    UIView * _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 1)];
    [_footerView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(13.0f, 0.0f, ViewWidth - 26, 1.0f) image:[UIImage imageNamed:@"carStoreAddressNameShadow.png"]]];
    myTable.tableFooterView = _footerView;
    [_footerView release];
    [self.view addSubview:myTable];
    
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, ViewHeight-44-50-5, ViewWidth - 20, 5) image:[UIImage imageNamed:@"分割线.png"]]];
    
    bottomButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth-175)/2, ViewHeight-44-50+5, 175, 38) backImage:[UIImage imageNamed:@"提交订单.png"] target:self action:@selector(bottomClick:)];
    [self.view addSubview:bottomButton];
    
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
    int temp = 1;
    if ([self.queryDataModel._submitOrderCarRes._serviceFee count] >0) {
        temp ++;
    }
    if ([self.queryDataModel._selectPackage intValue] == 1) {
        temp ++;
    }
    return temp;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
        {
            return [self.queryDataModel._submitOrderCarRes._serviceFee count]==0?1: [self.queryDataModel._submitOrderCarRes._serviceFee count]+ 1;
            break;
        }
        case 2:
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
                return 105;
                break;
            case 1:
                return 320;
                break;
            case 2:
                return 60;
                break;
                
            default:
                return 0;
                break;
        }
    }
    else if (indexPath.section == 1) {
        if ([self.queryDataModel._submitOrderCarRes._serviceFee count] == 0) {
            return 95;
        }
        else {
            return 30;
        }
    }
    else {
        return 95;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = [NSString stringWithFormat:@"identifier%ld%d", (long)indexPath.row, indexPath.section];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) 
        {
            MemberCarSubmitCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberCarSubmitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            if ([[UserInfo sharedUserInfo].userID isEqualToString:@""] || [self.queryDataModel._submitOrderCarRes._lcdFee intValue] == 0) { // zxt 添加非会员预订
                cell._memberLcdView.hidden = YES;
            }
            
            cell._lcdFee.text = [NSString stringWithFormat:@"返 %@", self.queryDataModel._submitOrderCarRes._lcdFee];
            cell._totalCarRentMoney.text = self.queryDataModel._submitOrderCarRes._totalCarRentMoney;
            //@"租金 ￥348 + 保险 ￥34 + 增值服务 ￥0 + 手续费 ￥34"
            NSInteger servicePrice = 0;
            for (CarServiceList * elem in self.queryDataModel._submitOrderCarRes._serviceFee) {
                servicePrice += [elem._servicePrice intValue];
            }
            if (servicePrice>0) {
                cell._priceInfo.text = [NSString stringWithFormat:@"租金 ¥%@ + 保险 ¥%@ + 增值服务 ¥%@ + 其他费用 ¥%@",self.queryDataModel._submitOrderCarRes._totalCarFee,self.queryDataModel._submitOrderCarRes._insuranceFee,[NSString stringWithFormat:  @"%ld",(long)servicePrice],self.queryDataModel._submitOrderCarRes._otherFee ];
            }
            else{
                cell._priceInfo.text = [NSString stringWithFormat:@"租金 ¥%@ + 保险 ¥%@ + 其他费用 ¥%@",self.queryDataModel._submitOrderCarRes._totalCarFee,self.queryDataModel._submitOrderCarRes._insuranceFee,self.queryDataModel._submitOrderCarRes._otherFee ];
            }

            return cell;
        }
        else if (indexPath.row == 1){
            MemberCarInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberCarInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            cell._peopleName.text = self.queryDataModel._name;
            cell._cellNum.text =self.queryDataModel._identityNumber;
            cell._telephone.text = self.queryDataModel._mobileNumber;
            
            if (self.queryDataModel._typeDesc.length == 0) {
                cell._typeName.frame = CGRectMake(50, 150, 250, 20);
            }
            
            cell._typeName.text = [NSString stringWithFormat:@"%@ %@", self.queryDataModel._typeName, self.queryDataModel._typeDesc];
//            cell._typeDesc.text = self.queryDataModel._typeDesc;
            cell._takeDate.text = self.queryDataModel._fromDateDsc;
            cell._takeShop.text = self.queryDataModel._storeCodeDsc;
            cell._returnDate.text = self.queryDataModel._toDateDsc;
            cell._returnShop.text = self.queryDataModel._toStoreCodeDsc;
            
            return cell;
        }
        else if (indexPath.row == 2){
            MemberCarInsuranceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberCarInsuranceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            cell._insuranceAmount.text = [NSString stringWithFormat:@"¥%@",self.queryDataModel._submitOrderCarRes._insuranceFee] ;

            return cell;
        }
        
    }
    else if (indexPath.section == 1) {
        
        if ([self.queryDataModel._submitOrderCarRes._serviceFee count] > 0) {
            if (indexPath.row == 0) {
                MemberCarServiceTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[MemberCarServiceTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                if ([self.queryDataModel._submitOrderCarRes._serviceFee count] > 0) {
                    cell._serviceLabel.text = @"增值服务";
                }
                //            else {
                //                cell._serviceLabel.text = @"优惠活动";
                //            }
                return cell;
            }
            else {
                MemberCarServiceInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[MemberCarServiceInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                CarService * service = [self.queryDataModel._submitOrderCarRes._serviceFee objectAtIndex:indexPath.row - 1];
                cell._serviceType.text = service._serviceName;
                cell._servicePrice.text = [NSString stringWithFormat:@"¥%@",service._servicePrice];
                
                
                //            if ([[SubmitOrderCarInfo sharedSubmitOrderCarInfo]._submitOrderCarRes._serviceFee count] > 0)
                //            {
                //                CarService * service = [[SubmitOrderCarInfo sharedSubmitOrderCarInfo]._carServiceList objectAtIndex:indexPath.row - 1];
                //                cell._serviceType.text = service._serviceName;
                //                cell._servicePrice.text = [NSString stringWithFormat:@"%@元",service._servicePrice];
                //            }
                //            else {
                //                CarActvity * activity = [[SubmitOrderCarInfo sharedSubmitOrderCarInfo]._carActvityList objectAtIndex:indexPath.row - 1];
                //                cell._serviceType.text = activity._actvityDesc;
                //            }
                return cell;
            }
        }
        else if ([self.queryDataModel._selectPackage intValue] == 1) {
            MemberCarPackageInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberCarPackageInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
    }
    else if (indexPath.section == 2) {
        MemberCarPackageInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[MemberCarPackageInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

//#pragma mark - UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    [NavigationController popViewControllerAnimated:YES];
//}

#pragma mark - self click
- (void)bottomClick:(id)sender
{
    ASIFormDataRequest * theRequest = [InterfaceClass submitOrderCarInfo:self.queryDataModel];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSubmitOrderCarInfoResult:) Delegate:self needUserType:NoMember];
//    [self onSubmitOrderCarInfoResult:nil];
}

-(void) onSubmitOrderCarInfoResult:(NSDictionary *)resultDic
{
    // 成功
    NSString * _carToCityCode = self.queryDataModel._toCityCode; // 还车城市
    NSArray * array = [DataClass selectFromCarRentalList];
    NSLog(@"%@",array);
    NSString * _carToCityName = [DataClass selectFromCarRentalListWithCityCode : _carToCityCode];
    NSString * _ticketCityCode = [DataClass selectFromAirportCityListWithCityName:_carToCityName];
    
    NSString * _carCityName = [DataClass selectFromCarRentalListWithCityCode : self.queryDataModel._cityCode];
    NSString * _hotelCityCode = [DataClass selectFromHotelCityListWithCityName:_carCityName];
    
    NSLog(@"%@,%@,%@,%@,%@,%@",_carToCityCode,_carToCityName,_ticketCityCode,self.queryDataModel._cityCode,_carCityName,_hotelCityCode);
    
    TicketQueryDataModel * tempDataModel = nil;
     TicketQueryDataModel * tempHotelDataModel = nil;
    NSString * toDate = [self.queryDataModel._toDate substringToIndex:10];
    NSString * fromDate = [self.queryDataModel._fromDate substringToIndex:10];
    if (_ticketCityCode) {
        tempDataModel = [[TicketQueryDataModel alloc] init];
        tempDataModel._fromCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:_carToCityName  code:_ticketCityCode ];
        tempDataModel._startDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateFormateTicketQuery:[NSDate dateFromString:toDate withFormat:@"yyyy-MM-dd"]] code:toDate ];   
        tempDataModel._arriveDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate dateFromString:toDate withFormat:@"yyyy-MM-dd"] day:Delay_Days type:3] code:[NSDate dateafterDay:[NSDate dateFromString:toDate withFormat:@"yyyy-MM-dd"] day:Delay_Days type:1] ]; 
        tempDataModel._flightType = SingleType;
        tempDataModel._transitCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:@""  code:@""  ];
    }
      
    if (_hotelCityCode) {
        tempHotelDataModel = [[TicketQueryDataModel alloc] init];
        tempHotelDataModel._fromCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:_carCityName  code:_hotelCityCode ];
        tempHotelDataModel._startDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateFormateTicketQuery:[NSDate dateFromString:fromDate withFormat:@"yyyy-MM-dd"]] code:fromDate ]; 
        tempHotelDataModel._arriveDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate dateFromString:fromDate withFormat:@"yyyy-MM-dd"] day:1 type:3] code:[NSDate dateafterDay:[NSDate dateFromString:fromDate withFormat:@"yyyy-MM-dd"] day:1 type:1] ]; 
    }

    PayForSuccessViewController * successFulVC = [[PayForSuccessViewController alloc] init];
    successFulVC._messageTitle = [resultDic objectForKey:@"message"];
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
        successFulVC._message = [NSString stringWithFormat:@"重要提示：\n1.取车时请携带本人有效身份证、驾照、本人信用卡/借记卡，取车时会冻结/刷取%@元租车预授权/押金\n2.如需取消订单，请您至少在预订取车时限开始前6小时致电神州租车客服400-6166-666。",self.queryDataModel._preAuthorization];
    }
    else {
         successFulVC._message = [NSString stringWithFormat:@"重要提示：\n1.取车时请携带本人有效身份证、驾照、本人信用卡/借记卡，取车时会冻结/刷取%@元租车预授权/押金\n2.如需取消订单，请您至少在预订取车时限开始前6小时登录客户端或隆畅达官网取消该订单或致电神州租车客服。",self.queryDataModel._preAuthorization];
    }
   
    successFulVC._orderId = [resultDic objectForKey:@"orderId"];
    successFulVC._ticketQuery = tempDataModel;
    successFulVC._hotelQuery = tempHotelDataModel;
    successFulVC._whoPaySuccess = Car;
    [tempDataModel release];
    [tempHotelDataModel release];
    [NavigationController pushViewController:successFulVC animated:YES];
    [successFulVC release];

}

@end
