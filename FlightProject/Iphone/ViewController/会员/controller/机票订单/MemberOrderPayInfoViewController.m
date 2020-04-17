//
//  MemberOrderPayInfoViewController.m
//  FlightProject
//
//  Created by admin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberOrderPayInfoViewController.h"
#import "TicketOrderInfoViewController.h"

@interface MemberOrderPayInfoViewController ()

@end

@implementation MemberOrderPayInfoViewController
@synthesize totalPrice, orderDataInfo, childCount, adultCount;
@synthesize contactorPhone, isAcceptService, getItineraryType;
@synthesize keyboardbar,textFieldArray;
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
    self.orderDataInfo = nil;
    myField = nil;
    bottomButton = nil;
    
    self.getItineraryType = nil;
    self.isAcceptService = nil;
    self.contactorPhone = nil;
    
    self.keyboardbar = nil;
    self.textFieldArray = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    self.title = @"待支付详情";
    editorContent = FALSE;

    self.getItineraryType = self.orderDataInfo._getItineraryType;
    self.contactorPhone = self.orderDataInfo._telephone;
    self.isAcceptService = self.orderDataInfo._isAcceptService;
    
    if ([self.orderDataInfo._isBuyInsurance boolValue]) {
        insurancePrice = [[GetConfiguration shareGetConfiguration]._insurance intValue];
    }
    else {
        insurancePrice = 0;
    }
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, ViewWidth, ViewHeight-44-15-50) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    myTable.allowsSelection = NO;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
    
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, ViewHeight-44-50-5, ViewWidth - 20, 5) image:[UIImage imageNamed:@"分割线.png"]]];
    
    bottomButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(88, ViewHeight-44-50+5, 145, 37.5) backImage:[UIImage imageNamed:@"内容编辑.png"] target:self action:@selector(bottomClick:)];
    [self.view addSubview:bottomButton];
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.getItineraryType intValue] == 1) {
        [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:6]] withRowAnimation:UITableViewRowAnimationFade];
    }
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
        return 50;
    }
    else if (indexPath.section == 5) {
        if ([self.orderDataInfo._flightType intValue] != 2) {
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
            if (editorContent)
            {
                if ([self.getItineraryType intValue] != 0) {
                    return 190;
                }else {
                    return 60;
                }
            }
            else {
                if ([self.getItineraryType intValue] == 0)
                {
                    return 60;
                }else if ([self.getItineraryType intValue] == 1){
                    return 100;
                }else
                    return 60;
            }
        }
        else {
            return 70;
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
            if (self.childCount > 0) {
                return [self.orderDataInfo._flightInfo count] * 2;
            }
            else {
                return [self.orderDataInfo._flightInfo count];
            }
            return 2;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break; 
        case 4:
            return [self.orderDataInfo._passengersInfo count];
            return 2;
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
        NSString * identifier = @"identifierView1";
        OrderTicketTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[OrderTicketTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [self getTicketInfo:cell :indexPath];
        }
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        NSString * identifier = @"identifierView2";
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
        NSString * identifier = @"identifierView3";
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
        NSString * identifier = [NSString stringWithFormat:@"identifier4%d", indexPath.row];
        OrderTicketInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[OrderTicketInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [self getPassengersInfo:cell:indexPath];
        }
        return cell;
    }
    else if (indexPath.section == 5) {
        NSString *identifier = [NSString stringWithFormat:@"identifier51%d", indexPath.row];
        if ([self.orderDataInfo._flightType intValue] != 2) {
            OrderTicketWaitManCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketWaitManCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            if (self.orderDataInfo._pickInfo.count > 0) {
                MemberOrderDetailFlightPickResponse *pickInfo = [self.orderDataInfo._pickInfo objectAtIndex:0];
                cell._waiterName.text = pickInfo._pickName;
                cell._waiterPhone.text = pickInfo._pickPhone;
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

            if (self.orderDataInfo._pickInfo.count == 1) {
                
                MemberOrderDetailFlightPickResponse *pickInfo = [self.orderDataInfo._pickInfo objectAtIndex:0];
                
                if ([pickInfo._pickType intValue] == 0) {
                    cell._waiterName.text = pickInfo._pickName;
                    cell._waiterPhone.text = pickInfo._pickPhone;
                }
                else if ([pickInfo._pickType intValue] == 1) {
                    cell._waiterName1.text = pickInfo._pickName;
                    cell._waiterPhone1.text = pickInfo._pickPhone;
                }
            }
            else if (self.orderDataInfo._pickInfo.count == 2) {
                
                MemberOrderDetailFlightPickResponse *pickInfo = [self.orderDataInfo._pickInfo objectAtIndex:0];
                MemberOrderDetailFlightPickResponse *pickInfo1 = [self.orderDataInfo._pickInfo objectAtIndex:1];
                
                if ([pickInfo._pickType intValue] == 0) {
                    cell._waiterName.text = pickInfo._pickName;
                    cell._waiterPhone.text = pickInfo._pickPhone;
                    
                    cell._waiterName1.text = pickInfo1._pickName;
                    cell._waiterPhone1.text = pickInfo1._pickPhone;
                }
                else if ([pickInfo._pickType intValue] == 1) {
                    cell._waiterName1.text = pickInfo._pickName;
                    cell._waiterPhone1.text = pickInfo._pickPhone;
                    
                    cell._waiterName.text = pickInfo1._pickName;
                    cell._waiterPhone.text = pickInfo1._pickPhone;
                }
            }
            return cell;
        }
    }
    else if (indexPath.section == 6)
    {
        if (editorContent) {
            
            NSString *identifier = [NSString stringWithFormat:@"identifier61%d", indexPath.row];
            if (indexPath.row == 0) {
                MemberOrderModifyTelephoneCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[MemberOrderModifyTelephoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    self.textFieldArray = [NSArray arrayWithObjects:cell._phoneNumTF, nil];
                    
                    cell._phoneNumTF.text = self.contactorPhone;
                    cell._phoneNumTF.delegate = self;
                    myField = cell._phoneNumTF;
                }
                return cell;
            }
            else if (indexPath.row == 1){
                MemberOrderModifyItineraryCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[MemberOrderModifyItineraryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    
                    //[cell._itinerarySwitch addTarget:self action:@selector(itinerarySwitchAction:) forControlEvents:UIControlEventValueChanged];
			
                    
                    [cell._leftButton1 addTarget:self action:@selector(ItinerarySelect:) forControlEvents:UIControlEventTouchUpInside];
                    [cell._leftButton2 addTarget:self action:@selector(ItinerarySelect:) forControlEvents:UIControlEventTouchUpInside];
                    [cell._mailButton addTarget:self action:@selector(ItineraryrightButton:) forControlEvents:UIControlEventTouchUpInside];
                    [cell._terminalButton addTarget:self action:@selector(ItineraryrightButton:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                if ([self.getItineraryType intValue] == 1) {
                    [cell._leftButton1 setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
                    [cell._leftButton2 setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
                    cell._mailAddressLabel.hidden = NO;
                    cell._mailAddressLabel.text = self.orderDataInfo._postAddressInfo._postAddress;
                }
                else if ([self.getItineraryType intValue] == 2){
                    [cell._leftButton1 setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
                    [cell._leftButton2 setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
                    cell._mailAddressLabel.hidden = YES;
                }
                else {
                    cell._mailAddressLabel.hidden = YES;
                }
                
                cell._itinerarySwitch.tag = 100;
                cell._itinerarySwitch.delegate=self;
                [cell._itinerarySwitch setOn:NO animated:YES];
                if ([self.getItineraryType intValue] != 0) {
                    [cell._itinerarySwitch setOn:YES animated:YES];
                    cell._areaView.frame = CGRectMake(10, 0, 300, 190);
                    cell._leftButton1.hidden = NO;
                    cell._leftButton2.hidden = NO;
                    cell._mailButton.hidden = NO;
                    cell._terminalButton.hidden = NO;
                }
                else {
                    [cell._itinerarySwitch setOn:NO animated:YES];
                    cell._areaView.frame = CGRectMake(10, 0, 300, 60);
                    cell._leftButton1.hidden = YES;
                    cell._leftButton2.hidden = YES;
                    cell._mailButton.hidden = YES;
                    cell._terminalButton.hidden = YES;
                }
                
                return cell;
            }
            else {
                MemberOrderModifyServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[MemberOrderModifyServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    [cell._moreButton addTarget:self action:@selector(moreInfo:) forControlEvents:UIControlEventTouchUpInside];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    [cell addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 65, 300, 5) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
                }
                
                //[cell._serviceSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
		    
		    cell._serviceSwitch.tag = 101;
		    cell._serviceSwitch.delegate = self;
		    [cell._serviceSwitch setOn:NO animated:YES];
                if ([self.isAcceptService boolValue]) {
		    [cell._serviceSwitch setOn:YES animated:YES];
                }else {
		    [cell._serviceSwitch setOn:NO animated:YES];
                   
                }
                
                return cell;
            }
        }
        else {
         
            NSString * identifier = [NSString stringWithFormat:@"identifier%d", indexPath.row];

            if (indexPath.row == 0) {
                
                OrderTicketPhoneCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[OrderTicketPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                cell.telNum.text = self.contactorPhone;
                return cell;
            }
            else if (indexPath.row == 1)
            {
                OrderTicketAddresCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    cell = [[[OrderTicketAddresCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                
                if ([self.getItineraryType intValue] == 0) {
                    cell.ticketType.text = @"行程单";
                    cell.ticketState.text = @"不需要行程单";
                    cell.areaView.frame = CGRectMake(10, 0, 300, 60);
                    cell.positionButton.hidden = YES;
                    cell.ticketState.hidden = NO;
                    cell.ticketAddress.hidden = YES;
                    cell.addView.hidden = NO;
                }else  if ([self.getItineraryType intValue] == 1){
                    cell.ticketType.text = @"行程单";
                    cell.ticketState.text = @"免费邮寄";
                    cell.ticketAddress.text = self.orderDataInfo._postAddressInfo._postAddress;
                    cell.areaView.frame = CGRectMake(10, 0, 300, 100);
                    cell.positionButton.hidden = YES;
                    cell.ticketState.hidden = NO;
                    cell.ticketAddress.hidden = NO;
                    cell.addView.hidden = NO;
                }else {
                    cell.ticketType.text = @"行程单";
                    cell.ticketState.text = @"终端机打印";
                    [cell.positionButton addTarget:self action:@selector(moveTo:) forControlEvents:UIControlEventTouchUpInside];
                    cell.areaView.frame = CGRectMake(10, 0, 300, 60);
                    cell.positionButton.hidden = NO;
                    cell.ticketState.hidden = NO;
                    cell.ticketAddress.hidden = YES;
                    cell.addView.hidden = NO;
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
                }
                
                if ([self.isAcceptService boolValue]) {
                    cell.serviceState.text = @"已选取服务";
                }else {
                    cell.serviceState.text = @"未选取服务";
                }
                return cell;
            }
        }
    }
    return nil;
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [myField resignFirstResponder];
    [self.keyboardbar HiddenKeyBoard];
}

#pragma mark - textFild delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.keyboardbar == nil) {
        KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
        self.keyboardbar = _keyboardbar;
        [_keyboardbar release];
    }
    [keyboardbar showBar:textField];  //显示工具条 
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0) {
        [UIAlertView alertViewWithMessage:@"请输入联系人手机号码！" :@"提示"];
    }
    else if (textField.text.length < 11){
        [UIAlertView alertViewWithMessage:@"请输入11位手机号码！" :@"提示"];
    }
    
    self.contactorPhone = textField.text;
    NSLog(@"联系方式：%@", contactorPhone);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
 
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 11;
	
	if(textFieldStrLength >= textFieldMaxLenth)
	{
		textField.text = [textFieldStr substringToIndex:textFieldMaxLenth];
		return NO;
	}
	else {
		return YES;
	}

}

#pragma mark - Button Click
//- (void)switchAction:(UISwitch *)sender
//{
//    if (sender.on) {
//        self.isAcceptService = @"TRUE";
//    }
//    else {
//        self.isAcceptService = @"FALSE";
//    }
//    NSLog(@"是否接受服务%@", self.isAcceptService);
//}

- (void)valueChangedInView:(CustomUISwitch *)sender
{
	switch (sender.tag) {
		case 100:
			if (!sender.on) {
				self.getItineraryType = @"0";
			}
			else {
				self.getItineraryType = @"2";
			}
			[myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:6]] withRowAnimation:UITableViewRowAnimationFade];
			break;
		case 101:
			if (sender.on) {
				self.isAcceptService = @"TRUE";
			}
			else {
				self.isAcceptService = @"FALSE";
			}
			NSLog(@"是否接受服务%@", self.isAcceptService);
			break;
		default:
			break;
	}

}

-(void)ItineraryrightButton:(UIButton *)sender
{
    NSLog(@"ItineraryrightButton:%d",sender.tag);
    if (sender.tag == 2) {
        DevicePositionMapViewController * devicePositionVC = [[DevicePositionMapViewController alloc] init];
        [self.navigationController pushViewController:devicePositionVC animated:YES];
        [devicePositionVC release];
    }
    else {
        PassengersAddressViewController *passAddressVC = [[PassengersAddressViewController alloc] init];
        passAddressVC.addressItem = self.orderDataInfo._postAddressInfo;
	     passAddressVC->memberVC2 = self;
	//passAddressVC.sourceType = PaySourceType;
        [self.navigationController pushViewController:passAddressVC animated:YES];
        [passAddressVC release];
    }
}

-(void)ItinerarySelect:(UIButton *)sender
{
    self.getItineraryType = [NSString stringWithFormat:@"%d",sender.tag];
    NSLog(@"getItineraryType =:%@",self.getItineraryType);
    if ([self.getItineraryType intValue] == 2) {
        [UIAlertView alertViewWithMessage:@"行程单打印验证码会在您航班起飞前以短信发送给您，请您在7日内打印！" :@"提示"];
    }
    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:6]] withRowAnimation:UITableViewRowAnimationFade];
    
    if (sender.tag == 1) {
        if (self.orderDataInfo._postAddressInfo._postAddress.length == 0) {
            [self ItineraryrightButton:sender];
        }
    }
}

-(void)addAddressOverWithAddressItem:(PassengerAddressItem *)addressItem // 代理 passAddressVC.delegate
{
	self.orderDataInfo._postAddressInfo = addressItem;
	
	[myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:6]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)bottomClick:(id)sender
{
        
    if (editorContent) {
        if (![myField.text isMatchedByRegex:PHONENO]) {
            [UIAlertView alertViewWithMessage:@"请输入正确的手机号码！" :@"提示"];
            return;
        }

        NSString *postId = @"";
        if([self.getItineraryType intValue] == 1 )
        {
            if (self.orderDataInfo._postAddressInfo._postAddress.length > 0) {
                postId = self.orderDataInfo._postAddressInfo._id;
            }
            else{
                [UIAlertView alertViewWithMessage:@"请添加邮寄地址！" :@"提示"];
                return;
            }
        }
        editorContent = !editorContent;
        
        if (editorContent)
        {
            [bottomButton setImage:[UIImage imageNamed:@"编辑完成.png"] forState:UIControlStateNormal];
        }
        else{
            [bottomButton setImage:[UIImage imageNamed:@"内容编辑.png"] forState:UIControlStateNormal];
        }

        ASIFormDataRequest * theRequest = [InterfaceClass updateOrder:self.orderDataInfo._orderId withContactorPhone:self.contactorPhone withItineraryType:self.getItineraryType withPostInfo:postId withAcceptService:self.isAcceptService];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUpdateOrderResult:) Delegate:self needUserType:Member];
    }else {
        editorContent = !editorContent;
        
        if (editorContent)
        {
            [bottomButton setImage:[UIImage imageNamed:@"编辑完成.png"] forState:UIControlStateNormal];
        }
        else{
            [bottomButton setImage:[UIImage imageNamed:@"内容编辑.png"] forState:UIControlStateNormal];
        }

        [myTable reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)onUpdateOrderResult:(NSDictionary *)dic
{
    [UIAlertView alertViewWithMessage:@"订单修改成功！" :@"提示"];
    
    self.orderDataInfo._getItineraryType = self.getItineraryType;
    self.orderDataInfo._isAcceptService = self.isAcceptService;
    self.orderDataInfo._telephone = self.contactorPhone;
    
    [myTable reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationFade];
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

- (void)getTicketInfo:(OrderTicketTitleCell *)tableViewCell :(NSIndexPath *)indexPath
{
    MemberOrderDetailFlightInfoResponse *cellDataInfo;
            
    if ([self.orderDataInfo._flightInfo count] == 1) {
        
        cellDataInfo = [self.orderDataInfo._flightInfo objectAtIndex:0];
        if (indexPath.row == 0) {
            tableViewCell.titleLab.text = @"成人单程";
        }else {
            tableViewCell.titleLab.text = @"儿童单程";
        }
    }
    else {
        if (self.childCount > 0) {
            
            cellDataInfo = [self.orderDataInfo._flightInfo objectAtIndex:indexPath.row/2];
            
            if ([self.orderDataInfo._flightType intValue] == 2)
            {
                if (indexPath.row == 0) {
                    tableViewCell.titleLab.text = @"成人去程";
                }
                else if (indexPath.row == 1) {
                    tableViewCell.titleLab.text = @"儿童去程";
                }
                else if (indexPath.row == 2) {
                    tableViewCell.titleLab.text = @"成人返程";
                }else {
                    tableViewCell.titleLab.text = @"儿童返程";
                }
            }
            else
            {
                if (indexPath.row == 0) {
                    tableViewCell.titleLab.text = @"成人一程";
                }
                else if (indexPath.row == 1) {
                    tableViewCell.titleLab.text = @"儿童一程";
                }
                else if (indexPath.row == 2) {
                    tableViewCell.titleLab.text = @"成人二程";
                }else {
                    tableViewCell.titleLab.text = @"儿童二程";
                }
            }
        }
        else {
            
            cellDataInfo = [self.orderDataInfo._flightInfo objectAtIndex:indexPath.row];
            
            if ([self.orderDataInfo._flightType intValue] == 2) {
                if (indexPath.row == 0) {
                    tableViewCell.titleLab.text = @"成人去程";
                }else {
                    tableViewCell.titleLab.text = @"成人返程";
                }
            }
            else {
                if (indexPath.row == 0) {
                    tableViewCell.titleLab.text = @"成人一程";
                }else {
                    tableViewCell.titleLab.text = @"成人二程";
                }
            }
        }
    }
    
    if ([[tableViewCell.titleLab.text substringToIndex:2] isEqualToString:@"成人"]) {
        tableViewCell.contentLab.text = [NSString stringWithFormat:@"（机票 ￥%d + 机建燃油 ￥%d + 保险 ￥%d）* %d张", [cellDataInfo._adultInfo._ticketPrice intValue], [cellDataInfo._adultInfo._airportTax intValue] + [cellDataInfo._adultInfo._fuelTax intValue], insurancePrice, self.adultCount];
    }
    else {
        tableViewCell.contentLab.text = [NSString stringWithFormat:@"（机票 ￥%d + 机建燃油 ￥%d + 保险 ￥%d）* %d张", [cellDataInfo._childInfo._ticketPrice intValue], [cellDataInfo._childInfo._airportTax intValue] + [cellDataInfo._childInfo._fuelTax intValue], insurancePrice, self.childCount];
    }
}

- (void)getPassengersInfo:(OrderTicketInfoCell *)cell :(NSIndexPath *)indexPath
{
    MemberOrderDetailPassengersInfoResponse *cellDataPassenger = [self.orderDataInfo._passengersInfo objectAtIndex:indexPath.row];
    cell.userName.text = cellDataPassenger._name; 

    if ([cellDataPassenger._type intValue] > 0) 
    {
        cell.ticketName.text = @"儿童票";
        cell.paperwork.text = @"生日";
        cell.paperworkNum.text = cellDataPassenger._birthday;
    }
    else {
        cell.ticketName.text = [cellDataPassenger._type intValue] > 0 ? @"儿童票" : @"成人票";
        switch ([cellDataPassenger._certType intValue]) {
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
        if ([cellDataPassenger._type intValue] > 0) {
            cell.paperwork.text = @"生日";
        }
        cell.paperworkNum.text = cellDataPassenger._certNum;
    }
}
@end
