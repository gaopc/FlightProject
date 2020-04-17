//
//  SelectCreditCardViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetCreditCardList.h"
#import "UpdateCreditCard.h"
#import "OrderByCardPayViewController.h"
@class HotelGuaranteeViewController;

@interface SelectCreditCardViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    @public HotelGuaranteeViewController *hotelGuaranteeViewController;
    @public OrderByCardPayViewController *orderByCardPayViewController;
}
@property (nonatomic,retain) UITableView *myTableView;
@property (nonatomic,retain) GetCreditCardList *getCreditCardList;
@property (nonatomic,retain) UpdateCreditCard *creditCardInfo;
@property (nonatomic,retain) UISubLabel *titleLabel;
@property (nonatomic,assign) BOOL sourceType;//0，从我的航旅进入；1，其他页面进入
@end
