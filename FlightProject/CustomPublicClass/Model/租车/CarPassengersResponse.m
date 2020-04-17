//
//  CarPassengersResponse.m
//  FlightProject
//
//  Created by gaopengcheng on 13-5-6.
//
//

#import "CarPassengersResponse.h"

@implementation CarPassengersResponse
@synthesize _id, _identityNumber, _name, _tel;

-(void)dealloc
{
    self._id = nil;
    self._name = nil;
    self._identityNumber = nil;
    self._tel = nil;
    [super dealloc];
}

+ (CarPassengersResponse *)CarPassengersInfo:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    CarPassengersResponse * carPassengersInfo = [[CarPassengersResponse alloc] init];
    carPassengersInfo._id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]];
    carPassengersInfo._name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
    carPassengersInfo._identityNumber = [NSString stringWithFormat:@"%@", [dic objectForKey:@"identityNumber"]];
    carPassengersInfo._tel = [NSString stringWithFormat:@"%@", [dic objectForKey:@"tel"]];
    return [carPassengersInfo autorelease];
}

+ (NSArray *)CarPassengersList:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray * array = [dic objectForKey:@"list"];
    if (![array isKindOfClass:[NSArray class]] ) {
        return nil;
    }
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary * elem in array) {
        [marray addObject:[self CarPassengersInfo:elem]];
    }
    return marray;
}
@end
