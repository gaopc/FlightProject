//
//  EditorMemberInfoViewController.h
//  FlightProject
//
//  Created by 崔立东 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  编辑会员信息
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "YearMonthDayView.h"
#import "NSDate+convenience.h"
@interface EditorMemberInfoViewController :  RootViewController<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate,YearMonthDayViewDelegate>
{
	
	UISubLabel *telephoneLabel; // 手机号
	
	
	UIButton *buttonA1; // 性别 男
	UIButton *buttonA2; // 性别 女
	
	UISubLabel *buttonALabel1;
	UISubLabel *buttonALabel2;
	
	
	
	UIScrollView *editorrMemberInfoView;

	
	UISubTextField *nameTextField; // 姓名
	UISubTextField *birthdayTextField; // 生日
	UISubTextField *certNumTextField; //证件号
	UISubTextField *emailTextField; //邮箱
	UISubTextField *postCodeTextField; //邮政编码
	NSString *menberBirthday;
	UIImageView *textImageView;
	UISubTextView *addressTextView; //地址
	
	
	int type;     //乘机人类型
	
	//YearMonthDayView *birthdayBgView; //生日弹出背景页面  
	UIView *birthdayView; //生日弹出页面  
	UIDatePicker *datePickerView;  //生日选择器
	
	BOOL isShow;                   //是否显示
	UIButton *confirmButton;
	UIButton *cancelButton;
	
	UIButton *submitButton; //提交按钮
	
	
	
	
}
@property (nonatomic, retain) UIDatePicker *datePickerView;
@property (nonatomic, retain) NSString *menberBirthday;
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@end


