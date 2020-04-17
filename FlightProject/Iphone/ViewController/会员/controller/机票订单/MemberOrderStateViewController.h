//
//  MemberOrderStateViewController.h
//  FlightProject
//
//  Created by admin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTicketToPerchCell.h"
#import "MemberOrderDetailCell.h"
#import "OrderTicketInfoCell.h"
#import "MemberOrderDetailResponse.h"
#import "GetConfiguration.h"
#import "DevicePositionMapViewController.h"
#import "TicketNumberInfoResponse.h"
#import "MemberOrderReturnViewController.h"


typedef enum{
    NoPay,
    Payments,
    HaveTicket,
    TicketUsed,
    HaveRefund,
    TicketRefund,
    TicketCanceled
}OrderState;

@interface MemberOrderStateViewController : RootViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
{
    UITableView *myTable;
    BOOL isSelect;
    
    NSString *userID;
    NSString *orderID;
    
    OrderState myOrderState;
    
    int totalPrice;             //总价
    int goPrice;                //去程票价
    int arrPrice;               //返程票价
    int totalAirportPrice;      //机建燃油费
    int twoAirportPrice;        //行程2机建燃油费
    int oneAirportPrice;        //行程1机建燃油费
    int insurancePrice;         //保险
    int ticketCount;            //机票个数
    int passengersCount;        //乘客个数
    int flightCount;            //航程数量
    int adultCount;             //成人数量
    int childCount;             //儿童数量
    UISubLabel *actualPriceLab;    //实付金额
    int contactType;            //乘客机票显示的类型
    NSString *selectTicketNum;  //选中的票号
}

@property (nonatomic, retain) NSString *orderState; //订单状态
@property (nonatomic, retain) MemberOrderDetailResponse *orderDataInfo;
@property (assign) BOOL _notLoginUser;
@end