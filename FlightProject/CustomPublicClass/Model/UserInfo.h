//
//  UserInfo.h
//  FlightProject
//
//  Created by longcd on 12-6-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (nonatomic,retain) NSString *userID;
@property (nonatomic,retain) NSString *password;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) NSString *telePhone;
@property (nonatomic,retain) NSString *birthday;
@property (nonatomic,retain) NSString *sex;
@property (nonatomic,retain) NSString *postalAddress;
@property (nonatomic,retain) NSString * postCode;
@property (nonatomic,retain) NSString * cardType;
@property (nonatomic,retain) NSString * cardNo;
@property (nonatomic,retain) NSString * deviceToken;
@property (nonatomic,retain) NSString * _orderStateNum;
@property (nonatomic,assign) BOOL _isAutoLogin;
@property (nonatomic,retain) NSString * _loginTime;
@property (nonatomic,assign) BOOL _isAutoLoginOut;
@property (nonatomic,retain) NSString *lcdCurrency;//畅达币总数
@property (nonatomic,retain) NSString *idCard;//身份证号
@property (assign) BOOL _isActivityShare;//活动分享朋友圈

+(UserInfo *)sharedUserInfo;
@end
