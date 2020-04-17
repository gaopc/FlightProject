//
//  SearchPayBankResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayBank : NSObject
@property(nonatomic,retain) NSString* bankID;
@property(nonatomic,retain) NSString* bankName;
@property(nonatomic,retain) NSString* bankGateway;
@end

@interface SearchPayBankResponse : NSObject

+(NSArray *)searchPayBankWithArray:(NSArray *)resultArray;
@end
