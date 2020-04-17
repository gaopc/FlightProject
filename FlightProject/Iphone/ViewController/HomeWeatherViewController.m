//
//  HomeWeatherViewController.m
//  FlightProject
//
//  Created by gaopengcheng on 14-12-12.
//
//

#import "HomeWeatherViewController.h"
#import "NSDate+convenience.h"
#import "HomeWeatherTableViewCell.h"
#import "CityListViewController.h"

@interface HomeWeatherViewController ()

@end

@implementation HomeWeatherViewController
@synthesize _queryWeatherInfo, _cityName, _areaCode;
@synthesize server;

- (void)dealloc
{
    self._queryWeatherInfo = nil;
    self._cityName = nil;
    self.server = nil;
    self._areaCode = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"天气";
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight - 45) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor whiteColor];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.bounces = NO;
    [self.view addSubview:myTable];
    [myTable release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self._isLoadView) {
        self._isLoadView = NO;
        ASIFormDataRequest * theRequest = [InterfaceClass queryWeatherInfoByAirportCode:self._cityName];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onWeatherCityPaseredResult:) Delegate:self needUserType:Default];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self._queryWeatherInfo) {
        return 1;
    }
    return self._queryWeatherInfo.weatherInfoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 170;
    }
    else {
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AirportWeatherInfo *weatherData = [self._queryWeatherInfo.weatherInfoList objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        static NSString *identifier0 = @"identifier0";
        HomeWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
        if (cell == nil) {
            cell = [[HomeWeatherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell._areaBut addTarget:self action:@selector(selectArea:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (!weatherData) {
            cell._areaLab.text = self._cityName;
            cell._temperatureLab.text = nil;
            cell._weatherLab.text = nil;
            cell._windLab.text = nil;
            cell._qualityLab.text = nil;
            cell._updateLab.text = nil;
            cell._imgView.image = nil;
            return cell;
        }
        cell._areaLab.text = self._cityName;
        cell._temperatureLab.text = [NSString stringWithFormat:@"%@/%@", weatherData.topTemperature, weatherData.lowTemperature];
        cell._weatherLab.text = [NSString stringWithFormat:@"天气：%@", weatherData.weather];
        cell._windLab.text = [NSString stringWithFormat:@"风力：%@", weatherData.wind];
        cell._qualityLab.text = [NSString stringWithFormat:@"空气质量：%@", weatherData.airQuality];
        cell._updateLab.text = [NSString stringWithFormat:@"更新时间：%@", self._queryWeatherInfo.updateDate];
        cell._imgView.urlString = weatherData.imageUrl;
        
        return cell;
    }
    else {
        static NSString *identifier = @"identifier";
        HomeWeatherListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[HomeWeatherListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell._weatherLab.text = weatherData.weather;
        cell._imgView.urlString = weatherData.imageUrl;
        cell._temperatureLab.text = [NSString stringWithFormat:@"%@~%@", weatherData.lowTemperature, weatherData.topTemperature];
        
        if (indexPath.row != 1) {
            NSString *stringNextDate = [NSDate dateafterDay:[NSDate date] day:indexPath.row type:7];
            cell._dateLab.text = stringNextDate;
        }
        else {
            cell._dateLab.text = @"明天";
        }
        return cell;
    }
}

- (void)selectArea:(UIButton *)sender
{
    NSArray * array =  [DataClass selectFromWeatherCityList];
    if ( [GetConfiguration shareGetConfiguration].needUpdateWeatherCitysList || [array count] == 0) {
        GetBasicInfoFromServer *temp = [[GetBasicInfoFromServer alloc] init];
        temp.cityDelegate = self;
        self.server = temp;
        [self.server getWeatherCitysList];
        [temp release];
    }
    else {
        [self didCityInfoResult:array];
    }
}

- (void)didCityInfoResult:(NSArray *)cityArray
{
    CityListViewController * citylistVC = [[CityListViewController alloc] init];
    citylistVC.citysArray = cityArray;
    citylistVC.cityType = WeatherList;
    citylistVC.delegate = self;
    citylistVC.title = @"城市选择";
    
    [ NavigationController pushViewController:citylistVC animated:YES];
    [citylistVC release];
}

-(void)didSelectedCityFinshed:(id)city
{
    
//    if (self._isCityWeather) {
//        Citys *cityInfo = city;
//        self._cityName = cityInfo._city_name;
//        self._areaCode = cityInfo._city_code;
//    }
//    else {
//        AirportList * airportInfo = (AirportList *)city;
//        self._cityName = airportInfo._city_name;
//        self._areaCode = airportInfo._city_code;
//    }
    Citys *cityInfo = city;
    self._cityName = cityInfo._city_name;
    self._areaCode = cityInfo._city_code;
    self._isLoadView = YES;
    
}

- (void)onWeatherCityPaseredResult:(NSDictionary *)dic
{
    if([[dic objectForKey:@"weatherInfoList"] isKindOfClass:[NSNull class]])
    {
        self._queryWeatherInfo = nil;
        [myTable reloadData];
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
        return;
    }
    
//    if (self._isCityWeather)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self._cityName forKey:WeatherSelectCity];
        [defaults synchronize];
    }
    self._queryWeatherInfo = [QueryWeatherInfo GetQueryWeatherInfoByAirportCode:dic];
    [myTable reloadData];
}
@end
