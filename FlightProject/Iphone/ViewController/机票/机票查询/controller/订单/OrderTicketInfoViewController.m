//
//  OrderTicketInfoViewController.m
//  FlightProject
//
//  Created by 高鹏程 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderTicketInfoViewController.h"

@interface OrderTicketInfoViewController ()

@end

@implementation OrderTicketInfoViewController
@synthesize orderInfoData;
@synthesize totalPrice;
@synthesize flyTpye;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.orderInfoData = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    self.title = @"机票详细信息";
    if (self.orderInfoData._isBuyInsurance) {
        insurancePrice = [[GetConfiguration shareGetConfiguration]._insurance intValue];
    }
    else {
        insurancePrice = 0;
    }
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, ViewWidth, ViewHeight-44-5) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.allowsSelection = NO;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - Table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 20;
    }
    else if (indexPath.section == 1) {
        return 40;
    }
    else if (indexPath.section == 2) {
        return 40;
    }
    else if (indexPath.section == 3) {
        return 20;
    }
    else if (indexPath.section == 4) {
        return 45;
    }
    else if (indexPath.section == 5) {
        
        if (self.orderInfoData._flightsInfoArray.count != 2) {
            return 60;
        }
        else {
            return 85;
        }
    }
    else 
    {
        if (indexPath.row == 0) {
            return 70;
        }
        else if (indexPath.row == 1) {
            if ([self.orderInfoData._getItineraryType intValue] == 0)
            {
                return 60;
            }else if ([self.orderInfoData._getItineraryType intValue] == 1){
                return 100;
            }else
                return 60;
        }
        else {
             return 80;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            if (self.orderInfoData._childCount > 0) {
                return [self.orderInfoData._flightsInfoArray count] * 2;
            }
            else {
                return [self.orderInfoData._flightsInfoArray count];
            }
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break; 
        case 4:
            return [self.orderInfoData._passengerArray count];
            break;
        case 5:
            return 1;
            break;
        case 6:
            return 3;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString * identifier = @"identifierView";
        OrderTicketHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[OrderTicketHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if (indexPath.section == 1)
    {
        NSString * identifier = @"identifierView";
        OrderTicketTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[OrderTicketTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            FlightInfo * info;
            
            if ([self.orderInfoData._flightsInfoArray count] == 1) {
                info = [self.orderInfoData._flightsInfoArray objectAtIndex:0];
                if (indexPath.row == 0) {
                    cell.titleLab.text = @"成人单程";
                    
                    cell.contentLab.text = [NSString stringWithFormat:@"（机票 ￥%d + 机建燃油 ￥%d + 保险 ￥%d）* %d张", [info._selectedCabin._ticketPrice intValue], [info._fuelTaxForAdult intValue] + [info._airportTaxForAdult intValue], insurancePrice, self.orderInfoData._adlutCount];
                }else {
                    cell.titleLab.text = @"儿童单程";
                    
                    cell.contentLab.text = [NSString stringWithFormat:@"（机票 ￥%d + 机建燃油 ￥%d + 保险 ￥%d）* %d张", [[self.orderInfoData._orderInfo._ticketPriceForChild objectAtIndex:0] intValue], [info._fuelTaxForChild intValue] + [info._airportTaxForChild intValue], insurancePrice, self.orderInfoData._childCount];
                }
            }
            else {
                if (self.orderInfoData._childCount > 0) {
                    info = [self.orderInfoData._flightsInfoArray objectAtIndex:indexPath.row / 2];
                    if (indexPath.row == 0) {
                        
                        if ([flyTpye intValue] == 2) {
                            cell.titleLab.text = @"成人一程";
                        }
                        else{
                            cell.titleLab.text = @"成人去程";
                        }
                        
                        cell.contentLab.text = [NSString stringWithFormat:@"（机票 ￥%d + 机建燃油 ￥%d + 保险 ￥%d）* %d张", [info._selectedCabin._ticketPrice intValue], [info._fuelTaxForAdult intValue] + [info._airportTaxForAdult intValue], insurancePrice, self.orderInfoData._adlutCount];
                    }
                    else if (indexPath.row == 1) {
                        
                        if ([flyTpye intValue] == 2) {
                            cell.titleLab.text = @"儿童一程";
                        }
                        else{
                            cell.titleLab.text = @"儿童去程";
                        }
                        
                        cell.contentLab.text = [NSString stringWithFormat:@"（机票 ￥%d + 机建燃油 ￥%d + 保险 ￥%d）* %d张", [[self.orderInfoData._orderInfo._ticketPriceForChild objectAtIndex:0] intValue], [info._fuelTaxForChild intValue] + [info._airportTaxForChild intValue], insurancePrice, self.orderInfoData._childCount];
                    }
                    else if (indexPath.row == 2) {
                        
                        if ([flyTpye intValue] == 2) {
                            cell.titleLab.text = @"成人二程";
                        }
                        else{
                            cell.titleLab.text = @"成人返程";
                        }
                        
                        cell.contentLab.text = [NSString stringWithFormat:@"（机票 ￥%d + 机建燃油 ￥%d + 保险 ￥%d）* %d张", [info._selectedCabin._ticketPrice intValue], [info._fuelTaxForAdult intValue] + [info._airportTaxForAdult intValue], insurancePrice, self.orderInfoData._adlutCount];
                    }else {
                        
                        if ([flyTpye intValue] == 2) {
                            cell.titleLab.text = @"儿童二程";
                        }
                        else{
                            cell.titleLab.text = @"儿童返程";
                        }
                        
                        cell.contentLab.text = [NSString stringWithFormat:@"（机票 ￥%d + 机建燃油 ￥%d + 保险 ￥%d）* %d张", [[self.orderInfoData._orderInfo._ticketPriceForChild objectAtIndex:1] intValue], [info._fuelTaxForChild intValue] + [info._airportTaxForChild intValue], insurancePrice, self.orderInfoData._childCount];
                    }
                }
                else {
                    info = [self.orderInfoData._flightsInfoArray objectAtIndex:indexPath.row];
                    
                    
                    if ([flyTpye intValue] == 2) {
                        if (indexPath.row == 0) {
                            cell.titleLab.text = @"成人一程";
                        }else {
                            cell.titleLab.text = @"成人二程";
                        }
                    }
                    else{
                        if (indexPath.row == 0) {
                            cell.titleLab.text = @"成人去程";
                        }else {
                            cell.titleLab.text = @"成人返程";
                        }
                    }
                    
                    cell.contentLab.text = [NSString stringWithFormat:@"（机票 ￥%d + 机建燃油 ￥%d + 保险 ￥%d）* %d张", [info._selectedCabin._ticketPrice intValue], [info._fuelTaxForAdult intValue] + [info._airportTaxForAdult intValue], insurancePrice, self.orderInfoData._adlutCount];
                }
            }
        }
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        NSString * identifier = @"identifierView";
        OrderTicketTotalMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[OrderTicketTotalMoneyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            
            cell.priceLab.text = [NSString stringWithFormat:@"%d", totalPrice];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if (indexPath.section == 3)
    {
        NSString * identifier = @"identifierView";
        OrderTicketClickCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[OrderTicketClickCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if (indexPath.section == 4)
    {
        NSString * identifier = [NSString stringWithFormat:@"identifier%d", indexPath.row];
        OrderTicketInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[OrderTicketInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            PassengerInfoItem *passegerInfo = [self.orderInfoData._passengerArray objectAtIndex:indexPath.row];
            cell.userName.text = passegerInfo._name; 
            cell.ticketName.text = [passegerInfo._type intValue] > 0 ? @"儿童票" : @"成人票";
            switch ([passegerInfo._certType intValue]) {
                case 0:
                    cell.paperwork.text = @"身份证";
                    break;
                case 1:
                    cell.paperwork.text = @"护照";
                    break;
                case 9:
                    cell.paperwork.text = @"其它";
                    break;
                default:
                    cell.paperwork.text = @"";
                    break;
            }
            if ([passegerInfo._type intValue] > 0) {
                cell.paperwork.text = @"生日";
                cell.paperworkNum.text = passegerInfo._birthday;
                NSLog(@"儿童信息：%@,%@,%@,%@", passegerInfo._name, passegerInfo._certType, passegerInfo._certNum, passegerInfo._id);
            }
            else
                cell.paperworkNum.text = passegerInfo._certNum;
        }
        
        return cell;
    }
    else if (indexPath.section == 5) {
        
        NSString *identifier = [NSString stringWithFormat:@"identifier51%d", indexPath.row];
        if (self.orderInfoData._flightsInfoArray.count != 2) {
            OrderTicketWaitManCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketWaitManCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (self.orderInfoData._pickUpPersonArray.count > 0) {
                PickPersonInfoItem *pickInfo = [self.orderInfoData._pickUpPersonArray objectAtIndex:0];
                if (pickInfo._name.length != 0) {
                    cell._waiterName.text = pickInfo._name;
                }
                cell._waiterPhone.text = pickInfo._phone;
            }
            return cell;
        }
        else {
            OrderTicketDoubleWaitManCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketDoubleWaitManCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (self.orderInfoData._pickUpPersonArray.count > 0) {
                PickPersonInfoItem *pickInfo = [self.orderInfoData._pickUpPersonArray objectAtIndex:0];
                if (pickInfo._name.length != 0) {
                    cell._waiterName.text = pickInfo._name;
                }
                cell._waiterPhone.text = pickInfo._phone;
                
                PickPersonInfoItem *pickInfo1 = [self.orderInfoData._pickUpPersonArray objectAtIndex:1];
                if (pickInfo1._name.length != 0) {
                    cell._waiterName1.text = pickInfo1._name;
                }
                cell._waiterPhone1.text = pickInfo1._phone;
            }
            return cell;
        }
    }
    else if (indexPath.section == 6)
    {
        NSString * identifier = @"identifier3";
        if (indexPath.row == 0) 
        {
            OrderTicketPhoneCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.telNum.text = self.orderInfoData._contactorPhone;
            }
            return cell;
        }
        else if (indexPath.row == 1)
        {
            OrderTicketAddresCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketAddresCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if ([self.orderInfoData._getItineraryType intValue] == 0) {
//                    cell.ticketType.text = @"不需要行程单";
//                    cell.addView.hidden = YES;
//                    cell.areaView.frame = CGRectMake(10, 0, 300, 40);
                    cell.ticketType.text = @"行程单";
                    cell.ticketState.text = @"不需要行程单";
                    cell.positionButton.hidden = YES;
                    cell.areaView.frame = CGRectMake(10, 0, 300, 60);
                }else  if ([self.orderInfoData._getItineraryType intValue] == 1){
                    cell.ticketType.text = @"行程单";
                    cell.ticketState.text = @"免费邮寄";
                    cell.ticketAddress.text = self.orderInfoData._postAddressItem._postAddress;
                    cell.areaView.frame = CGRectMake(10, 0, 300, 100);
                }else {
                    cell.ticketType.text = @"行程单";
                    cell.ticketState.text = @"终端机打印";
                    cell.positionButton.hidden = NO;
                    [cell.positionButton addTarget:self action:@selector(moveTo:) forControlEvents:UIControlEventTouchUpInside];
                    cell.areaView.frame = CGRectMake(10, 0, 300, 60);
                }
            }
            return cell;
        }
        else if (indexPath.row == 2)
        {
            OrderTicketServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                [cell.moreButton addTarget:self action:@selector(moreInfo:) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if (self.orderInfoData._isAcceptSevice) {
                    cell.serviceState.text = @"已选取服务";
                }else {
                    cell.serviceState.text = @"未选取服务";
                }
            }
            return cell;
        }
    }
     return nil;
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)moreInfo:(id)sender
{
    NSLog(@"自动降价更多描述");
    [UIAlertView alertViewWithMessage:ServiceText :@"自动降价说明"];
}


- (void)moveTo:(id)sender
{
    DevicePositionMapViewController * devicePositionVC = [[DevicePositionMapViewController alloc] init];
    [self.navigationController pushViewController:devicePositionVC animated:YES];
    [devicePositionVC release];
}
@end
