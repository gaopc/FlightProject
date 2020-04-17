//
//  RootRequestModel.h
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootRequestModel : NSObject

@property(nonatomic, retain) NSString *terminalId;
@property (nonatomic,retain) NSString * languageType;
+(id )shareRootRequestModel;
@end
