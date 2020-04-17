//
//  TelePhoneLoginResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserInfo.h"

@interface TelephoneLogin  : RootRequestModel
@property(nonatomic , retain) NSString * telephone;
@property (nonatomic,retain) NSString * password;
@end

@interface TelePhoneLoginResponse : NSObject
+(UserInfo *)telePhoneLoginResponseWithArray:(NSArray *)resultArray;
@end
