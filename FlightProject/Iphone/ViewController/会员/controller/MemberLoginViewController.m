//
//  MemberLoginViewController.m
//  FlightProject
//
//  Created by 崔立东 on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  会员登录
//

#import "MemberLoginViewController.h"
#import "MemberRegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "EditorMemberInfoViewController.h"

#import "EditorPasswordViewController.h"
#import "JSON.h"
#import "MyRegex.h"
#import "InterfaceClass.h"
#import "MemberDataResponse.h"
#import "SendRequstCatchQueue.h"
#import "ASIFormDataRequest.h"
#import "MemberHomeViewController.h"
#import "AutoDepreciateViewController.h"
#import "TicketAppointmentViewController.h"
#import "MyLCDCoinViewController.h"
#import "NOMemberLoginViewController.h"

@interface MemberLoginViewController ()
- (void)autoLogonInfoToUserDefault : (UserInfo*)auserInfo;
- (void)login :(id)sender;
//- (void)hideKeyboard:(id)sender;

@end

@implementation MemberLoginViewController
@synthesize delegate;
@synthesize textFieldArray,keyboardbar; // zxt 20121028
-(void)dealloc
{
	self.delegate = nil;
	self.textFieldArray = nil;
	self.keyboardbar = nil;
	[super dealloc];
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	NSString *telephone = [[NSUserDefaults standardUserDefaults] objectForKey:keyLoginTelephone];
	if (telephone) {
		telephoneTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:keyLoginTelephone];
	}else{
		if ([telephoneTextField.text isEqualToString:@""] || telephoneTextField.text == nil) {
			telephoneTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:keyLoginTelephone];
		}
	}


}
- (void)loadView{
	
        [super loadView];
	
	long origin_y = 12.0f;
	
	//NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, 7.0f)] ;
	[topView setImage:[UIImage imageNamed:@"MemberLoginTop.png"]];
	[self.view addSubview:topView];
	
	origin_y += topView.frame.size.height;
	
	loginView = [[UIView alloc]initWithFrame:CGRectMake(10.0f,origin_y, ViewWidth-20.0f, 165.0f)];
	loginView.backgroundColor = [UIColor clearColor];
	
	
	UIImageView *telephoneImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 18.0f, 275.5f, 36.5f)];
	[telephoneImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[loginView addSubview:telephoneImageView];
	
	UISubLabel *userNameTitle = [UISubLabel labelWithTitle:@"手机号 :" frame:CGRectMake(28.0f, 20.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	userNameTitle.textColor = FontColor333333;
	[loginView addSubview:userNameTitle];
	//手机号
	telephoneTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 24.0f, 190.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入注册手机号"];
	telephoneTextField.font = FontSize32;
	telephoneTextField.keyboardType = UIKeyboardTypeNumberPad;
	telephoneTextField.tag = 100;
	telephoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	telephoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	telephoneTextField.delegate = self;
	[loginView addSubview:telephoneTextField];
	
	
	UIImageView *passwordImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 70.0f, 275.5f, 36.5f)];
	[passwordImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[loginView addSubview:passwordImageView];
	
	UISubLabel *passwordNameTitle = [UISubLabel labelWithTitle:@"密    码 :" frame:CGRectMake(28.0f, 70.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	passwordNameTitle.textColor = FontColor333333;
	[loginView addSubview:passwordNameTitle];
	
	//密码
	passwordTextField = [UISubTextField TextFieldWithFrame:CGRectMake(85.0f, 74.0f, 200.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入6-20位密码"];
	passwordTextField.font = FontSize32;
	passwordTextField.secureTextEntry = YES;
	passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
        passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
	passwordTextField.tag = 101;
	passwordTextField.delegate = self;
	passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	[loginView addSubview:passwordTextField];
	
//	UIImageView *lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 122.0f, 275.0f, 1.0f)];
//	[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
//	[loginView addSubview:lineImageView];
	
	
	
	UISubLabel *audioLoginTitle = [UISubLabel labelWithTitle:@"自动登录" frame:CGRectMake(27.0f, 121.0f, 70.0f, 30.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	audioLoginTitle.textColor = FontColor333333;
	[loginView addSubview:audioLoginTitle];
	
	
	customSwitch = [[[CustomUISwitch alloc] initWithFrame:CGRectMake(100.0f, 125.0f, 60.0f, 22.0f)] autorelease];
	customSwitch.delegate=self;
	[customSwitch setOn:NO animated:YES];
	[loginView addSubview:customSwitch];
	
	if(![[NSUserDefaults standardUserDefaults]  objectForKey:keyAudioLogin])
		[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:[customSwitch isOn]] forKey:keyAudioLogin];
	
	
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, loginView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"MemberLoginCenter.png"]];
	[self.view addSubview:centerView];
	[self.view addSubview:loginView];
	[loginView release];
	
	origin_y += centerView.frame.size.height;
	
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, 7.0f)];
	[bottom setImage:[UIImage imageNamed:@"MemberLoginBottom.png"]];
	[self.view addSubview:bottom];
	
	self.textFieldArray = [NSArray arrayWithObjects:telephoneTextField,passwordTextField, nil];
	
	submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(50.0f, 205.0f, 225.5f, 45.0f) backImage:[UIImage imageNamed:@"MemberLoginButton.png"] target:self action:@selector(login:)];
	[self.view addSubview:submitButton];
	
	
	forgetPassWordButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"忘记密码?" frame:CGRectMake(123.0f, 258.0f, 80.0f, 25.0f) backImage: nil target:self action:@selector(forgetPassword:)];
	forgetPassWordButton.backgroundColor =[UIColor clearColor];
	[forgetPassWordButton setTitleColor:FontColorFF6113 forState:UIControlStateNormal];
	[forgetPassWordButton setTitleColor:FontColorFF6113 forState:UIControlStateHighlighted];
	[forgetPassWordButton.titleLabel  setFont:FontSize30];
	[self.view addSubview:forgetPassWordButton];
	
	UIImageView *lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(15.0f, 280.0f, 270, 1.0f)];
	[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
	[loginView addSubview:lineImageView];
	
	
	registerButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(8.0f, ViewWidth, ViewWidth-16.0f, 48.5) backImage:[UIImage imageNamed:@"MemberRegisterButton.png"] target:self action:@selector(registe:)];
	
	[registerButton setImage:[UIImage imageNamed:@"MemberRegisterButton.png"] forState:UIControlStateHighlighted];
	[registerButton.titleLabel  setFont:[UIFont boldSystemFontOfSize: 17.5f]];
	[self.view addSubview:registerButton];
	
	UISubLabel *registerTitle = [UISubLabel labelWithTitle:@"免费注册" frame:CGRectMake(17.0f, 328.0f, 300.0f, 30.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	registerTitle.textColor = FontColor696969;
	[self.view addSubview:registerTitle];
	
	explanationLabel = [UISubLabel labelWithTitle:@"注册成为会员可享受预订返赠等多重优惠。" frame:CGRectMake(15.0f, ViewHeight-85.0f, 290.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentCenter];
	explanationLabel.textColor = FontColorFF6113;
	[self.view addSubview:explanationLabel];
	
	
}
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title=@"会员登录";
	UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 7, 52, 30) backImage:[UIImage imageNamed:@"backPre.png"] target:self action:@selector(backHome)];
	UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
	self.navigationItem.leftBarButtonItem = leftBar;
	[leftBar release];
	
//	if ([telephoneTextField.text isEqualToString:@""] || telephoneTextField.text == nil) {
//		telephoneTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:keyLoginTelephone];
//	}
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}


- (void)login :(id)sender {
	
	if (0 == [telephoneTextField.text length]) {
		[UIAlertView alertViewWithMessage:@"请输入手机号码!" :@"提示"];
		
	}else if (11 > [telephoneTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入11位手机号码!" :@"提示"];
		
	}else if (![telephoneTextField.text isMatchedByRegex:PHONENO]) {
		
		[UIAlertView alertViewWithMessage:@"请输入正确的手机号码!" :@"提示"];
		
	}else if (0 == [passwordTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入密码!" :@"提示"];
		
	}else if (6 > [passwordTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入6-20位密码!" :@"提示"];
		
	}else if (![passwordTextField.text isMatchedByRegex:PASSWARD]) {
	
		[UIAlertView alertViewWithMessage:@"请输入正确的用户名密码!" :@"提示"];
		
	}else {
		ASIFormDataRequest * theRequest = [InterfaceClass memberLogin:telephoneTextField.text withUserPassword:passwordTextField.text];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onmemberLoginPaseredResult:) Delegate:self needUserType:Default];
		
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


- (void)valueChangedInView:(CustomUISwitch *)view
{
	if (customSwitch.on) 
	[UIAlertView alertViewWithMessage:@"开启自动登录功能，在每次启动掌上航旅时会自动登录您的账号。 本公司对于在自动登录情况下由于手机丢失而导致的客户信息泄露不承担法律责任，请你谅解。" :@"提示"];

	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:[customSwitch isOn]] forKey:keyAudioLogin];
	[[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)registe :(id)sender {
	passwordTextField.text= @"";
	MemberRegisterViewController *registerVC = [[MemberRegisterViewController alloc] init];
	registerVC.delegate = self.delegate;
	[self.navigationController pushViewController:registerVC animated:YES];
	[registerVC release];
}


- (void)forgetPassword :(id)sender {
	passwordTextField.text= @"";
	ForgetPasswordViewController *forgetPasswordVC = [[ForgetPasswordViewController alloc] init];
	forgetPasswordVC.telephoneText = telephoneTextField.text; //[[NSUserDefaults standardUserDefaults] objectForKey:keyLoginTelephone];
	[self.navigationController pushViewController:forgetPasswordVC animated:YES];
	[forgetPasswordVC release];
}

- (void)onmemberLoginPaseredResult:(NSDictionary *)dic
{
	memberData = [MemberDataResponse memberLogin:dic];
	
	[UserInfo sharedUserInfo]._isAutoLogin = [customSwitch isOn];
	[UserInfo sharedUserInfo].telePhone = telephoneTextField.text;
	[UserInfo sharedUserInfo].password = passwordTextField.text;
     
	
	[self autoLogonInfoToUserDefault:[UserInfo sharedUserInfo]];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"FALSE" forKey:keyAudioRegister];
	[[NSUserDefaults standardUserDefaults] synchronize];
    
    if (![UserInfo sharedUserInfo]._isAutoLogin) {
        [UserInfo sharedUserInfo]._loginTime = [NSDate laterDateStr:[NSDate date]];
    }
    else {
        [UserInfo sharedUserInfo]._loginTime = nil;
    }
    
    self._pointView._pointLab.tag = [[UserInfo sharedUserInfo]._orderStateNum intValue];
	
	// zxt  add 登陆成功后代理方法
	//  [NavigationController popViewControllerAnimated:YES];
	NSMutableArray * mArray = [NSMutableArray array];
    /*
	for (int i = 0; i < [NavigationController.viewControllers count]-1; i++) {
		[mArray addObject:[NavigationController.viewControllers objectAtIndex:i]];
	}
     */
    
    for (int i = 0; i < [NavigationController.viewControllers count]-1; i++) {
        
        if (!([[NavigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberLoginViewController class]] || [[NavigationController.viewControllers objectAtIndex:i] isKindOfClass:[NOMemberLoginViewController class]] || [[NavigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberRegisterViewController class]]))
        {
            [mArray addObject:[NavigationController.viewControllers objectAtIndex:i]];
        }
	}
	NavigationController.viewControllers = mArray;
	if (self.delegate && [self.delegate respondsToSelector:@selector(loginSuccessFul)]) {
		[self.delegate performSelector:@selector(loginSuccessFul)];
	}
}
-(void)loginBack{}
-(void)backHome
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginBack)]) {
        [self.delegate performSelector:@selector(loginBack)];
    }
    else {
        [super backHome];
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
	return  YES;
}


- (void)autoLogonInfoToUserDefault : (UserInfo*)auserInfo {
	
	if (auserInfo) {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:auserInfo.userID forKey:keyLoginUserID];
		[defaults setObject:auserInfo.telePhone forKey:keyLoginTelephone];
		[defaults setObject:auserInfo.password forKey:keyLoginPassword];
		[defaults synchronize];
	}
}

@end
