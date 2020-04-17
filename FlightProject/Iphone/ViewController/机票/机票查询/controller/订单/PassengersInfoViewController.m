//
//  PassengersInfoViewController.m
//  FlightProject
//
//  Created by longcd on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PassengersInfoViewController.h"
#import "TicketOrderInfoViewController.h"

#import "PassengersInfoCell.h"
#import "TicketOrderInfoViewController.h"
#import "MemberHomeViewController.h"

#import "EditPassgersInfoViewController.h"

#import "InterfaceClass.h"
#import "SendRequstCatchQueue.h"


@interface PassengersInfoViewController ()
-(void) getPassengersInfo; // 获取乘机人列表
-(void) addPassenger:(id)sender; //新增乘机人
-(void) add:(id)sender; //添加乘机人
-(void)editClick:(id)sender; //编辑乘机人

@end

@implementation PassengersInfoViewController
@synthesize passengersInfoArray = _passengersInfoArray;
@synthesize p_tableView = _p_tableView;
@synthesize stateDictionary = _stateDictionary;
@synthesize sourceType,surplusTicket,currentYear,currentYearBack;
@synthesize promptlable,delPassInfoItem,certDay;
#pragma mark -
#pragma mark View系统方法



- (void)loadView{
	
	[super loadView];
	
	UISubLabel *titleLabel = [UISubLabel labelWithTitle:@"常用乘机人列表" frame:CGRectMake(15.0f, 15.0f, 140.0f, 40.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
	titleLabel.textColor = FontColor333333;
	[self.view addSubview:titleLabel];
	
	passengerAddButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(ViewWidth - 122, 18.0f, 115.0f, 32.0f) backImage:[UIImage imageNamed:@"NewAddPassenersButton.png"] target:self action:@selector(addPassenger:)];
	[self.view addSubview:passengerAddButton];
	
	self.promptlable = [UISubLabel labelWithTitle:@"您还没有常用乘机人，请新增乘机人。" frame:CGRectMake(15.0f, 60.0f, ViewWidth - 20, 25.0f) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
	self.promptlable.hidden = YES;
	[self.view addSubview: self.promptlable];
	
	_p_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 60.0f, ViewWidth, ViewHeight-165.0f) style:UITableViewStylePlain];
	self.p_tableView.backgroundColor = [UIColor clearColor];
	self.p_tableView.dataSource = self;
	self.p_tableView.delegate = self;
	self.p_tableView.separatorColor = [UIColor clearColor];
	[self.view addSubview:self.p_tableView];
	
	if (self.sourceType == 0) {
		UIImageView *bottomButtonImgView=[UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight-100.0f, ViewWidth, 50.0f)];
		bottomButtonImgView.image=[UIImage imageNamed:@"PassBottomButtonBg.png"];
		[self.view addSubview:bottomButtonImgView];
		
		submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake((ViewWidth - 145)/2, ViewHeight-90.0f, 145.0f, 38.0f) backImage:[UIImage imageNamed:@"ConfirmationPassButton.png"] target:self action:@selector(add:)];
		[self.view addSubview:submitButton];
	} else {
		CGRect newFrame = self.p_tableView.frame;
		newFrame.size.height = ViewHeight-132.0f;
		self.p_tableView.frame = newFrame;
	}
	
	
	
}


-(void)dealloc
{
	[_p_tableView release];
	[_passengersInfoArray release];
	self.stateDictionary = nil;
	self.currentYear = nil;
	self.sourceType = 0;
	self.surplusTicket = 0;
	self.delPassInfoItem = nil;
	self.currentYearBack = nil;
	self.promptlable = nil;
	self.certDay = nil;
	[super dealloc];
}
-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self getPassengersInfo];
}
- (void)viewDidLoad
{
	[super viewDidLoad];
	if (self.sourceType == 0) {
		self.title = @"选择乘机人";
	}else {
		self.title = @"常用乘机人";
	}
	
	self.navigationItem.rightBarButtonItem = nil;
	_passengersInfoArray = [[NSMutableArray alloc] init ];
	// Do any additional setup after loading the view.
	self.stateDictionary = [NSMutableDictionary dictionary];
	//self.surplusTicket = 12;
	if (memberVC.orderInfoData._passengerArray.count>0) {
		
		for (PassengerInfoItem *tmp in memberVC.orderInfoData._passengerArray) {
			//NSNumber *checked = [self.stateDictionary objectForKey:tmp._id];
			NSNumber *checked = nil;
			[self.stateDictionary setObject:(checked = [NSNumber numberWithBool:YES]) forKey:tmp._id];
		}
	}
	

	
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
}


#pragma mark -
#pragma mark 数据加载方法

- (void)getPassengersInfo // 获取乘机人列表
{
	ASIFormDataRequest * theRequest = [InterfaceClass getPassengerList:[UserInfo sharedUserInfo].userID]; //测试的UserID69743
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(ongetPassengerListPaseredResult:) Delegate:self needUserType:Member];
}
- (void)ongetPassengerListPaseredResult:(NSDictionary *)dic
{
	isRequestList = TRUE;
	self.passengersInfoArray = [PassengerInfoDataResponse queryPassengerInfoList:dic];
	if (self.passengersInfoArray.count <=0) {
		self.promptlable.hidden = NO;
	}
	[self.p_tableView reloadData];
}

#pragma mark -
#pragma mark 自定义方法
//新增乘机人
-(void) addPassenger:(id)sender
{
	EditPassgersInfoViewController * editPassegersInfoVC = [[EditPassgersInfoViewController alloc] init];
	editPassegersInfoVC->passengersInfoVC = self;
	editPassegersInfoVC.currentYear = self.currentYear;
	editPassegersInfoVC.currentYearBack = nil;
	[self.navigationController pushViewController:editPassegersInfoVC animated:YES];
	[editPassegersInfoVC release];
}
-(void)backHome
{
	if (isRequestList) {
		NSMutableArray * mArray = [NSMutableArray array];
		[mArray addObjectsFromArray:memberVC.orderInfoData._passengerArray];
		for (PassengerInfoItem * item in mArray)
		{
			BOOL inAllArray = FALSE;
			for (PassengerInfoItem *tmp in self.passengersInfoArray)
			{
				if ([tmp._id isEqualToString:item._id]) {
					inAllArray = TRUE;
				}
			}
			if (inAllArray == FALSE) {
				[memberVC.orderInfoData._passengerArray removeObject:item];
			}
		}
		for (int i=0;i< [memberVC.orderInfoData._passengerArray count];i++)
		{
			PassengerInfoItem * item = [memberVC.orderInfoData._passengerArray objectAtIndex:i];
			for (PassengerInfoItem *tmp in self.passengersInfoArray)
			{
				if ([tmp._id isEqualToString:item._id]) {
					
					if ([tmp._type intValue] == 1) {
						FlightInfo * flightInfo = [memberVC.orderInfoData._flightsInfoArray objectAtIndex:0];
						NSString * flightStartDate = [flightInfo._startDate substringToIndex:10];
						int flightStartDateYear = [flightStartDate intValue];
						NSString * flightStartDateTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-2,[flightStartDate substringFromIndex:4]];
						NSString * flightStartDateOneTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-12,[flightStartDate substringFromIndex:4]];
						NSLog(@"%@,%@,%@",flightStartDate,flightStartDateTwo,flightStartDateOneTwo);
						if ([tmp._birthday  compare:  flightStartDateTwo]>0) {// 婴儿
							[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，如果需要购买婴儿票请拨打预订热线400-6858-999.",tmp._name] :@"提示"] ;
							return;
						}
						else if ([tmp._birthday compare: flightStartDateOneTwo]<=0){ // 成人
							[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，请编辑该乘机人类型为成人后再预订机票！",tmp._name] :@"提示"] ;
							return;
						}
						if (memberVC.orderInfoData._flightsInfoArray.count>1) {
							FlightInfo * flightInfo = [memberVC.orderInfoData._flightsInfoArray objectAtIndex:1];
							NSString * flightStartDate = [flightInfo._startDate substringToIndex:10];
							int flightStartDateYear = [flightStartDate intValue];
							NSString * flightStartDateTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-2,[flightStartDate substringFromIndex:4]];
							NSString * flightStartDateOneTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-12,[flightStartDate substringFromIndex:4]];
							NSLog(@"%@,%@,%@",flightStartDate,flightStartDateTwo,flightStartDateOneTwo);
							if ([tmp._birthday  compare:  flightStartDateTwo]>0) {// 婴儿
								[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，如果需要购买婴儿票请拨打预订热线400-6858-999.",tmp._name] :@"提示"] ;
								return;
							}
							else if ([tmp._birthday compare: flightStartDateOneTwo]<=0){ // 成人
								[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，请编辑该乘机人类型为成人后再预订机票！",tmp._name] :@"提示"] ;
								return;
							}
						}
					}
					[memberVC.orderInfoData._passengerArray replaceObjectAtIndex:i withObject:tmp];
				}
			}
		}
		
	}
	[super backHome];
}
//添加乘机人
-(void) add:(id)sender
{
	int childCount = 0; //儿童数量
	int adultCount = 0; //成人数量
	int checkedCount = 0; //选择的数量
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	for (PassengerInfoItem *tmp in self.passengersInfoArray) {
		NSNumber *checked = [self.stateDictionary objectForKey:tmp._id];
		if (checked) {
			if ([checked intValue]==1) {
				if ([tmp._type intValue] == 0) {
					FlightInfo * flightInfo = [memberVC.orderInfoData._flightsInfoArray objectAtIndex:0];
					NSString * flightStartDate = [flightInfo._startDate substringToIndex:10];
					int flightStartDateYear = [flightStartDate intValue];
					NSString * flightStartDateTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-2,[flightStartDate substringFromIndex:4]];
					NSString * flightStartDateOneTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-12,[flightStartDate substringFromIndex:4]];
					NSLog(@"%@,%@,%@",flightStartDate,flightStartDateTwo,flightStartDateOneTwo);
					
					if ([tmp._certType intValue] == 0) {
						NSString *cert = [tmp._certNum substringWithRange:NSMakeRange(6, 8)];
						if (cert.length==8) {
							self.certDay = [NSString stringWithFormat:@"%@-%@-%@",[cert substringWithRange:NSMakeRange(0, 4)],[cert substringWithRange:NSMakeRange(4, 2)],[cert substringWithRange:NSMakeRange(6, 2)]];
							
							if ([self.certDay  compare:  flightStartDateTwo]>0) {// 婴儿
								[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，如果需要购买婴儿票请拨打预订热线400-6858-999.",tmp._name] :@"提示"] ;
								return;
							}
							else if ([self.certDay compare: flightStartDateOneTwo] > 0){ // 成人
								[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@仅符合航空公司购买儿童票标准，请编辑为儿童类型!",tmp._name] :@"提示"] ;
								return;
							}
							
							if (memberVC.orderInfoData._flightsInfoArray.count>1) {
								FlightInfo * flightInfo = [memberVC.orderInfoData._flightsInfoArray objectAtIndex:1];
								NSString * flightStartDate = [flightInfo._startDate substringToIndex:10];
								int flightStartDateYear = [flightStartDate intValue];
								NSString * flightStartDateTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-2,[flightStartDate substringFromIndex:4]];
								NSString * flightStartDateOneTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-12,[flightStartDate substringFromIndex:4]];
								NSLog(@"%@,%@,%@",flightStartDate,flightStartDateTwo,flightStartDateOneTwo);
								if ([self.certDay  compare:  flightStartDateTwo]>0) {// 婴儿
									[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，如果需要购买婴儿票请拨打预订热线400-6858-999.",tmp._name] :@"提示"] ;
									return;
								}
								else if ([self.certDay compare: flightStartDateOneTwo] > 0){ // 成人
									[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@仅符合航空公司购买儿童票标准，请编辑为儿童类型!",tmp._name] :@"提示"] ;
									
									return;
								}
							}
						}
						

					}
				}
				
				if ([tmp._type intValue] == 1) {
					FlightInfo * flightInfo = [memberVC.orderInfoData._flightsInfoArray objectAtIndex:0];
					NSString * flightStartDate = [flightInfo._startDate substringToIndex:10];
					int flightStartDateYear = [flightStartDate intValue];
					NSString * flightStartDateTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-2,[flightStartDate substringFromIndex:4]];
					NSString * flightStartDateOneTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-12,[flightStartDate substringFromIndex:4]];
					NSLog(@"%@,%@,%@",flightStartDate,flightStartDateTwo,flightStartDateOneTwo);
					if ([tmp._birthday  compare:  flightStartDateTwo]>0) {// 婴儿
						[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，如果需要购买婴儿票请拨打预订热线400-6858-999.",tmp._name] :@"提示"] ;
						return;
					}
					else if ([tmp._birthday compare: flightStartDateOneTwo]<=0){ // 成人
						[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，请编辑该乘机人类型为成人后再预订机票！",tmp._name] :@"提示"] ;
						return;
					}
					if (memberVC.orderInfoData._flightsInfoArray.count>1) {
						FlightInfo * flightInfo = [memberVC.orderInfoData._flightsInfoArray objectAtIndex:1];
						NSString * flightStartDate = [flightInfo._startDate substringToIndex:10];
						int flightStartDateYear = [flightStartDate intValue];
						NSString * flightStartDateTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-2,[flightStartDate substringFromIndex:4]];
						NSString * flightStartDateOneTwo = [NSString stringWithFormat:@"%d%@",flightStartDateYear-12,[flightStartDate substringFromIndex:4]];
						NSLog(@"%@,%@,%@",flightStartDate,flightStartDateTwo,flightStartDateOneTwo);
						if ([tmp._birthday  compare:  flightStartDateTwo]>0) {// 婴儿
							[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，如果需要购买婴儿票请拨打预订热线400-6858-999.",tmp._name] :@"提示"] ;
							return;
						}
						else if ([tmp._birthday compare: flightStartDateOneTwo]<=0){ // 成人
							[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘客%@不符合航空公司购买儿童票的标准，请编辑该乘机人类型为成人后再预订机票！",tmp._name] :@"提示"] ;
							return;
						}
					}
				}
				[tempArray addObject:tmp];
				checkedCount++;
				if ([tmp._type isEqualToString:@"0"]) adultCount++;
				if ([tmp._type isEqualToString:@"1"]) childCount++;
			}
		}
	}
	
	if (checkedCount==0)
	{
		[UIAlertView alertViewWithMessage:@"请选择乘机人!" :@"提示"];
		[tempArray release];
		return;
	}
	
    int maxNum = [[[NSUserDefaults standardUserDefaults] objectForKey:keyMaxFlyNum] intValue];
	if (checkedCount > maxNum)
	{
		[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"乘机人最多可以添加%d位!", maxNum] :@"提示"];
		[tempArray release];
		return;
	}
	if (checkedCount>self.surplusTicket)
	{
		[UIAlertView alertViewWithMessage:@"该舱位剩余票数不足!" :@"提示"];
		[tempArray release];
		return;
	}
	if (childCount>adultCount*2) {
		
		[UIAlertView alertViewWithMessage:@"按航空公司规则，儿童乘机需要有成人陪伴，一名成人最多只能携带两名儿童!" :@"提示"];
		[tempArray release];
		return;
	}
	
	
	if (memberVC.orderInfoData._passengerArray.count>0) [memberVC.orderInfoData._passengerArray removeAllObjects];
	memberVC.orderInfoData._passengerArray = tempArray;
	
	[tempArray release];
	[self.navigationController popViewControllerAnimated:YES];
	
}

//编辑乘机人
-(void)editClick:(id)sender
{
	UIButton *button = (UIButton*)sender;
	PassengerInfoItem * passengerInfoItem =  (PassengerInfoItem *)[self.passengersInfoArray objectAtIndex:(button.tag-100)];
	EditPassgersInfoViewController * editPassegersInfoVC = [[EditPassgersInfoViewController alloc] init];
	editPassegersInfoVC.passengerInfoItem = passengerInfoItem;
	editPassegersInfoVC.currentYear = self.currentYear;
        editPassegersInfoVC.currentYearBack = nil;
	editPassegersInfoVC->passengersInfoVC = self;
	editPassegersInfoVC.index = (button.tag-100);
	editPassegersInfoVC.type = [passengerInfoItem._type intValue];
	[NavigationController pushViewController:editPassegersInfoVC animated:YES];
	[editPassegersInfoVC release];
}


#pragma mark -
#pragma mark UITableView方法

#pragma mark -
#pragma mark UITableView方法
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
	
	return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		

		self.delPassInfoItem = (PassengerInfoItem *)[self.passengersInfoArray objectAtIndex:indexPath.row];
		[self loadDelDataSource];
		[self.passengersInfoArray removeObjectAtIndex:indexPath.row];
		[self.p_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		
	}
	else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	}
}

//删除乘机人
-(void) loadDelDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass deletePassengers:[UserInfo sharedUserInfo].userID withIds:self.delPassInfoItem._id];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelPaseredResult:) Delegate:self needUserType:Member];
	
	
	
}

//删除请求返回处理
- (void)onDelPaseredResult:(NSDictionary *)dic
{
	
	if (memberVC.orderInfoData._passengerArray.count>0) {
		if ([memberVC.orderInfoData._passengerArray containsObject:self.delPassInfoItem]) {
			[memberVC.orderInfoData._passengerArray removeObject:self.delPassInfoItem];
		}
		
	}
	if (self.passengersInfoArray.count <=0) {
		self.promptlable.hidden = NO;
	}
	
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 65.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.passengersInfoArray count];
	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * identifier = @"identifier";
	PassengersInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[PassengersInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		cell.backgroundColor = [UIColor clearColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
	}
	PassengerInfoItem *passInfo = nil;
	passInfo = (PassengerInfoItem *)[self.passengersInfoArray objectAtIndex:indexPath.row];
	
	
	
	cell.name.text = passInfo._name;
	
	if ([passInfo._type intValue]==0)
		cell.identification.text = passInfo._certNum;
	if ([passInfo._type intValue]==1){
		if ([ passInfo._certNum isEqualToString:@"<null>"] || [ passInfo._certNum isEqualToString:@""])
		{
			passInfo._certNum =@"";
		}
		if(![ passInfo._certNum isEqualToString:@""]){
			cell.identification.text = passInfo._certNum;
		}else{
			cell.identification.text = passInfo._birthday;
		}
		
	}
		
	
	NSNumber *checked = [self.stateDictionary objectForKey:passInfo._id];
	if (!checked) [self.stateDictionary setObject:(checked = [NSNumber numberWithBool:NO]) forKey:passInfo._id];
	cell.btnView.hidden = checked.boolValue ? NO :YES;
	cell.editButton.tag = (100+indexPath.row);
	cell.delegate = self;
	
	if (self.sourceType == 1){
		
		cell.choiceImgView.hidden = YES;
		CGRect newFrame = cell.name.frame;
		newFrame.origin.x = 20.0f;
		newFrame.size.width = 90.0f;
		cell.name.frame = newFrame;
		
		newFrame = cell.identification.frame;
		newFrame.origin.x = 110.0f;
		newFrame.size.width = 185.0f;
		cell.identification.frame = newFrame;
		
	}
	
	return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (self.sourceType == 0) { //订单点击选择乘机人
		
		PassengersInfoCell *cell = (PassengersInfoCell*)[self.p_tableView cellForRowAtIndexPath:indexPath];
		PassengerInfoItem *passInfoItem = [self.passengersInfoArray objectAtIndex:indexPath.row];
		NSString *kId = passInfoItem._id;
		BOOL isChecked = !([[self.stateDictionary objectForKey:kId] boolValue]);
		NSNumber *checked = [NSNumber numberWithBool:isChecked];
		[self.stateDictionary setObject:checked forKey:kId];
		cell.btnView.hidden = isChecked ? NO : YES;
	}else {  //主页点击编辑乘机人
		
		PassengerInfoItem * passengerInfoItem =  (PassengerInfoItem *)[self.passengersInfoArray objectAtIndex:indexPath.row];
		EditPassgersInfoViewController * editPassegersInfoVC = [[EditPassgersInfoViewController alloc] init];
		editPassegersInfoVC.passengerInfoItem = passengerInfoItem;
		editPassegersInfoVC->passengersInfoVC = self;
		editPassegersInfoVC.currentYear = self.currentYear;
		editPassegersInfoVC.currentYearBack = nil;
		editPassegersInfoVC.index = indexPath.row;
		[NavigationController pushViewController:editPassegersInfoVC animated:YES];
		[editPassegersInfoVC release];
	}
	
	
}


@end
