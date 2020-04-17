//
//  EditCreditCardInfoViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EditCreditCardInfoViewController.h"
#import "UpdateCreditCard.h"
#import "HotelGuaranteeViewController.h"
#import "HotelQueryDataResponse.h"
#import "SelectBankViewController.h"
#import "MyRegex.h"
#import "InterfaceClass.h"
#import "GetBankList.h"


@implementation MyCell
@synthesize userName,credentialNum,cardNum,bankName,cvvNum,validityDate,selectBank,showCVV2;
@synthesize _pointView;

- (void)dealloc
{
    self.userName = nil;
    self.credentialNum = nil;
    self.cardNum = nil;
    self.bankName = nil;
    self.cvvNum = nil;
    self.validityDate = nil;
    self.selectBank = nil;
    self.showCVV2 = nil;
    self._pointView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 18, ViewWidth - 20, 7) image:[UIImage imageNamed:@"头带黑边.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 25, ViewWidth - 20, 335) image:[UIImage imageNamed:@"中间.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 360, ViewWidth - 20, 11) image:[UIImage imageNamed:@"尾.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 30, ViewWidth - 45, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"姓  名:" frame:CGRectMake(20, 30, 70, 30) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentRight]];
        self.userName = [UISubTextField TextFieldWithFrame:CGRectMake(95, 30, ViewWidth - 115, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入持卡人姓名" font:FontSize30];
        self.userName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.userName.textColor = FontColor3B3B3B;
        self.userName.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self.userName.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:self.userName];
        
        
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 80, ViewWidth - 45, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"证件号码:" frame:CGRectMake(20, 80, 70, 30) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentRight]];
        self.credentialNum = [UISubTextField TextFieldWithFrame:CGRectMake(95, 80, ViewWidth - 115, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入办理信用卡所用的证件号" font:FontSize26];
        self.credentialNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.credentialNum.textColor = FontColor3B3B3B;
        self.credentialNum.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self.credentialNum.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.credentialNum.keyboardType = UIKeyboardTypeASCIICapable;
        [self addSubview:self.credentialNum];
        
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 130, ViewWidth - 45, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"所属银行:" frame:CGRectMake(20, 130, 70, 30) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentRight]];
        self.bankName = [UISubTextField TextFieldWithFrame:CGRectMake(95, 130, ViewWidth - 115, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"选择银行" font:FontSize30];
        self.bankName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.bankName.textColor = FontColor3B3B3B;
        self.bankName.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self.bankName.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.bankName.keyboardType = UIKeyboardTypeNumberPad;
        self.bankName.enabled = NO;
        [self addSubview:self.bankName];
        self.selectBank = [UIButton customButtonTitle:nil image:nil frame:CGRectMake(20, 130, 277, 30) target:nil action:nil];
        
        self._pointView = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 40, 138, 8, 14) image:[UIImage imageNamed:@"航班动态列表下级.png"]];
//        [self.selectBank setImageEdgeInsets:UIEdgeInsetsMake(8,165 , 8, 0)];
        [self addSubview:self.bankName];
        [self addSubview:self.selectBank];
        [self addSubview:self._pointView];
        
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 180, ViewWidth - 45, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"信用卡号:" frame:CGRectMake(20, 180, 70, 30) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentRight]];
        self.cardNum = [UISubTextField TextFieldWithFrame:CGRectMake(95, 180, ViewWidth - 115, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入信用卡号" font:FontSize30];
        self.cardNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.cardNum.textColor = FontColor3B3B3B;
        self.cardNum.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self.cardNum.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.cardNum.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.cardNum];
        
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, ViewWidth - 90, 177, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"CVV2 码:" frame:CGRectMake(20, 230, 70, 30) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentRight]];
        self.cvvNum = [UISubTextField TextFieldWithFrame:CGRectMake(95, 230, 100, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"卡背面后3位" font:FontSize30];
        self.cvvNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.cvvNum.textColor = FontColor3B3B3B;
        self.cvvNum.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self.cvvNum.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.cvvNum.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.cvvNum];
        self.showCVV2 = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"CVV2说明截图.png"] frame:CGRectMake(ViewWidth - 115, 230, 90, 30) target:nil action:nil];
        [self addSubview:self.showCVV2];
        
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 280, ViewWidth - 45, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"有效期:" frame:CGRectMake(20, 280, 70, 30) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentRight]];
        self.validityDate = [UISubTextField TextFieldWithFrame:CGRectMake(95, 280, ViewWidth - 115, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请选择有效期时间" font:FontSize30];
        self.validityDate.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.validityDate.textColor = FontColor3B3B3B;
        self.validityDate.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self.validityDate.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:self.validityDate];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 40, 288, 8, 14) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end


@implementation CardCell
@synthesize userName,credentialNum,cardNum,bankName,selectBank;
@synthesize _pointView;

- (void)dealloc
{
    self._pointView = nil;
    self.userName = nil;
    self.credentialNum = nil;
    self.cardNum = nil;
    self.bankName = nil;
    self.selectBank = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 18, ViewWidth - 20, 7) image:[UIImage imageNamed:@"头带黑边.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 25, ViewWidth - 20, 235) image:[UIImage imageNamed:@"中间.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 260, ViewWidth - 20, 11) image:[UIImage imageNamed:@"尾.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 30, ViewWidth - 45, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"姓  名:" frame:CGRectMake(20, 30, 70, 30) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentRight]];
        self.userName = [UISubTextField TextFieldWithFrame:CGRectMake(95, 30, ViewWidth - 115, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入持卡人姓名" font:FontSize30];
        self.userName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.userName.textColor = FontColor3B3B3B;
        self.userName.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self.userName.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:self.userName];
        
        
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 80, ViewWidth - 45, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"证件号码:" frame:CGRectMake(20, 80, 70, 30) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentRight]];
        self.credentialNum = [UISubTextField TextFieldWithFrame:CGRectMake(95, 80, ViewWidth - 115, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入办理信用卡所用的证件号" font:FontSize26];
        self.credentialNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.credentialNum.textColor = FontColor3B3B3B;
        self.credentialNum.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self.credentialNum.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.credentialNum.keyboardType = UIKeyboardTypeASCIICapable;
        [self addSubview:self.credentialNum];
        
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 130, ViewWidth - 45, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"所属银行:" frame:CGRectMake(20, 130, 70, 30) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentRight]];
        self.bankName = [UISubTextField TextFieldWithFrame:CGRectMake(95, 130, ViewWidth - 115, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"选择银行" font:FontSize30];
        self.bankName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.bankName.textColor = FontColor3B3B3B;
        self.bankName.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self.bankName.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.bankName.keyboardType = UIKeyboardTypeNumberPad;
        self.bankName.enabled = NO;
        [self addSubview:self.bankName];
        self.selectBank = [UIButton customButtonTitle:nil image:nil frame:CGRectMake(20, 130, 277, 30) target:nil action:nil];
        
        self._pointView = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 40, 138, 8, 14) image:[UIImage imageNamed:@"航班动态列表下级.png"]];
        //        [self.selectBank setImageEdgeInsets:UIEdgeInsetsMake(8,165 , 8, 0)];
        [self addSubview:self.bankName];
        [self addSubview:self.selectBank];
        [self addSubview:self._pointView];
        
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 180, ViewWidth - 45, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"信用卡号:" frame:CGRectMake(20, 180, 70, 30) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentRight]];
        self.cardNum = [UISubTextField TextFieldWithFrame:CGRectMake(95, 180, ViewWidth - 115, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入信用卡号" font:FontSize30];
        self.cardNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.cardNum.textColor = FontColor3B3B3B;
        self.cardNum.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self.cardNum.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.cardNum.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.cardNum];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end



@interface EditCreditCardInfoViewController ()
@end

@implementation EditCreditCardInfoViewController
@synthesize myTableView,updateCreditCard,keyboardbar,textFieldArray,bankInfo,ifReloadData,ifAddCreditCard,cvv2View;
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
    self.updateCreditCard = nil;
    self.keyboardbar = nil;
    self.textFieldArray = nil;
    self.bankInfo = nil;
    self.cvv2View = nil;

	
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = nil;
    self.ifReloadData = NO;
    self.textFieldArray = [NSMutableArray array];
    self.updateCreditCard._userId = [UserInfo sharedUserInfo].userID;
	// Do any additional setup after loading the view.
    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,ViewHeight-44.0f-48) style:UITableViewStylePlain];
    self.myTableView = aTableView;  
    [aTableView release];
	self.myTableView.backgroundColor = [UIColor clearColor];
	self.myTableView.dataSource = self;
	self.myTableView.delegate = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:self.myTableView];
    
    if (self.ifAddCreditCard || self.ifEditAll) {
        [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth - 175)/2, ViewHeight-44-50+5, 175, 38) backImage:[UIImage imageNamed:@"MemberCompleteButton.png"] target:self action:@selector(submit)]];
    }
    else {
        UIButton *editBut = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(15, ViewHeight  - 44 - 50 + 5, 145, 37.5) backImage:[UIImage imageNamed:@"EditPassengersButton.png"] target:self action:@selector(submit)];
        UIButton *delBut = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth - 175)/2, ViewHeight-44-50+5, 175, 38) backImage:[UIImage imageNamed:@"删除卡信息.png"] target:self action:@selector(deleteCarInfo)];
        
//        [self.view addSubview:editBut];
        [self.view addSubview:delBut];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.ifReloadData)
    {
        self.updateCreditCard._bank = self.bankInfo._bankName;
        self.updateCreditCard._bankId = [NSString stringWithFormat:@"%@",self.bankInfo._hotelBankId];
        
        [myTableView reloadData];
    }
    self.ifReloadData = NO;
}

#pragma mark textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  
    YearMonthView *aYearMonthView = nil;
    if(textField.tag == 5)
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
	}else{
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
    switch (textField.tag) {
        case 1:
            self.updateCreditCard._username = textField.text;
            break;
        case 2:
            self.updateCreditCard._idCard = textField.text;
            break;
        case 3:
            self.updateCreditCard._bankIdCard = textField.text;
            break;
        case 4:
            self.updateCreditCard._cVV2Code = textField.text;
        break;
        default:
            break;
    }
	if (textField.tag ==2) {
		
		if (textField.text.length>=18) {
			NSString * text = [textField.text substringFromIndex:17];  
			textField.text = [textField.text stringByReplacingOccurrencesOfString :text withString:[text uppercaseString]];
			self.updateCreditCard._idCard = textField.text;
		}
		
	}

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
	switch (textField.tag) {
		case 1:
		{
			
			textFieldMaxLenth = 50;
		}
			break;
		case 2:
		{

			textFieldMaxLenth = 18;
		}
			break;
		case 3: 
		{

			textFieldMaxLenth = 16;
		}
			break;
		case 4:
		{

			textFieldMaxLenth = 3;
		}
			break;   
		default:
			
			break;
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



#pragma mark button-methods
-(void)submit
{
     NSArray *parts = [self.updateCreditCard._username componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];  
     NSArray *filteredArray = [parts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];  
     self.updateCreditCard._username = [filteredArray componentsJoinedByString:@""]; 
	
    if(self.updateCreditCard._username.length == 0)
    {
        [UIAlertView alertViewWithMessage:@"请输入持卡人姓名" :@"提示"];
        return;
    }
    if(![MyRegex checkname:self.updateCreditCard._username])
    {
        [UIAlertView alertViewWithMessage:@"请输入正确的姓名" :@"提示"];
        return;
    }
    if(self.updateCreditCard._idCard.length == 0)
    {
        [UIAlertView alertViewWithMessage:@"请输入证件号码" :@"提示"];
        return;
    }
    if (![MyRegex checkIsCertificateNum:self.updateCreditCard._idCard])
    {
        [UIAlertView alertViewWithMessage:@"请输入正确的证件号码" :@"提示"];
        return;
    }
    if(self.updateCreditCard._bank.length == 0)
    {
        [UIAlertView alertViewWithMessage:@"请选择所属银行" :@"提示"];
        return;
    }
    if(self.updateCreditCard._bankIdCard.length == 0)
    {
        [UIAlertView alertViewWithMessage:@"请输入信用卡卡号" :@"提示"];
        return;
    }
    if(self.updateCreditCard._bankIdCard.length < 15)
    {
        [UIAlertView alertViewWithMessage:@"请输入正确的信用卡卡号" :@"提示"];
        return;
    }
    if (![self.updateCreditCard._bankIdCard isMatchedByRegex:CREDIT_CARD]) {
	    
	    [UIAlertView alertViewWithMessage:@"请输入正确的信用卡卡号" :@"提示"];
	     return;
    }
	
    if (self.ifAddCreditCard || self.ifEditAll) {
        
        if(self.updateCreditCard._cVV2Code.length ==0)
        {
            [UIAlertView alertViewWithMessage:@"请输入CVV2码" :@"提示"];
            return;
        }
        if(self.updateCreditCard._cVV2Code.length <3)
        {
            [UIAlertView alertViewWithMessage:@"请输入3位CVV2码" :@"提示"];
            return;
        }
        
        if (![self.updateCreditCard._cVV2Code isMatchedByRegex:CREDIT_CARD]) {
            
            [UIAlertView alertViewWithMessage:@"请输入正确的CVV2码" :@"提示"];
            return;
        }
        
        if(self.updateCreditCard._validityDate.length == 0)
        {
            [UIAlertView alertViewWithMessage:@"请选择有效期" :@"提示"];
            return;
        }
        
        self.updateCreditCard._validityDate = [self.updateCreditCard._validityDate stringByReplacingOccurrencesOfString:@"/" withString:@""];
    }
    else {
        self.updateCreditCard._validityDate = @"";
    }
    
    if([[UserInfo sharedUserInfo].userID isEqualToString:@""])
    {
        hotelGuaranteeViewController.creditCardInfo = self.updateCreditCard;
        hotelGuaranteeViewController.viewNum = 2;
        orderByCardPayViewController.creditCardInfo = self.updateCreditCard;
        orderByCardPayViewController.viewNum = 2;
        [NavigationController popViewControllerAnimated:YES];
        return;
    }
    if(self.ifAddCreditCard)
    {
        ASIFormDataRequest * theRequest = [InterfaceClass addCreditCard:self.updateCreditCard];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onAddCreditCardPaseredResult:) Delegate:self needUserType:NoMember];
    }
    else
    {
        ASIFormDataRequest * theRequest = [InterfaceClass updateCreditCard:self.updateCreditCard];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onupdateCreditCardPaseredResult:) Delegate:self needUserType:NoMember];
    }

}
-(void)selectBank
{
    NSLog(@"selectBank");
    [self.keyboardbar HiddenKeyBoard];
    
    ASIFormDataRequest * theRequest = [InterfaceClass getBankList];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGetBankList:) Delegate:self needUserType:Default];
}

-(void)onGetBankList:(NSDictionary*)dic
{
    SelectBankViewController *selectBankVC = [[SelectBankViewController alloc] init];
    selectBankVC->editCreditCardInfoVC = self;
    if (orderByCardPayViewController != nil) {
        selectBankVC.payType = @"0";
    }
    else {
        selectBankVC.payType = @"1";
    }
    selectBankVC.bankList = [GetBankList GetBankList:dic];
    [NavigationController pushViewController:selectBankVC animated:YES];
    [selectBankVC release];
}

-(void)sureButtonClick:(id)instance
{
    NSLog(@"%s",__FUNCTION__);
    self.updateCreditCard._validityDate = (NSString*)instance;

    [self.keyboardbar HiddenKeyBoard];
    [myTableView reloadData];
}

-(void)cancelButtonClick
{
    NSLog(@"%s",__FUNCTION__);
    [self.keyboardbar HiddenKeyBoard];
}


-(void)showCVV2
{
    NSLog(@"showCVV2");
    if(self.cvv2View == nil)
    {
        UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(40,80,235,210)];
        aview.backgroundColor = [UIColor clearColor];
        self.cvv2View = aview;
        [aview release];
    }
    [self.cvv2View addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0,0,235,210) image:[UIImage imageNamed:@"弹出框背景图.png"]]];
    [self.cvv2View addSubview:[UIImageView ImageViewWithFrame:CGRectMake(7,5,215,150) image:[UIImage imageNamed:@"cvv2.png"]]];
    [self.cvv2View addSubview:[UIButton customButtonTitle:nil image:[UIImage imageNamed:@"TicketQueryConnectSure.png"] frame:CGRectMake(61,162,113,35) target:self action:@selector(setCVV2ViewHideen)]];
    [self.view addSubview:self.cvv2View];
}
-(void)setCVV2ViewHideen
{
    [self.cvv2View removeFromSuperview];
}
-(void)onAddCreditCardPaseredResult:(NSDictionary*)dic
{
    self.updateCreditCard._id = [dic objectForKey:@"id"];
    hotelGuaranteeViewController.creditCardInfo = self.updateCreditCard;
    hotelGuaranteeViewController.lastViewNum = hotelGuaranteeViewController.viewNum;
    self->hotelGuaranteeViewController.deleteCreditCard = NO;
    hotelGuaranteeViewController.viewNum = 2;
    
    orderByCardPayViewController.creditCardInfo = self.updateCreditCard;
    orderByCardPayViewController.viewNum = 2;
    
    
    if(hotelGuaranteeViewController == nil && orderByCardPayViewController == nil)
    {
        [NavigationController popViewControllerAnimated:YES];
    }
    else 
    {
        if (hotelGuaranteeViewController) {
            [NavigationController popToViewController:hotelGuaranteeViewController animated:YES];
        }
        else
        {
            [NavigationController popToViewController:orderByCardPayViewController animated:YES];
        }
    
    }
    
}

-(void)onupdateCreditCardPaseredResult:(NSDictionary*)dic
{
//    self.updateCreditCard._id = [dic objectForKey:@"id"];
    hotelGuaranteeViewController.creditCardInfo = self.updateCreditCard;
    hotelGuaranteeViewController.viewNum = 2;
    orderByCardPayViewController.creditCardInfo = self.updateCreditCard;
    orderByCardPayViewController.viewNum = 2;
    [NavigationController popViewControllerAnimated:YES];
}
#pragma mark mark_tableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 372;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    
    if (self.ifAddCreditCard || self.ifEditAll) {
        
        MyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell== nil) {
            cell = [[[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        [cell.selectBank addTarget:self action:@selector(selectBank) forControlEvents:UIControlEventTouchUpInside];
        [cell.showCVV2 addTarget:self action:@selector(showCVV2) forControlEvents:UIControlEventTouchUpInside];
        
        cell.userName.delegate = self;
        cell.credentialNum.delegate = self;
        cell.cardNum.delegate = self;
        cell.cvvNum.delegate = self;
        cell.validityDate.delegate = self;
        
        cell.userName.tag = 1;
        cell.credentialNum.tag = 2;
        cell.cardNum.tag = 3;
        cell.cvvNum.tag = 4;
        cell.validityDate.tag = 5;
        
        [self.textFieldArray removeAllObjects];
        if (self.ifAddCreditCard || self.ifEditAll) {
            [self.textFieldArray addObject:cell.userName];
            [self.textFieldArray addObject:cell.credentialNum];
            [self.textFieldArray addObject:cell.cardNum];
            [self.textFieldArray addObject:cell.cvvNum];
            [self.textFieldArray addObject:cell.validityDate];
        }
        else {
            [cell.userName setUserInteractionEnabled:NO];
            [cell.credentialNum setUserInteractionEnabled:NO];
            [cell.cardNum setUserInteractionEnabled:NO];
            cell.selectBank.enabled = NO;
            cell._pointView.hidden = YES;
            [self.textFieldArray addObject:cell.cvvNum];
            [self.textFieldArray addObject:cell.validityDate];
        }
        
        cell.userName.text = self.updateCreditCard._username;
        cell.credentialNum.text = self.updateCreditCard._idCard;
        cell.bankName.text = self.updateCreditCard._bank;
        cell.cardNum.text = self.updateCreditCard._bankIdCard;
        cell.cvvNum.text = self.updateCreditCard._cVV2Code;
        if([self.updateCreditCard._validityDate rangeOfString:@"/"].length == 0 && self.updateCreditCard._validityDate != nil)
        {
            NSMutableString *str = [NSMutableString stringWithString:self.updateCreditCard._validityDate];
            [str insertString:@"/" atIndex:2];
            cell.validityDate.text =str;
        }
        else
        {
            cell.validityDate.text =self.updateCreditCard._validityDate;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        
        CardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell== nil) {
            cell = [[[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        [cell.selectBank addTarget:self action:@selector(selectBank) forControlEvents:UIControlEventTouchUpInside];
        
        cell.userName.delegate = self;
        cell.credentialNum.delegate = self;
        cell.cardNum.delegate = self;
        
        cell.userName.tag = 1;
        cell.credentialNum.tag = 2;
        cell.cardNum.tag = 3;
        
        [self.textFieldArray removeAllObjects];
        [cell.userName setUserInteractionEnabled:NO];
        [cell.credentialNum setUserInteractionEnabled:NO];
        [cell.cardNum setUserInteractionEnabled:NO];
        cell.selectBank.enabled = NO;
        cell._pointView.hidden = YES;
        
        cell.userName.text = self.updateCreditCard._username;
        cell.credentialNum.text = self.updateCreditCard._idCard;
        cell.bankName.text = self.updateCreditCard._bank;
        cell.cardNum.text = self.updateCreditCard._bankIdCard;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)deleteCarInfo
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"删除当前信用卡信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 0;
    [alertView show];
    [alertView release];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0) {
        
        if (buttonIndex == 1) {
//            if([self->hotelGuaranteeViewController.creditCardInfo._id isEqualToString:self.updateCreditCard._id] || [self->orderByCardPayViewController.creditCardInfo._id isEqualToString:self.updateCreditCard._id])
//            {
//                
//            }
            ASIFormDataRequest * theRequest = [InterfaceClass deleteCreditCard:[NSString stringWithFormat:@"%@", self.updateCreditCard._id]];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDeleteCreditCard:) Delegate:self needUserType:Member];
        }
    }
}

- (void)onDeleteCreditCard:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    if ([statusCode intValue] == 0) {
        
        self->hotelGuaranteeViewController.viewNum = 1;
        self->hotelGuaranteeViewController.creditCardInfo = nil;
        self->hotelGuaranteeViewController.deleteCreditCard = YES;
        
        self->orderByCardPayViewController.viewNum = 1;
        self->orderByCardPayViewController.creditCardInfo = nil;
        self->orderByCardPayViewController.deleteCreditCard = YES;
        
        NSUserDefaults  * userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:NULL forKey:username_ThreeDemain];
        [userDefault setObject:NULL forKey:bank_ThreeDemain];
        [userDefault setObject:NULL forKey:bankId_ThreeDemain];
        [userDefault setObject:NULL forKey:bankIdCard_ThreeDemain];
        [userDefault setObject:NULL forKey:id_ThreeDemain];
        [userDefault setObject:NULL forKey:idCard_ThreeDemain];
        [userDefault setObject:NULL forKey:validityDate_ThreeDemain];
        
        [NavigationController popViewControllerAnimated:YES];
    }
    else {
        [UIAlertView alertViewWithMessage:message];
    }
}
@end
