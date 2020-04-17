//
//  OrderTicketToPerchCell.h
//  FlightProject
//
//  Created by 高鹏程 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTicketToPerchCell : UITableViewCell
{
    UISubLabel *departureCity;
    UISubLabel *arrCity;
    UISubLabel *departureDate;
    UISubLabel *arrDate;
    UISubLabel *companyName;
    UISubLabel *departureTime;
    UISubLabel *roomLab;
    UIImageView *pointView;
    UIImageView *companyView;
    UISubLabel *_stateName;
}

@property (nonatomic, retain) UISubLabel *roomLab;
@property (nonatomic, retain) UISubLabel *departureCity;
@property (nonatomic, retain) UISubLabel *arrCity;
@property (nonatomic, retain) UISubLabel *departureDate;
@property (nonatomic, retain) UISubLabel *arrDate;
@property (nonatomic, retain) UISubLabel *companyName;
@property (nonatomic, retain) UISubLabel *departureTime;
@property (nonatomic, retain) UIImageView *pointView;
@property (nonatomic, retain) UIImageView *companyView;
@property (nonatomic, retain) UIImageView *stateImgView;
@property (nonatomic, retain) UIImageView *lineView;
@property (nonatomic, retain) UISubLabel *_stateName;
@end

@interface OrderTicketToPerchDoubleCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *roomLab;
@property (nonatomic, retain) UISubLabel *departureCity;
@property (nonatomic, retain) UISubLabel *arrCity;
@property (nonatomic, retain) UISubLabel *departureDate;
@property (nonatomic, retain) UISubLabel *arrDate;
@property (nonatomic, retain) UISubLabel *companyName;
@property (nonatomic, retain) UISubLabel *departureTime;
@property (nonatomic, retain) UISubLabel *planModels;      //飞机型号
@property (nonatomic, retain) UISubLabel *airport1;        //机场
@property (nonatomic, retain) UISubLabel *airport2;        //机场
@property (nonatomic, retain) UIButton *ruleButton;     //退改签规定
@property (nonatomic, retain) UIImageView *pointView;
@property (nonatomic, retain) UIImageView *companyView;
@property (nonatomic, retain) UIImageView *stateImgView;
@property (nonatomic, retain) UIImageView *lineView;
@property (nonatomic, retain) UISubLabel *_stateName;
@end

@interface OrderTicketPriceCell : UITableViewCell
{
    UISubLabel *totalLab;
    UISubLabel *returnCoinLab;
    UISubLabel *totalMoneyCoinLab;
    UISubLabel *moneyLab;
    UISubLabel *arrMoneyLab;
    UISubLabel *ticketLab;
    UISubLabel *fuelLab;
    UISubLabel *insuranceLab;
    
    UIImageView *areaView;
    
    UIButton *cellButton;
    UIButton *moveButton;
}

@property (nonatomic, retain) UISubLabel *totalLab;
@property (nonatomic, retain) UISubLabel *returnCoinLab;
@property (nonatomic, retain) UISubLabel *totalMoneyCoinLab;
@property (nonatomic, retain) UISubLabel *moneyLab;
@property (nonatomic, retain) UISubLabel *ticketLab;
@property (nonatomic, retain) UISubLabel *fuelLab;
@property (nonatomic, retain) UISubLabel *twoFuelLab;
@property (nonatomic, retain) UISubLabel *insuranceLab;
@property (nonatomic, retain) UISubLabel *arrMoneyLab;
@property (nonatomic, retain) UIImageView *areaView;
@property (nonatomic, retain) UIImageView *_arrowView;
@property (nonatomic, retain) UIButton *cellButton;
@property (nonatomic, retain) UIButton *moveButton;

@property (nonatomic,retain) UIView * _returnLcdView;

@end

@interface OrderTicketPrice2Cell : UITableViewCell
{
    UISubLabel *ownCoinLab;
    UISubLabel *remainderLab;
    
    UIImageView *areaView;
    
    UISubTextField *coinFiled;
}
@property (nonatomic, retain) UISubLabel *remainderLab;
@property (nonatomic, retain) UIImageView *areaView;
@property (nonatomic, retain) UISubLabel *ownCoinLab;
@property (nonatomic, retain) UISubTextField *coinFiled;
@end

@interface PayUIButton :UIView
@property (nonatomic,retain) UIButton * _button;
@property (nonatomic,assign) int _level;
+(PayUIButton *) buttonWithFrame:(CGRect)frame  tag:(NSInteger)tag Image:(UIImage *)img text:(NSString *)str;
@end
@interface OrderTicket3Cell : UITableViewCell
@property (nonatomic, retain) PayUIButton *rightButton;
@property (nonatomic, retain) PayUIButton *leftButton;
@property (nonatomic, retain) PayUIButton *cardButton;
@property (nonatomic, retain) PayUIButton *telButton;
@property (nonatomic, retain) PayUIButton *weixinButton;
@property (nonatomic, retain) PayUIButton *otherButton;

@property (nonatomic, retain) UIImageView *_backGroundView;
@end

@interface OrderTicket4Cell : UITableViewCell
{
     UIButton *otherButton;
}
@property (nonatomic, retain) UIButton *otherButton;
@end

@interface OrderTicketPayCell : UITableViewCell
@property (nonatomic, retain) UIButton *payButton;
@end

@interface OrderTicketCancelCell : UITableViewCell
@property (nonatomic, retain) UIButton *cancelButton;
@end