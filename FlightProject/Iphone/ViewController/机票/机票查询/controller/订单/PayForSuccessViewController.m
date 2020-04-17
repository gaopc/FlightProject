//
//  CarPayForSuccessViewController.m
//  FlightProject
//
//  Created by admin on 12-10-29.
//
//

#import "PayForSuccessViewController.h"
#import "QueryFlightTicket.h"
#import "OrderCarListViewController.h"

#import "TaxiHomeViewController.h"
#import "HotelHomeViewController.h"
#import "HotelListViewController.h"
#import "TaxiHomeViewController.h"
#import "CarListViewController.h"
#import "MemberOrderViewController.h"
#import "OrderHotelLisViewController.h"
#import "OrderCarListViewController.h"
#import "CarInformationViewController.h"
#import "HotelInformationViewController.h"
#import "ActivityViewController.h"
#import "HomeActivityDetailViewController.h"
#import "WoyinOrderDetailViewController.h"
#import "WoyinTrainQureyViewController.h"
#import "WoyinOrderListViewController.h"


@interface PayForSuccessViewController ()

@end

@implementation PayForSuccessViewController
@synthesize _ticketList,_hotelList,_carList;
@synthesize _recommendsecRow,_recommendfirstRow;
@synthesize _hotelQuery,_ticketQuery,_carQuery;
@synthesize _firstInstance,_seconInstance;
@synthesize _whoPaySuccess;
@synthesize _message,_messageTitle,_hotelQueryDataResponse,_orderId;
@synthesize _CAFlight;
@synthesize _retainLcdNum, _actitySecond;
@synthesize _trainData;

- (void)dealloc
{
    self._trainData = nil;
    [recommend release];
    self._hotelList = nil;
    self._ticketList = nil;
    self._recommendfirstRow = nil;
    self._recommendsecRow = nil;
    self._carList = nil;
    self._hotelQuery = nil;
    self._ticketQuery = nil;
    self._carQuery = nil;
    self._firstInstance = nil;
    self._seconInstance = nil;
    self._message = nil;
    self._messageTitle = nil;
    self._hotelQueryDataResponse = nil;
    self._retainLcdNum = nil;
    self._actitySecond = nil;
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
//-(void)set_message:(NSString *)message
//{
//    if (!message) {
//        
//    }
//    if (_message != message) {
//        [_message release];
//        _message = nil;
//        _message = [message retain];
//        [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}
//-(void)set_messageTitle:(NSString *)messageTitle
//{
//    if (_messageTitle != messageTitle) {
//        [_messageTitle release];
//        _messageTitle = nil;
//        _messageTitle = [messageTitle retain];
//        [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"订单完成";
    UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 0, 52, 30) backImage:nil target:nil action:nil];
    UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44-5) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.allowsSelection = YES;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
    
    if(self._whoPaySuccess == Ticket)
    {
        self._pointView._pointLab.tag -= 1;
    }
    
    self._firstInstance = nil;
    self._seconInstance = nil;
    
    recommend = [[RecommendClass alloc ] init];
    recommend.delegate = self;
    if (self._ticketQuery) {
        [recommend recommendFlightWithDeparture:self._ticketQuery._fromCity._nameCode withArrival:@"" withStartDate:self._ticketQuery._startDate._nameCode];
    }
    if (self._hotelQuery) {
        [recommend recommendHotelWithCityName:self._hotelQuery._fromCity._nameCode withCheckInDate:self._hotelQuery._startDate._nameCode];
    }
    if (self._carQuery) {
        [recommend recommendCarWithCityCode:self._carQuery._cityCode withFromDate:self._carQuery._fromDate withToDate:self._carQuery._toDate];
    }
}

-(void) recommendHotelSucessful:(HotelQueryDataResponse *)response
{
    if (response) {
        self._hotelList = response._hotelQueryInfoArray;
        self._hotelQueryDataResponse = response;
    }
    [self reloadMyTableView];
}
-(void) recommendTicketSucessful:(QueryFlightTicket *)array
{
    if (array._firstFlightInfo) {
        NSString * arrayCity = array._arrivalCity;
        NSString * arrayCityCode = [DataClass selectFromAirportCityListWithCityName:arrayCity];
        self._ticketQuery._toCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: arrayCity code:arrayCityCode ];
        self._ticketList = array;
    }
    [self reloadMyTableView];
}
-(void) recommendCarSucessful:(NSArray *)array
{
    if (array) {
        QueryCarModelResponse * carInfo = [array objectAtIndex:0];
        self._carQuery._storeCode = carInfo._storeCode;
        self._carQuery._toStoreCode = carInfo._storeCode;
        self._carQuery._storeCodeDsc = carInfo._shopName;
        self._carQuery._toStoreCodeDsc = carInfo._shopName;
        
        NSArray * fromDateArray = [[self._carQuery._fromDate stringByReplacingOccurrencesOfString:@"-" withString:@" "] componentsSeparatedByString:@" "];
        self._carQuery._fromDateDsc = [NSString stringWithFormat:@"%@月%@日 %@",[fromDateArray objectAtIndex:1],[fromDateArray objectAtIndex:2],[fromDateArray objectAtIndex:3]] ;
        
        NSArray * toDateArray = [[self._carQuery._toDate stringByReplacingOccurrencesOfString:@"-" withString:@" "] componentsSeparatedByString:@" "];
        self._carQuery._toDateDsc = [NSString stringWithFormat:@"%@月%@日 %@",[toDateArray objectAtIndex:1] ,[toDateArray objectAtIndex:2],[toDateArray objectAtIndex:3]] ;
        
        self._carList = array;
    }
    [self reloadMyTableView];
}

-(void)reloadMyTableView
{
    switch (self._whoPaySuccess) {
        case Ticket:
            self._recommendfirstRow = self._carList;
            self._recommendsecRow = self._hotelList;
            break;
        case Hotel:
            self._recommendfirstRow = self._carList;
            self._recommendsecRow = self._ticketList._firstFlightInfo;
            break;
        case Car:
            self._recommendfirstRow = self._hotelList;
            self._recommendsecRow = self._ticketList._firstFlightInfo;
            break;
        case Train:
            self._recommendfirstRow = self._carList;
            self._recommendsecRow = self._hotelList;
            break;
        default:
            break;
    }
    
    self._firstInstance = [self._recommendfirstRow objectAtIndex:0];
    self._seconInstance = [self._recommendsecRow objectAtIndex:0];
    [myTable reloadData];
}


#pragma mark - Table view dataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 170;
    }
    else if (indexPath.row == 1){
        if (self._CAFlight) {
            return 110;
        }
        else {
            return 60;
        }
    }
    else if (indexPath.row == 2){
        return 23;
    }
    else
        return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self._firstInstance) {
        if (self._seconInstance) {
            return 5;
        }
        else {
            return 4;
        }
        return 4;
    }
    else if (self._seconInstance) {
        return 4;
    }
    else {
        return 2;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        static NSString * identifier0CarPayForSuccessCell = @"identifier0CarPayForSuccessCell";
        OrderPayForSuccessCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier0CarPayForSuccessCell];
        if (cell == nil)
        {
            cell = [[[OrderPayForSuccessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0CarPayForSuccessCell] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        CGSize suggestedSize = [self._message sizeWithFont:FontSize24 constrainedToSize:CGSizeMake(tableView.frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        CGRect rect = cell._message.frame;
        rect.size.height = suggestedSize.height+20;
        cell._message.frame = rect;
        
        cell._message.text = self._message;
        cell._messageTitle.text = self._messageTitle;
        
        if (self._isActivity) {
            
            if ([self._actitySecond intValue] < 60) {
                cell._shareActBtn.hidden = NO;
                cell._activityLab.hidden = NO;
                [cell._shareActBtn addTarget:self action:@selector(shareActity) forControlEvents:UIControlEventTouchUpInside];
                cell._activityLab.text = [NSString stringWithFormat:@"恭喜您，总计用时%@秒，多赚%@个畅达币！", self._actitySecond, self._retainLcdNum];
            }
            else {
                cell._shareActBtn.hidden = YES;
                cell._activityLab.hidden = NO;
                cell._activityLab.text = @"很可惜，总计用时超过60秒，没有获得畅达币";
            }
        }
        else {
            cell._shareActBtn.hidden = YES;
            cell._activityLab.hidden = YES;
        }
        
        return cell;
    }
    else if (indexPath.row == 1)
    {
        static NSString * identifier1CarPayForSuccessCell = @"identifier1CarPayForSuccessCell";
        OrderPayForSuccess1Cell * cell = [tableView dequeueReusableCellWithIdentifier:identifier1CarPayForSuccessCell];
        if (cell == nil)
        {
            cell = [[[OrderPayForSuccess1Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1CarPayForSuccessCell] autorelease];
            [cell.leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.fullButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.caButton addTarget:self action:@selector(caClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (self._whoPaySuccess == Train) {
                [cell.leftButton setTitle:@"购买返程" forState:UIControlStateNormal];
            }
        }
        
        if (self._CAFlight) {
            cell.caButton.hidden = NO;
        }
        else {
            cell.caButton.hidden = YES;
        }
        
        
        if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
//            cell.rightButton.hidden = YES;
//            cell.leftButton.hidden = YES;
//            cell.fullButton.hidden = NO;
        }
        return cell;
    }
    else if (indexPath.row == 2)
    {
        static NSString * identifier2CarPayForSuccessCell = @"identifier2CarPayForSuccessCell";
        OrderPayForSuccess2Cell * cell = [tableView dequeueReusableCellWithIdentifier:identifier2CarPayForSuccessCell];
        if (cell == nil)
        {
            cell = [[[OrderPayForSuccess2Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2CarPayForSuccessCell] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if (indexPath.row == 3)
    {
        if (self._firstInstance) {
            static NSString * identifier30CarPayForSuccessCell = @"identifier30CarPayForSuccessCell";
            OrderPayForSuccess3Cell * cell = [tableView dequeueReusableCellWithIdentifier:identifier30CarPayForSuccessCell];
            if (cell == nil)
            {
                cell = [[[OrderPayForSuccess3Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier30CarPayForSuccessCell] autorelease];
                cell.cellLine.Hidden = TRUE;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if ([self._firstInstance isKindOfClass:[HotelInfo class]]) {
                [cell.clickButton addTarget:self action:@selector(clickHotel:) forControlEvents:UIControlEventTouchUpInside];
                HotelInfo * info = self._firstInstance;
                cell.cellTitle.text = info._hotelName;
                cell.cellPrice.text = [NSString stringWithFormat:@"%.0f元/天",info._lowestPrice];
                cell.cellStore.text = @"";
                cell.cellAddress.text = info._address;
                cell.titleImage.urlString = info._picUrl;
            }
            else if ([self._firstInstance isKindOfClass:[QueryCarModelResponse class]]) 
            {
                [cell.clickButton addTarget:self action:@selector(clickCar:) forControlEvents:UIControlEventTouchUpInside];
                QueryCarModelResponse * carInfo = self._firstInstance;
                cell.cellTitle.text = carInfo._typeName;
                cell.cellPrice.text = [NSString stringWithFormat:@"%@元/天", carInfo._dayPrice];
                cell.cellStore.text = carInfo._shopName;
                cell.cellAddress.text = carInfo._shopAddress;
                cell.titleImage.urlString = carInfo._picUrl;
            }
            return cell;
        }
        else {
            if ([self._seconInstance isKindOfClass:[FlightInfo class]]) {
                static NSString * identifier31CarPayForSuccessCell = @"identifier31CarPayForSuccessCell";
                OrderPayForTicketCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier31CarPayForSuccessCell];
                if (cell == nil)
                {
                    cell = [[[OrderPayForTicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier31CarPayForSuccessCell] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                [cell.clickButton addTarget:self action:@selector(clickTicket:) forControlEvents:UIControlEventTouchUpInside];
                FlightInfo * info = self._seconInstance;
                cell.cellView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[info._flightNo substringToIndex:2]]];
                cell.cellTitle.text = [NSString stringWithFormat:@"%@%@",info._airline,info._flightNo];
                cell.celldate.text = [info._startDate substringToIndex:10];
                cell.cellCities.text = [NSString stringWithFormat:@"%@-%@",self._ticketQuery._fromCity._nameStr ,self._ticketQuery._toCity._nameStr];
                cell.cellPrice.text = [NSString stringWithFormat:@"单程%@元",info._ticketPrice] ;
                return cell;
            }
            else if ([self._seconInstance isKindOfClass:[HotelInfo class]]) {
                static NSString * identifier32CarPayForSuccessCell = @"identifier32CarPayForSuccessCell";
                OrderPayForSuccess3Cell * cell = [tableView dequeueReusableCellWithIdentifier:identifier32CarPayForSuccessCell];
                if (cell == nil)
                {
                    cell = [[[OrderPayForSuccess3Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier32CarPayForSuccessCell] autorelease];
                    cell.cellLine.Hidden = TRUE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                [cell.clickButton addTarget:self action:@selector(clickHotel:) forControlEvents:UIControlEventTouchUpInside];
                HotelInfo * info = self._seconInstance;
                cell.cellTitle.text = info._hotelName;
                cell.cellPrice.text = [NSString stringWithFormat:@"%.0f元/天",info._lowestPrice];
                cell.cellStore.text = @"";
                cell.cellAddress.text = info._address;
                cell.titleImage.urlString = info._picUrl;
                return cell;
            }
        }
               
    }
    else {
        if ([self._seconInstance isKindOfClass:[FlightInfo class]]) {
            static NSString * identifier31CarPayForSuccessCell = @"identifier31CarPayForSuccessCell";
            OrderPayForTicketCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier31CarPayForSuccessCell];
            if (cell == nil)
            {
                cell = [[[OrderPayForTicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier31CarPayForSuccessCell] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell.clickButton addTarget:self action:@selector(clickTicket:) forControlEvents:UIControlEventTouchUpInside];
            FlightInfo * info = self._seconInstance;
            cell.cellView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[info._flightNo substringToIndex:2]]];
            cell.cellTitle.text = [NSString stringWithFormat:@"%@%@",info._airline,info._flightNo];
            cell.celldate.text = [info._startDate substringToIndex:10];
            cell.cellCities.text = [NSString stringWithFormat:@"%@-%@",self._ticketQuery._fromCity._nameStr ,self._ticketQuery._toCity._nameStr];
            cell.cellPrice.text = [NSString stringWithFormat:@"单程%@元",info._ticketPrice] ;
            return cell;
        }
        else if ([self._seconInstance isKindOfClass:[HotelInfo class]]) {
            static NSString * identifier32CarPayForSuccessCell = @"identifier32CarPayForSuccessCell";
            OrderPayForSuccess3Cell * cell = [tableView dequeueReusableCellWithIdentifier:identifier32CarPayForSuccessCell];
            if (cell == nil)
            {
                cell = [[[OrderPayForSuccess3Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier32CarPayForSuccessCell] autorelease];
                cell.cellLine.Hidden = TRUE;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell.clickButton addTarget:self action:@selector(clickHotel:) forControlEvents:UIControlEventTouchUpInside];
            HotelInfo * info = self._seconInstance;
            cell.cellTitle.text = info._hotelName;
            cell.cellPrice.text = [NSString stringWithFormat:@"%.0f元/天",info._lowestPrice];
            cell.cellStore.text = @"";
            cell.cellAddress.text = info._address;
            cell.titleImage.urlString = info._picUrl;
            return cell;
        }
    }
    return nil;
}

#pragma mark - UIButton click
- (void)caClick:(id)sender
{
    NSLog(@"国航“凤凰知音”");
    ZhiYinCardViewController *zhiYin = [[ZhiYinCardViewController alloc] init];
    [NavigationController pushViewController:zhiYin animated:YES];
    [zhiYin release];
}

- (void)leftClick:(id)sender
{
    NSLog(@"跳转到查询页！");
    UIViewController * viewController = [[NavigationController.viewControllers objectAtIndex:1] retain];
    NavigationController.viewControllers = [NSArray arrayWithObjects:[NavigationController.viewControllers objectAtIndex:0], nil];
    if ([viewController isKindOfClass:[TicketHomeViewController class]] || [viewController isKindOfClass:[TaxiHomeViewController class]] ||[viewController isKindOfClass:[HotelHomeViewController class]] || [viewController isKindOfClass:[WoyinTrainQureyViewController class]]) {
        
        if (self._whoPaySuccess == Train) {
            WoyinTrainQureyViewController *quaryVC = (WoyinTrainQureyViewController *)viewController;
            [self changeTrainCities];
            quaryVC._isReturn = YES;
        }
        
        [NavigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
    else if ([viewController isKindOfClass:[HomeActivityDetailViewController class]] || [viewController isKindOfClass:[ActivityViewController class]]) {
        UIViewController * viewController1 = [[NavigationController.viewControllers objectAtIndex:2] retain];
        if ([viewController1 isKindOfClass:[TicketHomeViewController class]]) {
            [NavigationController pushViewController:viewController1 animated:YES];
            [viewController1 release];
        }
        else {
            [NavigationController popToRootViewControllerAnimated:YES];
            [viewController1 release];
        }
    }
    else {
        if (self._whoPaySuccess == Train) {            
            WoyinTrainQureyViewController * qureyVC = [[WoyinTrainQureyViewController alloc] init];
            [self changeTrainCities];
            qureyVC._isReturn = YES;
            [NavigationController pushViewController:qureyVC animated:YES];
            [qureyVC release];
        }
        else {
            [NavigationController popToRootViewControllerAnimated:YES];
            [viewController release];
        }
    }
}

- (void)rightClick:(id)sender
{
    
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
        
        NSLog(@"跳转到订单详情！");
        switch (self._whoPaySuccess) {
            case Ticket:
            {
                ASIFormDataRequest * theRequest = [InterfaceClass flightsOrderDetails:self._orderId];
                [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onflightsDetailPaseredResult:) Delegate:self needUserType:Default];
            }
                break;
            case Hotel:
            {
                ASIFormDataRequest * theRequest = [InterfaceClass getHotelOrderById:self._orderId withUserId:[UserInfo sharedUserInfo].userID];
                [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onHotelDetailPaseredResult:) Delegate:self needUserType:Default];
            }
                break;
            case Car:
            {
                ASIFormDataRequest * theRequest = [InterfaceClass orderCarInformationByorderId:self._orderId];
                [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCarDetailPaseredResult:) Delegate:self needUserType:Default];
            }
                break;
            case Train:
            {
                ASIFormDataRequest * theRequest = [InterfaceClass findOrderDetailListWithID:self._orderId];
                [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onTrainDetailPaseredResult:) Delegate:self needUserType:Default];
            }
                break;
            default:
                break;
        }
    }
    else {
    
        NSLog(@"跳转到订单列表！");
        switch (self._whoPaySuccess) {
            case Ticket:
            {
                ASIFormDataRequest * theRequest = [InterfaceClass flightsOrdersList:[UserInfo sharedUserInfo].userID withPageIndex:@"1"];
                [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onflightsOrdersListPaseredResult:) Delegate:self needUserType:Member];
            }
                break;
            case Hotel:
            {
                ASIFormDataRequest * theRequest = [InterfaceClass orderHotelListByUserId:[UserInfo sharedUserInfo].userID withPageIndex:@"1"];
                [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onHotelListPaseredResult:) Delegate:self needUserType:Member];
            }
                break;
            case Car:
            {
                ASIFormDataRequest * theRequest = [InterfaceClass orderCarListByUserId:[UserInfo sharedUserInfo].userID withPageIndex:@"1"];
                [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCarListPaseredResult:) Delegate:self needUserType:Member];
            }
                break;
            case Train:
            {
                NavigationController.viewControllers = [NSArray arrayWithObjects:[NavigationController.viewControllers objectAtIndex:0], nil];
                WoyinOrderListViewController * listVC = [[WoyinOrderListViewController alloc] init];
                [NavigationController pushViewController:listVC animated:YES];
                [listVC release];
            }
                break;
            default:
                break;
        }
    }
}

- (void)onflightsDetailPaseredResult:(NSDictionary *)dic
{
    NavigationController.viewControllers = [NSArray arrayWithObjects:[NavigationController.viewControllers objectAtIndex:0], nil];
    MemberOrderDetailResponse *orderDetailInfo = [MemberOrderDetailResponse setOrderDetail:dic];
    orderDetailInfo._orderId = self._orderId;
    
    MemberOrderStateViewController *orderStateVC = [[MemberOrderStateViewController alloc] init];
    orderStateVC.orderState = orderDetailInfo._state;
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
        orderStateVC._notLoginUser = YES;
    }
    orderStateVC.title = @"已出票订单";
    orderStateVC.orderDataInfo = orderDetailInfo;
    [NavigationController pushViewController:orderStateVC animated:YES];
    [orderStateVC release];
}

- (void)onHotelDetailPaseredResult:(NSDictionary *)dic
{
    NavigationController.viewControllers = [NSArray arrayWithObjects:[NavigationController.viewControllers objectAtIndex:0], nil];
    HotelInformationViewController *hotelInformationVC = [[HotelInformationViewController alloc] init];
    hotelInformationVC._hotelDetailInfo = [HotelModel GetOrderHotelDetail:dic];
    hotelInformationVC._hotelDetailInfo.orderNo = self._orderId;
    [NavigationController pushViewController:hotelInformationVC animated:YES];
    [hotelInformationVC release];
}

- (void)onCarDetailPaseredResult:(NSDictionary *)dic
{
    NavigationController.viewControllers = [NSArray arrayWithObjects:[NavigationController.viewControllers objectAtIndex:0], nil];
    CarInformationViewController *carInformationVC = [[CarInformationViewController alloc] init];
    carInformationVC._carInfoData = [GetOrderCarInformation GetOrderCarInformation:dic];
    carInformationVC._ids = self._orderId;
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
        carInformationVC._notLoginUser = YES;
    }
    [NavigationController pushViewController:carInformationVC animated:YES];
    [carInformationVC release];
}

- (void)onTrainDetailPaseredResult:(NSDictionary *)dic
{
    WoyinOrderDetailViewController *trainVC = [[WoyinOrderDetailViewController alloc] init];
    trainVC._orderItem = [TrainOrderItem TrainOrderDetailIInfoWithDic:dic];
//    trainVC._orderItem._startDate = self._selectOrder._startDate;
    
    [NavigationController pushViewController:trainVC animated:YES];
    [trainVC release];
}

-(void)onflightsOrdersListPaseredResult:(NSDictionary*)dic
{
    NavigationController.viewControllers = [NSArray arrayWithObjects:[NavigationController.viewControllers objectAtIndex:0], nil];
    MemberOrderViewController *memberOrderVC = [[MemberOrderViewController alloc] init];
    memberOrderVC._dataIsFull = YES;
    memberOrderVC.data = (NSMutableArray *)[MemberOrderInfo MemberOrderList:dic];
    memberOrderVC.totalPage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalPage"]];
    if ([memberOrderVC.totalPage intValue] <= 1 || [memberOrderVC.totalPage isEqualToString:@"(null)"]) {
		memberOrderVC.isfromRecomend = TRUE;
	}
    memberOrderVC.filterDataArray =(NSMutableArray *)[MemberOrderInfo MemberOrderList:dic];
    memberOrderVC.pageIndex = 1;
	[NavigationController pushViewController:memberOrderVC animated:YES];
	[memberOrderVC release];
}
-(void)onHotelListPaseredResult:(NSDictionary*)dic
{
    NavigationController.viewControllers = [NSArray arrayWithObjects:[NavigationController.viewControllers objectAtIndex:0], nil];
	OrderHotelLisViewController *hotelLisOrderVC = [[OrderHotelLisViewController alloc] init];
    hotelLisOrderVC._dataIsFull = TRUE;
	hotelLisOrderVC.getOrderHotelList = (GetOrderHotelList*)[GetOrderHotelList GetOrderHotelList:dic];
   	if ([hotelLisOrderVC.getOrderHotelList.totalPage intValue] <= 1 || [hotelLisOrderVC.getOrderHotelList.totalPage isEqualToString:@"(null)"]) {
		hotelLisOrderVC.isfromRecomend = TRUE;
	}
    hotelLisOrderVC.currentHotelList = (GetOrderHotelList*)[GetOrderHotelList GetOrderHotelList:dic];
    hotelLisOrderVC.pageIndex = 1;
	[NavigationController pushViewController:hotelLisOrderVC animated:YES];
	[hotelLisOrderVC release];
}

-(void)onCarListPaseredResult:(NSDictionary*)dic
{
    NavigationController.viewControllers = [NSArray arrayWithObjects:[NavigationController.viewControllers objectAtIndex:0], nil];
	OrderCarListViewController *carListViewController = [[OrderCarListViewController alloc] init];
    carListViewController._dataIsFull = TRUE;
	carListViewController.getOrderCarList = (GetOrderCarList*)[GetOrderCarList GetOrderCarList:dic];
    if([carListViewController.getOrderCarList.totalPage intValue] <= 1 || [carListViewController.getOrderCarList.totalPage isEqualToString:@"(null)"])
    {
		carListViewController.isfromRecomend = TRUE;
	}

    carListViewController.currentCarList = (GetOrderCarList*)[GetOrderCarList GetOrderCarList:dic];
    carListViewController.pageIndex = 1;
	[NavigationController pushViewController:carListViewController animated:YES];
	[carListViewController release];
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
    ticketDetailVC.title = [NSString stringWithFormat:@"%@-%@",self._ticketQuery._fromCity._nameStr,self._ticketQuery._toCity._nameStr];
    ticketDetailVC.queryDataModel = self._ticketQuery;
    ticketDetailVC.queryTicket = self._ticketList;
    ticketDetailVC.dataArray = (NSMutableArray *)self._ticketList._firstFlightInfo;
    ticketDetailVC.filterDataArray = (NSMutableArray *) self._ticketList._firstFlightInfo;
    ticketDetailVC.sortArrayBy = PriceAesc;
    [NavigationController pushViewController:ticketDetailVC animated:YES];
    [ticketDetailVC release];
}

- (void)clickHotel:(id)sender
{
    NSLog(@"跳转到酒店！");
    HotelHomeViewController * hotelHomeVC = [[HotelHomeViewController alloc] init];
    hotelHomeVC.queryDataModel = self._hotelQuery;
    NavigationController.viewControllers = [NSArray arrayWithObjects:[NavigationController.viewControllers objectAtIndex:0], hotelHomeVC,nil];
    [hotelHomeVC release];
    
    HotelListViewController * hotelListVC = [[HotelListViewController alloc] init];
    hotelListVC.queryDataModel = self._hotelQuery;
    hotelListVC.hotelListArray = (NSMutableArray *)self._hotelList;
    hotelListVC.isfromRecomend = YES;
    hotelListVC.lcdRate = self._hotelQueryDataResponse._lcdRate;
    hotelListVC.lcdValue = self._hotelQueryDataResponse._lcdValue;
    [NavigationController pushViewController:hotelListVC animated:YES];
    [hotelListVC release];
    
}
- (void)clickCar:(id)sender
{
    NSLog(@"跳转到租车！");
    TaxiHomeViewController * taxiHomeVC = [[TaxiHomeViewController alloc] init];
    taxiHomeVC.carDataModel = nil;
    taxiHomeVC.queryDataModel = self._carQuery;
    NavigationController.viewControllers = [NSArray arrayWithObjects:[NavigationController.viewControllers objectAtIndex:0],taxiHomeVC, nil];
    [taxiHomeVC release];
    
    CarListViewController * carListVC = [[CarListViewController alloc] init];
    carListVC.queryDataModel = self._carQuery;
    carListVC.carListDataArray = (NSMutableArray *)self._carList;
    carListVC.isfromRecomend = YES;
    [NavigationController pushViewController:carListVC animated:YES];
    [carListVC release];
}

- (void)shareActity
{
    if (IOS8_OR_LATER)
    {
        UIActionSheet *acitonSheet = [[UIActionSheet alloc] initWithTitle:@"好友分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微信", @"朋友圈", nil];
        acitonSheet.tag = 50;
        [acitonSheet showInView:self.view];
        [acitonSheet release];
    }
    else {
        AWActionSheet *sheet = [[AWActionSheet alloc] initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
        sheet.tag = 100;
        [sheet showInView:self.view];
        [sheet release];
    }
}
-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    NSString *wxTitle = @"比拼分享";
    NSString *destDateString = [NSString stringWithFormat:@"我在掌上航旅参加计时返畅达币活动，买机票送了%@块钱，快来看看吧！", self._retainLcdNum];
    NSString *wxUrl = [ActivityTimerView shareTimerView]._activityShareUrl;
    
    switch (index) {
        case 0:
        {
            if ([self isWeChatHave]) {
                [UserInfo sharedUserInfo]._isActivityShare = NO;
                [WeiXinExport sendAppContent:wxTitle withDes:destDateString withImg:[UIImage imageNamed:@"icon.png"] withUrl:wxUrl];
            }
        }
            break;
        case 1:
        {
            if ([self isWeChatHave]) {
                [UserInfo sharedUserInfo]._isActivityShare = NO;
                [WeiXinExport sendAppContentTo:destDateString withDes:destDateString withImg:[UIImage imageNamed:@"icon.png"] withUrl:wxUrl];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 2) {
        [self DidTapOnItemAtIndex:buttonIndex];
    }
}

- (BOOL)isWeChatHave
{
    if (![WXApi isWXAppInstalled]) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:@"您还没有安装微信客户端，请安装后进行分享。点击确定，立即安装。"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"确定",nil];
        [alertView setTag:123];
        [alertView show];
        [alertView release];
        return NO;
    }
    return YES;
}

#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 123) {//微信
        if (buttonIndex == 1) {
            
            NSString *weChatUrl = [WXApi getWXAppInstallUrl];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weChatUrl]];
        }
    }
}

-(int)numberOfItemsInActionSheet
{
    return 2;
}

-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[[AWActionSheetCell alloc] init] autorelease];
    switch (index) {
        case 0:
        {
            cell.iconView.image = [UIImage imageNamed:@"weChat.png"];
            [[cell titleLabel] setText:[NSString stringWithFormat:@"微信"]];
        }
            break;
        case 1:
        {
            cell.iconView.image = [UIImage imageNamed:@"wechatQuan.png"];
            [[cell titleLabel] setText:[NSString stringWithFormat:@"朋友圈"]];
        }
            break;
        default:
            break;
    }
    cell.index = index;
    return cell;
}

- (void)changeTrainCities
{
    [BookingModel shareBookingModel]._quaryInfo._fromStationName = self._trainData._toStation;
    [BookingModel shareBookingModel]._quaryInfo._toStationName = self._trainData._fromStation;
    
    NSArray *trainCityArr = [DataClass selectAllFromTrainCitysList];
    for (TrainCitysList *cityInfo in trainCityArr) {
        if ([cityInfo._city_name isEqualToString:self._trainData._fromStation]) {
            [BookingModel shareBookingModel]._quaryInfo._toStationCode = cityInfo._city_code;
        }
        if ([cityInfo._city_name isEqualToString:self._trainData._toStation]) {
            [BookingModel shareBookingModel]._quaryInfo._fromStationCode = cityInfo._city_code;
        }
    }
    
    NSLog(@"起点：%@ -- %@  终点：%@ -- %@", [BookingModel shareBookingModel]._quaryInfo._fromStationName, [BookingModel shareBookingModel]._quaryInfo._fromStationCode, [BookingModel shareBookingModel]._quaryInfo._toStationName, [BookingModel shareBookingModel]._quaryInfo._toStationCode);
}
@end