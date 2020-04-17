//
//  MyLCDCoinViewController.h
//  FlightProject
//
//  Created by lidong  cui on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyLCDCoinInfo;
@interface MyLCDCoinViewController:RootViewController<UITableViewDelegate,UITableViewDataSource>
{
	UISubLabel *availableLabel; //可用畅达币总数;
	UISubLabel *currencyLabel; //累计获取畅达币
	UISubLabel *useCurrencyLabel; //已用畅达币
	UISubLabel *notReturnCurrencyLabel; //未返还畅达币
	
	
	NSString * availableLcdCurrency; // 可用畅达币总数
	NSString * lcdCurrency; //累计获取畅达币
	NSString * useLcdCurrency; //已用畅达币
	NSString * notReturnLcdCurrency; //未返还畅达币数
	UIButton *explainButton; //畅达币使用规则
	
}

@property (nonatomic,retain) UITableView *l_tableView; //列表
@property(nonatomic, retain) NSMutableArray *myLcdDataArray; //我的畅达货币
@property (nonatomic,retain) MyLCDCoinInfo *myLCDCoinInfo; //畅达币
@end
