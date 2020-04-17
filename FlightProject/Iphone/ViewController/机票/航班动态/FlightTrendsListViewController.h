//
//  FlightTrendsListViewController.h
//  FlightProject
//
//  Created by longcd on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightTrendsDetailViewController.h"
#import "GetFlightDynamicByStartArrival.h"
#import "AsyncImageView.h"

@interface FlightTrendsListCell : UITableViewCell
@property(nonatomic, retain) AsyncImageView *flightIcon;
@property(nonatomic, retain) UIImageView *flightStatus;
@property(nonatomic, retain) UIImageView *arrowImage;
@property(nonatomic, retain) UISubLabel *flightNum;
@property(nonatomic, retain) UISubLabel *flightStartCity;
@property(nonatomic, retain) UISubLabel *flightArrivalCity;
@property(nonatomic, retain) UISubLabel *flightStartTime;
@property(nonatomic, retain) UISubLabel *flightArrivalTime;
@end

@interface HeaderView : UIView
@property(nonatomic,retain)UIImageView *flightIcon;
@property(nonatomic,retain)UISubLabel *flighCompanyName;
@end

@interface FlightTrendsListViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)UITableView *myTableView;
@property (nonatomic,retain)NSDictionary *strImageDic;
@property (nonatomic,retain)GetFlightDynamicByStartArrival *flightDynamics;
@property (nonatomic,retain)NSString *flightNo;
@property (nonatomic,retain) NSMutableDictionary *airCompanyDic;//按航空公司排序存储航空列表信息
@property (nonatomic,retain) NSArray *airCompanyKeys;//该次查询显示的所有航空公司
@property (nonatomic,retain)UIButton *timeOrderBtn;
@property (nonatomic,retain)UIButton *flightOrderBtn;
@property (assign)NSInteger viewStatus;//1：起飞时间升序；2：起飞时间降序；3：航空公司升序；4：航空公司降序

-(void)setListOrder:(UIButton*)sender;
@end
