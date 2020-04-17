//
//  CreditCardCell.h
//  FlightProject
//
//  Created by green kevin on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelCreditCardCell : UITableViewCell
{
	UIImageView *passengersBgView; //背景图片
	UIImageView *radioImgView; //选择背景图片
	
@public
	UIImageView* _btnView;
	
}

@property (nonatomic,retain) UISubLabel * name;
@property (nonatomic,retain) UISubLabel * bankIdCard;
@property (nonatomic,retain) UISubLabel * bank;
@property (nonatomic,assign)  UIButton *radioButton;
@property (nonatomic, retain) UIImageView* btnView;
@end

