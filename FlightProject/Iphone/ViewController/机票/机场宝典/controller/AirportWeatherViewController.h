//
//  AirportWeatherViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryWeatherInfo.h"
#import "AirportKnowledgeRootViewController.h"

@interface WeatherCell : UITableViewCell
@property(nonatomic,retain)UISubLabel *week;
@property(nonatomic,retain)UISubLabel *temperature;
@property(nonatomic,retain)UISubLabel *weather;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UIImageView *dottedLine;
@property(nonatomic,retain)UIImageView *backGroundImageView;
@end

@interface WeatherDetailCell : UITableViewCell
@property(nonatomic,retain)UIImageView *imageView;//天气图片
@property(nonatomic,retain)UISubLabel *updateTime;//更新时间
@property(nonatomic,retain)UISubLabel *weather;//天气
@property(nonatomic,retain)UISubLabel *temperature;//温度
@property(nonatomic,retain)UISubLabel *wind;//风力
@property(nonatomic,retain)UISubLabel *visibility;//能见度
@end

@interface AirportWeatherViewController : AirportKnowledgeRootViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)QueryWeatherInfo* queryWeatherInfo;
@property(nonatomic,retain)NSArray *weekArray;
@property(nonatomic,retain)UITableView *myTable;
@property(nonatomic,retain)AirportData *data;

@end
