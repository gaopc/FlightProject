//
//  TicketAppointmentViewController.m
//  FlightProject
//
//  Created by 崔立东 on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  机票预约
//

#import "TicketAppointmentViewController.h"
#import "AppointmentSettingViewController.h"
#import "TicketAppointmentCell.h"
#import "MemberLoginViewController.h"
#import "TicketAppointmentDataResponse.h"
#import "AppointmentInfoViewController.h"
@interface TicketAppointmentViewController ()

//加载数据
- (void)loadDataSource;
- (void)loadAppointmentView;
@end

@implementation TicketAppointmentViewController
@synthesize t_tableView = _t_tableView;
@synthesize ticketAppDataArray = _ticketAppDataArray;



- (void)loadView{
	
	[super loadView];
	
	long origin_y = 3.0f;
    int offx = (ViewWidth - 320)/3;
	
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y, ViewWidth-10.0f, 28.0f)];
	[topView setImage:[UIImage imageNamed:@"appointmentFrameTop.png"]];
	[self.view addSubview:topView];
	
	tableTitleView = [[[UIView alloc]initWithFrame:CGRectMake(10.0f, 25.0f, ViewWidth-20.0f, 20.0f)]autorelease];
	tableTitleView.backgroundColor = [UIColor clearColor];
	
	
	UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"预约行程" frame:CGRectMake(16.0f, 1.0f, 50.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel1.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel1];
	
	UISubLabel *titleLabel2 = [UISubLabel labelWithTitle:@"预约航班周期" frame:CGRectMake(85.0f + offx, 1.0f, 70.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel2.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel2];
	
	UISubLabel *titleLabel3 = [UISubLabel labelWithTitle:@"预约折扣" frame:CGRectMake(165.0f + 2*offx, 1.0f, 50.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel3.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel3];
	
	UISubLabel *titleLabel4 = [UISubLabel labelWithTitle:@"提交日期" frame:CGRectMake(225.0f + 3*offx, 1.0f, 50.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel4.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel4];
	
	UIImageView *lineImageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]] autorelease];
	lineImageView.frame= CGRectMake(10.0f, 20.0f, tableTitleView.frame.size.width-20.0f, 1.0f);
	[tableTitleView addSubview:lineImageView];
	
	
	
	origin_y += (topView.frame.size.height+tableTitleView.frame.size.height)-3;
	
	_t_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,origin_y,ViewWidth,ViewHeight-204.0f) style:UITableViewStylePlain];  
	self.t_tableView.backgroundColor = [UIColor clearColor];
	self.t_tableView.dataSource = self;
	self.t_tableView.delegate = self;
	self.t_tableView.showsVerticalScrollIndicator=YES;
        self.t_tableView.separatorColor = [UIColor clearColor];
	
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y-tableTitleView.frame.size.height, ViewWidth-10.0f, self.t_tableView.frame.size.height+tableTitleView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"TicketQueryCenter.png"]];
	[self.view addSubview:centerView];
	[self.view addSubview:tableTitleView];
	//tableTitleView.hidden = YES;
	[self.view addSubview:self.t_tableView];
	
	noAppointmentView = [[NoAppointmentView alloc]initWithFrame:CGRectMake(0.0f, 28.0f, ViewWidth,ViewHeight-200.0f)];
	noAppointmentView.tag = 100;
	[self.view addSubview:noAppointmentView];
	noAppointmentView.hidden = YES;
	
	
	
	origin_y += self.t_tableView.frame.size.height;
	
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y, ViewWidth-10.0f, 18.0f)];
	[bottom setImage:[UIImage imageNamed:@"TicketQueryShadow.png"]];
	[self.view addSubview:bottom];
	
	origin_y +=12.0f;
	
	//提交预约按钮
	
	settingButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake((ViewWidth - 225)/2, origin_y, 225.5f, 45.0f) backImage:[UIImage imageNamed:@"AddAppointmentButton.png"] target:self action:@selector(appointment:)];
	[self.view addSubview:settingButton];
	
	
	
	
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	_ticketAppDataArray = [[NSMutableArray alloc] init];
//	if(![self isLogin])
//	{
//		MemberLoginViewController  * memberLoginVC = [[MemberLoginViewController alloc] init];
//		memberLoginVC.delegate = self;
//		[NavigationController pushViewController:memberLoginVC animated:YES];
//		[memberLoginVC release];	
//	}else {
//		
//		[self loginSuccessFul];
//	}
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	self.t_tableView = nil;
	self.ticketAppDataArray = nil;
	// Release any retained subviews of the main view.
}




- (void)dealloc
{
	[_t_tableView release];
	[_ticketAppDataArray release];
	[noAppointmentView release];
	[super dealloc];
}
//-(void) loginSuccessFul
//{
//	self.title = @"机票预约";
//	[self loadDataSource];
//}


//加载未预约页面
- (void)loadAppointmentView
{	
	[self.t_tableView reloadData];
	if(self.ticketAppDataArray.count>0) {
		noAppointmentView.hidden = YES;
		tableTitleView.hidden = NO;
	}else{
		noAppointmentView.hidden = NO ;
		tableTitleView.hidden = YES;
	}
}

//外部引用重新引用数据源
- (void) againQuoteDataSource
{
	[self loadDataSource];
}

//加载数据
- (void)loadDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass queryReservationList:[UserInfo sharedUserInfo].userID];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryReservationListPaseredResult:) Delegate:self needUserType:Member];
	
}

//返回处理
- (void)onqueryReservationListPaseredResult:(NSDictionary *)dic
{
	self.ticketAppDataArray = [TicketAppointmentDataResponse queryReservationList:dic];
	
	[self loadAppointmentView];
	
}

-(void)appointment:(id)sender
{
	AppointmentSettingViewController * appointmentSettingVC = [[AppointmentSettingViewController alloc] init];
	appointmentSettingVC->ticketAppointmentVC =self;
	[NavigationController pushViewController:appointmentSettingVC animated:YES];
	[appointmentSettingVC release];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
	// Return the number of rows in the section.
	return [self.ticketAppDataArray count] ; 
	//return 5;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 53.0f;
	
}


- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *cellIndentifierOnline=@"TicketAppointmentCell";
	TicketAppointmentCell *ticketAppointmentCell=(TicketAppointmentCell *)[self.t_tableView dequeueReusableCellWithIdentifier:cellIndentifierOnline];
	if (ticketAppointmentCell == nil){
		ticketAppointmentCell=[[[TicketAppointmentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil] autorelease];
		ticketAppointmentCell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	TicketAppointmentInfo *appointmentInfo = nil;
	appointmentInfo = (TicketAppointmentInfo *)[self.ticketAppDataArray objectAtIndex:indexPath.row];
	ticketAppointmentCell.flightLabel.text = appointmentInfo._departure;
	ticketAppointmentCell.arriveLabel.text = appointmentInfo._arrival;
	ticketAppointmentCell.flightDateLabel.text = appointmentInfo._starteDate;
	ticketAppointmentCell.arriveDateLabel.text = appointmentInfo._endDate;
	ticketAppointmentCell.saleLabel.text = [NSString stringWithFormat:@"%d",appointmentInfo._cabinDiscount];
	ticketAppointmentCell.submitDateLabel.text = appointmentInfo._createTime;
	return ticketAppointmentCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 0, 300, 53)];
	TicketAppointmentInfo *appointmentInfo = nil;
	appointmentInfo = (TicketAppointmentInfo *)[self.ticketAppDataArray objectAtIndex:indexPath.row];
	
	AppointmentInfoViewController * appointmentInfoVC = [[AppointmentInfoViewController alloc] init];
	appointmentInfoVC.ticketAppointmentInfo = appointmentInfo;
	appointmentInfoVC->ticketAppointmentVC = self;
	[NavigationController pushViewController:appointmentInfoVC animated:YES];
	[appointmentInfoVC release];
	
	
}



@end
