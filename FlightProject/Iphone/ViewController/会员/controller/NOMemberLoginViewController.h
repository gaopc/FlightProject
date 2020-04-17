//
//  NOMemberLoginViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomUISwitch.h"
#import "KeyBoardTopBar.h"
@class MemberDataResponse;


@protocol NOMemberLoginViewControllerDelegate <NSObject>

-(void) loginSuccessFul;

@end

@interface NOMemberLoginViewController : RootViewController<UITextFieldDelegate,CustomUISwitchDelegate>
{
	
	UISubTextField *telephoneTextField;
	UISubTextField *passwordTextField;
	MemberDataResponse *memberData;
	UIButton *submitButton; //登录按钮
	UIButton *registerButton; //注册按钮
	UIButton *forgetPassWordButton; //忘记密码按钮
	
	UIButton *noMemberButton; //非会员登陆按钮
	
	UIView *loginView;
	
	CustomUISwitch *customSwitch;
	UISubLabel *explanationLabel;//说明

}

@property (nonatomic,assign) id delegate;
@property (nonatomic,retain)NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@end

