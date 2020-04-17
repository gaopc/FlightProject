//
//  RoomListViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoomListViewController.h"
#import "RoomListCell.h"
#import "HotelOrdersViewController.h"
#import "NOMemberLoginViewController.h"

@interface RoomListViewController ()
-(void)drawStarCodeView:(int) markValue;
-(void)drawDiamondCodeView:(int) markValue;
@end

@implementation RoomListViewController
@synthesize r_tableView = _r_tableView;

@synthesize selectedCellIndexPath,isExtend,hotelView,hotelInfo,roomListArray,startDay,endDay,cityName;

@synthesize selectRoomType,lcdRate,lcdValue,lcdActivityId,markValueView;

- (void) dealloc {
	
	self.roomListArray = nil;
	self.hotelInfo = nil;
	[_r_tableView release];
        self.selectRoomType = nil;
	self.cityName = nil;
	self.lcdValue = nil;
    self.lcdActivityId = nil;
	self.markValueView = nil;
	[super dealloc];
	
}



- (void)loadView{
	
	[super loadView];
	
	_r_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,ViewHeight-84.0f) style:UITableViewStylePlain];  
	self.r_tableView.backgroundColor = [UIColor clearColor];
	self.r_tableView.dataSource = self;
	self.r_tableView.delegate = self;
	self.r_tableView.showsVerticalScrollIndicator= NO;
    self.r_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:self.r_tableView];
	
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.selectedCellIndexPath= [NSIndexPath indexPathForRow:0 inSection:1];
	self.isExtend = TRUE;
	// Do any additional setup after loading the view.
	
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	self.selectedCellIndexPath = nil;
	self.hotelView = nil;
	self.startDay = nil;
	self.endDay = nil;
	self.r_tableView = nil;
	// Release any retained subviews of the main view.
}


- (UIView *)hotelView
{
	if (hotelView == nil)
	{
		hotelView = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 5.0f, ViewWidth-20.0f, 100.0f)];
		
		UIImageView *topBg = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, self.hotelView.frame.size.width, self.hotelView.frame.size.height) image:[UIImage imageNamed:@"cabinWeartherBackground.png"]];
		[hotelView addSubview: topBg];
		
		UISubLabel *hotelName = [UISubLabel labelWithTitle:@"" frame:CGRectMake(10.0f, 12.0f, 190.0f, 30.0f) font:FontSize38  alignment:NSTextAlignmentLeft];
		hotelName.textColor = FontColor333333;
		hotelName.text = self.hotelInfo._hotelName;
		[hotelView addSubview:hotelName];
		
		UIImageView *solidLineImg = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 48.0f, 280.0f, 1.0f) image:[UIImage imageNamed:@"SmallSolidLine.png"]];
		[hotelView addSubview: solidLineImg];
		if (self.hotelInfo._diamond) {
			[self drawDiamondCodeView:self.hotelInfo._starCode];
		}else{
			[self drawStarCodeView:self.hotelInfo._starCode];
		}

		
		UISubLabel *rating =  [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-90, 25.0f, 80.0f, 20.0f) font:FontSize26 color:FontColor454545 alignment:NSTextAlignmentLeft];
		rating.text =[NSString stringWithFormat:@"%@ %.1f",@"点评 : ",self.hotelInfo._rating];
		[hotelView addSubview:rating];
		
		UISubLabel *hotelAddress = [UISubLabel labelWithTitle:@"" frame:CGRectMake(10.0f, 55.0f, 280, 40.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
		hotelAddress.textColor = FontColor333333;
		hotelAddress.text = self.hotelInfo._address;
		[hotelView addSubview:hotelAddress];
		
		hotelView.tag=kViewTag;
		
		
	}
	return hotelView;
}

//星级
-(void)drawStarCodeView:(int) markValue{
	
	if (self.markValueView)
		[self.markValueView removeFromSuperview];
	
	self.markValueView= [[UIView alloc] initWithFrame:CGRectMake(215.0f, 10, 75, 18.0f )];
	
	for (int i=0; i<5; i++) {
		
		if (markValue>=1) {
			
		        UIImageView *starGreenImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*14.5, 0, 13, 13)];
			starGreenImg.image = [UIImage imageNamed:@"Star_Golden.png"]; //选中			
			[self.markValueView addSubview:starGreenImg];
			[starGreenImg release];
			markValue--;
			continue;
			
	        }else {
			UIImageView *starWhiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*14.5, 0, 13, 13)];
			starWhiteImg.image = [UIImage imageNamed:@"Star_Gray.png"];
			[self.markValueView addSubview:starWhiteImg];
			[starWhiteImg release];
			
		}
	}
	[self.hotelView addSubview:self.markValueView];
	[self.markValueView release];
	
}

-(void)drawDiamondCodeView:(int) markValue{
	
	if (self.markValueView)
		[self.markValueView removeFromSuperview];
	
	self.markValueView= [[UIView alloc] initWithFrame:CGRectMake(ViewWidth-100, 12, 75, 18.0f )];
	
	for (int i=0; i<5; i++) {
		
		if (markValue>=1) {
			
		        UIImageView *starGreenImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*13.5, 0, 12, 11)];
			starGreenImg.image = [UIImage imageNamed:@"Diamond_Golden.png"]; //选中
			[self.markValueView addSubview:starGreenImg];
			[starGreenImg release];
			markValue--;
			continue;
			
	        }else {
			UIImageView *starWhiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*13.5, 0, 12, 11)];
			starWhiteImg.image = [UIImage imageNamed:@"Diamond_Gray.png"];
			[self.markValueView addSubview:starWhiteImg];
			[starWhiteImg release];
			
		}
	}
	[self.hotelView addSubview:self.markValueView];
	[self.markValueView release];
	
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView
{
	return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return 1;
	}
	
        return [self.roomListArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (indexPath.section == 0) {
		return 110.0f;
	}
	else  {
		if ([self.selectedCellIndexPath compare:indexPath] == NSOrderedSame && self.isExtend) {
			return 140.0f;
		}
	}
	return 60.0f;
	
	
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (indexPath.section ==0) {
		
		UITableViewCell *cell = nil;
		static NSString *tRoomCellID_ID = @"RoomCellID";
		cell = [tableView dequeueReusableCellWithIdentifier:tRoomCellID_ID];
		if (cell == nil)
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tRoomCellID_ID] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		else
		{
			UIView *viewToRemove = nil;
			viewToRemove = [cell.contentView viewWithTag:kViewTag];
			if (viewToRemove)
				[viewToRemove removeFromSuperview];
		}
		
		[cell.contentView addSubview:self.hotelView];
		cell.backgroundColor = [UIColor clearColor];

		return cell;
		
		
	}
	if (indexPath.section == 1){
		static NSString * identifierTwo = @"identifierTwo";
		RoomListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierTwo];
		if (cell== nil) {
			cell = [[[RoomListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierTwo] autorelease];
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			//[cell.roomRuleButton addTarget:self action:@selector(lookRule:) forControlEvents:UIControlEventTouchUpInside];
		}
		cell.delegate = self;
		cell.roomRuleButton.tag = 100+indexPath.row;
                cell.roomButton.tag = 200+indexPath.row;
		
		HotelRoomType *hotelRoomType = nil;
		hotelRoomType = (HotelRoomType *)[self.roomListArray objectAtIndex:indexPath.row];
		
		if (self.selectedCellIndexPath.row == indexPath.row && self.isExtend) {
			cell.roomView.hidden = NO;
		}else {
			cell.roomView.hidden = YES;
		}
		
		cell.roomName.text = hotelRoomType._type;
		int iaveragePrice = 0 ;
		if ((int) hotelRoomType._averagePrice *100%100 ==0) 
			iaveragePrice = (int)(hotelRoomType._averagePrice);
		else 
			iaveragePrice = (int)(hotelRoomType._averagePrice) + 1;
		
		cell.roomPrice.text =[NSString stringWithFormat:@"%d",iaveragePrice];
		cell.roomReturnLcdFee.text = [NSString stringWithFormat:@"返%3d",hotelRoomType._returnLcdFee];
		if (!hotelRoomType._isScheduled) {
			cell.roomButton.hidden = YES;
			cell.roomNoButton.hidden = NO;
		
		}else{
			cell.roomButton.hidden = NO;
			cell.roomNoButton.hidden = YES;
		}
		if ((int)hotelRoomType._returnLcdFee == 0)
		{
			cell._returnLcdView.hidden = YES;
		}
		else 
		{
			cell._returnLcdView.hidden = NO;
		}
		[cell.hotelImageView setUrlString:hotelRoomType._picUrl];
		cell.breakfastLabel.text = hotelRoomType._breakfast;
		cell.networkLabel.text = hotelRoomType._network;
		cell.areaLabel.text = hotelRoomType._area;
		cell.floorLabel.text = hotelRoomType._floor;
		cell.bedTypeLabel.text = hotelRoomType._bedType;
		
		return cell;
	}
	return nil;
}


-(void)lookRule:(UIButton *)sender
{
	selectCabinIndex = sender.tag;
	
	
	
	
	if (self.selectedCellIndexPath.row == sender.tag) {
		self.isExtend = !self.isExtend;
	}
	else {
		self.isExtend = YES;
	}
	
	if (self.isExtend) {
		
		self.selectedCellIndexPath= [NSIndexPath indexPathForRow:selectCabinIndex inSection:1];
	}
	else {
		self.selectedCellIndexPath= [NSIndexPath indexPathForRow:selectCabinIndex inSection:1];
	}
}
-(void)setSelectedCellIndexPath:(NSIndexPath *)_selectedCellIndexPath
{
	NSMutableArray * IndexPatharray = [NSMutableArray array];
	if (self.selectedCellIndexPath == nil) {
		selectedCellIndexPath = [_selectedCellIndexPath retain];
	}
	else if (self.selectedCellIndexPath.row != _selectedCellIndexPath.row) 
	{
		[IndexPatharray addObject:self.selectedCellIndexPath];
		[selectedCellIndexPath release];
		selectedCellIndexPath = [_selectedCellIndexPath retain];
	}
	if (self.selectedCellIndexPath) {
		[IndexPatharray addObject:self.selectedCellIndexPath];
	}
	[self.r_tableView reloadRowsAtIndexPaths:IndexPatharray withRowAnimation:UITableViewRowAnimationFade];
}
-(void) loginSuccessFul
{
  
    HotelOrdersViewController *hotelViewCtr = [[HotelOrdersViewController alloc] init];
    hotelViewCtr.hotelInfo = self.hotelInfo;
    hotelViewCtr.checkCity = self.cityName;
    hotelViewCtr.hotelRoomType = self.selectRoomType;
    hotelViewCtr.checkInDate = self.startDay;
    hotelViewCtr.checkOutDate = self.endDay;
    hotelViewCtr.nowRomeCount = 5;//接口调整后，需更改此处的房间数量
    hotelViewCtr.lcdValue = self.lcdValue;
    hotelViewCtr.lcdRate = self.lcdRate;
	hotelViewCtr.lcdActivityId = self.lcdActivityId;
    
    [NavigationController pushViewController:hotelViewCtr animated:YES];
    [hotelViewCtr release];

}
-(void)preordainClick:(id)sender
{
    UIButton *button = (UIButton*)sender;
    self.selectRoomType = (HotelRoomType *)[self.roomListArray objectAtIndex:(button.tag-200)];
    
    self._VCType = DidNoMember;
    if (self.isLogin) {
        
        [self loginSuccessFul];
    }
    else {
//        NOMemberLoginViewController  * memberLoginVC = [[NOMemberLoginViewController alloc] init];
//        memberLoginVC.delegate = self;
//        [NavigationController pushViewController:memberLoginVC animated:YES];
//        [memberLoginVC release];	
    }
}


-(void)detailClick:(id)sender
{
	
	UIButton *button = (UIButton*)sender;
	
	selectCabinIndex =  (button.tag-100);
	
	if (self.selectedCellIndexPath.row == (button.tag-100)) {
		self.isExtend = !self.isExtend;
	}
	else {
		self.isExtend = YES;
	}
	
	if (self.isExtend) {
		
		self.selectedCellIndexPath= [NSIndexPath indexPathForRow:selectCabinIndex inSection:1];
	}
	else {
		self.selectedCellIndexPath= [NSIndexPath indexPathForRow:selectCabinIndex inSection:1];
	}
}






@end
