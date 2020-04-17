//
//  MyMonthlyBills.h
//  FlightProject
//
//  Created by xiemengyue on 13-5-3.
//
//

#import <Foundation/Foundation.h>

@interface MonthlyBill : NSObject

@property (nonatomic,retain)NSString *month;
@property (nonatomic,retain)NSString *flight;
@property (nonatomic,retain)NSString *hotel;
@property (nonatomic,retain)NSString *car;
@property (nonatomic,retain)NSString *lcdCurrency;

@end

@interface MyMonthlyBills : NSObject
@property (nonatomic,retain)NSMutableArray *monthsArray;

+(MyMonthlyBills*)GetMyMonthlyBills:(NSDictionary*)dic;
@end
