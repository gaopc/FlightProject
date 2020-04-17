//
//  SendRequstCatchQueue.m
//  FlightProject
//
//  Created by longcd on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SendRequstCatchQueue.h"
#import "NSDate+convenience.h"
#import "UserInfo.h"
#import "Header.h"
#import "RootViewController.h"
#import "GetBasicInfoFromServer.h"
#import "WelecomViewContrller.h"
#import "GetConfiguration.h"
#import "RecommendClass.h"
@implementation SendRequstCatchQueue
@synthesize currentViewController;
@synthesize catchArray,basicInfo,endOption;
-(void)dealloc
{
    self.catchArray = nil;
    self.currentViewController = nil;
    self.basicInfo = nil;
    self.endOption = nil;
    [super dealloc];
}
+(SendRequstCatchQueue *)shareSendRequstCatchQueue
{
    static SendRequstCatchQueue * instance = nil;
    if (instance == nil) {
        instance = [[SendRequstCatchQueue alloc] init];
    }
    return instance;
}
-(id)init
{
    if (self = [super init]) {
        self.catchArray = [NSMutableArray array] ;
    }
    return self;
}
// 三期
-(void)cancelRequst
{
    for (SendRequst * elem in self.catchArray) {
        elem.delegateVC = nil;
    }
    [[WaitView shareWaitView] hiddenWaitView];
}
-(void)requestResult:(SendRequst *)sendR
{
    if ([NSStringFromSelector(sendR.delegateSelector) isEqualToString:@"onConfigurationPaseredResult:"] ) {
        if (sendR.delegateVC) {
            if ([[GetConfiguration shareGetConfiguration]._version._mandatoryCode intValue] > MyVersionCode) {
            }
            else if ([[GetConfiguration shareGetConfiguration]._version._code intValue] > MyVersionCode){
            }
            else{
                if (self.endOption) {
                    if ([self.endOption count]==4) {
                        UserType type = [[self.endOption objectAtIndex:3] intValue];
                        SEL selector = NSSelectorFromString([self.endOption objectAtIndex:1]);
                        [self sendRequstCatchQueue:[self.endOption objectAtIndex:0] Selector:selector Delegate:[self.endOption objectAtIndex:2] needUserType:type];
                    }
                    else
                    {
                        [self sendRequstCatchQueue:[self.endOption objectAtIndex:0] Selector:nil Delegate:nil needUserType:Default];
                    }
                    self.endOption = nil;
                }
            }
        }
    }
    [self.catchArray removeObject:sendR];
    BOOL hidden = YES;
    for (SendRequst * elem in self.catchArray) {
        if (elem.delegateVC !=nil) {
            if (![elem.delegateVC respondsToSelector:NSSelectorFromString(@"onConfigurationPaseredResult:")]) {
                hidden = NO;
            }
        }
    }
    if ([self.catchArray count] == 0 || hidden) {
        [[WaitView shareWaitView] hiddenWaitView];
    }
}
-(void)sendRequstCatchQueue:(ASIFormDataRequest *)theRequest Selector:(SEL)aselector Delegate :(id)adelegate needUserType:(UserType)needUserType
{
    RootViewController * rootVC = [NavigationController.viewControllers lastObject];
    rootVC._VCType = needUserType;
    
    if (![NSStringFromSelector(aselector) isEqualToString:@"saveDeviceToken"]) {
        if (([GetConfiguration shareGetConfiguration]._isFirst == nil )&& (! [NSStringFromSelector(aselector) isEqualToString:@"onConfigurationPaseredResult:"]) && ![NSStringFromSelector(aselector) isEqualToString:@"onqueryactivityListResult:"] && ![NSStringFromSelector(aselector) isEqualToString:@"onWeatherInfoResult:"]) {
            self.endOption = [NSMutableArray arrayWithObjects:theRequest,NSStringFromSelector(aselector),adelegate,[NSString stringWithFormat:@"%d",needUserType], nil];
            GetBasicInfoFromServer *_basicInfo = [[GetBasicInfoFromServer alloc] init];
            self.basicInfo = _basicInfo;
            [_basicInfo release];
            self.basicInfo.cityDelegate = rootVC;
            [self.basicInfo getConfiguration:[UserInfo sharedUserInfo].deviceToken];
            return;
        }
        
        if ((needUserType != Default )) {
            if (((needUserType == NoMember)&&([[UserInfo sharedUserInfo].userID isEqualToString:@""]))) {
                
            }
            else{
                if (![rootVC isLogin]) {
                    return;
                }
            }
        }
        else {
            if (![UserInfo sharedUserInfo]._isAutoLogin && ([UserInfo sharedUserInfo].userID && ![[UserInfo sharedUserInfo].userID isEqualToString: @""]) ) {
                NSString * startDateTime = [NSString stringWithFormat:@"%@:00",[UserInfo sharedUserInfo]._loginTime];
                NSDate * startDate = [ NSDate dateFromString:startDateTime withFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSTimeInterval start = [startDate timeIntervalSinceNow] *1;
                start = abs((int)start);
                NSTimeInterval nomalValue = 1;
                if (  (start/3600) < nomalValue) {
                    if ((int)(start / 60) < AutoLoginOutTime) {
                        [UserInfo sharedUserInfo]._loginTime = [NSDate laterDateStr:[NSDate date]];
                    }
                    else{
                        [UserInfo sharedUserInfo].userID = nil;
                        
                        if ([ActivityTimerView shareTimerView]._isAactivation) {
                            [[ActivityTimerView shareTimerView] hiddenTimerView];
                            [[ActivityTimerView shareTimerView] stopTimerView];
                        }
                    }
                }
                else {
                    [UserInfo sharedUserInfo].userID = nil;
                    
                    if ([ActivityTimerView shareTimerView]._isAactivation) {
                        [[ActivityTimerView shareTimerView] hiddenTimerView];
                        [[ActivityTimerView shareTimerView] stopTimerView];
                    }
                }
            }
        }

    }
    
    
    self.currentViewController = [NSString stringWithFormat:@"%@",[rootVC class]];
    SendRequst * _sendRequst = [[SendRequst alloc] init];
    _sendRequst.delegate = self;
    _sendRequst.delegateVC = adelegate;
     _sendRequst.delegateSelector = aselector;
    
     NSArray * citysListRequests = [NSArray arrayWithObjects:@"onAirportListPaseredResult:",@"onAirportCityInfoPaseredResult:",@"onHotelCityListPaseredResult:",@"onCarRentalListPaseredResult:",@"onTrainVersionResult:",@"onTrainCitysListPaseredResult:",@"onWeatherCityListPaseredResult:", nil];
        
    if ([citysListRequests containsObject:NSStringFromSelector(aselector)]) {
        [adelegate release];
        adelegate = nil;
    }
    _sendRequst.currentViewController = self.currentViewController;
    NSString * requestUrl = [NSString stringWithFormat:@"%@",theRequest.url];
    NSLog(@"%@",requestUrl);
    if ([[[requestUrl componentsSeparatedByString:@":"] objectAtIndex:0] isEqualToString:@"http"]) {
        [_sendRequst sendRequstAsiFormHttp:theRequest];
    }
    else {
        [_sendRequst sendRequstAsiFormHttps:theRequest];
    }
    
    [self.catchArray addObject:_sendRequst];
    [_sendRequst release];
    
    if (adelegate && aselector)
    {
        if ((![self.currentViewController isEqualToString:[NSString stringWithFormat:@"%@",[WelecomViewContrller class]]]) ) {
            
            UIView * view =  [[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] subviews].lastObject;
            if (view == [WaitView shareWaitView] ) {
                if ([[NSString stringWithFormat:@"%@",[adelegate class]] isEqualToString:[NSString stringWithFormat:@"RecommendClass"]]) { //
                    [WaitView shareWaitView].loadingView._titleLab.text = @"正在为您查找您可能感兴趣的内容，请稍候…";
                }
                return;
            }
            
            if (!([NSStringFromSelector(aselector) isEqualToString:@"onqueryactivityListResult:"] || [NSStringFromSelector(aselector) isEqualToString:@"onWeatherInfoResult:"]|| [NSStringFromSelector(aselector) isEqualToString:@"onfindPreSalePeriodResult:"])) {
                [[WaitView shareWaitView] showWaitView];
                [[WaitView shareWaitView] setDelegate:self];
            }

            if ([[NSString stringWithFormat:@"%@",[adelegate class]] isEqualToString:[NSString stringWithFormat:@"RecommendClass"]]) { //
                [WaitView shareWaitView].loadingView._titleLab.text = @"正在为您查找您可能感兴趣的内容，请稍候…";
            }
            else {
                NSArray * _messageArray = [GetConfiguration shareGetConfiguration]._messageArray;
                [WaitView shareWaitView].loadingView._titleLab.text = [_messageArray objectAtIndex:arc4random() % [_messageArray count]];
            }
            if (([NSStringFromSelector(aselector) isEqualToString:@"getOrdersStateResult:"] )||([NSStringFromSelector(aselector) isEqualToString:@"onfindOrderPollInfoResult:"])||([NSStringFromSelector(aselector) isEqualToString:@"findOrderPayStatusInfoResult:"])||[NSStringFromSelector(aselector) isEqualToString:@"onapplyForSeatResult:"]) {
                [WaitView shareWaitView].loadingView._cancelButton.hidden = YES;
            }
            else{
                [WaitView shareWaitView].loadingView._cancelButton.hidden = NO;
            }
        }
    }
}

@end

