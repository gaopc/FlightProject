//
//  ZhiYinCardViewController.h
//  FlightProject
//
//  Created by xiemengyue on 13-5-6.
//
//

#import <UIKit/UIKit.h>
#import "CustomUISwitch.h"
#import "NSDate+convenience.h"
#import "YearMonthDayView.h"
@class KeyBoardTopBar;


//@interface MyTextField : UIView
//@property(nonatomic,retain)UITextField *textField;
//@property(nonatomic,retain)UITextView *textView;
//
//+(id)MyTextField:()
//@end

@interface ZhiYinCardViewController : RootViewController<UITextFieldDelegate,UITextViewDelegate,YearMonthDayViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *registerView;
    
    UISubTextField *nameTextField; //姓名
    UISubTextField *idCardNumTextField; //证件号码
    UISubTextField *birthdayTextField;//出生日期
    UISubTextField *telephoneTextField; //手机号码
    UISubTextField *phoneTextField;//电话号码
    UISubTextField *emailTextField;//邮箱
    UISubTextField *zipCodeTextField;//邮编
    UISubTextView  *addressTextView;//邮寄地址
    UIButton *submitButton; //注册按钮
    
    int sex;//性别 1女  0男  
    UIButton *sexNan;
    UIButton *sexNv;
    int type;//证件类型  1身份证  0护照
    UIButton *selectType1;
    UIButton *selectType2;
}
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@end
