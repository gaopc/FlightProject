//
//  PassengersAddressCell.h
//  FlightProject
//
//  Created by lidong  cui on 12-10-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassengersAddressDelegate
@optional


-(void)editClick:(id)sender;//点击编辑按钮

@end

@interface PassengersAddressCell : UITableViewCell <UITextViewDelegate>
{
	UIImageView *passengersBgView; //背景图片
	UIImageView *radioImgView; //选择背景图片
	
@public
	UIImageView* _btnView;
	
}
@property (nonatomic, assign) id <PassengersAddressDelegate> delegate;
@property (nonatomic,retain) UISubLabel * name;
@property (nonatomic,retain) UISubLabel * postCode;
@property (nonatomic,retain) UISubTextView * postAddress;

@property (nonatomic,assign)  UIButton *radioButton;
@property (nonatomic,assign)  UIButton *editButton;

@property (nonatomic, retain) UIImageView* btnView;

@property (nonatomic,retain)  UIView *passView;
@property (nonatomic,retain)  UIView *mainView;

@property (nonatomic,retain) UISubLabel * mainName;
@property (nonatomic,retain) UISubLabel * mainPostCode;
@property (nonatomic,retain) UISubTextView * mainPostAddress;
@end

