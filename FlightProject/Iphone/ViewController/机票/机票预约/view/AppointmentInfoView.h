//
//  AppointmentInfoView.h
//  FlightProject
//
//  Created by green kevin on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentInfoView : UIView
{
	UIImageView *flightSmallIcons; //起飞小图标
	UIImageView *arriveSmallIcons; //到达小图标

}

@property (nonatomic, retain) UISubLabel *flightLabel;
@property (nonatomic, retain) UISubLabel *arriveLabel;
@property (nonatomic, retain) UISubLabel *flightDateLabel;
@property (nonatomic, retain) UISubLabel *arriveDateLabel;
@property (nonatomic, retain) UISubLabel *saleLabel;
@property (nonatomic, retain) UISubLabel *submitDateLabel;

@end
