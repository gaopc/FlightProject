//
//  TrainListViewController.m
//  FlightProject
//
//  Created by admin on 13-1-6.
//
//

#import "TrainListViewController.h"

@interface TrainListFilterViewOrdersStateView : UIView
@property (nonatomic,retain) UIButton * _selectButton;
@property (nonatomic,assign) BOOL _isSelected;
@end


@implementation TrainListFilterViewOrdersStateView

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
        self._selectButton = [UIButton buttonWithTag:-1 image:[UIImage imageNamed:@"FilterMoreSelected.png"] title:@"不限" imageEdge:UIEdgeInsetsMake(5, 0, 5, 60) frame:CGRectMake((frame.size.width - 80) / 2, 10, 80, 30) font:FontSize22 color:FontColor2585CF target:nil action:nil];
        self._isSelected = FALSE;
        [self addSubview:self._selectButton];
    }
    return self;
}
@end

@implementation TrainListFilterView

@synthesize _orderStates ,_selectOrderStates,_view2, _buttonView, _selectRangeMonth;
@synthesize delegate;
-(void)dealloc
{
    self._selectRangeMonth = nil;
    self._buttonView = nil;
    self._orderStates = nil;
    self._selectOrderStates = nil;
    self._view2 = nil;
    self.delegate = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:self.bounds image:[UIImage imageNamed:@"background.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"列车类型" frame: CGRectMake(0, 3, ViewWidth, 25) font:FontSize24 color:FontColor696969 alignment:NSTextAlignmentCenter]];
        
        UIView * view2 =  [[UIView alloc] initWithFrame:CGRectMake(0, 24, ViewWidth, 50)];
        self._view2 = view2;
        [view2 release];
        
        UIImageView * imageV2 = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 50) image:[UIImage imageNamed:@"FilterBackground3.png"]];
        imageV2.tag = 1;
        imageV2.autoresizesSubviews = YES;
        imageV2.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        
        [self._view2 addSubview:imageV2];
        [self addSubview:self._view2];
        
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth-112)/2, frame.size.height - 50, 112, 35) backImage:[UIImage imageNamed:@"FilterDown.png"] target:self   action:@selector(filterDown)]];
    }
    return self;
}

-(void)selectOrderStates:(UIButton *)sender
{
    if ([self._orderStates count] >1) {
        if(sender.tag == -1)//点击“不限”时，“不限”按钮置蓝，其他按钮置空
        {
            for (TrainListFilterViewOrdersStateView *view in [self._view2 subviews])
            {
                if ([view isKindOfClass:[TrainListFilterViewOrdersStateView class]])
                {
                    if (view._selectButton == sender) {
                        view._isSelected = TRUE;
                        
                        [view._selectButton setTitleColor:FontColor2585CF forState:UIControlStateNormal];
                        [view._selectButton setImage:[UIImage imageNamed:@"FilterMoreSelected.png"] forState:UIControlStateNormal];
                    }
                    else {
                        view._isSelected = FALSE;
                        [view._selectButton setTitleColor:FontColor696969 forState:UIControlStateNormal];
                        [view._selectButton setImage:[UIImage imageNamed:@"FilterMoreUnSelected.png"] forState:UIControlStateNormal];
                    }
                }

            }
            
        }
        else
        {
            for (TrainListFilterViewOrdersStateView *view in [self._view2 subviews]) {
                if ([view isKindOfClass:[TrainListFilterViewOrdersStateView class]]) {
                    
                    if(view._selectButton.tag == -1)//点击除“不限”外其他按钮时，“不限”按钮置空
                    {
                        view._isSelected = FALSE;
                        [view._selectButton setTitleColor:FontColor696969 forState:UIControlStateNormal];
                        [view._selectButton setImage:[UIImage imageNamed:@"FilterMoreUnSelected.png"] forState:UIControlStateNormal];
                    }
                    else if (view._selectButton == sender)//点击除“不限”外其他按钮时，此按钮置为其相反状态
                    {
                        view._isSelected = !view._isSelected;
                        
                        view._isSelected?([view._selectButton setTitleColor:FontColor2585CF forState:UIControlStateNormal]):([view._selectButton setTitleColor:FontColor696969 forState:UIControlStateNormal]);
                        
                        view._isSelected?([view._selectButton setImage:[UIImage imageNamed:@"FilterMoreSelected.png"] forState:UIControlStateNormal]):([view._selectButton setImage:[UIImage imageNamed:@"FilterMoreUnSelected.png"] forState:UIControlStateNormal]);
                        break;
                    }
                    
                    
                   
                }
            }
            
        //此时是否将所有条件置空，若是，则自动选中“不限”按钮
            BOOL noLimit = YES;//YES：该将“不限”按钮置蓝；NO 不需要将“不限”按钮置蓝
            for (TrainListFilterViewOrdersStateView *view in [self._view2 subviews])
            {
                if ([view isKindOfClass:[TrainListFilterViewOrdersStateView class]] && view._isSelected)
                {
                    noLimit = NO;
                    break;
                }
            }
            
            if(noLimit)//需要将“不限”按钮置蓝
            {
                for (TrainListFilterViewOrdersStateView *view in [self._view2 subviews])
                {
                    if ([view isKindOfClass:[TrainListFilterViewOrdersStateView class]] && view._selectButton.tag == -1)
                    {
                        view._isSelected = TRUE;
                        
                        [view._selectButton setTitleColor:FontColor2585CF forState:UIControlStateNormal];
                        [view._selectButton setImage:[UIImage imageNamed:@"FilterMoreSelected.png"] forState:UIControlStateNormal];
                    }
                }
            }
            

        }
    }
}

-(void)set_orderStates:(NSMutableArray *)orderStates
{
    for (UIView * sub in [self._view2 subviews]) {
        if (sub.tag !=1) {
            [sub removeFromSuperview];
        }
    }
    
    if (_orderStates != orderStates) {
        [_orderStates release];
        _orderStates = [orderStates retain];
        if ([orderStates count]>1) {
            TrainListFilterViewOrdersStateView * view = [[TrainListFilterViewOrdersStateView alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
            view.tag = 0;
            view._isSelected = YES;
            [view._selectButton addTarget:self action:@selector(selectOrderStates:) forControlEvents:UIControlEventTouchUpInside];
            [view._selectButton setImage:[UIImage imageNamed:@"FilterMoreSelected.png"] forState:UIControlStateNormal];
            view._selectButton.tag = -1;
            [view._selectButton setTitle:@"不限" forState:UIControlStateNormal] ;
            [view._selectButton setTitleColor:FontColor2585CF forState:UIControlStateNormal];
            [self._view2 addSubview:view];
            [view release];
            
            for ( int i=0; i< [orderStates count];i++) {
                
                float xCoordinate = 110 + i * 100;
                float yCoordinate = 0;
                if (xCoordinate + 100 > ViewWidth) {
                    CGRect rect = self._view2.frame;
                    rect.size.height = (i+4)/3*50;
                    self._view2.frame= rect;
                    
                    xCoordinate -= (i+1)/3*300;
                    yCoordinate = (i+1)/3*50;
                }
                else {
                    CGRect rect = self._view2.frame;
                    rect.size.height = 50;
                    self._view2.frame= rect;
                }
                
                TrainListFilterViewOrdersStateView * view = [[TrainListFilterViewOrdersStateView alloc] initWithFrame:CGRectMake(xCoordinate, yCoordinate, 100, 50)];
                view.tag = i+1;
                view._isSelected = FALSE;
                [view._selectButton addTarget:self action:@selector(selectOrderStates:) forControlEvents:UIControlEventTouchUpInside];
                [view._selectButton setImage:[UIImage imageNamed:@"FilterMoreUnSelected.png"] forState:UIControlStateNormal];
                view._selectButton.tag = [[orderStates objectAtIndex:i] intValue];
                NSString * _stateStr = nil;
                
                _stateStr = [self setTrainType:view._selectButton.tag];
                
                [view._selectButton setTitle:_stateStr forState:UIControlStateNormal];
                [view._selectButton setTitleColor:FontColor696969 forState:UIControlStateNormal];
                [self._view2 addSubview:view];
                [view release];
                
            }
        }
        else if([orderStates count] == 1) {
            TrainListFilterViewOrdersStateView * view = [[TrainListFilterViewOrdersStateView alloc] initWithFrame:CGRectMake(12, 0, 100, 50)];
            view.tag = 0;
            view._isSelected = YES;
            [view._selectButton addTarget:self action:@selector(selectOrderStates:) forControlEvents:UIControlEventTouchUpInside];
            [view._selectButton setImage:[UIImage imageNamed:@"FilterMoreSelected.png"] forState:UIControlStateNormal];
            view._selectButton.tag = [[orderStates objectAtIndex:0] intValue];
            NSString * _stateStr = nil;
            _stateStr = [self setTrainType:view._selectButton.tag];
            
            [view._selectButton setTitle:_stateStr forState:UIControlStateNormal];
            [view._selectButton setTitleColor:FontColor2585CF forState:UIControlStateNormal];
            [self._view2 addSubview:view];
            [view release];
        }
    }
    
}

- (NSString *)setTrainType:(int)index
{
    NSString *tmp = @"";
    
    if (index == 0) {
        tmp = @"高铁(G)";
    }
    else if (index == 1) {
        tmp = @"动车(D)";
    }
    else if (index == 2) {
        tmp = @"直达(Z)";
    }
    else if (index == 3) {
        tmp = @"特快(T)";
    }
    else if (index == 4) {
        tmp = @"快速(K)";
    }
    else if (index == 5) {
        tmp = @"城铁(C)";
    }
    else if (index == 6) {
        tmp = @"其他";
    }
    return tmp;
}


-(void)filterDown
{
    self._selectOrderStates = [NSMutableArray array];
    
    if ([self._orderStates count]>1) {
        BOOL isSelectedAll = FALSE;
        for (TrainListFilterViewOrdersStateView * elem in [self._view2 subviews]) {
            if ([elem isKindOfClass:[TrainListFilterViewOrdersStateView class]]) {
                if (elem .tag == 0 ) {
                    if (elem._isSelected) {
                        isSelectedAll = TRUE;
                        self._selectOrderStates = self._orderStates;
                    }
                    break;
                }
            }
        }
        if (!isSelectedAll) {
            for (TrainListFilterViewOrdersStateView * elem in [self._view2 subviews]) {
                if ([elem isKindOfClass:[TrainListFilterViewOrdersStateView class]]) {
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterDown)]) {
        [self.delegate performSelector:@selector(filterDown)];
        //        [self removeFromSuperviewWithAnimated:YES];
    }
}

@end


@implementation TrainListViewController
@synthesize selectRowData, data, filterDataArray, filterView,searchType,startStation,endStation,_ticketQuery,_ticketList,_recommendsecRow,_seconInstance,airlineTicketView;

-(void)dealloc
{
	self.searchType = nil;
	self.endStation =nil;
	self.startStation = nil;
	self._ticketQuery = nil;
	self._ticketList = nil;
	self._recommendsecRow = nil;
	self._seconInstance = nil;

	self.airlineTicketView = nil;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"车次列表";
    cellSelect = 0;
    selectButton = 0;
    priceDese = NO;
    sortDese = YES;
    
    UIView * headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, ViewWidth, 35);
    
    timeButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"trainListTimeNone.png"] target:self action:@selector(timeButton:)];
    filterButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth/3, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListFilterNone.png"] target:self action:@selector(filterButton:)];
    priceButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth/3*2, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"trainListPriceNone.png"] target:self action:@selector(priceButton:)];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height, ViewWidth, ViewHeight - 79) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.dataSource = self;
    myTable.delegate = self;
    
    [headView addSubview : priceButton];
    [headView addSubview : timeButton];
    [headView addSubview : filterButton];
	

    
//    UIImageView *bomImgView = [UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight  - 44-41, 320, 41) image:[UIImage imageNamed:@"HotelListbottom.png"]];
//    
//    self.bomLab = [UISubLabel labelWithTitle:@"查询结果仅供参考，购票请拨打铁道部95105105专线订票" frame:CGRectMake(0, 5, 320, 41) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
//    [bomImgView addSubview:self.bomLab];
//    self.clickButton =[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(0, 5, 320, 41) backImage:nil target:self action:@selector(clickTicket:)];
//    self.clickButton.backgroundColor = [UIColor redColor];
//    [bomImgView addSubview:self.clickButton];

    [self.view addSubview:headView];
    [self.view addSubview:myTable];
//    [self.view addSubview:bomImgView];
  
    
    [headView release];
    [myTable release];
	
	TicketQueryDataModel * tempDataModel = nil;
	NSString *startDate =[NSDate dateCode:[NSDate date]];
	NSString * trainCityCode = [DataClass selectFromAirportCityListWithCityName:self.startStation];
	NSString * arrivalCityCode = [DataClass selectFromAirportCityListWithCityName:self.endStation];
	if(trainCityCode && arrivalCityCode && [self.searchType isEqualToString:@"0"]){

		tempDataModel = [[TicketQueryDataModel alloc] init];
		tempDataModel._fromCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:self.startStation  code:trainCityCode ];
		tempDataModel._toCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:self.endStation  code:arrivalCityCode ];
		tempDataModel._startDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateFormateTicketQuery:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"]] code:startDate ];
		tempDataModel._arriveDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:Delay_Days type:3] code:[NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:Delay_Days type:1] ];
		tempDataModel._flightType = SingleType;
		tempDataModel._transitCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:@""  code:@""  ];
		
		self._ticketQuery = tempDataModel;
		[tempDataModel release];
		recommend = [[RecommendClass alloc ] init];
		recommend.delegate = self;
		[recommend recommendFlightWithDeparture:trainCityCode withArrival:arrivalCityCode withStartDate:startDate];
		
		
	}
    
//    [self setDicData];
    [self timeButton:timeButton];
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
    TrainListViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[TrainListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    TrainListInfo *trainInfo = [self.filterDataArray objectAtIndex:indexPath.row];
    if (trainInfo != nil) {
        cell.startView.image = [UIImage imageNamed:[NSString stringWithFormat:@"trainIcon%@.png", trainInfo._originatingType]];
        cell.reachView.image = [UIImage imageNamed:[NSString stringWithFormat:@"trainIcon%@.png", trainInfo._terminalType]];
        
        cell.startTimeLab.text = trainInfo._departureTime;
        cell.reachTimeLab.text = trainInfo._arrivalTime;
        cell.startStationLab.text = trainInfo._originatingStation;
        cell.reachStationLab.text = trainInfo._terminalStation;
        cell.reachDayLab.text = [self setStringNum:trainInfo._days];
        cell.spendTimeLab.text = [self setSpendTime:trainInfo._runningTime];
        cell.distanceLab.text = [NSString stringWithFormat:@"里程%@KM", trainInfo._mileage];
        
//        cell.trainNameLab.text = [trainInfo._trainNumber stringByReplacingOccurrencesOfRegex:@"/" withString:@"\n"];
        
        
        
        NSString *tmpStr = @"";
        int index = [trainInfo._trainNumber rangeOfString:@"/"].location + 1;
        if (trainInfo._trainNumber.length > index) {
            tmpStr = [NSString stringWithFormat:@"%@%@", [[trainInfo._trainNumber substringToIndex:index] stringByReplacingOccurrencesOfString:@"/" withString:@"\n"], [trainInfo._trainNumber substringFromIndex:index]];
        }
        else{
            tmpStr = [trainInfo._trainNumber stringByReplacingOccurrencesOfString:@"/" withString:@"\n"];
        }
        cell.trainNameLab.text = tmpStr;
        cell.trainTypeLab.text = trainInfo._trainType;
    }
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 0, ViewWidth-20, 74)];
    cellSelect = indexPath.row;
    TrainListInfo *cellData = [self.filterDataArray objectAtIndex:indexPath.row];
    self.selectRowData = cellData;

    
    ASIFormDataRequest * theRequest = [InterfaceClass searchTrainDetail:cellData._trainNumber];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onTrainDetailsResult:) Delegate:self needUserType:Default];
    
//    [self onTrainDetailsResult:nil];
}

#pragma mark - buttonClick


-(void) recommendTicketSucessful:(QueryFlightTicket *)array
{
	if (array._firstFlightInfo) {

		self.airlineTicketView = [[AirlineTicketView alloc] initWithFrame:CGRectMake(0, ViewHeight  - 41+ViewStartY, ViewWidth, 41)];
		[self.view addSubview:self.airlineTicketView];
		CGRect newFrame = myTable.frame;
		newFrame.size.height = ViewHeight  - 34 - 35+ViewStartY;
		myTable.frame = newFrame;
		
		self._ticketList = array;
		
		self._recommendsecRow = self._ticketList._firstFlightInfo;
		self._seconInstance = [self._recommendsecRow objectAtIndex:0];
		
		if([self._seconInstance isKindOfClass:[FlightInfo class]])
		{
			FlightInfo * info = self._seconInstance;
			[self.airlineTicketView.clickButton addTarget:self action:@selector(clickTicket:) forControlEvents:UIControlEventTouchUpInside];
			self.airlineTicketView.cellPrice.text =  [NSString stringWithFormat:@"机票最低折扣价 %@元",info._ticketPrice] ;
			self.airlineTicketView.cellCities.text = [NSString stringWithFormat:@"%@ 至 %@",self.startStation ,self.endStation];
			self.airlineTicketView.cellClick.text = @"点击查询";

		}
		
		
	}
	
}

- (void)clickTicket:(id)sender
{
	NSLog(@"跳转到机票！");
	
	
	self._ticketQuery._flightType = SingleType;
	TicketHomeViewController * ticketHomeVC = [[TicketHomeViewController alloc] init];
	ticketHomeVC.ticketDataModel = self._ticketQuery;
	
	//    TicketQueryViewController * ticketHomeVC = [[TicketQueryViewController alloc] init];
	//    ticketHomeVC.title = @"机票";
	//    ticketHomeVC.queryDataModel = self._ticketQuery;
	
	NavigationController.viewControllers = [NSArray arrayWithObjects:[NavigationController.viewControllers objectAtIndex:0], ticketHomeVC,nil];
	[ticketHomeVC release];
	
	TicketQueryDetailViewController * ticketDetailVC = [[TicketQueryDetailViewController alloc] init];
	ticketDetailVC.title = [NSString stringWithFormat:@"%@-%@",self.startStation,self.endStation];
	ticketDetailVC.queryDataModel = self._ticketQuery;
	ticketDetailVC.queryTicket = self._ticketList;
	ticketDetailVC.dataArray = (NSMutableArray *)self._ticketList._firstFlightInfo;
	ticketDetailVC.filterDataArray = (NSMutableArray *) self._ticketList._firstFlightInfo;
	ticketDetailVC.sortArrayBy = PriceAesc;
	[NavigationController pushViewController:ticketDetailVC animated:YES];
	[ticketDetailVC release];
}




- (void)onTrainDetailsResult:(NSDictionary *)dic
{
    TrainTicketInfoViewController *trainDetailVC = [[TrainTicketInfoViewController alloc] init];
    trainDetailVC.title = self.selectRowData._trainNumber;
    trainDetailVC.stationInfoArray = (NSMutableArray *)[SearchTrainDetail setTrainDetailInfo:dic];//接口有问题
    trainDetailVC.trainListInfo = self.selectRowData;
    trainDetailVC.searchType = self.searchType;
    [NavigationController pushViewController:trainDetailVC animated:YES];
    [trainDetailVC release];
}

-(void)timeButton:(UIButton *)sender
{
    NSLog(@"timeButton");
    [self.filterView removeFromSuperview];
    sortDese = !sortDese;
    selectButton = 1;
    [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
    [priceButton setBackgroundImage:[UIImage imageNamed:@"trainListPriceNone.png"] forState:UIControlStateNormal];
    
    if (sortDese) {
        [sender setBackgroundImage:[UIImage imageNamed:@"trainListTimeDown.png"] forState:UIControlStateNormal];
        self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortArrayByScheduleDate context:NULL];
        self.data = (NSMutableArray *)[self.data sortedArrayUsingFunction:sortArrayByScheduleDate context:NULL];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"trainListTimeUp.png"] forState:UIControlStateNormal];
        self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortArrayBySecondScheduleDate context:NULL];
        self.data = (NSMutableArray *)[self.data sortedArrayUsingFunction:sortArrayBySecondScheduleDate context:NULL];
    }
    [myTable reloadData];
}

-(void)priceButton:(UIButton *)sender
{
    NSLog(@"priceButton");
    [self.filterView removeFromSuperview];
    [timeButton setBackgroundImage:[UIImage imageNamed:@"trainListTimeNone.png"] forState:UIControlStateNormal];
    [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
    
    priceDese = !priceDese;
    selectButton = 2;
    if (priceDese) {
        [sender setBackgroundImage:[UIImage imageNamed:@"trainListPriceUp.png"] forState:UIControlStateNormal];
        self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortArrayByTotelMoney context:NULL];
        self.data = (NSMutableArray *)[self.data sortedArrayUsingFunction:sortArrayByTotelMoney context:NULL];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"trainListPriceDown.png"] forState:UIControlStateNormal];
        self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortArrayByTotelMoneySecond context:NULL];
        self.data =  (NSMutableArray *)[self.data sortedArrayUsingFunction:sortArrayByTotelMoneySecond context:NULL];
    }
    
    [myTable reloadData];
}

-(void)filterButton:(UIButton *)sender
{
    [timeButton setBackgroundImage:[UIImage imageNamed:@"trainListTimeNone.png"] forState:UIControlStateNormal];
    [priceButton setBackgroundImage:[UIImage imageNamed:@"trainListPriceNone.png"] forState:UIControlStateNormal];
    
    NSLog(@"filterButton");
    if (self.filterView == nil) {
	    TrainListFilterView * filterView1 = [[TrainListFilterView alloc] initWithFrame:CGRectMake(0,35,ViewWidth,ViewHeight - (IOS7_OR_LATER?15:35))];
        self.filterView = filterView1;
        self.filterView.delegate = self;
        [filterView1 release];
        NSMutableArray * ordersStates = [NSMutableArray array];
        for (TrainListInfo * elem in self.data) {
            
            if (![ordersStates containsObject:[self setTrainTypeIndex:[elem._trainNumber substringToIndex:1]]]) {
                [ordersStates addObject:[self setTrainTypeIndex:[elem._trainNumber substringToIndex:1]]];
            }
        }
        [ordersStates sortUsingSelector:@selector(compare:)];
        self.filterView._orderStates = ordersStates;
    }
    
    self.filterView.frame = CGRectMake(0,35,ViewWidth,ViewHeight - (IOS7_OR_LATER?15:35));
    if (self.filterView.superview == nil) {
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListFilter.png"] forState:UIControlStateNormal];
        [self.view insertSubview:self.filterView atIndex: [[self.view subviews] count] animated:YES ];
    }
    else
    {
        [self setButtonTypeImage];
        [sender setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
        [self.filterView removeFromSuperviewWithAnimated:YES];
    }
    
}

-(void)filterDown
{
    [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (TrainListInfo * info in self.data) {
        
        if ([self.filterView._selectOrderStates containsObject:[self setTrainTypeIndex:[info._trainNumber substringToIndex:1]]]) {
            [tmpArray addObject:info];
        }
    }
    
    [self setButtonTypeImage];
    if ([tmpArray count] == 0) {
        [self.filterView removeFromSuperviewWithAnimated:YES];
        [UIAlertView alertViewWithMessage:@"暂无符合筛选条件的火车车次信息！" :@"提示"];
    }
    else {
        self.filterDataArray = tmpArray;
        [self.filterView removeFromSuperviewWithAnimated:YES];
        [myTable reloadData];
    }
}

static NSInteger sortArrayByScheduleDate(id item1, id item2, void *context){//从晚到早
    TrainListInfo *info1 = item1;
	TrainListInfo *info2 = item2;
    
	if ([info1._departureTime compare:info2._departureTime] < 0)
        return NSOrderedDescending;
    else if ([info1._departureTime compare:info2._departureTime] > 0)
        return NSOrderedAscending;
    else
        return NSOrderedSame;
}

static NSInteger sortArrayBySecondScheduleDate(id item1, id item2, void *context){//从早到晚
    TrainListInfo *info1 = item1;
	TrainListInfo *info2 = item2;
    
	if ([info1._departureTime compare:info2._departureTime] < 0)
        return NSOrderedAscending;
    else if ([info1._departureTime compare:info2._departureTime] > 0)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}


static NSInteger sortArrayByTotelMoney(id item1, id item2, void *context){//从高到低
    TrainListInfo *info1 = item1;
	TrainListInfo *info2 = item2;
    
    int v1 = [info1._runningTime intValue];
    int v2 = [info2._runningTime intValue];
	if (v1 < v2)
        return NSOrderedAscending;//升序
    else if (v1 >v2)
        return NSOrderedDescending;//降序
    else
        return NSOrderedSame;
}

static NSInteger sortArrayByTotelMoneySecond(id item1, id item2, void *context){//从高到低
    TrainListInfo *info1 = item1;
	TrainListInfo *info2 = item2;
    
    int v1 = [info1._runningTime intValue];
    int v2 = [info2._runningTime intValue];
	if (v1 < v2)
        return NSOrderedDescending;//降序
    else if (v1 >v2)
        return NSOrderedAscending;//升序
    else
        return NSOrderedSame;
}

- (NSString *)setStringNum:(NSString *)num
{
    NSString *tmp = @"";
    
    if ([num intValue] == 1) {
        tmp = @"";
    }
    else if ([num intValue] > 1){
        tmp = [NSString stringWithFormat:@"(第%@天)", num];
    }
    else{
        tmp = @"";
    }
    
    return tmp;
}

- (NSString *)setSpendTime:(NSString *)time
{
    NSString *tmp = @"";
    if ([time intValue] < 60) {
        tmp = [NSString stringWithFormat:@"历时  %@分", time];
    }
    else if ([time intValue] % 60 == 0)
    {
        tmp = [NSString stringWithFormat:@"历时  %d小时", [time intValue] / 60];
    }
    else
    {
        tmp = [NSString stringWithFormat:@"历时  %d小时%d分", [time intValue] / 60, [time intValue] % 60];
    }
    return tmp;
}

- (NSString *)setTrainTypeIndex:(NSString *)letter
{
    NSString *tmp = @"";
    if ([letter isEqualToString:@"G"]) {
        tmp = @"0";
    }
    else if ([letter isEqualToString:@"D"]) {
        tmp = @"1";
    }
    else if ([letter isEqualToString:@"Z"]) {
        tmp = @"2";
    }
    else if ([letter isEqualToString:@"T"]) {
        tmp = @"3";
    }
    else if ([letter isEqualToString:@"K"]) {
        tmp = @"4";
    }
    else if ([letter isEqualToString:@"C"]) {
        tmp = @"5";
    }
    else{
        tmp = @"6";
    }
    return tmp;
}

- (void)setDicData
{
    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"T123", @"空调普快", @"08:00", @"15:00", @"北京", @"乌鲁木齐西站", @"269", @"1124", @"0", @"2", @"4", nil] forKeys:[NSArray arrayWithObjects:@"trainNumber", @"trainType", @"departureTime", @"arrivalTime", @"originatingStation", @"terminalStation", @"runningTime", @"mileage", @"originatingType", @"terminalType", @"days", nil]];
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"D123", @"高铁", @"02:22", @"15:00", @"北京西站", @"北京站", @"40", @"300", @"0", @"1", @"1", nil] forKeys:[NSArray arrayWithObjects:@"trainNumber", @"trainType", @"departureTime", @"arrivalTime", @"originatingStation", @"terminalStation", @"runningTime", @"mileage", @"originatingType", @"terminalType", @"days", nil]];
    NSDictionary *dic3 = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"K263", @"动车", @"08:02", @"15:00", @"北京", @"包头东站", @"600", @"1124", @"1", @"1", @"2", nil] forKeys:[NSArray arrayWithObjects:@"trainNumber", @"trainType", @"departureTime", @"arrivalTime", @"originatingStation", @"terminalStation", @"runningTime", @"mileage", @"originatingType", @"terminalType", @"days", nil]];
    NSDictionary *dic4 = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"C123", @"空调普快", @"04:10", @"15:00", @"北京", @"乌鲁木齐西南站", @"269", @"1124", @"1", @"2", @"3", nil] forKeys:[NSArray arrayWithObjects:@"trainNumber", @"trainType", @"departureTime", @"arrivalTime", @"originatingStation", @"terminalStation", @"runningTime", @"mileage", @"originatingType", @"terminalType", @"days", nil]];
    NSDictionary *dic5 = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"123", @"空调普快", @"15:00", @"15:00", @"北京", @"乌鲁木齐西站", @"269", @"1124", @"0", @"2", @"4", nil] forKeys:[NSArray arrayWithObjects:@"trainNumber", @"trainType", @"departureTime", @"arrivalTime", @"originatingStation", @"terminalStation", @"runningTime", @"mileage", @"originatingType", @"terminalType", @"days", nil]];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:[NSArray arrayWithObjects:dic1, dic2, dic3, dic4, dic5, nil], nil] forKeys:[NSArray arrayWithObjects:@"trainList", nil]];
    
    self.data = (NSMutableArray*)[TrainListInfo setTrainListInfo:dic];
    self.filterDataArray = (NSMutableArray*)[TrainListInfo setTrainListInfo:dic];
}

- (void)setButtonTypeImage
{
    if (selectButton == 1) {
        if (sortDese) {
            [timeButton setBackgroundImage:[UIImage imageNamed:@"trainListTimeDown.png"] forState:UIControlStateNormal];
        }
        else {
            [timeButton setBackgroundImage:[UIImage imageNamed:@"trainListTimeUp.png"] forState:UIControlStateNormal];
        }
    }
    else if (selectButton == 2)
    {
        if (priceDese) {
            [priceButton setBackgroundImage:[UIImage imageNamed:@"trainListPriceUp.png"] forState:UIControlStateNormal];
        }
        else {
            [priceButton setBackgroundImage:[UIImage imageNamed:@"trainListPriceDown.png"] forState:UIControlStateNormal];
        }
    }
}
@end
