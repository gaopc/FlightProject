//
//  UserLoginCaller.h
//  FlightProject
//
//  Created by green kevin on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MemberDataResponse : NSObject

//登录
+ (MemberDataResponse *)memberLogin:(NSDictionary *)dic;
//验证码
+ (NSArray*)getVerificationCode:(NSDictionary *)dic;
//注册
+ (NSString*)memberRegister:(NSDictionary *)dic;
//忘记密码
+ (NSString *)forgetPassword:(NSDictionary *)dic;
//修改密码
+ (NSString *)updatePassword:(NSDictionary *)dic;
//编辑用户信息
+ (void)editPersonalInformation:(NSDictionary *)dic;
//获取用户信息
+ (void)getPersonalInformation:(NSDictionary *)dic;
@end
