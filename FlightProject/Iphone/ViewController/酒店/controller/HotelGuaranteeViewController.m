//
//  HotelGuaranteeViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelGuaranteeViewController.h"
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
@interface HotelGuaranteeViewController ()

@end

@implementation HotelGuaranteeViewController
@synthesize myTableView,viewNum,lastViewNum,keyboardbar,textFieldArray;
@synthesize creditCardInfo,onHotelQueryCreditCard,deleteCreditCard,myValidityDate;
@synthesize hotelInfo,hotelRoomType,checkInDate,checkOutDate,passInfoArray,roomCount,connectorMobile,retentionTime,checkCity,lcdRate,lcdValue,lcdActivityId;
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
    self.onHotelQueryCreditCard = nil;
    self.myValidityDate = nil;
    
    self.hotelInfo = nil;
    self.hotelRoomType = nil;
    self.checkInDate = nil;
    self.checkOutDate = nil;
    self.passInfoArray = nil;
    self.roomCount = nil;
    self.connectorMobile = nil;
    self.retentionTime = nil;
    self.checkCity = nil;
    self.lcdValue = nil;
    self.lcdRate = nil;
    self.lcdActivityId = nil;
    [super dealloc];
}
- (void)loadView{
	[super loadView];
    self.title = @"酒店担保";
     NSUserDefaults  * userDefault = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[userDefault objectForKey:username_ThreeDemain]);
    self.deleteCreditCard = NO;
    if([userDefault objectForKey:username_ThreeDemain] != NULL && ([[UserInfo sharedUserInfo].userID isEqualToString:[userDefault objectForKey:userID_ThreeDemain]]))
    {
        self.viewNum = 4;
        self.lastViewNum = self.viewNum;
        UpdateCreditCard *aUpdateCreditCard = [[UpdateCreditCard alloc] init];
        self.creditCardInfo = aUpdateCreditCard;
        [aUpdateCreditCard release];
        self.creditCardInfo._username = [NSString stringWithFormat:@"%@",[userDefault objectForKey:username_ThreeDemain]];
        self.creditCardInfo._bank = [NSString stringWithFormat:@"%@",[userDefault objectForKey:bank_ThreeDemain]];
        self.creditCardInfo._bankId = [NSString stringWithFormat:@"%@",[userDefault objectForKey:bankId_ThreeDemain]];
        self.creditCardInfo._bankIdCard = [NSString stringWithFormat:@"%@",[userDefault objectForKey:bankIdCard_ThreeDemain]];
//        self.myValidityDate = [NSString stringWithFormat:@"%@",[userDefault objectForKey:validityDate_ThreeDemain]];
        self.creditCardInfo._id = [NSString stringWithFormat:@"%@",[userDefault objectForKey:id_ThreeDemain]];
        self.creditCardInfo._idCard = [NSString stringWithFormat:@"%@",[userDefault objectForKey:idCard_ThreeDemain]];
    }
    else 
    {
        self.viewNum = 1;
        self.lastViewNum = viewNum;
    }
    self.textFieldArray = [NSMutableArray array];
    if (![self.hotelRoomType._descrition isEqual:@""])
    {
        suggestedSize = [self.hotelRoomType._descrition sizeWithFont:FontSize20 constrainedToSize:CGSizeMake(290, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    }

    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,ViewHeight-44.0f) style:UITableViewStylePlain];
    self.myTableView = aTableView;  
    [aTableView release];
	self.myTableView.backgroundColor = [UIColor clearColor];
	self.myTableView.dataSource = self;
	self.myTableView.delegate = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:self.myTableView];
    
    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(72.5, ViewHeight - 50 -44, 175, 38) backImage:[UIImage imageNamed:@"OrderInfoNextStep.png"] target:self action:@selector(Next)]];
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
        self.lastViewNum = viewNum;
        if(self.deleteCreditCard)
        {
            self.viewNum = 1;
            self.deleteCreditCard = NO;
            [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        }
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
	if (textField.text.length == 5) {
        
        
		NSString *cardMonth = [[textField.text componentsSeparatedByString:@"/"] objectAtIndex:0];
		NSString *cardYear =  [NSString stringWithFormat:@"%@%@",[year substringToIndex:2],[[textField.text componentsSeparatedByString:@"/"] objectAtIndex:1]];
		aYearMonthView = [[YearMonthView alloc] initWithFrame:CGRectMake(0, ViewHeight, ViewWidth, 200) Title:@"有效期选择" array:array selectYear:[NSString stringWithFormat:@"%@年",cardYear] selectMonth:[NSString stringWithFormat:@"%@月",cardMonth]];
		
	}
    else if (textField.text.length == 4) {
        
        
        NSString *cardMonth = [textField.text substringToIndex:2];
        NSString *cardYear =  [NSString stringWithFormat:@"%@%@",[year substringToIndex:2],[textField.text substringFromIndex:2]];
        aYearMonthView = [[YearMonthView alloc] initWithFrame:CGRectMake(0, ViewHeight, ViewWidth, 200) Title:@"有效期选择" array:array selectYear:[NSString stringWithFormat:@"%@年",cardYear] selectMonth:[NSString stringWithFormat:@"%@月",cardMonth]];
        
    }
    else {
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
     self.creditCardInfo._validityDate = [self.creditCardInfo._validityDate stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSLog(@"%@%@%d", self.creditCardInfo._validityDate, self.myValidityDate, self.lastViewNum);
//    if(![self.creditCardInfo._validityDate isEqualToString:self.myValidityDate] && (self.lastViewNum == 3 || self.lastViewNum == 4))
//    {
//        [UIAlertView alertViewWithMessage:@"请选择正确的有效期！" :@"提示"];
//        return;
//    }
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
//        [userDefault setObject:self.creditCardInfo._validityDate forKey:validityDate_ThreeDemain];
    }
    //        调到酒店订单页面
    HotelDetailViewController *hotelDetailVC = [[HotelDetailViewController alloc]init];
    hotelDetailVC.onHotelQueryCreditCard = self.onHotelQueryCreditCard;
    hotelDetailVC.hotelInfo = self.hotelInfo;
    hotelDetailVC.hotelRoomType = self.hotelRoomType;
    hotelDetailVC.checkInDate = self.checkInDate;
    hotelDetailVC.checkOutDate = self.checkOutDate;
    hotelDetailVC.passInfoArray = self.passInfoArray;
    hotelDetailVC.roomCount = self.roomCount;
    hotelDetailVC.connectorMobile = self.connectorMobile;
    hotelDetailVC.retentionTime = self.retentionTime;
    hotelDetailVC.creditCardInfo = self.creditCardInfo;
    hotelDetailVC.checkCity = self.checkCity;
    hotelDetailVC.lcdRate = self.lcdRate;
    hotelDetailVC.lcdValue = self.lcdValue;
    hotelDetailVC.lcdActivityId = self.lcdActivityId;
    [NavigationController pushViewController:hotelDetailVC animated:YES];
    [hotelDetailVC release];

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
    [self keyBoardHideen];
    EditCreditCardInfoViewController *editCreditCardInfoVC = [[EditCreditCardInfoViewController alloc] init];
    editCreditCardInfoVC.title = @"新增常用信用卡";
    editCreditCardInfoVC->hotelGuaranteeViewController = self;
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
    selectCreditCardVC->hotelGuaranteeViewController = self;
    [NavigationController pushViewController:selectCreditCardVC animated:YES];
    [selectCreditCardVC release];
}

-(void)editCreditCardInfo:(UIButton*)sender
{
    NSLog(@"editCardInfo");
    [self keyBoardHideen];
    EditCreditCardInfoViewController *editCreditCardInfoVC = [[EditCreditCardInfoViewController alloc] init];
    editCreditCardInfoVC.title = @"编辑常用信用卡";
    editCreditCardInfoVC.updateCreditCard = self.creditCardInfo;
    editCreditCardInfoVC->hotelGuaranteeViewController = self;
    editCreditCardInfoVC.ifAddCreditCard = NO;
    editCreditCardInfoVC.ifEditAll = YES;
    [NavigationController pushViewController:editCreditCardInfoVC animated:YES];
    [editCreditCardInfoVC release];
}

-(void)sureButtonClick:(id)instance
{
    NSLog(@"%s",__FUNCTION__);
    self.creditCardInfo._validityDate = (NSString*)instance;
    [keyboardbar HiddenKeyBoard];
    if(self.viewNum == 1)
    {
        self.lastViewNum = viewNum;
        self.viewNum = 4;
    }
    [myTableView reloadData];
}

-(void)cancelButtonClick
{
    NSLog(@"%s",__FUNCTION__);
    [keyboardbar HiddenKeyBoard];
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
            return suggestedSize.height+100;
            break;
        case 1:
            return 55;
            break;   
        default:
            return (400-suggestedSize.height-100-55);
            break;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            static NSString * firstIdentifier = @"firstIdentifier";
            HotelGuaranteeIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:firstIdentifier];
            if (cell== nil) {
                cell = [[[HotelGuaranteeIntroductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstIdentifier] autorelease];
            }
            ((int)([self.onHotelQueryCreditCard.money floatValue]*100)%100)?(cell.guaranteePrice.text = [NSString stringWithFormat:@"%d",((int)[self.onHotelQueryCreditCard.money floatValue])+1]):(cell.guaranteePrice.text = self.onHotelQueryCreditCard.money);

            CGRect rect = cell.descrip.frame;
            rect.size.height = suggestedSize.height+40;
            cell.descrip.frame = rect;
            cell.descrip.text = self.hotelRoomType._descrition;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:
        {
            static NSString * secondIdentifier = @"secondIdentifier";
            HotelGuaranteeSelectCardCell *cell = [tableView dequeueReusableCellWithIdentifier:secondIdentifier];
            if (cell== nil) {
                cell = [[[HotelGuaranteeSelectCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondIdentifier] autorelease];
            }
            [cell.selectCard setBackgroundImage:[UIImage imageNamed:@"选择信用卡.png"] forState:UIControlStateNormal];
            
            
            if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) { // zxt 20121029 添加非会员预订显示效果，不显示选择常用信用卡列表
//                [cell.selectCard setBackgroundImage:[UIImage imageNamed:@"添加信用卡.png"] forState:UIControlStateNormal];
//                [cell.selectCard addTarget:self action:@selector(addCreditCard:) forControlEvents:UIControlEventTouchUpInside];
                [cell.selectCard setBackgroundImage:nil forState:UIControlStateNormal];
            }
            else {
                [cell.selectCard addTarget:self action:@selector(selectCreditCard:) forControlEvents:UIControlEventTouchUpInside];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
                }
                [cell.addCreditCard addTarget:self action:@selector(addCreditCard:) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            else if(self.viewNum == 2)
            {
                static NSString * thirdIdentifier = @"thirdIdentifier2";
                HotelGuaranteeCardInfoSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier];
                if (cell== nil) {
                    cell = [[[HotelGuaranteeCardInfoSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdIdentifier] autorelease];
                }
                [cell.personName setText:self.creditCardInfo._username];
                [cell.bankName setText:self.creditCardInfo._bank];
                NSString *str1 = [self.creditCardInfo._bankIdCard substringWithRange:NSMakeRange(0, 4)];
                NSString *str2 = [self.creditCardInfo._bankIdCard substringWithRange:NSMakeRange(4, 4)];
                NSString *str3 = [self.creditCardInfo._bankIdCard substringWithRange:NSMakeRange(8, 4)];
                NSString *str4 = [self.creditCardInfo._bankIdCard substringFromIndex:12];
                [cell.cardNum setText:[NSString stringWithFormat:@"%@    %@    %@    %@",str1,str2,str3,str4]];
                [cell.cvvNum setText:self.creditCardInfo._cVV2Code];
                NSString *aValidityDate = [NSString stringWithFormat:@"%@/%@",[self.creditCardInfo._validityDate substringToIndex:2],[self.creditCardInfo._validityDate substringFromIndex:2]];
                [cell.validityDate setText:aValidityDate];
                [cell.editCardInfo addTarget:self action:@selector(editCreditCardInfo:) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            else 
            {
                static NSString * thirdIdentifier = @"thirdIdentifier3";
                HotelGuaranteeCardInfoThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier];
                if (cell== nil) {
                    cell = [[[HotelGuaranteeCardInfoThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdIdentifier] autorelease];
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
                    if (self.creditCardInfo._validityDate.length == 4) {
                        cell.validityDateTextField.text = [NSString stringWithFormat:@"%@/%@", [self.creditCardInfo._validityDate substringToIndex:2], [self.creditCardInfo._validityDate substringFromIndex:2]];
                    }
                    else {
                        cell.validityDateTextField.text = self.creditCardInfo._validityDate;
                    }
                }
                else {
                    cell.validityDateTextField.text = @"";
                }
                
                [self.textFieldArray removeAllObjects];
                [self.textFieldArray addObject:cell.cvvNumTextField];
                [self.textFieldArray addObject:cell.validityDateTextField];
                
                if(self.viewNum == 4)
                {
                    self.lastViewNum = self.viewNum;
                    self.viewNum = 1;
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.keyboardbar != nil)
    {
        [self.keyboardbar HiddenKeyBoard];
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
