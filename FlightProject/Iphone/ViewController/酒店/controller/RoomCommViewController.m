//
//  RoomCommViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoomCommViewController.h"
#import "HotelQueryDataResponse.h"
#import "HotelCommCell.h"
@interface RoomCommViewController ()
//加载数据
- (void)loadDataSource;
@end

@implementation RoomCommViewController

@synthesize c_tableView = _c_tableView;
@synthesize hotelCommArray = _hotelCommArray;
@synthesize hotelInfo,noCommTitleLabel;
- (void)loadView{
	
	[super loadView];
    	
	_c_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,15.0f,ViewWidth,ViewHeight-100.0f) style:UITableViewStylePlain];  
	self.c_tableView.backgroundColor = [UIColor clearColor];
	self.c_tableView.dataSource = self;
	self.c_tableView.delegate = self;
        self.c_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:self.c_tableView];
	
//	_refreshHeaderView = [[EGORefreshTableHeaderView alloc] init]; //initWithFrame: CGRectMake(0.0f, 698, 1024, 80)];
//	_refreshHeaderView.delegate = self;
//	_refreshHeaderView.backgroundColor= [UIColor clearColor];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"VideoInfo.png"]];
//	[self.c_tableView addSubview:_refreshHeaderView];
//	
//	[_refreshHeaderView refreshLastUpdatedDate];
	
}
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	_hotelCommArray = [[NSMutableArray alloc] init];
	pageIndex = 1;
	[self loadDataSource];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	self.hotelCommArray = nil;
	self.c_tableView = nil;
	// Release any retained subviews of the main view.
}

- (void) dealloc {
	
	[_hotelCommArray release];
	[_c_tableView release];
	[_refreshHeaderView release];
	self.hotelInfo = nil;
	self.noCommTitleLabel = nil;
	[super dealloc];	
}


//加载数据
- (void)loadDataSource
{
	
	ASIFormDataRequest * theRequest = [InterfaceClass queryComment:self.hotelInfo._hotelId withPageIndex:pageIndex];	
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryCommentPaseredResult:) Delegate:self needUserType:Default];
	
}

//加载成功
- (void)onqueryCommentPaseredResult:(NSDictionary *)dic
{
	if (pageIndex==1){
		self.hotelCommArray = [HotelQueryDataResponse queryComment:dic];
		if ([self.hotelCommArray count] >=10)
			[self isrefreshHeaderView];
		if ([self.hotelCommArray count] ==0)
		{
			
			self.noCommTitleLabel =[UISubLabel labelWithTitle:@"酒店当前还没有评论内容" frame:CGRectMake(0.0f, 86.0f, ViewWidth, 25.0f) font:FontBlodSize36 color:FontColor333333  alignment:NSTextAlignmentCenter];
			[self.view addSubview:self.noCommTitleLabel];
		}
		
	}else{
		[self.hotelCommArray addObjectsFromArray:[HotelQueryDataResponse queryComment:dic]];
	}
        [self.c_tableView reloadData];

	_refreshHeaderView.frame=CGRectMake(0.0f, self.c_tableView.contentSize.height, self.c_tableView.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}

- (void)isrefreshHeaderView
{
	if (!_refreshHeaderView) {
		_refreshHeaderView = [[EGORefreshTableHeaderView alloc] init]; 
		_refreshHeaderView.delegate = self;
		_refreshHeaderView.backgroundColor= [UIColor clearColor];
		[self.c_tableView addSubview:_refreshHeaderView];
		[_refreshHeaderView refreshLastUpdatedDate];
	}else {
		[_refreshHeaderView removeFromSuperview];
		_refreshHeaderView = nil;
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
	return [self.hotelCommArray count];
	
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{		
	
	return 110.0f;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * identifier = @"identifier";
	HotelCommCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[HotelCommCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		cell.backgroundColor = [UIColor clearColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
	}
	
	HotelCommentInfo *hotelCommentInfo = nil;
	hotelCommentInfo = (HotelCommentInfo *)[self.hotelCommArray objectAtIndex:indexPath.row];
	cell.name.text = hotelCommentInfo._name;
	cell.time.text =hotelCommentInfo._time;
	cell.evaluate.text = hotelCommentInfo._evaluate;
	
	// Configure the cell...
	
	return cell;
}





#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate －－上拉涮新委托方法

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:4.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}




#pragma mark -
#pragma mark Data Source Loading / Reloading －－上拉涮新相关

//实现上拖的方法
- (void)reloadTableViewDataSource
{
	if (self.hotelCommArray.count%10==0) {
		pageIndex++;
		
		[self loadDataSource];
		
		reloading = YES;
	}

	
}

//还原方法
- (void)doneLoadingTableViewData{
	reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.c_tableView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate －－上拉涮新相关

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}




@end
