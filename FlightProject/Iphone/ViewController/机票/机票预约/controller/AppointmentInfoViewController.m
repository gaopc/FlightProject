//
//  AppointmentInfoViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppointmentInfoViewController.h"
#import "TicketAppointmentDataResponse.h"
#import "AppointmentInfoView.h"
#import "AppointmentInfoCell.h"
#import "TicketAppointmentViewController.h"
@interface AppointmentInfoViewController ()
//加载数据
- (void)loadDataSource;
@end

@implementation AppointmentInfoViewController

@synthesize a_TableView = _a_TableView;
@synthesize ticketAppInfoDataArray;
@synthesize ticketAppointmentInfo;

- (void)loadView{
	
	[super loadView];
	
	long origin_y = 3.0f;
    int offWx = (ViewWidth - 320)/3;
	
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y, ViewWidth-10.0f, 28.0f)];
	[topView setImage:[UIImage imageNamed:@"appointmentFrameTop.png"]];
	[self.view addSubview:topView];
	
	UIView *tableTitleView = [[[UIView alloc]initWithFrame:CGRectMake(10.0f, 25.0f, ViewWidth-20.0f, 20.0f)]autorelease];
	tableTitleView.backgroundColor = [UIColor clearColor];
	
	
	UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"预约行程" frame:CGRectMake(22.0f, 1.0f, 50.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel1.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel1];
	
	UISubLabel *titleLabel2 = [UISubLabel labelWithTitle:@"预约航班周期" frame:CGRectMake(105.0f + offWx, 1.0f, 70.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel2.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel2];
	
	UISubLabel *titleLabel3 = [UISubLabel labelWithTitle:@"预约折扣" frame:CGRectMake(180.0f + 2*offWx, 1.0f, 50.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel3.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel3];
	
	UISubLabel *titleLabel4 = [UISubLabel labelWithTitle:@"提交日期" frame:CGRectMake(242.0f + 3*offWx, 1.0f, 50.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel4.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel4];
	
	UIImageView *lineImageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]] autorelease];
	lineImageView.frame= CGRectMake(10.0f, 20.0f, tableTitleView.frame.size.width-20.0f, 1.0f);
	[tableTitleView addSubview:lineImageView];
	
	origin_y += (topView.frame.size.height+tableTitleView.frame.size.height)-3;
	
	appointmentInfoView = [[AppointmentInfoView alloc]initWithFrame:CGRectMake(10.0f, origin_y, self.view.frame.size.width-20.0f, 53.0f)];
	appointmentInfoView.tag = 100;
	
	appointmentInfoView.flightLabel.text = ticketAppointmentInfo._departure;
	appointmentInfoView.arriveLabel.text = ticketAppointmentInfo._arrival;
	appointmentInfoView.flightDateLabel.text = ticketAppointmentInfo._starteDate;
	appointmentInfoView.arriveDateLabel.text = ticketAppointmentInfo._endDate;
	appointmentInfoView.saleLabel.text = [NSString stringWithFormat:@"%d",ticketAppointmentInfo._cabinDiscount];
	appointmentInfoView.submitDateLabel.text = ticketAppointmentInfo._createTime;
	
	

	
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y-tableTitleView.frame.size.height, ViewWidth-10.0f, appointmentInfoView.frame.size.height+tableTitleView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"TicketQueryCenter.png"]];
	[self.view addSubview:centerView];
	[self.view addSubview:tableTitleView];
	[self.view addSubview:appointmentInfoView];
	[appointmentInfoView release];
	
	origin_y += appointmentInfoView.frame.size.height;
	

	
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y, ViewWidth-10.0f, 18.0f)];
	[bottom setImage:[UIImage imageNamed:@"TicketQueryShadow.png"]];
	[self.view addSubview:bottom];
	
	origin_y += 15.0f;
	
	
	_a_TableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, origin_y, ViewWidth, ViewHeight-215.0f) style:UITableViewStylePlain];
	self.a_TableView.backgroundColor = [UIColor clearColor];
	self.a_TableView.dataSource = self;
	self.a_TableView.delegate = self;
	self.a_TableView.separatorColor = [UIColor clearColor];
	self.a_TableView.showsVerticalScrollIndicator=YES;
	[self.view addSubview:self.a_TableView];
	
	currentExpandSection = 0;          //默认第一个分组是展开的
	
    int offx = (ViewWidth - 313)/2;
	UIImageView *bottomImgView =[UIImageView ImageViewWithFrame:CGRectMake(offx, ViewHeight -44- 50, 313.0f, 38.0f)];
	bottomImgView.image=[UIImage imageNamed:@"appInfoBottom.png"];
	[self.view addSubview:bottomImgView];
	
	callButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"" frame:CGRectMake(offx + 5, ViewHeight -44- 48, 182.0f, 34.0f) backImage:[UIImage imageNamed:@"appInfoCallButton.png"] target:self action:@selector(call:)];
	[self.view addSubview:callButton];
	
	
	deleteButton = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"" frame:CGRectMake(offx + 192, ViewHeight -44- 48, 118.0f, 34.0f) backImage:[UIImage imageNamed:@"appInfoDelButton.png"] target:self action:@selector(delete:)];
	[self.view addSubview:deleteButton];
	
	[self loadDataSource];
	
	
}



- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"机票预约";
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	self.a_TableView = nil;
	// Release any retained subviews of the main view.
}


- (void)dealloc
{
	[_a_TableView release];
	self.ticketAppInfoDataArray = nil;
	[super dealloc];
}

//加载数据
- (void)loadDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass queryReservationDetail:[NSString stringWithFormat:@"%@",self.ticketAppointmentInfo._id]];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryReservationDetailPaseredResult:) Delegate:self needUserType:Member];
	
}



//返回处理
- (void)onqueryReservationDetailPaseredResult:(NSDictionary *)dic
{

        self.ticketAppInfoDataArray = [TicketAppointmentDataResponse queryReservationDetail:dic];
	[self.a_TableView reloadData];
	


}
//拨打客服电话
-(void)call:(id)sender
{
    [self callTel:@"400-6858-999"];
}

//删除机票预约
-(void)delete:(id)sender
{
	UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认删除机票预约么?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
	
        [alert show];
        [alert release];
	

}

- (void) alertView:(UIAlertView *)alertview clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if (buttonIndex==1) {
		ASIFormDataRequest * theRequest = [InterfaceClass deleteNewReservation:self.ticketAppointmentInfo._id];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelPaseredResult:) Delegate:self needUserType:Member];
	}
	
	
}


//返回删除处理
- (void)onDelPaseredResult:(NSDictionary *)dic
{
	[NavigationController popViewControllerAnimated:YES];
	[ticketAppointmentVC againQuoteDataSource];

}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
	// Return the number of sections.
	return [self.ticketAppInfoDataArray count];
}


//每个组中cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if( section == currentExpandSection ){
		return 1;
	}else{
		return 0;
	}
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 45.5f;
} 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 100.0f;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
		
	static NSString *cellIndentifierOnline=@"TicketAppointmentCell";
	AppointmentInfoCell *ticketAppointmentCell=(AppointmentInfoCell *)[self.a_TableView dequeueReusableCellWithIdentifier:cellIndentifierOnline];
	if (ticketAppointmentCell == nil){
		ticketAppointmentCell=[[[AppointmentInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil] autorelease];
		ticketAppointmentCell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	TicketAppointmentDesc *appointmentDesc = nil;
	appointmentDesc = (TicketAppointmentDesc *)[self.ticketAppInfoDataArray objectAtIndex:indexPath.row];
	ticketAppointmentCell.describeLabel.text = appointmentDesc._describe;
	
	CGSize expectedLabelSize = [ ticketAppointmentCell.describeLabel.text sizeWithFont: ticketAppointmentCell.describeLabel.font
						      constrainedToSize: ticketAppointmentCell.describeLabel.frame.size
							  lineBreakMode:NSLineBreakByTruncatingTail];
	
	CGRect newFrame = ticketAppointmentCell.describeLabel.frame;
	newFrame.size.height = expectedLabelSize.height;
	ticketAppointmentCell.describeLabel.frame = newFrame;
	ticketAppointmentCell.describeLabel.numberOfLines = 0;
	
	
	return ticketAppointmentCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
	view.backgroundColor = [UIColor clearColor];
	
	UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(view.bounds.origin.x+10.0f,view.bounds.origin.y,300.0f,45.5f)];
	bgView.userInteractionEnabled = YES;
	
	//每个cell的背景图片
	bgView.image =[UIImage imageNamed:@"HeaderInSection_A.png"];
	
	[view addSubview:bgView];
	
	TicketAppointmentDesc *appointmentDesc = nil;
	appointmentDesc = (TicketAppointmentDesc *)[self.ticketAppInfoDataArray objectAtIndex:section];

	
	UISubLabel *titleLabel = [UISubLabel labelWithTitle:@"[掌上航旅]机票预约信息: " frame:CGRectMake(10, 8, 180.0f, 30.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
	titleLabel.textColor = FontColor333333;
	[bgView addSubview:titleLabel];
	
	UISubLabel *dateLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(190, 13, 80.0f, 20.0f) font:FontSize24 alignment:NSTextAlignmentRight];
    dateLabel.adjustsFontSizeToFitWidth = YES;
	dateLabel.textColor = FontColor333333;
	dateLabel.text = appointmentDesc._date;
	[bgView addSubview:dateLabel];
	
	if( section == currentExpandSection ){
		bgView.image = [UIImage imageNamed:@"HeaderInSection_B.png"];
	}else {
		bgView.image = [UIImage imageNamed:@"HeaderInSection_A.png"];
	}
	

	[bgView release];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(0.0f, 0.0f, ViewWidth - 20, 45.0f) backImage:nil target:self action:@selector(expandOrFoldList:)];
	button.tag = section;
	[view addSubview: button];

	return view;
	
}

- (void)expandOrFoldList:(id)sender{
	UIButton *button = (UIButton *)sender;
	NSInteger section = button.tag;
	if( section != currentExpandSection ){
		currentExpandSection = section;
	}else{
		currentExpandSection = -1;
	}
	
	//rectForSection
	if (currentExpandSection != -1 && currentExpandSection != 0) {
		CGRect rect = [self.a_TableView rectForSection: currentExpandSection];
		
		[UIView beginAnimations: nil context: nil];
		[UIView setAnimationDuration: 0.5];
		[UIView setAnimationDelegate: self];
		[UIView setAnimationDidStopSelector: @selector( reloadDataForTableView: )];
		[self.a_TableView setContentOffset:CGPointMake( 0, rect.origin.y)];
		
		[UIView commitAnimations];
	}
	else  {
		[self.a_TableView reloadData];
	}

}

- (void)reloadDataForTableView:(NSInteger)section
{
	UIWindow *window = [(AppDelegate*)[UIApplication sharedApplication].delegate window];
	UIGraphicsBeginImageContext([UIScreen mainScreen].bounds.size);
	[window.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext(); 
	UIGraphicsEndImageContext();
	
	UIImageView *imageView = [[[UIImageView alloc] initWithImage: image] autorelease];
	imageView.frame = CGRectMake(0.0f, 0.0f, ViewWidth, ViewHeight);
	[window addSubview: imageView];
	
	[self.a_TableView reloadData];
	CGRect rect = [self.a_TableView rectForSection: currentExpandSection];
	

	
	[self.a_TableView setContentOffset:CGPointMake(0.0f, rect.origin.y)];
	[imageView removeFromSuperview];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

@end
