//
//  HotelOrdersViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotelQueryDataResponse;
@class KeyBoardTopBar;
@interface HotelOrdersViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSInteger roomCount;
    NSInteger insertSectionNum;
}
@property (nonatomic,retain) UITableView * myTableView;
@property (nonatomic,assign) BOOL fisrtStyle;
@property (nonatomic,retain) NSString *retentionTime;
@property (nonatomic,assign) BOOL hasPerson;
@property (nonatomic,retain) HotelInfo *hotelInfo;
@property (nonatomic,retain) HotelRoomType *hotelRoomType;
@property (nonatomic,retain) NSString *checkInDate;
@property (nonatomic,retain) NSString *checkOutDate;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic,retain) NSString *contactNum;
@property (nonatomic,assign) int nowRomeCount;

@property (nonatomic,retain) NSMutableArray *passInfoArray;
@property (nonatomic,retain) NSString * checkCity;
@property (nonatomic,retain) NSArray *timeArray;
@property (nonatomic,assign) NSInteger selectTimeRow;
@property (nonatomic,assign) NSInteger selectNowTimeRow;
@property (nonatomic,assign) BOOL checkIsNowDate;
@property (nonatomic,retain) NSString *lcdRate;
@property (nonatomic,retain) NSString *lcdValue;
@property (nonatomic,retain) NSString *lcdActivityId;
@end
