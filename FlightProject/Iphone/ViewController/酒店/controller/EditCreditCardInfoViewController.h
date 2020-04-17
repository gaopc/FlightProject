//
//  EditCreditCardInfoViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UpdateCreditCard;
@class HotelGuaranteeViewController;
@class SelectCreditCardViewController;
#import "KeyBoardTopBar.h"
#import "OrderByCardPayViewController.h"
#import "YearMonthView.h"
#import "GetBankList.h"


@interface MyCell : UITableViewCell
@property(nonatomic,retain)UISubTextField *userName;
@property(nonatomic,retain)UISubTextField *credentialNum;
@property(nonatomic,retain)UISubTextField *cardNum;
@property(nonatomic,retain)UISubTextField *cvvNum;
@property(nonatomic,retain)UISubTextField *bankName;
@property(nonatomic,retain)UISubTextField *validityDate;
@property(nonatomic,retain)UIButton *selectBank;
@property(nonatomic,retain)UIButton *showCVV2;
@property (nonatomic, retain) UIImageView *_pointView;
@end


@interface CardCell : UITableViewCell
@property(nonatomic,retain)UISubTextField *userName;
@property(nonatomic,retain)UISubTextField *credentialNum;
@property(nonatomic,retain)UISubTextField *cardNum;
@property(nonatomic,retain)UISubTextField *bankName;
@property(nonatomic,retain)UIButton *selectBank;
@property (nonatomic, retain) UIImageView *_pointView;
@end


@interface ValidityDatePicker : UIView
@end


@interface EditCreditCardInfoViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,YearMonthViewDelegate>
{
    @public HotelGuaranteeViewController *hotelGuaranteeViewController;
    @public  OrderByCardPayViewController *orderByCardPayViewController;
}
@property (nonatomic,retain) UITableView *myTableView;
@property (nonatomic,retain) UpdateCreditCard *updateCreditCard;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic,retain) NSMutableArray *textFieldArray;
@property (nonatomic,retain) BankListInfo *bankInfo;
@property (nonatomic,assign) BOOL ifReloadData;
@property (nonatomic,assign) BOOL ifAddCreditCard;//调用 新增信用卡接口，还是修改信用卡接口
@property (nonatomic,assign) BOOL ifEditAll;//YES:可以编辑所以信息  NO:只可以编辑cvv2 有效期
@property (nonatomic,retain) UIView *cvv2View;


//@property (nonatomic,retain) YearMonthView * yearMonthView;
@end

