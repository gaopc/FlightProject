//
//  MemberHomeViewController.h
//  FlightProject
//
//  Created by longcd on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarPassengerListViewController.h"
#import "TrainModel.h"

@class MyLCDCoinDataResponse;
@class MyLCDCoinInfo;

@interface MemberHomeViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>
{	
	MyLCDCoinDataResponse *myLCDCoinDataResponse;
	int page;
	int availableLcdCurrency; //可用畅达币数量
	
	MyLCDCoinInfo *myLCDCoinInfo;
	UIImageView *cellImageView; //背景图片
    NSMutableArray *coinArray;
    CGSize  strSize;

}
@property (nonatomic,retain) UITableView *m_tableView;
@property (nonatomic,retain) NSMutableDictionary * dataDic;
@property (nonatomic,retain) NSArray * sectionArray;

@end
