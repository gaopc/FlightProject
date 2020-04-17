//
//  TaxiHomeViewController.m
//  FlightProject
//
//  Created by longcd on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TaxiHomeViewController.h"
#import "TaxiTakeCarShopViewController.h"
#import "SubmitOrderCarInfo.h"
#import "CarListViewController.h"
#import "QueryCarModel.h"
#import "CityListViewController.h"
#import "CarQueryCustomCell.h"
#import "CarQueryDateCell.h"
#import "CarSwitchCell.h"
#import "CarQueryDoubleCustomCell.h"

#define kViewTag 1
@interface TaxiHomeViewController ()

@end

#pragma mark - TaxiHomeDataModelElem
@implementation TaxiHomeDataModelElem
@synthesize _nameStr,_nameCode;
-(void)dealloc
{
    self._nameCode = nil;
    self._nameStr = nil;
    [super dealloc];
}
+(TaxiHomeDataModelElem *)TaxiHomeDataModelElemWithStr:(NSString *)str  code:(NSString *)code
{
    TaxiHomeDataModelElem * model = [[TaxiHomeDataModelElem alloc] init];
    model._nameStr = str;
    model._nameCode = code;
    return [model autorelease];
}
@end

#pragma mark - TaxiHomeDataModel
@implementation TaxiHomeDataModel
@synthesize _startDate,_endData,_takeCity,_sendCity,_takeDoor,_sendDoor;
-(void)dealloc
{
    self._startDate = nil;
    self._endData = nil;
    self._takeCity = nil;
    self._sendCity = nil;
    self._takeDoor = nil;
    self._sendDoor = nil;

    [super dealloc];
}
@end

#pragma mark - TaxiHomeViewController
@implementation TaxiHomeViewController
@synthesize dataSourceArray ;
@synthesize queryDataModel = _queryDataModel;
@synthesize allKeys;
@synthesize imageVArray;
@synthesize server, buttonSelect;
@synthesize alertLabel;
@synthesize carDataModel;
@synthesize currentDataModelElem;
-(void)dealloc
{
    self.server  = nil;
    self.buttonSelect = nil;
    self.carDataModel = nil;
    self.queryDataModel = nil;
    self.dataSourceArray = nil;
    self.allKeys = nil;
    self.imageVArray = nil;
    self.alertLabel = nil;
    self.currentDataModelElem = nil;
    [super dealloc];
}

#pragma mark - loadView

- (void)viewDidLoad
{
    [super viewDidLoad];
   // Do any additional setup after loading the view.
    self.title = @"租车查询";
    //self.navigationItem.rightBarButtonItem = nil;
    isSameDoor = YES;

    if (self.queryDataModel && !self.carDataModel) {
        TaxiHomeDataModel *tempQueryDataModel = [[TaxiHomeDataModel alloc] init];
        self.carDataModel = tempQueryDataModel;
        [tempQueryDataModel release];
        NSString * _carCityName = [DataClass selectFromCarRentalListWithCityCode:self.queryDataModel._cityCode];
        self.carDataModel._takeCity = [TaxiHomeDataModelElem TaxiHomeDataModelElemWithStr:_carCityName code:self.queryDataModel._cityCode];
        self.carDataModel._sendCity = [TaxiHomeDataModelElem TaxiHomeDataModelElemWithStr:_carCityName code:self.queryDataModel._cityCode];
        Shops * takeShop =  [[Shops alloc] init];
        takeShop._shopName = @"选择门店地址" ;
        self.carDataModel._takeDoor =takeShop; 
        [takeShop release];
        Shops * sendShop =  [[Shops alloc] init];
        sendShop._shopName = @"选择门店地址" ;
        self.carDataModel._sendDoor =sendShop;
        [sendShop release];
        NSDate * startDate = [NSDate dateFromString:[self.queryDataModel._fromDate substringToIndex:10] withFormat:@"yyyy-MM-dd"];
        NSDate * toDate = [NSDate dateFromString:[self.queryDataModel._toDate substringToIndex:10] withFormat:@"yyyy-MM-dd"];
        self.carDataModel._startDate = [TaxiHomeDataModelElem TaxiHomeDataModelElemWithStr: [NSString stringWithFormat:@"%@-10:00", [NSDate dateFormateCarQuery:startDate]] code: self.queryDataModel._fromDate];
        //self.carDataModel._endData = [TaxiHomeDataModelElem TaxiHomeDataModelElemWithStr: [NSString stringWithFormat:@"%@-10:00",[NSDate dateafterDay:startDate day:Delay_Days+1 type:4]] code: [NSString stringWithFormat:@"%@ 10:00",[NSDate dateafterDay:startDate day:Delay_Days+1 type:1]]];
        self.carDataModel._endData = [TaxiHomeDataModelElem TaxiHomeDataModelElemWithStr:[NSString stringWithFormat:@"%@-10:00", [NSDate dateFormateCarQuery:toDate]] code:self.queryDataModel._toDate];
    }
    
    self.dataSourceArray = (NSMutableArray *)[NSArray arrayWithObjects:self.carDataModel._takeCity, self.carDataModel._takeDoor,self.carDataModel._sendDoor,nil];
    self.allKeys = [NSArray arrayWithObjects:@"取车城市",@"取车门店",@"还车门店", nil];
    self.imageVArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"CityIcon.png"],[UIImage imageNamed:@"取车查询icon.png"],[UIImage imageNamed:@"还车查询icon.png"], nil];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, ViewWidth-20.0f, ViewHeight - 44.0f) style:UITableViewStylePlain] ;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    myTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTable];
    [myTable release];
    myTable.tableHeaderView = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, myTable.frame.size.width, 28.0f) image:[UIImage imageNamed:@"appointmentFrameTop.png"]];
    //myTable.tableFooterView = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, myTable.frame.size.width, 5.0f) image:[UIImage imageNamed:@"carStoreAddressNameShadow.png"]];
	
}
#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSameDoor) {
        return 4+1;
    }
    return 5+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSameDoor) {
        if (indexPath.row ==3) {
            return 90;
        }
        else if (indexPath.row == 2) {
            return 50;
        }
        else if (indexPath.row == 4)
        {
            return 100;
        }
        return 60;
    }
    else {
        if (indexPath.row ==4) {
            return 90;
        }
        else if (indexPath.row == 3) {
            return 50;
        }
        else if (indexPath.row == 5)
        {
            return 100;
        }
        return 60;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSameDoor) {
        if (indexPath.row < 2) {
            static NSString *carQueryCustomCellIdentifier = @"carQueryCustomCellIdentifier";
            CarQueryCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:carQueryCustomCellIdentifier];
            if (cell == nil)
            {
                cell = [[[CarQueryCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carQueryCustomCellIdentifier] autorelease];
                [cell._nameButton addTarget:self action:@selector(getCarCityOrStore:) forControlEvents:UIControlEventTouchUpInside];
            }
            cell._imageV.image = [self.imageVArray objectAtIndex:indexPath.row];
            if (indexPath.row == 0) {
                cell._imageV.frame = CGRectMake(25, 10, 23, 35);
            }
            else {
                cell._imageV.frame = CGRectMake(20, 20, 35, 26);
            }
            cell._nameButton.tag = indexPath.row;
            cell._titleLabel.text = [self.allKeys objectAtIndex:indexPath.row];
            if (indexPath.row == 0) {
                TaxiHomeDataModelElem * elem = [self.dataSourceArray objectAtIndex:indexPath.row];
                [cell._nameButton setTitle:elem._nameStr forState:UIControlStateNormal];
                [cell._nameButton setTitleColor:FontColor000000 forState:UIControlStateNormal];
            }
            else {
                Shops * elem = [self.dataSourceArray objectAtIndex:indexPath.row];
                [cell._nameButton setTitle:elem._shopName forState:UIControlStateNormal];
                if (elem._storeCode) {
                    [cell._nameButton setTitleColor:FontColor000000 forState:UIControlStateNormal];
                }
                else{
                    [cell._nameButton setTitleColor:FontColor909090 forState:UIControlStateNormal];
                }
            }
            return cell;
        }
        else if (indexPath.row == 2){ 
            static NSString *carSwitchCellIdentifier = @"carSwitchCellIdentifier";
            CarSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:carSwitchCellIdentifier];
            if (cell == nil)
            {
                cell = [[[CarSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carSwitchCellIdentifier] autorelease];
		cell._switch.delegate=self;
		//[cell._switch addTarget:self action:@selector(valueChangedInView:) forControlEvents:UIControlEventValueChanged];
            }
            return cell;
        }
        else if (indexPath.row == 3){
            static NSString *carQueryDateCellIdentifier = @"carQueryDateCellIdentifier";
            CarQueryDateCell *cell = [tableView dequeueReusableCellWithIdentifier:carQueryDateCellIdentifier];
            if (cell == nil)
            {
                cell = [[[CarQueryDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carQueryDateCellIdentifier] autorelease];
                [cell._fromDataButton addTarget:self action:@selector(selectDateTime:) forControlEvents:UIControlEventTouchUpInside];
                [cell._toDataButton addTarget:self action:@selector(selectDateTime:) forControlEvents:UIControlEventTouchUpInside];
            }
            // 09月-28-周五-10:00
            NSArray * startArray = [self.carDataModel._startDate._nameStr componentsSeparatedByString:@"-"];
            cell._fromDataOneLabel.text = [NSString stringWithFormat:@"%@%@",[startArray objectAtIndex:2],[startArray objectAtIndex:0]];
            cell._fromDataTwoLabel.text = [NSString stringWithFormat:@"%@",[startArray objectAtIndex:1]];
            cell._fromTimeLabel.text = [NSString stringWithFormat:@"%@",[startArray objectAtIndex:3]];
            
            NSArray * backArray = [self.carDataModel._endData._nameStr componentsSeparatedByString:@"-"];
            cell._toDataOneLabel.text = [NSString stringWithFormat:@"%@%@",[backArray objectAtIndex:2],[backArray objectAtIndex:0]];
            cell._toDataTwoLabel.text = [NSString stringWithFormat:@"%@",[backArray objectAtIndex:1]];
            cell._toTimeLabel.text = [NSString stringWithFormat:@"%@",[backArray objectAtIndex:3]];
            return cell;       
        }
    }
    else {
        if (indexPath.row <3) {
            if (indexPath.row == 0) {
                static NSString *carQueryDoubleCustomCellIdentifier = @"carQueryDoubleCustomCellIdentifier";
                CarQueryDoubleCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:carQueryDoubleCustomCellIdentifier];
                if (cell == nil)
                {
                    cell = [[[CarQueryDoubleCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carQueryDoubleCustomCellIdentifier] autorelease];
                    [cell._takeCityName addTarget:self action:@selector(getCarCityOrStore:) forControlEvents:UIControlEventTouchUpInside];
                    [cell._backCityName addTarget:self action:@selector(getCarCityOrStore:) forControlEvents:UIControlEventTouchUpInside];
                }
                [cell._takeCityName setTitle:self.carDataModel._takeCity._nameStr forState:UIControlStateNormal];
                [cell._backCityName setTitle:self.carDataModel._sendCity._nameStr forState:UIControlStateNormal];
                return cell;
            }
            static NSString *carQueryCustomCellIdentifier = @"carQueryCustomCellIdentifier";
            CarQueryCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:carQueryCustomCellIdentifier];
            if (cell == nil)
            {
                cell = [[[CarQueryCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carQueryCustomCellIdentifier] autorelease];
                [cell._nameButton addTarget:self action:@selector(getCarCityOrStore:) forControlEvents:UIControlEventTouchUpInside];
            }
            cell._nameButton.tag = indexPath.row;
            cell._imageV.image = [self.imageVArray objectAtIndex:indexPath.row ];
            if (indexPath.row == 0) {
                cell._imageV.frame = CGRectMake(25, 10, 23, 35);
            }
            else {
                cell._imageV.frame = CGRectMake(20, 20, 35, 26);
            }
            cell._titleLabel.text = [self.allKeys objectAtIndex:indexPath.row];
            Shops * elem = [self.dataSourceArray objectAtIndex:indexPath.row];
            [cell._nameButton setTitle:elem._shopName forState:UIControlStateNormal];
            if (elem._storeCode) {
                [cell._nameButton setTitleColor:FontColor000000 forState:UIControlStateNormal];
            }
            else{
                 [cell._nameButton setTitleColor:FontColor909090 forState:UIControlStateNormal];
            }
            return cell;
        }
        else if (indexPath.row ==3) {
            static NSString *carSwitchCellIdentifier = @"carSwitchCellIdentifier";
            CarSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:carSwitchCellIdentifier];
            if (cell == nil)
            {
                cell = [[[CarSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carSwitchCellIdentifier] autorelease];
		cell._switch.delegate = self;
		    //[cell._switch addTarget:self action:@selector(valueChangedInView:) forControlEvents:UIControlEventValueChanged];
            }
            return cell;
        }
        else if (indexPath.row == 4){
            static NSString *carQueryDateCellIdentifier = @"carQueryDateCellIdentifier";
            CarQueryDateCell *cell = [tableView dequeueReusableCellWithIdentifier:carQueryDateCellIdentifier];
            if (cell == nil)
            {
                cell = [[[CarQueryDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carQueryDateCellIdentifier] autorelease];
                [cell._fromDataButton addTarget:self action:@selector(selectDateTime:) forControlEvents:UIControlEventTouchUpInside];
                [cell._toDataButton addTarget:self action:@selector(selectDateTime:) forControlEvents:UIControlEventTouchUpInside];
            }
            // 09月-28-周五-10:00
            NSArray * startArray = [self.carDataModel._startDate._nameStr componentsSeparatedByString:@"-"];
            cell._fromDataOneLabel.text = [NSString stringWithFormat:@"%@%@",[startArray objectAtIndex:2],[startArray objectAtIndex:0]];
            cell._fromDataTwoLabel.text = [NSString stringWithFormat:@"%@",[startArray objectAtIndex:1]];
            cell._fromTimeLabel.text = [NSString stringWithFormat:@"%@",[startArray objectAtIndex:3]];
            
            NSArray * backArray = [self.carDataModel._endData._nameStr componentsSeparatedByString:@"-"];
            cell._toDataOneLabel.text = [NSString stringWithFormat:@"%@%@",[backArray objectAtIndex:2],[backArray objectAtIndex:0]];
            cell._toDataTwoLabel.text = [NSString stringWithFormat:@"%@",[backArray objectAtIndex:1]];
            cell._toTimeLabel.text = [NSString stringWithFormat:@"%@",[backArray objectAtIndex:3]];
            return cell;
        }
    }
    
    static NSString *carQueryCellIdentifier = @"carQueryCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:carQueryCellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carQueryCellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth - 20-225)/2, 5, 225, 45) backImage:[UIImage imageNamed:@"WhenRealQuery.png"] target:self action:@selector(currentSearch:)]];
        self.alertLabel = [UISubLabel labelWithTitle:nil frame:CGRectMake(0, 5 + 45, ViewWidth - 20, 15) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        UIImageView * imageV = [UIImageView ImageViewWithFrame:CGRectMake((ViewWidth - 20-260)/2, 5 + 45 +25, 260, 20) image:[UIImage imageNamed:@"carLogo.png"]];
        [cell addSubview:self.alertLabel];
        [cell addSubview:imageV];
    }
	cell.backgroundColor = [UIColor clearColor];

    return cell;
}
#pragma mark - switchValueChanged
- (void)valueChangedInView:(CustomUISwitch *)sender
{
    isSameDoor = sender.on;
    if (isSameDoor) {

        self.carDataModel._sendCity._nameStr = self.carDataModel._takeCity._nameStr;
        self.carDataModel._sendCity._nameCode = self.carDataModel._takeCity._nameCode;
        
        self.carDataModel._sendDoor._storeCode = self.carDataModel._takeDoor._storeCode;
        self.carDataModel._sendDoor._shopName = self.carDataModel._takeDoor._shopName;
        self.carDataModel._sendDoor._startOpeningHours = self.carDataModel._takeDoor._startOpeningHours;
        self.carDataModel._sendDoor._endOpeningHours = self.carDataModel._takeDoor._endOpeningHours;
        self.carDataModel._sendDoor._deptype = self.carDataModel._takeDoor._deptype;
        self.carDataModel._sendDoor._shopAddress = self.carDataModel._takeDoor._shopAddress;
    }
    [myTable reloadData];
}


#pragma mark - changeCity  Store
-(void)getCarCityOrStore:(UIButton *)sender // 取车城市，取车门店，换车门店, 换车城市
{
    if (sender.tag == 0 || sender.tag == 3) {
        
        self.buttonSelect = [NSString stringWithFormat:@"%ld", (long)sender.tag];
        
        NSArray * array =  [DataClass selectFromCarRentalList];
        if ( [GetConfiguration shareGetConfiguration].needUpdateCarRentalList || [array count] == 0) {
            GetBasicInfoFromServer *serverInfo = [[GetBasicInfoFromServer alloc] init];
            self.server  = serverInfo;
            self.server.cityDelegate = self;
            
            [serverInfo release];
            [self.server getCarRentalList];
        }
        else {
            [self didCityInfoResult:array];
        }
        
        if (sender.tag == 0){
            NSLog(@"取车城市");
            self.currentDataModelElem = self.carDataModel._takeCity;
        }
        else {
            NSLog(@"还车城市");
            self.currentDataModelElem = self.carDataModel._sendCity;
        }

    }
    else if (sender.tag == 1 || sender.tag == 2){
        TaxiHomeDataModelElem * elem = nil;
        if (sender.tag == 1) {
            NSLog(@"取车门店");
            self.currentDataModelElem = self.carDataModel._takeDoor;
            elem = self.carDataModel._takeCity;
        }
        else {
            NSLog(@"还车门店");
            self.currentDataModelElem = self.carDataModel._sendDoor;
            elem = self.carDataModel._sendCity;
        }
        
        ASIFormDataRequest * theRequest = [InterfaceClass queryCarStore:elem._nameCode];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryCarStorePaseredResult:) Delegate:self needUserType:Default];
    }
}

- (void)didCityInfoResult:(NSArray *)cityArray
{
    CityListViewController * citylistVC = [[CityListViewController alloc] init];
    citylistVC.citysArray = cityArray;
    if ([self.buttonSelect intValue] == 0){
        NSLog(@"取车城市");
        citylistVC.title = @"取车城市";
        self.currentDataModelElem = self.carDataModel._takeCity;
    }
    else {
        NSLog(@"还车城市");
        citylistVC.title = @"还车城市";
        self.currentDataModelElem = self.carDataModel._sendCity;
    }
    
    citylistVC.cityType = CarRentalList;
    citylistVC.delegate = self;
    [NavigationController pushViewController:citylistVC animated:YES];
    [citylistVC release];
}

- (void)onqueryCarStorePaseredResult:(NSDictionary *)dic
{
    if (dic) {
        TaxiTakeCarShopViewController *taxiTakeCarShopVC = [[TaxiTakeCarShopViewController alloc] init];
        if (self.currentDataModelElem == self.carDataModel._takeDoor) {
            taxiTakeCarShopVC.title = @"取车门店";
        }
        else{
            taxiTakeCarShopVC.title = @"还车门店";
        }
        taxiTakeCarShopVC.delegate = self;
        taxiTakeCarShopVC.carStoreArray =  [QueryCarStore getQueryCarStore:dic];
        [NavigationController pushViewController:taxiTakeCarShopVC animated:YES];
        [taxiTakeCarShopVC release];
    }
}
-(void) didSelectedStoreFinshed:(id)object
{
    Shops * shop = (Shops *)object;
    
//    if ([shop._deptype isEqualToString:@"400"]) {
//        self.alertLabel.text = @"首次租车客户请选择门店租车，暂不接受服务点订车.";
//    }
//    else if ([self.alertLabel.text isEqualToString: @"首次租车客户请选择门店租车，暂不接受服务点订车."]) {
//        self.alertLabel.text = @"";
//    }
    
    Shops *currentShop = (Shops *)self.currentDataModelElem;
    currentShop._storeCode = shop._storeCode;
    currentShop._shopName = shop._shopName;
    currentShop._startOpeningHours = shop._startOpeningHours;
    currentShop._endOpeningHours = shop._endOpeningHours;
    currentShop._deptype = shop._deptype;
    currentShop._shopAddress = shop._shopAddress;
    NSArray * reloadArray = nil;
    if (isSameDoor) {
        self.carDataModel._takeDoor._storeCode = currentShop._storeCode;
        self.carDataModel._takeDoor._shopName = currentShop._shopName;
        self.carDataModel._takeDoor._startOpeningHours = currentShop._startOpeningHours;
        self.carDataModel._takeDoor._endOpeningHours = currentShop._endOpeningHours;
        self.carDataModel._takeDoor._deptype = currentShop._deptype;
        self.carDataModel._takeDoor._shopAddress = currentShop._shopAddress;
        self.carDataModel._sendDoor._storeCode = currentShop._storeCode;
        self.carDataModel._sendDoor._shopName = currentShop._shopName;
        self.carDataModel._sendDoor._startOpeningHours = currentShop._startOpeningHours;
        self.carDataModel._sendDoor._endOpeningHours = currentShop._endOpeningHours;
        self.carDataModel._sendDoor._deptype = currentShop._deptype;
        self.carDataModel._sendDoor._shopAddress = currentShop._shopAddress;
        // 09月-28-周五-10:00  2012-11-15 10:00
        NSArray * startArray = [self.carDataModel._startDate._nameStr componentsSeparatedByString:@"-"];
        NSArray * endArray = [self.carDataModel._endData._nameStr componentsSeparatedByString:@"-"];
        self.carDataModel._startDate._nameStr = [NSString stringWithFormat:@"%@-%@-%@-10:00",[startArray objectAtIndex:0],[startArray objectAtIndex:1],[startArray objectAtIndex:2]];
        self.carDataModel._startDate._nameCode = [NSString stringWithFormat:@"%@ 10:10",[[self.carDataModel._startDate._nameCode componentsSeparatedByString:@" "] objectAtIndex:0]];
        self.carDataModel._endData._nameStr = [NSString stringWithFormat:@"%@-%@-%@-10:00",[endArray objectAtIndex:0],[endArray objectAtIndex:1],[endArray objectAtIndex:2]];
        self.carDataModel._endData._nameCode = [NSString stringWithFormat:@"%@ 10:10",[[self.carDataModel._endData._nameCode componentsSeparatedByString:@" "] objectAtIndex:0]];
        reloadArray = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], [NSIndexPath indexPathForRow:3 inSection:0],nil];
    }
    else {
        if (self.currentDataModelElem == self.carDataModel._takeDoor) {
            NSArray * startArray = [self.carDataModel._startDate._nameStr componentsSeparatedByString:@"-"];
            self.carDataModel._startDate._nameStr = [NSString stringWithFormat:@"%@-%@-%@-10:00",[startArray objectAtIndex:0],[startArray objectAtIndex:1],[startArray objectAtIndex:2]];
            self.carDataModel._startDate._nameCode = [NSString stringWithFormat:@"%@ 10:10",[[self.carDataModel._startDate._nameCode componentsSeparatedByString:@" "] objectAtIndex:0]];
        }
        else{
            NSArray * endArray = [self.carDataModel._endData._nameStr componentsSeparatedByString:@"-"];
            self.carDataModel._endData._nameStr = [NSString stringWithFormat:@"%@-%@-%@-10:00",[endArray objectAtIndex:0],[endArray objectAtIndex:1],[endArray objectAtIndex:2]];
            self.carDataModel._endData._nameCode = [NSString stringWithFormat:@"%@ 10:10",[[self.carDataModel._endData._nameCode componentsSeparatedByString:@" "] objectAtIndex:0]];

        }
        reloadArray = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], [NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:4 inSection:0],nil];
    }
    
    [myTable reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationFade];
}
-(void)didSelectedCityFinshed:(id)city
{
    CarCitys * _city = (CarCitys *)city;
    TaxiHomeDataModelElem * elem =  (TaxiHomeDataModelElem *)self.currentDataModelElem;
    elem._nameCode = _city._city_code;
    elem._nameStr = _city._city_name;
    if (isSameDoor) {
        self.carDataModel._takeCity._nameStr = elem._nameStr;
        self.carDataModel._takeCity._nameCode = elem._nameCode;
        self.carDataModel._sendCity._nameStr = elem._nameStr;
        self.carDataModel._sendCity._nameCode = elem._nameCode;
        
        self.carDataModel._takeDoor._shopName = @"选择门店地址";
        self.carDataModel._sendDoor._shopName = @"选择门店地址";
        self.carDataModel._takeDoor._storeCode = nil;
        self.carDataModel._sendDoor._storeCode = nil;
        [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], [NSIndexPath indexPathForRow:1 inSection:0],nil] withRowAnimation:UITableViewRowAnimationFade];
    }
    else{
        if (self.currentDataModelElem == self.carDataModel._takeCity) {
            self.carDataModel._takeDoor._shopName = @"选择门店地址";
            self.carDataModel._takeDoor._storeCode = nil;
        }
        else{
            self.carDataModel._sendDoor._shopName = @"选择门店地址";
            self.carDataModel._sendDoor._storeCode = nil;
        }
        [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:2 inSection:0],nil] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - changeDateTime
-(void)selectDateTime:(UIButton *) sender
{
    TaxiDatePickerViewController *taxiPickerVC = [[TaxiDatePickerViewController alloc] init] ;
    
    switch (sender.tag) {
		case 0:
            if (self.carDataModel._takeDoor._storeCode == nil) {
                [taxiPickerVC release];
                [UIAlertView alertViewWithMessage:@"请选择取车门店" :@"提示"];
                return;
            }
            taxiPickerVC.dateType = StarDate;
		    taxiPickerVC.pushBackDay = PushBackZeroDay;
			break;
		case 1:
            if (self.carDataModel._sendDoor._storeCode == nil) {
                [taxiPickerVC release];
                [UIAlertView alertViewWithMessage:@"请选择还车门店" :@"提示"];
                return;
            }
            taxiPickerVC.dateType = BackDate ;
		      taxiPickerVC.pushBackDay = PushBackTwoDay;
			break;
		default:
			break;
	}

    if ([[self.carDataModel._takeDoor._endOpeningHours substringToIndex:2] intValue] == 24) {
        self.carDataModel._takeDoor._endOpeningHours = @"23:30";
    }
    if ([[self.carDataModel._sendDoor._endOpeningHours substringToIndex:2] intValue] == 24) {
        self.carDataModel._sendDoor._endOpeningHours = @"23:30";
    }
    
    taxiPickerVC.startTimeRange = [NSString stringWithFormat:@"%@-%@",self.carDataModel._takeDoor._startOpeningHours,self.carDataModel._takeDoor._endOpeningHours] ;
    taxiPickerVC.backTimeRange = [NSString stringWithFormat:@"%@-%@",self.carDataModel._sendDoor._startOpeningHours,self.carDataModel._sendDoor._endOpeningHours] ;
    
    taxiPickerVC.delegate = self;
    
	taxiPickerVC.startDateTicketQueryDataModel = self.carDataModel._startDate;
	taxiPickerVC.backDateTicketQueryDataModel = self.carDataModel._endData;
	[NavigationController pushViewController:taxiPickerVC animated:YES];
    [taxiPickerVC release];
}
-(void) didSelectedDateTimeFinshed:(id)object
{
//    // 09月-28-周五-10:00
//    NSArray * startArray = [self.carDataModel._startDate._nameStr componentsSeparatedByString:@"-"];
//    // 09月-28-周五-10:00
//    NSArray * endArray = [self.carDataModel._endData._nameStr componentsSeparatedByString:@"-"];
//    
//    if ([[startArray objectAtIndex:0] isEqualToString:[endArray objectAtIndex:0]]) {
//        if ([[startArray objectAtIndex:1] isEqualToString:[endArray objectAtIndex:1]]) {
//            self.alertLabel.text = @"不足24小时按1天计费.";
//        }
//        else if ([self.alertLabel.text isEqualToString: @"不足24小时按1天计费."]) {
//            self.alertLabel.text = @"";
//        }
//    }
    
    NSString * startDateTime = [NSString stringWithFormat:@"%@:00",self.carDataModel._startDate._nameCode];
    NSString * endDateTime = [NSString stringWithFormat:@"%@:00",self.carDataModel._endData._nameCode];
    if ([[[startDateTime componentsSeparatedByString:@" "] objectAtIndex:1] isEqualToString:@"24:00:00"]) {
        startDateTime = [NSString stringWithFormat:@"%@ 00:00:00",[[startDateTime componentsSeparatedByString:@" "] objectAtIndex:0]];
        startDateTime = [NSDate dateafterDay:[NSDate dateFromString:startDateTime withFormat:@"yyyy-MM-dd HH:mm:ss"] day:1 type:6];
    }
    if ([[[endDateTime componentsSeparatedByString:@" "] objectAtIndex:1] isEqualToString:@"24:00:00"]) {
        endDateTime = [NSString stringWithFormat:@"%@ 00:00:00",[[endDateTime componentsSeparatedByString:@" "] objectAtIndex:0]];
        endDateTime = [NSDate dateafterDay:[NSDate dateFromString:endDateTime withFormat:@"yyyy-MM-dd HH:mm:ss"] day:1 type:6];
    }
    
    NSDate * startDate = [ NSDate dateFromString:startDateTime withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * endDate = [ NSDate dateFromString:endDateTime withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeInterval start = [startDate timeIntervalSinceNow] *1;
    NSTimeInterval end = [endDate timeIntervalSinceNow] *1;
    NSTimeInterval cha = end - start;
    NSTimeInterval nomalValue = 1;
    if ( (cha/3600) < nomalValue *24) {
        if ([startDateTime isEqualToString:endDateTime]) {
            if ([self.alertLabel.text isEqualToString: @"不足24小时按1天计费."]) {
                self.alertLabel.text = @"";
            }
        }
        else
        {
            self.alertLabel.text = @"不足24小时按1天计费.";
        }
   }
    else if ([self.alertLabel.text isEqualToString: @"不足24小时按1天计费."]) {
        self.alertLabel.text = @"";
    }

    NSArray * reloadArray = nil;
    if (isSameDoor) {
        reloadArray = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:3 inSection:0], nil];
    }
    else {
        reloadArray = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:4 inSection:0],nil];
    }
    [myTable reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark - currentSearch
//实时查询
-(void)currentSearch:(UIButton *)searchBtn
{
    NSLog(@"实时查询");
    
    if (self.carDataModel._takeDoor._storeCode == nil) {
        [UIAlertView alertViewWithMessage:@"请选择取车门店" :@"提示"];
        return;
    }
    else if (self.carDataModel._sendDoor._storeCode == nil) {
        [UIAlertView alertViewWithMessage:@"请选择还车门店" :@"提示"];
        return;
    }
    else if([self.carDataModel._startDate._nameCode isEqualToString:self.carDataModel._endData._nameCode]){
        [UIAlertView alertViewWithMessage:@"还车时间必须大于取车时间30分钟以上" :@"提示"];
        return;
    }
    
    NSString * startDateTime = [NSString stringWithFormat:@"%@:00",self.carDataModel._startDate._nameCode];
    if ([[[startDateTime componentsSeparatedByString:@" "] objectAtIndex:1] isEqualToString:@"24:00:00"]) {
        startDateTime = [NSString stringWithFormat:@"%@ 00:00:00",[[startDateTime componentsSeparatedByString:@" "] objectAtIndex:0]];
        startDateTime = [NSDate dateafterDay:[NSDate dateFromString:startDateTime withFormat:@"yyyy-MM-dd HH:mm:ss"] day:1 type:6];
    }
    
    NSDate * startDate = [ NSDate dateFromString:startDateTime withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * endDate = [NSDate date];
    
    NSTimeInterval start = [startDate timeIntervalSinceNow] *1;
    NSTimeInterval end = [endDate timeIntervalSinceNow]*1;
    int cha = start - end ;
    if ( (cha /60) <= 120) {
            [UIAlertView alertViewWithMessage:@"请提前2小时预订，以便我们为您及时安排车辆。" :@"提示"];
            return;
    }

    SubmitOrderCarInfo * _tempqueryDataModel =[[SubmitOrderCarInfo alloc] init] ;
    self.queryDataModel = _tempqueryDataModel;
    [_tempqueryDataModel release];
    self.queryDataModel._toStoreCode = self.carDataModel._sendDoor._storeCode;
    self.queryDataModel._toDate = self.carDataModel._endData._nameCode;
    self.queryDataModel._toCityCode = self.carDataModel._sendCity._nameCode;
    
    self.queryDataModel._cityCode = self.carDataModel._takeCity._nameCode;
    self.queryDataModel._fromDate = self.carDataModel._startDate._nameCode;
    self.queryDataModel._storeCode = self.carDataModel._takeDoor._storeCode;
    self.queryDataModel._deptype = self.carDataModel._takeDoor._deptype; // 取车门点
    
    // 09月-28-周五-10:00
    NSArray * fromDateArray = [self.carDataModel._startDate._nameStr componentsSeparatedByString:@"-"];
    self.queryDataModel._fromDateDsc = [NSString stringWithFormat:@"%@%@日 %@",[fromDateArray objectAtIndex:0] ,[fromDateArray objectAtIndex:1],[fromDateArray objectAtIndex:3]] ;
    
    NSArray * toDateArray = [self.carDataModel._endData._nameStr componentsSeparatedByString:@"-"];
    self.queryDataModel._toDateDsc = [NSString stringWithFormat:@"%@%@日 %@",[toDateArray objectAtIndex:0] ,[toDateArray objectAtIndex:1],[toDateArray objectAtIndex:3]] ;
    
    self.queryDataModel._storeCodeDsc = self.carDataModel._takeDoor._shopName;
    self.queryDataModel._toStoreCodeDsc = self.carDataModel._sendDoor._shopName;
    
    ASIFormDataRequest * theRequest = [InterfaceClass queryCarModel:self.queryDataModel pageIndex:1];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onQueryCarModelPaseredResult:) Delegate:self needUserType:Default];

}
-(void)onQueryCarModelPaseredResult:(NSDictionary *)resultDic
{
    CarListViewController * carListVC = [[CarListViewController alloc] init];
    
    carListVC.queryDataModel = self.queryDataModel;
    
    carListVC.carListDataArray = (NSMutableArray *) [QueryCarModelResponse QueryCarModelResponse:resultDic ];
    [NavigationController pushViewController:carListVC animated:YES];
    [carListVC release];
}
#pragma mark - viewDidUnload
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.dataSourceArray = nil;
    self.queryDataModel = nil;
    // Release any retained subviews of the main view.
}

@end
