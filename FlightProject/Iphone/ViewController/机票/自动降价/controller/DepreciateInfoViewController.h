//
//  DepreciateInfoViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AutomaticallyInfo;
@interface DepreciateInfoViewController : RootViewController<UIActionSheetDelegate>

{
	
	UIImageView *smallIcons; //航空公司小图标
	UISubLabel *airlineLabel;// 航空公司
	UISubLabel *planeTypeLabel;//机型
	UISubLabel *cabinLabel; //舱位类型
	UISubLabel *cabinCodeLabel; //舱位码
	
	UISubLabel *departureLabel;//起飞城市
	UISubLabel *arrivalLabel;//降落城市
	
	UISubLabel *startTimeLabel; // 起飞时间
	UISubLabel *endTimeLabel; // 降落时间
	
	UISubLabel *startAirportLabel; // 起飞机场
	
	
	UISubLabel *endAirportLabel; // 降落机场 String

	
	UISubLabel *ticketPriceLabel; // 总金额
	
	UISubLabel *discountLabel; // 折扣
	
	UISubLabel *pushPriceLabel; // 推送价格
	UISubLabel *pushDiscountLabel; //推送折扣
	
	UISubLabel *pushCabinLabel; // 推送舱位类型
	UISubLabel *pushCabinCodeLabel;// 推送舱位码
	
	UISubLabel *savingLabel;//节省金额
	
	UISubLabel *createDateLabel;// 创建日期
	
	UIButton *callButton; //拨打电话;

	UIButton *pushRecordButton; //查看推送纪录;
	
	AutomaticallyInfo *automaticallyItem;
	

	
}

@property(nonatomic, retain) AutomaticallyInfo *automaticallyInfo;
@property(nonatomic, retain) NSMutableArray *pushDetailArray;
@end
