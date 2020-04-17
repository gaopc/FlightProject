//
//  MyMonthlyBills.m
//  FlightProject
//
//  Created by xiemengyue on 13-5-3.
//
//

#import "MyMonthlyBills.h"
@implementation MonthlyBill
@synthesize month,flight,hotel,car,lcdCurrency;

-(void)dealloc
{
    self.month = nil;
    self.flight = nil;
    self.hotel = nil;
    self.car = nil;
    self.lcdCurrency = nil;
    [super dealloc];
}
@end

@implementation MyMonthlyBills
@synthesize monthsArray;

+(MyMonthlyBills*)GetMyMonthlyBills:(NSDictionary*)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    MyMonthlyBills *aMyMonthlyBills = [[MyMonthlyBills alloc] init];
    NSArray *months = [dic objectForKey:@"months"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if([months isKindOfClass:[NSArray class]])
    {
        for(NSDictionary *elem in months)
        {
            MonthlyBill *monthlyBill = [[MonthlyBill alloc] init];
            monthlyBill.month = [NSString stringWithFormat:@"%@",[elem objectForKey:@"month"]];
            monthlyBill.flight = [NSString stringWithFormat:@"%d",[[elem objectForKey:@"flight"] intValue]];
            monthlyBill.hotel = [NSString stringWithFormat:@"%d",[[elem objectForKey:@"hotel"] intValue]];
            monthlyBill.car = [NSString stringWithFormat:@"%d",[[elem objectForKey:@"car"] intValue]];
            monthlyBill.lcdCurrency = [NSString stringWithFormat:@"%d",[[elem objectForKey:@"lcdCurrency"] intValue]];
            [array addObject:monthlyBill];
            [monthlyBill release];
        }
    }
    aMyMonthlyBills.monthsArray = array;
    [array release];
    if ([aMyMonthlyBills.monthsArray count]==0) {
        aMyMonthlyBills.monthsArray = nil;
    }
    return aMyMonthlyBills;
}
@end
