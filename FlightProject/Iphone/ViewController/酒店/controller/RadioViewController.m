//
//  RadioViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RadioViewController.h"
#import "RadioViewCell.h"
#import "HotelFilterCell.h"
#import "HotelInquiryDataResponse.h"
#import "HotelHomeViewController.h"
#import "HotelFilterViewController.h"
@interface RadioViewController ()

@end

@implementation RadioViewController

@synthesize r_tableView = _r_tableView;
@synthesize radioArray;
@synthesize radioTitle,topTitle,filterHotelType,popType,hotelRequestPara;
- (void)loadView{
	
	[super loadView];
	
	_r_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,ViewHeight-44.0f) style:UITableViewStylePlain];  
	self.r_tableView.backgroundColor = [UIColor whiteColor];
	self.r_tableView.dataSource = self;
	self.r_tableView.delegate = self;
        self.r_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	[self.view addSubview:self.r_tableView];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title =@"筛选";
	
	
	
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	self.radioTitle = nil;
	self.topTitle = nil;
	self.filterHotelType = 0;
	self.popType = 0;
	self.r_tableView = nil;
	// Release any retained subviews of the main view.
}

- (void) dealloc {
	
	
	[_r_tableView release];
        self.radioArray = nil;
	self.hotelRequestPara =nil;
	[super dealloc];
	
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
	// Return the number of sections.
	return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30.0f;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView * view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, 25.0f)] autorelease];
	UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(view.bounds.origin.x,view.bounds.origin.y,ViewWidth,25.0f)];
	bgView.userInteractionEnabled = YES;
	bgView.image =[UIImage imageNamed:@"HotelFilterSectionBg.png"];
	[view addSubview:bgView];
	[view addSubview:[UISubLabel labelWithTitle:self.radioTitle frame:CGRectMake(30.0f, 0.0f, tableView.frame.size.width, 25.0f) font:FontSize32 color:FontColor909090 alignment:NSTextAlignmentLeft]];
	[bgView release];
	return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
	// Return the number of rows in the section.
	return [self.radioArray count];
	
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{		
	
	return 50.0f;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIndentifierOnline=@"RadioCell";
	RadioViewCell *cell=(RadioViewCell *)[self.r_tableView dequeueReusableCellWithIdentifier:cellIndentifierOnline];
	if (cell == nil){
		cell=[[[RadioViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	if (self.filterHotelType == HotelAdministrativeArea || self.filterHotelType == HotelBusinessArea) {
		
		if (self.hotelRequestPara) {
			if ([self.hotelRequestPara._hotelArea isEqualToString:[self.radioArray objectAtIndex:indexPath.row]]) {
				cell.btnView.hidden = NO;
			}
		}
		
		cell.name.text = [self.radioArray objectAtIndex:indexPath.row];
	}
	if (self.filterHotelType == HotelLevel) {
		
		if (indexPath.row==0) {
			cell.name.text = @"星级不限";
		}else if (indexPath.row==1){
			cell.name.text = @"经济";
		}else {
			cell.name.text = [NSString stringWithFormat:@"%d %@",[[self.radioArray objectAtIndex:indexPath.row] intValue],@"星"];
		}
		
		if (self.hotelRequestPara) {
			if (self.hotelRequestPara._star == [[self.radioArray objectAtIndex:indexPath.row] intValue]) {
				cell.btnView.hidden = NO;
			}
		}
	}
	
	
	if (self.filterHotelType == HotelTraffic){
		Traffic *traffic = nil;
		traffic = (Traffic *)[self.radioArray objectAtIndex:indexPath.row];
		if (self.hotelRequestPara) {
			if ([self.hotelRequestPara._hotelArea isEqualToString:traffic._name]) {
				cell.btnView.hidden = NO;
			}
		}
		cell.name.text  = traffic._name;
		
	}
	if (self.filterHotelType == HotelMetro){
		MetroInfo *metroInfo = nil;
		metroInfo = (MetroInfo *)[self.radioArray objectAtIndex:indexPath.row];
		if (self.hotelRequestPara) {
			if ([self.hotelRequestPara._hotelArea isEqualToString:metroInfo._name]) {
				cell.btnView.hidden = NO;
			}
		}
		cell.name.text  = metroInfo._name;
		
	}
	
	if (self.filterHotelType == HotelCharges)
	{
		if (indexPath.row==0) {
			cell.name.text  = @"房价不限";
			
			if ([self.hotelRequestPara._priceName isEqualToString:@"房价"] || [self.hotelRequestPara._priceName isEqualToString:@"房价不限"]) {
				cell.btnView.hidden = NO;
			}else {
				cell.btnView.hidden = YES;
			}
		}else {
			if (self.hotelRequestPara) {
				if ([self.hotelRequestPara._priceName isEqualToString:[self.radioArray objectAtIndex:indexPath.row]]) {
					cell.btnView.hidden = NO;
				}
			}
			cell.name.text = [self.radioArray objectAtIndex:indexPath.row];
			
		}
		
		
		
	}
	
	if (self.filterHotelType == HotelBrand){
		if (indexPath.row==0) {
			cell.name.text  = @"品牌不限";
			if ([self.hotelRequestPara._hotelBrandName isEqualToString:@"品牌"]  || [self.hotelRequestPara._hotelBrandName isEqualToString:@"品牌不限"]) {
				cell.btnView.hidden = NO;
			}else {
				cell.btnView.hidden = YES;
			}
			
		}else {
			Brand *brandInfo = nil;
			brandInfo = (Brand *)[self.radioArray objectAtIndex:indexPath.row];
			if (self.hotelRequestPara) {
				if ([self.hotelRequestPara._hotelBrandName isEqualToString:brandInfo._brandName]) {
					cell.btnView.hidden = NO;
				}
			}
			
			cell.name.text  = brandInfo._brandName;
		}
		
		
	}
	
	// Configure the cell...
	
	return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	int i = 0;
	//	self.hotelRequestPara._longitude = @"";
	//	self.hotelRequestPara._latitude = @"";
	//	self.hotelRequestPara._administrativeArea =@"";
	//	self.hotelRequestPara._businessArea =@"";
	for (RadioViewCell* cell in [self.r_tableView visibleCells]) {
		
		cell.btnView.hidden = YES;
		i++;
	}
	[self.r_tableView deselectRowAtIndexPath:indexPath animated:YES];
	((RadioViewCell*)[self.r_tableView cellForRowAtIndexPath:indexPath]).btnView.hidden = NO;
	
	if (self.popType==0) {
		
		
		
		HotelHomeViewController *hotelHomeVC = [self.navigationController.viewControllers objectAtIndex:1];
		//行政区域
		if (self.filterHotelType == HotelAdministrativeArea) {
			
			self.hotelRequestPara._hotelArea = [self.radioArray objectAtIndex:indexPath.row];
			self.hotelRequestPara._administrativeArea = [self.radioArray objectAtIndex:indexPath.row];
			self.hotelRequestPara._longitude = @"";
			self.hotelRequestPara._latitude = @"";
			self.hotelRequestPara._businessArea =@"";
			
			
		}
		//商圈
		if (self.filterHotelType == HotelBusinessArea ) {
			self.hotelRequestPara._hotelArea = [self.radioArray objectAtIndex:indexPath.row];
			self.hotelRequestPara._businessArea = [self.radioArray objectAtIndex:indexPath.row];
			self.hotelRequestPara._longitude = @"";
			self.hotelRequestPara._latitude = @"";
			self.hotelRequestPara._administrativeArea =@"";
		}
		//交通枢纽
		if (self.filterHotelType == HotelTraffic){
			Traffic *traffic = nil;
			traffic = (Traffic *)[self.radioArray objectAtIndex:indexPath.row];
			self.hotelRequestPara._hotelArea  = traffic._name;
			self.hotelRequestPara._longitude = traffic._longitude;
			self.hotelRequestPara._latitude = traffic._latitude;
			self.hotelRequestPara._businessArea = @"";
			self.hotelRequestPara._administrativeArea =@"";
			
		}
		//交通地铁
		if (self.filterHotelType == HotelMetro){
			MetroInfo *metroInfo = nil;
			metroInfo = (MetroInfo *)[self.radioArray objectAtIndex:indexPath.row];
			self.hotelRequestPara._hotelArea  = metroInfo._name;
			self.hotelRequestPara._longitude = metroInfo._longitude;
			self.hotelRequestPara._latitude = metroInfo._latitude;
			self.hotelRequestPara._businessArea = @"";
			self.hotelRequestPara._administrativeArea =@"";
		}
		
		self.hotelRequestPara._hotelName = @"";
		[self.navigationController popToViewController:hotelHomeVC animated:YES];
		
		
	}
	if (self.popType==1) {
		
		HotelFilterViewController *filterVC = nil;
		if (self.hotelRequestPara._isSpecialOffer) {
			filterVC = [self.navigationController.viewControllers objectAtIndex:4];
		}else{
			filterVC = [self.navigationController.viewControllers objectAtIndex:3];
		}
		//行政区域
		if (self.filterHotelType == HotelAdministrativeArea ) {
			self.hotelRequestPara._hotelArea = [self.radioArray objectAtIndex:indexPath.row];
			self.hotelRequestPara._administrativeArea = [self.radioArray objectAtIndex:indexPath.row];
			self.hotelRequestPara._longitude = @"";
			self.hotelRequestPara._latitude = @"";
			self.hotelRequestPara._businessArea =@"";
			
		}
		//商圈
		if (self.filterHotelType == HotelBusinessArea) {
			self.hotelRequestPara._hotelArea = [self.radioArray objectAtIndex:indexPath.row];
			self.hotelRequestPara._businessArea = [self.radioArray objectAtIndex:indexPath.row];
			self.hotelRequestPara._longitude = @"";
			self.hotelRequestPara._latitude = @"";
			self.hotelRequestPara._administrativeArea =@"";
		}
		
		//交通枢纽
		if (self.filterHotelType == HotelTraffic){
			Traffic *traffic = nil;
			traffic = (Traffic *)[self.radioArray objectAtIndex:indexPath.row];
			self.hotelRequestPara._hotelArea  = traffic._name;
			self.hotelRequestPara._longitude = traffic._longitude;
			self.hotelRequestPara._latitude = traffic._latitude;
			self.hotelRequestPara._businessArea = @"";
			self.hotelRequestPara._administrativeArea =@"";
			
		}
		//交通地铁
		if (self.filterHotelType == HotelMetro){
			MetroInfo *metroInfo = nil;
			metroInfo = (MetroInfo *)[self.radioArray objectAtIndex:indexPath.row];
			self.hotelRequestPara._hotelArea  = metroInfo._name;
			self.hotelRequestPara._longitude = metroInfo._longitude;
			self.hotelRequestPara._latitude = metroInfo._latitude;
			self.hotelRequestPara._businessArea = @"";
			self.hotelRequestPara._administrativeArea =@"";
			
		}
		//价格
		if (self.filterHotelType == HotelCharges) {
			self.hotelRequestPara._highestPrice =@"0";
			self.hotelRequestPara._lowestPrice = @"0";
			
			if (indexPath.row== 0) {
				self.hotelRequestPara._priceName = @"房价不限";
				
			}else {
				self.hotelRequestPara._priceName = [self.radioArray objectAtIndex:indexPath.row];
				
				if (indexPath.row==1) {
					NSRange range = [[self.radioArray objectAtIndex:indexPath.row] rangeOfString:@"元"];
					int location = range.location;
					self.hotelRequestPara._lowestPrice = [[self.radioArray objectAtIndex:indexPath.row]  substringWithRange:NSMakeRange(0, location)];
					
				}
				else if (indexPath.row==2) {
					
					NSRange range = [[self.radioArray objectAtIndex:indexPath.row] rangeOfString:@"元"];
					int location = range.location;
					self.hotelRequestPara._highestPrice = [[self.radioArray objectAtIndex:indexPath.row]  substringWithRange:NSMakeRange(0, location)];
				}else {
					self.hotelRequestPara._highestPrice = [[[self.radioArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"-"] objectAtIndex:1];
					self.hotelRequestPara._lowestPrice = [[[self.radioArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"-"] objectAtIndex:0];
				}
				
			}
			
			
			
		}
		//星级
		if (self.filterHotelType == HotelLevel) {
			
			self.hotelRequestPara._star = [[self.radioArray objectAtIndex:indexPath.row] intValue];
			if (indexPath.row == 0) {
				
				self.hotelRequestPara._starName = @"星级不限";
			}else if (indexPath.row == 1) {
				
				self.hotelRequestPara._starName = @"经济";
			}else {
				
				self.hotelRequestPara._starName = [NSString stringWithFormat:@"%d %@",[[self.radioArray objectAtIndex:indexPath.row] intValue],@"星"];
			}
			
		}
		//品牌
		if (self.filterHotelType == HotelBrand) {
			
			if (indexPath.row == 0) {
				self.hotelRequestPara._hotelBrandID  = @"0";
				self.hotelRequestPara._hotelBrandName = @"品牌不限";
			}else {
				Brand *brand = nil;
				brand = (Brand *)[self.radioArray objectAtIndex:indexPath.row];
				self.hotelRequestPara._hotelBrandID  = brand._id;
				self.hotelRequestPara._hotelBrandName = brand._brandName;
			}
			
			
			
			
		}
		[filterVC.h_tableView reloadData];
		
		[self.navigationController popToViewController:filterVC animated:YES];
		
	}
	
	
}




@end
