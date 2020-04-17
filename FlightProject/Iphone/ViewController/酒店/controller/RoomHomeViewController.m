//
//  HotelRoomHomeViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoomHomeViewController.h"

#import "RoomListViewController.h"
#import "RoomIntroViewController.h"
#import "RoomCommViewController.h"
#import "RoomPicViewController.h"
#import "RoomMapViewController.h"
#import "HotelCollectDataResponse.h"
#import "InterfaceClass.h"
#import "ASIFormDataRequest.h"
@interface RoomHomeViewController ()

@end

@implementation RoomHomeViewController
@synthesize activeView,preView,ticketDelegate,roomListArray,hotelInfo,picUrlArray,startDay,endDay,cityName;
@synthesize lcdRate,lcdValue,lcdActivityId;

-(void)dealloc
{
	self.preView = nil;
	self.ticketDelegate = nil;
	self.activeView = nil;
	
	self.roomListArray = nil;
	self.hotelInfo = nil;
	self.picUrlArray = nil;
	self.cityName = nil;
	self.startDay = nil;
	self.endDay = nil;
	self.lcdRate = nil;
	self.lcdValue = nil;
	self.lcdActivityId = nil;
	[super dealloc];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	UIButton  * rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:100 title:nil frame:CGRectMake(10, 7, 57, 30) backImage:[UIImage imageNamed:@"CollectButtonRight.png"] target:self action:@selector(hotelCollect:)];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
	self.navigationItem.rightBarButtonItem = rightBar;
	[rightBar release];
	if (self.hotelInfo._isCollection) 

		rightButton.enabled = NO;
	else
		rightButton.enabled = YES;
	

	
	UIView * activeV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44)];
	activeV.backgroundColor = [UIColor clearColor];
	[self.view addSubview:activeV];
	[activeV release];
	self.activeView = activeV;
	
	NSMutableArray *hotelArray = [[NSMutableArray alloc] initWithObjects:self.hotelInfo, nil];
	
	
	RoomListViewController * roomListVC = [[RoomListViewController alloc] init];
	
	roomListVC.roomListArray= self.roomListArray;
	roomListVC.hotelInfo = self.hotelInfo;
	roomListVC.startDay = self.startDay;
	roomListVC.endDay = self.endDay;
	roomListVC.cityName = self.cityName;
	roomListVC.lcdRate = self.lcdRate;
	roomListVC.lcdValue = self.lcdValue;
	roomListVC.lcdActivityId = self.lcdActivityId;
	RoomIntroViewController * roomIntroVC = [[RoomIntroViewController alloc] init];
	roomIntroVC.hotelInfo= self.hotelInfo;
	
	
	RoomCommViewController * roomCommVC = [[RoomCommViewController alloc] init];
	roomCommVC.hotelInfo = self.hotelInfo;
	RoomPicViewController * roomPicVC = [[RoomPicViewController alloc] init];
	roomPicVC.picUrlArray = self.picUrlArray;
	roomPicVC.hotelInfo = self.hotelInfo;
	RoomMapViewController * roomMapVC = [[RoomMapViewController alloc] init];
	roomMapVC._mapInfoArray = hotelArray;
	[hotelArray release];
	roomListVC.title = self.hotelInfo._hotelName;
	roomIntroVC.title = self.hotelInfo._hotelName;
	roomCommVC.title = self.hotelInfo._hotelName;
	roomPicVC.title = self.hotelInfo._hotelName;
	roomMapVC.title = self.hotelInfo._hotelName;
	self.ticketDelegate = roomListVC;
	
	self.title = self.hotelInfo._hotelName;
	[self.activeView addSubview:roomListVC.view];
	roomListVC.view.frame = self.activeView.frame;
	self.preView = roomListVC.view;
	
	tabbarV = [[CustomTabbarView alloc] initWithFrame:CGRectMake(0, ViewHeight-44-44, ViewWidth, 44)];
	tabbarV.viewControllers = [NSArray arrayWithObjects:roomListVC,roomIntroVC,roomCommVC,roomPicVC,roomMapVC, nil];
	NSMutableArray * defultImages = [NSMutableArray array];
	NSMutableArray * selectedImages = [NSMutableArray array];
	for (int i=0; i<5; i++) {
		[defultImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"RoomTabbar%d-0.png",i]]];
		[selectedImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"RoomTabbar%d-1.png",i]]];
	}
	tabbarV.defultImages = defultImages;
	tabbarV.selectedImages = selectedImages;
	tabbarV.tabbarDelegate = self;
	[self.view addSubview:tabbarV];
	[tabbarV release];
}

-(void)customTabbarViewDidSelectViewController:(UIViewController *)viewController
{
	self.ticketDelegate = viewController;
	NSInteger index = [tabbarV.viewControllers indexOfObject:self.ticketDelegate];
	[tabbarV changSelectedV:index+1];
	self.title = viewController.title;
	[self.preView removeFromSuperview];
	[self.activeView addSubview:viewController.view];
	viewController.view.frame = self.activeView.frame;
	self.preView = viewController.view;
}

- (void)hotelCollect:(id)sender
{
	self._VCType = Member;
	if (self.isLogin) {
		[self loginSuccessFul];
	}
}

- (void)loginSuccessFul
{
	ASIFormDataRequest * theRequest = [InterfaceClass collection:[UserInfo sharedUserInfo].userID withHotelId:self.hotelInfo._hotelId];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onAddCollectResult:) Delegate:self needUserType:Member];
	

}


- (void)onAddCollectResult:(NSDictionary *)dic
{
	
	UIBarButtonItem *button = self.navigationItem.rightBarButtonItem;
	
	NSString *message = [HotelCollectDataResponse hotelCollectAddMessage:dic];
	if ([[dic objectForKey:@"statusCode"] isEqualToString:@"0" ]) {
		button.enabled = NO;
	}
	[UIAlertView alertViewWithMessage:message];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}






@end
