//
//  MemberLoginViewController.h
//  FlightProject
//
//  Created by 崔立东 on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  会员登录
//

#import <UIKit/UIKit.h>
#import "CustomUISwitch.h"
#import "KeyBoardTopBar.h"
@class MemberDataResponse;

@protocol MemberLoginViewControllerDelegate <NSObject>

-(void) loginSuccessFul;

@end

@interface MemberLoginViewController : RootViewController<UITextFieldDelegate,CustomUISwitchDelegate>
{
	UISubTextField *telephoneTextField;
	UISubTextField *passwordTextField;
	MemberDataResponse *memberData;
	UIButton *submitButton; //登录按钮
	UIButton *registerButton; //注册按钮
	UIButton *forgetPassWordButton; //忘记密码按钮
	UIView *loginView;
	
	CustomUISwitch *customSwitch;
	UISubLabel *explanationLabel;//说明

}

@property (nonatomic,assign) id delegate;
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain)KeyBoardTopBar *keyboardbar;

@end
