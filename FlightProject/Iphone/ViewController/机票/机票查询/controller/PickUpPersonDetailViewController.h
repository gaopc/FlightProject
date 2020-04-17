//
//  PickUpPersonDetailViewController.h
//  FlightProject
//
//  Created by 张晓婷 on 14-4-15.
//
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"

@class PassengerInfoDataResponse;
@class PickPersonInfoItem;
@class PickUpPersonListViewController;

@protocol PickUpPersonDetailViewControllerDelegate <NSObject>

-(void)addPickUpPersonOverWithItem:(PickPersonInfoItem *)passengerItem;

@end

@interface PickUpPersonDetailViewController : RootViewController<UITextFieldDelegate>
{
	
	UISubTextField *nameTextField; //姓名
	UISubTextField *certNumTextField; //手机号
	UISubLabel *certTypeTitleLabel;
	
	UIButton *submitButton; //添加乘机人;
	UIButton *deleteButton; //删除乘机人;
	
	UIView *editorBgView; //背景页面
	UIView *certNumView; //手机号页面
	
	UIButton *confirmButton;
	UIButton *cancelButton;
	
@public
	PickUpPersonListViewController *passengersInfoVC;
}

@property (nonatomic,retain) PassengerInfoDataResponse *passengerInfoData;
@property (nonatomic,retain) PickPersonInfoItem *passengerInfoItem;
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic,assign) id delegate;

@end

