//
//  IphoneHomeView.h
//  FlightProject
//
//  Created by 张晓婷 on 14-12-5.
//
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "QueryWeatherInfo.h"

@interface ActivityItem : NSObject
@property (nonatomic,retain) NSString * _id;
@property (nonatomic,retain) NSString * _imageUrl;
@property (nonatomic,retain) NSString * _titile;
@property (nonatomic,retain) NSString * _content;
@property (nonatomic,retain) NSString * _state;

+(ActivityItem *) ActivityItemWithDic:(NSDictionary *)dic;

@end

@interface IphoneHomeView : UIView<UIScrollViewDelegate>
{
    UILabel *weatherCity;
    UILabel *weatherQuality;
    UILabel *weatherTemperature;
    UIImageView *weatherImage;
    int actImageCount;
}
@property (nonatomic,assign) id delegate;
@property (nonatomic, retain) QueryWeatherInfo *_weatherData;
@property (nonatomic, retain) UILabel *_userTitleLab;
-(void) activityViewWithList:(NSArray *)list;
- (void)changeUserTpye:(int)tpye withPointView:(OrderPointView *)view;
- (void)changeCityWeather:(QueryWeatherInfo *)queryData withCityName:(NSString *)cityName;

- (void)pauseActImage;
- (void)playActImage;
@end
