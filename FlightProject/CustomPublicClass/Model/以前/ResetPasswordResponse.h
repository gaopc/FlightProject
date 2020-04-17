//
//  GetFeedbackInfosResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ResetPassword : NSObject

@property (nonatomic,retain) NSString * telephone;
@property (nonatomic,retain) NSString * passWord;
@property (nonatomic,retain) NSString * checkCode;

@end

@interface ResetPasswordResponse : NSObject

+(void)resetPasswordResponseWithArray:(NSArray *)resultArray;

@end
