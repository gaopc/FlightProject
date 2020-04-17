//
//  HotelSearchViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelInquiryViewController.h"
#import "HotelInquiryCell.h"
#import "HotelInquiryDataResponse.h"
#import "RadioViewController.h"
#import "CheckedViewController.h"
#import "HotelHomeViewController.h"
@interface HotelInquiryViewController ()
//- (void)loadDataSource;
@end

@implementation HotelInquiryViewController
@synthesize h_tableView = _h_tableView;
@synthesize filterArray = _filterArray;
@synthesize cityTitle,hoteNameDictionary,filterHoteDictionary,hotelRequestPara;
@synthesize textFieldArray,keyboardbar;



- (void)loadView{
	
	[super loadView];
	
	filterBgView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,60)];
	filterBgView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:filterBgView];
	
	
	UIImageView *nameImageView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 10.0f, 300.0f, 36.5f)];
	[nameImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[filterBgView addSubview:nameImageView];
	
	UIImageView *searchImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 18.0f, 18.0f, 15.0f)];
	[searchImageView setImage:[UIImage imageNamed:@"citySearch.png"]];
	[filterBgView addSubview:searchImageView];
	
	//关键字查询
	filterTextField = [UISubTextField TextFieldWithFrame:CGRectMake(45.0f, 13.0f, 255.0f, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"酒店名、关键词等"];
	filterTextField.backgroundColor = [UIColor clearColor];
	filterTextField.font = FontSize32;
	filterTextField.returnKeyType = UIReturnKeyDone;
	filterTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	filterTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	filterTextField.keyboardType = UIKeyboardTypeDefault;
	[filterTextField addTarget:self 
			    action:@selector(doNextOrDone:) 
		  forControlEvents:UIControlEventEditingDidEndOnExit];
	filterTextField.tag = 100;
	filterTextField.delegate = self;
	[filterBgView addSubview:filterTextField];
	[filterBgView  release];
	
	
	
	self.textFieldArray = [NSArray arrayWithObjects:filterTextField, nil];
	
	_h_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,70.0f,ViewWidth,ViewHeight-130.0f) style:UITableViewStylePlain];  
	self.h_tableView.backgroundColor = [UIColor clearColor];
	self.h_tableView.dataSource = self;
	self.h_tableView.delegate = self;
        self.h_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:self.h_tableView];
	
	
	
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"关键字";
	_filterArray = [[NSMutableArray alloc] init];
	
	if (![self.hotelRequestPara._hotelName isEqualToString:@""] ) {
		filterTextField.text = self.hotelRequestPara._hotelName;
	}
	if (![self.hotelRequestPara._hotelArea isEqualToString:@""] ) {
		filterTextField.text = self.hotelRequestPara._hotelArea;
	}
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	self.h_tableView = nil;
	
	// Release any retained subviews of the main view.
}

- (void) dealloc {
	
	[_filterArray release];
	[_h_tableView release];
	
	self.filterHoteDictionary = nil;
	self.hoteNameDictionary = nil;
	self.textFieldArray = nil;
	self.keyboardbar = nil;
	self.cityTitle = nil;
	[super dealloc];
	
}


#pragma mark -
#pragma mark 自定义方法

-(void) backHome
{
	if (0 == [filterTextField.text length]) {
		self.hotelRequestPara._hotelName = @"";
	}else {
		self.hotelRequestPara._hotelName = filterTextField.text;
		
	}
	hotelHomeVC.hotelRequestPara = self.hotelRequestPara;
	[NavigationController popViewControllerAnimated:YES];
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (self.keyboardbar == nil) {
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
		
	}
	[keyboardbar showBar:textField];  //显示工具条 
	return  YES;
}


- (void)doNextOrDone:(id)sender
{
	UITextField *field = (UITextField *)sender;
	switch (field.tag) {
		case 100:
			[filterTextField resignFirstResponder];
			break;
			
		default:
			break;
	}
	
	hotelHomeVC.hotelRequestPara = self.hotelRequestPara;
	[NavigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
	filterTextField.text = @"";
	self.hotelRequestPara._hotelName = @"";
	self.hotelRequestPara._hotelArea = @"";
	self.hotelRequestPara._administrativeArea =@"";
	self.hotelRequestPara._businessArea =@"";
	self.hotelRequestPara._isSpecialOffer =FALSE;
	self.hotelRequestPara._longitude = @"";
	self.hotelRequestPara._latitude = @"";
	return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString * searchStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	if (0 == filterTextField.text.length) {
		self.hotelRequestPara._hotelName = @"";
		self.hotelRequestPara._hotelArea = @"";
	}else {
		self.hotelRequestPara._hotelName = searchStr;
		self.hotelRequestPara._hotelArea = @"";
		self.hotelRequestPara._isSpecialOffer =FALSE;
		self.hotelRequestPara._administrativeArea =@"";
		self.hotelRequestPara._businessArea =@"";
		self.hotelRequestPara._longitude = @"";
		self.hotelRequestPara._latitude = @"";
	}
	
	return YES;
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
	
	return 60.0f;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * identifier = @"identifier";
	HotelInquiryCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[HotelInquiryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		cell.backgroundColor = [UIColor clearColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
	}
	
        cell.name.text = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
	
	// Configure the cell...
	
	return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 5, 300, 50)];
    
	RadioViewController *radioVC = nil;
	CheckedViewController *checkedVC = nil;
	
	
	NSString *tempName = [self.hoteNameDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
	
	if ([tempName isEqualToString:@"行政区"]) {
		radioVC = [[RadioViewController alloc] init];
		radioVC.radioArray =  [self.filterHoteDictionary objectForKey:@"行政区"];
		radioVC.radioTitle = @"行政区";
		radioVC.filterHotelType = HotelAdministrativeArea;
		radioVC.popType = PopHotelHome;
		radioVC.hotelRequestPara = self.hotelRequestPara;
		[NavigationController pushViewController:radioVC animated:YES];
		[radioVC release];
	}
	if ([tempName isEqualToString:@"热门商圈"]) {
		
		radioVC = [[RadioViewController alloc] init];
		radioVC.radioArray =  [self.filterHoteDictionary objectForKey:@"热门商圈"];
		radioVC.radioTitle = @"热门商圈";
		radioVC.filterHotelType = HotelBusinessArea;
		radioVC.popType = PopHotelHome;
		radioVC.hotelRequestPara = self.hotelRequestPara;
		[NavigationController pushViewController:radioVC animated:YES];
		[radioVC release];
	}
	if ([tempName isEqualToString:@"地铁"]) {
		checkedVC = [[CheckedViewController alloc] init];
		checkedVC.checkedArray =  [self.filterHoteDictionary objectForKey:@"地铁"];
		checkedVC.checkedTitle = @"地铁";
		checkedVC.filterHotelType = HotelMetro;
		checkedVC.popType = PopHotelHome;
		checkedVC.hotelRequestPara = self.hotelRequestPara;
		[NavigationController pushViewController:checkedVC animated:YES];
		[checkedVC release];
	}
	if ([tempName isEqualToString:@"交通枢纽"]) {
		
		radioVC = [[RadioViewController alloc] init];
		radioVC.radioArray =  [self.filterHoteDictionary objectForKey:@"交通枢纽"];
		radioVC.radioTitle = @"交通枢纽";
		radioVC.filterHotelType = HotelTraffic;
		radioVC.popType = PopHotelHome;
		radioVC.hotelRequestPara = self.hotelRequestPara;
		[NavigationController pushViewController:radioVC animated:YES];
		[radioVC release];
	}
	
	
	
}



@end
