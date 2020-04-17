//
//  GetCreditCardList.m
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetCreditCardList.h"
#import "UpdateCreditCard.h"

@implementation GetCreditCardList
@synthesize creditCardList;
- (void)dealloc
{
    self.creditCardList = nil;
    [super dealloc];
}

+(GetCreditCardList*)GetCreditCardList:(NSDictionary*)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    GetCreditCardList *getCreditCardList = [[GetCreditCardList alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if ([[dic objectForKey:@"creditCardModel"] isKindOfClass:[NSNull class]]) {
        [array release];
        [getCreditCardList release];
        return nil;
    }

	NSArray *creditCard = [dic objectForKey:@"creditCardModel"];
	if ([creditCard isKindOfClass:[NSArray class]]) {
		for(id elem in creditCard)
		{
			UpdateCreditCard *aUpdateCreditCard = [[UpdateCreditCard alloc] init];
			aUpdateCreditCard._id = [NSString stringWithFormat:@"%@",[elem objectForKey:@"id"]];
			aUpdateCreditCard._username = [NSString stringWithFormat:@"%@",[elem objectForKey:@"userName"]];
			aUpdateCreditCard._idCard = [NSString stringWithFormat:@"%@",[elem objectForKey:@"idCard"]];
			aUpdateCreditCard._bank = [NSString stringWithFormat:@"%@",[elem objectForKey:@"bank"]];
			aUpdateCreditCard._bankId = [NSString stringWithFormat:@"%@",[elem objectForKey:@"bankId"]];
			aUpdateCreditCard._bankIdCard = [NSString stringWithFormat:@"%@",[elem objectForKey:@"bankIdCard"]];
			aUpdateCreditCard._validityDate = [NSString stringWithFormat:@"%@",[elem objectForKey:@"validityDate"]];
			[array addObject:aUpdateCreditCard];
			[aUpdateCreditCard release];
		}
	}

    getCreditCardList.creditCardList = array;
    [array release];
    if ([getCreditCardList.creditCardList count] == 0) {
        getCreditCardList.creditCardList = nil;
    }
    return [getCreditCardList autorelease];
}
@end

@implementation CreditCardInfo
@synthesize ids,userName,idCard,bank,bankId,bankIdCard,validityDate,cVV2Code;
- (void)dealloc
{
    self.ids = nil;
    self.userName = nil;
    self.idCard = nil;
    self.bank = nil;
    self.bankId = nil;
    self.bankIdCard = nil;
    self.validityDate = nil;
    self.cVV2Code = nil;
    [super dealloc];
}

@end