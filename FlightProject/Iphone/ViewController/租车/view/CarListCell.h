//
//  CarListCell.h
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@class CarPackageBodyView;
@class CarPackageTitleView;

@interface CarListCell : UITableViewCell

@end

@interface CarListHeaderCell : UITableViewCell
@property (nonatomic,retain) AsyncImageView * _picImageV;
@property (nonatomic,retain) UISubLabel * _insurance;
@property (nonatomic,retain) UISubLabel * _typeName;
@property (nonatomic,retain) UISubLabel * _typeDesc;
@property (nonatomic,retain) UISubLabel * _preAuthorization;
@property (nonatomic,retain) UISubLabel * _dayPrice;
@property (nonatomic,retain) UISubLabel * _modeLevel;

@property (nonatomic, retain) CarPackageTitleView *_packageTitleView;
@property (nonatomic, retain) CarPackageBodyView *_packageBodyView;
@end

@interface CarListHeader2Cell : UITableViewCell
@property (nonatomic,retain) UISubLabel * _insurance;
@property (nonatomic,retain) UISubLabel * _preAuthorization;
@property (nonatomic,retain) UISubLabel * _modelLevelName;
@property (nonatomic,retain) UISubLabel * _modeLevel;
@end

@interface CarListBodyCell : UITableViewCell
@property (nonatomic,retain) AsyncImageView * _picImageV;
@property (nonatomic,retain) UISubLabel * _insurance;
@property (nonatomic,retain) UISubLabel * _typeName;
@property (nonatomic,retain) UISubLabel * _typeDesc;
@property (nonatomic,retain) UISubLabel * _preAuthorization;
@property (nonatomic,retain) UISubLabel * _dayPrice;
@property (nonatomic, retain) UIImageView *_areaView;
@property (nonatomic, retain) UIImageView *_dottedView;
@property (nonatomic, retain) UISubLabel *_payDays;

@property (nonatomic, retain) CarPackageTitleView *_packageTitleView;
@property (nonatomic, retain) CarPackageBodyView *_packageBodyView;
@end

@interface CarServicesCell : UITableViewCell
@property (nonatomic,retain) UIButton * _serviceButton;
@property (nonatomic,retain) UISubLabel * _serviceName;
@property (nonatomic,retain) UISubLabel * _servicePrice;
@end

@interface CarPackageTitleView : UIView
@property (nonatomic, retain) UIButton *_packageOpen;
@property (nonatomic, retain) UIImageView *_packageBackGround;
@end

@interface CarPackageBodyView : UIView
@property (nonatomic, retain) UIButton *_packageClose;
@property (nonatomic, retain) UIButton *_packageSelect;
@property (nonatomic, retain) UISubLabel *_packagePreferential;
@property (nonatomic, retain) UISubLabel *_packagePrice;
@property (nonatomic, retain) UISubLabel *_packageTotal;
@end

