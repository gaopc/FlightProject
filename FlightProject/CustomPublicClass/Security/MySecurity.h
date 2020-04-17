//
//  Security.h
//  FlightProject
//
//  Created by 崔立东 on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
/* 本类用于安全加密的类方法，方便调用 */
#import <Foundation/Foundation.h>

@interface MySecurity : NSObject
//md5加密
+ (NSString *)md5OfString:(NSString*)string;
//md5加密小写字母
+ (NSString *)md5OfStringLower: (NSString *)string;
//AES加密
+ (NSString *)encrypt:(NSString *)string password:(NSString *)password;
//AES解密
+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password;
//DES RSA

@end
