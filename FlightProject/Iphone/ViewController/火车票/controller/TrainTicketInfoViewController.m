//
//  TrainTicketInfoViewController.m
//  FlightProject
//
//  Created by green kevin on 13-1-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "TrainTicketInfoViewController.h"
#import "StationInfoCell.h"
#import "TrainListInfo.h"
@interface TrainTicketInfoViewController ()
- (UIView *)trainTicketPriceView;
- (int)loadTicketPriceData;
@end

@implementation TrainTicketInfoViewController
@synthesize fromStationLabel,toStationLabel,fromTimeLabel,toTimeLabel,thatDayLabel,mileageLabel,durationLabel;
@synthesize ticketPriceDict,fromStation,toStation;
@synthesize s_tableView,stationInfoArray,trainListInfo,ticketPriceViewA,ticketPriceViewB,searchType;
-(void)dealloc
{
	self.fromStationLabel = nil;
	self.toStationLabel = nil;
	self.fromTimeLabel = nil;
	self.toTimeLabel = nil;
	self.thatDayLabel = nil;
	self.mileageLabel = nil;
	self.durationLabel = nil;
	
	self.stationInfoArray = nil;
	self.ticketPriceDict = nil;
	
	self.ticketPriceViewA = nil;
	self.ticketPriceViewB = nil;
	
	self.fromStation = nil;
	self.toStation = nil;
	self.searchType = nil;
	self.s_tableView = nil;
	self.trainListInfo = nil;
	[super dealloc];
}

- (void)loadView{
	
	[super loadView];
	
	
	//车站信息视图
	[self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 10, ViewWidth-20, 100) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
	[self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 110, ViewWidth-20, 18) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
	
	[self.view addSubview:[UISubLabel labelWithTitle:@"出发站" frame:CGRectMake(50.0f, 15.0f, 60.0f, 20.0f) font:FontSize26 color:FontColor454545 alignment:NSTextAlignmentLeft]];
	self.fromStationLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(15.0f, 35.0f, 110.0f, 30.0f) font:FontBlodSize38 color:FontColor333333 alignment:NSTextAlignmentCenter];
	[self.view addSubview:fromStationLabel];
	
	[self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-190, 48, ViewWidth-260, 5) image:[UIImage imageNamed:@"StationsMarked.png"]]];
	
	[self.view addSubview:[UISubLabel labelWithTitle:@"到达站" frame:CGRectMake(ViewWidth-90, 15.0f, 60.0f, 20.0f) font:FontSize24 color:FontColor454545 alignment:NSTextAlignmentLeft]];
	self.toStationLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-125, 35.0f, ViewWidth-210, 30.0f) font:FontBlodSize38 color:FontColor333333 alignment:NSTextAlignmentCenter];
	[self.view addSubview:toStationLabel];
	
	
	self.fromTimeLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(50.0f, 62.0f, 60.0f, 25.0f) font:FontBlodSize32 color:FontColor1C7CBC alignment:NSTextAlignmentLeft];
	[self.view addSubview:self.fromTimeLabel];
	
	self.toTimeLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-92, 62.0f, 60.0f, 25.0f) font:FontBlodSize32 color:FontColor1C7CBC alignment:NSTextAlignmentLeft];
	[self.view addSubview:self.toTimeLabel];
	
	self.thatDayLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-48, 65.0f, 35.0f, 22.0f) font:FontSize22 color:FontColor1C7CBC alignment:NSTextAlignmentLeft];
	[self.view addSubview:self.thatDayLabel];
	
	
	[self.view addSubview:[UISubLabel labelWithTitle:@"里程" frame:CGRectMake(25.0f, 90.0f, 30.0f, 20.0f) font:FontSize24 color:FontColor454545 alignment:NSTextAlignmentLeft]];
	
	self.mileageLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(55.0f, 88.0f, 100.0f, 25.0f) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
	[self.view addSubview:self.mileageLabel];
	
	
	
	[self.view addSubview:[UISubLabel labelWithTitle:@"历时" frame:CGRectMake(ViewWidth-125, 90.0f, 30.0f, 20.0f) font:FontSize24 color:FontColor454545 alignment:NSTextAlignmentLeft]];
	
	self.durationLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-95, 88.0f, 100.0f, 25.0f) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
	[self.view addSubview:self.durationLabel];
	
	float tableheight = ViewHeight-288.0f;
	float topviewy = 214.0f;
	float centerviewy = 218;
	float tabletitleviewy = 216;
	float tabley = 236.0f;
	int ticketheight = [self loadTicketPriceData];
	if (ticketheight == 0) {
		
		tableheight = tableheight + 80.0f;
		tabley = tabley - 80.0f;
		topviewy = topviewy - 80.0f;
		centerviewy = centerviewy - 80.0f;
		tabletitleviewy = tabletitleviewy - 80.0f;
	}else{
		[self.view addSubview:[self trainTicketPriceView]];
	}
	
	
	
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, topviewy, ViewWidth-20.0f, 7.0f)] ;
	[topView setImage:[UIImage imageNamed:@"MemberLoginTop.png"]];
	[self.view addSubview:topView];
	
	
	UIView *tableTitleView = [[UIView alloc]initWithFrame:CGRectMake(10.0f, tabletitleviewy, ViewWidth-20.0f, 20.0f)];
	tableTitleView.backgroundColor = [UIColor clearColor];
	
	
	UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"车站" frame:CGRectMake(28.0f, 1.0f, 50.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel1.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel1];
	
	UISubLabel *titleLabel2 = [UISubLabel labelWithTitle:@"到达" frame:CGRectMake(ViewWidth-197, 1.0f, 90.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel2.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel2];
	
	UISubLabel *titleLabel3 = [UISubLabel labelWithTitle:@"出发" frame:CGRectMake(ViewWidth-154, 1.0f, 50.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel3.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel3];
	
	UISubLabel *titleLabel4 = [UISubLabel labelWithTitle:@"停车" frame:CGRectMake(ViewWidth-104, 1.0f, 30.0f, 20.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	titleLabel4.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel4];
	
	[tableTitleView addSubview:[UISubLabel labelWithTitle:@"里程(KM)" frame:CGRectMake(ViewWidth-72, 1.0f, 50.0f, 20.0f) font:FontSize22 color:FontColor454545 alignment:NSTextAlignmentLeft]];
	
	
	UIImageView *lineImageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]] autorelease];
	lineImageView.frame= CGRectMake(10.0f, 20.0f, tableTitleView.frame.size.width-20.0f, 1.0f);
	//[tableTitleView addSubview:lineImageView];
	
	
	UITableView *aTable =[[UITableView alloc] initWithFrame:CGRectMake(0.0f ,tabley,ViewWidth,tableheight) style:UITableViewStylePlain];  
	self.s_tableView = aTable;
	[aTable release];
	self.s_tableView.backgroundColor = [UIColor clearColor];
	self.s_tableView.dataSource = self;
	self.s_tableView.delegate = self;
	self.s_tableView.showsVerticalScrollIndicator=YES;
	self.s_tableView.separatorColor = [UIColor clearColor];
	
	
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f,centerviewy,ViewWidth-20.0f, self.s_tableView.frame.size.height+20)];
	[centerView setImage:[UIImage imageNamed:@"MemberLoginCenter.png"]];
	[self.view addSubview:centerView];
	[self.view addSubview:tableTitleView];
	[tableTitleView release];
        [self.view addSubview:self.s_tableView];
	
	
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, self.s_tableView.frame.size.height + 234, ViewWidth-20.0f, 7.0f)];
	[bottom setImage:[UIImage imageNamed:@"MemberLoginBottom.png"]];
	[self.view addSubview:bottom];
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	float dy=0.f;
	rowday2 = 0;
	rowday3 = 0;
	rowday4 = 0;
	indexstar = -1;
	indexend = -1;
	indexDay1 = -1;
	indexDay2 = -1;
	indexDay3 = -1;
	
	
	
	for (int i =0; i<self.stationInfoArray.count; i++) {
		
		SearchTrainDetail *searchInfo = [self.stationInfoArray objectAtIndex:i];
		//NSString *stationName = [self.searchType isEqualToString:@"1"]?searchInfo._stationName:[NSString stringWithFormat:@"%@站" ,searchInfo._stationName];
		
		if ([[self.searchType isEqualToString:@"1"]?searchInfo._stationName:[NSString stringWithFormat:@"%@站" ,searchInfo._stationName] isEqualToString:self.trainListInfo._originatingStation])
		{
			indexstar = i;
		}
		
		if ([[self.searchType isEqualToString:@"1"]?searchInfo._stationName:[NSString stringWithFormat:@"%@站" ,searchInfo._stationName] isEqualToString:self.trainListInfo._terminalStation])
		{
			indexend = i;
		}
		
		if ([searchInfo._days isEqualToString:@"2"])
		{
			if (indexDay1 == -1) {
				indexDay1 = i;
			}
			
		}
		if ([searchInfo._days isEqualToString:@"3"])
		{
			if (indexDay2 == -1) {
				indexDay2 = i;
			}
			
		}
		if ([searchInfo._days isEqualToString:@"4"])
		{
			if (indexDay3 == -1) {
				indexDay3 = i;
			}
			
		}
	}
	if (indexstar >= 0) {
		dy = indexstar * 55.0f;
		[self.s_tableView setContentOffset:CGPointMake(0,dy) animated:NO];
	}
	
	
	
	// Do any additional setup after loading the view.
}

- (NSString *)setSpendTime:(NSString *)time
{
	NSString *tmp = @"";
	if ([time intValue] < 60) {
		tmp = [NSString stringWithFormat:@"%@分", time];
	}
	else if ([time intValue] % 60 == 0)
	{
		tmp = [NSString stringWithFormat:@"%d小时", [time intValue] / 60];
	}
	else
	{
		tmp = [NSString stringWithFormat:@"%d小时%d分", [time intValue] / 60, [time intValue] % 60];
	}
	return tmp;
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

- (UIView *)trainTicketPriceView
{
	UIView *priceView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 130.0f, ViewWidth, 80.0f)];
	[priceView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, 80.0f) image:[UIImage imageNamed:@"AutoDepreciateGoodBg.png"]]];
	
	int rows= self.ticketPriceDict.count;
	float x = 0.0;
	float y = 80/rows;
	int i = 0;
	NSString *title = nil;
	
	NSArray *nameArray = [[NSArray alloc] initWithObjects:@"硬座",@"软座",@"硬卧",@"软卧",@"一等座",@"二等座",@"特等座", nil];
	
	for (int j=0; j<nameArray.count; j++) {
		NSString *name = [nameArray objectAtIndex:j];
		NSMutableArray *tempArray =(NSMutableArray *)[self.ticketPriceDict objectForKey:name];
		if (tempArray.count>0) {
			
			self.ticketPriceViewA = [[UIView alloc]initWithFrame:CGRectMake(15.0f, y * i, 300.0f, 80.0f/rows)];
			for (int k = 0; k < tempArray.count; k++) {
				if (k==0) {
					x = 30.0f;	
					[self.ticketPriceViewA addSubview:[UISubLabel labelWithTitle:[nameArray objectAtIndex:j] frame:CGRectMake(0.0f ,1.0f, 40.0f, 80.0f/rows-2) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft]];
				}else if (k==1) {
					x = 70.0f;	
				}else {
					x = 110.0f;	
				}
				//[self.ticketPriceViewA addSubview:[UISubLabel labelWithTitle:@"￥" frame:CGRectMake(k * 50 + x , 2.0f , 8.0f, 80.0f/rows-2) font:FontSize20 color:FontColorFF8813 alignment:NSTextAlignmentRight]];
				
				[self.ticketPriceViewA addSubview:[UISubLabel labelWithTitle:[NSString stringWithFormat:@"￥%@",[tempArray objectAtIndex:k]] frame:CGRectMake((k * 40.0f) + x, 1.0f, 70.0f, 80.0f/rows) font:FontBlodSize38 color:FontColorFF8813 alignment:NSTextAlignmentRight]];
				
				if (j==2) {
					switch (k) {
						case 0:
							title = @"(上)";
							break;
						case 1:
							title = @"(中)";
							break;
						case 2:
							title = @"(下)";
							break;
						default:
							break;
					}
					
					[self.ticketPriceViewA addSubview:[UISubLabel labelWithTitle:title frame:CGRectMake((k * 40.0f)+  x + 73.0f, 1.0f, 40.0f, 80.0f/rows-2) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft]];
					
					
				}
				if (j==3) {
					switch (k) {
						case 0:
							title = @"(上)";
							break;
						case 1:
							title = @"(下)";
							break;
						default:
							break;
					}
					[self.ticketPriceViewA addSubview:[UISubLabel labelWithTitle:title frame:CGRectMake((k * 40.0f)+ x + 73.0f , 1.0f, 40.0f, 80.0f/rows-2) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft]];
					
					
				}
				
				
			}
			[priceView addSubview:self.ticketPriceViewA];
			i++;
		}
		
	}
	
	
	[nameArray release];
	
	return [priceView autorelease];
}


- (int)loadTicketPriceData
{
	
	self.fromStationLabel.text = self.trainListInfo._originatingStation;
	self.toStationLabel.text = self.trainListInfo._terminalStation;
	self.fromTimeLabel.text = self.trainListInfo._departureTime;
	self.toTimeLabel.text = self.trainListInfo._arrivalTime;
	self.durationLabel.text = [self setSpendTime:self.trainListInfo._runningTime];;
	self.mileageLabel.text = [NSString stringWithFormat:@"%@ KM",self.trainListInfo._mileage];
	if ([self.trainListInfo._days intValue]>1) {
		self.thatDayLabel.text = [NSString stringWithFormat:@"第%@日",self.trainListInfo._days];
	}else {
		self.thatDayLabel.text = @"";
	}
	
	
	NSMutableDictionary *tempTicketPriceDict = [[NSMutableDictionary alloc] init];
	self.ticketPriceDict = tempTicketPriceDict;
	[tempTicketPriceDict release];
	
	if (![self.trainListInfo._hardSeatPric isEqualToString:@"0"]) {
		NSMutableArray *hardSeatArray =  [[NSMutableArray alloc] init];
		[hardSeatArray addObject: self.trainListInfo._hardSeatPric];
		[self.ticketPriceDict setObject:hardSeatArray forKey:@"硬座"];
		[hardSeatArray release];
	}
	
	if (![self.trainListInfo._softSeatPric isEqualToString:@"0"]) {
		NSMutableArray *softSeatArray =  [[NSMutableArray alloc] init];
		[softSeatArray addObject: self.trainListInfo._softSeatPric];
		[self.ticketPriceDict setObject:softSeatArray forKey:@"软座"];
		[softSeatArray release];
	}
	
	
	NSMutableArray *hardSleeperArray =  [[NSMutableArray alloc] init];
	int hardSleep = 0;
	if (![self.trainListInfo._hardSleeperUpPrice isEqualToString:@"0"]) {
		[hardSleeperArray addObject: self.trainListInfo._hardSleeperUpPrice];
		hardSleep ++;
		[self.ticketPriceDict setObject:hardSleeperArray forKey:@"硬卧"];
	}
	if (![self.trainListInfo._hardSleeperMidPrice isEqualToString:@"0"]) {
		[hardSleeperArray addObject: self.trainListInfo._hardSleeperMidPrice];
		hardSleep ++;
		[self.ticketPriceDict setObject:hardSleeperArray forKey:@"硬卧"];
	}
	if (![self.trainListInfo._hardSleeperDownPrice isEqualToString:@"0"]) {
		[hardSleeperArray addObject: self.trainListInfo._hardSleeperDownPrice];
		hardSleep ++;
		[self.ticketPriceDict setObject:hardSleeperArray forKey:@"硬卧"];
	}
	
	[hardSleeperArray release];
	
	NSMutableArray *softSleeperArray =  [[NSMutableArray alloc] init];
	int softSleep = 0;
	if (![self.trainListInfo._softSleeperUpPrice isEqualToString:@"0"]) {
		[softSleeperArray addObject: self.trainListInfo._softSleeperUpPrice];
		softSleep ++;
		[self.ticketPriceDict setObject:softSleeperArray forKey:@"软卧"];
	}
	if (![self.trainListInfo._softSleeperDownPrice isEqualToString:@"0"]) {
		[softSleeperArray addObject: self.trainListInfo._softSleeperDownPrice];
		softSleep ++;
		[self.ticketPriceDict setObject:softSleeperArray forKey:@"软卧"];
	}
	
	[softSleeperArray release];
	
	
	if (![self.trainListInfo._firstSeat isEqualToString:@"0"]) {
		NSMutableArray *firstSeatArray =  [[NSMutableArray alloc] init];
		[firstSeatArray addObject: self.trainListInfo._firstSeat];
		[self.ticketPriceDict setObject:firstSeatArray forKey:@"一等座"];
		[firstSeatArray release];
	}
	
	
	
	if (![self.trainListInfo._secondSeat isEqualToString:@"0"]) {
		NSMutableArray *secondeatArray =  [[NSMutableArray alloc] init];
		[secondeatArray addObject: self.trainListInfo._secondSeat];
		[self.ticketPriceDict setObject:secondeatArray forKey:@"二等座"];
		[secondeatArray release];
	}
	
	
	
	if (![self.trainListInfo._specialSeat isEqualToString:@"0"]) {
		NSMutableArray *specialSeatArray =  [[NSMutableArray alloc] init];
		[specialSeatArray addObject: self.trainListInfo._specialSeat];
		[self.ticketPriceDict setObject:specialSeatArray forKey:@"特等座"];
		[specialSeatArray release];
	}
	
	
	return self.ticketPriceDict.count;
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
	return [self.stationInfoArray count] ; 
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 55.0f;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * identifier = @"identifier";
	
	StationInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	SearchTrainDetail *searchInfo = nil;
	searchInfo = (SearchTrainDetail *)[self.stationInfoArray objectAtIndex:indexPath.row];
	if (cell == nil) {
		cell = [[[StationInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
	}
	
	if (indexPath.row>=indexstar && indexPath.row<=indexend) {
		cell.bgView.hidden = NO;
	}else {
		cell.bgView.hidden = YES;
	}
	
	if (indexPath.row == indexDay1 || indexPath.row == indexDay2 || indexPath.row == indexDay3) {
		if ([searchInfo._arrivalTime rangeOfString:@":"].length > 0 && ![searchInfo._arrivalTime isEqualToString:@"始发站"]) {
			if ( 0 <= [[[searchInfo._arrivalTime componentsSeparatedByString:@":"] objectAtIndex:0]intValue] <= 12 ) {
				cell.stationsDay2View.hidden = NO;
				cell.thatDayLabel1.text = [NSString stringWithFormat:@"第%@日",searchInfo._days];
			}
		}else {
			cell.stationsDay2View.hidden = YES;
		}
		if (![searchInfo._departureTime isEqualToString:@"终点站"] ) {
			cell.stationsDay1View.hidden = NO;
			cell.thatDayLabel.text = [NSString stringWithFormat:@"第%@日",searchInfo._days];
		}else {
			cell.stationsDay1View.hidden = YES;
		}
		

	}else {
		cell.stationsDay1View.hidden = YES;
		cell.stationsDay2View.hidden = YES;
	}
	
	cell.numLabel.text = searchInfo._stationNum;
	cell.stationNameLabel.text = searchInfo._stationName;
	
	if ([searchInfo._departureTime isEqualToString:@"终点站"] ) {
		cell.departureTimeLabel.text = @"--:--";
	}else {
		cell.departureTimeLabel.text = searchInfo._departureTime;
	}
	if ([searchInfo._arrivalTime isEqualToString:@"始发站"] ) {
		cell.arrivalTimeLabel.text = @"--:--";
	}else {
		cell.arrivalTimeLabel.text = searchInfo._arrivalTime;
	}
	
	cell.stopTimeLabel.text = searchInfo._stopTime;
	cell.mileageLabel.text = searchInfo._mileage;
	
	return cell;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
