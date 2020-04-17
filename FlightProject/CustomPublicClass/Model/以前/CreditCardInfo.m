//
//  CreditCardInfo.m
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CreditCardInfo.h"

@implementation CreditCardInfo

@synthesize cardNo,expiredDate,cvv,bankID,userId,userName,identitycard;
-(void)dealloc
{
    self.cardNo = nil;
    self.expiredDate = nil;
    self.cvv = nil;
    self.bankID = nil;
    self.userId = nil;
    self.userName = nil;
    self.identitycard = nil;
    [super dealloc];
}
@end
