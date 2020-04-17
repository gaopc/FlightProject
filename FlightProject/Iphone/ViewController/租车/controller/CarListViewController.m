//
//  CarListViewController.m
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarListViewController.h"
#import "TaxiHomeViewController.h"
#import "CarServicesViewController.h"

@interface CarListViewController ()

@end

@implementation CarListViewController

@synthesize  selectedCarDetail,carListDataArray;
@synthesize isfromRecomend;
@synthesize queryDataModel;
-(void)dealloc
{
    self.selectedCarDetail = nil;
    self.carListDataArray = nil;
    self.queryDataModel = nil;
    //[_refreshHeaderView release];  // 20121204 经产品确认，租车不加分页显示
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"车型选择";
    
    pageIndex = 1;
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 7, ViewWidth, ViewHeight-44) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];

    myTable.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;//UITableViewCellSeparatorStyleNone;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable reloadData];
    [myTable release];
    
//    if (!self.isfromRecomend) {  // 20121204 经产品确认，租车不加分页显示
//        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] init]; //initWithFrame: CGRectMake(0.0f, 698, 1024, 80)];
//        _refreshHeaderView.frame=CGRectMake(0.0f, myTable.contentSize.height, myTable.frame.size.width, 80);
//        _refreshHeaderView.delegate = self;
//        _refreshHeaderView.backgroundColor= [UIColor clearColor];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"VideoInfo.png"]];
//        [myTable addSubview:_refreshHeaderView];
//        
//        [_refreshHeaderView refreshLastUpdatedDate];
//
//    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 7)];
    [view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10.0f, -3.0f, ViewWidth - 20, 3.0f) image:[UIImage imageNamed:@"carStoreAddressNameShadow.png"]]];

    return [view autorelease];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UISubLabel labelWithframe:CGRectMake(0, 0, ViewWidth, 5) backgroundColor:[UIColor clearColor]];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.carListDataArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    QueryCarModelResponse * carModel = (QueryCarModelResponse *) [self.carListDataArray objectAtIndex:section];
    return [carModel._detail count] +1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QueryCarModelResponse* carModel = [self.carListDataArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0)
    {
        if ([carModel._packageType intValue]==1) {
            int days = [NSDate dayInterval:[NSDate dateFromString:self.queryDataModel._fromDate withFormat:@"yyyy-MM-dd HH:mm"] withEndDay:[NSDate dateFromString:self.queryDataModel._toDate withFormat:@"yyyy-MM-dd HH:mm"]];
            days = abs(days);
            if (days >26) {
                carModel._packageType  = @"0";
                carModel._dayPrice = carModel._packageInfo._day;
                carModel._orderType = carModel._packageInfo._orderType;
                carModel._productType = carModel._packageInfo._productType;
            }
        }

        if ([carModel._levelType intValue] == 0) {
            return 51;
        }
        else {
            if ([carModel._packageType intValue] == 2) {
                return 148;
            }
            else if ([carModel._packageType intValue] == 1) {
                return 105;
            }
            else {
                return 78;
            }
        }
    }
    else {
        QueryCarModelResponse* carModel = [self.carListDataArray objectAtIndex:indexPath.section];
        CarModelDetail * carDetail = [carModel._detail objectAtIndex:indexPath.row - 1];
        if ([carDetail._packageType intValue]==1) {
            int days = [NSDate dayInterval:[NSDate dateFromString:self.queryDataModel._fromDate withFormat:@"yyyy-MM-dd HH:mm"] withEndDay:[NSDate dateFromString:self.queryDataModel._toDate withFormat:@"yyyy-MM-dd HH:mm"]];
            days = abs(days);
            if (days >26) {
                carDetail._packageType  = @"0";
                carDetail._dayPrice = carDetail._packageInfo._day;
                carDetail._orderType = carDetail._packageInfo._orderType;
                carDetail._productType = carDetail._packageInfo._productType;
            }
        }
        if ([carDetail._packageType intValue] == 2) {
            return 150;
        }
        else if ([carDetail._packageType intValue] == 1) {
            return 105;
        }
        else {
            return 78;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QueryCarModelResponse* carModel = [self.carListDataArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        if ([carModel._levelType intValue] == 0) {
            static NSString * carListHeader2CellIdentifier = @"carListHeader2CellIdentifier";
            CarListHeader2Cell * cell = [tableView dequeueReusableCellWithIdentifier:carListHeader2CellIdentifier];
            if (cell == nil) {
                cell = [[[CarListHeader2Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carListHeader2CellIdentifier] autorelease];
            }
            cell._insurance.text = [NSString stringWithFormat:@"基本险:¥%@/天",carModel._insurance];
            cell._preAuthorization.text = [NSString stringWithFormat:@"预授权%@元起",carModel._preAuthorization];
            cell._modelLevelName.text = carModel._modeLevelName;
            cell._modeLevel.text = carModel._modeLevelName;
            return cell;
        }
        else{
            NSString *tmp = @"";
            if (indexPath.row < 10) {
                tmp = [NSString stringWithFormat:@"0%d", indexPath.row];
            }
            else {
                tmp = [NSString stringWithFormat:@"%d", indexPath.row];
            }
            NSString * carListHeaderCellIdentifier = [NSString stringWithFormat:@"carListBodyCellIdentifier%d%@", indexPath.section, tmp];
            
            CarListHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:carListHeaderCellIdentifier];
            if (cell == nil) {
                cell = [[[CarListHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carListHeaderCellIdentifier] autorelease];
            }
            cell._picImageV.urlString = carModel._picUrl;
            cell._insurance.text = [NSString stringWithFormat:@"基本险:¥%@/天",carModel._insurance];
            cell._typeName.text = carModel._typeName;
            cell._typeDesc.text = carModel._typeDesc;
            cell._preAuthorization.text = [NSString stringWithFormat:@"预授权%@元起",carModel._preAuthorization];
            cell._dayPrice.text = [NSString stringWithFormat:@"¥ %@",carModel._dayPrice];
            cell._modeLevel.text = carModel._modeLevelName;
        
            [cell._packageTitleView._packageOpen addTarget:self action:@selector(setSelectFrame:) forControlEvents:UIControlEventTouchUpInside];
            [cell._packageBodyView._packageClose addTarget:self action:@selector(setUnSelectFrame:) forControlEvents:UIControlEventTouchUpInside];
            [cell._packageBodyView._packageSelect addTarget:self action:@selector(setSelectPackage:) forControlEvents:UIControlEventTouchUpInside];
            
            cell._packageTitleView._packageOpen.tag = [[NSString stringWithFormat:@"%d%@", indexPath.section, tmp] intValue];
            cell._packageBodyView._packageClose.tag = [[NSString stringWithFormat:@"%d%@", indexPath.section, tmp] intValue];
            cell._packageBodyView._packageSelect.tag = [[NSString stringWithFormat:@"%d%@", indexPath.section, tmp] intValue];
            
            if ([carModel._packageType intValue] == 0) {
                cell._packageBodyView.hidden = YES;
                cell._packageTitleView.hidden = YES;
            }
            else if ([carModel._packageType intValue] == 1) {
                cell._packageBodyView.hidden = YES;
                cell._packageTitleView.hidden = NO;
                cell._packageTitleView._packageBackGround.hidden = NO;
                
                [cell._packageTitleView._packageOpen setTitle:[NSString stringWithFormat:@"%@ %@元/天", carModel._packageInfo._packageInfo, carModel._packageInfo._day] forState:UIControlStateNormal];
            }
            else {
                cell._packageBodyView.hidden = NO;
                cell._packageTitleView.hidden = YES;
                
                cell._packageBodyView._packagePreferential.text = [NSString stringWithFormat:@"本车享受套餐优惠！取车时需全额支付、不退款"];//, carModel._packageInfo._discount
                cell._packageBodyView._packagePrice.text = [NSString stringWithFormat:@"均价%@元/天", carModel._packageInfo._day];
                cell._packageBodyView._packageTotal.text = [NSString stringWithFormat:@"%@", carModel._packageInfo._total];
            }
            return cell;
        }
    }
    else {
        NSString *tmp = @"";
        if (indexPath.row < 10) {
            tmp = [NSString stringWithFormat:@"0%d", indexPath.row];
        }
        else {
            tmp = [NSString stringWithFormat:@"%d", indexPath.row];
        }
        NSString * carListBodyCellIdentifier = [NSString stringWithFormat:@"carListBodyCellIdentifier%d%@", indexPath.section, tmp];
        
        CarListBodyCell * cell = [tableView dequeueReusableCellWithIdentifier:carListBodyCellIdentifier];
        if (cell == nil) {
            cell = [[[CarListBodyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carListBodyCellIdentifier] autorelease];
        }
        
        
        CarModelDetail * carDetail = [carModel._detail objectAtIndex:indexPath.row - 1];

        
        cell._picImageV.urlString = carDetail._picUrl;
        cell._insurance.text = [NSString stringWithFormat:@"基本险:¥%@/天",carDetail._insurance];
        cell._typeName.text = carDetail._typeName;
        cell._typeDesc.text = carDetail._typeDesc;
        cell._preAuthorization.text =  [NSString stringWithFormat:@"预授权%@元起",carDetail._preAuthorization];
        cell._dayPrice.text = [NSString stringWithFormat:@"¥ %@",carDetail._dayPrice];;
        
        [cell._packageTitleView._packageOpen addTarget:self action:@selector(setSelectFrame:) forControlEvents:UIControlEventTouchUpInside];
        [cell._packageBodyView._packageClose addTarget:self action:@selector(setUnSelectFrame:) forControlEvents:UIControlEventTouchUpInside];
        [cell._packageBodyView._packageSelect addTarget:self action:@selector(setSelectPackage:) forControlEvents:UIControlEventTouchUpInside];
        
        cell._packageTitleView._packageOpen.tag = [[NSString stringWithFormat:@"%d%@", indexPath.section, tmp] intValue];
        cell._packageBodyView._packageClose.tag = [[NSString stringWithFormat:@"%d%@", indexPath.section, tmp] intValue];
        cell._packageBodyView._packageSelect.tag = [[NSString stringWithFormat:@"%d%@", indexPath.section, tmp] intValue];
        
        if ([carDetail._packageType intValue] == 0) {
            cell._packageBodyView.hidden = YES;
            cell._packageTitleView.hidden = YES;
            cell._areaView.frame = CGRectMake(10, 0, 300, 78);
            cell._dottedView.frame = CGRectMake(15, 77, 290, 1);
        }
        else if ([carDetail._packageType intValue] == 1) {
            cell._packageBodyView.hidden = YES;
            cell._packageTitleView.hidden = NO;
            cell._packageTitleView._packageBackGround.hidden = YES;
            cell._areaView.frame = CGRectMake(10, 0, 300, 105);
            cell._dottedView.frame = CGRectMake(15, 103, 290, 1);
            
            [cell._packageTitleView._packageOpen setTitle:[NSString stringWithFormat:@"%@ %@元/天", carDetail._packageInfo._packageInfo, carDetail._packageInfo._day] forState:UIControlStateNormal];
        }
        else {
            cell._packageBodyView.hidden = NO;
            cell._packageTitleView.hidden = YES;
            cell._areaView.frame = CGRectMake(10, 0, 300, 150);
            cell._dottedView.frame = CGRectMake(15, 148, 290, 1);
            
            cell._packageBodyView._packagePreferential.text = [NSString stringWithFormat:@"本车享受套餐优惠！取车时需全额支付、不退款"]; //, carDetail._packageInfo._discount
            cell._packageBodyView._packagePrice.text = [NSString stringWithFormat:@"均价%@元/天", carDetail._packageInfo._day];
            cell._packageBodyView._packageTotal.text = [NSString stringWithFormat:@"%@", carDetail._packageInfo._total];
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QueryCarModelResponse* carModel = [self.carListDataArray objectAtIndex:indexPath.section];
    if ( (indexPath.row == 0) && [carModel._levelType intValue] == 0){
        return;
    }
    
    int tmp = 0;
    self.selectedCarDetail = carModel;
    if (indexPath.row ==0) {
        self.queryDataModel._modeCode = carModel._modeCode;
        self.queryDataModel._vehicleLevel = carModel._modeLevel;
        self.queryDataModel._levelType = carModel._levelType;
        self.queryDataModel._orderType = carModel._orderType;
        self.queryDataModel._productType = carModel._productType;
        tmp = [carModel._packageType intValue];
    }
    else {
        CarModelDetail * carDetail = [carModel._detail objectAtIndex:indexPath.row - 1];
        self.queryDataModel._modeCode = carDetail._modeCode;
        self.queryDataModel._vehicleLevel = carDetail._modeLevel;
        self.queryDataModel._levelType = carDetail._levelType;
        self.queryDataModel._orderType = carDetail._orderType;
        self.queryDataModel._productType = carDetail._productType;
        self.selectedCarDetail = carDetail;
        tmp = [carDetail._packageType intValue];
    }
    self.queryDataModel._selectPackage = @"0";
    self.queryDataModel._typeName = self.selectedCarDetail._typeName;
    self.queryDataModel._typeDesc = self.selectedCarDetail._typeDesc;
    self.queryDataModel._preAuthorization =self.selectedCarDetail._preAuthorization;
    
    if (tmp == 0 || tmp == 2) {
        [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(11, 0, ViewWidth - 22, 78)];
    }
    else if (tmp == 1) {
        [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(11, 0, ViewWidth - 22, 105)];
    }
    
    self._VCType = DidNoMember;
    if (self.isLogin) {
        [self loginSuccessFul];
    }
}

- (void)loginSuccessFul
{
//    CarPassengerViewController * carPassengerVC = [[CarPassengerViewController alloc] init];
//    carPassengerVC.carDetail = self.selectedCarDetail;
//    carPassengerVC.queryDataModel = self.queryDataModel;
//    [NavigationController pushViewController:carPassengerVC animated:YES];
//    [carPassengerVC release];
    
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
        NSLog(@"新增租车人");
        CarPassengerViewController * carPassengerVC = [[CarPassengerViewController alloc] init];
        carPassengerVC.gateway = @"0";
        carPassengerVC.actionType = @"0";
        carPassengerVC.carDetail = self.selectedCarDetail;
        carPassengerVC.queryDataModel = self.queryDataModel;
        [NavigationController pushViewController:carPassengerVC animated:YES];
        [carPassengerVC release];
        return;
    }
    
    CarPassengerListViewController * carPassengerVC = [[CarPassengerListViewController alloc] init];
    carPassengerVC.title = @"选择常用租车人";
    carPassengerVC.gateway = @"0";
    carPassengerVC.selectedCarDetail = self.selectedCarDetail;
    carPassengerVC.queryDataModel = self.queryDataModel;
    [NavigationController pushViewController:carPassengerVC animated:YES];
    [carPassengerVC release];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate －－上拉涮新委托方法

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:4.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}


-(void)loadDataSource{

    ASIFormDataRequest * theRequest = [InterfaceClass queryCarModel:self.queryDataModel  pageIndex:pageIndex];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onQueryCarModelPaseredResult:) Delegate:self needUserType:Default];

}
-(void)onQueryCarModelPaseredResult:(NSDictionary *)resultDic
{
    [self.carListDataArray addObjectsFromArray:[QueryCarModelResponse QueryCarModelResponse:resultDic ]];
    [myTable reloadData];
    _refreshHeaderView.frame=CGRectMake(0.0f, myTable.contentSize.height, myTable.frame.size.width, 80);
    [self doneLoadingTableViewData];
}


#pragma mark -
#pragma mark Data Source Loading / Reloading －－上拉涮新相关

//实现上拖的方法
- (void)reloadTableViewDataSource
{
	pageIndex++;
	[self loadDataSource];
	reloading = YES;
}

//还原方法
- (void)doneLoadingTableViewData{
	reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:myTable];
}


#pragma mark -
#pragma mark UIScrollViewDelegate －－上拉涮新相关

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark -
#pragma mark －－列表单元改变
- (void)setUnSelectFrame:(UIButton *)sender
{
    QueryCarModelResponse* carModel = [self.carListDataArray objectAtIndex:sender.tag/100];
    if (sender.tag%100 == 0) {
        carModel._packageType = @"1";
    }
    else {
        CarModelDetail * carDetail = [carModel._detail objectAtIndex:sender.tag%100 - 1];
        carDetail._packageType = @"1";
    }

    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:sender.tag%100 inSection:sender.tag/100]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)setSelectFrame:(UIButton *)sender
{
    QueryCarModelResponse* carModel = [self.carListDataArray objectAtIndex:sender.tag/100];
    if (sender.tag%100 == 0) {
        carModel._packageType = @"2";
    }
    else {
        CarModelDetail * carDetail = [carModel._detail objectAtIndex:sender.tag%100 - 1];
        carDetail._packageType = @"2";
    }

    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:sender.tag%100 inSection:sender.tag/100]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)setSelectPackage:(UIButton *)sender
{
    [self tableView:myTable didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag%100 inSection:sender.tag/100] frame:CGRectMake(11, 78, 298, 69)];
    
    QueryCarModelResponse* carModel = [self.carListDataArray objectAtIndex:sender.tag/100];
    if ( (sender.tag%100 == 0) && [carModel._levelType intValue] == 0){
        return;
    }
    self.selectedCarDetail = carModel;
    if (sender.tag%100 ==0) {
        self.queryDataModel._modeCode = carModel._modeCode;
        self.queryDataModel._vehicleLevel = carModel._modeLevel;
        self.queryDataModel._levelType = carModel._levelType;
        self.queryDataModel._orderType = carModel._packageInfo._orderType;
        self.queryDataModel._productType = carModel._packageInfo._productType;
//        self.selectedCarDetail._dayPrice = carModel._packageInfo._day;
    }
    else {
        CarModelDetail * carDetail = [carModel._detail objectAtIndex:sender.tag%100 - 1];
        self.queryDataModel._modeCode = carDetail._modeCode;
        self.queryDataModel._vehicleLevel = carDetail._modeLevel;
        self.queryDataModel._levelType = carDetail._levelType;
        self.queryDataModel._orderType = carDetail._packageInfo._orderType;
        self.queryDataModel._productType = carDetail._packageInfo._productType;
        self.selectedCarDetail = carDetail;
//        self.selectedCarDetail._dayPrice = carDetail._packageInfo._day;
    }
    self.queryDataModel._selectPackage = @"1";
    self.queryDataModel._typeName = self.selectedCarDetail._typeName;
    self.queryDataModel._typeDesc = self.selectedCarDetail._typeDesc;
    self.queryDataModel._preAuthorization =self.selectedCarDetail._preAuthorization;
    
    
    self._VCType = DidNoMember;
    if (self.isLogin) {
        [self loginSuccessFul];
    }
}
@end
