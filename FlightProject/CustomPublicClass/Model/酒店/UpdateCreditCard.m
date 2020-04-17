//
//  UpdateCreditCard.m
//  FlightProject
//
//  Created by longcd on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UpdateCreditCard.h"

@implementation UpdateCreditCard
@synthesize _id,_username,_idCard,_bankId,_bank,_bankIdCard,_validityDate,_userId,_cVV2Code;
-(void)dealloc
{
    self._userId = nil;
    self._id = nil;
    self._username = nil;
    self._idCard = nil;
    self._bankId = nil;
    self._bank = nil;
    self._bankIdCard = nil;
    self._validityDate = nil;
    self._cVV2Code = nil;
    [super dealloc];
}
@end
