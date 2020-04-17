//
//  PushRecordViewController.m
//  FlightProject
//
//  Created by 崔立东 on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  历史推送纪录
//

#import "PushRecordViewController.h"
#import "PushRecordCell.h"
#import "AutomaticallyDataResponse.h"
@interface PushRecordViewController ()
// 计算自动降价折扣
- (NSString *) disCalculated:(NSString *)discount;
@end

@implementation PushRecordViewController
@synthesize pushRecordArray;
@synthesize p_tableView = _p_tableView;
@synthesize ticketPrice;
- (void)loadView{
	
	[super loadView];
	
	long origin_y = 3.0f;
	
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y, ViewWidth-10.0f, 28.0f)];
	[topView setImage:[UIImage imageNamed:@"appointmentFrameTop.png"]];
	[self.view addSubview:topView];
	
	
	UIView *tableTitleView = [[[UIView alloc]initWithFrame:CGRectMake(10.0f, 25.0f, ViewWidth-20.0f, 20.0f)]autorelease];
	tableTitleView.backgroundColor = [UIColor clearColor];
	
	
	UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"推送日期" frame:CGRectMake(22.0f, 1.0f, 50.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel1.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel1];
	
	UISubLabel *titleLabel2 = [UISubLabel labelWithTitle:@"票价 折扣" frame:CGRectMake((ViewWidth - 70)/2, 1.0f, 70.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentCenter];
	titleLabel2.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel2];
	
	UISubLabel *titleLabel3 = [UISubLabel labelWithTitle:@"换票可省" frame:CGRectMake(ViewWidth - 90, 1.0f, 50.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel3.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel3];
	
	
	UIImageView *lineImageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]] autorelease];
	lineImageView.frame= CGRectMake(10.0f, 20.0f, tableTitleView.frame.size.width-20.0f, 1.0f);
	[tableTitleView addSubview:lineImageView];
	
	origin_y += (topView.frame.size.height+tableTitleView.frame.size.height)-3;
	
	_p_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,origin_y,ViewWidth,ViewHeight-125.0f) style:UITableViewStylePlain];  
	self.p_tableView.backgroundColor = [UIColor clearColor];
	self.p_tableView.dataSource = self;
	self.p_tableView.delegate = self;
	self.p_tableView.showsVerticalScrollIndicator=YES;
	self.p_tableView.separatorColor = [UIColor clearColor];
	
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y-tableTitleView.frame.size.height, ViewWidth-10.0f, self.p_tableView.frame.size.height+tableTitleView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"TicketQueryCenter.png"]];
	[self.view addSubview:centerView];
	[self.view addSubview:tableTitleView];
	[self.view addSubview:self.p_tableView];
	
	origin_y += self.p_tableView.frame.size.height;
	
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(5.0f, origin_y, ViewWidth-10.0f, 18.0f)];
	[bottom setImage:[UIImage imageNamed:@"TicketQueryShadow.png"]];
	[self.view addSubview:bottom];
}



- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"历史推荐记录";
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	self.p_tableView = nil;
	// Release any retained subviews of the main view.
}

- (void)dealloc
{
	self.pushRecordArray = nil;
	[_p_tableView release];
	[super dealloc];
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
	return [self.pushRecordArray count] ; 
	//return 15;
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 53.0f;
	
}


- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *cellIndentifierOnline=@"PushRecordCell";
	PushRecordCell *pushRecordCell=(PushRecordCell *)[self.p_tableView dequeueReusableCellWithIdentifier:cellIndentifierOnline];
	if (pushRecordCell == nil){
		pushRecordCell=[[[PushRecordCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil] autorelease];
		pushRecordCell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	PushDetailInfo *pushDetailInfo =nil;
	pushDetailInfo = (PushDetailInfo *)[self.pushRecordArray objectAtIndex:indexPath.row];
        pushRecordCell.dateLabel.text = pushDetailInfo._date;
        pushRecordCell.priceLabel.text = [NSString stringWithFormat:@"%d",[pushDetailInfo._price intValue]];
	pushRecordCell.priceDiscount.text = [self disCalculated:pushDetailInfo._discount];
	pushRecordCell.savingLabel.text = [NSString stringWithFormat:@"%d", [pushDetailInfo._savingPrice intValue]];
	
	return pushRecordCell;
}


// 计算自动降价折扣
- (NSString *) disCalculated:(NSString *)discount
{
	NSString *fd  = @"";
	float _discount = [discount floatValue]/100;
	if(_discount < 1.0){
		fd = [NSString stringWithFormat:@"(%.1f%@)",_discount*10,@"折"];
	}else if(_discount > 1.0){
		fd = [NSString stringWithFormat:@"%@%@", discount, @"%"];
	}else if(_discount == 1.0){
		fd = [NSString stringWithFormat:@"(%@)",@"全价"];
	}
	return fd;
	
}




@end
