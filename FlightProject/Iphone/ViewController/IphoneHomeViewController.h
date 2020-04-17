//
//  IphoneHomeViewController.h
//  FlightProject
//
//  Created by longcd on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "GetBasicInfoFromServer.h"
#import "TicketQueryViewController.h"
#import "FlightTrendsViewController.h"

#import "TicketHomeViewController.h"
#import "HotelHomeViewController.h"
#import "TaxiHomeViewController.h"
#import "MemberHomeViewController.h"
#import "HomePageAnimateView.h"
//#import "ETFirstAlertDelegate.h"

#import "ActivityViewController.h"
#import "GetConfiguration.h"
#import "MemberRegisterViewController.h"
#import "CallPhoneView.h"

#import "IphoneHomeView.h"
#import "HomeActivityDetailViewController.h"


@interface IphoneHomeViewController : RootViewController< UIActionSheetDelegate, CLLocationManagerDelegate>
{
    UISegmentedControl * segmentedControlL;
    UIButton * doneInKeyboardButton;
    UIView *newView;
    UIButton *helpBtton;
    UIButton *aboutButton;
    UIButton *opinionButton;
//    UIButton *variableButton;       //注册 登陆 会员
    UIButton *userButton;
    UIButton *loginButton;
    UIButton *registerButton;
    UIButton *moreButton;
    UIButton * coverImageButton;
    int userType;
    
    
}

@property (assign) BOOL isLaunchOptions;
@property (nonatomic, retain) QueryWeatherInfo *_queryWeatherInfo;
@property (nonatomic, retain) CLLocationManager *myLocationManager;
@property (nonatomic, retain) CLGeocoder *myGecoder;
@property (nonatomic, retain) CLLocation *myLocation;
@property (nonatomic, retain) NSString *_locationCity;
@property (nonatomic, retain) NSString *_loginType;
@end
