//
//  GetNewVersionInfoResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetNewVersionInfoResponse.h"

@implementation VersionInfo

@synthesize version,versionCode,description,url;
-(void)dealloc
{
    self.versionCode = nil;
    self.version = nil;
    self.description = nil;
    self.url = nil;
    [super dealloc];
}

@end

@implementation GetNewVersionInfoResponse
+(VersionInfo *)getNewVersionInfoResponseWithArray:(NSArray *)resultArray
{
    VersionInfo * info = nil;
    if ([[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:0]] isEqualToString:@"0"]) {
        info = [[VersionInfo alloc] init];
        info.version = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
        info.versionCode = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:3]];
        info.description = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:4]];
        info.url = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:5]];
    }
    else {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:1]]];
    }
    return [info autorelease];
}
@end
