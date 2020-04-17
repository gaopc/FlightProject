//
//  ValidateVersionResponse.m
//  FlightProject
//
//  Created by green kevin on 13-3-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ValidateVersionResponse.h"

@implementation ValidateVersionResponse

//获取版本号
+ (NSArray *)getValidateVersion:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	int statusCode = [[dic objectForKey:@"statusCode"] intValue];
	NSString * message =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"desc"]];
	return [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",statusCode],message, nil];
}


@end

@implementation VersionInfo
@synthesize _name,_url,_desc;

-(void)dealloc
{
	self._name = nil;
	self._url = nil;
	self._desc = nil;
	[super dealloc];
}

@end