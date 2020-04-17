//
//  AddUserResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterInfo : RootRequestModel
@property (nonatomic,retain) NSString *telephone;
@property (nonatomic,retain) NSString *password;
@property (nonatomic,retain) NSString *checkCode;
@property (nonatomic,retain) NSString *source;
@property (nonatomic,retain) NSString *recommendTelephone;
@end

@interface AddUserResponse : NSObject
+(NSString *)addUserResponseWithArray:(NSArray *)resultArray;
@end
