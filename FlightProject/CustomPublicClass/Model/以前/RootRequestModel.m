//
//  RootRequestModel.m
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootRequestModel.h"

@implementation RootRequestModel
@synthesize terminalId,languageType;
-(void)dealloc
{
    self.terminalId = nil;
    self.languageType = nil;
    [super dealloc];
}
+(id )shareRootRequestModel
{
    id  instance = nil;
    if (instance == nil) {
        instance = [[[self class] alloc] init];
        [(RootRequestModel *) instance setTerminalId:[TerminalId TerminalId]];
        [(RootRequestModel *)instance setLanguageType:LanguageType];
    }
    return [instance autorelease];
}

@end
