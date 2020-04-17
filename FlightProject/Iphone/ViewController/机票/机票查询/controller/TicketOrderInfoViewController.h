//
//  MyCustomViewController.h
//  FlightProject
//
//  Created by 晓婷 张 on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "OrderTicketToPerchViewController.h"
#import "QueryFlightTicket.h"
#import "TicketQueryViewController.h"
#import "PassengerInfoDataResponse.h"
#import "PassengerAddressDataResponse.h"
#import "PassengersInfoViewController.h"
#import "PassengersAddressViewController.h"
#import "SubmitOrderResponse.h"
#import "OrderTicketToPerchViewController.h"
#import "TicketOrderInfoView.h"
#import "KeyBoardTopBar.h"
#import "CustomUISwitch.h"
#import "TooltipView.h"

@interface OrderInfoDataModel : NSObject
@property (nonatomic,retain) NSMutableArray * _flightsInfoArray;
@property (nonatomic,retain) NSMutableArray * _passengerArray;
@property (nonatomic,retain) NSMutableArray * _pickUpPersonArray;

@property (nonatomic,retain) NSString * _contactorPhone;
@property (nonatomic,assign) BOOL _isBuyInsurance;
@property (nonatomic,assign) BOOL _isAcceptSevice;
@property (nonatomic,retain) NSString * _getItineraryType;
@property (nonatomic,retain) PassengerAddressItem * _postAddressItem;
@property (nonatomic,retain) SubmitOrderResponse * _orderInfo;
@property (nonatomic,assign) NSInteger _childCount; 
@property (nonatomic,assign) NSInteger _adlutCount;
@end

@interface TicketOrderItineraryCell : UITableViewCell
@property (nonatomic,retain) UIButton * _leftButton1;
@property (nonatomic,retain) UIButton * _leftButton2;
@property (nonatomic,retain) UIButton * _terminalButton;
@property (nonatomic,retain) UIButton * _mailButton;
@property (nonatomic,retain) UISubLabel * _mailAddressLabel;
@end

@interface TicketOrderInfoViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CustomUISwitchDelegate,UIAlertViewDelegate>
{
//    UIView * singleInfos;
//    UIView * hardInfos;
    UITableView * myTable;
//    UIView * footerViewBottomView;
    UISubTextField * contactorPhone;
    NSInteger selectFlightInfoIndex;
    
//    UIImageView *boxImgView;
    
    UIButton *cancelButton;
    UIButton *deleteButton;
    TooltipView *boxImgView;
    
    int  pickUpPersonType;//去程（单程）、返程
}
@property (nonatomic,retain) UIView * headerView;
@property (nonatomic,retain) UIView * centerView;
@property (nonatomic,retain) UIView * footerView;
@property (nonatomic,assign) BOOL isExpend; 
@property (nonatomic,retain) OrderInfoDataModel * orderInfoData;
@property (nonatomic,retain) TicketQueryDataModel * queryDataModel;
@property(nonatomic,retain) NSMutableArray * flightsInfoArray;

@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic,retain) OrderInfo * orderInfo;
@property (nonatomic,retain) NSMutableArray* shengPZArray;

- (void)cancelClick:(id)sender;

@end
