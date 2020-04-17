//
//  CityListViewController.m
//  FlightProject
//
//  Created by longcd on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CityListViewController.h"
#import "TicketQueryViewController.h"
#import "TaxiHomeViewController.h"
#import "GetBasicInfoFromServer.h"
#import "FlightTrendsViewController.h"
#import "JSON.h"

@interface CityListViewController ()

@end

@implementation CityListViewController

@synthesize citysDataDic,allKeys;
@synthesize citysArray;
@synthesize cityType;
@synthesize delegate;
@synthesize keyboardbar;
@synthesize hotName;
@synthesize allCitysArray;
@synthesize domesticCitiesBtn,internationalCitiesBtn;
@synthesize myTextField;
-(void)dealloc
{
    self.citysArray = nil;
    self.citysDataDic = nil;
    self.allKeys = nil;
    self.delegate = nil;
    self.keyboardbar = nil;
    self.hotName = nil;
    self.allCitysArray = nil;
    self.domesticCitiesBtn = nil;
    self.internationalCitiesBtn = nil;
    self.myTextField = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) citysDicFromArray:(NSArray *)arr
{
    NSDictionary * dic = [Citys AirportCitysDicFromArray:arr hotName:self.hotName];
    self.citysDataDic = dic;
    // 热点放在第一位
    self.allKeys = nil;
    NSArray * tempArray = [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    if (tempArray) {
        NSMutableArray * mArray = [NSMutableArray array];
        if ([tempArray containsObject:self.hotName]) {
            [mArray addObject:self.hotName];
            NSRange range = {0,[tempArray count]-1};
            [mArray addObjectsFromArray:[tempArray subarrayWithRange:range]];
        }
        else {
            [mArray addObjectsFromArray:tempArray];
        }
        self.allKeys = mArray;
    }
    
    [myTable reloadData];
}

- (void)viewDidLoad //10.6.8
{
    [super viewDidLoad];
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake((ViewWidth-276) /2, (50 - 33) /2, 276, 33) image:[UIImage imageNamed:@"输入框.png"]]];
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake((ViewWidth-276) /2 +10, (50 - 33) /2 + (33 - 15)/2, 18, 15) image:[UIImage imageNamed:@"citySearch.png"]]];
    NSString * placeHolderStr = nil; //机场宝典，租车：首字母\中文；  机票,酒店：@"简拼\\全拼\\中文"
    if (self.cityType == AirportCityList || self.cityType == TrainCityList || self.cityType == HotelCityList|| self.cityType == WeatherList)
    {
        if(self.cityType == TrainCityList)
            placeHolderStr = @"城市，车站的简拼\\全拼\\中文";
        else
            placeHolderStr = @"简拼\\全拼\\中文";
    }
    else {
        placeHolderStr = @"简拼\\全拼\\中文";
    }
    UISubTextField * textField = [UISubTextField TextFieldWithFrame:CGRectMake((ViewWidth-276) /2 +10 + 18 + 10, (50 - 33) /2+7, 276 -((ViewWidth-276) /2 +10 + 18 + 10)+(ViewWidth-276) /2 , 23) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:placeHolderStr font: FontSize26];
    textField.delegate = self;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.myTextField = textField;
    [self.myTextField addTarget:self action:@selector(travelToOnTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.myTextField];
    
    switch (self.cityType) {
        case AirportCityList :
        {
            self.hotName = @"热门城市";
            if([self.delegate isKindOfClass:[FlightTrendsViewController class]])
            {
                typeNum = 0;
                self.domesticCitiesBtn = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"domesticCities_blue.png"] frame:CGRectMake(41, 60, 115, 30) target:self action:@selector(changeCity:)];
                self.internationalCitiesBtn = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"internationalCities_gray.png"] frame:CGRectMake(155, 60, 115, 30) target:self action:@selector(changeCity:)];
                self.domesticCitiesBtn.tag = 0;
                self.internationalCitiesBtn.tag = 1;
                [self.view addSubview:self.domesticCitiesBtn];
                [self.view addSubview:self.internationalCitiesBtn];
                
            }
            self.citysArray =  [DataClass selectFromAirportCityList];
            [self citysDicFromArray:self.citysArray];
        }
            break;
        case HotelCityList :
        {
            self.hotName = @"热门城市";
            self.citysArray = [DataClass selectFromHotelCityList];
            [self citysDicFromArray:self.citysArray];
        }
            break;
        case CarRentalList :
        {
            self.hotName = @"热门城市";
            self.citysArray = [DataClass selectFromCarRentalList];
            [self citysDicFromArray:self.citysArray];
        }
            break;
        case AirportsList :
        {
            self.hotName = @"热门机场";
            self.citysArray = [DataClass selectFromAirportList];
            [self citysDicFromArray:self.citysArray];
        }
            break;
        case TrainCityList:
        {
            self.hotName = @"热门";
            self.citysArray = [DataClass selectFromTrainCitysList];
            
            self.allCitysArray = [DataClass selectAllFromTrainCitysList];//这个变量用于，搜索某城市时，那些平时不显示的城市也在搜索范围呢（即isshow为0的）
            [self citysDicFromArray:self.citysArray];
        }
            break;
        case WeatherList :
        {
            self.hotName = @"热门城市";
            self.citysArray = [DataClass selectFromWeatherCityList];
            [self citysDicFromArray:self.citysArray];
        }
            break;
        default:
            break;
    }
    
    if([self.delegate isKindOfClass:[FlightTrendsViewController class]])
    {
        myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, ViewWidth, ViewHeight-44-100) style:UITableViewStylePlain];
    }
    else
    {
        myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ViewWidth, ViewHeight-44-50) style:UITableViewStylePlain];
    }
    myTable.backgroundColor = [UIColor clearColor];
    
    if(IOS7_OR_LATER)
    myTable.sectionIndexBackgroundColor = [UIColor clearColor];
    
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.keyboardbar == nil) {
        KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:[NSArray arrayWithObject:textField] view:self.view ];
        self.keyboardbar = _keyboardbar;
        [_keyboardbar release];
    }
    [keyboardbar showBar:textField];  //显示工具条 
    return YES;
}

- (void)travelToOnTextFieldDidChange:(id)sender
{
    NSLog(@"nihao");
    UITextField *tmpTextField = (UITextField *)sender;
    NSString * searchStr = [[tmpTextField text] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"searchStr = %@", searchStr);
    
    if (searchStr.length == 0) {
        [self citysDicFromArray:self.citysArray];
    }
    else
    {
        NSMutableArray * mArray = [NSMutableArray array];
        if(self.cityType == TrainCityList)
        {
            for (Citys * city in self.allCitysArray) {
                if ([[city._first_letter uppercaseString] hasPrefix:[searchStr uppercaseString]] ||[[city._city_name uppercaseString] hasPrefix:[searchStr uppercaseString]] || [[city._ename uppercaseString] hasPrefix:[searchStr uppercaseString]]|| [[city._jian_pin uppercaseString] hasPrefix:[searchStr uppercaseString]]) {
                    [mArray addObject:city];
                }
            }
        }
        else
        {
            for (Citys * city in self.citysArray) {
                if ([[city._first_letter uppercaseString] hasPrefix:[searchStr uppercaseString]] ||[[city._city_name uppercaseString] hasPrefix:[searchStr uppercaseString]] || [[city._ename uppercaseString] hasPrefix:[searchStr uppercaseString]]|| [[city._jian_pin uppercaseString] hasPrefix:[searchStr uppercaseString]]) {
                    [mArray addObject:city];
                }
            }
        }
        
        
        self.allKeys = nil;
        self.citysDataDic = [NSDictionary dictionaryWithObject:mArray forKey:@"1"];
        [myTable reloadData];
    }
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSString * searchStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    if (searchStr.length == 0) {
//        [self citysDicFromArray:self.citysArray];
//    }
//    else
//    {
//        NSMutableArray * mArray = [NSMutableArray array];
//        if(self.cityType == TrainCityList)
//        {
//            for (Citys * city in self.allCitysArray) {
//                if ([[city._first_letter uppercaseString] hasPrefix:[searchStr uppercaseString]] ||[[city._city_name uppercaseString] hasPrefix:[searchStr uppercaseString]] || [[city._ename uppercaseString] hasPrefix:[searchStr uppercaseString]]|| [[city._jian_pin uppercaseString] hasPrefix:[searchStr uppercaseString]]) {
//                    [mArray addObject:city];
//                }
//            }
//        }
//        else
//        {
//            for (Citys * city in self.citysArray) {
//                if ([[city._first_letter uppercaseString] hasPrefix:[searchStr uppercaseString]] ||[[city._city_name uppercaseString] hasPrefix:[searchStr uppercaseString]] || [[city._ename uppercaseString] hasPrefix:[searchStr uppercaseString]]|| [[city._jian_pin uppercaseString] hasPrefix:[searchStr uppercaseString]]) {
//                    [mArray addObject:city];
//                }
//            }
//        }
//        
//
//        self.allKeys = nil;
//        self.citysDataDic = [NSDictionary dictionaryWithObject:mArray forKey:@"1"];
//        [myTable reloadData];
//    }
//        
//    return YES;
//
////    switch (self.cityType) {
////        case AirportCityList:
////        {
////            for (Citys * city in self.citysArray) {
////                if (searchStr.length ==0) {
////                    [mArray addObject:city];
////                    continue;
////                }
////                if ([[city._first_letter uppercaseString] hasPrefix:[searchStr uppercaseString]] ||[[city._city_name uppercaseString] hasPrefix:[searchStr uppercaseString]] || [[city._ename uppercaseString] hasPrefix:[searchStr uppercaseString]]|| [[city._jian_pin uppercaseString] hasPrefix:[searchStr uppercaseString]]) {
////                    [mArray addObject:city];
////                }
////            }
////        }
////            break;
////        case HotelCityList:
////        {
////            for (HotelCitys * city in self.citysArray) {
////                if (searchStr.length ==0) {
////                    [mArray addObject:city];
////                    continue;
////                }
////                if ([[city._first_letter uppercaseString] hasPrefix:[searchStr uppercaseString]] ||[[city._city_name uppercaseString] hasPrefix:[searchStr uppercaseString]] || [[city._ename uppercaseString] hasPrefix:[searchStr uppercaseString]]|| [[city._jian_pin uppercaseString] hasPrefix:[searchStr uppercaseString]]) {
////                    [mArray addObject:city];
////                }
////            }
////        }
////            break;
////        case CarRentalList:
////        {
////            for (CarCitys * city in self.citysArray) {
////                if (searchStr.length ==0) {
////                    [mArray addObject:city];
////                    continue;
////                }
////                if ([[city._first_letter uppercaseString] hasPrefix:[searchStr uppercaseString]] ||[[city._city_name uppercaseString] hasPrefix:[searchStr uppercaseString]] || [[city._ename uppercaseString] hasPrefix:[searchStr uppercaseString]]|| [[city._jian_pin uppercaseString] hasPrefix:[searchStr uppercaseString]]) {
////                    [mArray addObject:city];
////                }
////            }
////        }
////            break;
////        case AirportsList:
////        {
////            for (AirportList * city in self.citysArray) {
////                if (searchStr.length ==0) {
////                    [mArray addObject:city];
////                    continue;
////                }
////                if ([[city._first_letter uppercaseString] hasPrefix:[searchStr uppercaseString]] ||[[city._city_name uppercaseString] hasPrefix:[searchStr uppercaseString]] || [[city._ename uppercaseString] hasPrefix:[searchStr uppercaseString]]|| [[city._jian_pin uppercaseString] hasPrefix:[searchStr uppercaseString]]) {
////                    [mArray addObject:city];
////                }
////            }
////        }
////            break;
////        case TrainCityList:
////        {
////            for (TrainCitysList * city in self.citysArray) {
////                if (searchStr.length ==0) {
////                    [mArray addObject:city];
////                    continue;
////                }
////                if ([[city._first_letter uppercaseString] hasPrefix:[searchStr uppercaseString]] ||[[city._city_name uppercaseString] hasPrefix:[searchStr uppercaseString]] || [[city._ename uppercaseString] hasPrefix:[searchStr uppercaseString]]|| [[city._jian_pin uppercaseString] hasPrefix:[searchStr uppercaseString]]) {
////                    [mArray addObject:city];
////                }
////            }
////        }
////            break;
////        default:
////            break;
////    }
////    
//    
//}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self citysDicFromArray:self.citysArray];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [keyboardbar HiddenKeyBoard];
    return YES;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self allKeys];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.allKeys)
    {
        return [self.allKeys count];
    }
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
        return [self.allKeys objectAtIndex:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * array = nil ;
    if (self.allKeys)
    {
        array = [self.citysDataDic objectForKey:[self.allKeys objectAtIndex:section]];
    }
    else
    {
        array = [self.citysDataDic objectForKey:@"1"];
    }

    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISubLabel * label = [[UISubLabel alloc] initWithFrame:CGRectMake(15, 5, 290, 30)];
        label.tag = 99;
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor blackColor];
        [cell.contentView addSubview:label];
        [label release];
	    
    }
    NSArray * array = nil ;
    if (self.allKeys) {
        array = [self.citysDataDic objectForKey:[self.allKeys objectAtIndex:indexPath.section] ];
    }
    else
    {
        array = [self.citysDataDic objectForKey:@"1"];
    }
    Citys * city =  [array objectAtIndex:indexPath.row];
    UISubLabel * textLabel = (UISubLabel *)[cell viewWithTag:99];
	textLabel.backgroundColor = [UIColor clearColor];
    textLabel.text = city._city_name ;
	cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.section);
    [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(0, 0, ViewWidth, 44)];
    NSArray * array = nil ;
    if (self.allKeys) {
        array = [self.citysDataDic objectForKey:[self.allKeys objectAtIndex:indexPath.section]] ;
    }
    else
    {
        array = [self.citysDataDic objectForKey:@"1"];
    }
    id object =  [array objectAtIndex:indexPath.row];

    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCityFinshed:)]) {
        [self.delegate performSelector:@selector(didSelectedCityFinshed:) withObject:object];
    }
    [NavigationController popViewControllerAnimated:YES];
}

-(void)changeCity:(UIButton*)sender
{
    if(sender.tag == typeNum)
        return;
    
    self.myTextField.text = @"";
    if(sender.tag)
    {
        typeNum = sender.tag;
        [self.domesticCitiesBtn setImage:[UIImage imageNamed:@"domesticCities_gray.png"] forState:UIControlStateNormal];
        [self.internationalCitiesBtn setImage:[UIImage imageNamed:@"internationalCities_blue.png"] forState:UIControlStateNormal];
        
        
        self.citysArray = [DataClass selectFromIntointernationalAirportCityList];
        if([self.citysArray count] == 0)
        {
            [self storeIntointernationalAirportCities];
            self.citysArray = [DataClass selectFromIntointernationalAirportCityList];
            [self citysDicFromArray:self.citysArray];
        }
        [self citysDicFromArray:self.citysArray];
        [myTable reloadData];
    }
    else
    {
        typeNum = sender.tag;
        [self.domesticCitiesBtn setImage:[UIImage imageNamed:@"domesticCities_blue.png"] forState:UIControlStateNormal];
        [self.internationalCitiesBtn setImage:[UIImage imageNamed:@"internationalCities_gray.png"] forState:UIControlStateNormal];
        self.citysArray = [DataClass selectFromAirportCityList];
        [self citysDicFromArray:self.citysArray];
        [myTable reloadData];
    }

}

-(void)storeIntointernationalAirportCities
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"国际城市" ofType:@"json"];
    NSString *str = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [str JSONValue];
    [str release];
    NSMutableArray *aArray = [[NSMutableArray alloc] init];
    for (id elem in array)
    {
        [aArray addObject:[NSArray arrayWithObjects:[elem objectForKey:@"code"], [elem objectForKey:@"name"],[elem objectForKey:@"ename"],[elem objectForKey:@"firstLetter"],[elem objectForKey:@"jianPin"],[elem objectForKey:@"flag"],nil]];
    }
    [DataClass insertIntointernationalAirportCityListWithArray:aArray];
    [aArray release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
