//
//  SearchFlightsBriefInfoResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchFlightsBriefInfoResponse.h"
@implementation SearchFlightsBriefInfoRequest
@synthesize flightType;
@synthesize dptCity;
@synthesize dstCity;
@synthesize departureDate;
@synthesize returnDate;
@synthesize airLine;
@synthesize isDirect;

-(void)dealloc{
	self.flightType = nil;
    self.dptCity = nil;
    self.dstCity = nil;
    self.departureDate = nil;
    self.returnDate = nil;
    self.airLine = nil;
    self.isDirect = nil;
    [super  dealloc];
}

-(id)init{
	self = [super init];
	if (self) {
		
	}
	return self;
}

@end

@implementation FlightsBriefInfo

@synthesize airLine;
@synthesize flightNo;
@synthesize startAirPort;
@synthesize departureTime;
@synthesize endAirPort;
@synthesize arrivalTime;
@synthesize stopNo;
@synthesize stopCity;
@synthesize isFood;
@synthesize isCodeShare;
@synthesize carrier;
@synthesize planeType;
@synthesize fullPrice;

@synthesize cabinItems;
@synthesize flightDelay;
@synthesize SflightTerminal,EflightTerminal;
@synthesize cabin;
@synthesize adultTax,childTax;
-(void)dealloc
{
    self.airLine = nil;
    self.flightNo = nil;
    self.startAirPort = nil;
    self.departureTime = nil;
    self.endAirPort = nil;
    self.arrivalTime = nil;
    self.stopNo = nil;
    self.stopCity = nil;
    self.isFood = nil;
    self.isCodeShare = nil;
    self.carrier = nil;
    self.planeType = nil;
    self.fullPrice = nil;
    self.cabinItems = nil;
    self.flightDelay = nil;
    self.SflightTerminal = nil;
    self.EflightTerminal = nil;
    self.cabin = nil;
    self.adultTax = nil;
    self.childTax = nil;
    [super dealloc];
}
-(NSString *)description
{
    NSString * str = [NSString stringWithFormat:@"airLine=%@,flightNo=%@,startAirPort=%@,departureTime=%@,endAirPort=%@,arrivalTime=%@,stopNo=%@,stopCity=%@,isFood=%@,isCodeShare=%@,carrier=%@,planeType=%@,fullPrice=%@,cabinItems=%@,flightDelay=%@,SflightTerminal=%@,EflightTerminal=%@",self.airLine,self.flightNo,self.startAirPort,self.departureTime,self.endAirPort,self.arrivalTime,self.stopNo,self.stopCity,self.isFood,self.isCodeShare,self.carrier,self.planeType,self.fullPrice,self.cabinItems,self.flightDelay,self.SflightTerminal,self.EflightTerminal];
    return str;
}


@end

@implementation SearchFlightsBriefInfoResponse
@synthesize startWeather,arrivaWeather,flightsBriefInfo;
-(void)dealloc
{
    self.startWeather = nil;
    self.arrivaWeather = nil;
    self.flightsBriefInfo = nil;
    [super dealloc];
}

+(FlightsBriefInfo *)searchFlightsBriefInfoResponseWithElem:(NSArray *)elem
{
    FlightsBriefInfo * briefInfo = [[FlightsBriefInfo alloc] init];
    briefInfo.airLine = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    briefInfo.flightNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    briefInfo.startAirPort = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    briefInfo.departureTime = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    briefInfo.endAirPort = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    briefInfo.arrivalTime = [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
    briefInfo.stopNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:6]];
    briefInfo.stopCity = [NSString stringWithFormat:@"%@",[elem objectAtIndex:7]];
    briefInfo.isFood = [NSString stringWithFormat:@"%@",[elem objectAtIndex:8]];
    briefInfo.isCodeShare = [NSString stringWithFormat:@"%@",[elem objectAtIndex:9]];
    briefInfo.carrier = [NSString stringWithFormat:@"%@",[elem objectAtIndex:10]];
    briefInfo.planeType = [NSString stringWithFormat:@"%@",[elem objectAtIndex:11]];
    briefInfo.fullPrice = [NSString stringWithFormat:@"%@",[elem objectAtIndex:12]];
    NSMutableArray *citems = [[NSMutableArray alloc] init];
    NSString *cis =  [NSString stringWithFormat:@"%@",[elem objectAtIndex:13]];
    NSArray *cia = [cis componentsSeparatedByString:@"+"];
    for (NSString *ci in cia) {
        NSArray *cit = [ci componentsSeparatedByString:@";"];
        int count = [cit count];
        if (count >= 6) {
            CabinItem *cabinItem = [[CabinItem alloc] init];
            cabinItem.cabinNO = [cit objectAtIndex:0];//舱位代码
            cabinItem.sits = [cit objectAtIndex:1];//剩余座位数
            cabinItem.discount = [cit objectAtIndex:2];//折扣率
            cabinItem.baseCabin = [cit objectAtIndex: 3];//基准舱位
            cabinItem.moneyType = [cit objectAtIndex:4];//货币类型
            cabinItem.oneWayPrice = [cit objectAtIndex:5];//单程价格（折扣价）
            cabinItem.cabinType = [cit objectAtIndex: 6];//舱位类型(0为正常折扣舱位,1为单程特价舱位,2是往返特价舱位)
            if (count > 7) 
                cabinItem.specialFlightNum = ([cit objectAtIndex: 7]==[NSNull null]?@"":[cit objectAtIndex: 7]);
            else cabinItem.specialFlightNum = @"";
            if (count > 8) {
                cabinItem.specialBaseCabin = [cit objectAtIndex: 7];
            }
            else cabinItem.specialBaseCabin = @"";
            
            [citems addObject:cabinItem];
            [cabinItem release];
        }
    }
    //排序
    for(int i=0;i<[citems count];i++)
    {
        CabinItem *cabinItem =[[citems objectAtIndex:i] retain];
        if([cabinItem.cabinNO isEqualToString:@"F"])
        {
            [citems removeObjectAtIndex:i];
            [citems insertObject:cabinItem atIndex:[citems count]];
        }
        [cabinItem release];
    }
    briefInfo.cabinItems = citems;
    [citems release];
    briefInfo.flightDelay = [NSString stringWithFormat:@"%@",[elem objectAtIndex:14]];
    briefInfo.SflightTerminal = [NSString stringWithFormat:@"%@",[elem objectAtIndex:15]];
    briefInfo.EflightTerminal = [NSString stringWithFormat:@"%@",[elem objectAtIndex:16]];
    return [briefInfo autorelease];
}
+(WeatherInfo *)GetWeatherInfoWithArray:(NSArray *)resultArray
{
    WeatherInfo * weatherInfo =  [[WeatherInfo alloc] init];

    weatherInfo.city = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:0]];
    weatherInfo.updateDate = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:1]];
    weatherInfo.liveWeather = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
    weatherInfo.airQuality = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:3]];
    weatherInfo.weatherIndex = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:4]];
    weatherInfo.weather = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:5]];
    weatherInfo.temperature = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:6]];
    weatherInfo.wind = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:7]];
    weatherInfo.image1 = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:8]];
    weatherInfo.image2 = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:9]];

     return [weatherInfo autorelease];
}

+(SearchFlightsBriefInfoResponse *)searchFlightsBriefInfoResponseWithArray:(NSArray *)resultArray
{
    SearchFlightsBriefInfoResponse * instance = [[SearchFlightsBriefInfoResponse alloc] init];
    
    NSArray * array = [resultArray objectAtIndex:0];
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) 
    {
        NSString * sWeather = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
        NSArray * sWeatherArray = [sWeather componentsSeparatedByString:@"&"];
        if ([sWeatherArray count] >9) {
            instance.startWeather = [self GetWeatherInfoWithArray:sWeatherArray];
        }
        else{
            instance.startWeather = nil;
        }
        
        NSString * eWeather = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
        NSArray * eWeatherArray = [eWeather componentsSeparatedByString:@"&"];
        if ([eWeatherArray count] >9) {
            instance.arrivaWeather = [self GetWeatherInfoWithArray:eWeatherArray];
        }
        else{
            instance.arrivaWeather = nil;
        }

        NSMutableArray * mArray = [[NSMutableArray alloc] init];
        for (int i = 1 ; i< [resultArray count] ; i++) {
            NSArray * elem = [resultArray objectAtIndex:i];
            [mArray addObject:[self searchFlightsBriefInfoResponseWithElem:elem]];
        }
       instance.flightsBriefInfo = mArray;
       [mArray release];
    }
    else
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[array objectAtIndex:1]] ];
    }
    
    return [instance autorelease];
}

+(CabinItem *)cabinItemWithCabin:(CabinItem *)cabin addAirportCode:(NSString *)airport_code
{
    CabinItem * returnCabin = [[CabinItem alloc] init];
    NSString * code = [[NSString stringWithFormat:@"%@%@",airport_code,cabin.cabinNO] uppercaseString] ;
    returnCabin.cabinNO =[NSString stringWithFormat:@"%@%@",[cabin.cabinNO uppercaseString],[DataClass selectFromBunkInfoWithCode:code]] ;
    returnCabin.oneWayPrice = [NSString stringWithFormat:@"¥%d",[cabin.oneWayPrice intValue]/100];
    float  discount = [cabin.discount floatValue] * 10;
    if (discount / 100 == 10.0) {
        returnCabin.discount = [NSString stringWithFormat:@"全价"];
    }
    else if  (discount / 100 < 10.0){
        returnCabin.discount = [NSString stringWithFormat:@"%.1f折", discount / 100.0f ];
    }
    else {
        returnCabin.discount = [NSString stringWithFormat:@"%.0f%@", discount / 10,@"%" ];
    }
    
    returnCabin.sits = [NSString stringWithFormat:@"座位数: %@",cabin.sits];
    return [returnCabin autorelease];
}
+(CabinItem *)cabinItemWithArray:(NSArray *)array addAirportCode:(NSString *)airport_code
{
    float  discout = 50000.0f;
    CabinItem * returnCabin = nil;
    for (CabinItem * cabin in array) {
        if (discout > [cabin.discount floatValue]) {
            discout = [cabin.discount floatValue];
            returnCabin = [self cabinItemWithCabin:cabin addAirportCode:airport_code];
        }
    }
    return returnCabin;
}
+(FlightsBriefInfo *)searchFlightsBriefInfoWithBriefInfo : (FlightsBriefInfo *)briefInfo
{
    FlightsBriefInfo * returnBriefInfo = [[FlightsBriefInfo alloc] init];
    returnBriefInfo.flightNo = briefInfo.flightNo;
    returnBriefInfo.airLine = [DataClass selectFromAirlinesWithCode:briefInfo.airLine];
    returnBriefInfo.startAirPort = [NSString stringWithFormat:@"起:%@%@",[DataClass selectFromCitysWithCode:briefInfo.startAirPort], briefInfo.SflightTerminal];
    returnBriefInfo.departureTime = [briefInfo.departureTime substringFromIndex:[briefInfo.departureTime length]-8];
    returnBriefInfo.endAirPort = [NSString stringWithFormat:@"降:%@%@",[DataClass selectFromCitysWithCode:briefInfo.endAirPort], briefInfo.EflightTerminal ];
    returnBriefInfo.arrivalTime = [briefInfo.arrivalTime substringFromIndex:[briefInfo.arrivalTime length]-8];
    returnBriefInfo.planeType = [NSString stringWithFormat:@"机型:%@",briefInfo.planeType];
    returnBriefInfo.cabin = [self cabinItemWithArray:briefInfo.cabinItems addAirportCode:briefInfo.airLine];
    return [returnBriefInfo autorelease];
}

@end
