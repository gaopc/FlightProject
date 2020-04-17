//
//  GetBankList.m
//  FlightProject
//
//  Created by longcd on 12-11-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetBankList.h"

@implementation BankListInfo

@synthesize _bankName,_hotelBankId;

-(void)dealloc
{
    self._bankName = nil;
    self._hotelBankId = nil;
    [super dealloc];
}
+(BankListInfo *) bankInfoWithDic:(NSDictionary *)elem
{
    if (![elem isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    BankListInfo * info = [[BankListInfo alloc] init];
    info._bankName = [NSString stringWithFormat:@"%@",[elem objectForKey:@"bankName"]];
    info._hotelBankId = [NSString stringWithFormat:@"%@",[elem objectForKey:@"hotelBankId"]];
    return [info autorelease];
}
@end

@implementation GetBankList
+(NSArray *)GetBankList:(NSDictionary * ) dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray * backList = [dic objectForKey:@"bankInfo"];
    NSMutableArray * mArray = nil;
    if ([backList isKindOfClass:[NSArray class]]) {
        if (backList.count > 0) {
            mArray = [NSMutableArray array];
            for (NSDictionary * elem in backList) {
                [mArray addObject:[BankListInfo bankInfoWithDic:elem]];
            }
        }
    }

    return mArray;
}
@end
