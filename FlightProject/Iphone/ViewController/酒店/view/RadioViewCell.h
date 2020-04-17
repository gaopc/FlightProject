//
//  RadioViewCell.h
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioViewCell : UITableViewCell
{
	UIImageView *radioImgView; //选择背景图片
	
@public
	UIImageView* _btnView;

}
@property (nonatomic,retain) UISubLabel * name;
@property (nonatomic, retain) UIImageView* btnView;

@end
