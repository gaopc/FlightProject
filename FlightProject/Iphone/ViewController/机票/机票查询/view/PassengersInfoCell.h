//
//  PassengersInfoCell.h
//  FlightProject
//
//  Created by green kevin on 12-9-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassengersInfoDelegate
@optional


-(void)editClick:(id)sender;//点击编辑按钮

@end

@interface PassengersInfoCell : UITableViewCell
{
	UIImageView *passengersBgView; //背景图片
	; //选择背景图片
	
	
@public
	UIImageView* _btnView;

}
@property (nonatomic,retain) id <PassengersInfoDelegate> delegate;
@property (nonatomic,retain) UISubLabel * name;
@property (nonatomic,retain) UISubLabel * identification;
@property (nonatomic,retain) UIImageView* btnView;
@property (nonatomic,retain) UIButton *editButton;
@property (nonatomic,retain) UIImageView *choiceImgView;
@end