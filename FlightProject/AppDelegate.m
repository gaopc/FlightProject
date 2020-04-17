//
//  AppDelegate.m
//  FlightProject
//
//  Created by longcd on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


//无线网密码 thcn_zhang_bjonmc!

#import "AppDelegate.h"
#import "GetBasicInfoFromServer.h"
#include <CoreTelephony/CTTelephonyNetworkInfo.h>
#include <CoreTelephony/CTCall.h>

#import <TencentOpenAPI/TencentOAuth.h>

#import "TencentOpenAPI/QQApiInterface.h"
#import "QQAPIDemoEntry.h"
#import <AlipaySDK/AlipaySDK.h>


@interface WBBaseRequest ()
- (void)debugPrint;
@end

@interface WBBaseResponse ()
- (void)debugPrint;
@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController;

@synthesize payResultDelegate;
@synthesize viewController;

- (void)dealloc
{
    self.navigationController = nil;
    self.payResultDelegate = nil;
    self.viewController = nil;

    //[sinaWeiBoExport release];
    [_window release];
//    [basicInfo release];
//    basicInfo = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*-force_load $(SRCROOT)/FlightProject/sinaweibo_ios_sdk/libWeiboSDK.a $(SRCROOT)/FlightProject/支付/银联支付/libUPPayPlugin.a
     
     [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlSchemes]]  //判断urlSchemes是否安装
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlSchemes]]  //打开urlSchemes
     */
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    [WXApi registerApp:WeChatId withDescription:@"掌上航旅"];
    //self.sinaWeiBoExport = [SinaWeiBoExport initSinaWeiBoExport];
  
    NSLog(@"launchOptions:%@",launchOptions);
    if (launchOptions) {
        isLaunchOptions = YES;
    }
    
    [[UIApplication sharedApplication]registerForRemoteNotificationTypes: (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound)]; 
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];

    [self Initializers];
    
//    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//    CTCarrier *carrier = info.subscriberCellularProvider;
//    NSLog(@"carrier:%@", [carrier description]);

    //add by 崔立东 2012.10.08 判断用户是否自动登录
    NSNumber *audioLogin = [[NSUserDefaults standardUserDefaults]  objectForKey:keyAudioLogin];
	if(audioLogin){
        if ([audioLogin intValue]==1) {
           [UserInfo sharedUserInfo].userID = [[NSUserDefaults standardUserDefaults]  objectForKey:keyLoginUserID];
           [UserInfo sharedUserInfo].telePhone = [[NSUserDefaults standardUserDefaults]  objectForKey:keyLoginTelephone];
	       [UserInfo sharedUserInfo]._isAutoLogin = YES;
        }		
    }
    
//    if (launchOptions) {
//        [self application:application didReceiveRemoteNotification:launchOptions];
//    }
    
    [self.window makeKeyAndVisible];

    return YES;
}

-(void)Initializers
{
    IphoneHomeViewController * rootVC = [[IphoneHomeViewController alloc] init];
    UINavigationController *navigationC = [[UINavigationController alloc] initWithRootViewController:rootVC] ;
    rootVC.isLaunchOptions = isLaunchOptions;
    [rootVC release];
    self.navigationController = navigationC;
    [navigationC release];
    [navigationC.navigationBar setNeedsDisplay1];
    self.window.rootViewController = navigationC;
	[navigationC setNavigationBarHidden:YES];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"------1:%@", [deviceToken description]);
    NSString * tokenStr  = [deviceToken description];
    tokenStr = [tokenStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    tokenStr = [tokenStr stringByReplacingOccurrencesOfString:@">" withString:@""];
    [UserInfo sharedUserInfo].deviceToken = tokenStr;
    ASIFormDataRequest * theRequest = [InterfaceClass saveDeviceToken:tokenStr];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(saveDeviceToken) Delegate:nil needUserType:Default];
    
//    basicInfo = [[GetBasicInfoFromServer alloc] init];
//    [basicInfo getConfiguration:[UserInfo sharedUserInfo].deviceToken];
}
-(void)saveDeviceToken{}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo NS_AVAILABLE_IOS(3_0)
{
    if ([[self.navigationController.viewControllers lastObject] isKindOfClass:[ActivityViewController class]] || [[self.navigationController.viewControllers lastObject] isKindOfClass:[WelecomViewContrller class]])
    {
        return;
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    ActivityViewController *activityVC = [[ActivityViewController alloc] init];
    [self.navigationController pushViewController:activityVC animated:YES];
    [activityVC release];
}
//

//-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
//{
//    NSLog(@"%@",notification);
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   [[NSNotificationCenter defaultCenter] postNotificationName:@"hideKeyBoard" object:nil]; 
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
//    [[ActivityTimerView shareTimerView] pauseTimerView];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

//当应用程序入活动状态执行
- (void)applicationDidBecomeActive:(UIApplication *)application
{
//    [[ActivityTimerView shareTimerView] playTimerView];
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"XXX" object:nil]; 设置一个通知
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:@"XXX" object:nil]; 接收这个通知
   [[NSNotificationCenter defaultCenter] postNotificationName:@"hideKeyBoard" object:nil];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //[self.sinaWeiBoExport.mySinaweibo applicationDidBecomeActive];//sinaweibo
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
   [[NSNotificationCenter defaultCenter] postNotificationName:@"hideKeyBoard" object:nil]; 
}
-(BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString *str = [NSString stringWithFormat:@"%@",url];
    NSLog(@"%@",str);
    
//    return [TencentOAuth HandleOpenURL:url];
    if([[str substringToIndex:2] isEqualToString:@"wx"]) {
        return  [WXApi handleOpenURL:url delegate:self];
    }
    
    [self parseURL:url application:application];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSString *str = [NSString stringWithFormat:@"%@",url];
    NSLog(@"应用返回：%@", str);
    if([[str substringToIndex:2] isEqualToString:@"wx"]) {
        
        return  [WXApi handleOpenURL:url delegate:self];
    }
    else if([[str substringToIndex:2] isEqualToString:@"wb"]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
//    else if ([[str substringToIndex:13] isEqualToString:@"FlightProject"]) {
//        [self parseURL:url application:application];
//        return YES;
//    }
    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
    else if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [self parseURL:resultDic application:application];
        }];
        return YES;
    }
    else if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [self parseURL:resultDic application:application];
        }];
        return YES;
    }
    else {
#if __QQAPI_ENABLE__
        [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[QQAPIDemoEntry class]];
#endif
        
        if (YES == [TencentOAuth CanHandleOpenURL:url])
        {
            return [TencentOAuth HandleOpenURL:url];
        }
        return YES;
    }
}
- (void)parseURL:(NSDictionary *)resultDic application:(UIApplication *)application {
    
    if (self.payResultDelegate && [self.payResultDelegate respondsToSelector:@selector(parseURL:application:)]) {
        [self.payResultDelegate performSelector:@selector(parseURL:application:) withObject:resultDic withObject:application];
    }
}
//- (void)parseURL:(NSURL *)url application:(UIApplication *)application {
//    
//    if (self.alixPayResultDelegate && [self.alixPayResultDelegate respondsToSelector:@selector(parseURL:application:)]) {
//        [self.alixPayResultDelegate performSelector:@selector(parseURL:application:) withObject:url withObject:application];
//    }
//}
// ----微博

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
//        ProvideMessageForWeiboViewController *controller = [[[ProvideMessageForWeiboViewController alloc] init] autorelease];
//        [self.viewController presentModalViewController:controller animated:YES];
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = @"发送结果";
//        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
//                             response.statusCode, response.userInfo, response.requestUserInfo];
        
        NSString *messageStr = @"";
        if (response.statusCode == 0) {
            messageStr = @"分享成功";
        }
        else if (response.statusCode == -1) {
            messageStr = @"您取消了分享";
        }
        else {
            messageStr = @"分享失败";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:messageStr
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = @"认证结果";
//        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
//                             response.statusCode, [(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
        
        NSString *messageStr = @"";
        if (response.statusCode == 0) {
            messageStr = @"授权成功";
        }
        else if (response.statusCode == -1) {
            messageStr = @"您取消了授权";
        }
        else {
            messageStr = @"授权失败";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:messageStr
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

//-----------------------------------微信——--------------------
-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = @"";
    NSString *strTitle = [NSString stringWithFormat:@"分享结果"];
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"分享结果"];
        if (resp.errCode == 0) {
            strMsg = @"分享成功";
            if ([UserInfo sharedUserInfo]._isActivityShare) {
                [self totalMileageReturnPayCoin];
                return;
            }
        }
        else if (resp.errCode == -2) {
            strMsg = @"您取消了分享";
        }
        else {
            strMsg = @"分享失败";
        }
        [UserInfo sharedUserInfo]._isActivityShare = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode) {
            case WXSuccess:
            {
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                if (self.payResultDelegate && [self.payResultDelegate respondsToSelector:@selector(weixinPayResp:)]) {
                    [self.payResultDelegate performSelector:@selector(weixinPayResp:) withObject:resp ];
                }
            }
                break;
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                NSLog(@"错误，retcode = %d, retstr = %@，rreturnKey = %@", resp.errCode,resp.errStr,[resp returnKey]);
                if (self.payResultDelegate && [self.payResultDelegate respondsToSelector:@selector(weixinPayResp:)]) {
                    [self.payResultDelegate performSelector:@selector(weixinPayResp:) withObject:resp ];
                }
                break;
        }
    }
    
}
-(void)weixinPayResp:(PayResp *)resp//微信支付结果通知
{}
- (void)totalMileageReturnPayCoin
{
    ASIFormDataRequest * theRequest = [InterfaceClass totalMileageReturnPayCoin];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getMileageReturnPayCoinResult:) Delegate:self needUserType:NoMember];
}

- (void)getMileageReturnPayCoinResult:(NSDictionary *)dic
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = 72;
    [alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 72) {
        [NavigationController popToRootViewControllerAnimated:YES];
    }
}
@end
