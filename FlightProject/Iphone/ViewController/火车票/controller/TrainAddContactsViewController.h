//
//  TrainAddContactsViewController.h
//  FlightProject
//
//  Created by gaopengcheng on 15-7-17.
//
//

#import <UIKit/UIKit.h>
#import "PassengerInfoDataResponse.h"
#import "KeyBoardTopBar.h"

@interface TrainAddContactsViewController : RootViewController <UITextFieldDelegate>
{
    UISubTextField *nameTextField; //姓名
    UISubTextField *certNumTextField; //手机号
    UISubLabel *certTypeTitleLabel;
    
    UIButton *submitButton; //添加乘机人;
    UIButton *deleteButton; //删除乘机人;
    
    UIView *editorBgView; //背景页面
    UIView *certNumView; //手机号页面
}
@property (nonatomic, retain) PickPersonInfoItem *_editItem;
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (assign) id _delegate;
@end
