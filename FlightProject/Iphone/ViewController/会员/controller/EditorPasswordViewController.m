//
//  EditorPasswordViewController.m
//  FlightProject
//
//  Created by green kevin on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EditorPasswordViewController.h"
#import "JSON.h"
#import "MyRegex.h"
#import "InterfaceClass.h"
#import "MemberDataResponse.h"
#import "SendRequstCatchQueue.h"
#import "ASIFormDataRequest.h"
@interface EditorPasswordViewController ()
//- (void)hideKeyboard:(id)sender;
@end

@implementation EditorPasswordViewController
@synthesize textFieldArray;
@synthesize userInfo = _userInfo;
@synthesize keyboardbar;
- (void)dealloc
{
    self.textFieldArray = nil;
	self.userInfo = nil;
    self.keyboardbar = nil;
	[super dealloc];
}


- (void)loadView{
	
        [super loadView];
	
	
	long origin_y = 12.0f;
	
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, 7.0f)] ;
	[topView setImage:[UIImage imageNamed:@"MemberLoginTop.png"]];
	[self.view addSubview:topView];
	
	origin_y += topView.frame.size.height;
	
	editorPasswordView = [[UIView alloc]initWithFrame:CGRectMake(10 ,origin_y,ViewWidth-20,190.0f)];
	editorPasswordView.backgroundColor = [UIColor clearColor];
	
	UIImageView *passwordOldImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 18.0f, ViewWidth - 20 - 12*2, 36.5f)];
	[passwordOldImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[editorPasswordView addSubview:passwordOldImageView];
	
	UISubLabel *passwordOldTitle = [UISubLabel labelWithTitle:@"原密码 :" frame:CGRectMake(28.0f, 21.0f, 70.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	passwordOldTitle.textColor = FontColor333333;
	[editorPasswordView addSubview:passwordOldTitle];
	//原密码
	passwordOldTextField = [UISubTextField TextFieldWithFrame:CGRectMake(95.0f, 24.0f, ViewWidth - 120, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入原密码"];
	passwordOldTextField.font = FontSize32;
	passwordOldTextField.secureTextEntry = YES;
	passwordOldTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
	passwordOldTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	passwordOldTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	passwordOldTextField.tag = 100;
	passwordOldTextField.delegate = self;
        passwordOldTextField.keyboardType = UIKeyboardTypeASCIICapable;
	[editorPasswordView addSubview:passwordOldTextField];
	
	
	UIImageView *passwordNewImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 73.0f, ViewWidth - 20 - 12*2, 36.5f)];
	[passwordNewImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[editorPasswordView addSubview:passwordNewImageView];
	
	UISubLabel *passwordNewTitle = [UISubLabel labelWithTitle:@"新密码 :" frame:CGRectMake(28.0f, 76.0f, 70.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	passwordNewTitle.textColor = FontColor333333;
	[editorPasswordView addSubview:passwordNewTitle];
	
	//新密码
	passwordNewTextField = [UISubTextField TextFieldWithFrame:CGRectMake(95.0f, 77.0f, ViewWidth - 120, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入6-20位字符"];
	passwordNewTextField.font = FontSize32;
	passwordNewTextField.secureTextEntry = YES;
	passwordNewTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
	passwordNewTextField.tag = 101;
	passwordNewTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	passwordNewTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	passwordNewTextField.delegate = self;
        passwordNewTextField.keyboardType = UIKeyboardTypeASCIICapable;
	[editorPasswordView addSubview:passwordNewTextField];
	
	
	UIImageView *confirmNewImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 128.0f, 275.5f, 36.5f)];
	[confirmNewImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[editorPasswordView addSubview:confirmNewImageView];
	
	UISubLabel *confirmNewTitle = [UISubLabel labelWithTitle:@"确认密码 :" frame:CGRectMake(20.0f, 131.0f, 70.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	confirmNewTitle.textColor = FontColor333333;
	[editorPasswordView addSubview:confirmNewTitle];
	
	confirmNewTextField = [UITextField TextFieldWithFrame:CGRectMake(95.0f, 135.0f, 200.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请再次输入新密码"];
	confirmNewTextField.backgroundColor =[UIColor clearColor];
	confirmNewTextField.font = FontSize32;
	confirmNewTextField.returnKeyType = UIReturnKeyDone;
	confirmNewTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	confirmNewTextField.keyboardType = UIKeyboardTypeDefault;
	//confirmNewTextField.clearButtonMode = UITextFieldViewModeAlways;
	confirmNewTextField.secureTextEntry = YES;
	confirmNewTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
	confirmNewTextField.tag = 102;
	confirmNewTextField.delegate = self;
	[editorPasswordView addSubview:confirmNewTextField];
	
	
	
	UISubLabel *showPassWordTitle = [UISubLabel labelWithTitle:@"显示密码" frame:CGRectMake(27.0f, 131.0f, 70.0f, 30.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	showPassWordTitle.textColor = FontColor333333;
//	[editorPasswordView addSubview:showPassWordTitle];
	

	
	
	customSwitch = [[CustomUISwitch alloc] initWithFrame:CGRectMake(100.0f, 135.0f, 60.0f, 22.0f)] ;
	customSwitch.delegate=self;
	[customSwitch setOn:NO animated:YES];
//	[editorPasswordView addSubview:customSwitch];
        [customSwitch release];
	
	
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, editorPasswordView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"MemberLoginCenter.png"]];
	[self.view addSubview:centerView];
	[self.view addSubview:editorPasswordView];
	[editorPasswordView release];
	
	self.textFieldArray = [NSArray arrayWithObjects :passwordOldTextField,passwordNewTextField, confirmNewTextField, nil];

	
	origin_y += centerView.frame.size.height;
	
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, 7.0f)];
	[bottom setImage:[UIImage imageNamed:@"MemberLoginBottom.png"]];
	[self.view addSubview:bottom];
	
	submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(50.0f, ViewHeight-230.0f, 225.5f, 45.0f) backImage:[UIImage imageNamed:@"MemberSubmitButton.png"] target:self action:@selector(editor:)];
	[submitButton setImage:[UIImage imageNamed:@"MemberSubmitButton.png"] forState:UIControlStateHighlighted];
	[self.view addSubview:submitButton];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title=@"修改密码";
}


- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

- (void)switchValueChange :(id)sender {
	
	UISwitch *theSwitch = (UISwitch *)sender;
	if (theSwitch.on) {
		
		passwordOldTextField.secureTextEntry = NO;
	        passwordNewTextField.secureTextEntry = NO;
		//confirmNewTextField.secureTextEntry = NO;
	}else{ 
		passwordOldTextField.secureTextEntry = YES;
	        passwordNewTextField.secureTextEntry = YES;
		//confirmNewTextField.secureTextEntry = YES;
	}
}

- (void)valueChangedInView:(CustomUISwitch *)view
{
	if (customSwitch.on) {
		
		passwordOldTextField.secureTextEntry = NO;
		passwordNewTextField.secureTextEntry = NO;
		//confirmNewTextField.secureTextEntry = NO;
	}else{ 
		passwordOldTextField.secureTextEntry = YES;
		passwordNewTextField.secureTextEntry = YES;
		//confirmNewTextField.secureTextEntry = YES;
	}
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if(![string isMatchedByRegex:PASSWARD] && string.length != 0 && textField.tag == 101)
    {
        return NO;
    }
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
	
	switch (textField.tag) {
		case 100:
		{

			textFieldMaxLenth = 20;
		}
			break;
		case 101:
		{
			textFieldMaxLenth = 20;
		}
			break;
        case 102:
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


- (void)editor :(id)sender {
	
	
	NSString *oldPWD = passwordOldTextField.text;
	NSString *newPWD = passwordNewTextField.text;
	NSString *renewPWD = confirmNewTextField.text;
	
	
	if (0 == [oldPWD length]) {
		[UIAlertView alertViewWithMessage:@"请输入原密码!" :@"提示"];
		
	}else if (6 > [oldPWD length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入6-20位密码!" :@"提示"];
		
	}else if (0==[newPWD length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入新密码!" :@"提示"];
		
	}else if (6 > [newPWD length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入6-20位密码!" :@"提示"];
		
    }else if (![newPWD isMatchedByRegex:PASSWARD]) {
        
        [UIAlertView alertViewWithMessage:@"新密码输入错误!" :@"提示"];
        
    }else if (![newPWD isEqualToString:renewPWD]) {
        
        [UIAlertView alertViewWithMessage:@"确认密码输入与新密码输入不一致!" :@"提示"];
        
    }else {
		
		ASIFormDataRequest * theRequest = [InterfaceClass updateNewPassword:[UserInfo sharedUserInfo].userID withOldPassword:passwordOldTextField.text withNewPassword:passwordNewTextField.text];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onupdateNewPasswordPaseredResult:) Delegate:self needUserType:Member];
		
		
	}
}


//更新密码返回处理
- (void)onupdateNewPasswordPaseredResult:(NSDictionary *)dic
{
	
	
	NSString  *messsage  = [MemberDataResponse updatePassword:dic];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:passwordNewTextField.text forKey:keyLoginPassword];
	[defaults synchronize];
	//返回处理
        
	[UIAlertView alertViewWithMessage:messsage];
	[self.navigationController popViewControllerAnimated:YES];
	
	
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.keyboardbar == nil) {
        KeyBoardTopBar * _keyboardbar =[[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
        self.keyboardbar = _keyboardbar;
        [_keyboardbar release];
    }
    [keyboardbar showBar:textField];  //显示工具条 

    return YES;
}


@end
