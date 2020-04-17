//
//  CityListViewController.h
//  FlightProject
//
//  Created by longcd on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataClass.h"
#import "KeyBoardTopBar.h"

typedef enum{
    AirportCityList,    // 机票城市列表
    CarRentalList,    // 租车城市列表
    HotelCityList,     // 酒店城市列表
    AirportsList ,        // 机场列表
    WeatherList ,        // 机场列表
    TrainCityList,        // 火车站点列表
}CityType;

@class TicketQueryDataModelElem;
@class TaxiHomeDataModelElem;

@protocol CityListViewControllerDelegate <NSObject>

-(void)didSelectedCityFinshed:(id) city;

@end

// 城市列表类
@interface CityListViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
     UITableView * myTable;
    NSInteger typeNum;//目前选择的是：国内航空0，还是国际航空1；
}
@property (nonatomic,retain) NSArray * citysArray;
@property (nonatomic,retain) NSDictionary * citysDataDic;
@property (nonatomic,retain) NSArray * allKeys;
@property (nonatomic,assign) CityType cityType;
@property (nonatomic,assign) id delegate;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic,retain) NSString * hotName;
@property (nonatomic,retain) NSArray *allCitysArray;

@property (nonatomic,retain) UIButton *domesticCitiesBtn;//3.6期
@property (nonatomic,retain) UIButton *internationalCitiesBtn;//3.6期

@property (nonatomic,retain) UISubTextField * myTextField;

-(void) citysDicFromArray:(NSArray *)arr;


@end
