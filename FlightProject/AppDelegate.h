//
//  AppDelegate.h
//  FlightProject
//
//  Created by longcd on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
// 

#import <UIKit/UIKit.h>
#import "IphoneHomeViewController.h"
#import "WelecomViewContrller.h"
#import "WXApi.h"

#import <TencentOpenAPI/TencentApiInterface.h>

@class FlightTrendsDetailViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, WXApiDelegate,WeiboSDKDelegate>
{
    UINavigationController *navigationController;
//    GetBasicInfoFromServer *basicInfo;
    CGRect lastVCFrame;
    BOOL isLaunchOptions;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, assign) id payResultDelegate;
@property (assign) id exportDelegate;

@property (retain, nonatomic) FlightTrendsDetailViewController * viewController;

-(void)Initializers;

@end
