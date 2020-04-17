//
//  HotelFilterNextViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelFilterNextViewController.h"
#import "HotelFilterCell.h"
#import "HotelInquiryDataResponse.h"
#import "RadioViewController.h"
#import "CheckedViewController.h"
@interface HotelFilterNextViewController ()

@end

@implementation HotelFilterNextViewController

@synthesize h_tableView = _h_tableView;
@synthesize hotelListArrat = _hotelListArrat;
@synthesize filterHoteDictionary,hoteNameDictionary,hotelRequestPara;

- (void)loadView{
	
	[super loadView];
	
	UISubLabel *titlelabel = [UISubLabel labelWithTitle:@"列表筛选" frame:CGRectMake(10.0f, 22.0f, 60.0f, 20.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
	titlelabel.textColor = FontColor333333;
	[self.view addSubview:titlelabel];
	
	_h_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,60.0f,ViewWidth,ViewHeight-104.0f) style:UITableViewStylePlain];  
	self.h_tableView.backgroundColor = [UIColor clearColor];
	self.h_tableView.dataSource = self;
	self.h_tableView.delegate = self;
	self.h_tableView.separatorColor = [UIColor clearColor];
	[self.view addSubview:self.h_tableView];
	
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.title = @"筛选";
	
	_hotelListArrat = [[NSMutableArray alloc] init];
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
	self.hotelRequestPara = nil;
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
	
	return [self.hoteNameDictionary count];
	
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
	
	cell.name.text = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
	
	if (indexPath.row==0) {
		cell.inquiryBgView.image = [UIImage imageNamed:@"HotelFilterCellBg1.png"];
	}
	if (indexPath.row ==([self.hoteNameDictionary count])) {
		cell.inquiryBgView.image = [UIImage imageNamed:@"HotelFilterCellBg3.png"];
	}
	
	//	switch (indexPath.row) {
	//		case 0:
	//			cell.name.text = @"行政区";
	//			cell.inquiryBgView.image = [UIImage imageNamed:@"HotelFilterCellBg1.png"];
	//			break;
	//		case 1:
	//			cell.name.text = @"交通枢纽";
	//			break;
	//		case 2:
	//			cell.name.text = @"热门商圈";
	//			break;
	//		case 3:
	//			cell.name.text = @"地铁";
	//			cell.inquiryBgView.image = [UIImage imageNamed:@"HotelFilterCellBg3.png"];
	//			break;
	//			
	//			
	//		default:
	//			break;
	//	}
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	RadioViewController *radioVC = nil;
	CheckedViewController *checkedVC = nil;
	
	
	NSString *tempName = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
	
	if ([tempName isEqualToString:@"行政区"]) {
		radioVC = [[RadioViewController alloc] init];
		radioVC.radioArray =  [self.filterHoteDictionary objectForKey:@"行政区"];
		radioVC.radioTitle = @"行政区";
		radioVC.filterHotelType = HotelAdministrativeArea;
		radioVC.popType = PopHotelFitler;
		radioVC.hotelRequestPara = self.hotelRequestPara;
		[NavigationController pushViewController:radioVC animated:YES];
		[radioVC release];
	}
	if ([tempName isEqualToString:@"热门商圈"]) {
		radioVC = [[RadioViewController alloc] init];
		radioVC.radioArray =  [self.filterHoteDictionary objectForKey:@"热门商圈"];
		radioVC.radioTitle = @"热门商圈";
		radioVC.filterHotelType = HotelBusinessArea;
		radioVC.popType = PopHotelFitler;
		radioVC.hotelRequestPara = self.hotelRequestPara;
		[NavigationController pushViewController:radioVC animated:YES];
		[radioVC release];
	}
	if ([tempName isEqualToString:@"地铁"]) {
		checkedVC = [[CheckedViewController alloc] init];
		checkedVC.checkedArray =  [self.filterHoteDictionary objectForKey:@"地铁"];
		checkedVC.checkedTitle =@"地铁";
		checkedVC.filterHotelType = HotelMetro;
		checkedVC.popType = PopHotelFitler;
		checkedVC.hotelRequestPara = self.hotelRequestPara;
		[NavigationController pushViewController:checkedVC animated:YES];
		[checkedVC release];
	}
	if ([tempName isEqualToString:@"交通枢纽"]) {
		radioVC = [[RadioViewController alloc] init];
		radioVC.radioArray =  [self.filterHoteDictionary objectForKey:@"交通枢纽"];
		radioVC.radioTitle = @"交通枢纽";
		radioVC.filterHotelType = HotelTraffic;
		radioVC.popType = PopHotelFitler;
		radioVC.hotelRequestPara = self.hotelRequestPara;
		[NavigationController pushViewController:radioVC animated:YES];
		[radioVC release];
	}
	
}






@end
