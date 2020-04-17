//
//  CarInformationViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarInformationViewController.h"
@interface CarInformationViewController ()

@end

@implementation CarInformationViewController
@synthesize _carInfoData, _ids, _notLoginUser;


- (void)dealloc
{
    myTable = nil;
    lineView = nil;
    bottomButton = nil;
    self._carInfoData = nil;
    self._ids = nil;
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
	self.title = @"订单详情";
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, ViewWidth, ViewHeight-44-15-50) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    
    UIView * _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 5)];
    [_footerView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10.0f, -3.0f, ViewWidth-20, 5.0f) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
    myTable.tableFooterView = _footerView;
    [_footerView release];
    
    lineView = [UIImageView ImageViewWithFrame:CGRectMake(10, ViewHeight-44-50-5, ViewWidth-20, 5) image:[UIImage imageNamed:@"分割线.png"]];
    
    bottomButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth - 136)/2, ViewHeight-44-50+5, 136, 33) backImage:[UIImage imageNamed:@"取消订单.png"] target:self action:@selector(bottomClick:)];
    
    if (![self._carInfoData._orderStatus isEqualToString:@"已预订"]) {
        bottomButton.hidden = YES;
        lineView.hidden = YES;
        myTable.frame = CGRectMake(0, 10, ViewWidth, ViewHeight-44-15);
    }
    [self.view addSubview:bottomButton];
    [self.view addSubview:lineView];
    [self.view addSubview:myTable];
    [myTable release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - Table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self._carInfoData._selectedService count] == 0) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return [self._carInfoData._selectedService count] == 0 ? 0 :[self._carInfoData._selectedService count] + 1;
            break;
            
        default:
            return 0;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return 225;
                break;
            case 1:
                return 320;
                break;
            case 2:
                return 60;
                break;
                
            default:
                return 0;
                break;
        }
    }
    else
    {
        if (indexPath.row == 0) {
            return 30;
        }
        else{
            return 30;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = [NSString stringWithFormat:@"identifier%d%d", indexPath.row, indexPath.section];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) 
        {
            MemberCarCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell._orderNumber.text = self._carInfoData._orderNumber;
            cell._orderStatus.text = self._carInfoData._orderStatus;
            cell._orderType.text = self._carInfoData._orderType;
            cell._submitDate.text = self._carInfoData._submitDate;
            NSInteger servicePrice = 0;
            for (CarServiceList * elem in self._carInfoData._selectedService) {
                servicePrice += [elem._servicePrice intValue];
            }
            if (servicePrice>0) {
                cell._priceInfo.text = [NSString stringWithFormat:@"租金 ￥%@ + 保险 ￥%@ + 增值服务 ￥%d + 其他费用 ￥%@", self._carInfoData._rent, self._carInfoData._insuranceAmount, servicePrice, self._carInfoData._serviceFee];
            }
            else{
                cell._priceInfo.text = [NSString stringWithFormat:@"租金 ￥%@ + 保险 ￥%@ + 其他费用 ￥%@", self._carInfoData._rent, self._carInfoData._insuranceAmount, self._carInfoData._serviceFee];
            }
            if ([[UserInfo sharedUserInfo].userID isEqualToString:@""] || [self._carInfoData._lcdFee intValue] == 0) {
                cell._returnLcdView.hidden = YES;
            } else {
                cell._lcdFee.text = [NSString stringWithFormat:@"返 %@", self._carInfoData._lcdFee];
            }

            cell._totalCarRentMoney.text = self._carInfoData._totalCarRentMoney;
            
            return cell;
        }
        else if (indexPath.row == 1){
            MemberCarInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberCarInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            cell._peopleName.text = self._carInfoData._name;
            cell._cellNum.text = self._carInfoData._identityNumber;
            cell._telephone.text = self._carInfoData._mobileNumber;
            cell._typeName.text = [NSString stringWithFormat:@"%@ %@",self._carInfoData._typeName,self._carInfoData._typeDesc];
            //cell._typeDesc.text = self._carInfoData._typeDesc;
            cell._takeDate.text = [self setDateType:self._carInfoData._fromDate];
            cell._returnDate.text = [self setDateType:self._carInfoData._toDate];
            cell._takeShop.text = self._carInfoData._takeShop;
            cell._returnShop.text = self._carInfoData._returnShop;
            return cell;
        }
        else if (indexPath.row == 2){
            MemberCarInsuranceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberCarInsuranceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell._insuranceAmount.text = [NSString stringWithFormat:@"¥%@", self._carInfoData._insuranceAmount];
            return cell;
        }
        
    }
    else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            MemberCarServiceTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberCarServiceTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            cell._serviceLabel.text = @"增值服务";
            return cell;
        }
        else {
            
            MemberCarServiceInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberCarServiceInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            CarServiceList *severiceList = [self._carInfoData._selectedService objectAtIndex:indexPath.row - 1];
            
            cell._serviceType.text = severiceList._serviceName;
            cell._servicePrice.text = [NSString stringWithFormat:@"¥%@", severiceList._servicePrice];
            return cell;
        }
    }
    return nil;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell点击事件");
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 5) {
        if (buttonIndex == 1)
        {
            if (self._notLoginUser) {
                ASIFormDataRequest * theRequest = [InterfaceClass deleteOrderCarByorderId:self._ids];
                [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDeleteOrderByCarResult:) Delegate:self needUserType:Default];
            }
            else {
                ASIFormDataRequest * theRequest = [InterfaceClass deleteOrderCarByorderId:self._ids];
                [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDeleteOrderByCarResult:) Delegate:self needUserType:Member];
            }
        }
    }
    else{
        [NavigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - self click
- (void)bottomClick:(id)sende
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil
                                                   message:@"您确定要取消订单吗？"
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"确定", nil];
    alert.tag = 5;
    [alert show];
    [alert release];
}

- (void)onDeleteOrderByCarResult:(NSDictionary *)dic
{
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@""
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    alert.tag = 0;
    [alert show];
    [alert release];
}

- (NSString *)setDateType:(NSString *)date
{
    NSString *changeDate = @"";
    NSArray *dateArray = [[date stringByReplacingOccurrencesOfString:@"-" withString:@" "] componentsSeparatedByString:@" "];
    
    if ([dateArray count] > 3) {
        changeDate = [NSString stringWithFormat:@"%@月%@日 %@", [dateArray objectAtIndex:1], [dateArray objectAtIndex:2], [dateArray objectAtIndex:3]];
    }

    return changeDate;
}
@end
