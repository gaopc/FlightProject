//
//  AirportKnowledgeViewController.m
//  FlightProject
//
//  Created by longcd on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AirportKnowledgeViewController.h"
#import "HomeButtonsView.h"
#import "HomeWeatherViewController.h"
#import "AirportTrafficViewController.h"
#import "AirlineViewController.h"
#import "AirportInfoViewController.h"
#import "PeripheryServicesViewController.h"
#import "PassengerNoticeViewController.h"
#import "DevicePositionMapViewController.h"
#import "AirportWeatherViewController.h"

@interface AirportKnowledgeViewController ()

@end

@implementation AirportKnowledgeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setNameLabelText:[AirportData AirportDataWithName:@"北京首都国际机场" CODE:@"PEK"]];
    HomeButtonsView *homeButtonsView = [[HomeButtonsView alloc] initWithFrame:CGRectMake(0,56, ViewWidth, 300)];//(0,61, 320, 300)
    homeButtonsView.delegate = self;
    [self setMyCureentView:homeButtonsView];
    [homeButtonsView release];
}

- (void)dealloc
{
    [super dealloc];
}

-(void)reloadTableView
{
    if(self.enterAirlinesVC)
    {
        [self.airportNameLabel setText:self.airPortData.airportName];
    }
    self.enterAirlinesVC = NO;
}
-(void)clickButton:(UIButton*)sender
{
    switch (sender.tag) {
        case 0:
        {
            ASIFormDataRequest * theRequest = [InterfaceClass queryWeatherInfoByAirportCode:self.airPortData.airportCode];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onWeatherInfoPaseredResult:) Delegate:self needUserType:Default]; 
        }
            break;
        case 1:
        {
            PassengerNoticeViewController *passengerNoticeVC = [[PassengerNoticeViewController alloc] init];
            [NavigationController pushViewController:passengerNoticeVC animated:YES];
            [passengerNoticeVC release];
        }
            break;
        case 2:
        {
            AirportInfoViewController *airportInfoVC = [[AirportInfoViewController alloc] init];
            airportInfoVC.data = [AirportData AirportDataWithName:self.airPortData.airportName CODE:self.airPortData.airportCode];
            [NavigationController pushViewController:airportInfoVC animated:YES];
            [airportInfoVC release];
        }
            break;
        case 3:
        {
            AirlineViewController *airlineVC = [[AirlineViewController alloc] init];
            [NavigationController pushViewController:airlineVC animated:YES];
            [airlineVC release];
        }
            break;
        case 4:
        {
            DevicePositionMapViewController *devicePositionMapVC = [[DevicePositionMapViewController alloc] init];
            [NavigationController pushViewController:devicePositionMapVC animated:YES];
            [devicePositionMapVC release];
        }
            break;
        case 5:
        {
            AirportTrafficViewController *airportTrafficVC = [[AirportTrafficViewController alloc] init];
            airportTrafficVC.data = [AirportData AirportDataWithName:self.airPortData.airportName CODE:self.airPortData.airportCode];
            [NavigationController pushViewController:airportTrafficVC animated:YES];
            [airportTrafficVC release];
        }
            break;
        default:
        {
            ASIFormDataRequest * theRequest = [InterfaceClass queryFacilityServiceByAirportCode:self.airPortData.airportCode];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onFacilityServicePaseredResult:) Delegate:self needUserType:Default]; 
        }
            break;
    }
}

-(void)onWeatherInfoPaseredResult:(NSDictionary*)dic
{
    if([(NSArray*)[dic objectForKey:@"weatherInfoList"] count] < 7)
    {
        return;
    }
    AirportWeatherViewController *airportWeatherVC = [[AirportWeatherViewController alloc] init];
    airportWeatherVC.queryWeatherInfo = (QueryWeatherInfo*)[QueryWeatherInfo GetQueryWeatherInfoByAirportCode:dic];
    airportWeatherVC.data = [AirportData AirportDataWithName:self.airPortData.airportName CODE:self.airPortData.airportCode];
    [NavigationController pushViewController:airportWeatherVC animated:YES];
    [airportWeatherVC release];
    
    
//    HomeWeatherViewController *weatherVC = [[HomeWeatherViewController alloc] init];
//    weatherVC._cityName = self.airPortData.airportName;
//    weatherVC._queryWeatherInfo = [QueryWeatherInfo GetQueryWeatherInfoByAirportCode:dic];
//    [NavigationController pushViewController:weatherVC animated:YES];
//    [weatherVC release];
}

-(void)onFacilityServicePaseredResult:(NSDictionary*)dic
{
    PeripheryServicesViewController *peripheryServicesVC = [[PeripheryServicesViewController alloc] init];
    peripheryServicesVC.queryFacilityService = (QueryFacilityService*)[QueryFacilityService GetQueryFacilityServiceByAirportCode:dic];
    peripheryServicesVC.data = [AirportData AirportDataWithName:self.airPortData.airportName CODE:self.airPortData.airportCode];
    [NavigationController pushViewController:peripheryServicesVC animated:YES];
    [peripheryServicesVC release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
