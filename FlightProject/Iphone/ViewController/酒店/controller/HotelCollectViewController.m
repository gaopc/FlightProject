//
//  HotelCollectViewController.m
//  FlightProject
//
//  Created by z1 on 13-6-26.
//
//

#import "HotelCollectViewController.h"

#import "HotelCollectCell.h"
#import "InterfaceClass.h"
#import "ASIFormDataRequest.h"
#import "NSDate+convenience.h"
#import "RoomHomeViewController.h"
#import "HotelQueryDataResponse.h"
#import "TicketQueryViewController.h"
#import "HotelHomeViewController.h"
@interface HotelCollectViewController ()
- (void)loadDataSource;
//加载酒店详情数据
- (void)loadDelDataSource;
- (void)isrefreshHeaderView;

@end

@implementation HotelCollectViewController
@synthesize h_tableView = _h_tableView;
@synthesize hotelListArray,hotelCollect,queryDataModel;
@synthesize pageIndex,_dataIsFull,isfromRecomend,promptlable,hotelCollectDataResponse;


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	if (!self._dataIsFull) {
		pageIndex = 1;
		[self loadDataSource];
	}
	
	self._dataIsFull = FALSE;
}

- (void)isrefreshHeaderView
{
	if (self.isfromRecomend) {
		[_refreshHeaderView removeFromSuperview];
		_refreshHeaderView = nil;
		
	}else {
		if (!_refreshHeaderView) {
			_refreshHeaderView = [[EGORefreshTableHeaderView alloc] init];
			_refreshHeaderView.delegate = self;
			_refreshHeaderView.backgroundColor= [UIColor clearColor];
			[self.h_tableView addSubview:_refreshHeaderView];
			[_refreshHeaderView refreshLastUpdatedDate];
		}
	}
}


-(void)setHeaderView
{
	if(self.hotelCollectDataResponse._totalPage <= 1)
	{
		self.isfromRecomend = YES;
		[self isrefreshHeaderView];
		return;
	}
	if(pageIndex == self.hotelCollectDataResponse._totalPage && self.hotelCollectDataResponse._totalPage != 1)
	{
		self.isfromRecomend = YES;
		[self isrefreshHeaderView];
		self.h_tableView.contentSize = CGSizeMake(ViewWidth, self.h_tableView.contentSize.height-65.0f);
		return;
	}
	_refreshHeaderView.frame=CGRectMake(0.0f, self.h_tableView.contentSize.height, self.h_tableView.frame.size.width, 80);
	[self doneLoadingTableViewData];
}


- (void)loadView{
	
	[super loadView];
	self.title = @"收藏酒店";
	
	self.queryDataModel = [[TicketQueryDataModel alloc] init];
	
	self.queryDataModel._startDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[NSDate dateFormateTicketQuery:[NSDate date]] code:[NSDate dateCode:[NSDate date] ]];
	self.queryDataModel._arriveDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate date] day:PushBackOneDay type:3] code: [NSDate dateafterDay:[NSDate date] day:PushBackOneDay type:1]];
	
	self.promptlable = [UISubLabel labelWithTitle:@"您没有收藏任何酒店" frame:CGRectMake(15.0f, 40.0f, 300.0f, 25.0f) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
	self.promptlable.hidden = YES;
	[self.view addSubview: self.promptlable];
	
	_h_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,10.0f,ViewWidth,ViewHeight-60.0f) style:UITableViewStylePlain];
	self.h_tableView.backgroundColor = [UIColor clearColor];
	self.h_tableView.dataSource = self;
	self.h_tableView.delegate = self;
        self.h_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:self.h_tableView];
	
	[self isrefreshHeaderView];
	
	
}

//加载数据
- (void)loadDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass collectionList:[UserInfo sharedUserInfo].userID withPageIndex:[NSString stringWithFormat:@"%d",pageIndex]];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryHotelPaseredResult:) Delegate:self needUserType:Default];
	
}


//加载成功
- (void)onqueryHotelPaseredResult:(NSDictionary *)dic
{
	self.hotelCollectDataResponse = [HotelCollectDataResponse hotelCollectQuery:dic];
	if (pageIndex==1)
		self.hotelListArray = self.hotelCollectDataResponse._hotelCollectQueryArray;
	else
		[self.hotelListArray addObjectsFromArray:self.hotelCollectDataResponse._hotelCollectQueryArray];
	
	if (self.hotelListArray.count <=0) {
		self.promptlable.hidden = NO;
	}
	
	[self.h_tableView reloadData];
	
	[self setHeaderView];
	
	
}


//删除酒店收藏hotelInfo
-(void) loadDelDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass cancelCollection:[UserInfo sharedUserInfo].userID withHotelId:self.hotelCollect._hotelId];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelPaseredResult:) Delegate:self needUserType:Member];
	
}

- (void)onDelPaseredResult:(NSDictionary *)dic
{
	if (pageIndex != self.hotelCollectDataResponse._totalPage) {
		pageIndex = 1;
		[self.hotelListArray removeAllObjects];
		[self loadDataSource];
	}
}

- (void) dealloc {
	
	self.h_tableView = nil;
	self.h_tableView.delegate = nil;
	self.h_tableView.dataSource = nil;
	self.hotelListArray = nil;
	self.promptlable = nil;
	[_h_tableView release];
	[super dealloc];
}


- (void)viewDidLoad
{
	
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - Table view data source


#pragma mark -
#pragma mark UITableView方法
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
	
	return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		self.hotelCollect = (HotelCollect *)[self.hotelListArray objectAtIndex:indexPath.row];
		if(pageIndex == self.hotelCollectDataResponse._totalPage){
			[self.hotelListArray removeObjectAtIndex:indexPath.row];
			[self.h_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		}
		[self loadDelDataSource];
	}
	else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	return [self.hotelListArray count];
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return 108.0f;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString * identifier = @"identifier";
	HotelCollectCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[HotelCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		cell.backgroundColor = [UIColor clearColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
	}
	HotelCollect *ahotelInfo = nil;
	ahotelInfo = (HotelCollect *)[self.hotelListArray objectAtIndex:indexPath.row];
	cell.hotelName.text = ahotelInfo._hotelName;
	
	cell.rating.text =[NSString stringWithFormat:@"%@ %.1f",@"点评 : ",ahotelInfo._rating];
	cell.districtName.text = ahotelInfo._districtName;
	
	if(ahotelInfo._diamond){
		[cell drawDiamondCodeView:ahotelInfo._starCode];
	}else{
		[cell drawStarCodeView:ahotelInfo._starCode];
	}
	
	
	
	return cell;
	
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	HotelCollect *ahotelInfo = nil;
	ahotelInfo = (HotelCollect *)[self.hotelListArray objectAtIndex:indexPath.row];
	
	hotelHomeVC.queryDataModel._fromCity._nameCode = ahotelInfo._cityCode;
	hotelHomeVC.queryDataModel._fromCity._nameStr = ahotelInfo._city;
	hotelHomeVC.hotelRequestPara._hotelName = ahotelInfo._hotelName;
	hotelHomeVC.hotelRequestPara._hotelArea = @"";
	hotelHomeVC.hotelRequestPara._administrativeArea =@"";
	hotelHomeVC.hotelRequestPara._businessArea =@"";
	
	
	hotelHomeVC.isCollect = TRUE;
	for (int i = 0; i < [NavigationController.viewControllers count]-1; i++) {
		
		if ([[NavigationController.viewControllers objectAtIndex:i] isKindOfClass:[HotelHomeViewController class]])
		{
			HotelHomeViewController *hotelHome = [NavigationController.viewControllers objectAtIndex:i];
			[self.navigationController popToViewController:hotelHome animated:YES];
			
		}
	}
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
	if(pageIndex == self.hotelCollectDataResponse._totalPage)
	{
		return;
	}
	pageIndex++;
	[self loadDataSource];
	reloading = YES;
}

//还原方法
- (void)doneLoadingTableViewData{
	reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.h_tableView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate －－上拉涮新相关

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
