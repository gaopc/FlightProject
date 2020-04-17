//
//  StationInfoCell.h
//  FlightProject
//
//  Created by green kevin on 13-1-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StationInfoCell : UITableViewCell

@property (nonatomic, retain) UISubLabel *stationNameLabel;
@property (nonatomic, retain) UISubLabel *departureTimeLabel;
@property (nonatomic, retain) UISubLabel *arrivalTimeLabel;
@property (nonatomic, retain) UISubLabel *stopTimeLabel;

@property (nonatomic, retain) UISubLabel *numLabel;

@property (nonatomic, retain) UISubLabel *mileageLabel;
@property (nonatomic, retain) UISubLabel *stationNumLabel;
@property (nonatomic, retain) UISubLabel *days;
@property (nonatomic, retain) UIImageView *stationsDay1View;

@property (nonatomic, retain) UIView *bgView;

@property (nonatomic,retain)UISubLabel * thatDayLabel;     //是否是当天
@property (nonatomic, retain) UIImageView *stationsDay2View;
@property (nonatomic,retain)UISubLabel * thatDayLabel1;     //是否是当天
@end
