//
//  CarServicesViewController.m
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarServicesViewController.h"
#import "CarListCell.h"
#import "CarPassengerViewController.h"
#import "NOMemberLoginViewController.h"

@interface CarServicesViewController ()

@end

@implementation CarServicesViewController
@synthesize  carDetail, carService,isSelectedServiceArray;
@synthesize queryDataModel;
-(void)dealloc
{
    self.carDetail = nil;
    self.carService = nil;
    self.isSelectedServiceArray = nil;
    self.queryDataModel = nil;
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
    self.title = @"增值服务";
	// Do any additional setup after loading the view.
    
    self.isSelectedServiceArray = [NSMutableArray array];
    for (int i=0; i<[self.carService._carService count]; i++) {
        CarService * service = [self.carService._carService objectAtIndex:i];
        if ([service._chooseType isEqualToString:@"1"]) {
            [self.isSelectedServiceArray addObject:@"1"];
        }
        else {
            [self.isSelectedServiceArray addObject:@"0"];
        }
    }
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, ViewWidth, ViewHeight-44 - 50 - 15) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
    
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, ViewHeight-44-50-5, ViewWidth-20, 5) image:[UIImage imageNamed:@"分割线.png"]]];
    
    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"TicketQueryConnectSure.png"] frame:CGRectMake((ViewWidth - 113) / 2, ViewHeight - 44 - 50 + 5, 113, 34) font:nil  color:nil target:self action:@selector(sureButton:)]];
    
}

-(void) backHome
{
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
        [NavigationController popViewControllerAnimated:YES];
        return;
    }
    for (int i = 0; i < [NavigationController.viewControllers count]; i ++) {
        if ([[NavigationController.viewControllers objectAtIndex:i] isKindOfClass:[CarPassengerListViewController class]]) {
            [NavigationController popToViewController:[NavigationController.viewControllers objectAtIndex:i] animated:YES];
        }
    }
}

-(void)selectService:(UIButton *)sender
{
    NSString * str = [self.isSelectedServiceArray objectAtIndex:sender.tag];
    str = [NSString stringWithFormat:@"%d",([str intValue] +1) % 2] ;
    [self.isSelectedServiceArray replaceObjectAtIndex:sender.tag withObject:str];
    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:sender.tag inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)sureButton:(UIButton * )sender // 待续
{
    if (![UserInfo sharedUserInfo].userID ){
        [UserInfo sharedUserInfo]._loginTime = nil;
    }
    
    self.queryDataModel._serviceId = @"";
    self.queryDataModel._activityId = @"";
    
    
    for (int i = 0; i < [self.carService._carService count]; i++) {
        if ([[self.isSelectedServiceArray objectAtIndex:i] boolValue]) {
            CarService * service =  [self.carService._carService objectAtIndex:i];
            self.queryDataModel._serviceId = [self.queryDataModel._serviceId isEqualToString:@"" ]?  [NSString stringWithFormat:@"%@",service._serviceId] : [NSString stringWithFormat:@"%@&%@",self.queryDataModel._serviceId,service._serviceId] ;
        }
    }
    for (int i = 0; i < [self.carService._actvityList count]; i++) {
            CarActvity * activity =  [self.carService._actvityList objectAtIndex:i];
           self.queryDataModel._activityId = [self.queryDataModel._activityId isEqualToString:@"" ]? [NSString stringWithFormat:@"%@",activity._actvityId] : [NSString stringWithFormat:@"%@&%@",self.queryDataModel._activityId,activity._actvityId] ;
    }
//    self._VCType = DidNoMember;
//    if (self.isLogin) {
//        [self loginSuccessFul];
//    }
    
    ASIFormDataRequest * theRequest = [InterfaceClass submitOrderCar:self.queryDataModel];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSubmitOrderCaPaseredResult:) Delegate:self needUserType:NoMember];
}
-(void) loginSuccessFul
{
    ASIFormDataRequest * theRequest = [InterfaceClass submitOrderCar:self.queryDataModel];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSubmitOrderCaPaseredResult:) Delegate:self needUserType:NoMember];
}
-(void)onSubmitOrderCaPaseredResult:(NSDictionary *)resultDic
{
//    ======================
//    SubmitOrderCarResponse * submitOrderCarRes = [SubmitOrderCarResponse SubmitOrderCarResponse:resultDic];
//    self.queryDataModel._submitOrderCarRes = submitOrderCarRes;    
//    CarPassengerViewController * carPassengerVC = [[CarPassengerViewController alloc] init];
//    carPassengerVC.queryDataModel = self.queryDataModel;
//    [NavigationController pushViewController:carPassengerVC animated:YES];
//    [carPassengerVC release];
    
    
    SubmitOrderCarResponse * submitOrderCarRes = [SubmitOrderCarResponse SubmitOrderCarResponse:resultDic];
    self.queryDataModel._submitOrderCarRes = submitOrderCarRes;
    CarSubmitOrderViewController * submitOrderVC = [[CarSubmitOrderViewController alloc] init];
    submitOrderVC.queryDataModel = self.queryDataModel;
    [NavigationController pushViewController:submitOrderVC animated:YES];
    [submitOrderVC release];
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UISubLabel labelWithframe:CGRectMake(0, 0, ViewWidth, 15) backgroundColor:[UIColor clearColor]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.carService._carService count] >0) {
        if ([self.carService._actvityList count] >0) {
            return 3;
        }
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 78;
    }
    else  if (indexPath.section == 1) {
        return 60;
    }
    else {
        CarActvity * activity = [self.carService._actvityList objectAtIndex:indexPath.row];
        CGSize suggestedSize = [activity._actvityDesc sizeWithFont:FontSize32 constrainedToSize:CGSizeMake(tableView.frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        return suggestedSize.height + 80.0f;
    }
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else  if (section == 1) {
        return [self.carService._carService count];
    }
    else {
        return [self.carService._actvityList count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString * carListBodyCellIdentifier = @"carListBodyCellIdentifier";
        CarListBodyCell * cell = [tableView dequeueReusableCellWithIdentifier:carListBodyCellIdentifier];
        if (cell == nil) {
            cell = [[[CarListBodyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carListBodyCellIdentifier] autorelease];
            cell._areaView.image = [UIImage imageNamed:@"carStoreName.png"];
            cell._dottedView.hidden = YES;
        }
        cell._picImageV.urlString = self.carDetail._picUrl;
        cell._insurance.text = [NSString stringWithFormat:@"基本险:¥%@/天",self.carDetail._insurance];
        cell._typeName.text = self.carDetail._typeName;
        cell._typeDesc.text = self.carDetail._typeDesc;
        cell._preAuthorization.text =  [NSString stringWithFormat:@"预授权%@元起",self.carDetail._preAuthorization];
        
        if ([self.queryDataModel._selectPackage intValue] == 1) {
            cell._dayPrice.text = [NSString stringWithFormat:@"¥ %@",self.carDetail._packageInfo._day];
        }
        else {
            cell._dayPrice.text = [NSString stringWithFormat:@"¥ %@",self.carDetail._dayPrice];
        }
        
        return cell;
    }
    else if (indexPath.section == 1) {
        static NSString * carServiceCellIdentifier = @"carServiceCellIdentifier";
        CarServicesCell  * cell = [tableView dequeueReusableCellWithIdentifier:carServiceCellIdentifier];
        if (cell == nil) {
            cell = [[[CarServicesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carServiceCellIdentifier] autorelease];
        }
        CarService * service = [self.carService._carService objectAtIndex:indexPath.row];
        if ([service._chooseType intValue] == 1) { // 必选
            [cell._serviceButton setImage:[UIImage imageNamed:@"FilterMoreSelected.png"] forState:UIControlStateNormal];
            cell._serviceButton.enabled = NO;
        }
        else { // 3可选
            NSString * str = [self.isSelectedServiceArray objectAtIndex:indexPath.row];
            if ([str boolValue]) {
                 [cell._serviceButton setImage:[UIImage imageNamed:@"FilterMoreSelected.png"] forState:UIControlStateNormal];
            }
            else {
                [cell._serviceButton setImage:[UIImage imageNamed:@"FilterMoreUnSelected.png"] forState:UIControlStateNormal];
            }
            cell._serviceButton.enabled = YES;
        }
        cell._serviceButton.tag = indexPath.row;
        [cell._serviceButton addTarget:self action:@selector(selectService:) forControlEvents:UIControlEventTouchUpInside];
        cell._serviceName.text = service._serviceName;
        cell._servicePrice.text = [NSString stringWithFormat:@"%@", service._servicePrice];
        return cell;
    }
    else {
        static NSString * carActivityCellIdentifier = @"carServiceCellIdentifier";
        UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:carActivityCellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carActivityCellIdentifier] autorelease];
            UISubLabel * label = [UISubLabel labelWithTitle:nil frame:CGRectMake(10, 0, ViewWidth - 20, 44) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentLeft];
            label.tag = 99;
            [cell addSubview:label];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        CarActvity * activity = [self.carService._actvityList objectAtIndex:indexPath.row];
        CGSize suggestedSize = [activity._actvityDesc sizeWithFont:FontSize32 constrainedToSize:CGSizeMake(tableView.frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        UISubLabel * label = (UISubLabel *) [cell viewWithTag:99];
        CGRect rect = label.frame;
        rect.size.height = suggestedSize.height;
        label.frame = rect;
        label.text = activity._actvityDesc;
	    cell.backgroundColor = [UIColor clearColor];

        return cell;
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
@end
