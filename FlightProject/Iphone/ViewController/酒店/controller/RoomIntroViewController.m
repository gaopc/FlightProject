//
//  RoomIntroViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoomIntroViewController.h"

@interface RoomIntroViewController ()
- (float) calCellTotalHeight;
@end

@implementation RoomIntroViewController
@synthesize hotelInfo,roomIntroView;
- (void)loadView{
	
	[super loadView];
	
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 10.0f, ViewWidth-20.0f, 7.0f)] ;
	[topView setImage:[UIImage imageNamed:@"MemberLoginTop.png"]];
	[self.view addSubview:topView];
	
	UITableView *r_tableView = [[UITableView alloc] initWithFrame:CGRectMake(10.0f ,17.0f,ViewWidth-20.0f,ViewHeight-120.0f) style:UITableViewStylePlain];  
	r_tableView.backgroundColor = [UIColor clearColor];
	r_tableView.dataSource = self;
	r_tableView.delegate = self;
	r_tableView.showsVerticalScrollIndicator=NO;
	r_tableView.separatorColor = [UIColor clearColor];
	
	
	
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f,17.0f,ViewWidth-20.0f, r_tableView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"MemberLoginCenter.png"]];
	[self.view addSubview:centerView];
        [self.view addSubview:r_tableView];
	[r_tableView release];
	
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, centerView.frame.size.height+17.0f, ViewWidth-20.0f, 7.0f)];
	[bottom setImage:[UIImage imageNamed:@"MemberLoginBottom.png"]];
	[self.view addSubview:bottom];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	cellTotalHeight = [self calCellTotalHeight];
	

}

//计算Cell的高度
- (float) calCellTotalHeight
{
	float totalHeight = 0.0;
	CGSize nameLabelSize = [self.hotelInfo._hotelName sizeWithFont:FontBlodSize38 constrainedToSize:CGSizeMake(280.0f, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
	
	totalHeight = totalHeight + nameLabelSize.height;
	
	CGSize addressLabelSize = [self.hotelInfo._address sizeWithFont:FontSize32 constrainedToSize:CGSizeMake(280.0f, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
	
	totalHeight = totalHeight + addressLabelSize.height;
	
	CGSize featureInfoLabelSize = [self.hotelInfo._featureInfo sizeWithFont:FontSize26 constrainedToSize:CGSizeMake(270.0f, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
	
	
	totalHeight = totalHeight + featureInfoLabelSize.height;
	
	CGSize generalLabelSize = [self.hotelInfo._generalAmenities sizeWithFont:FontSize26 constrainedToSize:CGSizeMake(270.0f, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
	
	
	totalHeight = totalHeight + generalLabelSize.height + 170;
	
	NSLog(@"totalHeight %f ",totalHeight);
	
	return totalHeight;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

- (void) dealloc {
	
	self.roomIntroView = nil;
	self.hotelInfo = nil;
	[super dealloc];
	
}


//城市视图
- (UIView *)roomIntroView
{
	if (roomIntroView == nil)
	{
		
		
		roomIntroView = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 5.0f, ViewWidth-20.0f, 0.0f)];
		[self.view addSubview:roomIntroView];
		
		
		UISubLabel *nameTitle = [UISubLabel labelWithTitle:@"酒店名称" frame:CGRectMake(10.0f, 8.0f, 80.0f, 20.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
		nameTitle.textColor = FontColor454545;
		[roomIntroView addSubview:nameTitle];
		

		name = [UISubLabel labelWithTitle:@"" frame:CGRectMake(10.0f, 36.0f, ViewWidth-40, 0.0f) font:FontBlodSize38 alignment:NSTextAlignmentLeft];
		name.textColor = FontColor333333;
		name.lineBreakMode = UILineBreakModeTailTruncation;
		name.numberOfLines = 0;
		name.text = self.hotelInfo._hotelName;
		
	
		
		CGSize nameLabelSize = [name.text sizeWithFont:name.font constrainedToSize:CGSizeMake(name.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
		
		
		CGRect newFrame = name.frame;
		newFrame.size.height = nameLabelSize.height;
		name.frame = newFrame;
		
		[roomIntroView addSubview:name];
		

		UIImageView *lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(0.0f, name.frame.origin.y +nameLabelSize.height + 5.0f, 280.0f, 1.0f)];
		[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
		[roomIntroView addSubview:lineImageView];
		
		
		UISubLabel *addressTitle = [UISubLabel labelWithTitle:@"酒店地址" frame:CGRectMake(10.0f, name.frame.origin.y +nameLabelSize.height+12.0f, 80.0f, 20.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
		addressTitle.textColor = FontColor454545;
		[roomIntroView addSubview:addressTitle];
		
		
		address = [UISubLabel labelWithTitle:@"" frame:CGRectMake(10.0f,  name.frame.origin.y +nameLabelSize.height+40.0f, ViewWidth-50, 0.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
		address.textColor = FontColor333333;
		address.lineBreakMode = UILineBreakModeTailTruncation;
		address.numberOfLines = 0;
		address.text = self.hotelInfo._address;

		
		CGSize addressLabelSize = [address.text sizeWithFont:address.font constrainedToSize:CGSizeMake(address.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
		
		newFrame = address.frame;
		newFrame.size.height = addressLabelSize.height;
		address.frame = newFrame;
		
		[roomIntroView addSubview:address];
		
		
		
		lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(0.0f, address.frame.origin.y +addressLabelSize.height+5.0, ViewWidth-40, 1.0f)];
		[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
		[roomIntroView addSubview:lineImageView];
		
		
		UISubLabel *featureInfoTitle = [UISubLabel labelWithTitle:@"特色介绍" frame:CGRectMake(10.0f, address.frame.origin.y +addressLabelSize.height+12.0, 80.0f, 20.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
		featureInfoTitle.textColor = FontColor454545;
		[roomIntroView addSubview:featureInfoTitle];
		
		
		featureInfo = [UISubLabel labelWithTitle:@"" frame:CGRectMake(10.0f, address.frame.origin.y +addressLabelSize.height+40.0, ViewWidth-50, 00.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
		featureInfo.textColor = FontColor333333;
		featureInfo.text = self.hotelInfo._featureInfo;
		featureInfo.numberOfLines = 0;

                 CGSize featureInfoLabelSize = [featureInfo.text sizeWithFont:FontSize26 constrainedToSize:CGSizeMake(featureInfo.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
		
		
		newFrame = featureInfo.frame;
		newFrame.size.height = featureInfoLabelSize.height;
		featureInfo.frame = newFrame;
	       
		[roomIntroView addSubview:featureInfo];
		
		lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(0.0f, featureInfo.frame.origin.y +featureInfoLabelSize.height + 5.0f, ViewWidth-40, 1.0f)];
		[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
		[roomIntroView addSubview:lineImageView];
		
		
		UISubLabel *generalAmenitiesTitle = [UISubLabel labelWithTitle:@"设施服务" frame:CGRectMake(10.0f, featureInfo.frame.origin.y +featureInfoLabelSize.height+12.0f, 80.0f, 20.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
		generalAmenitiesTitle.textColor = FontColor454545;
		[roomIntroView addSubview:generalAmenitiesTitle];
		
		
		generalAmenities = [UISubLabel labelWithTitle:@"" frame:CGRectMake(10.0f, featureInfo.frame.origin.y +featureInfoLabelSize.height+40.0f, ViewWidth-50, 80.0f) font:FontSize26 alignment:NSTextAlignmentLeft];
		generalAmenities.textColor = FontColor333333;
		generalAmenities.lineBreakMode = UILineBreakModeTailTruncation;
		generalAmenities.text = self.hotelInfo._generalAmenities;
		generalAmenities.numberOfLines = 0;
		

		CGSize generalLabelSize = [generalAmenities.text sizeWithFont:generalAmenities.font constrainedToSize:CGSizeMake(generalAmenities.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
		
		newFrame = generalAmenities.frame;
		newFrame.size.height = generalLabelSize.height;
		generalAmenities.frame = newFrame;
		
		[roomIntroView addSubview:generalAmenities];
		
		
		newFrame = roomIntroView.frame;
		newFrame.size.height = cellTotalHeight;
		roomIntroView.frame = newFrame;
		
		roomIntroView.tag = kViewTag;
	}
	
	
	return roomIntroView;
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
	return 1;
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{		
	
	return cellTotalHeight+20.0f;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell = nil;
	static NSString *tHotelHomeCellID_ID = @"HotelHomeCellID";
	cell = [tableView dequeueReusableCellWithIdentifier:tHotelHomeCellID_ID];
        if (cell == nil)
        {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tHotelHomeCellID_ID] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
	else
	{
		UIView *viewToRemove = nil;
		viewToRemove = [cell.contentView viewWithTag:kViewTag];
		if (viewToRemove)
			[viewToRemove removeFromSuperview];
	}
	
	
	UIView *view =self.roomIntroView;
	[cell.contentView addSubview:view];
	
	
	cell.backgroundColor = [UIColor clearColor];

	
	// Configure the cell...
	
	return cell;
}





@end
