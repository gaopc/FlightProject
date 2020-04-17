//
//  HotelRoomHomeViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TicketHomeViewController.h"

@interface RoomHomeViewController : RootViewController<CustomTabbarViewDelegate>
{
	id <TicketHomeViewControllerDelegate> ticketDelegate;
	
	CustomTabbarView * tabbarV;

	
}

@property (nonatomic,retain) NSString * lcdRate; //畅达币返点率
@property (nonatomic,retain) NSString * lcdValue; //畅达币返值
@property (nonatomic,retain) NSString * lcdActivityId; //畅达币有效天数
@property (nonatomic,assign) id ticketDelegate;
@property (nonatomic,retain) UIView * activeView;
@property (nonatomic,retain) UIView * preView;

@property (nonatomic,retain) NSMutableArray * roomListArray;
@property (nonatomic,retain) HotelInfo * hotelInfo;
@property (nonatomic,retain) NSMutableArray * picUrlArray;

@property (nonatomic, retain) NSString *startDay;
@property (nonatomic, retain) NSString *endDay;
@property (nonatomic, retain) NSString *cityName;
@end
