//
//  HotelFilterViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelFilterViewController.h"
#import "HotelFilterCell.h"
#import "HotelInquiryDataResponse.h"
#import "RadioViewController.h"
#import "HotelFilterNextViewController.h"
#import "HotelListViewController.h"
@interface HotelFilterViewController ()
//加载数据
- (void)loadHotelDataSource;
@end

@implementation HotelFilterViewController

@synthesize h_tableView = _h_tableView;
@synthesize hotelListArrat = _hotelListArrat;
@synthesize filterHoteDictionary,hoteNameDictionary,hoteInquiryNameDictionary,hotelRequestPara;

- (void)loadView{
	
	[super loadView];
	if ([self.hotelRequestPara._hotelArea isEqualToString:@""]) {
		
		self.hotelRequestPara._hotelArea = @"地区";
	}
	
	UISubLabel *titlelabel = [UISubLabel labelWithTitle:@"列表筛选" frame:CGRectMake(10.0f, 22.0f, 60.0f, 20.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
	titlelabel.textColor = FontColor333333;
	[self.view addSubview:titlelabel];
	
	_h_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,60.0f,ViewWidth,ViewHeight-104.0f) style:UITableViewStylePlain];  
	self.h_tableView.backgroundColor = [UIColor clearColor];
	self.h_tableView.dataSource = self;
	self.h_tableView.delegate = self;
	self.h_tableView.separatorColor = [UIColor clearColor];
	[self.view addSubview:self.h_tableView];
	
	UIImageView *bottomButtonImgView=[UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight-100.0f, ViewWidth, 50.0f)];
	bottomButtonImgView.image=[UIImage imageNamed:@"PassBottomButtonBg.png"];
	[self.view addSubview:bottomButtonImgView];
	
	
	
	submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(100.0f, ViewHeight-85.0f, 113.0f, 34.0f) backImage:[UIImage imageNamed:@"TicketQueryConnectSure.png"] target:self action:@selector(submit:)];
	[self.view addSubview:submitButton];
	
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.title = @"筛选";
	UIButton  * rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 7, 52, 30) backImage:[UIImage imageNamed:@"ResetButton.png"] target:self action:@selector(reset:)];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
	self.navigationItem.rightBarButtonItem = rightBar;
	[rightBar release];
	_hotelListArrat = [[NSMutableArray alloc] init];
	[self.h_tableView reloadData];
	
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}
- (void) dealloc {
	
	[_hotelListArrat release];
	[_h_tableView release];
	self.filterHoteDictionary = nil;
	self.hoteNameDictionary = nil;
	self.hoteInquiryNameDictionary = nil;
	self.hotelRequestPara = nil;
	[super dealloc];
	
}

#pragma mark -
#pragma mark 自定义方法

-(void) submit: (id)sender
{
	[self loadHotelDataSource];
}

-(void) reset: (id)sender
{
	self.hotelRequestPara._hotelName =@"";
	self.hotelRequestPara._highestPrice =@"0";
	self.hotelRequestPara._lowestPrice =@"0";
	self.hotelRequestPara._star = 0;
	self.hotelRequestPara._hotelBrandID =@"0";
	self.hotelRequestPara._longitude =@"";
	self.hotelRequestPara._latitude =@"";
	self.hotelRequestPara._pageIndex = 1;
	self.hotelRequestPara._byStar = @"";
	self.hotelRequestPara._byPrice = @"";
	self.hotelRequestPara._administrativeArea =@"";
	self.hotelRequestPara._businessArea =@"";
	self.hotelRequestPara._hotelArea = @"地区";
	self.hotelRequestPara._priceName = @"房价";
	self.hotelRequestPara._starName = @"星级";
	self.hotelRequestPara._hotelBrandName = @"品牌";
	
	[self.h_tableView reloadData];
	
	
}

//加载数据
- (void)loadHotelDataSource
{
	
	ASIFormDataRequest * theRequest = [InterfaceClass queryHotel:self.hotelRequestPara];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryHotelPaseredResult:) Delegate:self needUserType:Default];
	
}


- (void)onqueryHotelPaseredResult:(NSDictionary *)dic
{
	HotelQueryDataResponse *hotelDataResponse = [HotelQueryDataResponse hotelQuery:dic];
	if (hotelDataResponse._hotelQueryInfoArray.count>0) {
		hotelListVC.hotelListArray = hotelDataResponse._hotelQueryInfoArray;
		self.hotelRequestPara._pageIndex = 1;
		hotelListVC.specialOfferNumber = hotelDataResponse._specialOfferNumber;
		hotelListVC.hotelRequestPara = self.hotelRequestPara;
		if ([hotelDataResponse._number intValue]<=HOTEL_NUMBER_PAGE) {
			
			hotelListVC.isfromRecomend = TRUE;
			[hotelListVC isrefreshHeaderView];
			[hotelListVC.h_tableView reloadData];
			if (hotelListVC.isLastPage) {
				hotelListVC.h_tableView.contentSize = CGSizeMake(ViewWidth, hotelListVC.h_tableView.contentSize.height-65.0f);
				
			}else{
				hotelListVC.h_tableView.contentSize = CGSizeMake(ViewWidth, hotelListVC.h_tableView.contentSize.height);

			}
		}else {
			hotelListVC.isfromRecomend = FALSE;
			[hotelListVC isrefreshHeaderView];
			[hotelListVC loadFitstDataSource];
			hotelListVC.isLastPage = FALSE;
		}

		//[hotelListVC transferHotelRequestPara];
		
		//[hotelListVC.h_tableView reloadData];
		[NavigationController popViewControllerAnimated:YES];
		
	}else {
		[UIAlertView alertViewWithMessage:@"未查询到您搜索的酒店" :@"提示"];
	}
	
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
	
	return self.hoteNameDictionary.count + (self.hoteInquiryNameDictionary.count>0 ? 1 : 0);
	
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{		
	
	return 45.0f;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * identifier = @"identifier";
	HotelFilterCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[HotelFilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		cell.backgroundColor = [UIColor clearColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
	}
	// Configure the cell...
	if (self.hoteInquiryNameDictionary.count>0) {
		if (indexPath.row==0) {
			cell.name.text = self.hotelRequestPara._hotelArea;
		}else {
			NSString *titleName = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
			if ([titleName isEqualToString:@"酒店房价"]) {
				NSMutableArray *mutableArray =   [self.filterHoteDictionary objectForKey:@"酒店房价"];
				if (mutableArray.count>0) {
					cell.name.text = self.hotelRequestPara._priceName;
				}else {
					cell.name.text = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
				}
			}
			if ([titleName isEqualToString:@"酒店星级"]) {
				NSMutableArray *mutableArray =   [self.filterHoteDictionary objectForKey:@"酒店星级"];
				if (mutableArray.count>0) {
					cell.name.text = self.hotelRequestPara._starName;
				}else {
					cell.name.text = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
				}
			}
			
			if ([titleName isEqualToString:@"品牌"]) {
				NSMutableArray *mutableArray =   [self.filterHoteDictionary objectForKey:@"品牌"];
				if (mutableArray.count>0) {
					cell.name.text = self.hotelRequestPara._hotelBrandName;
				}else {
					cell.name.text = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
				}
			}
			
		}
		
	}else {
		
		//cell.name.text = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",(indexPath.row+1)]];
		NSString *titleName = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",(indexPath.row+1)]];
		if ([titleName isEqualToString:@"酒店房价"]) {
			NSMutableArray *mutableArray =   [self.filterHoteDictionary objectForKey:@"酒店房价"];
			if (mutableArray.count>0) {
				cell.name.text = self.hotelRequestPara._priceName;
			}else {
				cell.name.text = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",(indexPath.row+1)]];
			}
		}
		if ([titleName isEqualToString:@"酒店星级"]) {
			NSMutableArray *mutableArray =   [self.filterHoteDictionary objectForKey:@"酒店星级"];
			if (mutableArray.count>0) {
				cell.name.text = self.hotelRequestPara._starName;
			}else {
				cell.name.text = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",(indexPath.row+1)]];
			}
		}
		
		if ([titleName isEqualToString:@"品牌"]) {
			NSMutableArray *mutableArray =   [self.filterHoteDictionary objectForKey:@"品牌"];
			if (mutableArray.count>0) {
				cell.name.text = self.hotelRequestPara._hotelBrandName;
			}else {
				cell.name.text = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",(indexPath.row+1)]];
			}
		}
		
	}
	
	if (indexPath.row==0) {
		cell.inquiryBgView.image = [UIImage imageNamed:@"HotelFilterCellBg1.png"];
	}
	if (indexPath.row ==([self.hoteNameDictionary count])) {
		cell.inquiryBgView.image = [UIImage imageNamed:@"HotelFilterCellBg3.png"];
	}
	
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	RadioViewController *radioVC = nil;
	HotelFilterNextViewController *hotelFilterNextVC = nil;
	
	if (self.hoteInquiryNameDictionary.count>0) {
		if (indexPath.row==0) {
			hotelFilterNextVC = [[HotelFilterNextViewController alloc] init];
			hotelFilterNextVC.hoteNameDictionary = self.hoteInquiryNameDictionary;
			hotelFilterNextVC.filterHoteDictionary = self.filterHoteDictionary;
			hotelFilterNextVC.hotelRequestPara = self.hotelRequestPara;
			[NavigationController pushViewController:hotelFilterNextVC animated:YES];
			[hotelFilterNextVC release];
		}else {
			
			NSString *tempName = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
			if ([tempName isEqualToString:@"酒店房价"]) {
				radioVC = [[RadioViewController alloc] init];
				radioVC.radioArray =  [self.filterHoteDictionary objectForKey:@"酒店房价"];
				radioVC.radioTitle = @"酒店房价";
				radioVC.filterHotelType = HotelCharges;
				radioVC.popType = PopHotelFitler;
				radioVC.hotelRequestPara = self.hotelRequestPara;
				[NavigationController pushViewController:radioVC animated:YES];
				[radioVC release];
			}
			if ([tempName isEqualToString:@"酒店星级"]) {
				radioVC = [[RadioViewController alloc] init];
				radioVC.radioArray =  [self.filterHoteDictionary objectForKey:@"酒店星级"];
				radioVC.radioTitle =@"酒店星级";
				radioVC.filterHotelType = HotelLevel;
				radioVC.popType = PopHotelFitler;
				radioVC.hotelRequestPara = self.hotelRequestPara;
				[NavigationController pushViewController:radioVC animated:YES];
				[radioVC release];
			}
			if ([tempName isEqualToString:@"品牌"]) {
				radioVC = [[RadioViewController alloc] init];
				radioVC.radioArray =  [self.filterHoteDictionary objectForKey:@"品牌"];
				radioVC.radioTitle = @"品牌";
				radioVC.filterHotelType = HotelBrand;
				radioVC.popType = PopHotelFitler;
				radioVC.hotelRequestPara = self.hotelRequestPara;
				[NavigationController pushViewController:radioVC animated:YES];
				[radioVC release];
			}
		}
	}else {
		
		NSString *tempName = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",(indexPath.row+1)]];
		if ([tempName isEqualToString:@"酒店房价"]) {
			radioVC = [[RadioViewController alloc] init];
			radioVC.radioArray =  [self.filterHoteDictionary objectForKey:@"酒店房价"];
			radioVC.radioTitle = @"酒店房价";
			radioVC.filterHotelType = HotelCharges;
			radioVC.popType = PopHotelFitler;
			radioVC.hotelRequestPara = self.hotelRequestPara;
			[NavigationController pushViewController:radioVC animated:YES];
			[radioVC release];
		}
		if ([tempName isEqualToString:@"酒店星级"]) {
			radioVC = [[RadioViewController alloc] init];
			radioVC.radioArray =  [self.filterHoteDictionary objectForKey:@"酒店星级"];
			radioVC.radioTitle = @"酒店星级";
			radioVC.filterHotelType = HotelLevel;
			radioVC.popType = PopHotelFitler;
			radioVC.hotelRequestPara = self.hotelRequestPara;
			[NavigationController pushViewController:radioVC animated:YES];
			[radioVC release];
		}
		if ([tempName isEqualToString:@"品牌"]) {
			radioVC = [[RadioViewController alloc] init];
			radioVC.radioArray =  [self.filterHoteDictionary objectForKey:@"品牌"];
			radioVC.radioTitle = @"品牌";
			radioVC.filterHotelType = HotelBrand;
			radioVC.popType = PopHotelFitler;
			radioVC.hotelRequestPara = self.hotelRequestPara;
			[NavigationController pushViewController:radioVC animated:YES];
			[radioVC release];
		}
	}
	
	
	
	
	
}




@end
