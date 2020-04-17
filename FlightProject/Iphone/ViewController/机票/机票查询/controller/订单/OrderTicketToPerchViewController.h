
//
//  OrderTicketToPerchViewController.h
//  FlightProject
//
//  Created by 高鹏程 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyExtend.h"
#import "OrderTicketToPerchCell.h"
#import "OrderTicketInfoViewController.h"
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
#import "TicketQueryViewController.h"
#import "OrderByCardPayViewController.h"
#import "MemberOrderDetailResponse.h"

@class FlightSingleInfo;
@class FlightHardInfo;
@class OrderInfoDataModel;

@class OrderInfoDataModel ;

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

@interface OrderTicketToPerchViewController : RootViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UPPayPluginDelegate, UIAlertViewDelegate, UIActionSheetDelegate>
{
    UITableView *myTable;
    UISubTextField *myField;
    BOOL isSelect;
    BOOL isAllPayment;          //是否全部畅达币支付
    int flightNum;              //航程数量
    
    NSString *userID;
    NSString *orderID;
    
    AppDelegate *myDelegate;
    
    UIView * singleInfos;
    UIView * hardInfos;

    int totalPrice;             //总价
    int goPrice;                //去程票价
    int arrPrice;               //返程票价
    int totalAirportPrice;      //机建燃油费
    int oneAirportPrice;        //行程1机建燃油费
    int twoAirportPrice;        //行程1机建燃油费
    int insurancePrice;         //保险
    int ticketCount;            //机票个数
    int lcdPrice;               //可使用畅达币
    UISubLabel *actualPriceLab;    //实付金额
    
    NSInteger selectFlightInfoIndex;
}

@property (nonatomic,retain) UIView * headerView;
@property (nonatomic,retain) UIView * centerView;

@property (nonatomic, retain)UISubTextField *myField;
@property (nonatomic, assign)PayMode myMode;
@property (assign, nonatomic)NSInteger requestTimes;
@property (retain, nonatomic)id requestURL;
@property (retain, nonatomic)UIApplication * requestApplication;
@property (retain, nonatomic) NSString * unionPayResult;
@property (retain, nonatomic) AppDelegate *myDelegate;
@property (nonatomic,retain) OrderInfoDataModel * orderInfoData;
@property (nonatomic,retain) TicketQueryDataModel * queryDataModel;
@property (nonatomic,assign) BOOL isExpend; 

@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;

- (void)orderPay:(NSString *)payType;       //订单支付请求报文

@end