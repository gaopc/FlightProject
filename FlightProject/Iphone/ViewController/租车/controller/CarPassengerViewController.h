//
//  CarPassengerViewController.h
//  FlightProject
//
//  Created by longcd on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "MyRegex.h"
#import "CarServicesViewController.h"
#import "CarPassengersResponse.h"

@interface CarPassengerViewController : RootViewController<UITextFieldDelegate>
{
    UISubTextField * _nameField;
    UISubTextField * _identityNumberField;
    UISubTextField * _mobileNumberField;
    
    UIButton *delButton;
    UIButton *subButton;
    UIImageView *doubleButtonImgView;
}
@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic,retain) SubmitOrderCarInfo * queryDataModel;

@property (nonatomic,retain) CarModelDetail * carDetail;
@property (nonatomic,retain) QueryCarServiceResponse *carService;

@property (nonatomic, retain) NSString *actionType; //0 新增租车人  1 编辑租车人
@property (nonatomic, retain) NSString *gateway;    //0 汽车列表入口  1 会员租车人入口
@property (nonatomic, retain) CarPassengersResponse *carPassengersInfo;
@end
