//
//  ValidateVersionResponse.h
//  FlightProject
//
//  Created by green kevin on 13-3-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateVersionResponse : NSObject
//获取版本号
+ (NSArray *)getValidateVersion:(NSDictionary *)dic;
@end


@interface VersionInfo : NSObject
@property (nonatomic,retain)NSString * _name; //版本名称
@property (nonatomic,retain)NSString * _url; //下载地址,只针对Android
@property (nonatomic,retain)NSString * _desc;//更新内容

@end