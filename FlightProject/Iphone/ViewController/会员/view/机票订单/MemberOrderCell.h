//
//  MemberOrderCell.h
//  FlightProject
//
//  Created by admin on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberOrderCell : UITableViewCell
@property (nonatomic,retain) UIImageView * _stateImageV;
@property (nonatomic,retain) UIImageView * _company1ImageV;
@property (nonatomic,retain) UIImageView * _company2ImageV;

@property (nonatomic,retain) UISubLabel * _startDate;      //提交时间
@property (nonatomic,retain) UISubLabel * _startAirport;   //起飞机场
@property (nonatomic,retain) UISubLabel * _endAirport;     //降落机场
@property (nonatomic,retain) UISubLabel * _flightNo1;      //飞机型号
@property (nonatomic,retain) UISubLabel * _flightNo2;      //飞机型号
@property (nonatomic,retain) UISubLabel * _startTime1;     //起飞时间
@property (nonatomic,retain) UISubLabel * _startTime2;     //起飞时间
@property (nonatomic,retain) UISubLabel * _planeType;      //航线类型
@property (nonatomic,retain) UISubLabel * _ticketPrice;     //航程票价
@end
