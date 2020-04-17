//
//  MemberForgetPasswordViewController.h
//  FlightProject
//
//  Created by 崔立东 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  会员密码找回
//

#import <UIKit/UIKit.h>
#import "CustomUISwitch.h"
@class MemberDataResponse;
@class KeyBoardTopBar;
@interface ForgetPasswordViewController : RootViewController<UITextFieldDelegate>
{
	UIView *forgetPasswordView;
	
	
	UISubTextField *telephoneTextField; //手机号
	UISubTextField *passwordTextField; //密码
	UISubTextField *verificationCodeTextField; //验证码
    UISubTextField *twicePasswordTextField;
	
	MemberDataResponse *memberData;
	
	UIButton *verificationButton; //获取验证码按钮
	UIButton *submitButton; //注册按钮
	
	CustomUISwitch *customSwitch;

	NSTimer *_timer;
	
	
}

@property (nonatomic,assign) int times;
@property (nonatomic,retain) UISubLabel *showSecond;
@property (nonatomic,retain) NSString *telephoneText;
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@end
