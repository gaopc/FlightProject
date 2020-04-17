//
//  EditPassgersInfoViewController.m
//  FlightProject
//
//  Created by longcd on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EditPassgersInfoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MyRegex.h"
#import "PassengerInfoDataResponse.h"
#import "PassengersInfoViewController.h"
#import "NSDate+convenience.h"
@interface EditPassgersInfoViewController ()
- (void)addPassenger:(id)sender;
- (void)deletePassenger:(id)sender;
- (void)loadRadio:(int) atype withCertType:(int) acertType;//乘机人类型按钮
- (void)radioA:(id)sender;//乘机人类型
- (void)radioB:(id)sender;//证件类型
- (void)loadRequestData;

@end

@implementation EditPassgersInfoViewController

@synthesize passengerInfoData;
@synthesize passengerInfoItem,menberBirthday;
@synthesize index;
@synthesize keyboardbar,textFieldArray;
@synthesize delegate,currentYear,type,currentYearBack,certDay;

-(void)dealloc
{
	self.index = 0;
	self.menberBirthday = nil;
	self.passengerInfoData = nil;
        self.keyboardbar = nil;
        self.textFieldArray = nil;
        self.delegate = nil;
	self.currentYear = nil;
	self.currentYearBack = nil;
	self.certDay = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark View系统方法

- (void)loadView{
	
	[super loadView];
	
	editorBgView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,ViewHeight-100.0f)];
	editorBgView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:editorBgView];
	
	UIImageView *nameImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 40.0f-20, ViewWidth - 40, 36.5f)];
	[nameImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[editorBgView addSubview:nameImageView];
	
	UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"乘机人姓名:" frame:CGRectMake(25.0f, 47.0f-20, 80.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	titleLabel1.textColor = FontColor333333;
	[editorBgView addSubview:titleLabel1];
	
	//乘机人姓名
	nameTextField = [UISubTextField TextFieldWithFrame:CGRectMake(112.0f, 44.0f-20, ViewWidth - 140, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"中文或英文(TOM/BUSH)"];
	nameTextField.font = FontSize32;
	nameTextField.tag = 100;
	nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
	nameTextField.delegate = self;
	nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	[editorBgView addSubview:nameTextField];
	
	UIImageView *lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 90.0f-20, ViewWidth - 40, 1.0f)];
	[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
	[editorBgView addSubview:lineImageView];
	
	UISubLabel *titleLabel2 = [UISubLabel labelWithTitle:@"乘机人类型" frame:CGRectMake(20.0f, 100.0f-20, 80.0f, 20.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
	titleLabel2.textColor = FontColor454545;
	[editorBgView addSubview:titleLabel2];
	
	buttonA1 = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(18.0f, 135.0f-20, 25.0f, 25.0f) backImage:[UIImage imageNamed:@"Radio_B.png"] target:self action:@selector(radioA:)];
	[editorBgView addSubview:buttonA1];
	
	buttonALabel1 = [UISubLabel labelWithTitle:@"成人" frame:CGRectMake(48.0f, 135.0f-20, 38.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	buttonALabel1.textColor = FontColor454545;
	[editorBgView addSubview:buttonALabel1];
	
	buttonA2 = [UIButton buttonWithType:UIButtonTypeCustom tag:11 title:@"" frame:CGRectMake(100.0f, 135.0f-20, 25.0f, 25.0f) backImage:[UIImage imageNamed:@"Radio_A.png"] target:self action:@selector(radioA:)];
	[editorBgView addSubview:buttonA2];
	
	buttonALabel2 = [UISubLabel labelWithTitle:@"儿童" frame:CGRectMake(130.0f, 135.0f-20, 38.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	buttonALabel2.textColor = FontColor454545;
	[editorBgView addSubview:buttonALabel2];
	
	UISubLabel *buttonALabel3 = [UISubLabel labelWithTitle:@"儿童购票说明" frame:CGRectMake(183.0f, 138.0f-20, 120.0f, 22.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
	buttonALabel3.textColor = FontColor2B8DD0;
	[editorBgView addSubview:buttonALabel3];
	
	explainButton = [UIButton buttonWithType:UIButtonTypeCustom tag:20 title:@"" frame:CGRectMake(183.0f, 138.0f-20, 120.0f, 30.0f) backImage:nil target:self action:@selector(explain:)];
	[editorBgView addSubview:explainButton];
	
	lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 170.0f-20, ViewWidth - 40, 1.0f)];
	[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
	[editorBgView addSubview:lineImageView];
	
	
	certTypeView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,175.0f-20,ViewWidth-20.0f,70.0f)];
	certTypeView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:certTypeView];
	
	certTypeTitleLabel = [UISubLabel labelWithTitle:@"证件类型" frame:CGRectMake(20.0f, 0.0f, 80.0f, 20.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
	certTypeTitleLabel.textColor = FontColor454545;
	[certTypeView addSubview:certTypeTitleLabel];
	
	
	buttonB1 = [UIButton buttonWithType:UIButtonTypeCustom tag:20 title:@"" frame:CGRectMake(18.0f, 35.0f, 25.0f, 25.0f) backImage:[UIImage imageNamed:@"Radio_B.png"] target:self action:@selector(radioB:)];
	[certTypeView addSubview:buttonB1];
	
	
	buttonBLabel1 = [UISubLabel labelWithTitle:@"身份证" frame:CGRectMake(48.0f, 35.0f, 50.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	buttonBLabel1.textColor = FontColor454545;
	[certTypeView addSubview:buttonBLabel1];
	
	
	buttonB2 = [UIButton buttonWithType:UIButtonTypeCustom tag:21 title:@"" frame:CGRectMake(100.0f, 35.0f, 25.0f, 25.0f) backImage:[UIImage imageNamed:@"Radio_A.png"] target:self action:@selector(radioB:)];
	[certTypeView addSubview:buttonB2];
	
	
	buttonBLabel2 = [UISubLabel labelWithTitle:@"护照" frame:CGRectMake(130.0f, 35.0f, 38.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	buttonBLabel2.textColor = FontColor454545;
	[certTypeView addSubview:buttonBLabel2];
	
	
	buttonB3 = [UIButton buttonWithType:UIButtonTypeCustom tag:22 title:@"" frame:CGRectMake(183.0f, 35.0f, 25.0f, 25.0f) backImage:[UIImage imageNamed:@"Radio_A.png"] target:self action:@selector(radioB:)];
	[certTypeView addSubview:buttonB3];
	
	
	buttonBLabel3 = [UISubLabel labelWithTitle:@"其他" frame:CGRectMake(213.0f, 35.0f, 38.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	buttonBLabel3.textColor = FontColor454545;
	[certTypeView addSubview:buttonBLabel3];
	
	[certTypeView release];
	
	lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 69.0f, ViewWidth - 40, 1.0f)];
	[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
	[certTypeView addSubview:lineImageView];
	
	bdView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,170.0f+120-20,ViewWidth-20.0f,70.0f)];
	bdView.backgroundColor = [UIColor clearColor];
	bdView.hidden = YES;
	
	
	
	
	UIImageView *birthdayImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 28.0f, ViewWidth - 40, 36.5f)];
	birthdayImageView.backgroundColor = [UIColor clearColor];
	[birthdayImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[bdView addSubview:birthdayImageView];
	
	
	UISubLabel *titleLabel3 = [UISubLabel labelWithTitle:@"出生日期:" frame:CGRectMake(23.0f, 36.0f, 80.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	titleLabel3.textColor = FontColor333333;
	[bdView addSubview:titleLabel3];
	
	
	birthdayTextField = [UISubTextField TextFieldWithFrame:CGRectMake(102.0f, 36.0f, ViewWidth - 140, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请选择出生日期"];
	birthdayTextField.font = FontSize32;
	birthdayTextField.tag = 102;
        birthdayTextField.delegate = self;
	[bdView addSubview:birthdayTextField];
	
	UIImageView *iconView=[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 40, 42.0f, 8.0f, 13.0f)];
	iconView.image=[UIImage imageNamed:@"CellArrow.png"];
	[bdView addSubview:iconView];
	
	
	
	
	
	certNumView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,240.0f-25,ViewWidth-20.0f,115.0f)];
	certNumView.backgroundColor = [UIColor clearColor];
	[editorBgView addSubview:certNumView];
	
	UIImageView *certNumImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 27.0f, ViewWidth - 40, 36.5f)];
	[certNumImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[certNumView addSubview:certNumImageView];
	
	
	UISubLabel *titleLabel4 = [UISubLabel labelWithTitle:@"证件号码:" frame:CGRectMake(23.0f, 34.0f, 80.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	titleLabel4.textColor = FontColor333333;
	[certNumView addSubview:titleLabel4];
	
	
	certNumTextField = [UISubTextField TextFieldWithFrame:CGRectMake(102.0f, 31.0f, ViewWidth - 130, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入证件号码"];
	certNumTextField.font = FontSize32;
	certNumTextField.keyboardType = UIKeyboardTypeASCIICapable;
	certNumTextField.tag = 101;
	certNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	certNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	certNumTextField.delegate = self;
	[certNumView addSubview:certNumTextField];
	[certNumView release];
	
	[editorBgView addSubview:bdView];
	[bdView release];
	
	//[certNumView addSubview:[UISubLabel labelWithTitle:@"根据最新航空公司规定，儿童订票需要填写证件号码。" frame:CGRectMake(23.0f, 80.0f, 280.0f, 40.0f) font:FontSize28 color:FontColorFF8813 alignment:NSTextAlignmentLeft]];
	certNoteLabel = [UISubLabel labelWithTitle:@"根据最新航空公司规定，儿童订票需要填写证件号码。" frame:CGRectMake(23.0f, 80.0f, ViewWidth - 40, 40.0f) font:FontSize28 alignment:NSTextAlignmentLeft];
	certNoteLabel.textColor = FontColorFF8813;
	certNoteLabel.hidden = YES;
	[certNumView addSubview:certNoteLabel];
	
	UIImageView *bottomButtonImgView=[UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight-100.0f, ViewWidth, 50.0f)];
	bottomButtonImgView.image=[UIImage imageNamed:@"PassBottomButtonBg.png"];
	[self.view addSubview:bottomButtonImgView];
	
//	int currentYearValue = [self.currentYear year:[NSDate date]];
//	int startYear = currentYearValue - 12;
//	NSString *stringYear = [NSString stringWithFormat:@"%d%@",startYear,@"-01-01"];
	
    if (self.passengerInfoItem) {
		nameTextField.text = self.passengerInfoItem._name;
		if (self.passengerInfoItem._certNum !=(id)[NSNull null]) {
			certNumTextField.text =  [self.passengerInfoItem._certNum isEqualToString:@"<null>"] ? @"" :self.passengerInfoItem._certNum;
		}
		if (self.passengerInfoItem._birthday !=(id)[NSNull null]) {
//			if([self.passengerInfoItem._birthday compare:stringYear]>=0)
			birthdayTextField.text = self.passengerInfoItem._birthday;
			self.certDay = self.passengerInfoItem._birthday;
		}
		self.type = [self.passengerInfoItem._type intValue];
		certType = [self.passengerInfoItem._certType intValue];
		[self loadRadio:type withCertType:certType];
		
		UIImageView *doubleButtonImgView=[UIImageView ImageViewWithFrame:CGRectMake(2.0f,  ViewHeight-92.0f+3, ViewWidth - 6, 40.0f)];
		doubleButtonImgView.image=[UIImage imageNamed:@"appInfoBottom.png"];
		[self.view addSubview:doubleButtonImgView];
		
		
        int offx = (ViewWidth - 296)/2;
		deleteButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(offx, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"DeletePassengersButton.png"] target:self action:@selector(deletePassenger:)];
		[self.view addSubview:deleteButton];
		
		submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(offx + 150, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"EditPassengersButton.png"] target:self action:@selector(addPassenger:)];
		[self.view addSubview:submitButton];

		

		
	}else {
		submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake((ViewWidth - 146)/2, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"SubmitButton.png"] target:self action:@selector(addPassenger:)];
		[self.view addSubview:submitButton];
	}
	
	if(self.type == 1){
		
		if(certType == 0){
			certNoteLabel.hidden = NO;
			self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField, nil];
		}
		if(certType != 0){
			certNoteLabel.hidden = YES;
			self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField,birthdayTextField, nil];
		}
	}else
	{
		certNoteLabel.hidden = YES;
		self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField, nil];
	}
	
	//self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField, nil];
	
	
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	if (self.passengerInfoItem){
		self.title = @"编辑乘机人";
	}else {
		self.title = @"新增乘机人";
	}
	self.navigationItem.rightBarButtonItem = nil;
	
	
}


- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}



#pragma mark -
#pragma mark 数据加载方法

- (void)explain:(id)sender
{
	[UIAlertView alertViewWithMessage:@"儿童票要求在乘机日期时，年龄为2-12周岁的儿童。\n温馨提醒： 儿童票票价为全价票的一半价格，机场建设费免收，燃油税为成人价的一半。儿童乘机需要有成人陪伴，每1名成人最多携带2名儿童乘机。":@"儿童购票说明"];
}


- (void)addPassenger:(id)sender {
	
	
	
	NSArray *parts = [nameTextField.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
	NSArray *filteredArray = [parts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
	nameTextField.text = [filteredArray componentsJoinedByString:@""];
	
	NSArray *certParts = [certNumTextField.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
	NSArray *certFilteredArray = [certParts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
	certNumTextField.text = [certFilteredArray componentsJoinedByString:@""];
	
	if (0 == [nameTextField.text length]) {
		[UIAlertView alertViewWithMessage:@"请填写乘机人姓名!" :@"提示"];
		return;
		
	}else if (![MyRegex checkname:nameTextField.text]) {
		[UIAlertView alertViewWithMessage:@"请输入正确的乘机人姓名!" :@"提示"];
		return;
	}
    if ([nameTextField.text length] > 28) {
        [UIAlertView alertViewWithMessage:@"乘机人姓名长度不能超过28个!" :@"提示"];
        return;
    }
//    else if ([nameTextField.text isMatchedByRegex:ZHONGWEN_XINGMING]) {
//		if ([nameTextField.text length] > 11) {
//			[UIAlertView alertViewWithMessage:@"乘机人姓名长度不能超过11个汉字!" :@"提示"];
//			return;
//		}
//		
//	}else if (![nameTextField.text isMatchedByRegex:ZHONGWEN_XINGMING]) {
//		if ([nameTextField.text length] <= AirUserNameLenght) {
//			if ([nameTextField.text length] >= 12) {
//				if([[nameTextField.text substringWithRange:NSMakeRange(11, 1)] isMatchedByRegex:ZHONGWEN_XINGMING]){
//					[UIAlertView alertViewWithMessage:@"乘机人姓名长度不能超过11个汉字!" :@"提示"];
//					return;
//					
//				}
//			}
//		}
//	}
	
	if (0 == [certNumTextField.text length]) {
		[UIAlertView alertViewWithMessage:@"请填写证件号码!" :@"提示"];
		return;
	}else if (certType == 0) {
		if (![MyRegex checkIsCertificateNum:certNumTextField.text]) {
			
			[UIAlertView alertViewWithMessage:@"请输入正确的身份证号码!" :@"提示"];
			return;
		}
	}else {
		if (![certNumTextField.text isMatchedByRegex:PASSPORT_CARD]) {
			[UIAlertView alertViewWithMessage:@"请输入正确的证件号码!" :@"提示"];
			return;
		}
		
		
	}
	
	NSString * flightStartDate = [NSDate dateCode:self.currentYear];
	int flightStartDateYear = [flightStartDate intValue];
	NSString * flightStartDateTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-2,[flightStartDate substringFromIndex:4]];
	NSString * flightStartDateOneTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-12,[flightStartDate substringFromIndex:4]];
	if (certType == 0) {
		NSString *cert = [certNumTextField.text substringWithRange:NSMakeRange(6, 8)];
		if (cert.length==8) {
			self.certDay = [NSString stringWithFormat:@"%@-%@-%@",[cert substringWithRange:NSMakeRange(0, 4)],[cert substringWithRange:NSMakeRange(4, 2)],[cert substringWithRange:NSMakeRange(6, 2)]];
			
		}else{
			[UIAlertView alertViewWithMessage:@"请输入正确的身份证号码!" :@"提示"];
			return;
		}
	}
	if (passengersInfoVC.sourceType == OrderSourceType){
		
		if (certType == 0) {


			if ([self.certDay compare:flightStartDateTwo] > 0) { // 婴儿
				[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，如果需要购买婴儿票请拨打预订热线400-6858-999.",nameTextField.text] :@"提示"] ;
				return;
			}
			
			
			if (self.type==0) {
				if ([self.certDay compare:flightStartDateOneTwo] > 0) {
					[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@仅符合航空公司购买儿童票标准，请编辑为儿童类型!",nameTextField.text] :@"提示"] ;
					return;

				}else{
					birthdayTextField.text = @"";
				}

			}else if (self.type==1) {
				if ([self.certDay compare:flightStartDateOneTwo]<=0) // 成人
				{
					[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@仅符合航空公司购买成人票标准，请编辑为成人类型!",nameTextField.text] :@"提示"] ;
					return;

				}else{
					birthdayTextField.text = self.certDay;
				}

			}
		}
	}
	if (self.type==1) {
		if (certType != 0) {
			if (0==[birthdayTextField.text length]) {
				[UIAlertView alertViewWithMessage:@"请选择生日!" :@"提示"];
				return;
			}
		}
		else{
			birthdayTextField.text = self.certDay;
		}
	}
	if (self.type==0) {
		birthdayTextField.text = @"";
	}
	
	[self loadRequestData];
	
	
}


- (void)loadRequestData
{
	if (self.passengerInfoItem) {

		ASIFormDataRequest * theRequest = [InterfaceClass updatePassengers:[UserInfo sharedUserInfo].userID withId:self.passengerInfoItem._id withName:nameTextField.text withType:[NSString stringWithFormat:@"%d",self.type] withCertType:[NSString stringWithFormat:@"%d",certType] withCertNum:certNumTextField.text withBirthday:birthdayTextField.text withGender:@"M"];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onEditPaseredResult:) Delegate:self needUserType:Member];
		
	}else {
		if ([[UserInfo sharedUserInfo].userID isEqualToString:@""] && self.type == 1) {
			NSString * flightStartDate = [NSDate dateCode:self.currentYear];
			int flightStartDateYear = [flightStartDate intValue];
			NSString * flightStartDateTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-2,[flightStartDate substringFromIndex:4]];
			NSString * flightStartDateOneTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-12,[flightStartDate substringFromIndex:4]];
			if ([birthdayTextField.text compare:flightStartDateTwo]>0) { // 婴儿
				[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，如果需要购买婴儿票请拨打预订热线400-6858-999.",nameTextField.text] :@"提示"] ;
				return;
			}
			else if ([birthdayTextField.text compare:flightStartDateOneTwo]<=0) // 成人
			{
				[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，请编辑该乘机人类型为成人后再预订机票！",nameTextField.text] :@"提示"] ;
				return;
			}
			if (self.currentYearBack) {
				NSString * flightStartDate = [NSDate dateCode:self.currentYearBack];
				int flightStartDateYear = [flightStartDate intValue];
				NSString * flightStartDateTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-2,[flightStartDate substringFromIndex:4]];
				NSString * flightStartDateOneTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-12,[flightStartDate substringFromIndex:4]];
				if ([birthdayTextField.text compare:flightStartDateTwo]>0) { // 婴儿
					[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，如果需要购买婴儿票请拨打预订热线400-6858-999.",nameTextField.text] :@"提示"] ;
					return;
				}
				else if ([birthdayTextField.text compare:flightStartDateOneTwo]<=0) // 成人
				{
					[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，请编辑该乘机人类型为成人后再预订机票！",nameTextField.text] :@"提示"] ;
					return;
				}
			}
		}
		ASIFormDataRequest * theRequest = [InterfaceClass addPassengers:[UserInfo sharedUserInfo].userID withName:nameTextField.text withType:[NSString stringWithFormat:@"%d",self.type] withCertType:[NSString stringWithFormat:@"%d",certType] withCertNum:certNumTextField.text withBirthday:birthdayTextField.text withSex:@"M"];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onAddPaseredResult:) Delegate:self needUserType:NoMember];
		
	}
}

- (void)deletePassenger:(id)sender {
	
	UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认删除乘机人么?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
	alert.tag = 202;
	[alert show];
	[alert release];
	
	
}



//添加请求返回处理
- (void)onAddPaseredResult:(NSDictionary *)dic
{
	
	PassengerInfoItem *infoItem = [[PassengerInfoItem alloc]init];
	infoItem._id = [NSString stringWithFormat:@"%d",[PassengerInfoDataResponse addPassenger:dic]];
	infoItem._name = nameTextField.text;
	infoItem._certNum = certNumTextField.text;
	infoItem._type =  [NSString stringWithFormat:@"%d",self.type];
	infoItem._certType =  [NSString stringWithFormat:@"%d",certType];
	infoItem._birthday = birthdayTextField.text;
	//[passengersInfoVC.passengersInfoArray insertObject:infoItem atIndex:0];
	if (self.delegate && [self.delegate respondsToSelector:@selector(addPassengerOverWithItem:)]) {
		[self.delegate performSelector:@selector(addPassengerOverWithItem:) withObject:infoItem];
	}
	
	[infoItem release];
	
	[self.navigationController popViewControllerAnimated:YES];
	
	//[passengersInfoVC.p_tableView reloadData];
	
}

//修改请求返回处理
- (void)onEditPaseredResult:(NSDictionary *)dic
{
	PassengerInfoItem *infoItem = [[PassengerInfoItem alloc]init];
	infoItem._id = self.passengerInfoItem._id;
	infoItem._name = nameTextField.text;
	infoItem._certNum = certNumTextField.text;
	infoItem._type =  [NSString stringWithFormat:@"%d",self.type];
	infoItem._certType =  [NSString stringWithFormat:@"%d",certType];
	infoItem._birthday = birthdayTextField.text;
	//[passengersInfoVC.passengersInfoArray replaceObjectAtIndex:self.index withObject:infoItem];
	[infoItem release];
	//[passengersInfoVC.p_tableView reloadData];
	[self.navigationController popViewControllerAnimated:YES];
	
}

//删除请求返回处理
- (void)onDelPaseredResult:(NSDictionary *)dic
{
	if (passengersInfoVC.passengersInfoArray.count==1) {
		[passengersInfoVC.passengersInfoArray removeObject:self.passengerInfoItem];
		[passengersInfoVC.p_tableView reloadData];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark 自定义方法

-(void) confirm:(id)sender
{
	UIButton *btn =(UIButton *) sender;
	switch (btn.tag) {
		case 50:
			self.menberBirthday =[NSDate dateCode:datePickerView.date];
			birthdayTextField.text = self.menberBirthday;
			
			break;
		case 51:
			break;
		default:
			break;
	}
}


//加载证件类型按钮
- (void)loadRadio:(int) atype withCertType:(int) acertType
{
	switch(atype){
		case 0:
			[buttonA1 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			[buttonA2 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			
			//certTypeView.hidden = NO;
			//certNumView.hidden = NO;
			bdView.hidden = YES;
			
			
			buttonALabel1.textColor = FontColor2B8DD0;
			buttonALabel2.textColor =FontColor454545;
			
			break;
		case 1:
			[buttonA1 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			[buttonA2 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			
			//certTypeView.hidden = YES;
			//certNumView.hidden = YES;
			if(certType != 0)
				bdView.hidden = NO;
			
			buttonALabel1.textColor =FontColor454545;
			buttonALabel2.textColor = FontColor2B8DD0;
			
			break;
		default:
			
			break;
			
	}
	switch(acertType){
		case 0:
			[buttonB1 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			[buttonB2 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			[buttonB3 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			
			buttonBLabel1.textColor = FontColor2B8DD0;
			buttonBLabel2.textColor =FontColor454545;
			buttonBLabel3.textColor =FontColor454545;
			break;
		case 1:
			[buttonB1 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			[buttonB2 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			[buttonB3 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			buttonBLabel1.textColor =FontColor454545;
			buttonBLabel2.textColor = FontColor2B8DD0;
			buttonBLabel3.textColor =FontColor454545;
			break;
        case 7:
        case 8:
		case 9:
			[buttonB1 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			[buttonB2 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			[buttonB3 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			buttonBLabel1.textColor =FontColor454545;
			buttonBLabel2.textColor =FontColor454545;
			buttonBLabel3.textColor = FontColor2B8DD0;
			break;
		default:
			
			break;
			
	}
	
}


//乘机人类型
- (void)radioA:(id)sender
{
	UIButton *buttonA =(UIButton *)sender;
	self.textFieldArray = nil;
	switch (buttonA.tag) {
		case 10:
			[buttonA1 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			[buttonA2 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			self.type = 0; //成人
			certTypeView.hidden = NO;
			certNumView.hidden = NO;
			bdView.hidden = YES;
			certNoteLabel.hidden = YES;
			buttonALabel1.textColor = FontColor2B8DD0;
	                buttonALabel2.textColor = FontColor454545;
			
			self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField, nil];
			
			if (self.keyboardbar != nil)
				[keyboardbar HiddenKeyBoard];
			
			break;
		case 11:
			[buttonA1 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			[buttonA2 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			self.type = 1; //儿童
			certTypeView.hidden = NO;
			certNumView.hidden = NO;
			if(certType != 0){
				bdView.hidden = NO;
				certNoteLabel.hidden = YES;
				self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField,birthdayTextField, nil];
				
			}else{
				certNoteLabel.hidden = NO;
				self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField, nil];
				
			}
			
		        buttonALabel1.textColor = FontColor454545;
			buttonALabel2.textColor = FontColor2B8DD0;

			if (self.keyboardbar != nil)
				[keyboardbar HiddenKeyBoard];
			
			break;
		default:
			
			break;
	}
}
//证件类型
- (void)radioB:(id)sender
{
	UIButton *buttonB =(UIButton *)sender;
	self.textFieldArray = nil;
	switch (buttonB.tag) {
		case 20:
			[buttonB1 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			[buttonB2 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			[buttonB3 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			certType = 0; //身份证
			if(self.type == 1){
				bdView.hidden = YES;
				certNoteLabel.hidden = NO;
			}
			self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField, nil];
			buttonBLabel1.textColor = FontColor2B8DD0;
			buttonBLabel2.textColor =FontColor454545;
			buttonBLabel3.textColor =FontColor454545;
			if (self.keyboardbar != nil)
				[keyboardbar HiddenKeyBoard];
			break;
		case 21:
			[buttonB1 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			[buttonB2 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			[buttonB3 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			certType = 1; //护照
			if(self.type == 1){
				bdView.hidden = NO;
				certNoteLabel.hidden = YES;
				self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField,birthdayTextField, nil];
			}else
			{
				self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField, nil];
			}
			buttonBLabel1.textColor = FontColor454545;
			buttonBLabel2.textColor = FontColor2B8DD0;
			buttonBLabel3.textColor =FontColor454545;
			if (self.keyboardbar != nil)
				[keyboardbar HiddenKeyBoard];
			break;
		case 22:
			[buttonB1 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			[buttonB2 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			[buttonB3 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			
			certType = 9; //其他
			if(self.type == 1){
				bdView.hidden = NO;
				certNoteLabel.hidden = YES;
				self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField,birthdayTextField, nil];
			}else{
				self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField, nil];
			}
			buttonBLabel1.textColor =FontColor454545;
			buttonBLabel2.textColor =FontColor454545;
			buttonBLabel3.textColor = FontColor2B8DD0;
			if (self.keyboardbar != nil)
				[keyboardbar HiddenKeyBoard];
			break;
		default:
			
			break;
	}
}

-(void)sureButtonClick:(id)instance
{
	[birthdayTextField resignFirstResponder];
	[nameTextField resignFirstResponder];
	[keyboardbar HiddenKeyBoard];
	NSString *string = (NSString *)instance;
	birthdayTextField.text = string;
	self.menberBirthday = string;
}

-(void)cancelButtonClick
{
	[birthdayTextField resignFirstResponder];
	[nameTextField resignFirstResponder];
	[keyboardbar HiddenKeyBoard];
	
}


#pragma -mark textField delegate


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (textField == birthdayTextField) {
		
		YearMonthDayView *birthdayBgView = nil;
		
		
		//self.currentYear = [[NSDate alloc] init];
		
		NSMutableArray * array = [NSMutableArray array];
		
		
		int currentYearValue = [self.currentYear year:[NSDate date]];
		int startYear = currentYearValue - 12;
		NSString *stringYear = [NSString stringWithFormat:@"%d%@",startYear,@"-01-01"];
		NSString * year = [[NSDate dateCode:[NSDate dateFromString:stringYear]] substringToIndex:4];
		
		int endYear = currentYearValue;
		int yearInterval = endYear - startYear;
		
		for (int i=0; i<yearInterval; i++) {
			[array addObject:[NSString stringWithFormat:@"%4d年",[year intValue]+i]];
		}
		
		if (textField.text.length>0) {
			
			NSString *birthdayYear = [[textField.text componentsSeparatedByString:@"-"] objectAtIndex:0];
			NSString *birthdayMonth = [[textField.text componentsSeparatedByString:@"-"] objectAtIndex:1];
			NSString *birthdayDay = [[textField.text componentsSeparatedByString:@"-"] objectAtIndex:2];
			
			if([textField.text compare:stringYear]<0)
				birthdayBgView = [[YearMonthDayView alloc] initWithFrame:CGRectMake(0, ViewHeight, ViewWidth, 200) Title:@"生日选择" array:array selectYear:[NSString stringWithFormat:@"%4d年",[year intValue]] selectMonth:@"01月" selectDay:@"01日"];
			else
				birthdayBgView = [[YearMonthDayView alloc] initWithFrame:CGRectMake(0, ViewHeight, ViewWidth, 200) Title:@"生日选择" array:array selectYear:[NSString stringWithFormat:@"%@年",birthdayYear] selectMonth:[NSString stringWithFormat:@"%@月",birthdayMonth] selectDay:[NSString stringWithFormat:@"%@日",birthdayDay]];
		
			
		
		}else {
			birthdayBgView = [[YearMonthDayView alloc] initWithFrame:CGRectMake(0, ViewHeight, ViewWidth, 200) Title:@"生日选择" array:array selectYear:[NSString stringWithFormat:@"%4d年",[year intValue]] selectMonth:@"01月" selectDay:@"01日"];
			
		}
		
		birthdayBgView.delegate=self;
		birthdayBgView.tag = 10;
		textField.inputView = birthdayBgView;
		
	}
	
	if (self.keyboardbar == nil) {
		
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}else {
		//		self.keyboardbar.textFields = self.textFieldArray;
		[self.keyboardbar setTextFields:self.textFieldArray];
	}
	[keyboardbar showBar:textField];  //显示工具条
	
	
	return TRUE;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
	
	switch (textField.tag) {
		case 100:
		{
			
			textFieldMaxLenth = AirUserNameLenght;
		}
			break;
		case 101:
		{
			if (certType == 0) {
				
				
				textFieldMaxLenth = 18;
				
			}else {
				
				textFieldMaxLenth = 30;
			}
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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if (textField.tag ==101) {
		if (certType == 0){
			if (textField.text.length>=18) {
				NSString * text = [textField.text substringFromIndex:17];
				textField.text = [textField.text stringByReplacingOccurrencesOfString :text withString:[text uppercaseString]];
			}
		}
	}
}


#pragma mark -
#pragma mark UIAlertView
- (void) alertView:(UIAlertView *)alertview clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if (buttonIndex==1) {
	
		ASIFormDataRequest * theRequest = [InterfaceClass deletePassengers:[UserInfo sharedUserInfo].userID withIds:self.passengerInfoItem._id];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelPaseredResult:) Delegate:self needUserType:Member];
	}
	
//	switch (alertview.tag) {
//		case 200:
//			if (buttonIndex==1) {
//				self.type = 1;
//				birthdayTextField.text = self.certDay;
//				[self loadRequestData];
//			}
//			break;
//		case 201:
//			if (buttonIndex==1) {
//				self.type = 0;
//				birthdayTextField.text = @"";
//				[self loadRequestData];
//			}
//			break;
//		case 202:
//			if (buttonIndex==1) {
//				ASIFormDataRequest * theRequest = [InterfaceClass deletePassengers:[UserInfo sharedUserInfo].userID withIds:self.passengerInfoItem._id];
//				[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelPaseredResult:) Delegate:self needUserType:Member];
//			}
//			break;
//			
//		default:
//			break;
//	}
	
	
	
}



@end
