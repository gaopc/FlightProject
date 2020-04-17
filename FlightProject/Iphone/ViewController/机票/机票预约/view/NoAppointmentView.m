//
//  NoAppointmentView.m
//  FlightProject
//
//  Created by 崔立东 on 12-9-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  未预约文字说明
//

#import "NoAppointmentView.h"

@implementation NoAppointmentView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		self.backgroundColor = [UIColor clearColor];   
		
		noAppointmentTitleLabel = [UISubLabel labelWithTitle:@"您还没有预约机票" frame:CGRectMake(70, 20, 180, 22)font:FontSize40 alignment:NSTextAlignmentCenter];
		noAppointmentTitleLabel.backgroundColor = [UIColor clearColor];
		noAppointmentTitleLabel.textColor = FontColorFF8813;
		[self addSubview:noAppointmentTitleLabel];
		
//		UIImageView *lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(22.0f, 48.0f, 275.5f, 1.0f)];
//		[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
//		[self addSubview:lineImageView];
		
		NSString *directions =@"    您可以提前预约符合您预期的特价机票，掌上航旅会通过电子邮件或短信的形式通知您，节省您寻找低价机票上的宝贵时间和精力。\n    您可以预约三个月之内，时段为七天之内的同一行程，同一折扣以下，同一起飞时段的机票。";
		noAppointmentDirectionsLabel = [[UISubTextView alloc] initWithFrame:CGRectMake(10, 50, 300, self.frame.size.height - 80.0f)];
		//noAppointmentDirectionsLabel = [UISubLabel labelWithTitle:directions frame:CGRectMake(30, 60, 260, 160) font:FontSize30 alignment:NSTextAlignmentLeft];    
		noAppointmentDirectionsLabel.textColor = FontColor454545;
		noAppointmentDirectionsLabel.font = FontSize30;
		noAppointmentDirectionsLabel.editable = NO;
		noAppointmentDirectionsLabel.userInteractionEnabled = NO;
		noAppointmentDirectionsLabel.text = directions;
		noAppointmentDirectionsLabel.backgroundColor = [UIColor clearColor];
		

		
		[self addSubview:noAppointmentDirectionsLabel];
	}
	return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
