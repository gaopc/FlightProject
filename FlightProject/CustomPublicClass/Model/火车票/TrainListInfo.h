//
//  TrainListInfo.h
//  FlightProject
//
//  Created by admin on 13-1-6.
//
//

#import <Foundation/Foundation.h>

@interface TrainListInfo : NSObject
@property (nonatomic, retain) NSString *_trainNumber;
@property (nonatomic, retain) NSString *_trainType;
@property (nonatomic, retain) NSString *_departureTime;
@property (nonatomic, retain) NSString *_arrivalTime;
@property (nonatomic, retain) NSString *_originatingStation;

@property (nonatomic, retain) NSString *_terminalStation;
@property (nonatomic, retain) NSString *_runningTime;
@property (nonatomic, retain) NSString *_mileage;
@property (nonatomic, retain) NSString *_originatingType;
@property (nonatomic, retain) NSString *_terminalType;

@property (nonatomic, retain) NSString *_isAirConditioning;
@property (nonatomic, retain) NSString *_days;
@property (nonatomic, retain) NSString *_hardSeatPric;
@property (nonatomic, retain) NSString *_softSeatPric;
@property (nonatomic, retain) NSString *_hardSleeperUpPrice;

@property (nonatomic, retain) NSString *_hardSleeperMidPrice;
@property (nonatomic, retain) NSString *_hardSleeperDownPrice;
@property (nonatomic, retain) NSString *_softSleeperUpPrice;
@property (nonatomic, retain) NSString *_softSleeperDownPrice;
@property (nonatomic, retain) NSString *_firstSeat;

@property (nonatomic, retain) NSString *_secondSeat;
@property (nonatomic, retain) NSString *_specialSeat;

+ (NSArray *)setTrainListInfo:(NSDictionary *)dic;
@end

@interface SearchTrainDetail : NSObject

@property (nonatomic,retain)NSString * _stationName; //车站
@property (nonatomic,retain)NSString * _departureTime; //发车时间
@property (nonatomic,retain)NSString * _arrivalTime;//到达时间
@property (nonatomic,retain)NSString * _stopTime;//停靠时间
@property (nonatomic,retain)NSString * _mileage; //里程
@property (nonatomic,retain)NSString * _stationNum; //车站天数
@property (nonatomic,retain)NSString * _days;//天数

+ (NSArray *)setTrainDetailInfo:(NSDictionary *)dic;
@end