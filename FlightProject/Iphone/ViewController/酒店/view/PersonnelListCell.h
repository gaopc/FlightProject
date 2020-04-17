//
//  PersonnelListCell.h
//  FlightProject
//
//  Created by green kevin on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonnelListDelegate
@optional


-(void)editClick:(id)sender;//点击编辑按钮

@end
@interface PersonnelListCell : UITableViewCell
{
	
	UIImageView *passengersBgView; //背景图片

@public
	UIImageView* _btnView;
	
}
@property (nonatomic,retain) id <PersonnelListDelegate> delegate;
@property (nonatomic,retain) UISubLabel * name;
@property (nonatomic,retain) UIImageView* btnView;
@property (nonatomic,retain) UIImageView *choiceImgView;
@end
