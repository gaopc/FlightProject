//
//  NoAppointmentView.h
//  FlightProject
//
//  Created by 崔立东 on 12-9-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  未预约文字说明
//

#import <UIKit/UIKit.h>

@interface NoAppointmentView : UIView
{
	UISubLabel *noAppointmentTitleLabel;      //未预约说明标题
	UISubTextView *noAppointmentDirectionsLabel; //未预约说明内容
}
@end
