//
//  AirportKnowledgeRootViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AirportKnowledgeRootViewController.h"
#import "AirPortListViewController.h"


@implementation AirportData
@synthesize airportCode,airportName;

- (void)dealloc
{
    self.airportName = nil;
    self.airportCode = nil;
    [super dealloc];
}

+(AirportData*)AirportDataWithName:(NSString*)name CODE:(NSString*)code
{
    AirportData *model = [[AirportData alloc] init];
    model.airportName = name;
    model.airportCode = code;
    return [model autorelease];
}
@end


@interface AirportKnowledgeRootViewController ()

@end

@implementation AirportKnowledgeRootViewController
@synthesize airportNameLabel,enterAirlinesVC,airPortData;
@synthesize delegate;
@synthesize server;
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
    self.enterAirlinesVC = NO;
    
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) image:[UIImage imageNamed:@"航班动态背景.png"]]];
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 2, 300, 56) image:[UIImage imageNamed:@"AKVC-selectAirport.png"]]];//(10, 7, 300, 56)
    [self.view addSubview:[UISubLabel labelWithTitle:@"机场选择" frame:CGRectMake(30, 13, 50, 12) font:FontSize24 alignment:NSTextAlignmentLeft]];
    self.airportNameLabel = [UISubLabel labelWithTitle:self.airPortData.airportName frame:CGRectMake(30, 28, 200, 20) font:FontSize30 color:FontColor0066CC alignment:NSTextAlignmentLeft];
    [self.view addSubview:self.airportNameLabel];
    [self.view addSubview:[UIButton buttonWithTag:99 frame:CGRectMake(10, 7, 300, 56) target:self action:@selector(selectAirport:)]];
    	// Do any additional setup after loading the view.
}

//-(void)selectAirport:(UIButton*)sender
//{
//    self.enterAirlinesVC = YES;
//    AirPortListViewController *airPortListVC = [[AirPortListViewController alloc] init];
//    airPortListVC.airPortData = self.airPortData;
//    [NavigationController pushViewController:airPortListVC animated:YES];
//    [airPortListVC release];
//}

-(void)selectAirport:(UIButton *) sender // zxt 20121027  修改
{
    self.enterAirlinesVC = YES;
    
    NSArray * array =  [DataClass selectFromAirportList];
    if ([GetConfiguration shareGetConfiguration].needUpdateAirportInfo || [array count] == 0) {
        GetBasicInfoFromServer *basicInfoFromServer = [[GetBasicInfoFromServer alloc] init];
        self.server = basicInfoFromServer;
        [basicInfoFromServer release];
        self.server.cityDelegate = self;
        [self.server getAirportInfo];
        return;
    }
    else {
        [self didCityInfoResult:array];
    }
}

- (void)didCityInfoResult:(NSArray *)cityArray
{
    CityListViewController * cityListVC = [[CityListViewController alloc] init];
    cityListVC.citysArray = cityArray;
    cityListVC.title = @"机场选择";
    cityListVC.cityType = AirportsList;
    cityListVC.delegate = self;
    [NavigationController pushViewController:cityListVC animated:YES];
    [cityListVC release];
}

-(void)didSelectedCityFinshed:(id)city // zxt 20121027 添加  选择完城市的代理方法
{
     AirportList * _city = (AirportList *)city; 
     self.airPortData.airportName = _city._city_name;
     self.airPortData.airportCode = _city._city_code;
}


-(void)setNameLabelText:(AirportData*)data
{
    self.airPortData = [AirportData AirportDataWithName:data.airportName CODE:data.airportCode];
    [self.airportNameLabel setText:airPortData.airportName];
}
-(void)setMyCureentView:(UIView*)aView
{
    [self.view addSubview:aView];
}
- (void)dealloc
{
    self.airportNameLabel = nil;
    self.airPortData = nil;
    self.server = nil;
    delegate = nil;
    [super dealloc];
}
-(void)reloadViewData{}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadViewData)]) {
        [self.delegate performSelector:@selector(reloadViewData)];
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
