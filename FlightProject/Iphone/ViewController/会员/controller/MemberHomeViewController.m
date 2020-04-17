//
//  MemberHomeViewController.m
//  FlightProject
//
//  Created by longcd on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberHomeViewController.h"
#import "WoyinPassagerListViewController.h"
#import "PassengersAddressViewController.h"
#import "PassengersInfoCell.h"
#import "PassengerInfoDataResponse.h"
#import "MemberLoginViewController.h"
#import "EditorMemberInfoViewController.h"
#import "MemberOrderViewController.h"
#import "EditorPasswordViewController.h"
#import "MyLCDCoinViewController.h"
#import "MyLCDCoinDataResponse.h"
#import "OrderHotelLisViewController.h"
#import "OrderCarListViewController.h"
#import "InterfaceClass.h"
#import "GetOrderHotelList.h"
#import "GetOrderCarList.h"
#import "MemberDataResponse.h"
#import "SelectCreditCardViewController.h"
#import "MyMonthlyBillsViewController.h"
#import "PickUpPersonListViewController.h"
#import "WoyinOrderListViewController.h"

@interface MemberHomeViewController ()
- (void)loadDataSource;
//加载用户编辑数据
- (void)loadMemberInfoDataSource;
@end

@implementation MemberHomeViewController



@synthesize m_tableView,dataDic,sectionArray;

- (void)dealloc
{
	self.m_tableView = nil;
	self.dataDic = nil;
	self.sectionArray = nil;
	[super dealloc];
}



//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];

	NSArray * array =  [NSArray arrayWithObjects:[NSArray arrayWithObjects:[UserInfo sharedUserInfo].telePhone?[UserInfo sharedUserInfo].telePhone:@"",@"editorMemberInfo",@"MembertableViewCell.png", nil],[NSArray arrayWithObjects:@"修改密码",@"modifyPassWord", @"HotelFilterCellBg3.png",nil], nil];
	[self.dataDic setObject:array forKey:[self.sectionArray objectAtIndex:0]];
	if (self._pointView._pointLab.tag == 0) {
		self._pointView.hidden = YES;
	}
	else {
		if (self._pointView._pointLab.tag > 9) {
			self._pointView._pointLab.text = @"N";
		}
		else{
			self._pointView._pointLab.text = [NSString stringWithFormat:@"%d",self._pointView._pointLab.tag];
		}
		self._pointView.hidden = NO;
	}
	NSLog(@"标签数%@", self._pointView._pointLab.text);
    [UserInfo sharedUserInfo].lcdCurrency = @"0";
    [self setDataForTableView];
	[self.m_tableView reloadData];
    
    
    ASIFormDataRequest * theRequest = [InterfaceClass getLcdCurrency:[UserInfo sharedUserInfo].userID];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGetLcdCurrencyResult:) Delegate:self needUserType:Member];

}
- (void)viewDidLoad
{
	[super viewDidLoad];
	UIButton  * rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 7, 52, 30) backImage:[UIImage imageNamed:@"loginOut.png"] target:self action:@selector(loginOut)];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
	self.navigationItem.rightBarButtonItem = rightBar;
	[rightBar release];
	
	page = 1;
	
	self.title = @"我的航旅";
	
	// Do any additional setup after loading the view.
//	NSLog(@"[UserInfo sharedUserInfo].lcdCurrency===%@",[UserInfo sharedUserInfo].lcdCurrency);
//    CGSize maxSize=CGSizeMake(280, 99999);
//    strSize =[[NSString stringWithFormat:@"%d", [[UserInfo sharedUserInfo].lcdCurrency intValue]] sizeWithFont:FontSize32 constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
//    
//	self.sectionArray = [NSArray arrayWithObjects:@"个人信息", @"我的畅达币",@"订单管理",@"信息管理",nil];
//	self.dataDic = [NSMutableDictionary dictionaryWithObjects:
//			[NSArray arrayWithObjects:
//			 [NSArray arrayWithObjects:[NSArray arrayWithObjects:[UserInfo sharedUserInfo].telePhone?[UserInfo sharedUserInfo].telePhone:@"",@"editorMemberInfo",@"MembertableViewCell.png", nil],[NSArray arrayWithObjects:@"修改密码",@"modifyPassWord", @"HotelFilterCellBg3.png",nil], nil],
//			 
//			 [NSArray arrayWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@ %@",@"畅达币总数: ",[UserInfo sharedUserInfo].lcdCurrency],@"lookCdb", @"MembertableViewCell.png", nil],[NSArray arrayWithObjects:@"每月账单",@"monthlyBills", @"MembertableViewCell.png",nil], nil],
//			 
//			 [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"机票订单",@"ticketOrders",@"HotelFilterCellBg1.png", nil], [NSArray arrayWithObjects:@"酒店订单",@"hotelOrders", @"HotelFilterCellBg2.png", nil],[NSArray arrayWithObjects:@"租车订单",@"carOrders",@"HotelFilterCellBg3.png",  nil], nil],
//			 
//			 [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"常用乘机人",@"passegers",@"HotelFilterCellBg1.png",  nil], [NSArray arrayWithObjects:@"常用邮寄地址",@"address", @"HotelFilterCellBg2.png", nil] ,[NSArray arrayWithObjects:@"常用信用卡",@"creditCards",@"HotelFilterCellBg2.png",  nil],[NSArray arrayWithObjects:@"常用租车人",@"carPassegers",@"HotelFilterCellBg3.png",  nil], nil],
//			 nil] forKeys: self.sectionArray ];
	
    

	UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0 ,5,ViewWidth,ViewHeight-54.0f) style:UITableViewStylePlain]; 
	self.m_tableView = tableView;
	[tableView release];
	self.m_tableView.backgroundColor = [UIColor clearColor];
	self.m_tableView.dataSource = self;
	self.m_tableView.delegate = self;
	self.m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	[self.view addSubview:self.m_tableView];
	
	
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

//加载数据
- (void)loadDataSource
{
	//+(ASIFormDataRequest *)myLCDCoin:(NSString *)userId withPage:(NSString *)page //30
	ASIFormDataRequest * theRequest = [InterfaceClass myLCDCoin:[UserInfo sharedUserInfo].userID withPage:[NSString stringWithFormat:@"%d",page]];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onmyLCDCoinPaseredResult:) Delegate:self needUserType:Member];
	
}


//加载用户编辑数据
- (void)loadMemberInfoDataSource
{
	
	ASIFormDataRequest * theRequest = [InterfaceClass getPersonalInformation:[UserInfo sharedUserInfo].userID];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredMemberInfoResult:) Delegate:self needUserType:Member];
	
}

-(void)setDataForTableView
{
    NSLog(@"[UserInfo sharedUserInfo].lcdCurrency===%@",[UserInfo sharedUserInfo].lcdCurrency);
    CGSize maxSize=CGSizeMake(280, 99999);
    strSize =[[NSString stringWithFormat:@"%d", [[UserInfo sharedUserInfo].lcdCurrency intValue]] sizeWithFont:FontSize32 constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    
	self.sectionArray = [NSArray arrayWithObjects:@"个人信息", @"我的畅达币",@"订单管理",@"信息管理",nil];
	self.dataDic = [NSMutableDictionary dictionaryWithObjects:
                    [NSArray arrayWithObjects:
                     [NSArray arrayWithObjects:[NSArray arrayWithObjects:[UserInfo sharedUserInfo].telePhone?[UserInfo sharedUserInfo].telePhone:@"",@"editorMemberInfo",@"MembertableViewCell.png", nil],[NSArray arrayWithObjects:@"修改密码",@"modifyPassWord", @"HotelFilterCellBg3.png",nil], nil],
                     
                     [NSArray arrayWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@ %@",@"畅达币总数: ",[UserInfo sharedUserInfo].lcdCurrency],@"lookCdb", @"MembertableViewCell.png", nil],[NSArray arrayWithObjects:@"每月账单",@"monthlyBills", @"MembertableViewCell.png",nil], nil],
                     
                     [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"机票订单",@"ticketOrders",@"HotelFilterCellBg1.png", nil], [NSArray arrayWithObjects:@"酒店订单",@"hotelOrders", @"HotelFilterCellBg2.png", nil],[NSArray arrayWithObjects:@"租车订单",@"carOrders",@"HotelFilterCellBg2.png",  nil],[NSArray arrayWithObjects:@"火车票订单",@"TrainOrders",@"HotelFilterCellBg3.png",  nil], nil],
                     
                     [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"常用旅客",@"passegers",@"HotelFilterCellBg1.png",  nil],[NSArray arrayWithObjects:@"常用联系人",@"pickperson", @"HotelFilterCellBg2.png", nil] , [NSArray arrayWithObjects:@"常用邮寄地址",@"address", @"HotelFilterCellBg2.png", nil] ,[NSArray arrayWithObjects:@"常用信用卡",@"creditCards",@"HotelFilterCellBg2.png",  nil],[NSArray arrayWithObjects:@"常用租车人",@"carPassegers",@"HotelFilterCellBg3.png",  nil], nil],
                     nil] forKeys: self.sectionArray ];
    
    [self.m_tableView reloadData];

}
-(void)onGetLcdCurrencyResult:(NSDictionary*)dic
{
    NSLog(@"%@",[dic objectForKey:@"lcdCurrency"]);
    [UserInfo sharedUserInfo].lcdCurrency = [NSString stringWithFormat:@"%@",[dic objectForKey:@"lcdCurrency"]];
    [self setDataForTableView];
    
}

//返回处理
- (void)onmyLCDCoinPaseredResult:(NSDictionary *)dic
{
	
	myLCDCoinDataResponse = [MyLCDCoinDataResponse myLCDCoin:dic];
	myLCDCoinInfo = myLCDCoinDataResponse._myLCDCoinInfo;
//	availableLcdCurrency= [myLCDCoinInfo._availableLcdCurrency intValue];
	coinArray = myLCDCoinDataResponse._myLCDCoinDetailArray;
	
//	NSArray * array =  [NSArray arrayWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@ %d",@"畅达币总数: ",availableLcdCurrency],@"lookCdb", @"MembertableViewCell.png", nil],[NSArray arrayWithObjects:@"每月账单",@"monthlyBills", @"MembertableViewCell.png",nil],nil ] ;
//	[self.dataDic setObject:array forKey:[self.sectionArray objectAtIndex:1]];
//    
//    CGSize maxSize=CGSizeMake(280, 99999);
//    strSize =[[NSString stringWithFormat:@"%d", availableLcdCurrency] sizeWithFont:FontSize32 constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
	
//	[self.m_tableView reloadData];
    MyLCDCoinViewController *myLCDCoinVC = [[MyLCDCoinViewController alloc] init];
	myLCDCoinVC.myLcdDataArray = coinArray;
	myLCDCoinVC.myLCDCoinInfo = myLCDCoinInfo;
	[self.navigationController pushViewController:myLCDCoinVC animated:YES];
	[myLCDCoinVC release];
	
}
//返回处理
- (void)onPaseredMemberInfoResult:(NSDictionary *)dic
{
	
	[MemberDataResponse getPersonalInformation:dic];
	
	EditorMemberInfoViewController *editorVC = [[EditorMemberInfoViewController alloc] init];
	[self.navigationController pushViewController:editorVC animated:YES];
	[editorVC release];
	
}

//注销用户
-(void) loginOut
{
	UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认注销么?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
	[alert show];
	[alert release];
	


}

#pragma mark -
#pragma mark UIAlertView
- (void) alertView:(UIAlertView *)alertview clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if (buttonIndex==1) {
		self._pointView._pointLab.tag = 0;
		
		[UserInfo sharedUserInfo].userID = @"";
		[UserInfo sharedUserInfo].telePhone = @"";
		[UserInfo sharedUserInfo].email = @"";
		[UserInfo sharedUserInfo].password = @"";
		[UserInfo sharedUserInfo].name = @"";
		
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:keyAudioLogin];
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:keyLoginUserID];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		//我的畅达币 变成0
		NSArray * array =  [NSArray arrayWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@ %@",@"畅达币总数: ",@""],@"lookCdb", @"MembertableViewCell.png", nil],[NSArray arrayWithObjects:@"每月账单",@"monthlyBills", @"MembertableViewCell.png",nil],nil ] ;
		[self.dataDic setObject:array forKey:[self.sectionArray objectAtIndex:1]];
		
		[self.m_tableView reloadData];
		
		MemberLoginViewController  * memberLoginVC = [[MemberLoginViewController alloc] init];
		memberLoginVC.delegate = self;
		[NavigationController pushViewController:memberLoginVC animated:NO];
		[memberLoginVC release];
	}
	
	
}

-(void)loginBack
{
    
    [NavigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
	// Return the number of sections.
	return [self.sectionArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.row == 0)
	{
		return 30;
	}
	if (indexPath.section == 2 || indexPath.section== 3) {
		return 44;
	}else {
		return 50;
	}
	
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
	// Return the number of rows in the section.
	NSArray * array = [self.dataDic objectForKey:[self.sectionArray objectAtIndex:section]];
	return [array count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * identifier =@"identifier";
	
	UITableViewCell * cell =nil;
    
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		cellImageView = [UIImageView ImageViewWithFrame:CGRectMake(10, 1, tableView.frame.size.width-20, 44) image:nil];
		cellImageView.tag = 10;
		[cell addSubview:cellImageView];
        UISubLabel * label = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 3, tableView.frame.size.width - 40, 44) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentLeft];
		label.tag = 99;
        [cell addSubview:label];
        UISubLabel * labeltitle = [UISubLabel labelWithTitle:nil frame:CGRectMake(10, 0, tableView.frame.size.width - 40, 30) font:FontSize32 color:FontColor656565 alignment:NSTextAlignmentLeft];
		labeltitle.tag = 199;
        [cell addSubview:labeltitle];
        cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.backgroundColor = [UIColor clearColor];

    }
    if (indexPath.row==0) {
        UISubLabel * labeltitle = (UISubLabel *)[cell viewWithTag:199];
        labeltitle.text = [self.sectionArray objectAtIndex:indexPath.section];
        UISubLabel * label = (UISubLabel *)[cell viewWithTag:99];
        label.text =nil;
        cellImageView.image = nil;
    }
    else {
        UISubLabel * labeltitle = (UISubLabel *)[cell viewWithTag:199];
        labeltitle.text =nil;
        NSArray * array = [self.dataDic objectForKey:[self.sectionArray objectAtIndex:indexPath.section]];
        UISubLabel * label = (UISubLabel *)[cell viewWithTag:99];
        label.text = [[array objectAtIndex:indexPath.row - 1] objectAtIndex:0];
	    UIImage *image = [UIImage imageNamed:[[array objectAtIndex:indexPath.row-1] objectAtIndex:2]];
	    image = [image stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        cellImageView.image = image;
        if (indexPath.section == 1  && indexPath.row == 1) {
            
            UIImageView *imgView = [UIImageView ImageViewWithFrame:CGRectMake(125.0f + strSize.width, 15.0f, 20.0f, 20.0f) image:[UIImage imageNamed:@"DollarIcon.png"]];
            imgView.hidden = YES;
            
            if (strSize.width > 0) {
                imgView.hidden = NO;
            }
            
            [cell addSubview:imgView];
        }
        if (indexPath.section==2 && indexPath.row == 1)  {
				self._pointView.frame = CGRectMake(85, 5, 15, 15);
				[cell addSubview:self._pointView];
		}
    }
	cell.backgroundColor = [UIColor clearColor];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row==0) {
		return;
	}
    
    [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 2, 300, 44)];
	NSArray * array = [self.dataDic objectForKey:[self.sectionArray objectAtIndex:indexPath.section]] ;
	SEL selector = NSSelectorFromString([[array objectAtIndex:indexPath.row-1] objectAtIndex:1]);
	if ([self respondsToSelector:selector]) {
		[self performSelector:selector];
	}
}
-(void) editorMemberInfo // 编辑个人信息
{
	
	[self loadMemberInfoDataSource];
	
}
-(void) modifyPassWord
{
	NSLog(@"%s",__FUNCTION__);
	EditorPasswordViewController *editorPasswordVC = [[EditorPasswordViewController alloc] init];
	editorPasswordVC.userInfo = [UserInfo sharedUserInfo];
	[self.navigationController pushViewController:editorPasswordVC animated:YES];
	[editorPasswordVC release];
}
-(void) lookCdb
{
	NSLog(@"%s",__FUNCTION__);
    [self loadDataSource];
}
-(void)monthlyBills
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"monthlyBills");
    MyMonthlyBillsViewController *myMonthlyBillsVC = [[MyMonthlyBillsViewController alloc] init];
    [self.navigationController pushViewController:myMonthlyBillsVC animated:YES];
    [myMonthlyBillsVC release];
}
-(void) ticketOrders
{
	NSLog(@"%s",__FUNCTION__);
	
	ASIFormDataRequest * theRequest = [InterfaceClass flightsOrdersList:[UserInfo sharedUserInfo].userID withPageIndex:@"1"];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onflightsOrdersListPaseredResult:) Delegate:self needUserType:Member];
	
}
-(void) hotelOrders
{
	NSLog(@"%s",__FUNCTION__);
	ASIFormDataRequest * theRequest = [InterfaceClass orderHotelListByUserId:[UserInfo sharedUserInfo].userID withPageIndex:@"1"];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onHotelListPaseredResult:) Delegate:self needUserType:Member];
}
-(void) carOrders
{
	NSLog(@"%s",__FUNCTION__);
	ASIFormDataRequest * theRequest = [InterfaceClass orderCarListByUserId:[UserInfo sharedUserInfo].userID withPageIndex:@"1"];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCarListPaseredResult:) Delegate:self needUserType:Member];
}
-(void)TrainOrders
{
    WoyinOrderListViewController * passengersVC = [[WoyinOrderListViewController alloc] init];
    [self.navigationController pushViewController:passengersVC animated:YES];
    [passengersVC release];
    
//    NSLog(@"%s",__FUNCTION__);
//    ASIFormDataRequest * theRequest = [InterfaceClass findOrderSimpleList];
//    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onfindOrderSimpleListResult:) Delegate:self needUserType:Member];
}
-(void)onfindOrderSimpleListResult:(NSDictionary *)result
{
    NSArray * orderList = [result objectForKey:@"orderList"];
    NSMutableArray * _mArr = [NSMutableArray array];
    if ([orderList isKindOfClass:[NSArray class]]) {
        for (NSDictionary * train in orderList) {
            [_mArr addObject:[TrainOrderItem TrainOrderListItemInfoWithDic:train]];
        }
    }
    WoyinOrderListViewController * passengersVC = [[WoyinOrderListViewController alloc] init];
    passengersVC._dataArrayAll = _mArr;
    [self.navigationController pushViewController:passengersVC animated:YES];
    [passengersVC release];
}
-(void) passegers
{
	NSLog(@"%s",__FUNCTION__);
//	PassengersInfoViewController * passengersVC = [[PassengersInfoViewController alloc] init];
//	passengersVC.sourceType = HomeSourceType;
//	passengersVC.currentYear = [NSDate date];
//    passengersVC.currentYearBack = [NSDate date];
//	passengersVC.surplusTicket = 0;
//	[self.navigationController pushViewController:passengersVC animated:YES];
//	[passengersVC release];
	
    
    WoyinPassagerListViewController * passengersVC = [[WoyinPassagerListViewController alloc] init];
    passengersVC._viewType = @"1";
    [self.navigationController pushViewController:passengersVC animated:YES];
    [passengersVC release];
}

-(void) pickperson
{
	PickUpPersonListViewController *pickVC = [[PickUpPersonListViewController alloc]init];
	pickVC.sourceType = HomeSourceType;
	[self.navigationController pushViewController:pickVC animated:YES];
	[pickVC release];
}
-(void) address
{
	NSLog(@"%s",__FUNCTION__);
	PassengersAddressViewController *passAddressVC = [[PassengersAddressViewController alloc] init];
	passAddressVC.sourceType = HomeSourceType;
	[self.navigationController pushViewController:passAddressVC animated:YES];
	[passAddressVC release];
}
-(void)creditCards
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"creditCards");
    SelectCreditCardViewController *selectCreditCardVC = [[SelectCreditCardViewController alloc] init];
    selectCreditCardVC.title = @"常用信用卡";
    selectCreditCardVC.sourceType = NO;
    [self.navigationController pushViewController:selectCreditCardVC animated:YES];
    [selectCreditCardVC release];
}
-(void)carPassegers
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"carPassegers");
    
    CarPassengerListViewController * carPassengerVC = [[CarPassengerListViewController alloc] init];
    carPassengerVC.title = @"常用租车人";
    carPassengerVC.gateway = @"1";
    [NavigationController pushViewController:carPassengerVC animated:YES];
    [carPassengerVC release];
}
-(void)onflightsOrdersListPaseredResult:(NSDictionary*)dic
{
	MemberOrderViewController *memberOrderVC = [[MemberOrderViewController alloc] init];
	memberOrderVC._dataIsFull = YES;
	memberOrderVC.data = (NSMutableArray *)[MemberOrderInfo MemberOrderList:dic];
    memberOrderVC.totalPage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalPage"]];
    if ([memberOrderVC.totalPage intValue] <= 1 || [memberOrderVC.totalPage isEqualToString:@"(null)"]) {
		memberOrderVC.isfromRecomend = TRUE;
	}
	memberOrderVC.filterDataArray =(NSMutableArray *)[MemberOrderInfo MemberOrderList:dic];
    memberOrderVC.pageIndex = 1;
	[NavigationController pushViewController:memberOrderVC animated:YES];
	[memberOrderVC release];
}
-(void)onHotelListPaseredResult:(NSDictionary*)dic
{
	OrderHotelLisViewController *hotelLisOrderVC = [[OrderHotelLisViewController alloc] init];
	hotelLisOrderVC._dataIsFull = YES;
	hotelLisOrderVC.getOrderHotelList = (GetOrderHotelList*)[GetOrderHotelList GetOrderHotelList:dic];
	if ([hotelLisOrderVC.getOrderHotelList.totalPage intValue] <= 1 || [hotelLisOrderVC.getOrderHotelList.totalPage isEqualToString:@"(null)"]) {
		hotelLisOrderVC.isfromRecomend = TRUE;
	}
	hotelLisOrderVC.currentHotelList = (GetOrderHotelList*)[GetOrderHotelList GetOrderHotelList:dic];
    hotelLisOrderVC.pageIndex = 1;
	[NavigationController pushViewController:hotelLisOrderVC animated:YES];
	[hotelLisOrderVC release];
}

-(void)onCarListPaseredResult:(NSDictionary*)dic
{
	OrderCarListViewController *carListViewController = [[OrderCarListViewController alloc] init];
	carListViewController._dataIsFull = YES;
	carListViewController.getOrderCarList = (GetOrderCarList*)[GetOrderCarList GetOrderCarList:dic];
    if([carListViewController.getOrderCarList.totalPage intValue] <= 1 || [carListViewController.getOrderCarList.totalPage isEqualToString:@"(null)"])
    {
		carListViewController.isfromRecomend = TRUE;
	}
	carListViewController.currentCarList = (GetOrderCarList*)[GetOrderCarList GetOrderCarList:dic];
    carListViewController.pageIndex = 1;
	[NavigationController pushViewController:carListViewController animated:YES];
	[carListViewController release];
}
@end
