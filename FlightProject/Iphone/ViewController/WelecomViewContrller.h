//
//  WelecomViewContrller.h
//  FlightProject
//
//  Created by longcd on 12-11-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetBasicInfoFromServer.h"
#import "VersionView.h"
#import "AdvertisementView.h"


@interface WelecomViewContrller : RootViewController<CityListDelegate,UIActionSheetDelegate,UIAlertViewDelegate, VersionViewDelegate>
{
    UIActivityIndicatorView * activityIV;
    UILabel *secondLab;
    int times;
    NSTimer *timer;
}

@property (nonatomic,retain)GetBasicInfoFromServer * basicInfo ;
@property (nonatomic,retain) UIImageView * _backgroundImage;
@property (nonatomic,assign) BOOL _hasFirstImages;
@property (nonatomic, retain) UIImage *advertisementImage;
@end
