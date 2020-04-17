//
//  PassengersAddressViewController.m
//  FlightProject
//
//  Created by lidong  cui on 12-10-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PassengersAddressViewController.h"
#import "PassengerAddressDataResponse.h"
#import "EditPassgersAddressViewController.h"
#import "TicketOrderInfoViewController.h"
#import "MemberHomeViewController.h"
#import "TrainModel.h"

@interface PassengersAddressViewController ()
- (void) queryPassengersAddress; // 邮寄地址列表
@end


@implementation PassengersAddressViewController

@synthesize addressDataArray= _addressDataArray;
@synthesize a_tableView = _a_tableView;
@synthesize sourceType,promptlable;

@synthesize addressItem;


#pragma mark - View lifecycle
-(void)backHome
{
	if (isRequestList) {
		BOOL inAllArray = FALSE;
		for (PassengerAddressItem * item in self.addressDataArray)
		{
			if ([memberVC.orderInfoData._postAddressItem._id  isEqualToString:item._id]) {
				inAllArray = TRUE;
				memberVC.orderInfoData._postAddressItem = item;
				break;
			}
		}
		if (!inAllArray) {
			memberVC.orderInfoData._postAddressItem = nil;
		}
	}
	
	[super backHome];
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self queryPassengersAddress];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    	
	[super loadView];
	
	UISubLabel *titleLabel = [UISubLabel labelWithTitle:@"邮寄地址列表" frame:CGRectMake(15.0f, 15.0f, 140.0f, 40.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
	titleLabel.textColor = FontColor454545;
	[self.view addSubview:titleLabel];
	
	passAddressButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(ViewWidth - 125, 18.0f, 115.0f, 32.0f) backImage:[UIImage imageNamed:@"AddPassAddRessButton.png"] target:self action:@selector(addPassenger:)];
	[self.view addSubview:passAddressButton];
	
	
	self.promptlable = [UISubLabel labelWithTitle:@"您还没有常用邮寄地址，请新增邮寄地址。" frame:CGRectMake(15.0f, 60.0f, ViewWidth - 20, 25.0f) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
	self.promptlable.hidden = YES;
	[self.view addSubview: self.promptlable];

	
        _a_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 60.0f, ViewWidth, ViewHeight-104.0f) style:UITableViewStylePlain];
	self.a_tableView.backgroundColor = [UIColor clearColor];
	self.a_tableView.dataSource = self;
	self.a_tableView.delegate = self;
	
	self.a_tableView.separatorColor = [UIColor clearColor];
	[self.view addSubview:self.a_tableView];
	
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	[super viewDidLoad];
	if (self.sourceType == 0) {
		self.title = @"选择邮寄地址";
	}else {
		self.title = @"常用邮寄地址";
	}
	
	self.navigationItem.rightBarButtonItem = nil;
	_addressDataArray = [[NSMutableArray alloc] init];
	
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


-(void)dealloc
{
	//    [_addressDataArray release];
	[_a_tableView release];
	self.sourceType = 0;
	self.promptlable = nil;
	[super dealloc];
}


- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}



#pragma mark -
#pragma mark 数据加载方法

- (void) queryPassengersAddress // 邮寄地址列表
{
	ASIFormDataRequest * theRequest = [InterfaceClass getNewUserAddress:[UserInfo sharedUserInfo].userID]; //测试的UserID69743
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(ongetNewUserAddressPaseredResult:) Delegate:self needUserType:Member];
}

- (void)ongetNewUserAddressPaseredResult:(NSDictionary *)dic
{
	isRequestList = TRUE;
	passeAddressData = [PassengerAddressDataResponse queryPassengerAddressList:dic];
	self.addressDataArray = passeAddressData._passengerAddressArray;
	if (self.addressDataArray.count <=0) {
		
		self.promptlable.hidden = NO;
	}
	for (PassengerAddressItem * item in self.addressDataArray)
        {
		if ([self.addressItem._id isEqualToString:item._id]) {
			self.addressItem._postAddress = item._postAddress;
			break;
		}
        }
	
	[self.a_tableView reloadData];
}


#pragma mark -
#pragma mark 自定义方法

-(void) addPassenger: (id)sender
{
	if (self.addressDataArray.count>=3) {
		
		[UIAlertView alertViewWithMessage:@"常用邮寄地址最多可保留3条!" :@"提示"];
		
	}else {
		EditPassgersAddressViewController * editPassegersInfoVC = [[EditPassgersAddressViewController alloc] init];
		editPassegersInfoVC->passengersAddressVC = self;
		[self.navigationController pushViewController:editPassegersInfoVC animated:YES];
		[editPassegersInfoVC release];
	}
	
}


//点击编辑按钮
-(void)editClick:(id)sender
{
	UIButton *button = (UIButton*)sender;
	PassengerAddressItem * passengerAddressItem = (PassengerAddressItem*)[self.addressDataArray objectAtIndex:(button.tag-100)];
	EditPassgersAddressViewController * editPassegersInfoVC = [[EditPassgersAddressViewController alloc] init];
	editPassegersInfoVC.passengerAddressItem = passengerAddressItem;
	editPassegersInfoVC.index = (button.tag-100);
	editPassegersInfoVC->passengersAddressVC =self;
	[self.navigationController pushViewController:editPassegersInfoVC animated:YES];
	[editPassegersInfoVC release];
}

#pragma mark -
#pragma mark UITableView方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 150.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.addressDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString * identifier = @"PassengersAddressCell";
	PassengersAddressCell * cell = nil;
	PassengerAddressItem *passAddress = nil;
	passAddress = (PassengerAddressItem*)[self.addressDataArray objectAtIndex:indexPath.row];
	cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[PassengersAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		cell.backgroundColor = [UIColor clearColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		
	}
	
	if (self.sourceType ==0 ) {
		
		cell.mainView.hidden = YES;
		cell.passView.hidden = NO;
		cell.delegate = self;
		cell.name.text = passAddress._name;
		cell.postCode.text = passAddress._postCode;
        if (passAddress._province.length > 0) {
            
            cell.postAddress.text = [NSString stringWithFormat:@"%@%@%@ %@", passAddress._province, passAddress._city, passAddress._county, passAddress._postAddress];
        }
        else {
            cell.postAddress.text = passAddress._postAddress;
        }
		
		cell.editButton.tag = 100+indexPath.row;
		//passAddress._selected = @"0";
		if (memberVC.orderInfoData._postAddressItem) {
			if ([memberVC.orderInfoData._postAddressItem._id intValue] == [passAddress._id intValue])
			{
				cell.btnView.hidden = NO;
				passAddress._selected = @"1";
			}else {
				cell.btnView.hidden = YES;
			}
			
		}else if (self.addressItem) {
			if ([self.addressItem._id intValue] == [passAddress._id intValue])
			{
				cell.btnView.hidden = NO;
				passAddress._selected = @"1";
			}else {
				cell.btnView.hidden = YES;
			}
			
		}
		
	}else {
		cell.mainView.hidden = NO;
		cell.passView.hidden = YES;
		cell.mainName.text = passAddress._name;
		cell.mainPostCode.text = passAddress._postCode;
		if (passAddress._province.length > 0) {
            
            cell.mainPostAddress.text = [NSString stringWithFormat:@"%@%@%@ %@", passAddress._province, passAddress._city, passAddress._county, passAddress._postAddress];
        }
        else {
            cell.mainPostAddress.text = passAddress._postAddress;
        }
	}
	
	return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (self.sourceType == 0) {
		
		int i = 0;
		
		for (PassengersAddressCell* cell in [self.a_tableView visibleCells]) {
			PassengerAddressItem *tempPassItem = [self.addressDataArray objectAtIndex:i];
			tempPassItem._selected = @"0";
			cell.btnView.hidden = YES;
			i++;
			tempPassItem = nil;
			
		}
		[self.a_tableView deselectRowAtIndexPath:indexPath animated:YES];
		
		PassengerAddressItem *passengerAddressItem = [self.addressDataArray objectAtIndex:indexPath.row];
		passengerAddressItem._selected = @"1";
		((PassengersAddressCell*)[self.a_tableView cellForRowAtIndexPath:indexPath]).btnView.hidden = NO;
		memberVC.orderInfoData._postAddressItem = passengerAddressItem;
		
		self.addressItem._id = passengerAddressItem._id;
//		self.addressItem._postAddress = passengerAddressItem._postAddress;
        
        if (passengerAddressItem._province.length > 0) {
            
            self.addressItem._postAddress = [NSString stringWithFormat:@"%@%@%@ %@", passengerAddressItem._province, passengerAddressItem._city, passengerAddressItem._county, passengerAddressItem._postAddress];
            [BookingModel shareBookingModel]._mailInfo._address =[NSString stringWithFormat:@"%@%@%@ %@", passengerAddressItem._province, passengerAddressItem._city, passengerAddressItem._county, passengerAddressItem._postAddress];

        }
        else {
            self.addressItem._postAddress = passengerAddressItem._postAddress;
            [BookingModel shareBookingModel]._mailInfo._address = passengerAddressItem._postAddress;
        }
        [BookingModel shareBookingModel]._mailInfo._mailPostalcode = passengerAddressItem._postCode;
        [BookingModel shareBookingModel]._mailInfo._addressee = passengerAddressItem._name;
        [BookingModel shareBookingModel]._mailInfo._telPhone = passengerAddressItem._mobile;
        if ([passengerAddressItem._postAddress hasPrefix:@"广东省"]) {
            [BookingModel shareBookingModel]._mailInfo._mailPrice = @"12";
        }
        else
        {
             [BookingModel shareBookingModel]._mailInfo._mailPrice = @"20";
        }
        
		[self.navigationController popViewControllerAnimated:YES];
	}else {
		PassengerAddressItem * passengerAddressItem = (PassengerAddressItem*)[self.addressDataArray objectAtIndex:indexPath.row];
		EditPassgersAddressViewController * editPassegersInfoVC = [[EditPassgersAddressViewController alloc] init];
		editPassegersInfoVC.passengerAddressItem = passengerAddressItem;
		editPassegersInfoVC.index = indexPath.row;
		editPassegersInfoVC->passengersAddressVC =self;
		[self.navigationController pushViewController:editPassegersInfoVC animated:YES];
		[editPassegersInfoVC release];
	}
}

-(void)addAddressOverWithAddressItem:(PassengerAddressItem *)infoItem
{
    if (infoItem._province.length > 0) {
        [BookingModel shareBookingModel]._mailInfo._address =[NSString stringWithFormat:@"%@%@%@ %@", infoItem._province, infoItem._city, infoItem._county, infoItem._postAddress];
    }
    else {
        [BookingModel shareBookingModel]._mailInfo._address = infoItem._postAddress;
    }
    [BookingModel shareBookingModel]._mailInfo._mailPostalcode = infoItem._postCode;
    [BookingModel shareBookingModel]._mailInfo._addressee = infoItem._name;
    [BookingModel shareBookingModel]._mailInfo._telPhone = infoItem._mobile;
    if ([infoItem._postAddress hasPrefix:@"广东省"]) {
        [BookingModel shareBookingModel]._mailInfo._mailPrice = @"12";
    }
    else
    {
        [BookingModel shareBookingModel]._mailInfo._mailPrice = @"20";
    }
    
	if ([memberVC respondsToSelector:@selector(addAddressOverWithAddressItem:)]) {
		[memberVC performSelector:@selector(addAddressOverWithAddressItem:) withObject:infoItem];
	}
	
	if ([memberVC2 respondsToSelector:@selector(addAddressOverWithAddressItem:)]) {
		[memberVC2 performSelector:@selector(addAddressOverWithAddressItem:) withObject:infoItem];
	}
}


@end
