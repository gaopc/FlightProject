//
//  AutoDepreciateViewController.m
//  FlightProject
//
//  Created by longcd on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AutoDepreciateViewController.h"
#import "AutoDepreciateCell.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "AutomaticallyDataResponse.h"
#import "NoAutoDpreciateView.h"
#import "DepreciateInfoViewController.h"
#import "MemberLoginViewController.h"

@interface AutoDepreciateViewController ()
//加载数据
- (void)loadDataSource;
- (void)loadDataSourceByTicketNo:(NSString *)ticketNo;
@end

@implementation AutoDepreciateViewController
@synthesize autoDeprelist = _autoDeprelist;
@synthesize a_tableView = _a_tableView;



- (void)loadView{
	
	[super loadView];
		
	long origin_y = 3.0f;
	
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y, ViewWidth-10.0f, 28.0f)];
	[topView setImage:[UIImage imageNamed:@"appointmentFrameTop.png"]];
	[self.view addSubview:topView];
	
	origin_y += topView.frame.size.height;
	
        UIView *cutTipView = [[UIView alloc]initWithFrame:CGRectMake(5.0f, origin_y, ViewWidth-20.0f, 43.0f)];
	cutTipView.backgroundColor = [UIColor clearColor];
	
	
	UIImageView *cutTipImageView = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, 243.0f , 43.0f)];
	[cutTipImageView setImage:[UIImage imageNamed:@"CutTip.png"]];
	[cutTipView addSubview:cutTipImageView];
	
	UISubLabel *cutTipTitleLabel = [UISubLabel labelWithTitle:@"累计节省畅达币:" frame:CGRectMake(22.0f, 0.0f, 125.0f, 40.0f) font:FontSize28 alignment:NSTextAlignmentLeft];
	cutTipTitleLabel.textColor = FontColorFFFFFF;
	[cutTipView addSubview:cutTipTitleLabel];
	
	UISubLabel *falgTitleLabel = [UISubLabel labelWithTitle:@"￥" frame:CGRectMake(148.0f, 15.0f, 15.0f, 15.0f) font:FontSize18 alignment:NSTextAlignmentLeft];
	falgTitleLabel.textColor = FontColorFFFFFF;
	//[cutTipView addSubview:falgTitleLabel];
	
	cutTipNumberLabel = [UISubLabel labelWithTitle:@"0" frame:CGRectMake(160.0f, 2.0f, 60.0f, 35.0f) font:FontSize48 alignment:NSTextAlignmentLeft];
	cutTipNumberLabel.textColor = FontColorFFFFFF;
	
	[cutTipView addSubview:cutTipNumberLabel];
	
	origin_y += cutTipView.frame.size.height;
	
	
	tableTitleView = [[[UIView alloc]initWithFrame:CGRectMake(10.0f, origin_y, ViewWidth-20.0f, 20.0f)]autorelease];
	tableTitleView.backgroundColor = [UIColor clearColor];
	
	
    int offx = (ViewWidth - 320)/3;
	UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"起降城市" frame:CGRectMake(18.0f, 1.0f, 50.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel1.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel1];
	
	UISubLabel *titleLabel2 = [UISubLabel labelWithTitle:@"航班号/起飞日期" frame:CGRectMake(70.0f + offx, 1.0f, 90.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel2.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel2];
	
	UISubLabel *titleLabel3 = [UISubLabel labelWithTitle:@"推送次数" frame:CGRectMake(160.0f + 2*offx, 1.0f, 50.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel3.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel3];
	
	UISubLabel *titleLabel4 = [UISubLabel labelWithTitle:@"提交日期" frame:CGRectMake(230.0f + 3*offx, 1.0f, 50.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel4.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel4];
	
	UIImageView *lineImageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]] autorelease];
	lineImageView.frame= CGRectMake(10.0f, 20.0f, tableTitleView.frame.size.width-20.0f, 1.0f);
	[tableTitleView addSubview:lineImageView];
	
	
	origin_y += tableTitleView.frame.size.height;

	
	_a_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,origin_y,ViewWidth,ViewHeight-200.0f) style:UITableViewStylePlain];  

	self.a_tableView.backgroundColor = [UIColor clearColor];
	self.a_tableView.dataSource = self;
	self.a_tableView.delegate = self;
	self.a_tableView.showsVerticalScrollIndicator=YES;
	self.a_tableView.separatorColor = [UIColor clearColor];

	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, 31.0f, ViewWidth - 10, cutTipView.frame.size.height+tableTitleView.frame.size.height+self.a_tableView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"TicketQueryCenter.png"]];
	[self.view addSubview:centerView];
	[self.view addSubview:tableTitleView];
	tableTitleView.hidden = YES;
	[self.view addSubview:cutTipView];
	[cutTipView release];
	
	[self.view addSubview:self.a_tableView];
	noAutoDpreciateView = [[NoAutoDpreciateView alloc]initWithFrame:CGRectMake(0.0f, 80.0f, ViewWidth, ViewHeight-185.0f)];
	noAutoDpreciateView.tag = 100;
	[self.view addSubview:noAutoDpreciateView];
	
	[noAutoDpreciateView release];

	
	
	origin_y += self.a_tableView.frame.size.height;
	
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y, ViewWidth - 10, 18.0f)];
	[bottom setImage:[UIImage imageNamed:@"TicketQueryShadow.png"]];
	[self.view addSubview:bottom];
	
	
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     _autoDeprelist = [[NSMutableArray alloc] init];
    
//    if(![self isLogin])
//    {
//	MemberLoginViewController  * memberLoginVC = [[MemberLoginViewController alloc] init];
//        memberLoginVC.delegate = self;
//	[NavigationController pushViewController:memberLoginVC animated:YES];
//	[memberLoginVC release];	
//    }else {
//	    
//        [self loginSuccessFul];
//    }

	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	self.a_tableView = nil;
	self.autoDeprelist = nil;

}
- (void)dealloc
{
	[_autoDeprelist release];
	[_a_tableView release];
	[super dealloc];
}

//加载自动降价说明
- (void)loadAppointmentView
{	
	[self.a_tableView reloadData];
	if(self.autoDeprelist.count>0) {
		noAutoDpreciateView.hidden = YES;
		tableTitleView.hidden = NO;
	}else{ 
		noAutoDpreciateView.hidden = NO ;
		tableTitleView.hidden = YES;
	}
}



//加载数据
- (void)loadDataSourceByTicketNo:(NSString *)ticketNo
{
	ASIFormDataRequest * theRequest = [InterfaceClass queryAutomaticallyDroppedDetail:ticketNo]; 
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onTicketPaseredResult:) Delegate:self needUserType:Member];
	
}

//外部引用重新引用数据源
- (void) againQuoteDataSource
{
	[self loadDataSource];
}

//加载数据
- (void)loadDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass queryNewAutomaticallyDroppedList:[UserInfo sharedUserInfo].userID]; //测试的UserID 69659 [UserInfo sharedUserInfo].userID
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryNewAutomaticallyDroppedListPaseredResult:) Delegate:self needUserType:Member];
	
}




//加载成功
- (void)onqueryNewAutomaticallyDroppedListPaseredResult:(NSDictionary *)dic
{
	automaticallyDR = [AutomaticallyDataResponse queryAutomaticallyDroppedList:dic];
	self.autoDeprelist = automaticallyDR._autoMaticallyArray;
	cutTipNumberLabel.text = [NSString stringWithFormat:@"%d",automaticallyDR._cumulationPrice];
	[self loadAppointmentView];

}

//加载成功
- (void)onTicketPaseredResult:(NSDictionary *)dic
{
	AutomaticallyDataResponse *automatically = [AutomaticallyDataResponse queryAutomaticallyDroppedDetail:dic];
	automaticallyItem = automatically._automaticallyInfo;
	automaticallyItem._departure = automaticallyInfo._departure;
	automaticallyItem._arrival = automaticallyInfo._arrival;
	automaticallyItem._flightNo = automaticallyInfo._flightNo;
	automaticallyItem._createDate = automaticallyInfo._createDate;
	automaticallyItem._startDate = automaticallyInfo._startDate;
	DepreciateInfoViewController *autoDereciateVC = [[DepreciateInfoViewController alloc] init];
	autoDereciateVC.automaticallyInfo = automaticallyItem;
	autoDereciateVC.pushDetailArray = automatically._pushDetailArray;
	[NavigationController pushViewController:autoDereciateVC animated:YES];
	[autoDereciateVC release];

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
	return [self.autoDeprelist count] ; 
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 53.0f;
	
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *cellIndentifierOnline=@"AutoDepreciateCell";
	AutoDepreciateCell *autoDepreciateCell=(AutoDepreciateCell *)[self.a_tableView dequeueReusableCellWithIdentifier:cellIndentifierOnline];
	

	
	if (autoDepreciateCell == nil){
		autoDepreciateCell=[[[AutoDepreciateCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil] autorelease];
		autoDepreciateCell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	AutomaticallyInfo *autoInfo = nil;
	autoInfo = (AutomaticallyInfo *)[self.autoDeprelist objectAtIndex:indexPath.row];
	autoDepreciateCell.flightLabel.text = autoInfo._departure;
	autoDepreciateCell.arriveLabel.text = autoInfo._arrival;
	autoDepreciateCell.flightNOLabel.text =autoInfo._flightNo; 
	autoDepreciateCell.pushTimeLabel.text = autoInfo._pushTime;
	autoDepreciateCell.submitDateLabel.text = autoInfo._createDate;
	autoDepreciateCell.arriveDateLabel.text = autoInfo._startDate;
	
	return autoDepreciateCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 0, 300, 53)];
	automaticallyInfo = (AutomaticallyInfo *)[self.autoDeprelist objectAtIndex:indexPath.row];
	if([automaticallyInfo._pushTime intValue]==0)
		[UIAlertView alertViewWithMessage:@"恭喜您，您买到了当前最低价的票!" :@"提示"];
	else
		[self loadDataSourceByTicketNo:automaticallyInfo._ticketNo];
}

@end
