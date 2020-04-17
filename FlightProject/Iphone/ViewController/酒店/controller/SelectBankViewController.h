//
//  SelectBankViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditCreditCardInfoViewController;

@interface SelectBankViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    @public EditCreditCardInfoViewController *editCreditCardInfoVC;
}
@property (nonatomic,retain) UITableView *myTableView;
@property (nonatomic,retain) NSString *payType;    //0：机票支付  1：酒店担保
@property (nonatomic,retain) NSArray *bankList;
@end
