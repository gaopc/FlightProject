//
//  OrderByCardPayViewController.h
//  FlightProject
//
//  Created by admin on 12-11-2.
//
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "UpdateCreditCard.h"
#import "OrderByCardPayCell.h"
#import "PayForSuccessViewController.h"
@class HotelQueryDataResponse;
#import "YearMonthView.h"

@interface OrderByCardPayViewController : RootViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,YearMonthViewDelegate>
@property (nonatomic,retain) UITableView *myTableView;
@property (nonatomic,assign) NSInteger viewNum;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic,retain) NSMutableArray *textFieldArray;
@property (nonatomic,retain) UpdateCreditCard *creditCardInfo;//展示的信用卡信息
@property (nonatomic,assign) BOOL deleteCreditCard;


@property (nonatomic, retain) NSString *cardPayMoney;//担保金额
@property (nonatomic, retain) NSString *lcdCurrency;//支付的畅达币金额
@property (nonatomic, retain) NSString *orderId;//订单号
@property (nonatomic, retain) NSString *telephone;

@property (nonatomic,retain) NSString * _flightArriveCode;
@property (nonatomic,retain) NSString * _flightArriveDateCode;
@property (nonatomic, retain) NSString *returnLcd; //返回畅达币金额

@property (assign) BOOL isCAFlight;
@end
