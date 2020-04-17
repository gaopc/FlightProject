//
//  TrainListInfo.m
//  FlightProject
//
//  Created by admin on 13-1-6.
//
//

#import "TrainListInfo.h"

@implementation TrainListInfo
@synthesize _arrivalTime, _days, _departureTime, _firstSeat, _hardSeatPric, _hardSleeperDownPrice, _hardSleeperMidPrice;
@synthesize _hardSleeperUpPrice, _isAirConditioning, _mileage, _originatingStation, _originatingType, _runningTime;
@synthesize _secondSeat, _softSeatPric, _softSleeperDownPrice, _softSleeperUpPrice, _specialSeat, _terminalStation, _terminalType, _trainNumber, _trainType;

- (void)dealloc
{
    self._trainNumber = nil;
    self._arrivalTime = nil;
    self._days = nil;
    self._departureTime = nil;
    self._firstSeat = nil;

    self._hardSeatPric = nil;
    self._hardSleeperDownPrice = nil;
    self._hardSleeperMidPrice = nil;
    self._hardSleeperUpPrice = nil;
    self._isAirConditioning = nil;
    
    self._mileage = nil;
    self._originatingStation = nil;
    self._originatingType = nil;
    self._runningTime = nil;
    self._secondSeat = nil;
    
    self._softSeatPric = nil;
    self._softSleeperDownPrice = nil;
    self._softSleeperUpPrice = nil;
    self._specialSeat = nil;
    self._terminalStation = nil;
    
    self._trainType= nil;
    self._terminalType = nil;
    
    [super dealloc];
}

+(TrainListInfo *)TrainListDetail:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    TrainListInfo * trainListInfo = [[TrainListInfo alloc] init];
    trainListInfo._trainNumber = [NSString stringWithFormat:@"%@", [dic objectForKey:@"trainNumber"]];
    trainListInfo._trainType = [NSString stringWithFormat:@"%@", [dic objectForKey:@"trainType"]];
    trainListInfo._departureTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"departureTime"]];
    trainListInfo._arrivalTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"arrivalTime"]];
    trainListInfo._originatingStation = [NSString stringWithFormat:@"%@", [dic objectForKey:@"originatingStation"]];
    
    trainListInfo._terminalStation = [NSString stringWithFormat:@"%@", [dic objectForKey:@"terminalStation"]];
    trainListInfo._runningTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"runningTime"]];
    trainListInfo._mileage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"mileage"]];
    trainListInfo._originatingType = [NSString stringWithFormat:@"%@", [dic objectForKey:@"originatingType"]];
    trainListInfo._terminalType = [NSString stringWithFormat:@"%@", [dic objectForKey:@"terminalType"]];
    
    trainListInfo._isAirConditioning = [NSString stringWithFormat:@"%@", [dic objectForKey:@"isAirConditioning"]];
    trainListInfo._days = [NSString stringWithFormat:@"%@", [dic objectForKey:@"days"]];
    trainListInfo._hardSeatPric = [NSString stringWithFormat:@"%@", [dic objectForKey:@"hardSeatPric"]];
    trainListInfo._softSeatPric = [NSString stringWithFormat:@"%@", [dic objectForKey:@"softSeatPric"]];
    trainListInfo._hardSleeperUpPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"hardSleeperUpPrice"]];
    
    trainListInfo._hardSleeperMidPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"hardSleeperMidPrice"]];
    trainListInfo._hardSleeperDownPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"hardSleeperDownPrice"]];
    trainListInfo._softSleeperUpPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"softSleeperUpPrice"]];
    trainListInfo._softSleeperDownPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"softSleeperDownPrice"]];
    trainListInfo._firstSeat = [NSString stringWithFormat:@"%@", [dic objectForKey:@"firstSeat"]];
    
    trainListInfo._secondSeat = [NSString stringWithFormat:@"%@", [dic objectForKey:@"secondSeat"]];
    trainListInfo._specialSeat = [NSString stringWithFormat:@"%@", [dic objectForKey:@"specialSeat"]];
    
    return [trainListInfo autorelease];
}

+ (NSArray *)setTrainListInfo:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray * array = [dic objectForKey:@"trainList"];
    if ((!array) || ([[dic objectForKey:@"trainList"] isKindOfClass:[NSString class]] ) ) {
        return nil;
    }
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary * elem in array) {
        [marray addObject:[self TrainListDetail:elem]];
    }
    if ([marray count] == 0) {
        return nil;
    }
    return marray;
}
@end


@implementation SearchTrainDetail
@synthesize _stationName,_departureTime,_arrivalTime,_stopTime,_mileage,_stationNum,_days;
-(void)dealloc
{
	self._stationName = nil;
	self._departureTime = nil;
	self._arrivalTime = nil;
	self._stopTime = nil;
	self._mileage = nil;
	self._stationNum = nil;
	self._days = nil;
	
	[super dealloc];
}

+ (SearchTrainDetail *)trainDetailInfo:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    SearchTrainDetail * searchTrainDetail = [[SearchTrainDetail alloc] init];
    searchTrainDetail._stationName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"stationName"]];
    searchTrainDetail._departureTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"departureTime"]];
    searchTrainDetail._stopTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"stopTime"]];
    searchTrainDetail._arrivalTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"arrivalTime"]];
    searchTrainDetail._mileage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"mileage"]];
    
    searchTrainDetail._stationNum = [NSString stringWithFormat:@"%@", [dic objectForKey:@"stationNum"]];
    searchTrainDetail._days = [NSString stringWithFormat:@"%@", [dic objectForKey:@"days"]];
    
    return [searchTrainDetail autorelease];
}

+ (NSArray *)setTrainDetailInfo:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray * array = [dic objectForKey:@"trainDetailList"];
    if ((!array) || ([[dic objectForKey:@"trainDetailList"] isKindOfClass:[NSString class]] ) ) {
        return nil;
    }
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary * elem in array) {
        [marray addObject:[self trainDetailInfo:elem]];
    }
    if ([marray count] == 0) {
        return nil;
    }
    return marray;
}
@end
