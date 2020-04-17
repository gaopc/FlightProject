//
//  MemberHotelCell.h
//  FlightProject
//
//  Created by admin on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberHotelCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_orderNo;
@property (nonatomic, retain) UISubLabel *_orderState;
@property (nonatomic, retain) UISubLabel *_scheduleDate;
@property (nonatomic, retain) UISubLabel *_hotelInfo;
@property (nonatomic, retain) UISubLabel *_lcdCurrency;
@property (nonatomic, retain) UISubLabel *_totelMoney;
@property (nonatomic,retain) UIView * _returnLcdView;
@end

@interface MemberHotelInfoCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_hotelName;
@property (nonatomic, retain) UISubLabel *_hotelAddress;
@property (nonatomic, retain) UISubLabel *_checkInDate;
@property (nonatomic, retain) UISubLabel *_checkOutDate;
@end

@interface MemberHotelPeopleInfoCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_peopleName;
@end

@interface MemberHotelTelePhoneCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_telNum;
@end

@interface MemberEndCell : UITableViewCell
@end 

@interface MemberHotelDetailCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_hotelInfo;
@property (nonatomic, retain) UISubLabel *_lcdCurrency;
@property (nonatomic, retain) UISubLabel *_totelMoney;
@property (nonatomic,retain) UIView * _returnLcdView;
@end
