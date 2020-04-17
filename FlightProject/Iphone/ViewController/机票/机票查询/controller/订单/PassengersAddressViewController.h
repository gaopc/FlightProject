//
//  PassengersAddressViewController.h
//  FlightProject
//
//  Created by lidong  cui on 12-10-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassengersAddressCell.h"
#import "PassengerAddressDataResponse.h"

//@class PassengerAddressDataResponse;
@class TicketOrderInfoViewController;
@class MemberHomeViewController;
@class MemberOrderPayInfoViewController;
@interface PassengersAddressViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,PassengersAddressDelegate>
{
    UIButton *passAddressButton; //新增地址;
    UIButton *submitButton; //添加乘机人;
    PassengerAddressDataResponse *passeAddressData;
@public	
	TicketOrderInfoViewController *memberVC;
	MemberHomeViewController *memberVC1;
        MemberOrderPayInfoViewController *memberVC2;
    BOOL isRequestList;
}

@property (nonatomic,retain) NSMutableArray * addressDataArray;
@property (nonatomic,retain) UITableView *a_tableView;
@property (nonatomic,assign) int sourceType;
@property (nonatomic,retain) PassengerAddressItem * addressItem;
@property (nonatomic,retain) UISubLabel *promptlable;
-(void)editClick:(id)sender;//点击编辑按钮
-(void)addAddressOverWithAddressItem:(PassengerAddressItem *)infoItem;


@end
