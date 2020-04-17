//
//  MyLCDCoinDataResponse.m
//  FlightProject
//
//  Created by green kevin on 12-10-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyLCDCoinDataResponse.h"
@implementation MyLCDCoinDataResponse
@synthesize _myLCDCoinInfo,_myLCDCoinDetailArray;

//获取我的畅达货
+ (MyLCDCoinDataResponse *)myLCDCoin:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	MyLCDCoinDataResponse * myLCDCoin = [[[MyLCDCoinDataResponse  alloc] init] autorelease];
      
	MyLCDCoinInfo *minfo = [[MyLCDCoinInfo alloc] init];
	
	minfo._availableLcdCurrency =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"availableLcdCurrency"]];
	minfo._lcdCurrency =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"lcdCurrency"]];
	minfo._useLcdCurrency =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"useLcdCurrency"]];
	minfo._notReturnLcdCurrency = [NSString stringWithFormat:@"%@", [dic objectForKey:@"notReturnLcdCurrency"]];	
	
    NSArray *autoInfolist = [dic valueForKey:@"detail"];
	NSMutableArray *list = [[NSMutableArray alloc] init];
    if ([autoInfolist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dicList in autoInfolist) {
            MyLCDCoinDetailInfo *info = [[MyLCDCoinDetailInfo alloc] init];
            info._type =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"type"]];
            info._content =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"content"]];
            info._amount = [NSString stringWithFormat:@"%@",[dicList objectForKey:@"amount"]];
            info._incomeOrExpenses =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"incomeOrExpenses"]];
            info._date =  [dicList objectForKey:@"date"];
            [list addObject: info];
            [info release];
        }
    }

	myLCDCoin._myLCDCoinInfo = minfo;
	[minfo release];
	myLCDCoin._myLCDCoinDetailArray=list;
	[list release];
    if ([myLCDCoin._myLCDCoinDetailArray count]==0) {
        myLCDCoin._myLCDCoinDetailArray = nil;
    }
	return myLCDCoin;
}


@end

@implementation MyLCDCoinInfo

@synthesize _availableLcdCurrency,_lcdCurrency,_useLcdCurrency,_notReturnLcdCurrency;

-(void)dealloc
{
	self._availableLcdCurrency = nil;
	self._lcdCurrency = nil;
	self._useLcdCurrency = nil;
	self._notReturnLcdCurrency = nil;
	[super dealloc];
}

@end


@implementation MyLCDCoinDetailInfo

@synthesize _type,_content,_amount,_incomeOrExpenses,_date;

-(void)dealloc
{
	self._type = nil;
	self._content = nil;
	self._amount = nil;
	self._incomeOrExpenses = nil;
	self._date = nil;
	[super dealloc];
}

@end
