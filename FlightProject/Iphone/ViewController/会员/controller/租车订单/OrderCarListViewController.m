//
//  OrderCarListViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderCarListViewController.h"
#import "HotelAndCarLisDetailCell.h"
#import "PrecautionsViewController.h"
#import "CarInformationViewController.h"

@interface OrderCarListViewController ()

@end

@implementation OrderCarListViewController
@synthesize myTable,carLiFilterView,getOrderCarList,currentCarList;
@synthesize _dataIsFull,isfromRecomend,pageIndex;
@synthesize orderIds;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc
{
    timeButton = nil;
    filterButton =nil;
    priceButton =nil;
    self.myTable = nil;
    self.carLiFilterView = nil;
    self.getOrderCarList = nil;
    self.currentCarList = nil;
    self.orderIds = nil;
    [super dealloc];
}

- (void)isrefreshHeaderView
{
	if (self.isfromRecomend ) {
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
    if(pageIndex == [self.getOrderCarList.totalPage intValue] && [self.getOrderCarList.totalPage intValue] != 1)
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
    self.title = @"租车订单";
    sortTimeDese = FALSE;
    sortPriceDese = FALSE;
    loadMore = NO;
    selectButton = 0;
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
    
    UITableView * tempTable = [[UITableView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height + 5, ViewWidth, ViewHeight-44-headView.frame.size.height - 5-50) style:UITableViewStylePlain];
    tempTable.backgroundColor = [UIColor clearColor];
    tempTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    tempTable.dataSource = self;
    tempTable.delegate = self;
    self.myTable =tempTable;
    
    [self.view addSubview:tempTable];
    [tempTable release];
    [self.view addSubview:headView];
    [headView release];
    
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight-44-50, ViewWidth, 5) image:[UIImage imageNamed:@"航班动态航班号查询结果-改_10.png"]]];
    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth - 145)/2, ViewHeight-44-50+10, 145, 38) backImage:[UIImage imageNamed:@"订单注意事项.png"] target:self action:@selector(precautions)]];
    
    [self isrefreshHeaderView];
	[self loadFitstDataSource];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self._dataIsFull) {
        pageIndex = 1;
        ASIFormDataRequest * theRequest = [InterfaceClass orderCarListByUserId:[UserInfo sharedUserInfo].userID withPageIndex:@"1"];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCarListResult:) Delegate:self needUserType:Member];
    }
    self._dataIsFull = FALSE;
}

-(void)precautions
{
    PrecautionsViewController *precautionsViewController = [[PrecautionsViewController alloc] init];
    [NavigationController pushViewController:precautionsViewController animated:YES];
    [precautionsViewController release];
}
-(void)timeSort
{
    if (sortTimeDese) {
        self.currentCarList.carList = (NSMutableArray*)[self.currentCarList.carList sortedArrayUsingFunction:sortArrayBySubmitDate context:NULL];
        self.getOrderCarList.carList = (NSMutableArray*)[self.getOrderCarList.carList sortedArrayUsingFunction:sortArrayBySubmitDate context:NULL];
    }
    else {
        self.currentCarList.carList = (NSMutableArray*)[self.currentCarList.carList sortedArrayUsingFunction:sortArrayBySecondSubmitDate context:NULL];
        self.getOrderCarList.carList = (NSMutableArray*)[self.getOrderCarList.carList sortedArrayUsingFunction:sortArrayBySecondSubmitDate context:NULL];
    }
}
-(void)timeButton:(UIButton *)sender
{
    NSLog(@"timeButton");
    [self.carLiFilterView removeFromSuperview];
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
        self.currentCarList.carList = (NSMutableArray*)[self.currentCarList.carList sortedArrayUsingFunction:sortArrayByTotalPrice context:NULL];
        self.getOrderCarList.carList =  (NSMutableArray*)[self.getOrderCarList.carList sortedArrayUsingFunction:sortArrayByTotalPrice context:NULL];
    }
    else {
        self.currentCarList.carList = (NSMutableArray*)[self.currentCarList.carList sortedArrayUsingFunction:sortArrayByTotalPriceSecond context:NULL];
        self.getOrderCarList.carList = (NSMutableArray*)[self.getOrderCarList.carList sortedArrayUsingFunction:sortArrayByTotalPriceSecond context:NULL];
    }
}
-(void)priceButton:(UIButton *)sender
{
    NSLog(@"priceButton");
    [self.carLiFilterView removeFromSuperview];
    sortPriceDese = !sortPriceDese;
    selectButton = 2;
    [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeNone.png"] forState:UIControlStateNormal];
    [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
    
    if (sortPriceDese) {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListPriceUp.png"] forState:UIControlStateNormal];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListPriceDown.png"] forState:UIControlStateNormal];
    }
    [self priceSort];
    [self.myTable reloadData];
}

-(NSArray*)getMyStatesArray
{
    NSMutableArray * ordersStates = [NSMutableArray array];
    [ordersStates addObject:[NSString stringWithFormat:@"不限"]];
    for (OrderCarModel * elem in self.getOrderCarList.carList) {
        
        if (![ordersStates containsObject:elem.orderStatus]) {
            [ordersStates addObject:elem.orderStatus];
            NSLog(@"%@",elem.orderStatus);
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
    
    if (self.carLiFilterView == nil) {
        CarHotelLiFilterView * filterView1 = [[CarHotelLiFilterView alloc] initWithFrame:CGRectMake(0,35,ViewWidth,ViewHeight - (IOS7_OR_LATER?15:35)  )];
        self.carLiFilterView = filterView1;
        self.carLiFilterView.delegate = self;
        [filterView1 release];
    }
    self.carLiFilterView.statusArray = [self getMyStatesArray];
    [self.carLiFilterView setButtons];
    
    self.carLiFilterView.frame = CGRectMake(0,35,ViewWidth,ViewHeight - (IOS7_OR_LATER?15:35));
    if (self.carLiFilterView.superview == nil) {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListFilter.png"] forState:UIControlStateNormal];
        [self.view insertSubview:self.carLiFilterView atIndex: [[self.view subviews] count] animated:YES ];
    }
    else
    {
        [self setCarButtonTypeImage];
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
        [self.carLiFilterView removeFromSuperviewWithAnimated:YES];
    }
}

-(void)selectState:(UIButton*)sender
{
    FilterButtonView * filterButtonView = (FilterButtonView * )sender.superview;
    filterButtonView.isSelecded = TRUE;
    filterButtonView.aLabel.textColor = FontColor2585CF;
    [filterButtonView.selectButton setBackgroundImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
    
    for (FilterButtonView * elem in [self.self.carLiFilterView subviews]) {
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
//    NSArray *array = [NSArray arrayWithObjects:@"不限",@"已预订",@"已完成",@"租赁中",@"已取消", nil];
    int i=0;
    for (FilterButtonView * elem in [self.carLiFilterView subviews]) {
        loadMore = YES;
        if ([elem isKindOfClass:[FilterButtonView class]]) {
            if(elem.isSelecded)
            {
                NSLog(@"%@",[self.carLiFilterView.statusArray objectAtIndex:i]);
                if([[self.carLiFilterView.statusArray objectAtIndex:i] isEqualToString:@"不限"])
                {
                    for(id elem2 in self.getOrderCarList.carList)
                    {
                        [getNewArray addObject:elem2];
                    }
                    break;
                }
                for(int k=0;k<[self.getOrderCarList.carList count];k++)
                {
                    if([((OrderCarModel*)[self.getOrderCarList.carList objectAtIndex:k]).orderStatus isEqualToString:[self.carLiFilterView.statusArray objectAtIndex:i]])
                    {
                        [getNewArray addObject:[self.getOrderCarList.carList objectAtIndex:k]];
                    }
                }
            }
            i++;
        }
        
    }
    
    [self setCarButtonTypeImage];
    if ([getNewArray count] == 0) {
        [self.carLiFilterView removeFromSuperviewWithAnimated:YES];
        if(loadMore)
        [UIAlertView alertViewWithMessage:@"暂无符合筛选条件的租车订单！" :@"提示"];
    }
    else {
        self.currentCarList.carList = getNewArray;
        [self.carLiFilterView removeFromSuperviewWithAnimated:YES];
        [self.myTable reloadData];
    }
    
     [self setHeaderView];
}


static NSInteger sortArrayBySubmitDate(id item1, id item2, void *context){//从晚到早
    OrderCarModel *info1 = item1;
	OrderCarModel *info2 = item2;
    
	if ([info1.submitDate compare:info2.submitDate] < 0)
        return NSOrderedDescending;
    else if ([info1.submitDate compare:info2.submitDate] > 0)
        return NSOrderedAscending;
    else
        return NSOrderedSame;
}

static NSInteger sortArrayBySecondSubmitDate(id item1, id item2, void *context){//从早到晚
    OrderCarModel *info1 = item1;
	OrderCarModel *info2 = item2;
    
	if ([info1.submitDate compare:info2.submitDate] < 0)
        return NSOrderedAscending;
    else if ([info1.submitDate compare:info2.submitDate] > 0)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

static NSInteger sortArrayByTotalPrice(id item1, id item2, void *context){//从高到低
    OrderCarModel *info1 = item1;
	OrderCarModel *info2 = item2;
    
    int v1 = [info1.totalPrice intValue];
    int v2 = [info2.totalPrice intValue];
	if (v1 < v2)
        return NSOrderedAscending;//升序
    else if (v1 >v2)
        return NSOrderedDescending;//降序
    else
        return NSOrderedSame;
}

static NSInteger sortArrayByTotalPriceSecond(id item1, id item2, void *context){//从高到低
    OrderCarModel *info1 = item1;
	OrderCarModel *info2 = item2;
    
    int v1 = [info1.totalPrice intValue];
    int v2 = [info2.totalPrice intValue];
	if (v1 < v2)
        return NSOrderedDescending;//降序
    else if (v1 >v2)
        return NSOrderedAscending;//升序
    else
        return NSOrderedSame;
}

#pragma mark tableviewdelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentCarList.carList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    HotelAndCarLisDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[HotelAndCarLisDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
    }
    [cell.label1 setText:@"取车:"];
    [cell.label2 setText:@"还车:"];
    
    OrderCarModel *carModel = [self.currentCarList.carList objectAtIndex:indexPath.row];
    [cell.name setText:carModel.carName];
    [cell.typeName setText:carModel.typeDesc];
    NSArray *array1 =[carModel.submitDate componentsSeparatedByString:@" "];
    NSArray *array2 =[carModel.takeDate componentsSeparatedByString:@" "];
    NSArray *array3 =[carModel.returnDate componentsSeparatedByString:@" "];
    [cell.scheduleDate setText:[NSString stringWithFormat:@"%@ 提交",[array1 objectAtIndex:0]]];
    [cell.checkInDate setText:[array2 objectAtIndex:0]];
    [cell.checkOutDate setText:[array3 objectAtIndex:0]];
    [cell.totelMoney setText:carModel.totalPrice];
    if((int)([carModel.totalPrice floatValue]*100)%100)
    {
        [cell.totelMoney setText:[NSString stringWithFormat:@"%d",[carModel.totalPrice intValue]+1]];
    }
    else 
    {
        [cell.totelMoney setText:[NSString stringWithFormat:@"%d",[carModel.totalPrice intValue]]];;
    }
    [cell.stateCodeImageV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"租车-%@.png",carModel.orderStatus]]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 0, 300, 74)];
    NSLog(@"%d",indexPath.row);
    self.orderIds = ((OrderCarModel*)[self.currentCarList.carList objectAtIndex:indexPath.row]).ids;
    ASIFormDataRequest * theRequest = [InterfaceClass orderCarInformationByorderId:self.orderIds];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCarInformationPaseredResult:) Delegate:self needUserType:Member];
}

-(void)onCarInformationPaseredResult:(NSDictionary*)dic
{
    CarInformationViewController *carInformationVC = [[CarInformationViewController alloc] init];
    carInformationVC._carInfoData = [GetOrderCarInformation GetOrderCarInformation:dic];
    carInformationVC._ids = self.orderIds;
    [NavigationController pushViewController:carInformationVC animated:YES];
    [carInformationVC release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void)setCarButtonTypeImage
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
            [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceUp.png"] forState:UIControlStateNormal];
        }
        else {
            [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceDown.png"] forState:UIControlStateNormal];
        }
    }
}
-(void)onCarListResult:(NSDictionary*)dic
{
    if (pageIndex==1)
    {
        self.getOrderCarList = (GetOrderCarList*)[GetOrderCarList GetOrderCarList:dic];
        self.currentCarList = (GetOrderCarList*)[GetOrderCarList GetOrderCarList:dic];
    }
	else
    {
        NSMutableArray *arraytemp = [NSMutableArray arrayWithArray:self.getOrderCarList.carList];
        NSMutableArray *array = [GetOrderCarList GetOrderCarList:dic].carList;
    	[arraytemp addObjectsFromArray:array];
        self.getOrderCarList.carList = arraytemp;
        self.currentCarList.carList = self.getOrderCarList.carList;
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




-(void)loadSourceData
{
    ASIFormDataRequest * theRequest = [InterfaceClass orderCarListByUserId:[UserInfo sharedUserInfo].userID withPageIndex:[NSString stringWithFormat:@"%d",pageIndex]];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCarListResult:) Delegate:self needUserType:Member];
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
    if(pageIndex == [self.getOrderCarList.totalPage intValue])
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

@end
