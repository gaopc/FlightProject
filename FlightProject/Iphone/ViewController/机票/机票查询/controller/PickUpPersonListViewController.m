//
//  PickUpPersonListViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 14-4-15.
//
//

#import "PickUpPersonListViewController.h"
#import "TicketOrderInfoViewController.h"
#import "PassengersInfoCell.h"
#import "TicketOrderInfoViewController.h"
#import "MemberHomeViewController.h"
#import "PickUpPersonDetailViewController.h"
#import "InterfaceClass.h"
#import "SendRequstCatchQueue.h"
#import "PassengerInfoDataResponse.h"

@interface PassengersInfoViewController ()
-(void) getPassengersInfo; // 获取乘机人列表
-(void) addPassenger:(id)sender; //新增乘机人
-(void) add:(id)sender; //添加乘机人
-(void)editClick:(id)sender; //编辑乘机人

@end

@interface PickUpPersonListViewController ()

@end

@implementation PickUpPersonListViewController
@synthesize passengersInfoArray = _passengersInfoArray;
@synthesize p_tableView = _p_tableView;
@synthesize sourceType,pickPersonItem;
@synthesize promptlable,delPassInfoItem,certDay;
@synthesize delegate,cPersonLabel,maximum;

#pragma mark -
#pragma mark View系统方法

-(void)dealloc
{
	[_p_tableView release];
	[_passengersInfoArray release];
	self.sourceType = 0;
	self.delPassInfoItem = nil;
	self.promptlable = nil;
	self.certDay = nil;
	 self.delegate = nil;
	self.pickPersonItem = nil;
	self.cPersonLabel = nil;
	
	[super dealloc];
}
-(void)addPickUpPersonDelegateWithItem:(id)item
{}
-(void)backHome
{
	if (isRequestList) {
		BOOL inAllArray = FALSE;
		for (PickPersonInfoItem * item in self.passengersInfoArray)
		{
			if ([self.pickPersonItem._id  isEqualToString:item._id]) {
				inAllArray = TRUE;
				if (self.delegate && [self.delegate respondsToSelector:@selector(addPickUpPersonDelegateWithItem:)]) {
					[self.delegate performSelector:@selector(addPickUpPersonDelegateWithItem:) withObject:item];
				}
				break;
			}
		}
		if (!inAllArray) {
			PickPersonInfoItem * info = [[PickPersonInfoItem alloc] init];
			info._id = @"";
			info._name = @"";
			info._phone = @"";
			info._selected = @"0";
			if (self.delegate && [self.delegate respondsToSelector:@selector(addPickUpPersonDelegateWithItem:)]) {
				[self.delegate performSelector:@selector(addPickUpPersonDelegateWithItem:) withObject:info];
			}
			[info release];
		}
	}
	
	

	
	[super backHome];
}

- (void)loadView{
	
	[super loadView];
	
	UISubLabel *titleLabel = [UISubLabel labelWithTitle:@"常用联系人列表" frame:CGRectMake(15.0f, 15.0f, 140.0f, 40.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
	titleLabel.textColor = FontColor333333;
	[self.view addSubview:titleLabel];
	
	passengerAddButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(ViewWidth - 125, 18.0f, 115.0f, 32.0f) backImage:[UIImage imageNamed:@"addContacts.png"] target:self action:@selector(addPassenger:)];
	[self.view addSubview:passengerAddButton];
	
	self.promptlable = [UISubLabel labelWithTitle:@"您还没有常用联系人，请新增联系人。" frame:CGRectMake(15.0f, 60.0f, ViewWidth - 20, 25.0f) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
	self.promptlable.hidden = YES;
	[self.view addSubview: self.promptlable];
	
	self.cPersonLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(15.0f, 60.0f, ViewWidth - 20, 25.0f) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
	//self.cPersonLabel.text = [NSString stringWithFormat:@"常用联系人最多能保存20条，您已经保存了%@条",@"20"];
	self.cPersonLabel.hidden = YES;
	[self.view addSubview: self.cPersonLabel];
	
	_p_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 100.0f, ViewWidth, ViewHeight-205.0f) style:UITableViewStylePlain];
	self.p_tableView.backgroundColor = [UIColor clearColor];
	self.p_tableView.dataSource = self;
	self.p_tableView.delegate = self;
	self.p_tableView.separatorColor = [UIColor clearColor];
	[self.view addSubview:self.p_tableView];
	
	if (self.sourceType == 0) {
		UIImageView *bottomButtonImgView=[UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight-100.0f, ViewWidth, 50.0f)];
		bottomButtonImgView.image=[UIImage imageNamed:@"PassBottomButtonBg.png"];
		[self.view addSubview:bottomButtonImgView];
		
		submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake((ViewWidth - 146)/2, ViewHeight-90.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"NoPassengersButton.png"] target:self action:@selector(add:)];
		[self.view addSubview:submitButton];
	} else {
		CGRect newFrame = self.p_tableView.frame;
		newFrame.size.height = ViewHeight-145.0f;
		self.p_tableView.frame = newFrame;
	}
	
	
	
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
		self.title = @"选择联系人";
	}else {
		self.title = @"常用联系人";
	}
	
	self.navigationItem.rightBarButtonItem = nil;
	_passengersInfoArray = [[NSMutableArray alloc] init ];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
}


#pragma mark -
#pragma mark 数据加载方法
- (void)getPassengersInfo // 获取乘机人列表
{
	ASIFormDataRequest * theRequest = [InterfaceClass getPickList:[UserInfo sharedUserInfo].userID]; //测试的UserID69743
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(ongetPassengerListPaseredResult:) Delegate:self needUserType:Member];
}

- (void)ongetPassengerListPaseredResult:(NSDictionary *)dic
{
	isRequestList = TRUE;
	PassengerInfoDataResponse *passengerInfoDR = [[[PassengerInfoDataResponse alloc] init] autorelease];
	[passengerInfoDR queryPickPersonInfoList:dic];
	self.passengersInfoArray =passengerInfoDR._pickPersonInfoArray;
	self.maximum = [passengerInfoDR._maximum intValue];
	if (self.maximum == 0)
	   self.maximum = 20;
	
	self.total = [passengerInfoDR._total intValue];
	if (self.passengersInfoArray.count <=0) {
		self.promptlable.hidden = NO;
		self.cPersonLabel.hidden = YES;
	}else{
		self.promptlable.hidden = YES;
		self.cPersonLabel.hidden = NO;
		self.cPersonLabel.text = [NSString stringWithFormat:@"常用联系人最多能保存%d条，您已经保存了%d条",self.maximum,self.total];

	}
	[self.p_tableView reloadData];
}

#pragma mark -
#pragma mark 自定义方法
//新增乘机人
-(void) addPassenger:(id)sender
{
	if (self.total>=self.maximum) {
		[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"常用联系人最多能保存%d条!",self.maximum] :@"提示"];
		return;

	}
	PickUpPersonDetailViewController * editPassegersInfoVC = [[PickUpPersonDetailViewController alloc] init];
	editPassegersInfoVC->passengersInfoVC = self;
	[self.navigationController pushViewController:editPassegersInfoVC animated:YES];
	[editPassegersInfoVC release];
}
//不需要联系人
-(void) add:(id)sender
{
	
	PickPersonInfoItem * info = [[PickPersonInfoItem alloc] init];
	info._id = @"";
	info._name = @"";
	info._phone = @"";
	info._selected = @"0";
	if (self.delegate && [self.delegate respondsToSelector:@selector(addPickUpPersonDelegateWithItem:)]) {
		[self.delegate performSelector:@selector(addPickUpPersonDelegateWithItem:) withObject:info];
	}
	[info release];
	[self.navigationController popViewControllerAnimated:YES];
	
}

//编辑乘机人
-(void)editClick:(id)sender
{
	UIButton *button = (UIButton*)sender;
	PickPersonInfoItem * passengerInfoItem =  (PickPersonInfoItem *)[self.passengersInfoArray objectAtIndex:(button.tag-100)];
	PickUpPersonDetailViewController * editPassegersInfoVC = [[PickUpPersonDetailViewController alloc] init];
	editPassegersInfoVC.passengerInfoItem = passengerInfoItem;
	editPassegersInfoVC->passengersInfoVC = self;
	editPassegersInfoVC.index = (button.tag-100);
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
		
		
		self.delPassInfoItem = (PickPersonInfoItem *)[self.passengersInfoArray objectAtIndex:indexPath.row];
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
	ASIFormDataRequest * theRequest = [InterfaceClass deletePick:[UserInfo sharedUserInfo].userID ids:self.delPassInfoItem._id];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelPaseredResult:) Delegate:self needUserType:Member];
	
	
	
}

//删除请求返回处理
- (void)onDelPaseredResult:(NSDictionary *)dic
{
	
//	if (memberVC.orderInfoData._passengerArray.count>0) {
//		if ([memberVC.orderInfoData._passengerArray containsObject:self.delPassInfoItem]) {
//			[memberVC.orderInfoData._passengerArray removeObject:self.delPassInfoItem];
//		}
//		
//	}
	if (self.passengersInfoArray.count <=0) {
		self.promptlable.hidden = NO;
		self.cPersonLabel.hidden = YES;
	}else{
		self.promptlable.hidden = YES;
		self.cPersonLabel.hidden = NO;
		self.cPersonLabel.text = [NSString stringWithFormat:@"常用联系人最多能保存%d条，您已经保存了%lu条",self.maximum,(unsigned long)self.passengersInfoArray.count];
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
	PickPersonInfoItem *passInfo = nil;
	passInfo = (PickPersonInfoItem *)[self.passengersInfoArray objectAtIndex:indexPath.row];
	cell.name.text = passInfo._name;
	cell.identification.text = passInfo._phone;
	cell.editButton.tag = (100+indexPath.row);
	cell.delegate = self;
	if ([self.pickPersonItem._id intValue] == [passInfo._id intValue])
	{
		cell.btnView.hidden = NO;
		passInfo._selected = @"1";
	}else {
		cell.btnView.hidden = YES;
	}
	
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
		
		int i = 0;
		for (PassengersInfoCell* cell in [self.p_tableView visibleCells]) {
			PickPersonInfoItem *tempPassItem = [self.passengersInfoArray objectAtIndex:i];
			tempPassItem._selected = @"0";
			cell.btnView.hidden = YES;
			i++;
			tempPassItem = nil;
			
		}
		[self.p_tableView deselectRowAtIndexPath:indexPath animated:YES];
		
		PickPersonInfoItem *passInfoItem = [self.passengersInfoArray objectAtIndex:indexPath.row];
		passInfoItem._selected = @"1";
		
		((PassengersInfoCell*)[self.p_tableView cellForRowAtIndexPath:indexPath]).btnView.hidden = NO;
	
		if (self.delegate && [self.delegate respondsToSelector:@selector(addPickUpPersonDelegateWithItem:)]) {
		           [self.delegate performSelector:@selector(addPickUpPersonDelegateWithItem:) withObject:passInfoItem];
		}
		[self.navigationController popViewControllerAnimated:YES];
		
	}else {  //主页点击编辑乘机人
		
		PickPersonInfoItem * passengerInfoItem =  (PickPersonInfoItem *)[self.passengersInfoArray objectAtIndex:indexPath.row];
		PickUpPersonDetailViewController * editPassegersInfoVC = [[PickUpPersonDetailViewController alloc] init];
		editPassegersInfoVC.passengerInfoItem = passengerInfoItem;
		editPassegersInfoVC->passengersInfoVC = self;
		editPassegersInfoVC.index = indexPath.row;
		[NavigationController pushViewController:editPassegersInfoVC animated:YES];
		[editPassegersInfoVC release];
	}
	
	
}


@end
