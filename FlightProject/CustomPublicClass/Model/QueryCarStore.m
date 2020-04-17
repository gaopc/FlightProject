//
//  QueryCarStore.m
//  FlightProject
//
//  Created by dyl mac mini 04 on 12-10-22.
//
//

#import "QueryCarStore.h"

@implementation CarStore

@synthesize _areaCode,_areaName,_shops;

-(void)dealloc
{
    self._areaCode = nil;
    self._areaName = nil;
    self._shops = nil;
    [super dealloc];
}

@end

@implementation Shops

@synthesize _storeCode,_shopName,_shopAddress,_startOpeningHours,_endOpeningHours,_deptype;

-(void)dealloc
{
    self._storeCode = nil;
    self._shopName = nil;
    self._shopAddress = nil;
    self._startOpeningHours = nil;
    self._endOpeningHours = nil;
    self._deptype = nil;
    [super dealloc];
}

@end

@implementation QueryCarStore

+(NSArray *)getQueryCarStore:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *temp = [dic objectForKey:@"carStore"];
    if ([temp isKindOfClass:[NSArray class]]) {
        for (id elem in temp) {
            CarStore *carStore = [[CarStore alloc] init];
            carStore._areaCode = [NSString stringWithFormat:@"%@",[elem objectForKey:@"areaCode"]];
            carStore._areaName = [NSString stringWithFormat:@"%@",[elem objectForKey:@"areaName"]];
            NSMutableArray *array1 = [[NSMutableArray alloc] init];
            for (id elem1 in[elem objectForKey:@"shops"] ) {
                Shops *shops = [[Shops alloc] init];
                shops._storeCode =[NSString stringWithFormat:@"%@",[elem1 objectForKey:@"storeCode"]] ;
                shops._shopName = [NSString stringWithFormat:@"%@",[elem1 objectForKey:@"shopName"]];
                shops._shopAddress = [NSString stringWithFormat:@"%@",[elem1 objectForKey:@"shopAddress"]];
                shops._startOpeningHours = [NSString stringWithFormat:@"%@",[elem1 objectForKey:@"startOpeningHours"]];
                shops._endOpeningHours =[NSString stringWithFormat:@"%@", [elem1 objectForKey:@"endOpeningHours"]];
                shops._deptype = [NSString stringWithFormat:@"%@",[elem1 objectForKey:@"deptype"]];
                [array1 addObject:shops];
                [shops release];
            }
            carStore._shops = array1;
            [array1 release];
            [array addObject:carStore];
            [carStore release];
        }
    }
    if ([array count] == 0) {
        [array release];
        return nil;
    }
    return [array autorelease];
}
@end


