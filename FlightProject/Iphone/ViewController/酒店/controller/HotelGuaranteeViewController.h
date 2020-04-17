//
//  HotelGuaranteeViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "UpdateCreditCard.h"
@class HotelQueryDataResponse;
#import "YearMonthView.h"
@class HotelQueryCreditCard;

@interface HotelGuaranteeViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,YearMonthViewDelegate>
{
    CGSize suggestedSize;
}
@property (nonatomic,retain) UITableView *myTableView;
@property (nonatomic,assign) NSInteger viewNum;
@property (nonatomic,assign) NSInteger lastViewNum;
//1表示:没有存在本地的信用卡信息；或在列表中删除了存在本地的信用卡，并返回到该界面
//2表示:从添加信用卡页面添加完，pop回该页时显示的cell；可以点击进入信用卡编辑页面
//3表示:从信用卡列表选择某信用卡，pop回该页的cell
//4表示:从本地读取的信用卡信息，显示在该页时的cell；改cell与3中的cell是一种，需要填写cvv码及卡号后四位
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic,retain) NSMutableArray *textFieldArray;
@property (nonatomic,retain) UpdateCreditCard *creditCardInfo;//展示的信用卡信息

@property (nonatomic,retain) OnHotelQueryCreditCard *onHotelQueryCreditCard;
@property (nonatomic,assign) BOOL deleteCreditCard;
@property (nonatomic,retain) NSString *myValidityDate;

@property (nonatomic,retain) NSString *retentionTime;
@property (nonatomic,retain) HotelInfo *hotelInfo;
@property (nonatomic,retain) HotelRoomType *hotelRoomType;
@property (nonatomic,retain) NSString *checkInDate;
@property (nonatomic,retain) NSString *checkOutDate;
@property (nonatomic,retain) NSMutableArray *passInfoArray;
@property (nonatomic,retain) NSString *roomCount;
@property (nonatomic,retain) NSString *connectorMobile;
@property (nonatomic,retain) NSString *checkCity;

@property (nonatomic,retain) NSString *lcdRate;
@property (nonatomic,retain) NSString *lcdValue;
@property (nonatomic,retain) NSString *lcdActivityId;
@end
