//
//  AppDelegate.h
//  LCDFlight
//
//  Created by longcd on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IphoneHomeViewController.h"
#import "GetBasicInfoFromServer.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (assign) id payResultDelegate;
-(void)Initializers;
@end
