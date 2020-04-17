//
//  GetNewVersionInfoResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//2.62	获取最新版本接口
#import <Foundation/Foundation.h>

@interface VersionInfo : NSObject
@property (nonatomic,retain) NSString * version;
@property (nonatomic,retain) NSString * versionCode;
@property (nonatomic,retain) NSString * description;
@property (nonatomic,retain) NSString * url;
@end

@interface GetNewVersionInfoResponse : NSObject
+(VersionInfo *)getNewVersionInfoResponseWithArray:(NSArray *)resultArray;
@end
