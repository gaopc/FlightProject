//
//  TicketAppointmentViewController.h
//  FlightProject
//
//  Created by 崔立东 on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  机票预约

#import <UIKit/UIKit.h>
#import "NoAppointmentView.h"
@class TicketAppointmentDataResponse;

@interface TicketAppointmentViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>
{
	
	 UIButton *settingButton; //预约设置按钮
	 TicketAppointmentDataResponse *appointmentData;
	  NoAppointmentView *noAppointmentView; //未预约提示说明
	UIView *tableTitleView;
      
}
@property (nonatomic,retain) UITableView *t_tableView; //机票预约 
@property(nonatomic, retain) NSMutableArray *ticketAppDataArray; //机票预约数组


//外部引用重新引用数据源
- (void) againQuoteDataSource;
@end
