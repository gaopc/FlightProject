//
//  OnLineQuestionDataResponse.m
//  FlightProject
//
//  Created by green kevin on 12-10-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OnLineQuestionDataResponse.h"

@implementation OnLineQuestionDataResponse

//提交客户反馈意见到服务器
+ (NSString *)submitAdvise:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	NSString *message =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
	return message;
}

@end


@implementation OnLineQuestionInfo

@synthesize _problem,_mobilNumber,_email;

-(void)dealloc
{
	self._problem = nil;
	self._mobilNumber = nil;
	self._email = nil;
	
	[super dealloc];
}

@end
