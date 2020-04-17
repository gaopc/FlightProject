//
//  GetBasicInfoFromServer.m
//  FlightProject
//
//  Created by longcd on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetBasicInfoFromServer.h"
#import "JSON.h"
#import "DataClass.h"

@implementation GetBasicInfoFromServer
@synthesize delegate, cityDelegate,configerDic;


-(void)dealloc
{
    self.delegate = nil;
    self.cityDelegate = nil;
    self.configerDic = nil;
    [super dealloc];
}
- (NSArray *)getVersionsFromDB
{
    NSArray * array = [DataClass selectFromVersions];
    return array;
}
- (void) getConfiguration:(NSString *)deviceToken
{
    deviceToken = @""; // 20140512  zxt  添加了saveDeviceToken的接口，此方法token传“”
    NSArray  * array = [self getVersionsFromDB];
    //NSLog(@"%@",array);
    NSMutableDictionary * mDic = [NSMutableDictionary dictionary];
    for (NSArray * elem in array) {
        // @"table_name", @"version"
        [mDic setValue:[elem objectAtIndex:1] forKey:[elem objectAtIndex:0]];
    }
    
    //NSLog(@"数据库版本：%@",mDic);
    NSString * dbVersionStr = [NSString stringWithFormat:@"%@",[mDic objectForKey:@"DBVersion"]];
    
    if ([dbVersionStr intValue] < [DBVersion intValue] ){
         NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *originFilePath = [docPath stringByAppendingPathComponent:@"database.sqlite"];
        NSString *sqlFilePath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sqlite"];
        
        NSFileManager *fm = [NSFileManager defaultManager];//文件管理器
        if ([fm fileExistsAtPath:originFilePath] == YES) {
            NSError *error = nil;
            if([fm removeItemAtPath:originFilePath error:&error] == NO)
            {
                NSLog(@"删除数据库的时候出现了错误：%@",[error localizedDescription]);
            }

            if([fm copyItemAtPath:sqlFilePath toPath:originFilePath error:&error] == NO)
            {
                NSLog(@"创建数据库的时候出现了错误：%@",[error localizedDescription]);
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"热门航线" forKey:ticketSearchHistory_ThreeDemain];
                 [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"DBVersion",DBVersion, nil],nil]];
            }
        }
    }

    NSArray * _messageArray = [GetConfiguration shareGetConfiguration]._messageArray;
    if (_messageArray == nil) {
        [GetConfiguration shareGetConfiguration]._messageArray = [NSArray arrayWithObjects:@"请稍等，正在为您加载...", nil];
    }
    ASIFormDataRequest * theRequest = [InterfaceClass getConfigurationWithDeviceToken:deviceToken version:[NSString stringWithFormat:@"%d",MyVersionCode] userId:[UserInfo sharedUserInfo].userID?[UserInfo sharedUserInfo].userID:@""]; 
    
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onConfigurationPaseredResult:) Delegate:self needUserType:Default];
    
}
-(void)onConfigurationPaseredResultFail:(NSDictionary *)resultDic
{
    if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(didBasicInfoResult:)]) {  // zxt 1114 移动到最下面
        [self.cityDelegate performSelector:@selector(didBasicInfoResult:) withObject:resultDic];
    }
}
- (void) onConfigurationPaseredResult:(NSDictionary *) resultDic
{
    id maxNum = [resultDic objectForKey:@"maxFlyNum"];
    if ([maxNum isKindOfClass:[NSString class]]) {
        [[NSUserDefaults standardUserDefaults] setObject:[resultDic objectForKey:@"maxFlyNum"] forKey:keyMaxFlyNum];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:keyMaxFlyNum];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.configerDic = resultDic;
    
    id tempCityDelegate = [self.cityDelegate retain];
    
    if ([GetConfiguration shareGetConfiguration]._version == nil)
    {        
        GetConfiguration * configuration = [GetConfiguration shareGetConfiguration:resultDic];
        
        self.cityDelegate = nil;
        
        NSArray  * array = [self getVersionsFromDB];
        
        NSMutableDictionary * mDic = [NSMutableDictionary dictionary];
        for (NSArray * elem in array) {
            // @"table_name", @"version"
            [mDic setValue:[elem objectAtIndex:1] forKey:[elem objectAtIndex:0]];
        }
        configuration.needUpdateTrainCitysList = FALSE;
        configuration.needUpdateAirportInfo = FALSE;
        configuration.needUpdateAirportCityInfo = FALSE;
        configuration.needUpdateHotelCityList = FALSE;
        configuration.needUpdateCarRentalList = FALSE;
        configuration.needUpdateWeatherCitysList = FALSE;

        if ([(NSString *)[mDic objectForKey:@"TrainCitysList"] compare:configuration._trainCityVersion] < 0 ){
            configuration.needUpdateTrainCitysList = TRUE;
            self.cityDelegate = nil;
            [self getTrainCitysList];
        }
        
        if ([(NSString *)[mDic objectForKey:@"AirportList"] compare:configuration._airportVersion] < 0 ){
            configuration.needUpdateAirportInfo = TRUE;
            self.cityDelegate = nil;
            [self getAirportInfo];
        }
        
        if ([(NSString *)[mDic objectForKey:@"AirportCityList"] compare:configuration._airportCItyVersion] < 0 ){
            configuration.needUpdateAirportCityInfo = TRUE;
            self.cityDelegate = nil;
            [self getAirportCityInfo];
        }
        
        if ([(NSString *)[mDic objectForKey:@"HotelCityList"] compare:configuration._hotelCityVersion] < 0 ){
            configuration.needUpdateHotelCityList = TRUE;
            self.cityDelegate = nil;
            [self getHotelCityList];
        }
        
        if ([(NSString *)[mDic objectForKey:@"CarRentalList"] compare:configuration._carRentalVersion] < 0 ){
            configuration.needUpdateCarRentalList = TRUE;
            self.cityDelegate = nil;
            [self getCarRentalList];
        }
        
        if ([(NSString *)[mDic objectForKey:@"weatherCityVersion"] compare:configuration._weatherCithVersion] < 0 ){
            configuration.needUpdateWeatherCitysList = TRUE;
            self.cityDelegate = nil;
            [self getWeatherCitysList];
        }
    }
    else{
        
    }
    if (tempCityDelegate && [tempCityDelegate respondsToSelector:@selector(didBasicInfoResult:)]) {  // zxt 1114 移动到最下面
        [tempCityDelegate performSelector:@selector(didBasicInfoResult:) withObject:self.configerDic];
    }

}
- (void)getAirportInfo
{
    ASIFormDataRequest * theRequest = [InterfaceClass updateAirportList];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onAirportListPaseredResult:) Delegate:[self retain] needUserType:Default];
}
- (void)getAirportCityInfo
{
    ASIFormDataRequest * theRequest = [InterfaceClass updateAirportCityList];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onAirportCityInfoPaseredResult:) Delegate:[self retain] needUserType:Default];
}

-(void) getHotelCityList
{
    ASIFormDataRequest * theRequest = [InterfaceClass updateHotelCityList]; 
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onHotelCityListPaseredResult:) Delegate:[self retain] needUserType:Default];
}
-(void) getCarRentalList
{
    ASIFormDataRequest * theRequest = [InterfaceClass updateRentCityList];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCarRentalListPaseredResult:) Delegate:[self retain] needUserType:Default];
}
-(void) getTrainCitysList
{
    // zxt 20130702 将火车票城市列表数据改为写死到客户端
    
//    ASIFormDataRequest * theRequest = [InterfaceClass stationList];
//    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onTrainCitysListPaseredResult:) Delegate:[self retain] needUserType:Default];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"TrainCitysList" ofType:@"txt"];
//    NSString *str = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    
//    NSDictionary *  dic = [str JSONValue];
//    NSLog(@"%@",dic);
//    [self onTrainCitysListPaseredResult:dic];
    
     // zxt 20150608 将火车票城市列表数据改为从接口获取
    
    ASIFormDataRequest * theRequest = [InterfaceClass findStationList];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onTrainCitysListPaseredResult:) Delegate:[self retain] needUserType:Default];
}
- (void)getWeatherCitysList
{
    ASIFormDataRequest * theRequest = [InterfaceClass updateWeatherCityList];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onWeatherCityListPaseredResult:) Delegate:[self retain] needUserType:Default];
}
- (void) getTrainCitysVersion
{
    [GetConfiguration shareGetConfiguration].needUpdateTrainCitysList = TRUE;
    ASIFormDataRequest * theRequest = [InterfaceClass getTrainVersion];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onTrainVersionResult:) Delegate:[self retain] needUserType:Default];
}

-(void)onTrainVersionResult:(NSDictionary*)dic
{
    
    NSString * version = [dic objectForKey:@"versionStation"];
    
    NSArray  * array = [self getVersionsFromDB];
    NSMutableDictionary * mDic = [NSMutableDictionary dictionary];
    for (NSArray * elem in array) {
        [mDic setValue:[elem objectAtIndex:1] forKey:[elem objectAtIndex:0]];
    }
    if([mDic objectForKey:@"TrainCitysList"] == nil)
    {
        [GetConfiguration shareGetConfiguration].needUpdateTrainCitysList = TRUE;
        [GetConfiguration shareGetConfiguration]._trainCityVersion = version;
        self.cityDelegate = nil;
        [self getTrainCitysList];
    }
    else
    {
        if ([(NSString *)[mDic objectForKey:@"TrainCitysList"] compare:version] < 0 ){
            [GetConfiguration shareGetConfiguration].needUpdateTrainCitysList = TRUE;
            [GetConfiguration shareGetConfiguration]._trainCityVersion = version;
            self.cityDelegate = nil;
            [self getTrainCitysList];
        }
        else
        {
            [GetConfiguration shareGetConfiguration].needUpdateTrainCitysList = FALSE;
        }
    }
}

-(void) onTrainCitysListPaseredResult:(NSDictionary *) resultDic
{
    
    [self performSelectorInBackground:@selector(trainCitysListTread:) withObject:resultDic];
    
//    //[self performSelectorInBackground:@selector(trainCitysListTread:) withObject:resultDic];
//    [GetConfiguration shareGetConfiguration].needUpdateTrainCitysList = FALSE;
//    NSMutableArray * mArray = [NSMutableArray array];
//    for (NSDictionary * dic in [resultDic objectForKey:@"stationInfo"]) {
//        NSString * firstLetter = [NSString stringWithFormat:@"%@",[dic objectForKey:@"firstLetter"]];
//        NSString * code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]?[dic objectForKey:@"code"]:@""];
//        NSString * name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"stationName"]];
//        NSString * flag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"popular"]];
//        NSString * jianPin = [NSString stringWithFormat:@"%@",[dic objectForKey:@"jianPin"]?[dic objectForKey:@"jianPin"]:@""];
//        NSString * ename = [NSString stringWithFormat:@"%@",[dic objectForKey:@"quanPin"]?[dic objectForKey:@"quanPin"]:@""];
//        NSString *isshow = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isshow"]];
//        [mArray addObject:[NSArray arrayWithObjects:code, name,firstLetter, flag,jianPin,ename,isshow,nil]];
//    }
//    [DataClass insertIntoTrainCitysListWithArray:mArray];
//    [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"TrainCitysList",[GetConfiguration shareGetConfiguration]._trainCityVersion, nil], nil]];
//    if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(didCityInfoResult:)]) {
//        [self.cityDelegate performSelector:@selector(didCityInfoResult:) withObject:mArray];
//    }
}
-(void) trainCitysListTread:(NSDictionary *) resultDic
{
    [GetConfiguration shareGetConfiguration].needUpdateTrainCitysList = FALSE;
    NSArray * stationInfos = [resultDic objectForKey:@"stationInfos"];
    NSMutableArray * mArray = [NSMutableArray array];
    if ([stationInfos isKindOfClass:[NSArray class]]) {
        for (NSDictionary * dic in stationInfos) {
            NSString * firstLetter = [NSString stringWithFormat:@"%@",[dic objectForKey:@"firstLetter"]];
            NSString * code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"stationCode"]?[dic objectForKey:@"stationCode"]:@""];
            NSString * name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"stationName"]];
            NSString * flag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flag"]];
            NSString * jianPin = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nameSimple"]?[dic objectForKey:@"nameSimple"]:@""];
            NSString * ename = [NSString stringWithFormat:@"%@",[dic objectForKey:@"namFull"]?[dic objectForKey:@"namFull"]:@""];
            firstLetter = [ename substringToIndex:1];
            NSString *isshow = @"1";
            [mArray addObject:[NSArray arrayWithObjects:code, name,firstLetter, flag,jianPin,ename,isshow,nil]];
        }
        [DataClass insertIntoTrainCitysListWithArray:mArray];
        [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"TrainCitysList",[GetConfiguration shareGetConfiguration]._trainCityVersion, nil], nil]];
    }
    if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(didCityInfoResult:)]) {
        [self.cityDelegate performSelector:@selector(didCityInfoResult:) withObject:mArray];
    }
}

-(void)onWeatherCityListPaseredResult:(NSDictionary*)resultDic
{
    [GetConfiguration shareGetConfiguration].needUpdateWeatherCitysList = FALSE;
    NSArray * weatherCityList = [resultDic objectForKey:@"weatherCityList"];
    NSMutableArray * mArray = [NSMutableArray array];
    if ([weatherCityList isKindOfClass:[NSArray class]]) {
        for (NSDictionary * dic in weatherCityList) {
            NSString * firstLetter = [NSString stringWithFormat:@"%@",[dic objectForKey:@"firstLetter"]];
            NSString * code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cityId"]?[dic objectForKey:@"cityId"]:@""];
            NSString * name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cityName"]];
            NSString * flag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flag"]];
            NSString * jianPin = [NSString stringWithFormat:@"%@",[dic objectForKey:@"jianPin"]?[dic objectForKey:@"jianPin"]:@""];
            NSString * ename = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ename"]?[dic objectForKey:@"ename"]:@""];
            [mArray addObject:[NSArray arrayWithObjects:code, name,firstLetter, flag,jianPin,ename,nil]];
        }
        [DataClass insertIntoWeatherCitysListWithArray:mArray];
        [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"WeatherCityList",[GetConfiguration shareGetConfiguration]._weatherCithVersion, nil], nil]];
    }
    if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(didCityInfoResult:)]) {
        [self.cityDelegate performSelector:@selector(didCityInfoResult:) withObject:mArray];
    }
    
}
-(void) airportListTread:(NSDictionary *) resultDic
{
    [GetConfiguration shareGetConfiguration].needUpdateAirportInfo = FALSE;
    
    NSMutableArray * mArray = [NSMutableArray array];
    NSArray * hotelCity = [resultDic objectForKey:@"airportList"];
    if ([hotelCity isKindOfClass:[NSArray class]]) {
        for (NSDictionary * dic in hotelCity) {
            NSString * firstLetter = [NSString stringWithFormat:@"%@",[dic objectForKey:@"firstLetter"]];
            NSString * code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            NSString * name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            NSString * flag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flag"]];
            NSString * jianPin = [NSString stringWithFormat:@"%@",[dic objectForKey:@"jianPin"]?[dic objectForKey:@"jianPin"]:@""];
            NSString * ename = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ename"]?[dic objectForKey:@"ename"]:@""];
            [mArray addObject:[NSArray arrayWithObjects:firstLetter, code, name,flag,jianPin,ename,nil]];
        }
        [DataClass insertIntoAirportListWithArray:mArray];
        [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"AirportList",[GetConfiguration shareGetConfiguration]._airportVersion, nil], nil]];
    }
    if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(didCityInfoResult:)]) {
        [self.cityDelegate performSelector:@selector(didCityInfoResult:) withObject:mArray];
    }

}
-(void) onAirportListPaseredResult:(NSDictionary *) resultDic
{
    [self performSelectorInBackground:@selector(airportListTread:) withObject:resultDic];
}
-(void) airportCityTread:(NSDictionary *)resultDic
{
    [GetConfiguration shareGetConfiguration].needUpdateAirportCityInfo = FALSE;
    NSString * beijingCode = @"";
    NSString * shanghaiCode = @"";
    NSString * guangzhouCode = @"";
    NSMutableArray * mArray = [NSMutableArray array];
    NSArray * hotelCity = [resultDic objectForKey:@"airportCityList"];
    if ([hotelCity isKindOfClass:[NSArray class]]) {
        for (NSDictionary * dic in hotelCity) {
            NSString * code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            NSString * name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            
            [mArray addObject:[NSArray arrayWithObjects:code, name,[NSString stringWithFormat:@"%@",[dic objectForKey:@"ename"]],[NSString stringWithFormat:@"%@",[dic objectForKey:@"firstLetter"]],[NSString stringWithFormat:@"%@",[dic objectForKey:@"jianPin"]],[NSString stringWithFormat:@"%@",[dic objectForKey:@"flag"]],nil]];
            
            if ([name isEqualToString:@"北京"]) {
                beijingCode = [code retain];
            }
            else if ([name isEqualToString:@"上海"]){
                shanghaiCode = [code retain];
            }
            else if ([name isEqualToString:@"广州"]){
                guangzhouCode = [code retain];
            }
            
        }
        [DataClass insertIntoAirportCityListWithArray:mArray];
        [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"AirportCityList",[GetConfiguration shareGetConfiguration]._airportCItyVersion, nil], nil]];
    }
    if ([[DataClass selectFromFlight_Search_History] count] == 0) {
        //北京—上海、北京—广州、上海—广州、上海—北京
        [DataClass insertIntoFlight_City_HotWithArray:[NSArray arrayWithObjects: [NSArray arrayWithObjects:shanghaiCode, @"上海",beijingCode,@"北京",nil],[NSArray arrayWithObjects:shanghaiCode, @"上海",guangzhouCode,@"广州",nil],[NSArray arrayWithObjects:beijingCode, @"北京",guangzhouCode,@"广州",nil],[NSArray arrayWithObjects:beijingCode, @"北京",shanghaiCode,@"上海",nil],nil]];
    }
    [beijingCode release];
    [shanghaiCode release];
    [guangzhouCode release];
    
    if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(didCityInfoResult:)]) {
        [self.cityDelegate performSelector:@selector(didCityInfoResult:) withObject:mArray];
    }

}
- (void)onAirportCityInfoPaseredResult:(NSDictionary *)resultDic
{
    [self performSelectorInBackground:@selector(airportCityTread:) withObject:resultDic];
}
-(void)hotelCityListTread:(NSDictionary *)resultDic
{
    [GetConfiguration shareGetConfiguration].needUpdateHotelCityList = FALSE;
    NSMutableArray * mArray = [NSMutableArray array];

    NSArray * hotelCity = [resultDic objectForKey:@"hotelCity"];
    if ([hotelCity isKindOfClass:[NSArray class]]) {

        for (NSDictionary * dic in hotelCity) {
            NSString * firstLetter = [NSString stringWithFormat:@"%@ ",[dic objectForKey:@"firstLetter"]];
            NSString * code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            NSString * name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            NSString * flag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flag"]];
            NSString * jianPin = [NSString stringWithFormat:@"%@",[dic objectForKey:@"jianPin"]?[dic objectForKey:@"jianPin"]:@""];
            NSString * ename = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ename"]?[dic objectForKey:@"ename"]:@""];
            [mArray addObject:[NSArray arrayWithObjects:code,name,firstLetter,flag,jianPin,ename,nil]]; // 20121026 添加 firstLetter
            
        }
        [DataClass insertIntoHotelCityListWithArray:mArray];
        [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"HotelCityList",[GetConfiguration shareGetConfiguration]._hotelCityVersion, nil], nil]];
    }
   
    
    if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(didCityInfoResult:)]) {
        [self.cityDelegate performSelector:@selector(didCityInfoResult:) withObject:mArray];
    }
}
-(void) onHotelCityListPaseredResult:(NSDictionary *) resultDic
{
    [self performSelectorInBackground:@selector(hotelCityListTread:) withObject:resultDic];
}
-(void)carRentalListTread:(NSDictionary *)resultDic
{
    [GetConfiguration shareGetConfiguration].needUpdateCarRentalList = FALSE;
    NSMutableArray * mArray = [NSMutableArray array];

    NSArray * hotelCity = [resultDic objectForKey:@"rentCity"];
    if ([hotelCity isKindOfClass:[NSArray class]]) {
        for (NSDictionary * dic in hotelCity) {
            NSString * firstLetter = [NSString stringWithFormat:@"%@",[dic objectForKey:@"firstLetter"]];
            NSString * code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            NSString * name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            NSString * flag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flag"]];
            NSString * jianPin = [NSString stringWithFormat:@"%@",[dic objectForKey:@"jianPin"]?[dic objectForKey:@"jianPin"]:@""];
            NSString * ename = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ename"]?[dic objectForKey:@"ename"]:@""];
            [mArray addObject:[NSArray arrayWithObjects:code,name,firstLetter,flag,jianPin,ename,nil]]; // 20121026 添加 firstLetter
        }
        [DataClass insertIntoCarRentalListWithArray:mArray];
        [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"CarRentalList",[GetConfiguration shareGetConfiguration]._carRentalVersion, nil], nil]];
    }
    if (self.cityDelegate && [self.cityDelegate respondsToSelector:@selector(didCityInfoResult:)]) {
        [self.cityDelegate performSelector:@selector(didCityInfoResult:) withObject:mArray];
    }

}
-(void) onCarRentalListPaseredResult:(NSDictionary *) resultDic
{
    [self performSelectorInBackground:@selector(carRentalListTread:) withObject:resultDic];
}

@end
