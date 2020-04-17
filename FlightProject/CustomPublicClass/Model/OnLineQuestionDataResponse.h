//
//  OnLineQuestionDataResponse.h
//  FlightProject
//
//  Created by green kevin on 12-10-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnLineQuestionDataResponse : NSObject
//提交客户反馈意见到服务器
+ (NSString *)submitAdvise:(NSDictionary *)dic;
@end



@interface OnLineQuestionInfo : NSObject

@property (nonatomic,retain)NSString * _problem; // 建议内容
@property (nonatomic,retain)NSString * _mobilNumber; //手机号
@property (nonatomic,retain)NSString * _email; //邮箱


@end
