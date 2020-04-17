//
//  MemberOrderPayInfoViewController.h
//  FlightProject
//
//  Created by admin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTicketToPerchCell.h"
#import "OrderTicketInfoCell.h"
#import "DevicePositionMapViewController.h"
#import "MemberOrderDetailResponse.h"
#import "GetConfiguration.h"
#import "MemberOrderDetailCell.h"
#import "KeyBoardTopBar.h"
#import "MyRegex.h"

@interface MemberOrderPayInfoViewController : RootViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    UITableView *myTable;
    UISubTextField *myField;
    int insurancePrice;
    UIButton *bottomButton;
    
    BOOL editorContent;
}

@property (nonatomic, retain) NSString *getItineraryType;
@property (nonatomic, retain) NSString *contactorPhone;
@property (nonatomic, retain) NSString *isAcceptService;
@property (assign) int totalPrice;
@property (assign) int adultCount;
@property (assign) int childCount;
@property (nonatomic, retain) MemberOrderDetailResponse *orderDataInfo;

@property (nonatomic,retain) NSArray *textFieldArray;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@end
