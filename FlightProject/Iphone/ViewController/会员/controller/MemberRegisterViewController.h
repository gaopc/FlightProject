//
//  MemberRegisterViewController.h
//  FlightProject
//
//  Created by 崔立东 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  会员注册
//

#import <UIKit/UIKit.h>
#import "CustomUISwitch.h"

@class KeyBoardTopBar;


@interface MemberRegisterViewController : RootViewController<UITextFieldDelegate,CustomUISwitchDelegate>
{
	UISubTextField *telephoneTextField; //手机号
	UISubTextField *passwordTextField; //密码
    UISubTextField *twicePasswordTextField; //确认密码
	UISubTextField *verificationCodeTextField; //验证码
    UISubTextField *recommendTelephoneTextField; //推荐人号码   // zxt 20121028
	UIButton *verificationButton; //登录按钮
	
	UIView *registerView;	
	UIButton *submitButton; //注册按钮
	
	CustomUISwitch *customSwitch;
	NSTimer *_timer;
	UISubLabel *explanationLabel;//说明
}
@property (nonatomic,assign) int times;
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic,assign) id delegate;
@property (nonatomic,retain) UISubLabel *showSecond;
@end
