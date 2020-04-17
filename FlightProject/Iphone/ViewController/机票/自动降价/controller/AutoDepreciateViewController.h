//
//  AutoDepreciateViewController.h
//  FlightProject
//
//  Created by longcd on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  自动降价

#import <UIKit/UIKit.h>
@class NoAutoDpreciateView;
@class AutomaticallyInfo;
@class AutomaticallyDataResponse;
@interface AutoDepreciateViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>
{
	
	UISubLabel *cutTipNumberLabel;
	NoAutoDpreciateView *noAutoDpreciateView;
	
	AutomaticallyInfo *automaticallyItem;
	AutomaticallyInfo *automaticallyInfo;
	AutomaticallyDataResponse *automaticallyDR;
	
	UIView *tableTitleView;

	
}

@property(nonatomic, retain) NSMutableArray *autoDeprelist;
@property (nonatomic,retain) UITableView *a_tableView;
//外部引用重新引用数据源
- (void) againQuoteDataSource;
@end
