//
//  MemberRegisterViewController.m
//  FlightProject
//
//  Created by 崔立东 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  会员注册
//

#import "MemberRegisterViewController.h"
#import "JSON.h"
#import "MyRegex.h"
#import "InterfaceClass.h"
#import "MemberDataResponse.h"
#import "SendRequstCatchQueue.h"
#import "ASIFormDataRequest.h"
#import "KeyBoardTopBar.h"
#import "MemberLoginViewController.h"
#import "NOMemberLoginViewController.h"
#import "NSDate+convenience.h"
@interface MemberRegisterViewController ()
//启动定时器
- (void)startTimer;
//执行自定义逻辑
- (void)onTimer;
//废弃定时器
- (void)stopTimer;
@end

@implementation MemberRegisterViewController
@synthesize textFieldArray;
@synthesize keyboardbar,delegate,times,showSecond;
-(void)dealloc
{
	self.textFieldArray = nil;
	self.keyboardbar = nil;
	self.delegate = nil;
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
	
	registerView = [[UIView alloc]initWithFrame:CGRectMake(10.0f ,origin_y,ViewWidth-20.0f,280.0f)];
	registerView.backgroundColor = [UIColor clearColor];
	
	UIImageView *telephoneImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 18.0f, 275.5f, 36.5f)];
	[telephoneImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[registerView addSubview:telephoneImageView];
	
	[registerView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 32.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
	
	UISubLabel *userNameTitle = [UISubLabel labelWithTitle:@"手机号 :" frame:CGRectMake(28.0f, 20.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	userNameTitle.textColor = FontColor333333;
	[registerView addSubview:userNameTitle];
	//手机号
	telephoneTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 23.0f, 200.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入11位有效手机号码"];
	telephoneTextField.font = FontSize32;
	telephoneTextField.keyboardType = UIKeyboardTypeNumberPad;
	telephoneTextField.tag = 100;
	telephoneTextField.delegate = self;
	telephoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	telephoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	[registerView addSubview:telephoneTextField];
	
	UIImageView *verificationImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 73.0f, 167.5f, 33.5f)];
	[verificationImageView setImage:[UIImage imageNamed:@"VerificationTextBox.png"]];
	[registerView addSubview:verificationImageView];
	
	[registerView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 86.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
	
	UISubLabel *verificationCodeTitle = [UISubLabel labelWithTitle:@"验证码 :" frame:CGRectMake(28.0f, 74.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	userNameTitle.textColor = FontColor333333;
	[registerView addSubview:verificationCodeTitle];
	
	//短信验证码
	verificationCodeTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 78.0f, 93.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入验证码"];
	verificationCodeTextField.font = FontSize30;
	verificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
	verificationCodeTextField.tag = 101;
	verificationCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	verificationCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	verificationCodeTextField.delegate = self;
	[registerView addSubview:verificationCodeTextField];
	
	
	verificationButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(185.0f, 73.0f, 104.0f, 34.0f) backImage:[UIImage imageNamed:@"VerificationButtonA.png"] target:self action:@selector(getCode:)];
	//[verificationButton setImage:[UIImage imageNamed:@"VerificationButtonB.png"] forState:UIControlStateHighlighted];
	[registerView addSubview:verificationButton];
	
	self.showSecond = [UISubLabel labelWithTitle:@"" frame:CGRectMake(205.0f, 76.0f, 60.0f, 25.0f) font:FontBlodSize32 alignment:NSTextAlignmentCenter];
	self.showSecond.textColor = FontColorABABAB;
	self.showSecond.hidden = YES;
	[registerView addSubview:self.showSecond];
	
	UIImageView *passwordImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 128.0f, 275.5f, 36.5f)];
	[passwordImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[registerView addSubview:passwordImageView];
	[registerView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 140.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
	
	UISubLabel *passwordNameTitle = [UISubLabel labelWithTitle:@"密    码 :" frame:CGRectMake(28.0f, 130.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	passwordNameTitle.textColor = FontColor333333;
	[registerView addSubview:passwordNameTitle];
	
	//密码
	passwordTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 133.0f, 200.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入6-20位字符"];
	passwordTextField.backgroundColor =[UIColor clearColor];
	passwordTextField.font = FontSize32;
	passwordTextField.secureTextEntry = YES;
	passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
	passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
        passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
	passwordTextField.tag = 102;
	passwordTextField.delegate = self;
	[registerView addSubview:passwordTextField];
    
    /*
     确认密码
     */
    UIImageView *newPasswordImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 183.0f, 275.5f, 36.5f)];
    [newPasswordImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
    [registerView addSubview:newPasswordImageView];
    [registerView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 195.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
    
    UISubLabel *newPasswordNameTitle = [UISubLabel labelWithTitle:@"确认密码:" frame:CGRectMake(28.0f, 185.0f, 60.0f, 30.0f) font:FontBlodSize26 alignment:NSTextAlignmentLeft];
    newPasswordNameTitle.textColor = FontColor333333;
    [registerView addSubview:newPasswordNameTitle];
    
    //密码
    twicePasswordTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 188.0f, 200.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入6-20位字符"];
    twicePasswordTextField.backgroundColor =[UIColor clearColor];
    twicePasswordTextField.font = FontSize32;
    twicePasswordTextField.secureTextEntry = YES;
    twicePasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    twicePasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
    twicePasswordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
    twicePasswordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    twicePasswordTextField.tag = 104;
    twicePasswordTextField.delegate = self;
    [registerView addSubview:twicePasswordTextField];

	
	UISubLabel *showPassWordTitle = [UISubLabel labelWithTitle:@"显示密码" frame:CGRectMake(27.0f, 176.0f, 70.0f, 30.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	showPassWordTitle.textColor = FontColor333333;
//	[registerView addSubview:showPassWordTitle];
	
	
	
	customSwitch = [[CustomUISwitch alloc] initWithFrame:CGRectMake(100.0f, 178.0f, 60.0f, 22.0f)] ;
	customSwitch.delegate=self;
	[customSwitch setOn:NO animated:YES];
//	[registerView addSubview:customSwitch];
        [customSwitch release];
	
	
        UIImageView *recommendImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 238.0f, 275.5f, 36.5f)];
        [recommendImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
        [registerView addSubview:recommendImageView];
	
	UISubLabel *recommendTitle = [UISubLabel labelWithTitle:@"推荐人 :" frame:CGRectMake(28.0f, 240.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	recommendTitle.textColor = FontColor333333;
	[registerView addSubview:recommendTitle];
	
        //推荐人
        recommendTelephoneTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 243.0f, 200.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入推荐人手机号码"];
        recommendTelephoneTextField.font = FontSize32;
	recommendTelephoneTextField.keyboardType = UIKeyboardTypeNumberPad;
	recommendTelephoneTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
	recommendTelephoneTextField.tag = 103;
	recommendTelephoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	recommendTelephoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	recommendTelephoneTextField.delegate = self;
	
	
	[registerView addSubview:recommendTelephoneTextField];
	
	
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, registerView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"MemberLoginCenter.png"]];
	[self.view addSubview:centerView];
	[self.view addSubview:registerView];
	[registerView release];
	
	origin_y += centerView.frame.size.height;
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, 7.0f)];
	[bottom setImage:[UIImage imageNamed:@"MemberLoginBottom.png"]];
	[self.view addSubview:bottom];
	
	submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(50.0f, ViewHeight-135.0f, 225.5f, 45.0f) backImage:[UIImage imageNamed:@"MemberRegisterSubmit.png"] target:self action:@selector(regist:)];
	[self.view addSubview:submitButton];
	self.textFieldArray = [NSArray arrayWithObjects: telephoneTextField,verificationCodeTextField,passwordTextField, twicePasswordTextField, recommendTelephoneTextField, nil];
	
	explanationLabel = [UISubLabel labelWithTitle:@"注册成为会员可享受预订返赠等多重优惠。" frame:CGRectMake(10.0f, ViewHeight-100.0f, 300.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	explanationLabel.textColor = FontColorFF6113;
	[registerView addSubview:explanationLabel];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title=@"用户注册";
//    [[NSUserDefaults standardUserDefaults] setObject:@"FALSE" forKey:keyAudioRegister];
    
    UIButton  * rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 7, 52, 30) backImage:[UIImage imageNamed:@"login.png"] target:self action:@selector(userLogin:)];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
	
	
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}


- (void)regist :(id)sender {
	
	BOOL verResult=TRUE;
	
	if (0 == [telephoneTextField.text length]) {
		[UIAlertView alertViewWithMessage:@"请输入手机号!" :@"提示"];
		verResult = FALSE;
		
	}else if (11 > [telephoneTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入11位手机号码!" :@"提示"];
		verResult = FALSE;
		
	}else if (![telephoneTextField.text isMatchedByRegex:PHONENO]) {
		
		[UIAlertView alertViewWithMessage:@"请输入正确的手机号!" :@"提示"];
		verResult = FALSE;
		
	}else if (0==[verificationCodeTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入验证码!" :@"提示"];
		verResult = FALSE;
		
	}else if (![verificationCodeTextField.text isMatchedByRegex:VERIFICATION_CODE]) {
		
		[UIAlertView alertViewWithMessage:@"验证码请输入4位有效数字!" :@"提示"];
		verResult = FALSE;
		
	}else if (0 == [passwordTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入密码!" :@"提示"];
		verResult = FALSE;
		
	}else if (6 > [passwordTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入6-20位密码!" :@"提示"];
		verResult = FALSE;
		
	}else if (![passwordTextField.text isMatchedByRegex:PASSWARD]) {
		
		[UIAlertView alertViewWithMessage:@"请输入正确的密码!" :@"提示"];
		verResult = FALSE;
		
    }else if (![passwordTextField.text isEqualToString:twicePasswordTextField.text]) {
        
        [UIAlertView alertViewWithMessage:@"两次输入的密码不一致!" :@"提示"];
        verResult = FALSE;
        
    }else if (0 != [recommendTelephoneTextField.text length]) {
		
		if (!([recommendTelephoneTextField.text isMatchedByRegex:PHONENO] || [recommendTelephoneTextField.text isMatchedByRegex:NUMBER])) {
			
			[UIAlertView alertViewWithMessage:@"请输入11位手机号码或6位渠道号码!" :@"提示"];
			verResult = FALSE;
		}
		
	}
	if (verResult) {
		ASIFormDataRequest * theRequest = [InterfaceClass memberNewRegister:telephoneTextField.text withUserPassword:passwordTextField.text withCheckCode:verificationCodeTextField.text WithrecommendCode:recommendTelephoneTextField.text];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredResult:) Delegate:self needUserType:Default];
		
		
	}
	
	
	
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
		ASIFormDataRequest * theRequest = [InterfaceClass getNewVerificationCode: telephoneTextField.text withType:@"0"];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onVerCodeResult:) Delegate:self needUserType:Default];
		
	}
}

- (void)valueChangedInView:(CustomUISwitch *)view
{
	if (customSwitch.on) 
		
		passwordTextField.secureTextEntry = NO;
	else 
		passwordTextField.secureTextEntry = YES;
}


//注册请求返回处理
- (void)onPaseredResult:(NSDictionary *)dic
{
	NSString *message = [MemberDataResponse memberRegister:dic];
	
	[UserInfo sharedUserInfo].telePhone = telephoneTextField.text ;
	[UserInfo sharedUserInfo].password = passwordTextField.text;
    [UserInfo sharedUserInfo]._loginTime = [NSDate laterDateStr:[NSDate date]];

	[[NSUserDefaults standardUserDefaults]  setObject:telephoneTextField.text forKey:keyLoginTelephone];
	
	
	[UIAlertView alertViewWithMessage:message];
	
	
	[[NSUserDefaults standardUserDefaults] setObject:@"FALSE" forKey:keyAudioRegister];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	NSMutableArray * viewcontollers = [[NSMutableArray alloc] init];
//	[viewcontollers addObjectsFromArray:NavigationController.viewControllers];
//	    
//	UIViewController * instance = [viewcontollers objectAtIndex:[viewcontollers count]-2];
//	if ([instance isKindOfClass:[MemberLoginViewController class]] || [instance isKindOfClass:[NOMemberLoginViewController class]]) {
//		[viewcontollers removeObject:instance];
//	}
//	NavigationController.viewControllers = viewcontollers;
//	[viewcontollers release];
    
    
    for (int i = 0; i < [NavigationController.viewControllers count]-1; i++) {
        
        if (!([[NavigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberLoginViewController class]] || [[NavigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberRegisterViewController class]]|| [[NavigationController.viewControllers objectAtIndex:i] isKindOfClass:[NOMemberLoginViewController class]]))
        {
            [viewcontollers addObject:[NavigationController.viewControllers objectAtIndex:i]];
        }
	}
	NavigationController.viewControllers = viewcontollers;
    [viewcontollers release];
	
	if (self.delegate && [self.delegate respondsToSelector:@selector(loginSuccessFul)]) {
		[self.delegate performSelector:@selector(loginSuccessFul)];
	}
    
	//[self.navigationController popViewControllerAnimated:YES];

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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(![string isMatchedByRegex:PASSWARD] && string.length != 0 )
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

			textFieldMaxLenth = 11; 
		}
			break;
        case 104:
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

- (void)userLogin:(id)sendr
{
    MemberLoginViewController  * memberLoginVC = [[MemberLoginViewController alloc] init];
    memberLoginVC.delegate = self.delegate;
    [NavigationController pushViewController:memberLoginVC animated:YES];
    [memberLoginVC release];
}
@end
