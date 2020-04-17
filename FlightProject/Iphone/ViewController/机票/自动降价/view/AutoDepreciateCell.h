//
//  AutoDepreciateCell.h
//  FlightProject
//
//  Created by 崔立东 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  自动降价列表Cell
//

#import <UIKit/UIKit.h>

@interface AutoDepreciateCell : UITableViewCell
{
	UIImageView *flightSmallIcons; //起飞小图标
	UIImageView *arriveSmallIcons; //到达小图标
		
}

@property (nonatomic, retain) UISubLabel *flightLabel;
@property (nonatomic, retain) UISubLabel *arriveLabel;
@property (nonatomic, retain) UISubLabel *flightNOLabel;
@property (nonatomic, retain) UISubLabel *arriveDateLabel;

@property (nonatomic, retain) UISubLabel *pushTimeLabel;
@property (nonatomic, retain) UISubLabel *submitDateLabel;
@end
