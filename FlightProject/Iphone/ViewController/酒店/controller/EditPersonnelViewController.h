//
//  EditPersonnelViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
@class HotelPassengerDataResponse;
@class HotelPersonnelInfo;
@class PersonnelListViewController;

@protocol EditPersonnelViewControllerDelegate <NSObject>

-(void)addHotelPersonOverWithPersonItem:(HotelPersonnelInfo *)infoItem;

@end

@interface EditPersonnelViewController :  RootViewController<UITextFieldDelegate>
{
	UISubTextField *nameTextField; //姓名
	UIView *editorBgView; //背景页面
	UIButton *submitButton; //添加乘机人;
	UIButton *deleteButton; //删除乘机人;
	
@public	
	PersonnelListViewController *passengersInfoVC;
}

@property (nonatomic,retain) HotelPassengerDataResponse *passengerInfoData;
@property (nonatomic,retain) HotelPersonnelInfo *passengerInfoItem;

@property (nonatomic, retain) NSString *menberBirthday;
@property (nonatomic,assign) int index;

@property (nonatomic,assign) id delegate;
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain)KeyBoardTopBar *keyboardbar;
@end