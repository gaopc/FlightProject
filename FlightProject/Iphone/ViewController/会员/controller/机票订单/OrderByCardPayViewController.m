//
//  OrderByCardPayViewController.m
//  FlightProject
//
//  Created by admin on 12-11-2.
//
//

#import "OrderByCardPayViewController.h"
#import "HotelGuaranteeIntroductionCell.h"
#import "HotelGuaranteeSelectCardCell.h"
#import "HotelGuaranteeCardInfoFirstCell.h"
#import "HotelGuaranteeCardInfoSecondCell.h"
#import "HotelGuaranteeCardInfoThirdCell.h"
#import "InterfaceClass.h"
#import "SelectCreditCardViewController.h"
#import "EditCreditCardInfoViewController.h"
#import "HotelDetailViewController.h"
#import "GetCreditCardList.h"
#import "GetConfiguration.h"

@interface OrderByCardPayViewController ()

@end

@implementation OrderByCardPayViewController
@synthesize myTableView,viewNum,keyboardbar,textFieldArray,deleteCreditCard;
@synthesize creditCardInfo;
@synthesize lcdCurrency, cardPayMoney, orderId, telephone;
@synthesize _flightArriveCode,_flightArriveDateCode,returnLcd;
@synthesize isCAFlight;

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
    self.myTableView = nil;
    self.keyboardbar = nil;
    self.textFieldArray = nil;
    self.creditCardInfo = nil;

    self.lcdCurrency = nil;
    self.cardPayMoney = nil;
    self.orderId = nil;
    self.telephone = nil;
    
    self._flightArriveCode = nil;
    self._flightArriveDateCode = nil;
    self.returnLcd = nil;
    [super dealloc];
}
- (void)loadView{
	[super loadView];
    self.title = @"信用卡支付";
    self.deleteCreditCard = NO;
    NSUserDefaults  * userDefault = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[userDefault objectForKey:username_ThreeDemain]);
    if([userDefault objectForKey:username_ThreeDemain] != NULL && ([[UserInfo sharedUserInfo].userID isEqualToString:[userDefault objectForKey:userID_ThreeDemain]]))
    {
        self.viewNum = 4;
        UpdateCreditCard *aUpdateCreditCard = [[UpdateCreditCard alloc] init];
        self.creditCardInfo = aUpdateCreditCard;
        [aUpdateCreditCard release];
        self.creditCardInfo._username = [userDefault objectForKey:username_ThreeDemain];
        self.creditCardInfo._bank = [userDefault objectForKey:bank_ThreeDemain];
        self.creditCardInfo._bankId = [userDefault objectForKey:bankId_ThreeDemain];
        self.creditCardInfo._bankIdCard = [userDefault objectForKey:bankIdCard_ThreeDemain];
        self.creditCardInfo._id = [userDefault objectForKey:id_ThreeDemain];
        self.creditCardInfo._idCard = [userDefault objectForKey:idCard_ThreeDemain];
    }
    else
    {
        self.viewNum = 1;
    }
    self.textFieldArray = [NSMutableArray array];
    
    
    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,ViewHeight-44.0f) style:UITableViewStylePlain];
    self.myTableView = aTableView;
    [aTableView release];
	self.myTableView.backgroundColor = [UIColor clearColor];
	self.myTableView.dataSource = self;
	self.myTableView.delegate = self;
//    self.myTableView.allowsSelection = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:self.myTableView];
    
    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth - 136)/2, ViewHeight - 44 - 60, 136, 33) backImage:[UIImage imageNamed:@"支付.png"] target:self action:@selector(Next)]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.viewNum != 1 && self.viewNum != 4)
    {
        [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
    }
    if(self.viewNum != 4)
    {
        if(self.deleteCreditCard)
        {
            self.deleteCreditCard = NO;
            [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
    if(self.viewNum == 4)
    {
        self.viewNum = 4;
    }
    else
    {
        self.viewNum = 1;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	YearMonthView *aYearMonthView = nil;
    if(textField.tag == 2)
    {
        NSMutableArray * array = [NSMutableArray array];
        NSString * year = [[NSDate dateCode:[NSDate date]] substringToIndex:4];
        for (int i=0; i<20; i++) {
            [array addObject:[NSString stringWithFormat:@"%4d年",[year intValue]+i]];
        }
	if (textField.text.length>0) {
		 NSString *cardMonth = [[textField.text componentsSeparatedByString:@"/"] objectAtIndex:0];
		NSString *cardYear =  [NSString stringWithFormat:@"%@%@",[year substringToIndex:2],[[textField.text componentsSeparatedByString:@"/"] objectAtIndex:1]];
		aYearMonthView = [[YearMonthView alloc] initWithFrame:CGRectMake(0, ViewHeight, ViewWidth, 200) Title:@"有效期选择" array:array selectYear:[NSString stringWithFormat:@"%@年",cardYear] selectMonth:[NSString stringWithFormat:@"%@月",cardMonth]];
	}else {
		   aYearMonthView = [[YearMonthView alloc] initWithFrame:CGRectMake(0, ViewHeight, ViewWidth, 200) Title:@"有效期选择" array:array selectYear:[NSString stringWithFormat:@"%@年",year] selectMonth:[NSString stringWithFormat:@"%@月",[[NSDate dateCode:[NSDate date]] substringWithRange:NSMakeRange(5, 2)]]];
	}
	aYearMonthView.delegate=self;
        textField.inputView = aYearMonthView;
        [aYearMonthView release];
    }
    
    if(self.keyboardbar == nil )
    {
        KeyBoardTopBar *aKeyboardbar =  [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
        self.keyboardbar = aKeyboardbar;
        [aKeyboardbar release];
    }
    
    //KeyBoardTopBar的实例对象调用显示键盘方法
    
    [self.keyboardbar showBar:textField];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag == 1)
    {
        self.creditCardInfo._cVV2Code = textField.text;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 4;

    if(textField.tag == 1)
    {
        textFieldMaxLenth = 3;
    }
   	if(textFieldStrLength >= textFieldMaxLenth)
	{
		textField.text = [textFieldStr substringToIndex:textFieldMaxLenth];
		return NO;
	}
	else {
		return YES;
	}
}

-(void)Next
{
    NSLog(@"Next");
    
    if(self.creditCardInfo == nil)
    {
        [UIAlertView alertViewWithMessage:@"请添加信用卡" :@"提示"];
        return;
    }

    if(self.creditCardInfo._cVV2Code.length < 3)
    {
        [UIAlertView alertViewWithMessage:@"请输入完整的CVV2码" :@"提示"];
        return;
    }
    if(self.creditCardInfo._validityDate.length < 4)
    {
        [UIAlertView alertViewWithMessage:@"请选择信用卡有效期" :@"提示"];
        return;
    }
    
    self.creditCardInfo._validityDate = [self.creditCardInfo._validityDate stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([GetConfiguration shareGetConfiguration]._umeng) {
        [MobClick event:@"CardPay"];
    }
    ASIFormDataRequest * theRequest = [InterfaceClass creditCarardPay:[UserInfo sharedUserInfo].userID withOrderId:self.orderId withPayMoney:self.cardPayMoney withPayCoin:self.lcdCurrency withCard:self.creditCardInfo withPhone:self.telephone];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCreditCardPayPaseredResult:) Delegate:self needUserType:NoMember];
}

- (void)onCreditCardPayPaseredResult:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"statusCode"] intValue] == 0 || [[dic objectForKey:@"statusCode"] intValue] == 1 || [[dic objectForKey:@"statusCode"] intValue] == 3) {
        if(![[UserInfo sharedUserInfo].userID isEqualToString:@""])
        {
            NSUserDefaults  * userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:[UserInfo sharedUserInfo].userID forKey:userID_ThreeDemain];
            [userDefault setObject:self.creditCardInfo._username forKey:username_ThreeDemain];
            [userDefault setObject:self.creditCardInfo._bank forKey:bank_ThreeDemain];
            [userDefault setObject:self.creditCardInfo._bankId forKey:bankId_ThreeDemain];
            [userDefault setObject:self.creditCardInfo._bankIdCard forKey:bankIdCard_ThreeDemain];
            [userDefault setObject:self.creditCardInfo._id forKey:id_ThreeDemain];
            [userDefault setObject:self.creditCardInfo._idCard forKey:idCard_ThreeDemain];
            [userDefault setObject:self.creditCardInfo._validityDate forKey:validityDate_ThreeDemain];
        }
        [self paySuccessFul:dic];
    }
    else {
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
    }
}

-(void) paySuccessFul:(NSDictionary *)resultDic
{    
    
    // flightInfo._arrival; 城市汉字
    //
    
    NSString * _cityName = [DataClass selectFromAirportCityListWithCityCode:_flightArriveCode];
    NSLog(@"城市：%@", _cityName);
    NSString * _hotelCode = [DataClass selectFromHotelCityListWithCityName:_cityName];
    NSString * _carCode = [DataClass selectFromCarRentalListWithCityName:_cityName];
    
    SubmitOrderCarInfo * tempDataModel = nil;
    TicketQueryDataModel * tempHotelDataModel = nil;
    NSString * startDate = _flightArriveDateCode;
    NSLog(@"时间：%@", _flightArriveDateCode);
    
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
        tempDataModel._fromDate =  [NSString stringWithFormat:@"%@ 10:00",[NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:1 type:1]] ;
        tempDataModel._toDate =  [NSString stringWithFormat:@"%@ 10:00",[NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:2 type:1]] ;
    }
    
    PayForSuccessViewController *paySuccessVC = [[PayForSuccessViewController alloc] init];
    paySuccessVC._messageTitle = [resultDic objectForKey:@"message"];
    paySuccessVC._orderId = self.orderId;
    paySuccessVC._CAFlight = self.isCAFlight;
    
//    int radio = [self.lcdCurrency intValue] * 100 / [self.cardPayMoney intValue];
//    
//    paySuccessVC._message =[NSString stringWithFormat:@"登陆会员：\n1.相关信息会发送短信与您确认\n2.客票起飞后、会返还票面价%d%@的畅达币到您的会员账户\n非登录会员：\n相关信息会发送短信与您确认。",radio,@"%"];
    
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""] || [self.returnLcd intValue] == 0) {
        paySuccessVC._message =@"重要提示：\n相关信息会发送短信与您确认。";
    }
    else {
        paySuccessVC._message =[NSString stringWithFormat:@"重要提示：\n1.相关信息会发送短信与您确认\n2.客户起飞后会返还%@个畅达币到您的畅达币账户。",self.returnLcd] ;
    }
    
    paySuccessVC._carQuery = tempDataModel;
    paySuccessVC._hotelQuery = tempHotelDataModel;
    [tempDataModel release];
    [tempHotelDataModel release];
    paySuccessVC._whoPaySuccess = Ticket;
    [NavigationController pushViewController:paySuccessVC animated:YES];
    [paySuccessVC release];
    
}

-(void)keyBoardHideen
{
    for (id elem in self.textFieldArray) {
        UITextField *aField = (UITextField*)elem;
        [aField resignFirstResponder];
    }
}

-(void)addCreditCard:(UIButton*)sender
{
    NSLog(@"addCreditCard");
    EditCreditCardInfoViewController *editCreditCardInfoVC = [[EditCreditCardInfoViewController alloc] init];
    editCreditCardInfoVC.title = @"新增常用信用卡";
    editCreditCardInfoVC->orderByCardPayViewController = self;
    UpdateCreditCard *aUpdateCreditCard = [[UpdateCreditCard alloc] init];
    editCreditCardInfoVC.updateCreditCard = aUpdateCreditCard;
    [aUpdateCreditCard release];
    editCreditCardInfoVC.ifAddCreditCard = YES;
    [NavigationController pushViewController:editCreditCardInfoVC animated:YES];
    [editCreditCardInfoVC release];
}
-(void)selectCreditCard:(UIButton*)sender
{
    NSLog(@"selectCreditCard");
    
    [self keyBoardHideen];
    
    SelectCreditCardViewController *selectCreditCardVC = [[SelectCreditCardViewController alloc] init];
    selectCreditCardVC.title = @"选择常用信用卡";
    selectCreditCardVC.sourceType = YES;
    selectCreditCardVC->orderByCardPayViewController = self;
    //selectCreditCardVC.getCreditCardList = (GetCreditCardList*)[GetCreditCardList GetCreditCardList:dic];
    [NavigationController pushViewController:selectCreditCardVC animated:YES];
    [selectCreditCardVC release];
    
//    ASIFormDataRequest * theRequest = [InterfaceClass creditCardList:[UserInfo sharedUserInfo].userID];
//    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCreditCardListdPaseredResult:) Delegate:self needUserType:Member];
}

-(void)editCreditCardInfo:(UIButton*)sender
{
    NSLog(@"editCardInfo");
    EditCreditCardInfoViewController *editCreditCardInfoVC = [[EditCreditCardInfoViewController alloc] init];
    editCreditCardInfoVC.title = @"编辑常用信用卡";
    editCreditCardInfoVC.updateCreditCard = self.creditCardInfo;
    editCreditCardInfoVC->orderByCardPayViewController = self;
    editCreditCardInfoVC.ifAddCreditCard = NO;
    [NavigationController pushViewController:editCreditCardInfoVC animated:YES];
    [editCreditCardInfoVC release];
}

-(void)onCreditCardListdPaseredResult:(NSDictionary*)dic
{
//    SelectCreditCardViewController *selectCreditCardVC = [[SelectCreditCardViewController alloc] init];
//    selectCreditCardVC->orderByCardPayViewController = self;
//    selectCreditCardVC.getCreditCardList = (GetCreditCardList*)[GetCreditCardList GetCreditCardList:dic];
//    [NavigationController pushViewController:selectCreditCardVC animated:YES];
//    [selectCreditCardVC release];
}

-(void)sureButtonClick:(id)instance
{
    NSLog(@"%s",__FUNCTION__);
    self.creditCardInfo._validityDate = (NSString*)instance;
    [self.keyboardbar HiddenKeyBoard];
    if(self.viewNum == 1)
    {
        self.viewNum = 4;
    }
    [myTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:NO];
}

-(void)cancelButtonClick
{
    NSLog(@"%s",__FUNCTION__);
   [self.keyboardbar HiddenKeyBoard];
}

#pragma mark mark_tableviewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView
{
	return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 170;
            break;
        case 1:
            return 55;
            break;
        default:
            return 170;
            break;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            static NSString * firstIdentifier = @"firstIdentifier";
            OrderByCardPayCell *cell = [tableView dequeueReusableCellWithIdentifier:firstIdentifier];
            if (cell== nil) {
                cell = [[[OrderByCardPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstIdentifier] autorelease];
                cell._cardPrice.text = self.cardPayMoney;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
            break;
        case 1:
        {
            static NSString * secondIdentifier = @"secondIdentifier";
            HotelGuaranteeSelectCardCell *cell = [tableView dequeueReusableCellWithIdentifier:secondIdentifier];
            if (cell== nil) {
                cell = [[[HotelGuaranteeSelectCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell.selectCard setBackgroundImage:[UIImage imageNamed:@"选择信用卡.png"] forState:UIControlStateNormal];
            
            
            if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) { // zxt 20121029 添加非会员预订显示效果，不显示选择常用信用卡列表
                [cell.selectCard addTarget:self action:@selector(addCreditCard:) forControlEvents:UIControlEventTouchUpInside];
            }
            else {
                [cell.selectCard addTarget:self action:@selector(selectCreditCard:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            return cell;
        }
            break;
        default:
        {
            if(self.viewNum == 1)
            {
                static NSString * thirdIdentifier = @"thirdIdentifier1";
                HotelGuaranteeCardInfoFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier];
                if (cell== nil) {
                    cell = [[[HotelGuaranteeCardInfoFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdIdentifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                [cell.addCreditCard addTarget:self action:@selector(addCreditCard:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }
            else if(self.viewNum == 2)
            {
                static NSString * thirdIdentifier = @"thirdIdentifier2";
                HotelGuaranteeCardInfoSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier];
                if (cell== nil) {
                    cell = [[[HotelGuaranteeCardInfoSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdIdentifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                [cell.personName setText:self.creditCardInfo._username];
                [cell.bankName setText:self.creditCardInfo._bank];
                NSString *str1 = [self.creditCardInfo._bankIdCard substringWithRange:NSMakeRange(0, 4)];
                NSString *str2 = [self.creditCardInfo._bankIdCard substringWithRange:NSMakeRange(4, 4)];
                NSString *str3 = [self.creditCardInfo._bankIdCard substringWithRange:NSMakeRange(8, 4)];
                NSString *str4 = [self.creditCardInfo._bankIdCard substringFromIndex:12];
                [cell.cardNum setText:[NSString stringWithFormat:@"%@  %@  %@  %@",str1,str2,str3,str4]];
                [cell.cvvNum setText:self.creditCardInfo._cVV2Code];
                NSString *aValidityDate = [NSString stringWithFormat:@"%@/%@",[self.creditCardInfo._validityDate substringToIndex:2],[self.creditCardInfo._validityDate substringFromIndex:2]];
                [cell.validityDate setText:aValidityDate];
                [cell.editCardInfo addTarget:self action:@selector(editCreditCardInfo:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }
            else
            {
                static NSString * thirdIdentifier = @"thirdIdentifier3";
                HotelGuaranteeCardInfoThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier];
                if (cell== nil) {
                    cell = [[[HotelGuaranteeCardInfoThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdIdentifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                [cell.personName setText:self.creditCardInfo._username];
                [cell.bankName setText:self.creditCardInfo._bank];
                [cell.cardNum setText:[self.creditCardInfo._bankIdCard substringToIndex:4]];
                [cell.cardNumLast setText:[self.creditCardInfo._bankIdCard substringFromIndex:12]];
                
                cell.cvvNumTextField.delegate = self;
                cell.cvvNumTextField.tag = 1;
                if(self.creditCardInfo._cVV2Code.length != 0)
                {
                    cell.cvvNumTextField.text = self.creditCardInfo._cVV2Code;
                }
                else {
                    cell.cvvNumTextField.text = @"";
                }
                
                cell.validityDateTextField.delegate = self;
                cell.validityDateTextField.tag = 2;
                if(self.creditCardInfo._validityDate != NULL)
                {
                    cell.validityDateTextField.text = self.creditCardInfo._validityDate;
                }
                else {
                    cell.validityDateTextField.text = @"";
                }
                
                [self.textFieldArray removeAllObjects];
                [self.textFieldArray addObject:cell.cvvNumTextField];
                [self.textFieldArray addObject:cell.validityDateTextField];
                if(self.viewNum == 4)
                {
                    self.viewNum = 1;
                }
                return cell;
            }
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [keyboardbar HiddenKeyBoard];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
