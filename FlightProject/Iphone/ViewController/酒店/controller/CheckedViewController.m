//
//  CheckedViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CheckedViewController.h"
#import "HotelInquiryDataResponse.h"
#import "RadioViewController.h"
@interface CheckedViewController ()

@end

@implementation CheckedViewController

@synthesize c_tableView = _c_tableView;
@synthesize checkedArray;
@synthesize checkedTitle,topTitle,filterHotelType,popType,hotelRequestPara;




- (void)loadView{
	
	[super loadView];
	
	_c_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,ViewHeight-44.0f) style:UITableViewStylePlain];  
	self.c_tableView.backgroundColor = [UIColor whiteColor];
	self.c_tableView.dataSource = self;
	self.c_tableView.delegate = self;
        self.c_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	[self.view addSubview:self.c_tableView];
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.title =@"筛选";
	
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	self.checkedTitle = nil;
	self.topTitle = nil;
	self.filterHotelType = 0;
	self.popType = 0;
	self.c_tableView = nil;
}


- (void) dealloc {
	
	
	[_c_tableView release];
        self.checkedArray = nil;
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
	UIView * view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, 25.0f)] autorelease];
	UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(view.bounds.origin.x,view.bounds.origin.y,ViewWidth,25.0f)];
	bgView.userInteractionEnabled = YES;
	bgView.image =[UIImage imageNamed:@"HotelFilterSectionBg.png"];
	[view addSubview:bgView];
	[bgView release];
	[view addSubview:[UISubLabel labelWithTitle:self.checkedTitle frame:CGRectMake(30.0f, 0.0f, tableView.frame.size.width, 25.0f) font:FontSize32 color:FontColor909090 alignment:NSTextAlignmentLeft]];
	
	return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
	// Return the number of rows in the section.
	return [self.checkedArray count];
	
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{		
	
	return 50.0f;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellStyle style =  UITableViewCellStyleDefault;
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckedCell"];
	if (!cell) 
		cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"CheckedCell"] autorelease];
	
	cell.backgroundColor = [UIColor whiteColor];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
	Metro *metro = nil;
	metro = (Metro *)[self.checkedArray objectAtIndex:indexPath.row];
	
	cell.textLabel.text = metro._name;
	cell.textLabel.textColor = FontColor333333;
	cell.textLabel.font = FontSize32;
	cell.backgroundColor = [UIColor clearColor];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(0, 0, ViewWidth, 50)];
	Metro *metro = nil;
	metro = (Metro *)[self.checkedArray objectAtIndex:indexPath.row];
	RadioViewController *radioVC = [[RadioViewController alloc] init];
	radioVC.radioArray = metro._metroInfoArray;
	radioVC.topTitle = @"筛选";
	radioVC.radioTitle = metro._name;
	radioVC.filterHotelType = HotelMetro;
	radioVC.popType = self.popType;
	radioVC.hotelRequestPara = self.hotelRequestPara;
	[NavigationController pushViewController:radioVC animated:YES];
	[radioVC release];
}
@end
