//
//  EditorPasswordViewController.h
//  FlightProject
//
//  Created by green kevin on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUISwitch.h"
#import "KeyBoardTopBar.h"

@interface EditorPasswordViewController : RootViewController<UITextFieldDelegate,CustomUISwitchDelegate>
{
	
	
	UISubTextField *passwordOldTextField; //旧密码
	UISubTextField *passwordNewTextField; //新密码
	UITextField *confirmNewTextField; //确认新密码
	UIView *editorPasswordView;
	UIButton *submitButton; //修改按钮
	CustomUISwitch *customSwitch;
	
	
}

@property (nonatomic,retain) UserInfo *userInfo;
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@end
