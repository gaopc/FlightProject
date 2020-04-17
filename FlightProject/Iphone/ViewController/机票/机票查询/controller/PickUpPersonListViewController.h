//
//  PickUpPersonListViewController.h
//  FlightProject
//
//  Created by 张晓婷 on 14-4-15.
//
//

#import <UIKit/UIKit.h>

#import "PassengersInfoCell.h"
#import "PassengerInfoDataResponse.h"

@class PassengerInfoDataResponse;
@class TicketOrderInfoViewController;
@class MemberHomeViewController;

@interface PickUpPersonListViewController :  RootViewController<UITableViewDelegate,UITableViewDataSource,PassengersInfoDelegate>
{
	UIButton *passengerAddButton; //新增乘机人;
	UIButton *submitButton; //添加乘机人;
	PassengerInfoDataResponse *passengerInfoData;
	NSMutableDictionary *stateDictionary;
	
	
@public
	TicketOrderInfoViewController *memberVC;
	MemberHomeViewController *memberVC1;
	BOOL isRequestList;
}

@property (nonatomic,retain) id delegate;
@property (nonatomic,retain) NSMutableArray * passengersInfoArray;
@property (nonatomic,retain) UITableView *p_tableView;
@property (nonatomic,retain) UISubLabel *promptlable;
@property (nonatomic,retain) UISubLabel *cPersonLabel;
@property (nonatomic,assign) int sourceType;
@property (nonatomic,assign) int maximum;
@property (nonatomic,assign) int total;
@property (nonatomic,retain) PickPersonInfoItem *pickPersonItem;
@property (nonatomic,retain) PickPersonInfoItem *delPassInfoItem;
@property (nonatomic, retain) NSString *certDay;

//点击编辑按钮
-(void)editClick:(id)sender;


@end
