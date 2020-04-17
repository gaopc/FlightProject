//
//  HomeWeatherTableViewCell.h
//  FlightProject
//
//  Created by gaopengcheng on 14-12-19.
//
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface HomeWeatherTableViewCell : UITableViewCell
@property (nonatomic, retain) UILabel *_areaLab;
@property (nonatomic, retain) UILabel *_temperatureLab;
@property (nonatomic, retain) UILabel *_windLab;
@property (nonatomic, retain) UILabel *_weatherLab;
@property (nonatomic, retain) UILabel *_qualityLab;
@property (nonatomic, retain) UILabel *_updateLab;
@property (nonatomic, retain) AsyncImageView *_imgView;
@property (nonatomic, retain) UIButton *_areaBut;
@end

@interface HomeWeatherListTableViewCell : UITableViewCell
@property (nonatomic, retain) UILabel *_dateLab;
@property (nonatomic, retain) UILabel *_temperatureLab;
@property (nonatomic, retain) UILabel *_weatherLab;
@property (nonatomic, retain) AsyncImageView *_imgView;
@end
