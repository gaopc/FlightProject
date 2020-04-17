//
//  AppointmentInfoViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
@class TicketAppointmentDataResponse;
@class TicketAppointmentInfo;
@class AppointmentInfoView;
@class TicketAppointmentViewController;
@interface AppointmentInfoViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
	TicketAppointmentDataResponse *appointmentData;
	AppointmentInfoView *appointmentInfoView;
	NSInteger currentExpandSection;
	UIView *hintView;
	
	UIButton *callButton; //拨打电话;
	UIButton *deleteButton; //删除;
@public
	TicketAppointmentViewController *ticketAppointmentVC;
	
}
@property (nonatomic,retain) UITableView *a_TableView; //机票预约详情
@property(nonatomic, retain) NSMutableArray *ticketAppInfoDataArray; //机票预约详情数组
@property (nonatomic,retain) TicketAppointmentInfo *ticketAppointmentInfo; //机票预约
@end
