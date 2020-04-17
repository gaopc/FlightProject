//
//  CabinItem.m
//  LCDFlight
//
//  Created by zzz on 18/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CabinItem.h"


@implementation CabinItem

@synthesize cabinNO;
@synthesize sits;
@synthesize discount;
@synthesize moneyType;
@synthesize oneWayPrice;
@synthesize cabinType;
@synthesize baseCabin;
@synthesize specialFlightNum;
@synthesize specialBaseCabin;
-(void)dealloc{
	self.cabinNO = nil;
	self.sits = nil;
    self.discount = nil;
    self.moneyType = nil;
    self.oneWayPrice = nil;
    self.cabinType = nil;
    self.baseCabin = nil;
    self.specialFlightNum = nil;
    self.specialBaseCabin = nil;
    [super  dealloc];
}

-(id)init{
	self = [super init];
	if (self) {
		
	}
	return self;
}
-(NSString *)description
{
    NSString * str = [NSString stringWithFormat:@"=====%@,%@,%@,%@,%@,%@,%@,%@,%@",cabinNO,sits,discount,moneyType,oneWayPrice,cabinType,baseCabin,specialFlightNum,self.specialBaseCabin];
    return str;
}
@end
