//
//  OnLineQuestionViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"

@interface OnLineQuestionViewController :  RootViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate>
{
	UISubTextView *problemTextView; //建议内容
	UISubTextField *telephoneTextField; //手机号
	UISubTextField *emailTextField; //邮箱
	
	
	UIButton *submitButton; //提交建议;
	UIButton *callButton; //拨打客服电话;
	
	UIView *editorBgView;
	
	
	
}
@property (nonatomic,retain) NSArray * textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar * keyboardbar;
@end
