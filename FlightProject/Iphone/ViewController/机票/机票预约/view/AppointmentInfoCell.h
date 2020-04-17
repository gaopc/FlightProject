//
//  AppointmentInfoCell.h
//  FlightProject
//
//  Created by green kevin on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentInfoCell : UITableViewCell
{
	UIImageView *describeImg; //预约描述背图
	
}
@property (nonatomic, retain) UISubLabel *describeLabel;
@end
