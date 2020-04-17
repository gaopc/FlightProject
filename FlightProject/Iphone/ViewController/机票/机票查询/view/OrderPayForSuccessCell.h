//
//  OrderPayForSuccessCell.h
//  FlightProject
//
//  Created by 高鹏程 on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface OrderPayForSuccessCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_message;
@property (nonatomic, retain) UISubLabel *_messageTitle;
@property (nonatomic, retain) UILabel *_activityLab;
@property (nonatomic, retain) UIButton *_shareActBtn;
@end

@interface OrderPayForSuccess1Cell : UITableViewCell
@property (nonatomic, retain) UIButton *leftButton;
@property (nonatomic, retain) UIButton *rightButton;
@property (nonatomic, retain) UIButton *fullButton;
@property (nonatomic, retain) UIButton *caButton;
@end

@interface OrderPayForSuccess2Cell : UITableViewCell
@end

@interface OrderPayForSuccess3Cell : UITableViewCell
@property (nonatomic, retain) UIButton *clickButton;
@property (nonatomic, retain) UISubLabel *cellTitle;
@property (nonatomic, retain) UISubLabel *cellPrice;
@property (nonatomic, retain) UISubLabel *cellStore;
@property (nonatomic, retain) UISubLabel *cellAddress;
@property (nonatomic, retain) UISubLabel *cellLine;
@property (nonatomic, retain) AsyncImageView *titleImage;
@end

@interface OrderPayForTicketCell : UITableViewCell
@property (nonatomic, retain) UIButton *clickButton;
@property (nonatomic, retain) UISubLabel *cellTitle;
@property (nonatomic, retain) UISubLabel *cellPrice;
@property (nonatomic, retain) UISubLabel *cellCities;
@property (nonatomic, retain) UISubLabel *celldate;
@property (nonatomic, retain) UIImageView *cellView;
@end

@interface HotelPayForSuccessCell : UITableViewCell
@end

@interface CarPayForSuccessCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *depositLable;
@end

