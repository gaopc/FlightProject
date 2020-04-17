//
//  WoyinOrderListViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 15-6-5.
//
//
#import "DoubleSlider.h"
#import "WoyinOrderListViewController.h"
@interface TrainOrderListFilterViewOrdersStateView : UIView
@property (nonatomic,retain) UIButton * _selectButton;
@property (nonatomic,assign) BOOL _isSelected;
@end
@implementation TrainOrderListFilterViewOrdersStateView

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
@interface TrainOrderListFilterView : UIView
{
    DoubleSlider * flightTimeSlider;
}

@property (nonatomic,retain) NSMutableArray * _orderStates;
@property (nonatomic,retain) NSMutableArray * _selectOrderStates;
@property (nonatomic,retain) NSArray * _selectRangeMonth;
@property (nonatomic,retain) UIView * _view1;
@property (nonatomic,retain) UIView * _view2;
@property (nonatomic,retain) UIImageView * _buttonView;

@property (nonatomic,assign) id delegate;

- (void)setTicketOrderTime:(NSInteger)index;
@end

@implementation TrainOrderListFilterView

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
        for (TrainOrderListFilterViewOrdersStateView *view in [self._view2 subviews]) {
            if ([view isKindOfClass:[TrainOrderListFilterViewOrdersStateView class]]) {
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
            TrainOrderListFilterViewOrdersStateView * view = [[TrainOrderListFilterViewOrdersStateView alloc] initWithFrame:CGRectMake(10, 0, (ViewWidth - 20)/3, 50)];
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
                
                TrainOrderListFilterViewOrdersStateView * view = [[TrainOrderListFilterViewOrdersStateView alloc] initWithFrame:CGRectMake(xCoordinate, yCoordinate, (ViewWidth - 20)/3, 50)];
                view.tag = i+1;
                view._isSelected = YES;
                [view._selectButton addTarget:self action:@selector(selectOrderStates:) forControlEvents:UIControlEventTouchUpInside];
                [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
                view._selectButton.tag = [[orderStates objectAtIndex:i] intValue];
                NSString * _stateStr = nil;
                switch (view._selectButton.tag) {
                    case 1:
                        _stateStr = @"待支付";
                        break;
                    case 2:
                        _stateStr = @"出票中";
                        break;
                    case 3:
                        _stateStr = @"已出票";
                        break;
                    case 4:
                        _stateStr = @"出票失败";
                        break;
                    case 5:
                        _stateStr = @"已取消";
                        break;
                    case 7:
                        _stateStr = @"有退票";
                        break;
                    case 8:
                        _stateStr = @"已退票";
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
            TrainOrderListFilterViewOrdersStateView * view = [[TrainOrderListFilterViewOrdersStateView alloc] initWithFrame:CGRectMake(12, 0, (ViewWidth - 20)/3, 50)];
            view.tag = 0;
            view._isSelected = YES;
            [view._selectButton addTarget:self action:@selector(selectOrderStates:) forControlEvents:UIControlEventTouchUpInside];
            [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
            view._selectButton.tag = [[orderStates objectAtIndex:0] intValue];
            NSString * _stateStr = nil;
            switch (view._selectButton.tag) {
                case 1:
                    _stateStr = @"待支付";
                    break;
                case 2:
                    _stateStr = @"出票中";
                    break;
                case 3:
                    _stateStr = @"已出票";
                    break;
                case 4:
                    _stateStr = @"出票失败";
                    break;
                case 5:
                    _stateStr = @"已取消";
                    break;
                case 7:
                    _stateStr = @"有退票";
                    break;
                case 8:
                    _stateStr = @"已退票";
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

- (void)setTicketOrderTime:(NSInteger)index
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
    [self setTicketOrderTime:sender.tag];
}

-(void)filterDown
{
    self._selectOrderStates = [NSMutableArray array];
    
    if ([self._orderStates count]>1) {
        BOOL isSelectedAll = FALSE;
        for (TrainOrderListFilterViewOrdersStateView * elem in [self._view2 subviews]) {
            if ([elem isKindOfClass:[TrainOrderListFilterViewOrdersStateView class]]) {
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
            for (TrainOrderListFilterViewOrdersStateView * elem in [self._view2 subviews]) {
                if ([elem isKindOfClass:[TrainOrderListFilterViewOrdersStateView class]]) {
                    if (elem .tag != 0 ) {
                        if (elem._isSelected)
                            [self._selectOrderStates addObject:[NSString stringWithFormat:@"%d",(int)elem._selectButton.tag]];
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

@interface TrainOrderListCell : UITableViewCell
@property (nonatomic,retain) UIImageView * _stateImageV; //状态图片
@property (nonatomic,retain) UISubLabel * _submitDate;      //提交时间
@property (nonatomic,retain) UISubLabel * _fromCity;   //出发城市
@property (nonatomic,retain) UISubLabel * _toCity;     //目的城市
@property (nonatomic,retain) UISubLabel * _trainNumber;      //车次
@property (nonatomic,retain) UISubLabel * _goTime;     //出发时间
@property (nonatomic,retain) UISubLabel * _ticketPrice;     //票价
@end


@implementation TrainOrderListCell
@synthesize _fromCity,_goTime,_stateImageV,_submitDate,_ticketPrice,_toCity,_trainNumber;

- (void)dealloc
{
    self._fromCity = nil;
    self._goTime = nil;
    self._stateImageV = nil;
    self._submitDate = nil;
    self._ticketPrice = nil;
    self._toCity = nil;
    self._trainNumber = nil;

    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 100, 75) image:[UIImage imageNamed:@"TicketListLeft.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 90, 0, 80, 75) image:[UIImage imageNamed:@"TicketListRight.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 52, ViewWidth - 120, 1) image:[UIImage imageNamed:@"TicketListxuxian.png"]]];
        
        self._trainNumber = [UISubLabel labelWithTitle:@"D330" frame:CGRectMake(20, 8, 70, 40) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._fromCity = [UISubLabel labelWithTitle:@"乌鲁木齐" frame:CGRectMake((ViewWidth - 140)/2, 9, 70, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self._toCity = [UISubLabel labelWithTitle:@"鄂尔多斯" frame:CGRectMake((ViewWidth - 140)/2, 29, 70, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self._goTime = [UISubLabel labelWithTitle:@"2012-08-20" frame:CGRectMake(ViewWidth - 100 - 70, 10, 70, 40) font:FontSize20 color:FontColor333333 alignment:NSTextAlignmentRight];
        
        self._submitDate = [UISubLabel labelWithTitle:@"2012-08-18 提交" frame:CGRectMake(20, 54, 150, 20) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        self._stateImageV = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 80, 52, 52, 20) image:[UIImage imageNamed:@"待支付.png"]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 85, 29, 8, 8) image:[UIImage imageNamed:@"TicketListRMB.png"]]];
        self._ticketPrice =   [UISubLabel labelWithTitle:@"2379" frame:CGRectMake(ViewWidth - 75, 20, 100, 20) font:FontBlodSize42 color:FontColorFF8813 alignment:NSTextAlignmentLeft];

        [self addSubview:self._trainNumber];
        [self addSubview:self._fromCity];
        [self addSubview:self._toCity];
        [self addSubview:self._goTime];
        [self addSubview:self._submitDate];
        [self addSubview:self._stateImageV];
        [self addSubview:self._ticketPrice];
        
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end


@interface WoyinOrderListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTable;
    
    UIButton * timeButton;
    UIButton * filterButton;
    UIButton * priceButton;
    BOOL priceDese;
    BOOL sortDese;
    int selectButton;
    BOOL loadMore;//筛选订单后，如果有加载更多按钮，点击按钮时加载更多数据后对得到的所有数据进行筛选，此时为YES；没有筛选订单，直接加载更多，此时代码加载完数据后还会去执行筛选方法，此时为NO

}
@property (nonatomic,retain) TrainOrderListFilterView * filterView;
@property (nonatomic,retain) NSMutableArray * filterDataArray;
@property (nonatomic,retain) TrainOrderItem * _selectOrder;
@end

@implementation WoyinOrderListViewController
@synthesize filterView,filterDataArray;
@synthesize _dataArrayAll;
@synthesize _selectOrder;
- (void)dealloc
{
    self._dataArrayAll = nil;
    self.filterView = nil;
    self.filterDataArray = nil;
    self._selectOrder = nil;
    [super dealloc];
}

-(void)loadView
{
    [super loadView];
    selectButton = 0;
    priceDese = NO;
    sortDese = NO;
    loadMore = NO;

    UIView * headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, ViewWidth, 35);
    [self.view addSubview:headView];
    [headView release];
    timeButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListTimeNone.png"] target:self action:@selector(timeButton:)];
    filterButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth/3, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListFilterNone.png"] target:self action:@selector(filterButton:)];
    priceButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth*2/3, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListPriceNone.png"] target:self action:@selector(priceButton:)];
    [headView addSubview : timeButton];
    [headView addSubview : filterButton];
    [headView addSubview : priceButton];
    
    [self timeButton:timeButton];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height, ViewWidth, ViewHeight - 44 - 38) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"火车票订单";
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self TrainOrders];
}
-(void)TrainOrders
{
    NSLog(@"%s",__FUNCTION__);
    ASIFormDataRequest * theRequest = [InterfaceClass findOrderSimpleList];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onfindOrderSimpleListResult:) Delegate:self needUserType:Member];
}
-(void)onfindOrderSimpleListResult:(NSDictionary *)result
{
    NSArray * orderList = [result objectForKey:@"orderList"];
    NSMutableArray * _mArr = [NSMutableArray array];
    if ([orderList isKindOfClass:[NSArray class]]) {
        for (NSDictionary * train in orderList) {
            [_mArr addObject:[TrainOrderItem TrainOrderListItemInfoWithDic:train]];
        }
    }
    self._dataArrayAll = _mArr;
    self.filterDataArray = [NSMutableArray arrayWithArray:self._dataArrayAll];
    [myTable reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.filterDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"identifier";
    TrainOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[TrainOrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    TrainOrderItem * order = [self.filterDataArray objectAtIndex:indexPath.row];
    cell._trainNumber.text = order._trainCode;
    cell._fromCity.text = order._fromStation;
    cell._toCity.text = order._toStation;
    cell._goTime.text = order._startDate;
    cell._submitDate.text = order._orderDate;
    cell._ticketPrice.text = order._orderTotal;
    switch ([order._orderStatus intValue]) {
        case 1:
            cell._stateImageV.image = [UIImage imageNamed:@"待支付.png"];
            break;
        case 2:
            cell._stateImageV.image = [UIImage imageNamed:@"出票中.png"];
            break;
        case 3:
            cell._stateImageV.image = [UIImage imageNamed:@"已出票.png"];
            break;
        case 4:
            cell._stateImageV.image = [UIImage imageNamed:@"出票失败.png"];
            break;
        case 5:
            cell._stateImageV.image = [UIImage imageNamed:@"已取消.png"];
            break;
        case 7:
            cell._stateImageV.image = [UIImage imageNamed:@"有退票.png"];
            break;
        case 8:
            cell._stateImageV.image = [UIImage imageNamed:@"已退票.png"];
            break;

        default:
            break;
    }

    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 0, 300, 74)];
    self._selectOrder = [self.filterDataArray objectAtIndex:indexPath.row];

    ASIFormDataRequest * theRequest = [InterfaceClass findOrderDetailListWithID:self._selectOrder._orderId];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onfindOrderDetailListResult:) Delegate:self needUserType:Member];
}
-(void)onfindOrderDetailListResult:(NSDictionary *)result
{
    WoyinOrderDetailViewController *trainVC = [[WoyinOrderDetailViewController alloc] init];
    trainVC._orderItem = [TrainOrderItem TrainOrderDetailIInfoWithDic:result];
    trainVC._orderItem._startDate = self._selectOrder._startDate;
    
    NSLog(@"startDate:%@", self._selectOrder._startDate);

    [NavigationController pushViewController:trainVC animated:YES];
    [trainVC release];
}
#pragma mark - buttonClick
-(void)timeSort
{
    if (sortDese) {
        self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortArrayByScheduleDate context:NULL];
        self._dataArrayAll = (NSMutableArray *)[self._dataArrayAll sortedArrayUsingFunction:sortArrayByScheduleDate context:NULL];
    }
    else {
        self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortArrayBySecondScheduleDate context:NULL];
        self._dataArrayAll = (NSMutableArray *)[self._dataArrayAll sortedArrayUsingFunction:sortArrayBySecondScheduleDate context:NULL];
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
        TrainOrderListFilterView * filterView1 = [[TrainOrderListFilterView alloc] initWithFrame:CGRectMake(0,35,ViewWidth,ViewHeight-(IOS7_OR_LATER?15:35))];
        self.filterView = filterView1;
        self.filterView.delegate = self;
        [filterView1 release];
    }
    
    NSMutableArray * timeRange = [NSMutableArray arrayWithObjects:@"6",@"24",nil];
    NSMutableArray * ordersStates = [NSMutableArray array];
    for (TrainOrderItem * elem in self._dataArrayAll) {
        
        if (![ordersStates containsObject:elem._orderStatus]) {
            [ordersStates addObject:elem._orderStatus];
        }
    }
    [ordersStates sortUsingSelector:@selector(compare:)];
    NSLog(@"%@,%@",timeRange,ordersStates);
    [self.filterView setTicketOrderTime];
    self.filterView._orderStates = ordersStates;
    
    self.filterView.frame = CGRectMake(0,35,ViewWidth,ViewHeight-(IOS7_OR_LATER?15:35));
    if (self.filterView.superview == nil) {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListFilter.png"] forState:UIControlStateNormal];
        [self.view insertSubview:self.filterView atIndex: [[self.view subviews] count]  animated:YES ];
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
    
    for (TrainOrderItem * info in self._dataArrayAll) {
        
        if ([self.filterView._selectRangeMonth count] == 0) {
            if ([self.filterView._selectOrderStates containsObject:info._orderStatus]) {
                [tmpArray addObject:info];
            }
        }
        else if ([self.filterView._selectRangeMonth count] == 1){
            
            if ([info._orderDate compare:startDate]<0) {
                if ([self.filterView._selectOrderStates containsObject:info._orderStatus]) {
                    [tmpArray addObject:info];
                }
            }
        }
        else if ([self.filterView._selectRangeMonth count] == 2){
            if ([info._orderDate compare:startDate]>=0 && [info._orderDate compare:endDate]<=0) {
                if ([self.filterView._selectOrderStates containsObject:info._orderStatus]) {
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
            [UIAlertView alertViewWithMessage:@"暂无符合筛选条件的车票订单！" :@"提示"];
        }
    }
    else {
        self.filterDataArray = tmpArray;
        [self.filterView removeFromSuperviewWithAnimated:YES];
        [myTable reloadData];
    }
}

static NSInteger  sortArrayByScheduleDate(id item1, id item2, void *context){//从晚到早
    TrainOrderItem *info1 = item1;
    TrainOrderItem *info2 = item2;
    if ([info1._orderDate compare:info2._orderDate] < 0)
        return NSOrderedDescending;
    else if ([info1._orderDate compare:info2._orderDate] > 0)
        return NSOrderedAscending;
    else
        return  NSOrderedSame;
}

static NSInteger sortArrayBySecondScheduleDate(id item1, id item2, void *context){//从早到晚
    TrainOrderItem *info1 = item1;
    TrainOrderItem *info2 = item2;
    
    if ([info1._orderDate compare:info2._orderDate] < 0)
        return NSOrderedAscending;
    else if ([info1._orderDate compare:info2._orderDate] > 0)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

static NSInteger sortArrayByTotelMoney(id item1, id item2, void *context){//从高到低
    TrainOrderItem *info1 = item1;
    TrainOrderItem *info2 = item2;
    
    CGFloat v1 = [info1._orderTotal floatValue];
    CGFloat v2 = [info2._orderTotal floatValue];
    if (v1 < v2)
        return NSOrderedAscending;//升序
    else if (v1 >v2)
        return NSOrderedDescending;//降序
    else
        return NSOrderedSame;
}

static NSInteger sortArrayByTotelMoneySecond(id item1, id item2, void *context){//从高到低
    TrainOrderItem *info1 = item1;
    TrainOrderItem *info2 = item2;
    
    CGFloat v1 = [info1._orderTotal floatValue];
    CGFloat v2 = [info2._orderTotal floatValue];
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
        self._dataArrayAll = (NSMutableArray *)[self._dataArrayAll sortedArrayUsingFunction:sortArrayByTotelMoney context:NULL];
    }
    else {
        self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortArrayByTotelMoneySecond context:NULL];
        self._dataArrayAll =  (NSMutableArray *)[self._dataArrayAll sortedArrayUsingFunction:sortArrayByTotelMoneySecond context:NULL];
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
    int year=(int)[comps year];
    int month=(int)[comps month];
    int day=(int)[comps day];
    
    if (month - [addMonth intValue] < 0) {
        resultMonth = [NSString stringWithFormat:@"%d", 12 + month - [addMonth intValue]];
        resultYear = [NSString stringWithFormat:@"%d", year - 1];
        resultDay = [NSString stringWithFormat:@"%d", day];
    }
    else{
        resultMonth = [NSString stringWithFormat:@"%d", month - [addMonth intValue]];
        resultYear = [NSString stringWithFormat:@"%d", year];
        resultDay = [NSString stringWithFormat:@"%d", day];
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
    
    
    newDate = [NSString stringWithFormat:@"%@-%@-%@ 23:59:59", resultYear, resultMonth, resultDay];
    NSLog(@"%@", newDate);
    [calendar release];
    return newDate;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
