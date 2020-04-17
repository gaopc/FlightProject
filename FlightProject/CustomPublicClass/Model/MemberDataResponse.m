//
//  UserLoginCaller.m
//  FlightProject
//
//  Created by green kevin on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberDataResponse.h"

@implementation MemberDataResponse

//用户登录
+ (MemberDataResponse *)memberLogin:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	MemberDataResponse * member = [[[MemberDataResponse  alloc] init] autorelease];
	int statusCode = [[dic objectForKey:@"statusCode"] intValue];
	//statusCode状态为0表示成功
	if (statusCode==0) {
        [UserInfo sharedUserInfo].userID =[NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]];
        [UserInfo sharedUserInfo].name =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        [UserInfo sharedUserInfo].email = [NSString stringWithFormat:@"%@",[dic objectForKey:@"email"]];
        [UserInfo sharedUserInfo]._orderStateNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"unpaidOrders"]];
        [UserInfo sharedUserInfo].cardNo = nil;
        [UserInfo sharedUserInfo].lcdCurrency = [NSString stringWithFormat:@"%@",[dic objectForKey:@"lcdCurrency"]];
        [UserInfo sharedUserInfo].idCard = [NSString stringWithFormat:@"%@",[dic objectForKey:@"idCard"]];
	}

	return member;
}
//获取验证码
+ (NSArray *)getVerificationCode:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	int statusCode = [[dic objectForKey:@"statusCode"] intValue];
	NSString * message = [dic objectForKey:@"message"];
	return [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",statusCode],message, nil];
}

//用户注册
+ (NSString*)memberRegister:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	[UserInfo sharedUserInfo].userID = [dic objectForKey:@"userId"];
    [UserInfo sharedUserInfo].cardNo = nil;
	NSString * message = [dic objectForKey:@"message"];
	return message;
}


//忘记密码
+ (NSString *)forgetPassword:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	NSString * message = [dic objectForKey:@"message"];
	return message;

}

//修改密码
+ (NSString *)updatePassword:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	NSString * message = [dic objectForKey:@"message"];
	return message;
}


//编辑用户信息
+ (void)editPersonalInformation:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
	
}

//获取用户信息
+ (void)getPersonalInformation:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    [UserInfo sharedUserInfo].name =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
	[UserInfo sharedUserInfo].email = [NSString stringWithFormat:@"%@",[dic objectForKey:@"email"]];
	[UserInfo sharedUserInfo].sex =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"sex"]];
	[UserInfo sharedUserInfo].birthday = [NSString stringWithFormat:@"%@",[dic objectForKey:@"birthday"]];
	[UserInfo sharedUserInfo].postalAddress = [NSString stringWithFormat:@"%@",[dic objectForKey:@"postalAddress"]];
	[UserInfo sharedUserInfo].postCode = [NSString stringWithFormat:@"%@",[dic objectForKey:@"postCode"]];
	[UserInfo sharedUserInfo].cardType =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"cardType"]];
	[UserInfo sharedUserInfo].cardNo = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cardNo"]];

}

-(void)dealloc
{
	
	[super dealloc];
}

@end
