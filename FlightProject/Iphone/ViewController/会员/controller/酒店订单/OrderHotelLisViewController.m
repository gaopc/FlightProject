//
//  OrderHotelLisViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderHotelLisViewController.h"
#import "HotelAndCarLisDetailCell.h"
#import "HotelInformationViewController.h"

@interface OrderHotelLisViewController ()
- (void)isrefreshHeaderView;
- (void)loadFitstDataSource;
@end

@implementation OrderHotelLisViewController
@synthesize myTable,getOrderHotelList,hotelLiFilterView,currentHotelList,pageIndex;
@synthesize _dataIsFull,isfromRecomend;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
			[self.myTable addSubview:_refreshHeaderView];
			[_refreshHeaderView refreshLastUpdatedDate];
		}
	}
}
- (void)loadFitstDataSource
{
	[self.myTable reloadData];
	
	_refreshHeaderView.frame=CGRectMake(0.0f, self.myTable.contentSize.height, self.myTable.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}

-(void)setHeaderView
{
    if(pageIndex == [self.getOrderHotelList.totalPage intValue] && [self.getOrderHotelList.totalPage intValue] != 1)
    {
        self.isfromRecomend = YES;
        [self isrefreshHeaderView];
        myTable.contentSize = CGSizeMake(ViewWidth, myTable.contentSize.height-65.0f);
        return;
    }
    _refreshHeaderView.frame=CGRectMake(0.0f, self.myTable.contentSize.height, self.myTable.frame.size.width, 80);
    [self doneLoadingTableViewData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"酒店订单";
    sortTimeDese = FALSE;
    sortPriceDese = FALSE;
    selectButton = 0;
    loadMore = NO;
	// Do any additional setup after loading the view.
    UIView * headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, ViewWidth, 35);
    
    timeButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListTimeNone.png"] target:self action:@selector(timeButton:)];
    filterButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth/3, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListFilterNone.png"] target:self action:@selector(filterButton:)];
    priceButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth*2/3, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListPriceNone.png"] target:self action:@selector(priceButton:)];
    
    [headView addSubview : timeButton];
    [headView addSubview : filterButton];
    [headView addSubview : priceButton];
    
    [self timeButton:timeButton];
    
    UITableView * tempTable = [[UITableView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height + 5, ViewWidth, ViewHeight-84) style:UITableViewStylePlain];//ViewHeight-44-headView.frame.size.height - 5
    tempTable.backgroundColor = [UIColor clearColor];
    tempTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    tempTable.dataSource = self;
    tempTable.delegate = self;
    self.myTable =tempTable;
    
    [self.view addSubview:tempTable];
    [tempTable release];
    [self.view addSubview:headView];
    [headView release];

	[self isrefreshHeaderView];
	
	[self loadFitstDataSource];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self._dataIsFull) {
        pageIndex = 1;
        [self loadSourceData];
    }
    
    self._dataIsFull = FALSE;
}

-(void)loadSourceData
{
    ASIFormDataRequest * theRequest = [InterfaceClass orderHotelListByUserId:[UserInfo sharedUserInfo].userID withPageIndex:[NSString stringWithFormat:@"%d",pageIndex]];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onHotelListResult:) Delegate:self needUserType:Member];
}

-(void)timeSort
{
    if (sortTimeDese) {
        self.currentHotelList.hotelList = (NSMutableArray *)[self.currentHotelList.hotelList sortedArrayUsingFunction:sortArrayByScheduleDate context:NULL];
        self.getOrderHotelList.hotelList = (NSMutableArray *)[self.getOrderHotelList.hotelList sortedArrayUsingFunction:sortArrayByScheduleDate context:NULL];
    }
    else {
        self.currentHotelList.hotelList = (NSMutableArray *)[self.currentHotelList.hotelList sortedArrayUsingFunction:sortArrayBySecondScheduleDate context:NULL];
        self.getOrderHotelList.hotelList = (NSMutableArray *)[self.getOrderHotelList.hotelList sortedArrayUsingFunction:sortArrayBySecondScheduleDate context:NULL];
    }
}

-(void)timeButton:(UIButton *)sender
{
    NSLog(@"timeButton");
    [self.hotelLiFilterView removeFromSuperview];
    sortTimeDese = !sortTimeDese;
    selectButton = 1;
    [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
    [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceNone.png"] forState:UIControlStateNormal];
    if (sortTimeDese) {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListTimeDown.png"] forState:UIControlStateNormal];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListTimeUp.png"] forState:UIControlStateNormal];
    }
    [self timeSort];
    [self.myTable reloadData];
}

-(void)priceSort
{
    if (sortPriceDese) {
        self.currentHotelList.hotelList = (NSMutableArray *)[self.currentHotelList.hotelList sortedArrayUsingFunction:sortArrayByTotelMoneySecond  context:NULL];
        self.getOrderHotelList.hotelList = (NSMutableArray *)[self.getOrderHotelList.hotelList sortedArrayUsingFunction:sortArrayByTotelMoneySecond context:NULL];
    }
    else {
        self.currentHotelList.hotelList = (NSMutableArray *)[self.currentHotelList.hotelList sortedArrayUsingFunction:sortArrayByTotelMoney context:NULL];
        self.getOrderHotelList.hotelList = (NSMutableArray *)[self.getOrderHotelList.hotelList sortedArrayUsingFunction:sortArrayByTotelMoney context:NULL];
    }
}

-(void)priceButton:(UIButton *)sender
{
    NSLog(@"priceButton");
    [self.hotelLiFilterView removeFromSuperview];
    sortPriceDese = !sortPriceDese;
    selectButton = 2;
    [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeNone.png"] forState:UIControlStateNormal];
    [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
    
    if (sortPriceDese) {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListPriceDown.png"] forState:UIControlStateNormal];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListPriceUp.png"] forState:UIControlStateNormal];
    }
    [self priceSort];
    [self.myTable reloadData];
}

-(NSArray*)getMyStatesArray
{
    NSMutableArray * ordersStates = [NSMutableArray array];
    [ordersStates addObject:[NSString stringWithFormat:@"不限"]];
    for (HotelModel * elem in self.getOrderHotelList.hotelList) {
        
        if (![ordersStates containsObject:elem.stateString]) {
            [ordersStates addObject:elem.stateString];
        }
    }
    [ordersStates sortUsingSelector:@selector(compare:)];
    return ordersStates;
}
-(void)filterButton:(UIButton *)sender
{
    NSLog(@"filterButton");
    [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeNone.png"] forState:UIControlStateNormal];
    [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceNone.png"] forState:UIControlStateNormal];

    if (self.hotelLiFilterView == nil) {
        CarHotelLiFilterView * filterView1 = [[CarHotelLiFilterView alloc] initWithFrame:CGRectMake(0,35,ViewWidth,ViewHeight -  (IOS7_OR_LATER?15:35)  )];
        self.hotelLiFilterView = filterView1;
        self.hotelLiFilterView.delegate = self;
        [filterView1 release];
    }
    self.hotelLiFilterView.statusArray = [self getMyStatesArray];
    [self.hotelLiFilterView setButtons];
    
    self.hotelLiFilterView.frame = CGRectMake(0,35,ViewWidth,ViewHeight - (IOS7_OR_LATER?15:35));

    if (self.hotelLiFilterView.superview == nil) {
         [sender setBackgroundImage:[UIImage imageNamed:@"TicketListFilter.png"] forState:UIControlStateNormal];
        [self.view insertSubview:self.hotelLiFilterView atIndex: [[self.view subviews] count] -1 animated:YES ];
    }
    else
    {
        [self setHotelButtonTypeImage];
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
        [self.hotelLiFilterView removeFromSuperviewWithAnimated:YES];
    }
}

-(void)selectState:(UIButton*)sender
{
    FilterButtonView * filterButtonView = (FilterButtonView * )sender.superview;
    filterButtonView.isSelecded = TRUE;
    filterButtonView.aLabel.textColor = FontColor2585CF;
    [filterButtonView.selectButton setBackgroundImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
        
    for (FilterButtonView * elem in [self.hotelLiFilterView subviews]) {
        if ([elem isKindOfClass:[FilterButtonView class]]) {
            if (elem.tag != filterButtonView.tag) {
                elem.isSelecded = FALSE;
                elem.aLabel.textColor = FontColor333333;
                [elem.selectButton setBackgroundImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
            }
        }
    }
}

-(void)filterDown
{
    [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
    NSMutableArray *getNewArray = [NSMutableArray array];
//    NSArray *array = [NSArray arrayWithObjects:@"不限",@"已确认",@"已结账",@"未入住",@"处理中",@"已取消",nil];
    int i=0;
    for (FilterButtonView * elem in [self.hotelLiFilterView subviews]) {
        loadMore = YES;
        if ([elem isKindOfClass:[FilterButtonView class]]) {
            if(elem.isSelecded)
            {
                NSLog(@"筛选条件==%@",[self.hotelLiFilterView.statusArray objectAtIndex:i]);
                if([[self.hotelLiFilterView.statusArray objectAtIndex:i] isEqualToString:@"不限"])
                {
                    for(id elem2 in self.getOrderHotelList.hotelList)
                    {
                        [getNewArray addObject:elem2];
                    }
                    break;
                }
                for(int k=0;k<[self.getOrderHotelList.hotelList count];k++)
                {
                    if([((HotelModel*)[self.getOrderHotelList.hotelList objectAtIndex:k]).stateString isEqualToString:[self.hotelLiFilterView.statusArray objectAtIndex:i]])
                    {
                        [getNewArray addObject:[self.getOrderHotelList.hotelList objectAtIndex:k]];
                    }
                }
            }
            i++;
        }
        
    }
    
    [self setHotelButtonTypeImage];
    if ([getNewArray count] == 0) {
        [self.hotelLiFilterView removeFromSuperviewWithAnimated:YES];
        if(loadMore)
        [UIAlertView alertViewWithMessage:@"暂无符合筛选条件的酒店订单！" :@"提示"];
    }
    else {
        self.currentHotelList.hotelList = getNewArray;
        [self.hotelLiFilterView removeFromSuperviewWithAnimated:YES];
        [self.myTable reloadData];
    }
    [self setHeaderView];
}

static NSInteger sortArrayByScheduleDate(id item1, id item2, void *context){//从晚到早
    HotelModel *info1 = item1;
	HotelModel *info2 = item2;
    
	if ([info1.scheduleDate compare:info2.scheduleDate] < 0)
        return NSOrderedDescending;
    else if ([info1.scheduleDate compare:info2.scheduleDate] > 0)
        return NSOrderedAscending;
    else
        return NSOrderedSame;
}

static NSInteger sortArrayBySecondScheduleDate(id item1, id item2, void *context){//从早到晚
    HotelModel *info1 = item1;
	HotelModel *info2 = item2;
    
	if ([info1.scheduleDate compare:info2.scheduleDate] < 0)
        return NSOrderedAscending;
    else if ([info1.scheduleDate compare:info2.scheduleDate] > 0)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

static NSInteger sortArrayByTotelMoney(id item1, id item2, void *context){//从高到低
    HotelModel *info1 = item1;
	HotelModel *info2 = item2;
    
    int v1 = [info1.totelMoney intValue];
    int v2 = [info2.totelMoney intValue];
	if (v1 < v2)
        return NSOrderedAscending;//升序
    else if (v1 >v2)
        return NSOrderedDescending;//降序
    else
        return NSOrderedSame;
}

static NSInteger sortArrayByTotelMoneySecond(id item1, id item2, void *context){//从高到低
    HotelModel *info1 = item1;
	HotelModel *info2 = item2;
    
    int v1 = [info1.totelMoney intValue];
    int v2 = [info2.totelMoney intValue];
	if (v1 < v2)
        return NSOrderedDescending;//降序
    else if (v1 >v2)
        return NSOrderedAscending;//升序
    else
        return NSOrderedSame;
}

#pragma marl tableviewdelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentHotelList.hotelList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    HotelAndCarLisDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[HotelAndCarLisDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
    }
    HotelModel *hotelModel = [self.currentHotelList.hotelList objectAtIndex:indexPath.row];
    [cell.name setText:hotelModel.hotelName];
    [cell.typeName setText:hotelModel.roomTypeName];
    [cell.scheduleDate setText:[NSString stringWithFormat:@"%@ 提交",hotelModel.scheduleDate]];
    [cell.checkInDate setText:hotelModel.checkInDate];
    [cell.checkOutDate setText:hotelModel.checkOutDate];
    if((int)([hotelModel.totelMoney floatValue]*100)%100)
    {
        [cell.totelMoney setText:[NSString stringWithFormat:@"%d",[hotelModel.totelMoney intValue]+1]];
    }
    else 
    {
        [cell.totelMoney setText:[NSString stringWithFormat:@"%d",[hotelModel.totelMoney intValue]]];;
    }
    // 0处理中 1未入住 2已结账 3已取消 4已确认
    [cell.stateCodeImageV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"酒店%@.png",hotelModel.stateCode]]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 0, 300, 74)];
    NSLog(@"%d",indexPath.row);
    HotelInformationViewController *hotelInformationVC = [[HotelInformationViewController alloc] init];
    hotelInformationVC._hotelDetailInfo = [self.currentHotelList.hotelList objectAtIndex:indexPath.row];
    [NavigationController pushViewController:hotelInformationVC animated:YES];
    [hotelInformationVC release];
}

- (void)dealloc
{
    timeButton = nil;
    filterButton = nil;
    priceButton = nil;
    self.myTable = nil;
    self.getOrderHotelList = nil;
    self.hotelLiFilterView = nil;
    self.currentHotelList = nil;
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)onHotelListResult:(NSDictionary*)dic
{
    if (pageIndex==1)
    {
    	self.getOrderHotelList = (GetOrderHotelList*)[GetOrderHotelList GetOrderHotelList:dic];
        self.currentHotelList = (GetOrderHotelList*)[GetOrderHotelList GetOrderHotelList:dic];
    }
	else
    {
        NSMutableArray *arraytemp = [NSMutableArray arrayWithArray:self.getOrderHotelList.hotelList];
        NSMutableArray *array = [GetOrderHotelList GetOrderHotelList:dic].hotelList;
    	[arraytemp addObjectsFromArray:array];
        self.getOrderHotelList.hotelList = arraytemp;
        self.currentHotelList.hotelList = self.getOrderHotelList.hotelList;
        [self filterDown];
    }
	
    if(selectButton == 1)
    {
        [self timeSort];
    }
    if(selectButton == 2)
    {
        [self priceSort];
    }
    
    [self.myTable reloadData];
    [self setHeaderView];

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
    if(pageIndex == [self.getOrderHotelList.totalPage intValue])
    {
        return;
    }
    pageIndex++;
    [self loadSourceData];
    reloading = YES;
}

//还原方法
- (void)doneLoadingTableViewData{
	reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.myTable];
}


#pragma mark -
#pragma mark UIScrollViewDelegate －－上拉涮新相关

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

- (void)setHotelButtonTypeImage
{
    if (selectButton == 1) {
        if (sortTimeDese) {
            [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeDown.png"] forState:UIControlStateNormal];
        }
        else {
            [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeUp.png"] forState:UIControlStateNormal];
        }
    }
    else if (selectButton == 2)
    {
        if (sortPriceDese) {
            [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceDown.png"] forState:UIControlStateNormal];
        }
        else {
            [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceUp.png"] forState:UIControlStateNormal];
        }
    }
}
@end
