//
//  MemberOrderPayViewController.h
//  FlightProject
//
//  Created by admin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyExtend.h"
#import "OrderTicketToPerchCell.h"
#import "MemberOrderPayInfoViewController.h"
#import "PayForSuccessViewController.h"

#import "ASIFormDataRequest.h"
#import "InterfaceClass.h"
#import "UPPayPluginDelegate.h"
#import "PayDataClass.h"

//#import "AlixPayOrder.h"
//#import "AlixPayResult.h"
//#import "AlixPay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"

#import "UPPayPlugin.h"

#import "JSON.h"

#import "MemberOrderDetailResponse.h"
#import "GetConfiguration.h"
#import "OrderByCardPayViewController.h"
//#import "AppDelegate.h"
@class AppDelegate;

typedef enum{
    Card,
    Phone,
    Alix,
    Union,
    Weixin,
    UnionPayEnd,
    AlixPayEnd,
    WeixinEnd,
    None
} PayMode;

@interface MemberOrderPayViewController : RootViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UPPayPluginDelegate, UIActionSheetDelegate>
{
    UITableView *myTable;
    UISubTextField *myField;
    BOOL isSelect;
    BOOL isAllPayment;          //是否全部畅达币支付
    
    NSString *userID;
    NSString *orderID;
    
    AppDelegate *myDelegate;
    
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
    int lcdPrice;               //可使用畅达币
    UISubLabel *actualPriceLab;    //实付金额
}

@property (nonatomic, retain)UISubTextField *myField;
@property (nonatomic, assign)PayMode myMode;
@property (assign, nonatomic)NSInteger requestTimes;
@property (retain, nonatomic) id  requestURL;
@property (retain, nonatomic)UIApplication * requestApplication;
@property (retain, nonatomic) NSString * unionPayResult;
@property (retain, nonatomic) AppDelegate *myDelegate;

@property (nonatomic, retain) MemberOrderDetailResponse *orderDataInfo;
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;

- (void)orderPay:(NSString *)payType;       //订单支付请求报文
@end