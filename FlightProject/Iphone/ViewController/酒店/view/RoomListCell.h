//
//  RoomListCell.h
//  FlightProject
//
//  Created by green kevin on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@protocol RoomListDelegate
@optional

-(void)preordainClick:(id)sender;//点击预订按钮
-(void)detailClick:(id)sender;//点击详情按钮

@end

@interface RoomListCell : UITableViewCell

@property (nonatomic, assign) id <RoomListDelegate> delegate;
@property (nonatomic,retain) UISubLabel * roomName;
@property (nonatomic,retain) UISubLabel * roomPrice;
@property (nonatomic,retain) UISubLabel * roomReturnLcdFee;
@property (nonatomic,retain) UIButton * roomButton;
@property (nonatomic,retain) UIImageView * roomNoButton;
@property (nonatomic,retain) UIButton * roomRuleButton;
@property (nonatomic,assign) BOOL _isExtend;


@property (nonatomic,retain) UIView *roomView;
@property (nonatomic,retain) UISubLabel *breakfastLabel;
@property (nonatomic,retain) UISubLabel *networkLabel;
@property (nonatomic,retain) UISubLabel *areaLabel;
@property (nonatomic,retain) UISubLabel *floorLabel;
@property (nonatomic,retain) UISubLabel *bedTypeLabel;

@property (nonatomic,retain) UIView * _returnLcdView;

@property (nonatomic,retain) AsyncImageView *hotelImageView;
@end
