//
//  WoyinTrainListViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 15-6-4.
//
//

#import "WoyinTrainListViewController.h"
#import "WoyinPassagerListViewController.h"

@interface WoyinTrainListFilterViewOrdersStateView : UIView
@property (nonatomic,retain) UIButton * _selectButton;
@property (nonatomic,assign) BOOL _isSelected;
@end


@implementation WoyinTrainListFilterViewOrdersStateView

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

@interface WoyinTrainListFilterView : UIView

@property (nonatomic,retain) NSMutableArray * _orderStates;
@property (nonatomic,retain) NSMutableArray * _selectOrderStates;
@property (nonatomic,retain) NSArray * _selectRangeMonth;
@property (nonatomic,retain) UIView * _view2;
@property (nonatomic,retain) UIImageView * _buttonView;
@property (nonatomic,assign) id delegate;
@end
@implementation WoyinTrainListFilterView

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
            for (WoyinTrainListFilterViewOrdersStateView *view in [self._view2 subviews])
            {
                if ([view isKindOfClass:[WoyinTrainListFilterViewOrdersStateView class]])
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
            for (WoyinTrainListFilterViewOrdersStateView *view in [self._view2 subviews]) {
                if ([view isKindOfClass:[WoyinTrainListFilterViewOrdersStateView class]]) {
                    
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
            for (WoyinTrainListFilterViewOrdersStateView *view in [self._view2 subviews])
            {
                if ([view isKindOfClass:[WoyinTrainListFilterViewOrdersStateView class]] && view._isSelected)
                {
                    noLimit = NO;
                    break;
                }
            }
            
            if(noLimit)//需要将“不限”按钮置蓝
            {
                for (WoyinTrainListFilterViewOrdersStateView *view in [self._view2 subviews])
                {
                    if ([view isKindOfClass:[WoyinTrainListFilterViewOrdersStateView class]] && view._selectButton.tag == -1)
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
            WoyinTrainListFilterViewOrdersStateView * view = [[WoyinTrainListFilterViewOrdersStateView alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
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
                
                WoyinTrainListFilterViewOrdersStateView * view = [[WoyinTrainListFilterViewOrdersStateView alloc] initWithFrame:CGRectMake(xCoordinate, yCoordinate, 100, 50)];
                view.tag = i+1;
                view._isSelected = FALSE;
                [view._selectButton addTarget:self action:@selector(selectOrderStates:) forControlEvents:UIControlEventTouchUpInside];
                [view._selectButton setImage:[UIImage imageNamed:@"FilterMoreUnSelected.png"] forState:UIControlStateNormal];
                view._selectButton.tag = [[orderStates objectAtIndex:i] intValue];
                NSString * _stateStr = nil;
                
                _stateStr = [self setTrainType:(int)view._selectButton.tag];
                
                [view._selectButton setTitle:_stateStr forState:UIControlStateNormal];
                [view._selectButton setTitleColor:FontColor696969 forState:UIControlStateNormal];
                [self._view2 addSubview:view];
                [view release];
                
            }
        }
        else if([orderStates count] == 1) {
            WoyinTrainListFilterViewOrdersStateView * view = [[WoyinTrainListFilterViewOrdersStateView alloc] initWithFrame:CGRectMake(12, 0, 100, 50)];
            view.tag = 0;
            view._isSelected = YES;
            [view._selectButton addTarget:self action:@selector(selectOrderStates:) forControlEvents:UIControlEventTouchUpInside];
            [view._selectButton setImage:[UIImage imageNamed:@"FilterMoreSelected.png"] forState:UIControlStateNormal];
            view._selectButton.tag = [[orderStates objectAtIndex:0] intValue];
            NSString * _stateStr = nil;
            _stateStr = [self setTrainType:(int)view._selectButton.tag];
            
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
        for (WoyinTrainListFilterViewOrdersStateView * elem in [self._view2 subviews]) {
            if ([elem isKindOfClass:[WoyinTrainListFilterViewOrdersStateView class]]) {
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
            for (WoyinTrainListFilterViewOrdersStateView * elem in [self._view2 subviews]) {
                if ([elem isKindOfClass:[WoyinTrainListFilterViewOrdersStateView class]]) {
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterDown)]) {
        [self.delegate performSelector:@selector(filterDown)];
        //        [self removeFromSuperviewWithAnimated:YES];
    }
}

@end

@interface WoyinTrainListViewCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_startTimeLab;
@property (nonatomic, retain) UISubLabel *_reachTimeLab;
@property (nonatomic, retain) UISubLabel *_startStationLab;
@property (nonatomic, retain) UISubLabel *_reachStationLab;
@property (nonatomic, retain) UISubLabel *_reachDayLab;
@property (nonatomic, retain) UISubLabel *_seatsLab;
@property (nonatomic, retain) UIScrollView *_seatsScrollView;


@property (nonatomic, retain) UISubLabel *_spendTimeLab;
@property (nonatomic, retain) UISubLabel *_trainNameLab;
@property (nonatomic, retain) UISubLabel *_priceLab;

@property (nonatomic, retain) UIImageView *startView;
@property (nonatomic, retain) UIImageView *reachView;
@property (nonatomic, retain) UIImageView *trainView;
@end

@implementation WoyinTrainListViewCell
@synthesize startView, reachView, trainView;
@synthesize _startTimeLab, _reachTimeLab, _startStationLab, _reachStationLab, _seatsLab, _spendTimeLab, _trainNameLab, _priceLab,_reachDayLab;

- (void)dealloc
{
    self._startTimeLab = nil;
    self._reachTimeLab = nil;
    self._startStationLab = nil;
    self._reachStationLab = nil;
    self._seatsLab = nil;
    self._spendTimeLab = nil;
    self._trainNameLab = nil;
    self._priceLab = nil;
    self._reachDayLab = nil;

    self.startView = nil;
    self.reachView = nil;
    self.trainView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth-100, 75) image:[UIImage imageNamed:@"TicketListLeft.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-90, 0, 80, 75) image:[UIImage imageNamed:@"TicketListRight.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 52, ViewWidth-120, 1) image:[UIImage imageNamed:@"TicketListxuxian.png"]]];
        
        self.startView = [UIImageView ImageViewWithFrame:CGRectMake(25, 10, 15, 15) image:[UIImage imageNamed:@"trainIcon0.png"]];
        self.reachView = [UIImageView ImageViewWithFrame:CGRectMake(25, 32, 15, 15) image:[UIImage imageNamed:@"trainIcon2.png"]];
        
        self._startTimeLab = [UISubLabel labelWithTitle:@"06:30" frame:CGRectMake(10, 8, 90, 20) font:FontBlodSize42 color:FontColor2585CF alignment:NSTextAlignmentRight];
        self._reachTimeLab = [UISubLabel labelWithTitle:@"08:10" frame:CGRectMake(40, 30, 60, 20) font:FontBlodSize32 color:FontColorBlue alignment:NSTextAlignmentRight];
        self._reachDayLab = [UISubLabel labelWithTitle:@"(第2天)" frame:CGRectMake(103, 30, 60, 20) font:FontSize20 color:FontColor2585CF alignment:NSTextAlignmentLeft];
        self._startStationLab = [UISubLabel labelWithTitle:@"乌鲁木齐西" frame:CGRectMake(ViewWidth-190, 8, 90, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentRight];
        self._reachStationLab = [UISubLabel labelWithTitle:@"鄂尔多斯东" frame:CGRectMake(ViewWidth-190, 30, 90, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentRight];
        self._seatsScrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(20, 52, 200, 20)] autorelease];
        self._seatsScrollView.showsHorizontalScrollIndicator = NO;
        self._seatsScrollView.showsVerticalScrollIndicator = NO;
        self._seatsLab = [UISubLabel labelWithTitle:@"二等座 755   一等座 90   特等座 无" frame:self._seatsScrollView.bounds font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        [self._seatsScrollView addSubview:self._seatsLab];

        
        self._spendTimeLab = [UISubLabel labelWithTitle:@"8小时33分" frame:CGRectMake(ViewWidth-92, 5, 80, 20) font:FontSize24 color:FontColor636363 alignment:NSTextAlignmentCenter];
        self._trainNameLab = [UISubLabel labelWithTitle:@"K8888" frame:CGRectMake(ViewWidth-82, 0, 60, 75) font:FontBlodSize36 color:FontColorFF8813 alignment:NSTextAlignmentCenter];
        self._trainNameLab.minimumScaleFactor = 18;
        self._trainNameLab.adjustsFontSizeToFitWidth = YES;
        self._trainNameLab.lineBreakMode = NSLineBreakByWordWrapping;
        
        self._priceLab = [UISubLabel labelWithTitle:@"¥230起" frame:CGRectMake(ViewWidth-82, 50, 60, 20) font:FontSize26 color:FontColorFF8813 alignment:NSTextAlignmentCenter];
        
        [self addSubview:self.startView];
        [self addSubview:self.reachView];
        [self addSubview:self._startTimeLab];
        [self addSubview:self._reachTimeLab];
        [self addSubview:self._reachDayLab];
        [self addSubview:self._startStationLab];
        [self addSubview:self._reachStationLab];
        [self addSubview:self._spendTimeLab];
        [self addSubview:self.trainView];
        [self addSubview:self._trainNameLab];
        [self addSubview:self._priceLab];
        [self addSubview:self._seatsScrollView];

    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@interface WoyinBottomView : UIView

@property (nonatomic,retain) UIImageView *  _leftImageView;
@property (nonatomic,retain) UIImageView *  _rightImageView;
@property (nonatomic,retain) UISubLabel * _proLabel;
@property (nonatomic,retain) UISubLabel * _nextLabel;
@property (nonatomic,retain) UISubLabel * _dateLabel;
@property (nonatomic,retain) UISubLabel * _weekLabel;

@property (nonatomic,retain) UIButton * _proButton;
@property (nonatomic,retain) UIButton * _nextButton;

@end

@implementation WoyinBottomView
@synthesize _leftImageView,_rightImageView,_proLabel,_nextLabel,_dateLabel,_weekLabel,_proButton,_nextButton;
-(void)dealloc
{
    self._leftImageView = nil;
    self._rightImageView = nil;
    self._proLabel = nil;
    self._nextLabel = nil;
    self._dateLabel = nil;
    self._weekLabel = nil;
    self._proButton = nil;
    self._nextButton = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:self.bounds image:[UIImage imageNamed:@"TicketListbottom.png"]]];
        self._leftImageView = [UIImageView ImageViewWithFrame:CGRectMake(10,15,21,21) image:[UIImage imageNamed:@"TicketListBottomLeft2.png"]];
        self._rightImageView = [UIImageView ImageViewWithFrame:CGRectMake(280,15,21,21) image:[UIImage imageNamed:@"TicketListBottomRight1.png"]];
        self._proLabel = [UISubLabel labelWithTitle:@"前一天" frame:CGRectMake(42, 15, 100, 20) font:FontSize26 color:FontColor1B77C3 alignment:NSTextAlignmentLeft];
        self._nextLabel = [UISubLabel labelWithTitle:@"后一天" frame:CGRectMake(235, 15, 100, 20) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
        self._dateLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(0, 7, ViewWidth, 20) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
        self._weekLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(0, 20, ViewWidth, 20) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
        
        self._proButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 15, 100, 20) backImage:nil target:nil action:nil];
        self._nextButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(235, 15, 100, 20) backImage:nil target:nil action:nil];
        
        self._proButton.enabled = NO;
        
        [self addSubview:self._leftImageView];
        [self addSubview:self._rightImageView];
        [self addSubview:self._proLabel];
        [self addSubview:self._nextLabel];
        [self addSubview:self._dateLabel];
        [self addSubview:self._weekLabel];
        [self addSubview:self._proButton];
        [self addSubview:self._nextButton];
    }
    return self;
}

@end


@interface WoyinTrainListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView * headView;
    UIButton * timeButton;
    UIButton * filterButton;
    UIButton * priceButton;
    UIButton * dateButton;
    UITableView *myTable;

    BOOL priceDese;
    BOOL sortDese;
    int selectButton; //0未选中，1左侧选中，2右侧选中
    RecommendClass * recommend;
    WoyinBottomView  *bottomView;
}
@property (nonatomic, retain) WoyinTrainListFilterView * filterView;
@property (nonatomic,retain) TicketQueryDataModel * _ticketQuery;
@property (nonatomic, retain) AirlineTicketView *airlineTicketView;
@property (nonatomic,retain) QueryFlightTicket  * _ticketList;
@property (nonatomic,retain) NSString  *searchDate;

@property (nonatomic,retain) NSArray * _dataArrayFilter;


@end

@implementation WoyinTrainListViewController
@synthesize _dataArrayAll,_dataArrayFilter;
@synthesize filterView,_ticketQuery,airlineTicketView,_ticketList;
@synthesize searchDate;
- (void)dealloc
{
    self._dataArrayAll = nil;
    self._dataArrayFilter = nil;

    self.filterView = nil;
    self._ticketQuery = nil;
    self.airlineTicketView = nil;
    self._ticketList = nil;
    self.searchDate = nil;

    [super dealloc];
}
-(void)initBottonView
{
    NSString * nowDay =  [NSDate dateCode:[NSDate date]]; //2012-01-01
    NSLog(@"%@",nowDay);
    NSString * lastDay =  [NSDate dateCode:[NSDate dateafterDay:[NSDate date] day:[[BookingModel shareBookingModel]._preSalePeriod intValue]-1]];
    
    self.searchDate = [BookingModel shareBookingModel]._quaryInfo._quaryDate._nameCode;

    if ([self.searchDate isEqualToString:lastDay]) {
        bottomView._nextButton.enabled = NO;
        bottomView._nextLabel.textColor = FontColor1C7CBC;
        bottomView._rightImageView.image = [UIImage imageNamed:@"TicketListBottomRight2.png"];
    }
    else {
        bottomView._nextButton.enabled = YES;
        bottomView._nextLabel.textColor = FontColorFFFFFF;
        bottomView._rightImageView.image = [UIImage imageNamed:@"TicketListBottomRight1.png"];
    }
    
    if ([self.searchDate isEqualToString:[NSDate dateCode:[NSDate date]]]) {
        bottomView._proButton.enabled = NO;
        bottomView._proLabel.textColor = FontColor1C7CBC;
        bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft2.png"];
    }
    else {
        bottomView._proButton.enabled = YES;
        bottomView._proLabel.textColor = FontColorFFFFFF;
        bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft1.png"];
    }

}


-(void)loadView
{
    [super loadView];
    priceDese = NO;
    sortDese = YES;
    selectButton = 0;
    
    headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, ViewWidth, 35);
//    213 × 69 214 × 69  107*35
    timeButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, ViewWidth/4 - 1, 35) backImage:[UIImage imageNamed:@"trainStartNormal.png"] target:self action:@selector(timeButton:)];
    filterButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth/4, 0, ViewWidth/4 - 1, 35) backImage:[UIImage imageNamed:@"trainFilterNormal.png"] target:self action:@selector(filterButton:)];
    priceButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth/2, 0, ViewWidth/4 - 1, 35) backImage:[UIImage imageNamed:@"trainPriceNormal.png"] target:self action:@selector(priceButton:)];
    dateButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth/4*3, 0, ViewWidth/4, 35) backImage:[UIImage imageNamed:@"trainDateNormal.png"] target:self action:@selector(dateButton:)];
    [self timeButton:timeButton];
    [headView addSubview : priceButton];
    [headView addSubview : timeButton];
    [headView addSubview : dateButton];
    [headView addSubview : filterButton];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height, ViewWidth, ViewHeight - 79) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.dataSource = self;
    myTable.delegate = self;
    
    [self.view addSubview:headView];
    [self.view addSubview:myTable];
    [headView release];
    [myTable release];
    
    bottomView = [[WoyinBottomView alloc] initWithFrame:CGRectMake(0, ViewHeight  - 44-41, ViewWidth, 41)];
    [bottomView._nextButton addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView._proButton addTarget:self action:@selector(proButton:) forControlEvents:UIControlEventTouchUpInside];
    bottomView._dateLabel.text = [BookingModel shareBookingModel]._quaryInfo._quaryDate._nameCode;
    bottomView._weekLabel.text = [NSDate getWeekDayLongStr:[BookingModel shareBookingModel]._quaryInfo._quaryDate._nameCode];
    [self.view addSubview:bottomView];
    [bottomView release];
    
    [self initBottonView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"车次列表";
    self._dataArrayFilter = [NSMutableArray arrayWithArray:self._dataArrayAll];
    [myTable reloadData];
    
    TicketQueryDataModel * tempDataModel = nil;
    NSString *startDate =[NSDate dateCode:[NSDate date]];
    NSString * trainCityCode = [DataClass selectFromAirportCityListWithCityName:[BookingModel shareBookingModel]._quaryInfo._fromStationName];
    NSString * arrivalCityCode = [DataClass selectFromAirportCityListWithCityName:[BookingModel shareBookingModel]._quaryInfo._toStationName];
    if(trainCityCode && arrivalCityCode ){
        
        tempDataModel = [[TicketQueryDataModel alloc] init];
        tempDataModel._fromCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[BookingModel shareBookingModel]._quaryInfo._fromStationName  code:trainCityCode ];
        tempDataModel._toCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[BookingModel shareBookingModel]._quaryInfo._toStationName  code:arrivalCityCode ];
        tempDataModel._startDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateFormateTicketQuery:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"]] code:startDate ];
        tempDataModel._arriveDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:Delay_Days type:3] code:[NSDate dateafterDay:[NSDate dateFromString:startDate withFormat:@"yyyy-MM-dd"] day:Delay_Days type:1] ];
        tempDataModel._flightType = SingleType;
        tempDataModel._transitCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:@""  code:@""  ];
        
        self._ticketQuery = tempDataModel;
        [tempDataModel release];
        recommend = [[RecommendClass alloc ] init];
        recommend.delegate = self;
        [recommend recommendFlightWithDeparture:trainCityCode withArrival:arrivalCityCode withStartDate:[BookingModel shareBookingModel]._quaryInfo._quaryDate._nameCode];
        
    }

}
#pragma mark - Table view dataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self._dataArrayFilter count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"identifier";
    WoyinTrainListViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[WoyinTrainListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    TrainItemInfo * item = [self._dataArrayFilter objectAtIndex:indexPath.row];
    cell._startTimeLab.text = item._startTime;
    cell._reachTimeLab.text = item._arriveTime;
    cell._startStationLab.text = item._fromStationName;
    cell._reachStationLab.text = item._toStationName;
    cell._reachDayLab.text = [NSString stringWithFormat:@"(%@)",item._arriveDays];
    cell._spendTimeLab.text = [NSString stringWithFormat:@"%d小时%d分",[[[item._runTime componentsSeparatedByString:@":"] objectAtIndex:0] intValue],[[[item._runTime componentsSeparatedByString:@":"] objectAtIndex:1] intValue]];
    cell._trainNameLab.text = item._trainNumber;
    cell._priceLab.text = [NSString stringWithFormat:@"¥%@起",item._lowerPrice];
    cell._seatsLab.text = item._seatStr;
    
    if (![item._ifStart boolValue]) {
        cell.startView.image = [UIImage imageNamed:@"trainIcon1.png"];
    }
    else {
        cell.startView.image = [UIImage imageNamed:@"trainIcon0.png"];
    }
    if (![item._ifEnd boolValue]) {
        cell.reachView.image = [UIImage imageNamed:@"trainIcon1.png"];
    }
    else {
        cell.reachView.image = [UIImage imageNamed:@"trainIcon2.png"];
    }
    
    CGSize suggestedSize = [cell._seatsLab.text sizeWithFont:cell._seatsLab.font constrainedToSize:CGSizeMake(FLT_MAX, cell._seatsLab.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect rect = cell._seatsLab.frame;
    rect.size.width = suggestedSize.width;
    cell._seatsLab.frame = rect;
    cell._seatsScrollView.contentSize = CGSizeMake(rect.size.width+20, cell._seatsScrollView.frame.size.height);
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 0, ViewWidth-20, 74)];
    TrainItemInfo * item = [self._dataArrayFilter objectAtIndex:indexPath.row];
    NSLog(@"selectedItem:%@",item);
    [BookingModel shareBookingModel]._selectTrain = item;
    WoyinTrainDetailViewController *trainVC = [[WoyinTrainDetailViewController alloc] init];
    [NavigationController pushViewController:trainVC animated:YES];
    [trainVC release];
}
-(void)nextButton:(UIButton *)sender
{
    NSLog(@"nextButton");

    self.searchDate = [NSDate dateafterDay:[NSDate dateFromString:[BookingModel shareBookingModel]._quaryInfo._quaryDate._nameCode] day:1 type:1];
    
    ASIFormDataRequest * theRequest = [InterfaceClass findTrainListWithStartDate:self.searchDate];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(nextOnPaseredResult:) Delegate:self needUserType:Default];
}

-(void)proButton:(UIButton *)sender
{
    NSLog(@"proButton");

    self.searchDate = [NSDate dateafterDay:[NSDate dateFromString:[BookingModel shareBookingModel]._quaryInfo._quaryDate._nameCode] day:-1 type:1];
    
    ASIFormDataRequest * theRequest = [InterfaceClass findTrainListWithStartDate:self.searchDate];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(nextOnPaseredResult:) Delegate:self needUserType:Default];
}
-(void)nextOnPaseredResult:(NSDictionary *)resultDic
{
    NSArray * trainList = [resultDic objectForKey:@"trainInfos"];
    NSMutableArray * _mArr = [NSMutableArray array];
    if ([trainList isKindOfClass:[NSArray class]]) {
        for (NSDictionary * train in trainList) {
            TrainItemInfo * item = [TrainItemInfo TrainItemInfoWithDic:train];
            if ([BookingModel shareBookingModel]._ifonlyGTrain) {
                if ([item._trainNumber hasPrefix:@"G"]||[item._trainNumber hasPrefix:@"D"]) {
                    [_mArr addObject:item];
                }
            }
            else
            {
                [_mArr addObject:item];
            }
        }
    }
    self._dataArrayAll = _mArr;
    self._dataArrayFilter = [NSArray arrayWithArray:self._dataArrayAll];
    [myTable reloadData];
    [BookingModel shareBookingModel]._quaryInfo._quaryDate._nameCode = self.searchDate;
    [BookingModel shareBookingModel]._quaryInfo._quaryDate._nameStr = [NSDate dateFormateTicketQuery:[NSDate dateFromString:searchDate]];
    
    
    NSString * nowDay =  [NSDate dateCode:[NSDate date]]; //2012-01-01
    
    NSString * lastDay =  [NSDate dateCode:[NSDate dateafterDay:[NSDate date] day:[[BookingModel shareBookingModel]._preSalePeriod intValue]-1]];
    
    if ([self.searchDate isEqualToString:lastDay]) {
        bottomView._nextButton.enabled = NO;
        bottomView._nextLabel.textColor = FontColor1C7CBC;
        bottomView._rightImageView.image = [UIImage imageNamed:@"TicketListBottomRight2.png"];
    }
    else {
        bottomView._nextButton.enabled = YES;
        bottomView._nextLabel.textColor = FontColorFFFFFF;
        bottomView._rightImageView.image = [UIImage imageNamed:@"TicketListBottomRight1.png"];
    }
    
    if ([self.searchDate isEqualToString:nowDay]) {
        bottomView._proButton.enabled = NO;
        bottomView._proLabel.textColor = FontColor1C7CBC;
        bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft2.png"];
    }
    else {
        bottomView._proButton.enabled = YES;
        bottomView._proLabel.textColor = FontColorFFFFFF;
        bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft1.png"];
    }
    bottomView._dateLabel.text = searchDate;
    bottomView._weekLabel.text = [NSDate getWeekDayLongStr:searchDate];
    
}
-(void)timeButton:(UIButton *)sender
{
    NSLog(@"timeButton");
    [self.filterView removeFromSuperview];
    sortDese = !sortDese;
    selectButton = 1;
    [filterButton setBackgroundImage:[UIImage imageNamed:@"trainFilterNormal.png"] forState:UIControlStateNormal];
    [dateButton setBackgroundImage:[UIImage imageNamed:@"trainDateNormal.png"] forState:UIControlStateNormal];
    [priceButton setBackgroundImage:[UIImage imageNamed:@"trainPriceNormal.png"] forState:UIControlStateNormal];
    
    if (sortDese) {
        [sender setBackgroundImage:[UIImage imageNamed:@"trainStartDown.png"] forState:UIControlStateNormal];
        self._dataArrayFilter = (NSMutableArray *)[self._dataArrayFilter sortedArrayUsingFunction:sortArrayByScheduleDate context:NULL];
        self._dataArrayAll = (NSMutableArray *)[self._dataArrayAll sortedArrayUsingFunction:sortArrayByScheduleDate context:NULL];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"trainStatUp.png"] forState:UIControlStateNormal];
        self._dataArrayFilter = (NSMutableArray *)[self._dataArrayFilter sortedArrayUsingFunction:sortArrayBySecondScheduleDate context:NULL];
        self._dataArrayAll = (NSMutableArray *)[self._dataArrayAll sortedArrayUsingFunction:sortArrayBySecondScheduleDate context:NULL];
    }
    [myTable reloadData];
}

-(void)priceButton:(UIButton *)sender
{
    NSLog(@"priceButton");
    [self.filterView removeFromSuperview];
    [timeButton setBackgroundImage:[UIImage imageNamed:@"trainStartNormal.png"] forState:UIControlStateNormal];
    [dateButton setBackgroundImage:[UIImage imageNamed:@"trainDateNormal.png"] forState:UIControlStateNormal];
    [filterButton setBackgroundImage:[UIImage imageNamed:@"trainFilterNormal.png"] forState:UIControlStateNormal];
    priceDese = !priceDese;
    selectButton = 2;

    if (priceDese) {
        [sender setBackgroundImage:[UIImage imageNamed:@"trainPriceUp.png"] forState:UIControlStateNormal];
        self._dataArrayFilter = (NSMutableArray *)[self._dataArrayFilter sortedArrayUsingFunction:sortArrayByTotelPrice context:NULL];
        self._dataArrayAll = (NSMutableArray *)[self._dataArrayAll sortedArrayUsingFunction:sortArrayByTotelPrice context:NULL];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"trainPriceDown.png"] forState:UIControlStateNormal];
        self._dataArrayFilter = (NSMutableArray *)[self._dataArrayFilter sortedArrayUsingFunction:sortArrayByTotelPriceSecond context:NULL];
        self._dataArrayAll =  (NSMutableArray *)[self._dataArrayAll sortedArrayUsingFunction:sortArrayByTotelPriceSecond context:NULL];
    }
    
    [myTable reloadData];
}

- (void)dateButton:(UIButton *)sender
{
    NSLog(@"dateButton");
    [self.filterView removeFromSuperview];
    [timeButton setBackgroundImage:[UIImage imageNamed:@"trainStartNormal.png"] forState:UIControlStateNormal];
    [priceButton setBackgroundImage:[UIImage imageNamed:@"trainPriceNormal.png"] forState:UIControlStateNormal];
    [filterButton setBackgroundImage:[UIImage imageNamed:@"trainFilterNormal.png"] forState:UIControlStateNormal];
    priceDese = !priceDese;
    selectButton = 3;
    
    if (priceDese) {
        [sender setBackgroundImage:[UIImage imageNamed:@"trainDateUp.png"] forState:UIControlStateNormal];
        self._dataArrayFilter = (NSMutableArray *)[self._dataArrayFilter sortedArrayUsingFunction:sortArrayByTotelMoney context:NULL];
        self._dataArrayAll = (NSMutableArray *)[self._dataArrayAll sortedArrayUsingFunction:sortArrayByTotelMoney context:NULL];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"trainDateDown.png"] forState:UIControlStateNormal];
        self._dataArrayFilter = (NSMutableArray *)[self._dataArrayFilter sortedArrayUsingFunction:sortArrayByTotelMoneySecond context:NULL];
        self._dataArrayAll =  (NSMutableArray *)[self._dataArrayAll sortedArrayUsingFunction:sortArrayByTotelMoneySecond context:NULL];
    }
    
    [myTable reloadData];
}

-(void)filterButton:(UIButton *)sender
{
    [timeButton setBackgroundImage:[UIImage imageNamed:@"trainStartNormal.png"] forState:UIControlStateNormal];
    [priceButton setBackgroundImage:[UIImage imageNamed:@"trainPriceNormal.png"] forState:UIControlStateNormal];
    [dateButton setBackgroundImage:[UIImage imageNamed:@"trainDateNormal.png"] forState:UIControlStateNormal];
    
    NSLog(@"filterButton");
    if (self.filterView == nil) {
        WoyinTrainListFilterView * filterView1 = [[WoyinTrainListFilterView alloc] initWithFrame:CGRectMake(0,35,ViewWidth,ViewHeight - (IOS7_OR_LATER?15:35))];
        self.filterView = filterView1;
        self.filterView.delegate = self;
        [filterView1 release];
        NSMutableArray * ordersStates = [NSMutableArray array];
        for (TrainItemInfo * elem in self._dataArrayAll) {
            
            if (![ordersStates containsObject:[self setTrainTypeIndex:[elem._trainNumber substringToIndex:1]]]) {
                [ordersStates addObject:[self setTrainTypeIndex:[elem._trainNumber substringToIndex:1]]];
            }
        }
        [ordersStates sortUsingSelector:@selector(compare:)];
        self.filterView._orderStates = ordersStates;
    }
    
    self.filterView.frame = CGRectMake(0,35,ViewWidth,ViewHeight - (IOS7_OR_LATER?15:35));
    if (self.filterView.superview == nil) {
        [sender setBackgroundImage:[UIImage imageNamed:@"trainFilterHigh.png"] forState:UIControlStateNormal];
        [self.view insertSubview:self.filterView atIndex: [[self.view subviews] count] animated:YES ];
    }
    else
    {
        [self setButtonTypeImage];
        [sender setBackgroundImage:[UIImage imageNamed:@"trainFilterNormal.png"] forState:UIControlStateNormal];
        [self.filterView removeFromSuperviewWithAnimated:YES];
    }
    
}
-(void)filterDown
{
    [filterButton setBackgroundImage:[UIImage imageNamed:@"trainFilterNormal.png"] forState:UIControlStateNormal];
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (TrainItemInfo * info in self._dataArrayAll) {
        
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
        self._dataArrayFilter = tmpArray;
        [self.filterView removeFromSuperviewWithAnimated:YES];
        [myTable reloadData];
    }
}

static NSInteger sortArrayByScheduleDate(id item1, id item2, void *context){//从晚到早
    TrainItemInfo *info1 = item1;
    TrainItemInfo *info2 = item2;
    if ([info1._startTime compare:info2._startTime] < 0)
        return NSOrderedDescending;
    else if ([info1._startTime compare:info2._startTime] > 0)
        return NSOrderedAscending;
    else
        return NSOrderedSame;
}

static NSInteger sortArrayBySecondScheduleDate(id item1, id item2, void *context){//从早到晚
    TrainItemInfo *info1 = item1;
    TrainItemInfo *info2 = item2;
    
    if ([info1._startTime compare:info2._startTime] < 0)
        return NSOrderedAscending;
    else if ([info1._startTime compare:info2._startTime] > 0)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}


static NSInteger sortArrayByTotelMoney(id item1, id item2, void *context){//从高到低
    TrainItemInfo *info1 = item1;
    TrainItemInfo *info2 = item2;
    
    int runtime1 = [[[info1._runTime componentsSeparatedByString:@":"] objectAtIndex:0] intValue]*60+[[[info1._runTime componentsSeparatedByString:@":"] objectAtIndex:1] intValue];
    int runtime2 = [[[info2._runTime componentsSeparatedByString:@":"] objectAtIndex:0] intValue]*60+[[[info2._runTime componentsSeparatedByString:@":"] objectAtIndex:1] intValue];

    
    int v1 = runtime1;
    int v2 = runtime2;
    if (v1 < v2)
        return NSOrderedAscending;//升序
    else if (v1 >v2)
        return NSOrderedDescending;//降序
    else
        return NSOrderedSame;
}

static NSInteger sortArrayByTotelMoneySecond(id item1, id item2, void *context){//从高到低
    TrainItemInfo *info1 = item1;
    TrainItemInfo *info2 = item2;
    
    int runtime1 = [[[info1._runTime componentsSeparatedByString:@":"] objectAtIndex:0] intValue]*60+[[[info1._runTime componentsSeparatedByString:@":"] objectAtIndex:1] intValue];
    int runtime2 = [[[info2._runTime componentsSeparatedByString:@":"] objectAtIndex:0] intValue]*60+[[[info2._runTime componentsSeparatedByString:@":"] objectAtIndex:1] intValue];
    
    
    int v1 = runtime1;
    int v2 = runtime2;
    if (v1 < v2)
        return NSOrderedDescending;//降序
    else if (v1 >v2)
        return NSOrderedAscending;//升序
    else
        return NSOrderedSame;
}

static NSInteger sortArrayByTotelPrice(id item1, id item2, void *context){//从高到低
    TrainItemInfo *info1 = item1;
    TrainItemInfo *info2 = item2;
    
    int v1 = [info1._lowerPrice intValue];
    int v2 = [info2._lowerPrice intValue];
    if (v1 < v2)
        return NSOrderedAscending;//升序
    else if (v1 >v2)
        return NSOrderedDescending;//降序
    else
        return NSOrderedSame;
}

static NSInteger sortArrayByTotelPriceSecond(id item1, id item2, void *context){//从高到低
    TrainItemInfo *info1 = item1;
    TrainItemInfo *info2 = item2;
    
    int v1 = [info1._lowerPrice intValue];
    int v2 = [info2._lowerPrice intValue];
    if (v1 < v2)
        return NSOrderedDescending;//降序
    else if (v1 >v2)
        return NSOrderedAscending;//升序
    else
        return NSOrderedSame;
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

-(void) recommendTicketSucessful:(QueryFlightTicket *)array
{
    if (array._firstFlightInfo) {
        
        self.airlineTicketView = [[AirlineTicketView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height, ViewWidth, 41)];
        [self.view addSubview:self.airlineTicketView];
        CGRect newFrame = myTable.frame;
        newFrame.origin.y += 41;
        newFrame.size.height -= 41;
        myTable.frame = newFrame;
        
        self._ticketList = array;
        
        if([[self._ticketList._firstFlightInfo objectAtIndex:0] isKindOfClass:[FlightInfo class]])
        {
            FlightInfo * info = [self._ticketList._firstFlightInfo objectAtIndex:0];
            [self.airlineTicketView.clickButton addTarget:self action:@selector(clickTicket:) forControlEvents:UIControlEventTouchUpInside];
            self.airlineTicketView.cellPrice.text =  [NSString stringWithFormat:@"机票最低折扣价 %@元",info._ticketPrice] ;
            self.airlineTicketView.cellCities.text = [NSString stringWithFormat:@"%@ 至 %@",[BookingModel shareBookingModel]._quaryInfo._fromStationName ,[BookingModel shareBookingModel]._quaryInfo._toStationName];
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
    
    NavigationController.viewControllers = [NSArray arrayWithObjects:[NavigationController.viewControllers objectAtIndex:0], ticketHomeVC,nil];
    [ticketHomeVC release];
    
    TicketQueryDetailViewController * ticketDetailVC = [[TicketQueryDetailViewController alloc] init];
    ticketDetailVC.title = [NSString stringWithFormat:@"%@-%@",[BookingModel shareBookingModel]._quaryInfo._fromStationName ,[BookingModel shareBookingModel]._quaryInfo._toStationName];
    ticketDetailVC.queryDataModel = self._ticketQuery;
    ticketDetailVC.queryTicket = self._ticketList;
    ticketDetailVC.dataArray = (NSMutableArray *)self._ticketList._firstFlightInfo;
    ticketDetailVC.filterDataArray = (NSMutableArray *) self._ticketList._firstFlightInfo;
    ticketDetailVC.sortArrayBy = PriceAesc;
    [NavigationController pushViewController:ticketDetailVC animated:YES];
    [ticketDetailVC release];
}
- (void)setButtonTypeImage
{
    if (selectButton == 1) {
        if (sortDese) {
            [timeButton setBackgroundImage:[UIImage imageNamed:@"trainStartDown.png"] forState:UIControlStateNormal];
        }
        else {
            [timeButton setBackgroundImage:[UIImage imageNamed:@"trainStatUp.png"] forState:UIControlStateNormal];
        }
    }
    else if (selectButton == 2)
    {
        if (priceDese) {
            [priceButton setBackgroundImage:[UIImage imageNamed:@"trainPriceUp.png"] forState:UIControlStateNormal];
        }
        else {
            [priceButton setBackgroundImage:[UIImage imageNamed:@"trainPriceDown.png"] forState:UIControlStateNormal];
        }
    }
    else if (selectButton == 3)
    {
        if (priceDese) {
            [dateButton setBackgroundImage:[UIImage imageNamed:@"trainDateUp.png"] forState:UIControlStateNormal];
        }
        else {
            [dateButton setBackgroundImage:[UIImage imageNamed:@"trainDateDown.png"] forState:UIControlStateNormal];
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
