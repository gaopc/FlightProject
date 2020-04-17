//
//  EditPassgersInfoViewController.h
//  FlightProject
//
//  Created by longcd on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "NSDate+convenience.h"
#import "YearMonthDayView.h"
@class PassengerInfoDataResponse;
@class PassengerInfoItem;
@class PassengersInfoViewController;

@protocol EditPassgersInfoViewControllerDelegate <NSObject>

-(void)addPassengerOverWithItem:(PassengerInfoItem *)passengerItem;

@end

@interface EditPassgersInfoViewController : RootViewController<UITextFieldDelegate,YearMonthDayViewDelegate>
{
	
	UISubTextField *nameTextField; //姓名
	UISubTextField *certNumTextField; //证件号
	
	UISubTextField *birthdayTextField; //生日
	
	UISubLabel *certTypeTitleLabel;
	UISubLabel *certNoteLabel;
	
	UIButton *buttonA1; // 乘机人类型成人
	UIButton *buttonA2; // 乘机人类型儿童
	UISubLabel *buttonALabel1;
	UISubLabel *buttonALabel2;
	UISubLabel *buttonBLabel2;
	UISubLabel *buttonBLabel3;
	
	UIButton *buttonB1; // 身份证类型身份证
	UIButton *buttonB2; // 身份证类型护照
	UIButton *buttonB3; // 身份证类型其他
	
	UISubLabel *buttonBLabel1;
	
	UIButton *submitButton; //添加乘机人;
	UIButton *deleteButton; //删除乘机人;
	
	
	int certType; //证件类型
	UIView *editorBgView; //背景页面
	UIView *certTypeView; //证件类型页面
	UIView *bdView; //生日页面
	UIView *certNumView; //证件号页面
	
	//UIView *birthdayBgView; //生日弹出背景页面
	UIView *birthdayView; //生日弹出页面
	UIDatePicker *datePickerView;  //生日选择器
	//MultiDialViewController *multiDialController;
	UIButton *confirmButton;
	UIButton *cancelButton;
	
	UIButton *explainButton; // 2－12岁
	
	
	
	
@public
	PassengersInfoViewController *passengersInfoVC;
}

@property (nonatomic,retain) PassengerInfoDataResponse *passengerInfoData;
@property (nonatomic,retain) PassengerInfoItem *passengerInfoItem;

@property (nonatomic, retain) NSString *menberBirthday;
@property (nonatomic, retain) NSDate *currentYear;
@property (nonatomic, retain) NSDate *currentYearBack;
@property (nonatomic, assign) int type;     //乘机人类型;
@property (nonatomic, retain) NSString *certDay;
@property (nonatomic,assign) int index;

@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic,assign) id delegate;

@end
