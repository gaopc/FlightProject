//
//  HotelBottomView.h
//  FlightProject
//
//  Created by green kevin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HotelBottomDelegate
@optional

-(void)mapClick:(id)sender;//点击地图按钮


@end

@interface HotelBottomView : UIView
{
	UIImageView *bottomView; //背景图片
	
	
	
}
@property (nonatomic, assign) id <HotelBottomDelegate> delegate;
@property (nonatomic,retain) UISubLabel * startDayLabel;
@property (nonatomic,retain) UISubLabel * endDayLabel;
@property (nonatomic, retain) UIButton* mapButton;
@property (nonatomic, retain) UIButton* listButton;

@property (nonatomic, retain) UIImageView *mapImgView; //按钮图片;
@property (nonatomic, retain) UIImageView *listImgView; //按钮图片;

@end
