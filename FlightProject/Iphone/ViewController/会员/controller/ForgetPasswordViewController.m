//
//  MemberForgetPasswordViewController.m
//  FlightProject
//
//  Created by 崔立东 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  会员密码找回
//

#import "ForgetPasswordViewController.h"
#import "JSON.h"
#import "MyRegex.h"
#import "InterfaceClass.h"
#import "MemberDataResponse.h"
#import "SendRequstCatchQueue.h"
#import "ASIFormDataRequest.h"
#import "KeyBoardTopBar.h"

@interface ForgetPasswordViewController ()
//启动定时器
- (void)startTimer;
//执行自定义逻辑
- (void)onTimer;
//废弃定时器
- (void)stopTimer;
@end

@implementation ForgetPasswordViewController
@synthesize textFieldArray;
@synthesize keyboardbar,telephoneText,times,showSecond;
-(void)dealloc
{
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    self.telephoneText = nil;
    self.showSecond = nil;
    [super dealloc];
}

- (void)loadView{
	
        [super loadView];
	
	
	long origin_y = 12.0f;
	
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, 7.0f)] ;
	[topView setImage:[UIImage imageNamed:@"MemberLoginTop.png"]];
	[self.view addSubview:topView];
	
	origin_y += topView.frame.size.height;
	
	
	
	forgetPasswordView = [[UIView alloc]initWithFrame:CGRectMake(10 ,origin_y,ViewWidth-20,235)];
	forgetPasswordView.backgroundColor = [UIColor clearColor];
	
	
	UIImageView *telephoneImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 18.0f, 275.5f, 36.5f)];
	[telephoneImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[forgetPasswordView addSubview:telephoneImageView];
	[forgetPasswordView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 32.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
	
	
	UISubLabel *userNameTitle = [UISubLabel labelWithTitle:@"手机号 :" frame:CGRectMake(28.0f, 21.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	userNameTitle.textColor = FontColor333333;
	[forgetPasswordView addSubview:userNameTitle];
	//手机号
	telephoneTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 25.0f, 200.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入11位有效手机号"];
	telephoneTextField.font = FontSize32;
	telephoneTextField.keyboardType = UIKeyboardTypeNumberPad;
	telephoneTextField.tag = 100;
	telephoneTextField.delegate = self;
	telephoneTextField.text = self.telephoneText;
	telephoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	telephoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	[forgetPasswordView addSubview:telephoneTextField];
	
	
	UIImageView *verificationImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 73.0f, 167.5f, 33.5f)];
	[verificationImageView setImage:[UIImage imageNamed:@"VerificationTextBox.png"]];
	[forgetPasswordView addSubview:verificationImageView];
	[forgetPasswordView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 86.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
	
	UISubLabel *verificationCodeTitle = [UISubLabel labelWithTitle:@"验证码 :" frame:CGRectMake(28.0f, 73.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	userNameTitle.textColor = FontColor333333;
	[forgetPasswordView addSubview:verificationCodeTitle];
	
	//短信验证码
	verificationCodeTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 77.0f, 93.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入验证码"];
	verificationCodeTextField.font = FontSize30;
	verificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
	verificationCodeTextField.tag = 101;
	verificationCodeTextField.delegate = self;
	verificationCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	verificationCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	[forgetPasswordView addSubview:verificationCodeTextField];
	
	
	verificationButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(185.0f, 73.0f, 104.0f, 34.0f) backImage:[UIImage imageNamed:@"VerificationButtonA.png"] target:self action:@selector(getCode:)];
	//[verificationButton setImage:[UIImage imageNamed:@"VerificationButtonB.png"] forState:UIControlStateHighlighted];
	[forgetPasswordView addSubview:verificationButton];
	
	self.showSecond = [UISubLabel labelWithTitle:@"" frame:CGRectMake(205.0f, 76.0f, 60.0f, 25.0f) font:FontBlodSize32 alignment:NSTextAlignmentCenter];
	self.showSecond.textColor = FontColorABABAB;
	self.showSecond.hidden = YES;
	[forgetPasswordView addSubview:self.showSecond];
	
	UIImageView *passwordImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 128.0f, 275.5f, 36.5f)];
	[passwordImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	
	[forgetPasswordView addSubview:passwordImageView];
	[forgetPasswordView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 140.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
	
	UISubLabel *passwordNameTitle = [UISubLabel labelWithTitle:@"密    码 :" frame:CGRectMake(28.0f, 130.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	passwordNameTitle.textColor = FontColor333333;
	[forgetPasswordView addSubview:passwordNameTitle];
	
	//密码
	passwordTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 133.0f, 200.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入6-20位字符"];
	passwordTextField.font = FontSize32;
	passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
        passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
	passwordTextField.secureTextEntry = YES;
	passwordTextField.tag = 102;
	passwordTextField.delegate = self;
	passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	[forgetPasswordView addSubview:passwordTextField];
	
	UISubLabel *showPassWordTitle = [UISubLabel labelWithTitle:@"显示密码" frame:CGRectMake(27.0f, 175.0f, 70.0f, 30.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	showPassWordTitle.textColor = FontColor333333;
//	[forgetPasswordView addSubview:showPassWordTitle];
    
    /*
     确认密码
     */
    UIImageView *newPasswordImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 183.0f, 275.5f, 36.5f)];
    [newPasswordImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
    [forgetPasswordView addSubview:newPasswordImageView];
    [forgetPasswordView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 195.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
    
    UISubLabel *newPasswordNameTitle = [UISubLabel labelWithTitle:@"确认密码:" frame:CGRectMake(28.0f, 185.0f, 60.0f, 30.0f) font:FontBlodSize26 alignment:NSTextAlignmentLeft];
    newPasswordNameTitle.textColor = FontColor333333;
    [forgetPasswordView addSubview:newPasswordNameTitle];
    
    //密码
    twicePasswordTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 188.0f, 200.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入6-20位字符"];
    twicePasswordTextField.backgroundColor =[UIColor clearColor];
    twicePasswordTextField.font = FontSize32;
    twicePasswordTextField.secureTextEntry = YES;
    twicePasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    twicePasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
    twicePasswordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
    twicePasswordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    twicePasswordTextField.tag = 103;
    twicePasswordTextField.delegate = self;
    [forgetPasswordView addSubview:twicePasswordTextField];

	
	customSwitch = [[CustomUISwitch alloc] initWithFrame:CGRectMake(100.0f, 178.0f, 60.0f, 22.0f)];
	customSwitch.delegate=self;
	[customSwitch setOn:NO animated:YES];
//	[forgetPasswordView addSubview:customSwitch];
	[customSwitch release];
	
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, forgetPasswordView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"MemberLoginCenter.png"]];
	[self.view addSubview:centerView];
	[self.view addSubview:forgetPasswordView];
	[forgetPasswordView release];
	
	origin_y += centerView.frame.size.height;
	
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, 7.0f)];
	[bottom setImage:[UIImage imageNamed:@"MemberLoginBottom.png"]];
	[self.view addSubview:bottom];
	
	self.textFieldArray = [NSArray arrayWithObjects: telephoneTextField,verificationCodeTextField,passwordTextField, twicePasswordTextField, nil];
	
	submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(50.0f, ViewHeight-200.0f, 225.5f, 45.0f) backImage:[UIImage imageNamed:@"MemberSubmitButton.png"] target:self action:@selector(editor:)];
	[submitButton setImage:[UIImage imageNamed:@"MemberSubmitButton.png"] forState:UIControlStateHighlighted];
	[self.view addSubview:submitButton];

}

- (void)valueChangedInView:(CustomUISwitch *)view
{
	if (customSwitch.on) {
		
		passwordTextField.secureTextEntry = NO;
	}else{ 
		passwordTextField.secureTextEntry = YES;
	}
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title=@"忘记密码";
	
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

- (void)getCode :(id)sender {
	
	if (0 == [telephoneTextField.text length]) {
		[UIAlertView alertViewWithMessage:@"请输入手机号!" :@"提示"];
		
	}else if (11 > [telephoneTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入11位手机号码!" :@"提示"];
		
	}else if (![telephoneTextField.text isMatchedByRegex:PHONENO]) {
		
		[UIAlertView alertViewWithMessage:@"请输入正确的手机号!" :@"提示"];
		
	}else {
		[keyboardbar HiddenKeyBoard];
//		[self startTimer];
		//[verificationButton setImage:[UIImage imageNamed:@"VerificationButtonB.png"] forState:UIControlStateHighlighted];
		ASIFormDataRequest * theRequest = [InterfaceClass getNewVerificationCode: telephoneTextField.text withType:@"1"];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onVerCodeResult:) Delegate:self needUserType:Default];
		
	}
}
//获取验证码请求返回处理
- (void)onVerCodeResult:(NSDictionary *)dic
{
	verificationCodeTextField.text =@"";
	if ([[[MemberDataResponse getVerificationCode:dic] objectAtIndex:0] intValue]==0){
		[self startTimer];
		[UIAlertView alertViewWithMessage:[[MemberDataResponse getVerificationCode:dic] objectAtIndex:1]];
	}
	
}

- (void)editor :(id)sender {
	
	if (0 == [telephoneTextField.text length]) {
		[UIAlertView alertViewWithMessage:@"请输入手机号!" :@"提示"];
		
	}else if (11 > [telephoneTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入11位手机号码!" :@"提示"];
		
	}else if (![telephoneTextField.text isMatchedByRegex:PHONENO]) {
		
		[UIAlertView alertViewWithMessage:@"请输入正确的手机号!" :@"提示"];
		
	}else if (0==[verificationCodeTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入验证码!" :@"提示"];
		
	}else if (![verificationCodeTextField.text isMatchedByRegex:VERIFICATION_CODE]) {
		
		[UIAlertView alertViewWithMessage:@"验证码请输入4位有效数字!" :@"提示"];
		
	}else if (0 == [passwordTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入密码!" :@"提示"];
		
	}else if (6 > [passwordTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入6-20位密码!" :@"提示"];
		
	}else if (![passwordTextField.text isMatchedByRegex:PASSWARD]) {
		
		[UIAlertView alertViewWithMessage:@"请输入正确的密码!" :@"提示"];
		
    }else if (![passwordTextField.text isEqualToString:twicePasswordTextField.text]) {
        
        [UIAlertView alertViewWithMessage:@"两次输入的密码不一致!" :@"提示"];
    }else {
		ASIFormDataRequest * theRequest = [InterfaceClass forgetPassword:telephoneTextField.text withPassword:passwordTextField.text withCheckCode:verificationCodeTextField.text];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onforgetPasswordPaseredResult:) Delegate:self needUserType:Default];
		
		
	}
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(![string isMatchedByRegex:PASSWARD] && string.length != 0)
    {
        return NO;
    }
    
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
	
	switch (textField.tag) {
		case 100:
		{

			textFieldMaxLenth = 11;
		}
			break;
		case 101:
		{

			textFieldMaxLenth = 4;
		}
			break;
		case 102:
		{

			textFieldMaxLenth = 20;
		}
			break;
        case 103:
        {
            
            textFieldMaxLenth = 20;
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


-(void)onforgetPasswordPaseredResult:(NSDictionary *)dic
{

	NSString *message = [MemberDataResponse forgetPassword:dic];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:telephoneTextField.text forKey:keyLoginTelephone];
	[defaults setObject:passwordTextField.text forKey:keyLoginPassword];
	[defaults synchronize];
	[UIAlertView alertViewWithMessage:message];
	
	[self.navigationController popViewControllerAnimated:YES];
	
}

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


//启动定时器
- (void)startTimer
{
	self.times= 31;
	//verificationButton.enabled = NO;
	_timer = [[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES] retain];
}
//执行自定义逻辑
- (void)onTimer
{
	self.times--;
	if (self.times == 30) {
		verificationButton.enabled = NO;
		self.showSecond.hidden = NO;
		[verificationButton setBackgroundImage:[UIImage imageNamed:@"VerificationButtonC.png"]  forState:UIControlStateNormal];
	}
	self.showSecond.text = [NSString stringWithFormat:@"（%d）",self.times];
	if (self.times ==0) {
		verificationButton.enabled = YES;
		self.showSecond.hidden = YES;
		[verificationButton setBackgroundImage:[UIImage imageNamed:@"VerificationButtonA.png"]  forState:UIControlStateNormal];
		[self stopTimer];
	}
}


//废弃定时器
- (void)stopTimer
{
	if(_timer != nil){
		[_timer invalidate];
		[_timer release];
		_timer = nil;
	}
}

@end
