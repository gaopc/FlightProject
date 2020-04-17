//
//  WeatherInfoViewController.h
//  FlightProject
//
//  Created by longcd on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeatherInfoCell : UITableViewCell
@property (nonatomic,retain) UIImageView * imageV1;
@property (nonatomic,retain) UIImageView * imageV2;
@property (nonatomic,retain) UILabel * weather;
@property (nonatomic,retain) UILabel * temperature;
@property (nonatomic,retain) UITextView * text;
@end

@interface OtherWeatherInfoCell : UITableViewCell
@property (nonatomic,retain) UILabel * situation;
@property (nonatomic,retain) UIImageView * imageV1;
@property (nonatomic,retain) UIImageView * imageV2;
@property (nonatomic,retain) UILabel * wind;
@property (nonatomic,retain) UILabel * temperature;
@end

@interface WeatherInfoViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, retain) WeatherInfo *startWeather;
@property(nonatomic, retain) WeatherInfo *arrivaWeather;
@property(nonatomic, retain) WeatherInfo *costumWeatherInfo;
@end
