//
//  MemberOrderPayViewController.m
//  FlightProject
//
//  Created by admin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberOrderPayViewController.h"
#import "AppDelegate.h"
#import "RecommendClass.h"
#import "DataClass.h"

@interface MemberOrderPayViewController ()

@end

@implementation MemberOrderPayViewController
@synthesize myField;
@synthesize myMode, requestURL, requestTimes, requestApplication, unionPayResult;
@synthesize myDelegate;
@synthesize orderDataInfo;
@synthesize keyboardbar, textFieldArray;
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
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    self.orderDataInfo = nil;
    self.myField = nil;
    myDelegate.payResultDelegate = nil;
    

    [super dealloc];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    [self initData];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44-5) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.allowsSelection = YES;
    myTable.dataSource = self;
    myTable.delegate = self;
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return flightCount;
    }
    else if (section == 1){
        return 2;
    }
    else if (section == 2){
        return 1;
    }
    else {
        return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (!isSelect) {
            return 50;
        }else
            return 100;
    }
    else if (indexPath.section == 1)
    {
        return 105;
    }
    else if (indexPath.section == 2)
    {
        if (isAllPayment) {
            return 70;
        }
        else {
            NSArray *paymentArray = [self.orderDataInfo._payment componentsSeparatedByString:@"&"];
            return 25+45*[paymentArray count];
//            if (paymentArray.count > 2) {
//                return 135;
//            }
//            else {
//                return 70;
//            }
        }
    }
    else {
        return 60;
    }
}

-(void) orderTicket3Cell:(OrderTicket3Cell *  )cell  :(NSInteger )i
{
    NSArray *paymentArray = [self.orderDataInfo._payment componentsSeparatedByString:@"&"];

    cell._backGroundView.frame = CGRectMake(10, 0, ViewWidth - 20, 30+paymentArray.count*45);
    
    NSMutableArray * btnArr = [NSMutableArray array];
    for (int i = 0; i < paymentArray.count; i ++)
    {
        if (i>5) {
            break;
        }
        PayUIButton *button = (PayUIButton *)[cell viewWithTag:[[paymentArray objectAtIndex:i] intValue]];
        button.hidden = NO;
        if ([btnArr count]==0) {
            [btnArr addObject:button];
        }
        else
        {
            NSUInteger insertIndex = [btnArr count];
            for (int i = 0; i < btnArr.count; i ++) {
                PayUIButton *elem = (PayUIButton *)[btnArr objectAtIndex:i];
                if (elem._level > button._level) {
                    insertIndex = i;
                    break;
                }
            }
            [btnArr insertObject:button atIndex:insertIndex];
        }
    }
    for (int i = 0; i < btnArr.count; i ++) {
        PayUIButton *elemBtn = (PayUIButton *)[btnArr objectAtIndex:i];
        elemBtn.frame = CGRectMake(0, 25+i*45, ViewWidth, 45);
    }
    
    //    if (paymentArray.count < 3) {
    //        cell._backGroundView.frame = CGRectMake(10, 0, ViewWidth - 20, 65);
    //    }
//    int offx = (ViewWidth - 320)/2;
//    for (int i = 0; i < paymentArray.count; i ++) {
//        
//        UIButton *button = (UIButton *)[cell viewWithTag:[[paymentArray objectAtIndex:i] intValue]];
//        button.hidden = NO;
//        
//        if (i == 0) {
//            button.frame = CGRectMake(20 + offx, 27, 136, 33);
//        }
//        else if (i == 1) {
//            button.frame = CGRectMake(164 + offx, 27, 136, 33);
//        }
//        else if (i == 2) {
//            button.frame = CGRectMake(20 + offx, 75, 136, 33);
//        }
//        else if (i == 3) {
//            button.frame = CGRectMake(164 + offx, 75, 136, 33);
//        }
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (!isSelect) 
        {
            NSString * identifier = @"identifier1";
            OrderTicketToPerchCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketToPerchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            if ([self.orderDataInfo._flightInfo count] > 1 && indexPath.row == 0) {
                cell.lineView.hidden = NO;
            }else{
                cell.lineView.hidden = YES;
            }
            [self setFlightinfo1Info:cell indexPath:indexPath];
            
            return cell;
        }
        else 
        {
            NSString * identifier = @"identifier11";
            OrderTicketToPerchDoubleCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketToPerchDoubleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                [cell.ruleButton addTarget:self action:@selector(ruleInfo:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            cell.ruleButton.tag =  indexPath.row;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if ([self.orderDataInfo._flightInfo count] > 1 && indexPath.row == 0) {
                cell.lineView.hidden = NO;
            }else{
                cell.lineView.hidden = YES;
            }
            [self setFlightinfo2Info:cell indexPath:indexPath];
            
            return cell;
        }
    }
    
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            NSString * identifier = @"identifier2";
            OrderTicketPriceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.cellButton addTarget:self action:@selector(moveViewRight:) forControlEvents:UIControlEventTouchUpInside];
                [cell.moveButton addTarget:self action:@selector(moveViewDown:) forControlEvents:UIControlEventTouchUpInside];
            }
            if ([[UserInfo sharedUserInfo].userID isEqualToString:@""] || [self.orderDataInfo._returnLcdCurrency intValue] ==0) {
                cell._returnLcdView.hidden = YES;
            }
            else {
                cell._returnLcdView.hidden = NO;
            }
            [self orderTicketPriceCell:cell :indexPath.row];
            return cell;
        }
        else {
            NSString * identifier = @"identifier22";
            OrderTicketPrice2Cell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketPrice2Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            actualPriceLab = cell.remainderLab;
            actualPriceLab.text = [NSString stringWithFormat:@"%d", totalPrice];
            cell.coinFiled.delegate = self;
            self.textFieldArray = [NSArray arrayWithObjects:cell.coinFiled, nil];
            self.myField = cell.coinFiled ;
            cell.ownCoinLab.text = [NSString stringWithFormat:@"可使用 %d 畅达币", lcdPrice];
            return cell;
        }
    }
    else if (indexPath.section == 2)
    {
        if (isAllPayment)
        {
            NSString * identifier = @"identifier4";
            OrderTicketPayCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.payButton addTarget:self action:@selector(payCDCoin:) forControlEvents:UIControlEventTouchUpInside];
            }
            return cell;
        }
        else 
        {
            NSString * identifier = @"identifier3";
            OrderTicket3Cell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicket3Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.leftButton._button addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
                [cell.rightButton._button addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
                [cell.cardButton._button addTarget:self action:@selector(clickCardButton:) forControlEvents:UIControlEventTouchUpInside];
                [cell.weixinButton._button addTarget:self action:@selector(clickWeixinButton:) forControlEvents:UIControlEventTouchUpInside];
                [cell.telButton._button addTarget:self action:@selector(clickTelButton:) forControlEvents:UIControlEventTouchUpInside];
//                [cell.otherButton addTarget:self action:@selector(moveOtherView:) forControlEvents:UIControlEventTouchUpInside];
            }
            [self orderTicket3Cell:cell :indexPath.row];
            return cell;
        }   
    }
    else if (indexPath.section == 3)
    {
        NSString * identifier = @"identifier5";
        OrderTicketCancelCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[OrderTicketCancelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.cancelButton addTarget:self action:@selector(cancelOrder:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
    return nil;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell点击事件");
    [self isFlightNumCA];
//    [self.myField resignFirstResponder];
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

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    actualPriceLab.text = [NSString stringWithFormat:@"%d", totalPrice];
    textField.text = @"0";
    if (isAllPayment) {
        isAllPayment = !isAllPayment;
        
        [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
    }
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * temp = [textField.text stringByReplacingCharactersInRange:range withString:string];
    temp = [NSString stringWithFormat:@"%d",[temp intValue]];

    if (lcdPrice > totalPrice) {
        if ([temp intValue] >= totalPrice) {
            if (!isAllPayment) {
                isAllPayment = !isAllPayment;
                
                [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
            }
            
            textField.text = [NSString stringWithFormat:@"%d", totalPrice];
            actualPriceLab.text = @"0";
            
            if ([temp intValue] > totalPrice) {
                [UIAlertView alertViewWithMessage:@"您使用的畅达币超出了应支付的当前票价！" :@"提示"];
            }
            return NO;
        }
        
        if ([temp intValue] < totalPrice && isAllPayment) {
            isAllPayment = !isAllPayment;
            
            [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    else{
        if ([temp intValue] >= lcdPrice) {
            
            textField.text = [NSString stringWithFormat:@"%d", lcdPrice];
            actualPriceLab.text = [NSString stringWithFormat:@"%d",  (totalPrice - lcdPrice)];
            if ([temp intValue] > lcdPrice) {
                [UIAlertView alertViewWithMessage:@"您没有这么多的可用畅达币！" :@"提示"];
            }
            return NO;
        }
    }
    actualPriceLab.text = [NSString stringWithFormat:@"%d",  (totalPrice - [temp intValue])];
    textField.text = temp;
    return NO;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 123) {
        if (buttonIndex == 1) {
            NSString * URLString = @"http://itunes.apple.com/cn/app/id333206289?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
        }
    }
    else  if (alertView.tag == 124) {
    }
    else if (alertView.tag == 1)
    {
        if (buttonIndex == 1) {
            [self callTel:@"400-6858-999"];
        }
    }
    else if (alertView.tag == 2)
    {
        self._pointView._pointLab.tag -= 1;
        [NavigationController popViewControllerAnimated:YES];
    }
    else if (alertView.tag == 11)
    {
        if (buttonIndex == 1) {
            ASIFormDataRequest * theRequest = [InterfaceClass cancelOrder:[UserInfo sharedUserInfo].userID withOrderId:self.orderDataInfo._orderId]; //测试的UserID69743 69752
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCancelOrderResult:) Delegate:self needUserType:Member];
        }
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        myDelegate.payResultDelegate = nil;
        
        OrderByCardPayViewController *orderPay = [[OrderByCardPayViewController alloc] init];
        orderPay.cardPayMoney = actualPriceLab.text;
        orderPay.lcdCurrency = myField.text;
        orderPay.orderId = self.orderDataInfo._orderId;
        orderPay.telephone = self.orderDataInfo._telephone;
        orderPay.returnLcd = self.orderDataInfo._returnLcdCurrency;
    
        MemberOrderDetailFlightInfoResponse * flightInfo = nil;
        if ([self.orderDataInfo._flightType intValue] < 3 ) {
            flightInfo = [self.orderDataInfo._flightInfo objectAtIndex:0];
        }
        else if ([self.orderDataInfo._flightType intValue] == 3) {
            flightInfo = [self.orderDataInfo._flightInfo objectAtIndex:1];
        }
        
        orderPay._flightArriveCode = [DataClass selectFromAirportCityListWithCityName:flightInfo._arrival];
        orderPay._flightArriveDateCode = flightInfo._arrivalDate;//[flightInfo._endTime substringToIndex:10];
        
        [NavigationController pushViewController:orderPay animated:YES];
        [orderPay release];
    }
    else if (buttonIndex == 1)
    {
        [self callTel:@"400-6858-999"];
    }
}

#pragma mark - self
- (void)cancelOrder:(id)sender
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil
                                                   message:@"您确定取消改订单吗？"
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"确定", nil];
    [alert setTag:11];
    [alert show];
    [alert release];
}

- (void)onCancelOrderResult:(NSDictionary *)dic
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil
                                                   message:@"您已成功取消该订单，请前往订单列表查看"
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    [alert setTag:2];
    [alert show];
    [alert release];
}

- (void)payCDCoin:(id)sender
{
    if ([GetConfiguration shareGetConfiguration]._umeng) {
        [MobClick event:@"LcdPay"];
    }
    NSLog(@"畅达币支付！");
    myDelegate.payResultDelegate = nil;
    
    ASIFormDataRequest * theRequest = [InterfaceClass payLcdCoin:[UserInfo sharedUserInfo].userID withOrderId:self.orderDataInfo._orderId withPayCoin:myField.text];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getPayCDCoinResult:) Delegate:self needUserType:Member];
}

- (void)getPayCDCoinResult:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"statusCode"] intValue] == 0 || [[dic objectForKey:@"statusCode"] intValue] == 1 || [[dic objectForKey:@"statusCode"] intValue] == 3) {
        [self paySuccessFul:dic];
    }
    else {
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
    }
}

- (void)moveViewDown:(id)sender
{
    NSLog(@"抽屉按钮点击！");
//    [self.myField resignFirstResponder];
    [self.keyboardbar HiddenKeyBoard];
    
    isSelect = !isSelect;
    
    NSMutableArray *arryCell = [[NSMutableArray alloc] init];
    for (int i = 0; i < [myTable numberOfRowsInSection:0]; i ++) {
        [arryCell addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [arryCell addObject:[NSIndexPath indexPathForRow:0 inSection:1]];
    [myTable reloadRowsAtIndexPaths:arryCell withRowAnimation:UITableViewRowAnimationFade];
    [arryCell release];
}

- (void)moveViewRight:(id)sender
{
//    [self.myField resignFirstResponder];
    [self.keyboardbar HiddenKeyBoard];
    myDelegate.payResultDelegate = nil;
    NSLog(@"VIEW 右测切换！");
    
    MemberOrderPayInfoViewController *orderPayInfoVC = [[MemberOrderPayInfoViewController alloc] init];
    orderPayInfoVC.totalPrice = totalPrice;
    orderPayInfoVC.adultCount = adultCount;
    orderPayInfoVC.childCount = childCount;
    orderPayInfoVC.orderDataInfo = self.orderDataInfo;
    [self.navigationController pushViewController:orderPayInfoVC animated:YES];
    [orderPayInfoVC release];
}

- (void)moveOtherView:(id)sender
{
    NSLog(@"其他方式支付");
    myDelegate.payResultDelegate = nil;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"支付方式选择"
                                                             delegate:self 
                                                    cancelButtonTitle:@"取消" 
                                               destructiveButtonTitle:@"信用卡支付"
                                                    otherButtonTitles:@"拨打客服电话预订", nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}

- (void)clickRightButton:(UIButton *)sender
{
    if ([GetConfiguration shareGetConfiguration]._umeng) {
        [MobClick event:@"UnionPay"];
    }
    
    NSArray *paymentArray = [self.orderDataInfo._payment componentsSeparatedByString:@"&"];
    NSArray *payInfoArray = [self.orderDataInfo._paymentInfo componentsSeparatedByString:@"&"];
    if (self.orderDataInfo._paymentInfo.length > 0) {
        NSString *payMesage = [payInfoArray objectAtIndex:[paymentArray indexOfObject:[NSString stringWithFormat:@"%d", sender.tag]]];
        if (payMesage.length > 0) {
            
            [UIAlertView alertViewWithMessage:payMesage];
            return;
        }
    }
    
    NSLog(@"右侧支付按钮");
    self.myMode = Union;
    myDelegate.payResultDelegate = nil;
    [self orderPay:@"1"];
}

- (void)clickLeftButton:(UIButton *)sender
{
    if ([GetConfiguration shareGetConfiguration]._umeng) {
        [MobClick event:@"AlixPay"];
    }
    
    NSArray *paymentArray = [self.orderDataInfo._payment componentsSeparatedByString:@"&"];
    NSArray *payInfoArray = [self.orderDataInfo._paymentInfo componentsSeparatedByString:@"&"];
    if (self.orderDataInfo._paymentInfo.length > 0) {
        NSString *payMesage = [payInfoArray objectAtIndex:[paymentArray indexOfObject:[NSString stringWithFormat:@"%d", sender.tag]]];
        if (payMesage.length > 0) {
            
            [UIAlertView alertViewWithMessage:payMesage];
            return;
        }
    }
    
    NSLog(@"左侧支付按钮");
    self.myMode = Alix;
    myDelegate.payResultDelegate = self;
    [self orderPay:@"0"];
}
- (void)clickWeixinButton:(UIButton *)sender
{
    NSArray *paymentArray = [self.orderDataInfo._payment componentsSeparatedByString:@"&"];
    NSArray *payInfoArray = [self.orderDataInfo._paymentInfo componentsSeparatedByString:@"&"];
    if (self.orderDataInfo._paymentInfo.length > 0) {
        NSString *payMesage = [payInfoArray objectAtIndex:[paymentArray indexOfObject:[NSString stringWithFormat:@"%d", sender.tag]]];
        if (payMesage.length > 0) {
            
            [UIAlertView alertViewWithMessage:payMesage];
            return;
        }
    }
    
    NSLog(@"微信支付按钮");
    self.myMode = Weixin;
    myDelegate.payResultDelegate = self;
     [self orderPay:@"5"];
//    [WeiXinExport sendPay_Demo:nil];
}
- (void)clickTelButton:(UIButton *)sender
{
    NSArray *paymentArray = [self.orderDataInfo._payment componentsSeparatedByString:@"&"];
    NSArray *payInfoArray = [self.orderDataInfo._paymentInfo componentsSeparatedByString:@"&"];
    if (self.orderDataInfo._paymentInfo.length > 0) {
        NSString *payMesage = [payInfoArray objectAtIndex:[paymentArray indexOfObject:[NSString stringWithFormat:@"%d", sender.tag]]];
        if (payMesage.length > 0) {
            
            [UIAlertView alertViewWithMessage:payMesage];
            return;
        }
    }
    
    [self callTel:@"400-6858-999"];
}

- (void)clickCardButton:(UIButton *)sender
{
    NSArray *paymentArray = [self.orderDataInfo._payment componentsSeparatedByString:@"&"];
    NSArray *payInfoArray = [self.orderDataInfo._paymentInfo componentsSeparatedByString:@"&"];
    if (self.orderDataInfo._paymentInfo.length > 0) {
        NSString *payMesage = [payInfoArray objectAtIndex:[paymentArray indexOfObject:[NSString stringWithFormat:@"%d", sender.tag]]];
        if (payMesage.length > 0) {
            
            [UIAlertView alertViewWithMessage:payMesage];
            return;
        }
    }
    
    myDelegate.payResultDelegate = nil;
    
    OrderByCardPayViewController *orderPay = [[OrderByCardPayViewController alloc] init];
    orderPay.isCAFlight = [self isFlightNumCA];
    orderPay.cardPayMoney = actualPriceLab.text;
    orderPay.lcdCurrency = myField.text;
    orderPay.orderId = self.orderDataInfo._orderId;
    orderPay.telephone = self.orderDataInfo._telephone;
    orderPay.returnLcd = self.orderDataInfo._returnLcdCurrency;
    
    MemberOrderDetailFlightInfoResponse * flightInfo = nil;
    if ([self.orderDataInfo._flightType intValue] < 3 ) {
        flightInfo = [self.orderDataInfo._flightInfo objectAtIndex:0];
    }
    else if ([self.orderDataInfo._flightType intValue] == 3) {
        flightInfo = [self.orderDataInfo._flightInfo objectAtIndex:1];
    }
    
    orderPay._flightArriveCode = [DataClass selectFromAirportCityListWithCityName:flightInfo._arrival];
    orderPay._flightArriveDateCode = flightInfo._arrivalDate;//[flightInfo._endTime substringToIndex:10];
    
    [NavigationController pushViewController:orderPay animated:YES];
    [orderPay release];
}

- (void)searchRuleResult:(NSDictionary *)dic
{
    NSLog(@"dic = %@", dic);
    [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"rule"]]:@"退改签规则"];
}
- (void)orderPay:(NSString *)payType
{    
    NSString * _actualPrice = [NSString stringWithFormat:@"%d",[actualPriceLab.text intValue]];
    NSString * _lcdPrice =  [NSString stringWithFormat:@"%d",[myField.text intValue]];
    ASIFormDataRequest * theRequest = [InterfaceClass getMessageState:[UserInfo sharedUserInfo].userID withOrderId:self.orderDataInfo._orderId withPayMoney:_actualPrice withPayCoin:_lcdPrice withPayType:payType];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getMessageStateResult:) Delegate:self needUserType:Member];
}

- (void)getMessageStateResult:(NSDictionary *)dic
{
    NSString * orderInfo  = nil;
    if ([[dic objectForKey:@"statusCode"] intValue] == 0) {
        orderInfo  =[NSString stringWithFormat:@"%@",[dic objectForKey:@"packets"]] ;
        if ([orderInfo length] <10) {
            orderInfo = nil;
        }
    }
    
    if (self.myMode == Alix) {
        if (orderInfo) {
            NSString *appScheme = @"FlightProject";
            [[AlipaySDK defaultService] payOrder:orderInfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                self.myMode = AlixPayEnd;
                self.requestURL =  resultDic;

//                self.requestURL =  url;
//                self.requestApplication = application;
                
                NSString * resultData = [NSString stringWithFormat:@"resultStatus={%@};memo={%@};result={%@}",[resultDic objectForKey:@"resultStatus"],[resultDic objectForKey:@"memo"],[resultDic objectForKey:@"result"]];
                NSLog(@"%@",resultData);
                
                ASIFormDataRequest * theRequest = [InterfaceClass getOrdersState:[UserInfo sharedUserInfo].userID withOrderId:self.orderDataInfo._orderId withTimes:[NSString stringWithFormat:@"%d",++requestTimes] withPayType:@"0" withPackets:resultData];
                
                if ([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]] intValue] != 9000) {
                    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
                }
                else {
                    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getOrdersStateResult:) Delegate:self needUserType:Default];
                }

            }];
        }
//        if (orderInfo) {
//            NSString *appScheme = @"FlightProject"; 
//            AlixPay * alixpay = [AlixPay shared];
//            int ret = [alixpay pay:orderInfo applicationScheme:appScheme];
//            if (ret == kSPErrorAlipayClientNotInstalled) {
//                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
//                                                                     message:@"您还没有安装支付宝客户端，请安装后进行支付。\n点击确定，立即安装。" 
//                                                                    delegate:self 
//                                                           cancelButtonTitle:@"取消" 
//                                                           otherButtonTitles:@"确定",nil];
//                [alertView setTag:123];
//                [alertView show];
//                [alertView release];
//            }
//            else if (ret == kSPErrorSignError) {
//                NSLog(@"签名错误！");
//            }
//        }
        
        return;
    }
    if (self.myMode == Union) {
        if (orderInfo) {
//            //[UPPayPlugin test:orderInfo SystemProvide:@"00000001" SPID:@"0001" withViewController:self Delegate:self];
//            [UPPayPlugin startPay:orderInfo SystemProvide:@"10941000" SPID:@"0190" withViewController:self Delegate:self];
//            [UPPayPlugin startPay:orderInfo sysProvide:nil spId:nil mode:UPPayMode viewController:self delegate:self];
            [UPPayPlugin startPay:orderInfo mode:UPPayMode viewController:self delegate:self];
        }
        return;
    }
    if (self.myMode == Weixin)
    {
        [WeiXinExport sendPay:dic];
    }
}
-(void)weixinPayResp:(PayResp *)resp//微信支付结果通知
{
    NSString * reutrnResp = resp.returnKey;
    NSLog(@"weixinPayResp:%@",reutrnResp);
    reutrnResp = @"failure";
     if (resp.errCode == WXSuccess)
     {
         reutrnResp = @"success";
     }
    self.myMode = WeixinEnd;
    self.requestURL =  resp;
    ASIFormDataRequest * theRequest = [InterfaceClass getOrdersState:[UserInfo sharedUserInfo].userID withOrderId:self.orderDataInfo._orderId withTimes:[NSString stringWithFormat:@"%d",++requestTimes] withPayType:@"5" withPackets:reutrnResp];
    if (resp.errCode == WXSuccess) {
        
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getOrdersStateResult:) Delegate:self needUserType:Default];
    }
    else {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
    }
}
- (void)parseURL:(NSDictionary *)resultDic application:(UIApplication *)application {
    self.myMode = AlixPayEnd;
    self.requestURL =  resultDic;
    self.requestApplication = application;
    NSString * resultData = [NSString stringWithFormat:@"resultStatus={%@};memo={%@};result={%@}",[resultDic objectForKey:@"resultStatus"],[resultDic objectForKey:@"memo"],[resultDic objectForKey:@"result"]];
    NSLog(@"%@",resultData);
    
    ASIFormDataRequest * theRequest = [InterfaceClass getOrdersState:[UserInfo sharedUserInfo].userID withOrderId:self.orderDataInfo._orderId withTimes:[NSString stringWithFormat:@"%d",++requestTimes] withPayType:@"0" withPackets:resultData];
    
    if ([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]] intValue] != 9000) {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
    }
    else {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getOrdersStateResult:) Delegate:self needUserType:Default];
    }
}
//- (void)parseURL:(NSURL *)url application:(UIApplication *)application
//{
//    self.myMode = AlixPayEnd;
//    self.requestURL =  url;
//    self.requestApplication = application;
//    NSString * urlStr = [[NSString stringWithFormat:@"%@",url] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",urlStr);
//    NSRange range = [urlStr rangeOfString:@"?"];
//    NSString * query = [urlStr substringFromIndex:range.location+1];
//    NSLog(@"%@",query);
//    NSDictionary * alixDic = [query JSONValue];
//    NSDictionary * data = [alixDic objectForKey:@"memo"];
//    NSString * resultStatus = [data objectForKey:@"ResultStatus"];
//    NSString * memo = [data objectForKey:@"memo"];
//    NSString * result = [data objectForKey:@"result"];
////    result = [result stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
////    result = [result stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
//    NSString * resultData = [NSString stringWithFormat:@"resultStatus={%@};memo={%@};result={%@}",resultStatus,memo,result];
//    NSLog(@"%@",resultData);
//    
//    ASIFormDataRequest * theRequest = [InterfaceClass getOrdersState:[UserInfo sharedUserInfo].userID withOrderId:self.orderDataInfo._orderId withTimes:[NSString stringWithFormat:@"%d",++requestTimes] withPayType:@"0" withPackets:resultData];
//    
//    if ([resultStatus intValue] != 9000) {
//        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
//    }
//    else {
//        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getOrdersStateResult:) Delegate:self needUserType:Default];
//    }
//}

-(void)UPPayPluginResult:(NSString*)result  // 银联支付结果回调
{    
    
    self.myMode = UnionPayEnd;
    self.unionPayResult = result;
    
    ASIFormDataRequest * theRequest = [InterfaceClass getOrdersState:[UserInfo sharedUserInfo].userID withOrderId:self.orderDataInfo._orderId withTimes:[NSString stringWithFormat:@"%d",++requestTimes] withPayType:@"1" withPackets:result];
    if ([self.unionPayResult isEqualToString:@"success"]) {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(getOrdersStateResult:) Delegate:self needUserType:Default];
    }
    else {
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:nil Delegate:nil needUserType:Default];
    }
}

- (void)getOrdersStateResult:(NSDictionary *)dic
{
    if ((self.myMode == UnionPayEnd)  || (self.myMode == AlixPayEnd) || (self.myMode == WeixinEnd)) {
        
        GetPaymentInfoResphonse * paymentInfo = [GetPaymentInfoResphonse GetPaymentInfoResphonse:dic];
        
        if([paymentInfo.result isEqualToString:@"1"]){
            if (requestTimes == 1) {
                sleep(5);
            }
            else if (requestTimes == 2) {
                sleep(3);
            }
            else if (requestTimes < 11)  {
                sleep(2);
            }
            else {
                [self paySuccessFul:dic];
                return;
            }
            if (self.myMode == AlixPayEnd) {
                [self parseURL:requestURL application:requestApplication];
            }
            else if (self.myMode == UnionPayEnd) {
                [self UPPayPluginResult:self.unionPayResult];
            }
            else if (self.myMode == WeixinEnd) {
                [self weixinPayResp:requestURL];
            }
        }
        else {
            if ([paymentInfo.result isEqualToString:@"0"] || [paymentInfo.result isEqualToString:@"3"]) {
                [self paySuccessFul:dic];
            }
            else {
                [UIAlertView alertViewWithMessage:paymentInfo.message tag:0 delegate:nil];
            }
        }
        return;
    }
}
-(void) paySuccessFul:(NSDictionary *)resultDic
{
    myDelegate.payResultDelegate = nil;
    
    MemberOrderDetailFlightInfoResponse * flightInfo = nil;
    if ([self.orderDataInfo._flightType intValue] < 3 ) {
        flightInfo = [self.orderDataInfo._flightInfo objectAtIndex:0];
    }
    else if ([self.orderDataInfo._flightType intValue] == ConnectTypeSecond) {
        flightInfo = [self.orderDataInfo._flightInfo objectAtIndex:1];
    }
    // flightInfo._arrival; 城市汉字
    //
    
    NSString * _cityName = flightInfo._arrival;//[DataClass selectFromAirportCityListWithCityCode:];
    NSString * _hotelCode = [DataClass selectFromHotelCityListWithCityName:_cityName];
    NSString * _carCode = [DataClass selectFromCarRentalListWithCityName:_cityName];
    
    SubmitOrderCarInfo * tempDataModel = nil;
    TicketQueryDataModel * tempHotelDataModel = nil;
    NSString * startDate = flightInfo._arrivalDate;
    
    if (_hotelCode) {
        tempHotelDataModel = [[TicketQueryDataModel alloc] init];
        tempHotelDataModel._fromCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:_cityName  code:_hotelCode ];
        tempHotelDataModel._startDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateFormateTicketQuery:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"]] code:startDate ]; 
        tempHotelDataModel._arriveDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:1 type:3] code:[NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:1 type:1] ]; 
    }
    
    if (_carCode) {
        tempDataModel = [[SubmitOrderCarInfo alloc] init];
        tempDataModel._cityCode = _carCode;
        tempDataModel._toCityCode =_carCode;
        tempDataModel._fromDate = [NSString stringWithFormat:@"%@ 10:00",[NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:1 type:1]] ;
        tempDataModel._toDate =  [NSString stringWithFormat:@"%@ 10:00",[NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:2 type:1]] ;
    }
    PayForSuccessViewController *paySuccessVC = [[PayForSuccessViewController alloc] init];
    paySuccessVC._messageTitle = [resultDic objectForKey:@"message"];
    paySuccessVC._CAFlight = [self isFlightNumCA];
    paySuccessVC._orderId = orderID;
    
//    NSString * str = self.orderDataInfo._returnLcdCurrency;
//    NSString * totalstr = self.orderDataInfo._ticketPrice;
//    int radio = [str intValue] * 100 / [totalstr intValue];
    
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""] || [self.orderDataInfo._returnLcdCurrency intValue] == 0) {
        paySuccessVC._message =@"重要提示：\n相关信息会发送短信与您确认。";
    }
    else {
        paySuccessVC._message =[NSString stringWithFormat:@"重要提示：\n1.相关信息会发送短信与您确认\n2.客户起飞后会返还%@个畅达币到您的畅达币账户。",self.orderDataInfo._returnLcdCurrency] ;
    }
    
    paySuccessVC._carQuery = tempDataModel;
    paySuccessVC._hotelQuery = tempHotelDataModel;
    [tempDataModel release];
    [tempHotelDataModel release];
    paySuccessVC._whoPaySuccess = Ticket;
    [NavigationController pushViewController:paySuccessVC animated:YES];
    [paySuccessVC release];
    
}

- (void)ruleInfo:(UIButton *)sender
//- (void)ruleInfo:(UIButton *)sender
{
    MemberOrderDetailFlightInfoResponse *flightDataInfo = [self.orderDataInfo._flightInfo objectAtIndex:sender.tag];
    NSString *ruleMessage = [NSString stringWithFormat:@"%@", flightDataInfo._rules];
    [UIAlertView alertViewWithMessage:ruleMessage :@"退改签规则"];
}

- (void)initData
{
    isSelect = NO;
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    userID = [UserInfo sharedUserInfo].userID;
    orderID = self.orderDataInfo._orderId;
    passengersCount = [self.orderDataInfo._passengersInfo count];
    flightCount = [self.orderDataInfo._flightInfo count];
    ticketCount = flightCount * passengersCount;
    
    totalPrice = [self.orderDataInfo._ticketPrice intValue];
    for (MemberOrderDetailPassengersInfoResponse *item in self.orderDataInfo._passengersInfo) {
        if ([item._type intValue] == 0) {
            adultCount ++;
        }
        else {
            childCount ++;
        }
    }
    
    for (int i = 0; i < [self.orderDataInfo._flightInfo count]; i ++) {
        MemberOrderDetailFlightInfoResponse *flightDataInfo = [self.orderDataInfo._flightInfo objectAtIndex:i];

        if (i == 0){
            goPrice = [flightDataInfo._adultInfo._ticketPrice intValue]*adultCount + [flightDataInfo._childInfo._ticketPrice intValue]*childCount;
            oneAirportPrice =  ([flightDataInfo._adultInfo._fuelTax intValue] + [flightDataInfo._adultInfo._airportTax intValue])*adultCount + ([flightDataInfo._childInfo._fuelTax intValue] + [flightDataInfo._childInfo._airportTax intValue])*childCount;
        }
        else {
            arrPrice = [flightDataInfo._adultInfo._ticketPrice intValue]*adultCount + [flightDataInfo._childInfo._ticketPrice intValue]*childCount;
            twoAirportPrice = ([flightDataInfo._adultInfo._fuelTax intValue] + [flightDataInfo._adultInfo._airportTax intValue])*adultCount + ([flightDataInfo._childInfo._fuelTax intValue] + [flightDataInfo._childInfo._airportTax intValue])*childCount;
        }
    }
    
    totalAirportPrice = oneAirportPrice + twoAirportPrice;
    if ([self.orderDataInfo._isBuyInsurance boolValue]) {
        insurancePrice = flightCount * passengersCount * [[GetConfiguration shareGetConfiguration]._insurance intValue];
    }
    else {
        insurancePrice = 0;
    }
    lcdPrice = [self.orderDataInfo._availableLcdCurrency intValue];
//    totalPrice = goPrice + arrPrice + totalAirportPrice + insurancePrice;
}

-(void) orderTicketPriceCell:(OrderTicketPriceCell *  )cell  :(NSInteger )i
{
    cell.returnCoinLab.text = self.orderDataInfo._returnLcdCurrency;
    cell.totalMoneyCoinLab.text = [NSString stringWithFormat:@"%d", totalPrice];
    
    if (isSelect) {
        [cell.moveButton setBackgroundImage:[UIImage imageNamed:@"抽屉2.png"] forState:UIControlStateNormal];
    }else {
        [cell.moveButton setBackgroundImage:[UIImage imageNamed:@"抽屉.png"] forState:UIControlStateNormal];
    }
    
    if ([self.orderDataInfo._flightType intValue] == 1) {
        cell.ticketLab.text = [NSString stringWithFormat:@"票价：￥%d（%d张）", goPrice, ticketCount];
        cell.fuelLab.text = [NSString stringWithFormat:@"机建燃油费：￥%d（%d份）", totalAirportPrice, ticketCount];
    }
    else if ([self.orderDataInfo._flightType intValue] == 2)
    {
        cell.ticketLab.text = [NSString stringWithFormat:@"去程票价：￥%d（%d张）", goPrice, ticketCount/2];
        cell.arrMoneyLab.text = [NSString stringWithFormat:@"返程票价：￥%d（%d张）", arrPrice, ticketCount/2];
        cell.fuelLab.text = [NSString stringWithFormat:@"去程机建燃油费：￥%d（%d份）", oneAirportPrice, ticketCount/2];
        cell.twoFuelLab.text = [NSString stringWithFormat:@"返程机建燃油费：￥%d（%d份）", twoAirportPrice, ticketCount/2];
        
        cell.arrMoneyLab.hidden = NO;
        cell.twoFuelLab.hidden = NO;
        
        cell.ticketLab.frame = CGRectMake(135, 20, 200, 20);
        cell.arrMoneyLab.frame = CGRectMake(135, 33, 200, 20);
        cell.fuelLab.frame = CGRectMake(135, 46, 200, 20);
        cell.twoFuelLab.frame = CGRectMake(135, 59, 200, 20);
        cell.insuranceLab.frame = CGRectMake(135, 72, 200, 20);
    }
    else if ([self.orderDataInfo._flightType intValue] == 3)
    {
        cell.ticketLab.text = [NSString stringWithFormat:@"一程票价：￥%d（%d张）", goPrice, ticketCount/2];
        cell.arrMoneyLab.text = [NSString stringWithFormat:@"二程票价：￥%d（%d张）", arrPrice, ticketCount/2];
        cell.fuelLab.text = [NSString stringWithFormat:@"一程机建燃油费：￥%d（%d份）", oneAirportPrice, ticketCount/2];
        cell.twoFuelLab.text = [NSString stringWithFormat:@"二程机建燃油费：￥%d（%d份）", twoAirportPrice, ticketCount/2];
        
        cell.arrMoneyLab.hidden = NO;
        cell.twoFuelLab.hidden = NO;
        
        cell.ticketLab.frame = CGRectMake(135, 20, 200, 20);
        cell.arrMoneyLab.frame = CGRectMake(135, 33, 200, 20);
        cell.fuelLab.frame = CGRectMake(135, 46, 200, 20);
        cell.twoFuelLab.frame = CGRectMake(135, 59, 200, 20);
        cell.insuranceLab.frame = CGRectMake(135, 72, 200, 20);
    }
    
    if ([self.orderDataInfo._isBuyInsurance boolValue]) {
        cell.insuranceLab.text = [NSString stringWithFormat:@"保险：￥%d（%d份）", insurancePrice, ticketCount];
    }else {
        cell.insuranceLab.text = [NSString stringWithFormat:@"保险：￥0（0份）"];
    }    
}

-(void) setFlightinfo1Info: (OrderTicketToPerchCell *  )tableViewCell indexPath: (NSIndexPath *)indexPath
{
    MemberOrderDetailFlightInfoResponse *cellDataInfo = [self.orderDataInfo._flightInfo objectAtIndex:indexPath.row];
    tableViewCell.departureCity.text = cellDataInfo._departure;
    tableViewCell.arrCity.text = cellDataInfo._arrival;
    tableViewCell.departureDate.text = [NSString stringWithFormat:@"%@", cellDataInfo._startTime];
    tableViewCell.arrDate.text = [NSString stringWithFormat:@"%@", cellDataInfo._endTime];
    tableViewCell.companyName.text = [NSString stringWithFormat:@"%@%@", cellDataInfo._airline, cellDataInfo._flightNo];
    tableViewCell.departureTime.text = [NSString stringWithFormat:@"%@", cellDataInfo._departureDate];
    tableViewCell.roomLab.text = [NSString stringWithFormat:@"%@(%@)", cellDataInfo._cabinType, cellDataInfo._cabinCode];
    tableViewCell.companyView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [cellDataInfo._flightNo substringToIndex:2]]];
    
    if ([self.orderDataInfo._flightType intValue] == 2) {
        if (indexPath.row == 0) {
            tableViewCell._stateName.text = @"去程";
        }else {
            tableViewCell._stateName.text = @"返程";
        }        
    }
    else if ([self.orderDataInfo._flightType intValue] == 3)
    {
        if (indexPath.row == 0) {
            tableViewCell._stateName.text = @"第一航程";
        }else {
            tableViewCell._stateName.text = @"第二航程";
        }
    }
}

-(void) setFlightinfo2Info: (OrderTicketToPerchDoubleCell *  )tableViewCell indexPath: (NSIndexPath *)indexPath
{
    MemberOrderDetailFlightInfoResponse *cellDataInfo = [self.orderDataInfo._flightInfo objectAtIndex:indexPath.row];
    tableViewCell.departureTime.text = [NSString stringWithFormat:@"%@", cellDataInfo._departureDate];
    tableViewCell.companyName.text = [NSString stringWithFormat:@"%@%@", cellDataInfo._airline, cellDataInfo._flightNo];
    tableViewCell.companyView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [cellDataInfo._flightNo substringToIndex:2]]];
    tableViewCell.planModels.text = [NSString stringWithFormat:@"机型: %@", cellDataInfo._planeType];
    tableViewCell.departureCity.text = cellDataInfo._departure;
    tableViewCell.arrCity.text = cellDataInfo._arrival;
    tableViewCell.departureDate.text = [NSString stringWithFormat:@"%@", cellDataInfo._startTime];
    tableViewCell.arrDate.text = [NSString stringWithFormat:@"%@", cellDataInfo._endTime];
    tableViewCell.airport1.text = [NSString stringWithFormat:@"%@%@", cellDataInfo._startAirport, cellDataInfo._startTerminal];
    tableViewCell.airport2.text = [NSString stringWithFormat:@"%@%@", cellDataInfo._endAirport, cellDataInfo._endTerminal];
    tableViewCell.roomLab.text = [NSString stringWithFormat:@"%@(%@)", cellDataInfo._cabinType, cellDataInfo._cabinCode];
    
    if ([self.orderDataInfo._flightType intValue] == 2) {
        if (indexPath.row == 0) {
            tableViewCell._stateName.text = @"去程";
        }else {
            tableViewCell._stateName.text = @"返程";
        }        
    }
    else if ([self.orderDataInfo._flightType intValue] == 3)
    {
        if (indexPath.row == 0) {
            tableViewCell._stateName.text = @"第一航程";
        }else {
            tableViewCell._stateName.text = @"第二航程";
        }
    }
}

- (BOOL)isFlightNumCA
{
    BOOL isCA = NO;
    for (int i = 0; i < [self.orderDataInfo._flightInfo count]; i ++) {
        
        MemberOrderDetailFlightInfoResponse *cellDataInfo = [self.orderDataInfo._flightInfo objectAtIndex:i];
        NSLog(@"所选航班号：%@-%d", [cellDataInfo._flightNo substringToIndex:2], i);
        if ([[cellDataInfo._flightNo substringToIndex:2] isEqualToString:@"CA"]) {
            isCA = YES;
        }
    }
    return isCA;
}
@end

