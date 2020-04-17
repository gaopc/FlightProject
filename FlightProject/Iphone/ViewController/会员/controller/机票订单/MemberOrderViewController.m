//
//  MemberOrderViewController.m
//  FlightProject
//
//  Created by admin on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberOrderViewController.h"
#import "MemberLoginViewController.h"
@interface OrderListFilterViewOrdersStateView : UIView
@property (nonatomic,retain) UIButton * _selectButton;
@property (nonatomic,assign) BOOL _isSelected;
@end
@implementation OrderListFilterViewOrdersStateView

@synthesize _selectButton,_isSelected;
-(void)dealloc
{
    self._selectButton = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self._selectButton = [UIButton buttonWithTag:-1 image:[UIImage imageNamed:@"FilterSingleSelected.png"] title:@"不限" imageEdge:UIEdgeInsetsMake(5, 0, 5, 80-20) frame:CGRectMake((frame.size.width - 80) / 2, 10, 80, 30) font:FontSize22 color:FontColor2585CF target:nil action:nil];
        self._isSelected = FALSE;
        [self addSubview:self._selectButton];
    }
    return self;
}
@end

@implementation OrderListFilterView

@synthesize _orderStates ,_selectOrderStates,_view1,_view2, _buttonView, _selectRangeMonth;
@synthesize delegate;
-(void)dealloc
{
    self._selectRangeMonth = nil;
    self._buttonView = nil;
    self._orderStates = nil;
    self._selectOrderStates = nil;
    self._view1 = nil;
    self._view2 = nil;
    self.delegate = nil;
    [super dealloc];
}

-(void)selectOrderStates:(UIButton *)sender
{
    if ([self._orderStates count] >1) {
        for (OrderListFilterViewOrdersStateView *view in [self._view2 subviews]) {
            if ([view isKindOfClass:[OrderListFilterViewOrdersStateView class]]) {
                if (view._selectButton == sender) {
                    view._isSelected = TRUE;
                    [view._selectButton setTitleColor:FontColor2585CF forState:UIControlStateNormal];
                    [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
                }
                else {
                    view._isSelected = FALSE;
                    [view._selectButton setTitleColor:FontColor696969 forState:UIControlStateNormal];
                    [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
                }
            }
        }
    }
}
-(void)set_orderStates:(NSMutableArray *)orderStates
{
    for (UIView * sub in [self._view2 subviews]) {
        if (sub.tag != -1) {
            [sub removeFromSuperview];
        }
    }
    
    if (_orderStates != orderStates) {
        [_orderStates release];
        _orderStates = [orderStates retain];
        if ([orderStates count]>1) {
            OrderListFilterViewOrdersStateView * view = [[OrderListFilterViewOrdersStateView alloc] initWithFrame:CGRectMake(10, 0, (ViewWidth - 20)/3, 50)];
            view.tag = 0;
            view._isSelected = YES;
            [view._selectButton addTarget:self action:@selector(selectOrderStates:) forControlEvents:UIControlEventTouchUpInside];
            [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
            view._selectButton.tag = 0;
            [view._selectButton setTitle:@"不限" forState:UIControlStateNormal] ;
            [view._selectButton setTitleColor:FontColor2585CF forState:UIControlStateNormal];
            [self._view2 addSubview:view];
            [view release];
            
            for ( int i=0; i< [orderStates count];i++) {
                
                float xCoordinate = 10 + (i + 1)*(ViewWidth - 20)/3;
                float yCoordinate = 0;
                if (xCoordinate + (ViewWidth - 20)/3 > ViewWidth) {
                    CGRect rect = self._view2.frame;
                    rect.size.height = (i+4)/3*50;
                    self._view2.frame= rect;
                    
                    xCoordinate -= (i+1)/3*(ViewWidth - 20);
                    yCoordinate = (i+1)/3*50;
                }
                else {
                    CGRect rect = self._view2.frame;
                    rect.size.height = 50;
                    self._view2.frame= rect;
                }

                OrderListFilterViewOrdersStateView * view = [[OrderListFilterViewOrdersStateView alloc] initWithFrame:CGRectMake(xCoordinate, yCoordinate, (ViewWidth - 20)/3, 50)];
                view.tag = i+1;
                view._isSelected = YES;
                [view._selectButton addTarget:self action:@selector(selectOrderStates:) forControlEvents:UIControlEventTouchUpInside];
                [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
                view._selectButton.tag = [[orderStates objectAtIndex:i] intValue];
                NSString * _stateStr = nil;
                switch (view._selectButton.tag) {
                    case 0:
                        _stateStr = @"待支付";
                        break;
                    case 1:
                        _stateStr = @"支付中";
                        break;
                    case 2:
                        _stateStr = @"已出票";
                        break;
                    case 3:
                        _stateStr = @"有退票";
                        break;
                    case 4:
                        _stateStr = @"已使用";
                        break;
                    case 5:
                        _stateStr = @"已退票";
                        break;
                    case 6:
                        _stateStr = @"已取消";
                        break;
                    default:
                        break;
                }
                
                [view._selectButton setTitle:_stateStr forState:UIControlStateNormal];
                [view._selectButton setTitleColor:FontColor696969 forState:UIControlStateNormal];
                [self._view2 addSubview:view];
                [view release];
                
            }
        }
        else if([orderStates count] == 1) {
            OrderListFilterViewOrdersStateView * view = [[OrderListFilterViewOrdersStateView alloc] initWithFrame:CGRectMake(12, 0, (ViewWidth - 20)/3, 50)];
            view.tag = 0;
            view._isSelected = YES;
            [view._selectButton addTarget:self action:@selector(selectOrderStates:) forControlEvents:UIControlEventTouchUpInside];
            [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
            view._selectButton.tag = [[orderStates objectAtIndex:0] intValue];
            NSString * _stateStr = nil;
            switch (view._selectButton.tag) {
                case 0:
                    _stateStr = @"待支付";
                    break;
                case 1:
                    _stateStr = @"支付中";
                    break;
                case 2:
                    _stateStr = @"已出票";
                    break;
                case 3:
                    _stateStr = @"有退票";
                    break;
                case 4:
                    _stateStr = @"已使用";
                    break;
                case 5:
                    _stateStr = @"已退票";
                    break;
                case 6:
                    _stateStr = @"已取消";
                    break;
                default:
                    break;
            }

            [view._selectButton setTitle:_stateStr forState:UIControlStateNormal];
            [view._selectButton setTitleColor:FontColor2585CF forState:UIControlStateNormal];
            [self._view2 addSubview:view];
            [view release];
        }
    }

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:self.bounds image:[UIImage imageNamed:@"background.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"订单时段" frame: CGRectMake(0, 2, ViewWidth, 25) font:FontSize20 color:FontColor696969 alignment:NSTextAlignmentCenter]];
        [self addSubview:[UISubLabel labelWithTitle:@"订单状态" frame: CGRectMake(0, 100, ViewWidth, 25) font:FontSize20 color:FontColor696969 alignment:NSTextAlignmentCenter]];

        UIView * view1 =  [[UIView alloc] initWithFrame:CGRectMake(0, 24, ViewWidth, 77)];
        UIView * view2 =  [[UIView alloc] initWithFrame:CGRectMake(0, 121, ViewWidth, 50)];

        self._view1 =view1;
        self._view2 = view2;

        [view1 release];
        [view2 release];
        
        UIImageView * imageV1 = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 77) image:[UIImage imageNamed:@"FilterBackground1.png"]];
        imageV1.tag = 1;
        
        UIImageView *imgLineView = [UIImageView ImageViewWithFrame:CGRectMake((ViewWidth - 268)/2, 25, 258, 16) image:[UIImage imageNamed:@"筛选横条.png"]];

        UIImageView * imageV2 = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 50) image:[UIImage imageNamed:@"FilterBackground3.png"]];
        imageV2.tag = -1;
        imageV2.autoresizesSubviews = YES;
        imageV2.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        
        [self._view1 addSubview:imageV1];
        [self._view1 addSubview:imgLineView];
        [self._view2 addSubview:imageV2];
        
        [self._view1 addSubview:[UISubLabel labelWithTitle:@"不限" frame:CGRectMake((ViewWidth - 268)/2 - 21, 50, 60, 15) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        [self._view1 addSubview:[UISubLabel labelWithTitle:@"3个月内" frame:CGRectMake((ViewWidth - 268)/2 - 21 + 60, 50, 60, 15) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        [self._view1 addSubview:[UISubLabel labelWithTitle:@"4-6个月" frame:CGRectMake((ViewWidth - 268)/2 - 21 + 60*2, 50, 60, 15) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        [self._view1 addSubview:[UISubLabel labelWithTitle:@"6-12个月" frame:CGRectMake((ViewWidth - 268)/2 - 21 + 60*3, 50, 60, 15) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        [self._view1 addSubview:[UISubLabel labelWithTitle:@"1年以后" frame:CGRectMake((ViewWidth - 268)/2 - 21 + 60*4, 50, 60, 15) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        
        self._buttonView = [UIImageView ImageViewWithFrame:CGRectMake((ViewWidth - 268)/2 - 3, 20, 25, 25) image:[UIImage imageNamed:@"handle-hover.png"]];
        [self._view1 addSubview:self._buttonView];
        
        for (int i = 0; i < 5; i ++) {
            [self._view1 addSubview:[UIButton buttonWithTag:i frame:CGRectMake((ViewWidth - 268)/2 - 21 + 60*i, 25, 60, 30) target:self action:@selector(moveImage:)]];
        }
        
        [self addSubview:self._view1];
        [self addSubview:self._view2];

        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth-112)/2, frame.size.height - 60, 112, 35) backImage:[UIImage imageNamed:@"FilterDown.png"] target:self   action:@selector(filterDown)]];
    }
    return self;
}

- (void)setTicketOrderTime
{
    self._buttonView.frame = CGRectMake((ViewWidth - 268)/2 - 3, 20, 25, 25);
    self._selectRangeMonth = [NSArray array];
}

- (void)setTicketOrderTime:(int)index
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.6];
    self._buttonView.frame = CGRectMake((ViewWidth - 268)/2 - 3 + index*60, 20, 25, 25);
    [UIView commitAnimations];
    
    switch (index) {
        case 0:
            self._selectRangeMonth = [NSArray array];
            break;
        case 1:
            self._selectRangeMonth = [NSArray arrayWithObjects:@"0", @"3", nil];
            break;
        case 2:
            self._selectRangeMonth = [NSArray arrayWithObjects:@"3", @"6", nil];
            break;
        case 3:
            self._selectRangeMonth = [NSArray arrayWithObjects:@"6", @"12", nil];
            break;
        case 4:
            self._selectRangeMonth = [NSArray arrayWithObjects:@"12", nil];
            break;
        default:
            break;
    }
}

- (void)moveImage:(UIButton *)sender
{
    NSLog(@"tag%d", sender.tag);
    [self setTicketOrderTime:sender.tag];
}

-(void)filterDown
{
    self._selectOrderStates = [NSMutableArray array];

    if ([self._orderStates count]>1) {
        BOOL isSelectedAll = FALSE;
        for (OrderListFilterViewOrdersStateView * elem in [self._view2 subviews]) {
            if ([elem isKindOfClass:[OrderListFilterViewOrdersStateView class]]) {
                if (elem .tag == 0 ) {
                    if (elem._isSelected) {
                        isSelectedAll = TRUE;
                        self._selectOrderStates = self._orderStates;
                        break;
                    }
                }
            }
        }
        if (!isSelectedAll) {
            for (OrderListFilterViewOrdersStateView * elem in [self._view2 subviews]) {
                if ([elem isKindOfClass:[OrderListFilterViewOrdersStateView class]]) {
                    if (elem .tag != 0 ) {
                        if (elem._isSelected) 
                            [self._selectOrderStates addObject:[NSString stringWithFormat:@"%d",elem._selectButton.tag]];
                    }
                }
            }
        }
    }
    else if([self._orderStates count]==1){
        self._selectOrderStates = self._orderStates;
    }
    NSLog(@"%@",self._selectOrderStates);
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterDown)]) {
        [self.delegate performSelector:@selector(filterDown)];
//        [self removeFromSuperviewWithAnimated:YES];
    }
}

@end


@interface MemberOrderViewController ()

@end

@implementation MemberOrderViewController
@synthesize data,filterView;
@synthesize filterDataArray;
@synthesize _dataIsFull,pageIndex,isfromRecomend,totalPage;

-(void)dealloc
{
    orderInfoData = nil;
    ticketQueryData = nil;
    self.data  = nil;
    self.filterView = nil;
    self.filterDataArray = nil;
    self.totalPage = nil;
    [super dealloc];
}

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
			[myTable addSubview:_refreshHeaderView];
			[_refreshHeaderView refreshLastUpdatedDate];
		}
	}
}
- (void)loadFitstDataSource
{
	[myTable reloadData];
	
	_refreshHeaderView.frame=CGRectMake(0.0f, myTable.contentSize.height, myTable.frame.size.width, 80);
	[self doneLoadingTableViewData];
	
}

-(void)setHeaderView
{
    if(pageIndex == [self.totalPage intValue] && [self.totalPage intValue] != 1)
    {
        self.isfromRecomend = YES;
        [self isrefreshHeaderView];
        myTable.contentSize = CGSizeMake(ViewWidth, myTable.contentSize.height-65.0f);
        return;
    }
    _refreshHeaderView.frame=CGRectMake(0.0f, myTable.contentSize.height, myTable.frame.size.width, 80);
    [self doneLoadingTableViewData];
}

- (void)viewDidLoad
{
    self.title = @"机票订单";
    cellSelect = 0;
    selectButton = 0;
    priceDese = NO;
    sortDese = NO;
    pageIndex = 1;
    loadMore = NO;
    
    UIView * headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, ViewWidth, 35);
    
    timeButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListTimeNone.png"] target:self action:@selector(timeButton:)];
    filterButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth/3, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListFilterNone.png"] target:self action:@selector(filterButton:)];
    priceButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth*2/3, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListPriceNone.png"] target:self action:@selector(priceButton:)];
    [self timeButton:timeButton];
    
//    UIImageView *titleView = [UIImageView ImageViewWithFrame:CGRectMake(0, headView.frame.size.height - 2, 320, 28) image:[UIImage imageNamed:@"顶部表格.png"]];
//    
//    [titleView addSubview:[UISubLabel labelWithTitle:@"航班信息" frame:CGRectMake(0, 0, 107, 27) font:FontSize20 color:FontColor909090 alignment:NSTextAlignmentCenter]];
//    [titleView addSubview:[UISubLabel labelWithTitle:@"行程" frame:CGRectMake(90, 0, 70, 27) font:FontSize20 color:FontColor909090 alignment:NSTextAlignmentCenter]];
//    [titleView addSubview:[UISubLabel labelWithTitle:@"飞行日期" frame:CGRectMake(160, 0, 60, 27) font:FontSize20 color:FontColor909090 alignment:NSTextAlignmentCenter]];
//    [titleView addSubview:[UISubLabel labelWithTitle:@"总价/状态" frame:CGRectMake(230, 0, 80, 27) font:FontSize20 color:FontColor909090 alignment:NSTextAlignmentCenter]];

    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height, ViewWidth, ViewHeight - 44 - 38) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.dataSource = self;
    myTable.delegate = self;
    
    [headView addSubview : timeButton];
    [headView addSubview : filterButton];
    [headView addSubview : priceButton];
    
//    [self.view addSubview:titleView];
    
    [self.view addSubview:myTable];
    [myTable release];
    
    [self.view addSubview:headView];
    [headView release];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self isrefreshHeaderView];
	[self loadFitstDataSource];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self._dataIsFull) {
        pageIndex = 1;
        [self getFlightsOrdersList];
    }
    else {
        int temp = 0;
        for (int i =0 ; i < [self.data count]; i ++) {
            MemberOrderInfo *orderListData = [self.data objectAtIndex:i];
            if ([orderListData._state intValue] == 0) {
                temp ++;
            }
        }
        self._pointView._pointLab.tag = temp;
        
        if (self._pointView._pointLab.tag == 0) {
            self._pointView.hidden = YES;
        }
        else {
            if (self._pointView._pointLab.tag > 9) {
                self._pointView._pointLab.text = @"N";
            }
            else{
                self._pointView._pointLab.text = [NSString stringWithFormat:@"%d",self._pointView._pointLab.tag];
            }
            self._pointView.hidden = NO;
        }
        NSLog(@"待支付订单数目：%@", self._pointView._pointLab.text);
    }
    self._dataIsFull = FALSE;
    [myTable reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - Table view dataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.filterDataArray count] > 0) {
        return [filterDataArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = [NSString stringWithFormat:@"identifier%d", indexPath.row];
    MemberOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[MemberOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
        
        
    }
    if ([self.filterDataArray count] > 0) {
        MemberOrderInfo *cellDic = [self.filterDataArray objectAtIndex:indexPath.row];
        
        if ([cellDic._flightType intValue] == 1) {
            cell._planeType.text = @"单程";
            cell._startAirport.text = [cellDic._departure objectAtIndex:0];
            cell._endAirport.text = [cellDic._arrical objectAtIndex:0];
        }
        else if ([cellDic._flightType intValue] == 2) {
            cell._planeType.text = @"往返";
            cell._startAirport.text = [cellDic._departure objectAtIndex:0];
            cell._endAirport.text = [cellDic._arrical objectAtIndex:0];
        }
        else if ([cellDic._flightType intValue] == 3) {
            cell._planeType.text = @"联程";
            cell._startAirport.text = [cellDic._departure objectAtIndex:0];
            cell._endAirport.text = [cellDic._arrical objectAtIndex:[cellDic._arrical count] - 1];
        }

        switch ([cellDic._state intValue]) {
            case 0:
                cell._stateImageV.image = [UIImage imageNamed:@"待支付.png"];
                break;
            case 1:
                cell._stateImageV.image = [UIImage imageNamed:@"支付中.png"];
                break;
            case 2:
                cell._stateImageV.image = [UIImage imageNamed:@"已出票.png"];
                break;
            case 3:
                cell._stateImageV.image = [UIImage imageNamed:@"有退票.png"];
                break;
            case 4:
                cell._stateImageV.image = [UIImage imageNamed:@"已使用.png"];
                break;
            case 5:
                cell._stateImageV.image = [UIImage imageNamed:@"已退票.png"];
                break;
            case 6:
                cell._stateImageV.image = [UIImage imageNamed:@"已取消.png"];
                break;
            default:
                break;
        }
        
        if ([cellDic._flightType intValue] == 1) {
            cell._flightNo1.text = [cellDic._flightNo objectAtIndex:0];
            cell._flightNo1.frame = CGRectMake(40, 20, 70, 20);
            cell._flightNo2.hidden = YES;
            cell._startTime1.text = [cellDic._departureDate objectAtIndex:0];
            cell._startTime1.frame = CGRectMake(150, 20, 70, 20);
            cell._startTime2.hidden = YES;
            cell._startDate.text = [NSString stringWithFormat:@"%@ 提交", cellDic._date];
            cell._ticketPrice.text = cellDic._totalPrice;
            cell._company1ImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [[cellDic._flightNo    objectAtIndex:0] substringToIndex:2]]];
            cell._company1ImageV.frame = CGRectMake(20, 23, 15, 15);
            cell._company2ImageV.hidden = YES;
        }
        else {
            cell._flightNo1.text = [cellDic._flightNo objectAtIndex:0];
            cell._flightNo2.text = [cellDic._flightNo objectAtIndex:1];
            cell._startTime1.text = [cellDic._departureDate objectAtIndex:0];
            cell._startTime2.text = [cellDic._departureDate objectAtIndex:1];
            cell._startDate.text = [NSString stringWithFormat:@"%@ 提交", cellDic._date];
            cell._ticketPrice.text = cellDic._totalPrice;
            cell._company1ImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [[cellDic._flightNo    objectAtIndex:0] substringToIndex:2]]];
            cell._company2ImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [[cellDic._flightNo    objectAtIndex:1] substringToIndex:2]]];
            
            cell._flightNo1.frame = CGRectMake(40, 10, 70, 20);
            cell._flightNo2.frame = CGRectMake(40, 30, 70, 20);
            cell._startTime1.frame = CGRectMake(150, 10, 70, 20);
            cell._startTime2.frame = CGRectMake(150, 30, 70, 20);
            cell._company1ImageV.frame = CGRectMake(20, 13, 15, 15);
            cell._company2ImageV.frame = CGRectMake(20, 33, 15, 15);
            
            cell._company2ImageV.hidden = NO;
            cell._startTime2.hidden = NO;
            cell._flightNo2.hidden = NO;
        }
    }
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 0, 300, 74)];
    cellSelect = indexPath.row;
    MemberOrderInfo *cellData = [self.filterDataArray objectAtIndex:indexPath.row];
    
    ASIFormDataRequest * theRequest = [InterfaceClass flightsOrderDetails:cellData._orderId]; //测试的UserID69743 69752
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onflightsOrderDetailsResult:) Delegate:self needUserType:Member];
}


#pragma mark - buttonClick
-(void)timeSort
{
    if (sortDese) {
        self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortArrayByScheduleDate context:NULL];
        self.data = (NSMutableArray *)[self.data sortedArrayUsingFunction:sortArrayByScheduleDate context:NULL];
    }
    else {
        self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortArrayBySecondScheduleDate context:NULL];
        self.data = (NSMutableArray *)[self.data sortedArrayUsingFunction:sortArrayBySecondScheduleDate context:NULL];
    }
}

-(void)timeButton:(UIButton *)sender
{
    NSLog(@"timeButton");
    [self.filterView removeFromSuperview];
    sortDese = !sortDese;
    selectButton = 1;
    [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
    [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceNone.png"] forState:UIControlStateNormal];

    if (sortDese) {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListTimeDown.png"] forState:UIControlStateNormal];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListTimeUp.png"] forState:UIControlStateNormal];
    }
    [self timeSort];
    [myTable reloadData];
}

-(void)filterButton:(UIButton *)sender
{
    [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeNone.png"] forState:UIControlStateNormal];
    [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceNone.png"] forState:UIControlStateNormal];
    
    NSLog(@"filterButton");
    if (self.filterView == nil) {
        OrderListFilterView * filterView1 = [[OrderListFilterView alloc] initWithFrame:CGRectMake(0,35,ViewWidth,ViewHeight-(IOS7_OR_LATER?15:35))];
        self.filterView = filterView1;
        self.filterView.delegate = self;
        [filterView1 release];
    }
    
    NSMutableArray * timeRange = [NSMutableArray arrayWithObjects:@"6",@"24",nil];
    NSMutableArray * ordersStates = [NSMutableArray array];
    for (MemberOrderInfo * elem in self.data) {
        
        if (![ordersStates containsObject:elem._state]) {
            [ordersStates addObject:elem._state];
        }
    }
    [ordersStates sortUsingSelector:@selector(compare:)];
    NSLog(@"%@,%@",timeRange,ordersStates);
    [self.filterView setTicketOrderTime];
    self.filterView._orderStates = ordersStates;

    self.filterView.frame = CGRectMake(0,35,ViewWidth,ViewHeight-(IOS7_OR_LATER?15:35));
    if (self.filterView.superview == nil) {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListFilter.png"] forState:UIControlStateNormal];
        [self.view insertSubview:self.filterView atIndex: [[self.view subviews] count] -1 animated:YES ];
    }
    else
    {
        [self setTicketButtonTypeImage];
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
        [self.filterView removeFromSuperviewWithAnimated:YES];
    }
    
}
-(void)filterDown
{
    [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
    NSString *startDate = @"";
    NSString *endDate = @"";
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    if ([self.filterView._selectRangeMonth count] == 1) {
        startDate = [self setComparDate:[self.filterView._selectRangeMonth objectAtIndex:0]];
    }
    else if ([self.filterView._selectRangeMonth count] == 2)
    {
        startDate = [self setComparDate:[self.filterView._selectRangeMonth objectAtIndex:1]];
        endDate = [self setComparDate:[self.filterView._selectRangeMonth objectAtIndex:0]];
    }
    
    
    if([self.filterView._selectOrderStates count] != 0)
        //进入列表页面初次去点击“完成筛选”按钮时，数组元素不为0，在此将loadMore置为YES；当初次进入页面不去筛选，直接加载更多时也会调该方法，数组元素为0
    {
        loadMore = YES;
    }
    
    for (MemberOrderInfo * info in self.data) {

        if ([self.filterView._selectRangeMonth count] == 0) {
            if ([self.filterView._selectOrderStates containsObject:info._state]) {
                [tmpArray addObject:info];
            }
        }
        else if ([self.filterView._selectRangeMonth count] == 1){
            
            if ([info._date compare:startDate]<0) {
                if ([self.filterView._selectOrderStates containsObject:info._state]) {
                    [tmpArray addObject:info];
                }
            }
        }
        else if ([self.filterView._selectRangeMonth count] == 2){
            if ([info._date compare:startDate]>0 && [info._date compare:endDate]<=0) {
                if ([self.filterView._selectOrderStates containsObject:info._state]) {
                    [tmpArray addObject:info];
                }
            }
        }
    }
    
    [self setTicketButtonTypeImage];
    
    if ([tmpArray count] == 0) {
        [self.filterView removeFromSuperviewWithAnimated:YES];
        if(loadMore) {
            [self.filterView setTicketOrderTime];
            [UIAlertView alertViewWithMessage:@"暂无符合筛选条件的机票订单！" :@"提示"];
        }
    }
    else {
        self.filterDataArray = tmpArray;
        [self.filterView removeFromSuperviewWithAnimated:YES];
        [myTable reloadData];
    }
    [self setHeaderView];
}

static NSInteger  sortArrayByScheduleDate(id item1, id item2, void *context){//从晚到早
    MemberOrderInfo *info1 = item1;
	MemberOrderInfo *info2 = item2;
	if ([info1._date compare:info2._date] < 0)
        return NSOrderedDescending;
    else if ([info1._date compare:info2._date] > 0)
        return NSOrderedAscending;
    else
        return  NSOrderedSame;
}

static NSInteger sortArrayBySecondScheduleDate(id item1, id item2, void *context){//从早到晚
    MemberOrderInfo *info1 = item1;
	MemberOrderInfo *info2 = item2;
    
	if ([info1._date compare:info2._date] < 0)
        return NSOrderedAscending;
    else if ([info1._date compare:info2._date] > 0)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

static NSInteger sortArrayByTotelMoney(id item1, id item2, void *context){//从高到低
    MemberOrderInfo *info1 = item1;
	MemberOrderInfo *info2 = item2;
    
    int v1 = [info1._totalPrice intValue];
    int v2 = [info2._totalPrice intValue];
	if (v1 < v2)
        return NSOrderedAscending;//升序
    else if (v1 >v2)
        return NSOrderedDescending;//降序
    else
        return NSOrderedSame;
}

static NSInteger sortArrayByTotelMoneySecond(id item1, id item2, void *context){//从高到低
    MemberOrderInfo *info1 = item1;
	MemberOrderInfo *info2 = item2;
    
    int v1 = [info1._totalPrice intValue];
    int v2 = [info2._totalPrice intValue];
	if (v1 < v2)
        return NSOrderedDescending;//降序
    else if (v1 >v2)
        return NSOrderedAscending;//升序
    else
        return NSOrderedSame;
}

-(void)priceSort
{
    if (priceDese) {
        self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortArrayByTotelMoney context:NULL];
        self.data = (NSMutableArray *)[self.data sortedArrayUsingFunction:sortArrayByTotelMoney context:NULL];
    }
    else {
        self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortArrayByTotelMoneySecond context:NULL];
        self.data =  (NSMutableArray *)[self.data sortedArrayUsingFunction:sortArrayByTotelMoneySecond context:NULL];
    }
}
-(void)priceButton:(UIButton *)sender
{
    NSLog(@"priceButton");
    [self.filterView removeFromSuperview];
    [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeNone.png"] forState:UIControlStateNormal];
    [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
    
    priceDese = !priceDese;
    selectButton = 2;
    if (priceDese) {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListPriceUp.png"] forState:UIControlStateNormal];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListPriceDown.png"] forState:UIControlStateNormal];
    }
    [self priceSort];

    [myTable reloadData];
}

- (NSString *)setComparDate:(NSString *)addMonth
{
    NSString *newDate = @"";
    NSString *resultMonth = @"";
    NSString *resultYear = @"";
    NSString *resultDay = @"";
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    now=[NSDate date];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:now];
    NSInteger year=[comps year];
    NSInteger month=[comps month];
    NSInteger day=[comps day];
    
    if (month - [addMonth intValue] < 0) {
        resultMonth = [NSString stringWithFormat:@"%ld", 12 + month - [addMonth intValue]];
        resultYear = [NSString stringWithFormat:@"%ld", year - 1];
        resultDay = [NSString stringWithFormat:@"%ld", day];
    }
    else{
        resultMonth = [NSString stringWithFormat:@"%ld", month - [addMonth intValue]];
        resultYear = [NSString stringWithFormat:@"%ld", year];
        resultDay = [NSString stringWithFormat:@"%ld", day];
    }
    
    if (resultYear.length == 1) {
        resultYear = [NSString stringWithFormat:@"0%@", resultYear];
    }
    if (resultMonth.length == 1) {
        resultMonth = [NSString stringWithFormat:@"0%@", resultMonth];
    }
    if (resultDay.length == 1) {
        resultDay = [NSString stringWithFormat:@"0%@", resultDay];
    }
    
    
    newDate = [NSString stringWithFormat:@"%@-%@-%@", resultYear, resultMonth, resultDay];
    NSLog(@"%@", newDate);
    [calendar release];
    return newDate;
}

- (void)getFlightsOrdersList
{
    ASIFormDataRequest * theRequest = [InterfaceClass flightsOrdersList:[UserInfo sharedUserInfo].userID withPageIndex:[NSString stringWithFormat:@"%d",pageIndex]];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onFlightsOrdersListResult:) Delegate:self needUserType:Member];
}
-(void)onFlightsOrdersListResult:(NSDictionary*)dic
{
    self.totalPage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalPage"]];
    if (pageIndex==1)
    {
        
        self.data = (NSMutableArray *)[MemberOrderInfo MemberOrderList:dic];
        self.filterDataArray = self.data;
    }
	else
    {
        NSMutableArray *arraytemp = [NSMutableArray arrayWithArray:self.data];
        NSMutableArray *array = (NSMutableArray *)[MemberOrderInfo MemberOrderList:dic];
    	[arraytemp addObjectsFromArray:array];
        self.data = arraytemp;
        self.filterDataArray = self.data;
        [self filterDown];
    }
	
    int temp = 0;
    for (int i =0 ; i < [self.data count]; i ++) {
        MemberOrderInfo *orderListData = [self.data objectAtIndex:i];
        if ([orderListData._state intValue] == 0) {
            temp ++;
        }
    }
    self._pointView._pointLab.tag = temp;
    
    if(selectButton == 1)
    {
        [self timeSort];
    }
    if(selectButton == 2)
    {
        [self priceSort];
    }
    [myTable reloadData];
    [self setHeaderView];

}

- (void)onflightsOrderDetailsResult:(NSDictionary *)dic
{
    int myOrderState = 0;
    
    MemberOrderDetailResponse *orderDetailInfo = [MemberOrderDetailResponse setOrderDetail:dic];
    MemberOrderInfo *cellData = [self.filterDataArray objectAtIndex:cellSelect];
    orderDetailInfo._orderId = cellData._orderId;
    
    if ([orderDetailInfo._state intValue] == -1) {
        myOrderState = [cellData._state intValue];
    }
    else {
        myOrderState = [orderDetailInfo._state intValue];
    }
    
    if (myOrderState == 0) {
        MemberOrderPayViewController *orderPayTicketVC = [[MemberOrderPayViewController alloc] init];
        orderPayTicketVC.title = @"待支付订单";
        orderPayTicketVC.orderDataInfo = orderDetailInfo;
        [NavigationController pushViewController:orderPayTicketVC animated:YES];
        [orderPayTicketVC release];
    }
    else {
        MemberOrderStateViewController *orderStateVC = [[MemberOrderStateViewController alloc] init];
        orderStateVC.orderState = [NSString stringWithFormat:@"%d", myOrderState];
        orderStateVC.orderDataInfo = orderDetailInfo;
        [NavigationController pushViewController:orderStateVC animated:YES];
        [orderStateVC release];
    }
}


- (void)setTicketButtonTypeImage
{
    if (selectButton == 1) {
        if (sortDese) {
            [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeDown.png"] forState:UIControlStateNormal];
        }
        else {
            [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeUp.png"] forState:UIControlStateNormal];
        }
    }
    else if (selectButton == 2)
    {
        if (priceDese) {
            [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceUp.png"] forState:UIControlStateNormal];
        }
        else {
            [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceDown.png"] forState:UIControlStateNormal];
        }
    }
}

-(void)loadSourceData
{
    ASIFormDataRequest * theRequest = [InterfaceClass flightsOrdersList:[UserInfo sharedUserInfo].userID withPageIndex:[NSString stringWithFormat:@"%d",pageIndex]];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onFlightsOrdersListResult:) Delegate:self needUserType:Member];
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
    if(pageIndex == [self.totalPage intValue])
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
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:myTable];
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
