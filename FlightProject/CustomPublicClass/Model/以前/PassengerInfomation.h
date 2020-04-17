//
//  PassengerInfomation.h
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//会员常旅客基本信息
#import <UIKit/UIKit.h>

@interface PassengerInfomation : NSObject

@property (nonatomic, retain) NSString *psgName;//常旅客姓名
@property (nonatomic, retain) NSString *psgType;//旅客类型
@property (nonatomic, retain) NSString *IDType;//证件类型
@property (nonatomic, retain) NSString *IDNo;//证件号
@property (nonatomic, retain) NSString *birthday;//旅客生日
@property (nonatomic, retain) NSString *contactPhone;//联系电话
@property (nonatomic,retain)NSString * userID;//常旅客ID

@end
