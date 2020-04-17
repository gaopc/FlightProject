//
//  HomeWeatherViewController.h
//  FlightProject
//
//  Created by gaopengcheng on 14-12-12.
//
//

#import <UIKit/UIKit.h>
#import "QueryWeatherInfo.h"

@interface HomeWeatherViewController : RootViewController <UITableViewDataSource, UITableViewDelegate>
{
    UILabel *weatherLab;
    UILabel *weatherTemperatureLab;
    UILabel *weatherQualityLab;
    UILabel *weatherWindLab;
    UILabel *weatherUpdateLab;
    UIImageView *weatherImageView;
    
    UITableView *myTable;
    UILabel *areaLab;
}
@property (nonatomic, retain) QueryWeatherInfo *_queryWeatherInfo;
@property (nonatomic, retain) NSString *_cityName;
@property (nonatomic, retain) NSString *_areaCode;
@property (nonatomic, retain) GetBasicInfoFromServer *server;
@property (assign) BOOL _isLoadView;
@property (assign) BOOL _isCityWeather;
@end
