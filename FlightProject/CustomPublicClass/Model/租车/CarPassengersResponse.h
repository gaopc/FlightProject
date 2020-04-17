//
//  CarPassengersResponse.h
//  FlightProject
//
//  Created by gaopengcheng on 13-5-6.
//
//

#import <Foundation/Foundation.h>

@interface CarPassengersResponse : NSObject
@property (nonatomic,retain) NSString * _id;
@property (nonatomic,retain) NSString * _name;
@property (nonatomic,retain) NSString * _identityNumber;
@property (nonatomic,retain) NSString * _tel;

+ (NSArray *)CarPassengersList:(NSDictionary *)dic;
@end
