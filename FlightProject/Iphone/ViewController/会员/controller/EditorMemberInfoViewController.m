//
//  EditorMemberInfoViewController.m
//  FlightProject
//
//  Created by 崔立东 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  编辑会员信息
//

#import "EditorMemberInfoViewController.h"
#import "MemberDataResponse.h"
#import "MyRegex.h"

@interface EditorMemberInfoViewController ()
- (void)hideKeyboard:(id)sender;
- (void)loadRadio:(int) atype;
- (void)loadEditorView;

@end

@implementation EditorMemberInfoViewController
@synthesize datePickerView,menberBirthday;
@synthesize textFieldArray;
@synthesize keyboardbar;
- (void)dealloc
{
	self.datePickerView = nil;
	self.menberBirthday = nil;
	self.textFieldArray = nil;
	self.keyboardbar = nil;
	[super dealloc];
}


- (void)loadView{
	
	[super loadView];
	
	long origin_y = 12.0f;
	
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, 28.0f)] ;
	[topView setImage:[UIImage imageNamed:@"MemberLoginTop.png"]];
	[self.view addSubview:topView];
	
	
 	editorrMemberInfoView = [[UIScrollView alloc]initWithFrame:CGRectMake(10.0f ,origin_y,ViewWidth-20.0f, ViewHeight - 44 - 50 - origin_y-30)];
	editorrMemberInfoView.backgroundColor = [UIColor clearColor];
	editorrMemberInfoView.showsVerticalScrollIndicator = YES;
	editorrMemberInfoView.showsHorizontalScrollIndicator = NO;
	editorrMemberInfoView.delegate=self;
	editorrMemberInfoView.contentOffset = CGPointMake(ViewWidth-20.0f, 0);
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:editorrMemberInfoView.frame backImage:nil target:self action:@selector(chick:)];
	[editorrMemberInfoView addSubview: button];
	
	//[self.view addSubview:editorrMemberInfoView];
	
	//	_m_tableView = [[[UITableView alloc] initWithFrame:CGRectMake(10.0f ,origin_y,ViewWidth-20.0f,345.0f) style:UITableViewStylePlain]autorelease];  
	//	self.m_tableView.backgroundColor = [UIColor clearColor];
	//	self.m_tableView.dataSource = self;
	//	self.m_tableView.delegate = self;
	//	self.m_tableView.showsVerticalScrollIndicator=NO;
	//	self.m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	UISubLabel *userNameTitle = [UISubLabel labelWithTitle:@"手机号 :" frame:CGRectMake(26.0f, 5.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	userNameTitle.textColor = FontColor333333;
	[editorrMemberInfoView addSubview:userNameTitle];
	
	telephoneLabel = [UISubLabel labelWithTitle:[UserInfo sharedUserInfo].telePhone frame:CGRectMake(85.0f, 5.0f, 225.0f, 30.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	telephoneLabel.textColor = FontColor333333;
	[editorrMemberInfoView addSubview:telephoneLabel];
	
	
	
	UIImageView *nameImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 45.0f, ViewWidth - 20 - 12*2, 36.5f)];
	[nameImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[editorrMemberInfoView addSubview:nameImageView];
	
	UISubLabel *nameTitle = [UISubLabel labelWithTitle:@"姓名 :" frame:CGRectMake(28.0f, 46.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	nameTitle.textColor = FontColor333333;
	[editorrMemberInfoView addSubview:nameTitle];
	
	//姓名
	nameTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 50.0f, ViewWidth - 120, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入真实姓名"];
	nameTextField.font = FontSize30;
	nameTextField.tag = 100;
	nameTextField.delegate = self;
	nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
	[editorrMemberInfoView addSubview:nameTextField];
	
	UISubLabel *sexTitle = [UISubLabel labelWithTitle:@"性别 :" frame:CGRectMake(28.0f, 80.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	sexTitle.textColor = FontColor333333;
	[editorrMemberInfoView addSubview:sexTitle];
	
	buttonA1 = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(85.0f, 85.0f, 25.0f, 25.0f) backImage:[UIImage imageNamed:@"Radio_B.png"] target:self action:@selector(radioA:)];
	[editorrMemberInfoView addSubview:buttonA1];
	
	buttonALabel1 = [UISubLabel labelWithTitle:@"男" frame:CGRectMake(115.0f, 85.0f, 38.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	buttonALabel1.textColor = FontColor454545;
	[editorrMemberInfoView addSubview:buttonALabel1];
	
	buttonA2 = [UIButton buttonWithType:UIButtonTypeCustom tag:11 title:@"" frame:CGRectMake(170.0f, 85.0f, 25.0f, 25.0f) backImage:[UIImage imageNamed:@"Radio_A.png"] target:self action:@selector(radioA:)];
	[editorrMemberInfoView addSubview:buttonA2];
	
	buttonALabel2 = [UISubLabel labelWithTitle:@"女" frame:CGRectMake(200.0f, 85.0f, 38.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	buttonALabel2.textColor = FontColor454545;
	[editorrMemberInfoView addSubview:buttonALabel2];
	
	//身份证件
	UIImageView *certNumImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 170.0f, ViewWidth - 20 - 12*2, 36.5f)];
	[certNumImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[editorrMemberInfoView addSubview:certNumImageView];
	
	UISubLabel *certNumTitle = [UISubLabel labelWithTitle:@"身份证:" frame:CGRectMake(23.0f, 172.0f, 65.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	certNumTitle.textColor = FontColor333333;
	[editorrMemberInfoView addSubview:certNumTitle];
	
	
	certNumTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 175.0f, ViewWidth - 120, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入证件号码"];
	certNumTextField.font = FontSize30;
        certNumTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
	certNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	certNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	certNumTextField.tag = 102;
	certNumTextField.delegate = self;
        certNumTextField.keyboardType = UIKeyboardTypeASCIICapable;
	[editorrMemberInfoView addSubview:certNumTextField];
	
	UIImageView *lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 215.0f, ViewWidth - 20 - 12*2, 1.0f)];
	[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
	[editorrMemberInfoView addSubview:lineImageView];
	
	
	//邮箱
	UIImageView *emailImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 230.0f, ViewWidth - 20 - 12*2, 36.5f)];
	[emailImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[editorrMemberInfoView addSubview:emailImageView];
	
	UISubLabel *emailTitle = [UISubLabel labelWithTitle:@"邮箱 :" frame:CGRectMake(28.0f, 232.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	emailTitle.textColor = FontColor333333;
	[editorrMemberInfoView addSubview:emailTitle];
	
	
	emailTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 235.0f, ViewWidth - 120, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入常用邮箱"];
	emailTextField.font = FontSize30;
	emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
	emailTextField.tag = 103;
	emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	emailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	emailTextField.delegate = self;
	emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
	[editorrMemberInfoView addSubview:emailTextField];
	
	//地址
	UIImageView *addressImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 280.0f, ViewWidth - 20 - 12*2, 71.5f)];
	[addressImageView setImage:[UIImage imageNamed:@"MemberAddressTextBox.png"]];
	[editorrMemberInfoView addSubview:addressImageView];
	
	UISubLabel *addressTitle = [UISubLabel labelWithTitle:@"地址 :" frame:CGRectMake(28.0f, 282.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	addressTitle.textColor = FontColor333333;
	[editorrMemberInfoView addSubview:addressTitle];
	
	addressTextView = [[UISubTextView alloc] initWithFrame:CGRectMake(75.0f, 280.0f, ViewWidth - 110, 68.0f)];
	addressTextView.tag = 104;
	addressTextView.backgroundColor = [UIColor clearColor];
	addressTextView.delegate = self;
	addressTextView.font = [UIFont fontWithName:@"Helvetica" size:16.5f];
	addressTextView.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
	[editorrMemberInfoView addSubview:addressTextView];
	
	//邮编
	UIImageView *postCodeImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 365.0f, ViewWidth - 20 - 12*2, 36.5f)];
	[postCodeImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[editorrMemberInfoView addSubview:postCodeImageView];
	
	UISubLabel *postCodeTitle = [UISubLabel labelWithTitle:@"邮编 :" frame:CGRectMake(28.0f, 366.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	postCodeTitle.textColor = FontColor333333;
	[editorrMemberInfoView addSubview:postCodeTitle];
	
        postCodeTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 370.0f, ViewWidth - 120, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入6位邮政编码"];
	postCodeTextField.font = FontSize30;
	postCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
	postCodeTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
	postCodeTextField.tag = 105;
	postCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	postCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	postCodeTextField.delegate = self;
	[editorrMemberInfoView addSubview:postCodeTextField];
	
	
	[self loadRadio:type];
	
	CGSize newSize = CGSizeMake(editorrMemberInfoView.frame.size.width,410.0f);
	[editorrMemberInfoView setContentSize:newSize];
	
	
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, ViewHeight - 44 - 50 - origin_y-30)];
	[centerView setImage:[UIImage imageNamed:@"MemberLoginCenter.png"]];
	[self.view addSubview:centerView];
	[self.view addSubview:editorrMemberInfoView];
	[editorrMemberInfoView release];
	origin_y += centerView.frame.size.height;
    	
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, 18)];
	[bottom setImage:[UIImage imageNamed:@"MemberLoginBottom.png"]];
	[self.view addSubview:bottom];
	
	submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(72.5f, ViewHeight-97.0f, 175.5f, 38.0f) backImage:[UIImage imageNamed:@"MemberCompleteButton.png"] target:self action:@selector(editor:)];
	[self.view addSubview:submitButton];
	
	//生日
	
	[editorrMemberInfoView addSubview: [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 120.0f, ViewWidth - 20 - 12*2, 33.5f) image:[UIImage imageNamed:@"MemberBirthdayTextBox.png"]]];
	[editorrMemberInfoView addSubview:[UISubLabel labelWithTitle:@"生日 :"  frame:CGRectMake(28.0f, 120.0f, 60.0f, 30.0f) font:FontBlodSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
	birthdayTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 127.0f, ViewWidth - 120, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"1900-01-01"];
	birthdayTextField.backgroundColor =[UIColor clearColor];
	birthdayTextField.font = FontSize30;
	birthdayTextField.keyboardType = UIKeyboardTypeDefault;
	birthdayTextField.returnKeyType = UIReturnKeyNext;
	birthdayTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
	birthdayTextField.tag = 101;
	birthdayTextField.inputView = (UIView *)[self.view viewWithTag:10];
	birthdayTextField.delegate = self;
	[editorrMemberInfoView addSubview:birthdayTextField];
	
	self.textFieldArray = [NSArray arrayWithObjects :nameTextField,birthdayTextField,certNumTextField,emailTextField,addressTextView,postCodeTextField,nil];
	
        [self loadEditorView];
	
	//[self.m_tableView reloadData];
	
}


-(void)sureButtonClick:(id)instance
{
	[birthdayTextField resignFirstResponder];
	[keyboardbar HiddenKeyBoard];
	NSString *string = (NSString *)instance;
	self.menberBirthday = string;
	birthdayTextField.text = string;
}

-(void)cancelButtonClick
{
	[birthdayTextField resignFirstResponder];
	[keyboardbar HiddenKeyBoard];
	[(UIView *)[self.view viewWithTag:10] removeFromSuperview];
	
}

- (void)loadEditorView
{
	//nameTextField.text =  [UserInfo sharedUserInfo].name;
	if ([MyRegex checkname:[UserInfo sharedUserInfo].name]) {
		nameTextField.text = [UserInfo sharedUserInfo].name;
        }
        else{
		nameTextField.text =nil;
        }
	emailTextField.text = [UserInfo sharedUserInfo].email;
	addressTextView.text = [UserInfo sharedUserInfo].postalAddress; 
	certNumTextField.text = [UserInfo sharedUserInfo].cardNo;
	postCodeTextField.text = [UserInfo sharedUserInfo].postCode; 
	birthdayTextField.text = [UserInfo sharedUserInfo].birthday;
	type = [[UserInfo sharedUserInfo].sex intValue];
	[self loadRadio:[[UserInfo sharedUserInfo].sex intValue]];
	
	
}

- (void)editor :(id)sender {
    
     NSLog(@"%d__%@", nameTextField.text.length, nameTextField.text);
	
	BOOL verResult=TRUE;
	NSArray *parts = [nameTextField.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];  
	NSArray *filteredArray = [parts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];  
	nameTextField.text = [filteredArray componentsJoinedByString:@""]; 
	
	if (0 != [nameTextField.text length]) {
		if (![MyRegex checkname:nameTextField.text]) {
			[UIAlertView alertViewWithMessage:@"请输入正确的姓名!" :@"提示"];
			verResult = FALSE;
		}
		
	}
	if (0 != [certNumTextField.text length]) {
		
		if (![MyRegex checkIsCertificateNum:certNumTextField.text]) {
			
			[UIAlertView alertViewWithMessage:@"请输入有效的身份证号!" :@"提示"];
			verResult = FALSE;
		}
		
	}
	if (0 != [emailTextField.text length]) { 
		
		if (![emailTextField.text isMatchedByRegex:EMAIL] ) { 
			
			[UIAlertView alertViewWithMessage:@"请输入正确的邮箱!" :@"提示"];
			verResult = FALSE;
			
		}
		
	}
	if (0 != [postCodeTextField.text length]) {
		
		if (![postCodeTextField.text isMatchedByRegex:ZIP_CODE]) {
			
			[UIAlertView alertViewWithMessage:@"请输入有效的邮政编码!" :@"提示"];
			verResult = FALSE;
			
		}
		
	}
	if (verResult) {
		ASIFormDataRequest * theRequest = [InterfaceClass editPersonalInformation:[UserInfo sharedUserInfo].userID withName:nameTextField.text withEmail:emailTextField.text withSex:[NSString stringWithFormat:@"%d",type] withBirthday:birthdayTextField.text withPostalAddress:addressTextView.text withPostCode:postCodeTextField.text withCardNo:certNumTextField.text];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(oneditPersonalInformationPaseredResult:) Delegate:self needUserType:Member];
		
	}
	
}



//编辑请求返回处理
- (void)oneditPersonalInformationPaseredResult:(NSDictionary *)dic
{
	
	[MemberDataResponse editPersonalInformation:dic];
	
	[UserInfo sharedUserInfo].name = nameTextField.text;
	[UserInfo sharedUserInfo].email = emailTextField.text;
	[UserInfo sharedUserInfo].cardNo = certNumTextField.text;
	[UserInfo sharedUserInfo].sex = [NSString stringWithFormat:@"%d",type];
	[UserInfo sharedUserInfo].birthday = birthdayTextField.text;
	[UserInfo sharedUserInfo].postalAddress = addressTextView.text;
	[UserInfo sharedUserInfo].postCode = postCodeTextField.text;
	
	
	[self.navigationController popViewControllerAnimated:YES];
	
}



- (void)radioA:(id)sender 
{
	UIButton *buttonA =(UIButton *)sender;
	switch (buttonA.tag) {
		case 10:
			[buttonA1 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			[buttonA2 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			type = 0; //男 
			buttonALabel1.textColor = FontColor2B8DD0;
			break;
		case 11:
			[buttonA1 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			[buttonA2 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			type = 1; //女
			buttonALabel2.textColor = FontColor2B8DD0;
			break;	
		default:
			
			break;
	}
}

- (void)loadRadio:(int) atype
{ 
	switch(atype){
		case 0:
			[buttonA1 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			[buttonA2 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			buttonALabel1.textColor = FontColor2B8DD0;
			break;
		case 1:
			[buttonA1 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
			[buttonA2 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
			buttonALabel2.textColor = FontColor2B8DD0;
			break;
		default:
			
			break;
			
	}
}


- (void)chick:(id)sender
{
	//[self hideKeyboard:nil];
}

///* 点击背景影藏键盘 */
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	
//	[self hideKeyboard:nil];
//}
//
- (void)hideKeyboard:(id)sender
{
	[nameTextField resignFirstResponder];
	[birthdayTextField resignFirstResponder];
	[certNumTextField resignFirstResponder];
	[emailTextField resignFirstResponder];
	[addressTextView resignFirstResponder];
	[postCodeTextField resignFirstResponder];
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField{ 
//	
//	UITextField *input = (UITextField *)textField;
//	if (input.tag == 101)
//	{
//		//[self hideKeyboard:nil];
//		if (!isShow) {
//			[UIView animateWithDuration:0.8f animations:^{
//				isShow = YES;
//				[birthdayBgView setAlpha:1.0f];
//			}];
//		}
//		
//	}else{
//		[self.keyboardbar showBar:textField];  //显示工具条 
//	}
//	
//}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
	
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	if (self.keyboardbar == nil) {
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}
	[keyboardbar showBar:textView];  //显示工具条 
	return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (textField == birthdayTextField) {
		YearMonthDayView *birthdayBgView = nil;
		NSDate *currentYear = [[NSDate alloc] init];
		NSMutableArray * array = [NSMutableArray array];
		
                NSString * year = [[NSDate dateCode:[NSDate dateFromString:@"1900-01-01"]] substringToIndex:4];
		int endYear = [currentYear year:[NSDate date]];
		int yearInterval = endYear - 1900;
		for (int i=0; i<yearInterval; i++) {
			[array addObject:[NSString stringWithFormat:@"%4d年",[year intValue]+i]];
		}
		
		if (textField.text.length>0) {
			NSString *birthdayYear = [[textField.text componentsSeparatedByString:@"-"] objectAtIndex:0];
			NSString *birthdayMonth = [[textField.text componentsSeparatedByString:@"-"] objectAtIndex:1];
			NSString *birthdayDay = [[textField.text componentsSeparatedByString:@"-"] objectAtIndex:2];
			birthdayBgView = [[YearMonthDayView alloc] initWithFrame:CGRectMake((ViewWidth - 320)/2, ViewHeight, 320, 190) Title:@"生日选择" array:array selectYear:[NSString stringWithFormat:@"%@年",birthdayYear] selectMonth:[NSString stringWithFormat:@"%@月",birthdayMonth] selectDay:[NSString stringWithFormat:@"%@日",birthdayDay]];
			

		}else{
			birthdayBgView = [[YearMonthDayView alloc] initWithFrame:CGRectMake(0, ViewHeight, ViewWidth, 190) Title:@"生日选择" array:array selectYear:@"1980年" selectMonth:@"01月" selectDay:@"01日"];
			
		}
				
		birthdayBgView.delegate=self;
		birthdayBgView.tag = 10;
		textField.inputView = birthdayBgView;
		[currentYear release];
		
	}
	
	if (self.keyboardbar == nil) {
		
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];        
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
			textFieldMaxLenth = UCenterUserNameLenght;
		}
			break;
			
		case 102:
		{

			textFieldMaxLenth = 18;

			
		}
			break;
			
		case 103:
		{
			textFieldMaxLenth = 50;		
		}
			break;
		case 105:
		{
			textFieldMaxLenth = 6;
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
	if (textField.tag ==102) {
		if (textField.text.length>=18) {
			NSString * text = [textField.text substringFromIndex:17];  
			textField.text = [textField.text stringByReplacingOccurrencesOfString :text withString:[text uppercaseString]];   
		}
	}
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text  
{  
	NSString * textFieldStr = [[textView.text stringByReplacingCharactersInRange:range withString:text] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 80;
	
	if (textFieldStrLength>=textFieldMaxLenth)   
	{  
		textView.text =  [textFieldStr substringToIndex:textFieldMaxLenth];
		
		return  NO;  
	}  
	else   
	{  
		return YES;  
	}  
}  


- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title=@"编辑个人信息";
	// Do any additional setup after loading the view.
	//type = 0; //成人
	//menberBirthday = @"";
	NSDate *today = [NSDate date];
	datePickerView.date = today;
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

@end
