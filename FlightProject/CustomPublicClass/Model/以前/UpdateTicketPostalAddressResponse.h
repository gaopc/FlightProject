//
//  UpdateTicketPostalAddressResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MailPsgInfo.h"
@interface UpdateTicketPostalAddressRequst:NSObject
@property (nonatomic,retain)NSString * userID;
@property (nonatomic,retain)NSString * orderID;
@property (nonatomic,retain)MailPsgInfo * mailPsg;
@end

@interface UpdateTicketPostalAddressResponse : NSObject
+(void)updateTicketPostalAddressResponseWithArray:(NSArray *)resultArray;
@end
