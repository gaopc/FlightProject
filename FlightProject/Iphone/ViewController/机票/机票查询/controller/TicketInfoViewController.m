//
//  TicketInfoViewController.m
//  FlightProject
//
//  Created by longcd on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TicketInfoViewController.h"
#import "TicketQueryViewController.h"
#import "TicketOrderInfoViewController.h"
#import "NOMemberLoginViewController.h"
#import "AsyncImageView.h"
#import "AirportWeatherViewController.h"
#import "TicketQueryConnectDetailViewController.h"
#import "TicketQueryRoundDetailViewController.h"

@interface TicketInfoSectionOneCell : UITableViewCell

@property (nonatomic,retain) UIImageView * _companyImageV;
@property (nonatomic,retain) UISubLabel * _flightNo;
@property (nonatomic,retain) UISubLabel * _startDate;
@property (nonatomic,retain) UISubLabel * _flightType;

@property (nonatomic,retain)  AsyncImageView* _fromWearther;
@property (nonatomic,retain) AsyncImageView * _toWearther;
@property (nonatomic,retain) UISubLabel * _fromCity;
@property (nonatomic,retain) UISubLabel * _toCity;
@property (nonatomic,retain) UISubLabel * _startTime;
@property (nonatomic,retain) UISubLabel * _arrivlTime;
@property (nonatomic,retain) UISubLabel * _fromAirport;
@property (nonatomic,retain) UISubLabel * _toAirport;
@property (nonatomic,retain) UISubLabel * _planType;
@property (nonatomic,retain) UISubLabel * _airportFuelTax;

@property (nonatomic,retain) UIButton * _stopCitysButton;

@end


@implementation TicketInfoSectionOneCell
@synthesize _companyImageV,_flightNo,_startDate,_flightType,_fromCity,_fromAirport,_fromWearther,_toCity,_toAirport,_toWearther,_startTime,_arrivlTime,_planType,_airportFuelTax;
@synthesize _stopCitysButton;
-(void)dealloc
{
    self._companyImageV = nil;
    self._flightNo = nil;
    self._startDate = nil;
    self._flightType = nil;
    self._fromCity = nil;
    self._fromAirport = nil;
    self._fromWearther = nil;
    self._toCity = nil;
    self._toAirport = nil;
    self._toWearther = nil;
    self._startTime = nil;
    self._arrivlTime = nil;
    self._planType = nil;
    self._airportFuelTax = nil;
    self._stopCitysButton = nil;

    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self._planType = [UISubLabel labelWithTitle:nil frame:CGRectMake(10, 8, 100, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._companyImageV = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 120, 8, 15, 15)];
        self._flightNo = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 105, 6, 100, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 30, 118, 68) image:[UIImage imageNamed:@"cabinWeartherBackground.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 128, 30, 118, 68) image:[UIImage imageNamed:@"cabinWeartherBackground.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake((ViewWidth - 24)/2, 50, 24, 21) image:[UIImage imageNamed:@"cabinArrows.png"]]];
        
        UISubLabel * label1 = [[UISubLabel alloc] initWithFrame:CGRectMake(20, 35, 60, 23) ];
        [label1 setTextAlignment:NSTextAlignmentLeft];
        [label1 setBackgroundColor:[UIColor clearColor]];
        label1.font = FontSize40;
        label1.textColor = FontColor000000;
        label1.minimumFontSize = 10;
        label1.adjustsFontSizeToFitWidth = YES;
        label1.highlightedTextColor = [UIColor whiteColor];
        self._fromCity = label1;
        [label1 release];
        UISubLabel * label2 = [[UISubLabel alloc] initWithFrame:CGRectMake(ViewWidth - 120, 35, 60, 23)];
        [label2 setTextAlignment:NSTextAlignmentLeft];
        [label2 setBackgroundColor:[UIColor clearColor]];
        label2.font = FontSize40;
        label2.textColor = FontColor000000;
        label2.minimumFontSize = 10;
        label2.adjustsFontSizeToFitWidth = YES;
        label2.highlightedTextColor = [UIColor whiteColor];
        self._toCity = label2;
        [label2 release];
        
        self._startTime = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 60, 100, 20) font:FontSize40 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        self._arrivlTime = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 120, 60, 100, 20) font:FontSize40 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        
        self._fromAirport = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 77, 200, 20) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        self._toAirport = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 120, 77, 200, 20) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        
        AsyncImageView * _sd1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(85, 23 + 10, 40, 40)];
         AsyncImageView * _sd2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(ViewWidth - 60 + 5, 23 + 10, 40, 40)];
        _sd1.tag = 0;
        _sd2.tag = 1;
        self._fromWearther =_sd1;
        self._toWearther = _sd2;
        [_sd1 release];
        [_sd2 release];
        
      self._airportFuelTax = [UISubLabel labelWithTitle:nil frame:CGRectMake(10, 100, 150, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];  
        self._startDate = [UISubLabel labelWithTitle:nil frame:CGRectMake(0, 100, ViewWidth, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self._flightType = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 33, 100, 100, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._stopCitysButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth - 40)/2, 22, 40, 20) backImage:[UIImage imageNamed:@"stopCityImage.png"] target:nil action:nil]; //(148, 50, 24, 21)
        
        [self addSubview:self._companyImageV];
        [self addSubview:self._flightNo];
        [self addSubview:self._startDate];
        [self addSubview:self._flightType];
        [self addSubview:self._fromWearther];
        [self addSubview:self._toWearther];
        [self addSubview:self._fromCity];
        [self addSubview:self._toCity];
        [self addSubview:self._startTime];
        [self addSubview:self._arrivlTime];
        [self addSubview:self._fromAirport];
        [self addSubview:self._toAirport];
        [self addSubview:self._planType];
        [self addSubview:self._airportFuelTax];
        [self addSubview:self._stopCitysButton];
        
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

//@protocol TicketInfoSectionTwoCellDelegate <NSObject>
//
//-(void)lookRule:(UIButton *)sender :(BOOL) _isExtend;
//
//@end

@interface TicketInfoSectionTwoCell : UITableViewCell

@property (nonatomic,retain) UISubLabel * _cabinName;
@property (nonatomic,retain) UISubLabel * _cabinPrice;
@property (nonatomic,retain) UISubLabel * _cabinDiscout;
@property (nonatomic,retain) UISubLabel * _cabinSits;
@property (nonatomic,retain) UISubLabel * _cabinReturnLcdFee;
@property (nonatomic,retain) UIButton * _cabinButton;
@property (nonatomic,retain) UIButton * _cabinRuleButton;

@property (nonatomic,assign) id delegate;

@property (nonatomic,retain) UISubLabel * _cabinRule;

@property (nonatomic,assign) BOOL _isExtend;

@property (nonatomic,retain) UIImageView * _cabinReturnLcdImage;

@property (nonatomic,retain)  UIImageView * _lowerImageV ;


@end
@implementation TicketInfoSectionTwoCell
@synthesize _cabinName,_cabinSits,_cabinPrice,_cabinDiscout,_cabinButton,_cabinRuleButton,_cabinReturnLcdFee;
@synthesize delegate;
@synthesize _cabinRule;
@synthesize _isExtend;
@synthesize _cabinReturnLcdImage;
@synthesize _lowerImageV;

-(void)dealloc
{
    self._cabinName = nil;
    self._cabinSits = nil;
    self._cabinPrice = nil;
    self._cabinDiscout = nil;
    self._cabinButton = nil;
    self._cabinRuleButton = nil;
    self._cabinReturnLcdFee = nil;
    self.delegate = nil;
    self._cabinRule = nil;
    self._cabinReturnLcdImage = nil;
    self._lowerImageV = nil;

    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self._isExtend = FALSE;
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 55) image:[UIImage imageNamed:@"cabinListCell.png"]]];
        self._cabinName = [UISubLabel labelWithTitle:@"" frame:CGRectMake(20, 5, 150, 20) font: FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft ];

        self._cabinPrice = [UISubLabel labelWithTitle:@"" frame:CGRectMake(138, 7, 60, 20) font:FontSize42 color:FontColorFF8813  alignment:NSTextAlignmentLeft];
        self._cabinDiscout = [UISubLabel labelWithTitle:@"" frame:CGRectMake(200, 5, 60, 20) font: FontSize24 color:FontColorFF6113 alignment:NSTextAlignmentLeft];

        self._cabinSits = [UISubLabel labelWithTitle:@"" frame:CGRectMake(160, 37, 30, 15) font: FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        
        self._cabinReturnLcdFee = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth - 190, 34, 100, 20) font: FontSize24 color:FontColorFF6113 alignment:NSTextAlignmentRight];
        self._cabinReturnLcdImage = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 90, 39, 10, 10) image:[UIImage imageNamed:@"cabinCdb.png"] ];
        
        self._cabinButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth - 80, 17, 60, 23) backImage:[UIImage imageNamed:@"cabinButton.png"] target:nil action:nil];
        
        self._lowerImageV = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 31, 0, 20, 20) image:[UIImage imageNamed:@"TicketListLower.png"]];
        
        self._cabinRuleButton = [UIButton buttonWithTag:0 image:[UIImage imageNamed:@"cabinDown.png"] title:@"退改签规则" imageEdge:UIEdgeInsetsMake(6 , 2, 6,  75 - 11) frame:CGRectMake(20, 34, 75, 20) font:FontSize24 color:FontColor333333 target:nil   action:nil];
        self._cabinRule = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 60, self.frame.size.width-40, 40) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._cabinName];
         [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(130, 18, 6, 7) image:[UIImage imageNamed:@"cabinListRMB.png"]]];
        [self addSubview:self._cabinPrice];
        [self addSubview:self._cabinDiscout];
        [self addSubview:self._cabinReturnLcdFee];
        [self addSubview:self._cabinReturnLcdImage];

        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 32, ViewWidth - 108, 1) image:[UIImage imageNamed:@"cabinDottedLine.png"]]];
        [self addSubview:self._cabinRuleButton];
        
        [self addSubview:[UISubLabel labelWithTitle:@"票量:" frame:CGRectMake(130, 34, 60, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft]];  
        
        [self addSubview:self._cabinSits];
        [self addSubview:self._cabinButton];
        
        [self addSubview:self._cabinRule];
        [self addSubview:self._lowerImageV];
        
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)lookRule:(UIButton *)sender
{
//    self._isExtend = !self._isExtend;
//     [sender setImage:[UIImage imageNamed: self._isExtend?@"cabinUp.png":@"cabinDown.png"] forState:UIControlStateNormal] ;
//    if (self.delegate && [self.delegate respondsToSelector:@selector(lookRule::)]) {
//        [self.delegate lookRule:sender:self._isExtend];
//    }
}
@end

@interface TicketInfoViewController ()

@end

@implementation TicketInfoViewController
@synthesize delegate, dataArray,myTable;
@synthesize flightsInfoArray;
@synthesize queryTicket,queryDataModel,selectedCellIndexPath;
@synthesize isExtend;
@synthesize _fromWeather,_toWeather,_selectAirportCode,_selectAirportName;
-(void)dealloc
{

    self.delegate = nil;
    
    self.dataArray = nil;
    self.myTable = nil;
    
    self.flightsInfoArray = nil;
    
    self.queryTicket = nil;
    self.queryDataModel = nil;
    self.selectedCellIndexPath = nil;
    self._toWeather = nil;
    self._fromWeather = nil;
    
    self._selectAirportCode = nil;
    self._selectAirportName = nil;

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
    self.title = @"机票信息";
	// Do any additional setup after loading the view.
    
    UITableView * tempTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44) style:UITableViewStylePlain];
    tempTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    tempTable.backgroundColor = [UIColor clearColor];
    tempTable.dataSource = self;
    tempTable.delegate = self;
    [self.view addSubview:tempTable];
    [tempTable release];
    self.myTable = tempTable;
    
}
-(void)onRulePaseredResult:(NSDictionary *)relustDic
{
    CabinInfo * cabin = [self.queryTicket._cabinInfo objectAtIndex:selectCabinIndex];
    cabin._rule = [NSString stringWithFormat:@"%@",[relustDic objectForKey:@"rule"]];
     self.selectedCellIndexPath= [NSIndexPath indexPathForRow:selectCabinIndex inSection:1];
}
-(void)lookRule:(UIButton *)sender
{
    selectCabinIndex = sender.tag;
    
    if (self.selectedCellIndexPath.row == sender.tag) {
        self.isExtend = !self.isExtend;
    }
    else {
        self.isExtend = YES;
    }
    
    if (self.isExtend) {
        CabinInfo * cabin = [self.queryTicket._cabinInfo objectAtIndex:selectCabinIndex];
        if (!cabin._rule) {
            ASIFormDataRequest * theRequest = [InterfaceClass searchRule:[self.queryTicket._flightNo substringToIndex:2] withCabin: cabin._cabinCode withTime:self.queryTicket._startDate withSpecialFlightNum:cabin._specialFlightNum]; 
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onRulePaseredResult:) Delegate:self needUserType:Default];
        }
        else {
            self.selectedCellIndexPath= [NSIndexPath indexPathForRow:selectCabinIndex inSection:1];
        }
    }
    else {
        self.selectedCellIndexPath= [NSIndexPath indexPathForRow:selectCabinIndex inSection:1];
    }
}
-(void)setSelectedCellIndexPath:(NSIndexPath *)_selectedCellIndexPath
{
    NSMutableArray * IndexPatharray = [NSMutableArray array];
    if (self.selectedCellIndexPath == nil) {
        selectedCellIndexPath = [_selectedCellIndexPath retain];
    }
    else if (self.selectedCellIndexPath.row != _selectedCellIndexPath.row) 
    {
        [IndexPatharray addObject:self.selectedCellIndexPath];
        [selectedCellIndexPath release];
        selectedCellIndexPath = [_selectedCellIndexPath retain];
    }
    if (self.selectedCellIndexPath) {
        [IndexPatharray addObject:self.selectedCellIndexPath];
    }
    [myTable reloadRowsAtIndexPaths:IndexPatharray withRowAnimation:UITableViewRowAnimationFade];
}
-(void)reserve:(UIButton *)sender;
{
    TicketInfoViewController * preVC = [NavigationController.viewControllers objectAtIndex:[NavigationController.viewControllers count] - 3];
    if (![preVC isKindOfClass:[TicketInfoViewController class]]) 
    {
        if ((self.queryDataModel._flightType == RoundTypeBack)) 
        {
            self.queryDataModel._flightType = RoundTypeGo;
        }
        else if ((self.queryDataModel._flightType == ConnectTypeSecond)) 
        {
            self.queryDataModel._flightType = ConnectTypeFirst;
        }
    }

    CabinInfo * cabin = [self.queryTicket._cabinInfo objectAtIndex:sender.tag];
    self.queryTicket._selectedCabin = cabin;
    switch (self.queryDataModel._flightType) {
        case SingleType:
            [self.flightsInfoArray replaceObjectAtIndex:0 withObject:self.queryTicket];
            break;
        case RoundTypeGo:
            [self.flightsInfoArray replaceObjectAtIndex:0 withObject:self.queryTicket];
            TicketQueryRoundDetailViewController * preRdetailVC = [NavigationController.viewControllers objectAtIndex:[NavigationController.viewControllers count] - 2];
            TicketQueryRoundDetailViewController * rdetailVC = [[TicketQueryRoundDetailViewController alloc] init]; 
            rdetailVC.queryDataModel = preRdetailVC.queryDataModel;
            rdetailVC.flightsInfoArray = preRdetailVC.flightsInfoArray;
            rdetailVC.queryDataModel._flightType = RoundTypeBack;
//            if ( [rdetailVC respondsToSelector:@selector(getOtherFlightData)]) {
//                [rdetailVC performSelector:@selector(getOtherFlightData)];
//            }
            [NavigationController pushViewController:rdetailVC animated:YES];
            [rdetailVC release];
            return;
        case RoundTypeBack:
            [self.flightsInfoArray replaceObjectAtIndex:1 withObject:self.queryTicket];
            break;
        case ConnectTypeFirst:
            [self.flightsInfoArray replaceObjectAtIndex:0 withObject:self.queryTicket];
            TicketQueryConnectDetailViewController * predetailVC = [NavigationController.viewControllers objectAtIndex:[NavigationController.viewControllers count] - 2];
            TicketQueryConnectDetailViewController * detailVC = [[TicketQueryConnectDetailViewController alloc] init];
            detailVC.queryTicket = predetailVC.queryTicket;
            detailVC.queryDataModel = predetailVC.queryDataModel;
            detailVC.flightsInfoArray = predetailVC.flightsInfoArray;
            detailVC.queryDataModel._flightType = ConnectTypeSecond;
//            if ( [detailVC respondsToSelector:@selector(getOtherFlightData)]) {
//                    [detailVC performSelector:@selector(getOtherFlightData)];
//            }
            [NavigationController pushViewController:detailVC animated:YES];
            [detailVC release];
            return;
        case ConnectTypeSecond:
            [self.flightsInfoArray replaceObjectAtIndex:1 withObject:self.queryTicket];
            break;
        default:
            break;
    }
    
    self._VCType = DidNoMember;

    if (self.isLogin) {
        [self loginSuccessFul];
    }
    else {
        //        NOMemberLoginViewController  * memberLoginVC = [[NOMemberLoginViewController alloc] init];
        //        memberLoginVC.delegate = self;
        //        [NavigationController pushViewController:memberLoginVC animated:YES];
        //        [memberLoginVC release];	
    }

}
-(void) loginSuccessFul
{
    ASIFormDataRequest * theRequest = nil;

    FlightInfo * firstFlight = [self.flightsInfoArray objectAtIndex:0];
    
    if (self.queryDataModel._flightType == SingleType) {
        theRequest = [InterfaceClass bookingShowMessages:firstFlight._flightNo withCabin:firstFlight._selectedCabin._cabinCode withBaseCabin:firstFlight._selectedCabin._baseCabin withdeparture:self.queryDataModel._fromCity._nameCode withArrival:self.queryDataModel._toCity._nameCode withDepartureDate:firstFlight._startDate withArrivalDate:firstFlight._endTime returnFlightNo:@"" withreturnCabin:@"" withreturnBaseCabin:@"" withreturnDeparture:@"" withreturnArrival:@"" withreturnDepartureDate:@"" withreturnArrivalDate:@""];
    }
    else if(self.queryDataModel._flightType == RoundTypeBack)
    {
        FlightInfo * secondFlight = [self.flightsInfoArray objectAtIndex:1];
        theRequest = [InterfaceClass bookingShowMessages:firstFlight._flightNo withCabin:firstFlight._selectedCabin._cabinCode withBaseCabin:firstFlight._selectedCabin._baseCabin withdeparture:self.queryDataModel._toCity._nameCode withArrival:self.queryDataModel._fromCity._nameCode withDepartureDate:firstFlight._startDate withArrivalDate:firstFlight._endTime returnFlightNo:secondFlight._flightNo withreturnCabin:secondFlight._selectedCabin._cabinCode withreturnBaseCabin:secondFlight._selectedCabin._baseCabin withreturnDeparture:self.queryDataModel._fromCity._nameCode withreturnArrival:self.queryDataModel._toCity._nameCode withreturnDepartureDate:secondFlight._startDate withreturnArrivalDate:secondFlight._endTime];
    }
    else if(self.queryDataModel._flightType == ConnectTypeSecond)
    {
        FlightInfo * secondFlight = [self.flightsInfoArray objectAtIndex:1];
        theRequest = [InterfaceClass bookingShowMessages:firstFlight._flightNo withCabin:firstFlight._selectedCabin._cabinCode withBaseCabin:firstFlight._selectedCabin._baseCabin withdeparture:self.queryDataModel._fromCity._nameCode withArrival:self.queryDataModel._transitCity._nameCode withDepartureDate:firstFlight._startDate withArrivalDate:firstFlight._endTime returnFlightNo:secondFlight._flightNo withreturnCabin:secondFlight._selectedCabin._cabinCode withreturnBaseCabin:secondFlight._selectedCabin._baseCabin withreturnDeparture:self.queryDataModel._transitCity._nameCode withreturnArrival:self.queryDataModel._toCity._nameCode withreturnDepartureDate:secondFlight._startDate withreturnArrivalDate:secondFlight._endTime];
    }
    
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onBookingShowMessages:) Delegate:self needUserType:Default];

}

-(void)onBookingShowMessages:(NSDictionary *)dic
{
    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"statusCode"]] intValue]==0) {
        self.queryTicket._suggestionMsg = [NSString stringWithFormat:@"%@",[dic objectForKey:@"showMessage"]];
    }
    else
    {
        self.queryTicket._suggestionMsg = nil;
    }
    TicketOrderInfoViewController * orderInfoVC = [[TicketOrderInfoViewController alloc] init];
    orderInfoVC.flightsInfoArray = self.flightsInfoArray;
    orderInfoVC.queryDataModel = self.queryDataModel;
    [NavigationController pushViewController:orderInfoVC animated:YES];
    [orderInfoVC release];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return [self.dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 130.0f;
    }
    else  {
        if ([self.selectedCellIndexPath compare:indexPath] == NSOrderedSame && self.isExtend) {
            CabinInfo * cabin = [self.queryTicket._cabinInfo objectAtIndex:indexPath.row];
            CGSize suggestedSize = [cabin._rule sizeWithFont:FontSize24 constrainedToSize:CGSizeMake(tableView.frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            return suggestedSize.height + 100.0f;
        }
    }
    return 60.0f;
}
-(void)showStopCityInfo
{
    NSString * alertStr = nil;
    for (StopCityInfo * info  in self.queryTicket._stopCityInfo) {
        alertStr =  alertStr?[NSString stringWithFormat:@"%@\n%@ %@分钟",alertStr,info._name,info._time]:[NSString stringWithFormat:@"经停城市：%@\n经停时间：%@分钟",info._name,info._time];
    }
    [UIAlertView alertViewWithMessage:alertStr];
}
-(void)onWeatherInfoPaseredResult:(NSDictionary*)dic
{
    if([(NSArray*)[dic objectForKey:@"weatherInfoList"] count] < 7)
    {
        return;
    }
    AirportWeatherViewController *airportWeatherVC = [[AirportWeatherViewController alloc] init];
    airportWeatherVC.queryWeatherInfo = (QueryWeatherInfo*)[QueryWeatherInfo GetQueryWeatherInfoByAirportCode:dic];
    airportWeatherVC.data = [AirportData AirportDataWithName:self._selectAirportName CODE:self._selectAirportCode];
    [NavigationController pushViewController:airportWeatherVC animated:YES];
    [airportWeatherVC release];
}

-(void)showMoreWearth:(AsyncImageView *)sender
{
    if (sender.image)
    {
        self._selectAirportCode = self.queryTicket._startAirportCode;
        self._selectAirportName = self.queryTicket._startAirport;
        if (sender.tag == 1) {
            self._selectAirportCode = self.queryTicket._endAirportCode;
            self._selectAirportName = self.queryTicket._endAirport;
        }
        ASIFormDataRequest * theRequest = [InterfaceClass queryWeatherInfoByAirportCode:self._selectAirportCode];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onWeatherInfoPaseredResult:) Delegate:self needUserType:Default];

    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString * identifierOne = @"identifierOne";
        TicketInfoSectionOneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierOne];
        if (cell== nil) {
            cell = [[[TicketInfoSectionOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierOne] autorelease];
            [cell._fromWearther addTarget:self action:@selector(showMoreWearth:) forControlEvents:UIControlEventTouchUpInside];
            [cell._toWearther addTarget:self action:@selector(showMoreWearth:) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([self.queryTicket._stopNum intValue] > 0) {
            cell._stopCitysButton.hidden = NO;
            [cell._stopCitysButton addTarget:self action:@selector(showStopCityInfo) forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            cell._stopCitysButton.hidden = YES;
        }
        
        TicketQueryDataModelElem * dptDataModel = self.queryDataModel._fromCity;
        TicketQueryDataModelElem * dstDataModel = self.queryDataModel._toCity;
        TicketQueryDataModelElem * goDataModel = self.queryDataModel._startDate;
        //TicketQueryDataModelElem * backDataModel = self.queryDataModel._arriveDate;;
        cell._companyImageV.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[self.queryTicket._flightNo substringToIndex:2]]];
        cell._flightNo.text = [NSString stringWithFormat:@"%@%@",self.queryTicket._airline,self.queryTicket._flightNo];
        cell._startDate.text = goDataModel._nameCode;
        NSString * flightTypeStr = nil ;
        switch (self.queryDataModel._flightType) {
            case SingleType:
                flightTypeStr = @"单程";
                break;
            case RoundTypeGo :
                flightTypeStr = @"往返";
                break;
            case  RoundTypeBack:
                flightTypeStr = @"往返";
                break;
            case ConnectTypeFirst :
                flightTypeStr = @"联程";
                dptDataModel = self.queryDataModel._fromCity;
                dstDataModel = self.queryDataModel._transitCity;
                break;
            case ConnectTypeSecond:
                flightTypeStr = @"联程";
                dptDataModel = self.queryDataModel._transitCity;
                dstDataModel = self.queryDataModel._toCity;
                break;
            default:
                break;
        }
        cell._fromWearther.urlString = self._fromWeather;
        cell._toWearther.urlString = self._toWeather;
        cell._flightType.text = flightTypeStr;
        cell._fromCity.text = dptDataModel._nameStr;
        cell._startTime.text = [self.queryTicket._startDate substringFromIndex:11];
        cell._fromAirport.text = [NSString stringWithFormat:@"%@%@",self.queryTicket._startAirport,self.queryTicket._startTerminal];
        cell._toCity.text = dstDataModel._nameStr;
        cell._arrivlTime.text = [self.queryTicket._endTime substringFromIndex:11];
        cell._toAirport.text = [NSString stringWithFormat:@"%@%@",self.queryTicket._endAirport,self.queryTicket._endTerminal];
        cell._planType.text = [NSString stringWithFormat:@"机型: %@",self.queryTicket._planeType];
        
	    cell._airportFuelTax.text = [NSString stringWithFormat:@"机建/燃油: ¥%@/¥%@",self.queryTicket._airportTaxForAdult,self.queryTicket._fuelTaxForAdult];
        return cell;
    }
    else if (indexPath.section == 1){
        static NSString * identifierTwo = @"identifierTwo";
        TicketInfoSectionTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierTwo];
        if (cell== nil) {
            cell = [[[TicketInfoSectionTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierTwo] autorelease];
            cell.delegate = self;
            [cell._cabinButton addTarget:self action:@selector(reserve:) forControlEvents:UIControlEventTouchUpInside];
            [cell._cabinRuleButton addTarget:self action:@selector(lookRule:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        cell._cabinRuleButton.tag = indexPath.row;
        cell._cabinButton.tag = indexPath.row;
        
        CabinInfo * cabin = [self.queryTicket._cabinInfo objectAtIndex:indexPath.row];
        
//        if ([cabin._ticketCount intValue] == 0) {
//            cell._cabinButton.enabled = NO;
//        }
//        else {
//            cell._cabinButton.enabled = YES;
//        }
        
        if ([cabin._dropFee intValue] >0) {
            cell._lowerImageV.hidden = NO;
        }
        else {
            cell._lowerImageV.hidden = YES;
        }

                
        cell._cabinName.text = [NSString stringWithFormat:@"%@(%@)",cabin._cabinTypeName,cabin._cabinCode];
        cell._cabinPrice.text = cabin._ticketPrice;

        if ([cabin._discount floatValue] < 100) {
            NSString * str = [NSString stringWithFormat:@"%.1f",[cabin._discount floatValue] / 10];
            NSArray * array = [str componentsSeparatedByString:@"."];
            if ([[array objectAtIndex:1] intValue]==0) {
                cell._cabinDiscout.text = [NSString stringWithFormat:@"%.f折",[cabin._discount floatValue] / 10];
            }
            else {
                cell._cabinDiscout.text = [NSString stringWithFormat:@"%.1f折",[cabin._discount floatValue] / 10];
            }

            //cell._cabinDiscout.text = [NSString stringWithFormat:@"%.1f折",[cabin._discount floatValue] / 10];
        }
        else if ([cabin._discount intValue] == 100) {
            cell._cabinDiscout.text = [NSString stringWithFormat:@"全价"];
        }
        else {
            cell._cabinDiscout.text = @"";//[NSString stringWithFormat:@"%.0f%@",[cabin._discount floatValue],@"%"]; //[NSString stringWithFormat:@"%.1f",[cabin._discount floatValue]];
        }

        if ([[cabin._ticketCount substringToIndex:1] isEqualToString:@">"]) {
            cell._cabinSits.text = @"充足";
            //cell._cabinSits.backgroundColor = [UIColor clearColor];
            cell._cabinSits.textColor = FontColor333333;
        }
        else  {
            cell._cabinSits.text = [NSString stringWithFormat:@"%@张",cabin._ticketCount];
            if ([cabin._ticketCount intValue] >3) {
                //cell._cabinSits.backgroundColor = [UIColor clearColor];
                cell._cabinSits.textColor = FontColorFF8813;
            }
           else 
            {
                //cell._cabinSits.backgroundColor = FontColorRed;
                cell._cabinSits.textColor = FontColorRed;
            }
        }

//        cell._cabinReturnLcdFee.text = [NSString stringWithFormat:@"返%3d",[cabin._returnLcdFee intValue]];
//        cell._cabinReturnLcdImage.hidden = NO;
        
        if ([cabin._returnLcdFee intValue] > 0) {
            cell._cabinReturnLcdFee.text = [NSString stringWithFormat:@"返%3d",[cabin._returnLcdFee intValue]];
            cell._cabinReturnLcdImage.hidden = NO;
        }
        else {
            cell._cabinReturnLcdFee.text =@"";
            cell._cabinReturnLcdImage.hidden = YES;
        }
        
        if (self.selectedCellIndexPath.row == indexPath.row && self.isExtend) {
             [cell._cabinRuleButton setImage:[UIImage imageNamed: @"cabinUp.png"] forState:UIControlStateNormal] ;
            
            CGSize suggestedSize = [cabin._rule sizeWithFont:FontSize24 constrainedToSize:CGSizeMake(tableView.frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            CGRect rect = cell._cabinRule.frame;
            rect.size.height = suggestedSize.height+40;
            cell._cabinRule.frame = rect;
            
            cell._cabinRule.text = cabin._rule;
        }
        else {
            [cell._cabinRuleButton setImage:[UIImage imageNamed: @"cabinDown.png"] forState:UIControlStateNormal] ;
            cell._cabinRule.text = @"";
        }

        return cell;
    }
    return nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
