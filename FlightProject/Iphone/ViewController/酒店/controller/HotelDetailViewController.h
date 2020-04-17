//
//  HotelDetailViewController.h
//  FlightProject
//
//  Created by admin on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberHotelCell.h"
@class HotelQueryDataResponse;
@class HotelQueryCreditCard;
#import "UpdateCreditCard.h"

@interface HotelDetailViewController : RootViewController<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
{
    UITableView *myTable;
    UIButton *bottomButton;
}
@property (nonatomic,retain) OnHotelQueryCreditCard *onHotelQueryCreditCard;
@property (nonatomic,retain) NSString *retentionTime;
@property (nonatomic,retain) HotelInfo *hotelInfo;
@property (nonatomic,retain) HotelRoomType *hotelRoomType;
@property (nonatomic,retain) UpdateCreditCard *creditCardInfo;//信用卡信息
@property (nonatomic,retain) NSString *checkInDate;
@property (nonatomic,retain) NSString *checkOutDate;
@property (nonatomic,retain) NSString *roomCount;
@property (nonatomic,retain) NSString *connectorMobile;
@property (nonatomic,retain) NSMutableArray *passInfoArray;

@property (nonatomic,retain) NSString * checkCity;

@property (nonatomic,retain) NSArray * _carList;
@property (nonatomic,retain) NSArray  * _ticketList;
@property (nonatomic,retain) NSString *lcdRate;
@property (nonatomic,retain) NSString *lcdValue;
@property (nonatomic,retain) NSString *lcdActivityId;
@end
