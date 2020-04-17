//
//  PushRecordCell.h
//  FlightProject
//
//  Created by 崔立东 on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  历史推送纪录Cell
//

#import <UIKit/UIKit.h>

@interface PushRecordCell : UITableViewCell
{
	UISubLabel *dateLabel;//推送日期
	UISubLabel *priceLabel;//推送价格
	UISubLabel *priceDiscount;//推送折扣
	UISubLabel *savingLabel; //节省价格
}

@property (nonatomic, retain) UISubLabel *dateLabel;
@property (nonatomic, retain) UISubLabel *priceLabel;
@property (nonatomic, retain) UISubLabel *priceDiscount;
@property (nonatomic, retain) UISubLabel *savingLabel;

@end
