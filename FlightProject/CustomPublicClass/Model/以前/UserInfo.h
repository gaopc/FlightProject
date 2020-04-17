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
+(UserInfo *)sharedUserInfo;
@end
