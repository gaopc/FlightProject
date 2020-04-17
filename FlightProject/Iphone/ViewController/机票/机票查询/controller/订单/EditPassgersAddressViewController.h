//
//  EditPassgersAddressViewController.h
//  FlightProject
//
//  Created by lidong  cui on 12-10-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassengerAddressDataResponse.h"
#import "KeyBoardTopBar.h"
#import "CityPickerView.h"

@protocol EditPassgersAddressViewControllerDelegate <NSObject>

-(void)addAddressOverWithAddressItem:(PassengerAddressItem *)addressItem;

@end

@class PassengersAddressViewController;
@interface EditPassgersAddressViewController : RootViewController<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
	
	UISubTextField *nameTextField; //姓名
	UISubTextView *addressTextView; //详细地址
	UISubTextField *postCodeTextField; //邮政编码
	UISubTextField *mobileTextField; //联系电话
	
	UISubLabel *placeHolderLabel;
        
	UIButton *submitButton; //添加邮寄地址;
	UIButton *deleteButton; //删除邮寄地址;
	
	UIView *editorBgView;
    UIScrollView *myScroll;
    UIButton *selectCity;
    
    CityPickerView *cityPickerView;
    NSString *provinceName;
    NSString *cityName;
    NSString *countyName;
	
@public
	PassengersAddressViewController *passengersAddressVC;
	
}

@property (nonatomic,retain) PassengerAddressItem * passengerAddressItem;
@property (nonatomic,assign) int index;
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic,assign) id delegate;
@property (nonatomic, retain) NSDictionary *_cityData;
@end
