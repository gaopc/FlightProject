//
//  AppDelegate.m
//  LCDFlight
//
//  Created by longcd on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController;
@synthesize payResultDelegate;

- (void)dealloc
{
    [_window release];
    self.navigationController = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    if (IS_IPAD) { // 设备是ipad
        
    }
    else // 设备是iphone
    {
        [self Initializers];
    }
    [self.window makeKeyAndVisible];
    
    return YES;

}
//add by 倪邵峰 2012.6.26
-(void)Initializers
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    IphoneHomeViewController * rootVC = [[IphoneHomeViewController alloc] init];
    UINavigationController *navigationC = [[UINavigationController alloc] initWithRootViewController:rootVC] ;
    [rootVC release];
    [navigationC.navigationBar setNeedsDisplay1];
    self.window.rootViewController = navigationC;
    [navigationC release];
}
//add by 倪邵峰 2012.6.26

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//张晓婷 20120820  添加支付
-(BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [self parseURL:url application:application];
    return YES;
}

- (void)parseURL:(NSURL *)url application:(UIApplication *)application {
    
    if (self.payResultDelegate && [self.payResultDelegate respondsToSelector:@selector(parseURL:application:)]) {
        [self.payResultDelegate performSelector:@selector(parseURL:application:) withObject:url withObject:application];
    }
}
@end
