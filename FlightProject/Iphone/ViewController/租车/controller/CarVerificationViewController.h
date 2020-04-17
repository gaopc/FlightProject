//
//  CarVerificationViewController.h
//  FlightProject
//
//  Created by gaopengcheng on 14-10-23.
//
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"

@interface CarVerificationViewController : RootViewController <UITextFieldDelegate>
{
    UISubTextField *verificationCodeTextField;
    UIButton *verificationButton;
    NSTimer *_timer;
}
@property (nonatomic, retain) UILabel *_phoneLab;
@property (nonatomic, retain) NSArray *_textFieldArray;
@property (nonatomic, retain) KeyBoardTopBar *_keyboardbar;
@property (nonatomic, retain) SubmitOrderCarInfo * _carInfo;
@property (nonatomic, retain) UISubLabel *_showSecond;
@property (nonatomic, assign) int times;
@property (nonatomic, retain) UILabel *_promptLab;
@property (nonatomic,retain) CarModelDetail * _selectedCarDetail;
@end
