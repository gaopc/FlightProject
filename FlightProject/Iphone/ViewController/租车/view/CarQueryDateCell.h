//
//  CarQueryDateCell.h
//  FlightProject
//
//  Created by longcd on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarQueryDateCell : UITableViewCell
@property (nonatomic,retain) UIButton * _fromDataButton;
@property (nonatomic,retain) UIButton * _toDataButton;
@property (nonatomic,retain) UISubLabel * _fromDataOneLabel;
@property (nonatomic,retain) UISubLabel * _fromDataTwoLabel;
@property (nonatomic,retain) UISubLabel * _toDataOneLabel;
@property (nonatomic,retain) UISubLabel * _toDataTwoLabel;
@property (nonatomic,retain) UISubLabel * _fromTimeLabel;
@property (nonatomic,retain) UISubLabel * _toTimeLabel;
@end
