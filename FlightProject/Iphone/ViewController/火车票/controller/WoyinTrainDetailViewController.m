//
//  WoyinTrainDetailViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 15-6-4.
//
//

#import "WoyinTrainDetailViewController.h"

@interface TrainSectionOneCell : UITableViewCell

@property (nonatomic,retain) UISubLabel * _trainNumber;
@property (nonatomic,retain) UISubLabel * _startDate;
@property (nonatomic,retain) UISubLabel * _runTime;

@property (nonatomic,retain) UISubLabel * _fromCity;
@property (nonatomic,retain) UISubLabel * _toCity;
@property (nonatomic,retain) UISubLabel * _startTime;
@property (nonatomic,retain) UISubLabel * _arrivlTime;

@property (nonatomic,retain) UISubLabel * _service;

@end


@implementation TrainSectionOneCell
@synthesize _trainNumber,_startTime,_runTime,_arrivlTime,_fromCity,_service,_startDate,_toCity;

-(void)dealloc
{
    self._trainNumber = nil;
    self._startTime = nil;
    self._runTime = nil;
    self._arrivlTime = nil;
    self._fromCity = nil;
    self._service = nil;
    self._startDate = nil;
    self._toCity = nil;
    
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self._trainNumber = [UISubLabel labelWithTitle:@"D330" frame:CGRectMake(10, 8, 100, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._startDate = [UISubLabel labelWithTitle:@"2015-05-02" frame:CGRectMake(0, 8, ViewWidth, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self._runTime = [UISubLabel labelWithTitle:@"历时8小时33分钟" frame:CGRectMake(ViewWidth - 105, 6, 100, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 30, 118, 68) image:[UIImage imageNamed:@"cabinWeartherBackground.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 128, 30, 118, 68) image:[UIImage imageNamed:@"cabinWeartherBackground.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake((ViewWidth - 24)/2, 50, 24, 21) image:[UIImage imageNamed:@"cabinArrows.png"]]];
        
        UISubLabel * label1 = [[UISubLabel alloc] initWithFrame:CGRectMake(20, 40, 98, 23) ];
        [label1 setTextAlignment:NSTextAlignmentLeft];
        [label1 setBackgroundColor:[UIColor clearColor]];
        label1.font = FontSize40;
        label1.textColor = FontColor000000;
        label1.minimumScaleFactor = 10;
        label1.adjustsFontSizeToFitWidth = YES;
        label1.highlightedTextColor = [UIColor whiteColor];
        self._fromCity = label1;
        [label1 release];
        UISubLabel * label2 = [[UISubLabel alloc] initWithFrame:CGRectMake(ViewWidth - 120, 40, 98, 23)];
        [label2 setTextAlignment:NSTextAlignmentLeft];
        [label2 setBackgroundColor:[UIColor clearColor]];
        label2.font = FontSize40;
        label2.textColor = FontColor000000;
        label2.minimumScaleFactor = 10;
        label2.adjustsFontSizeToFitWidth = YES;
        label2.highlightedTextColor = [UIColor whiteColor];
        self._toCity = label2;
        [label2 release];
        
        self._fromCity.text = @"北京";
        self._toCity.text = @"乌鲁木齐";
        
        self._startTime = [UISubLabel labelWithTitle:@"15:25" frame:CGRectMake(20, 70, 100, 20) font:FontSize40 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        self._arrivlTime = [UISubLabel labelWithTitle:@"17:25" frame:CGRectMake(ViewWidth - 120, 70, 100, 20) font:FontSize40 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        
        self._service = [UISubLabel labelWithTitle:@"产品服务费：¥5" frame:CGRectMake(10, 100, 150, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._trainNumber];
        [self addSubview:self._startDate];
        [self addSubview:self._runTime];
        [self addSubview:self._fromCity];
        [self addSubview:self._toCity];
        [self addSubview:self._startTime];
        [self addSubview:self._arrivlTime];
        [self addSubview:self._service];
        
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

@interface TrainSectionTwoCell : UITableViewCell

@property (nonatomic,retain) UISubLabel * _seatName;
@property (nonatomic,retain) UISubLabel * _seatPrice;
@property (nonatomic,retain) UISubLabel * _cabinCount;
@property (nonatomic,retain) UIButton * _bookButton;

@end
@implementation TrainSectionTwoCell

@synthesize _bookButton,_cabinCount,_seatName,_seatPrice;

-(void)dealloc
{
    self._bookButton = nil;
    self._cabinCount = nil;
    self._seatName = nil;
    self._seatPrice = nil;
    
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 55) image:[UIImage imageNamed:@"cabinListCell.png"]]];
        self._seatName = [UISubLabel labelWithTitle:@"一等座" frame:CGRectMake(20, 0, 150, 55) font: FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft ];
        
        self._seatPrice = [UISubLabel labelWithTitle:@"138" frame:CGRectMake(100, 0, 150, 55) font:FontBlodSize42 color:FontColorFF8813  alignment:NSTextAlignmentLeft];
        self._cabinCount = [UISubLabel labelWithTitle:@"8张" frame:CGRectMake(210, 0, 50, 55) font:FontSize28 color:FontColorFF8813  alignment:NSTextAlignmentLeft];

        self._bookButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth - 80, 17, 60, 23) backImage:[UIImage imageNamed:@"cabinButton.png"] target:nil action:nil];
        
        [self addSubview:self._seatName];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(90, 30, 6, 7) image:[UIImage imageNamed:@"cabinListRMB.png"]]];
        [self addSubview:self._seatPrice];
        [self addSubview:[UISubLabel labelWithTitle:@"票量:" frame:CGRectMake(175, 0, 60, 55) font:FontSize28 color:[UIColor grayColor] alignment:NSTextAlignmentLeft]];

        [self addSubview:self._cabinCount];
        [self addSubview:self._bookButton];
        
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


@interface WoyinTrainDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * myTable;
}
@end

@implementation WoyinTrainDetailViewController

-(void)loadView
{
    [super loadView];
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"火车票信息";

}
-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 2) {
        return 1;
    }
    return [[BookingModel shareBookingModel]._selectTrain._trainSeats count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 130.0f;
    }
    else  if (indexPath.section == 1){
        return 60.0f;
    }
    return 100.0f;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString * identifierOne = @"identifierOne";
        TrainSectionOneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierOne];
        if (cell== nil) {
            cell = [[[TrainSectionOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierOne] autorelease];
        }
    
        cell._trainNumber.text = [BookingModel shareBookingModel]._selectTrain._trainNumber;
        cell._startDate.text = [BookingModel shareBookingModel]._quaryInfo._quaryDate._nameCode;
        cell._runTime.text = [NSString stringWithFormat:@"历时%d小时%d分",[[[[BookingModel shareBookingModel]._selectTrain._runTime componentsSeparatedByString:@":"] objectAtIndex:0] intValue],[[[[BookingModel shareBookingModel]._selectTrain._runTime componentsSeparatedByString:@":"] objectAtIndex:1] intValue]];
        //[BookingModel shareBookingModel]._selectTrain._runTime;
        cell._startTime.text = [BookingModel shareBookingModel]._selectTrain._startTime;
        cell._arrivlTime.text = [BookingModel shareBookingModel]._selectTrain._arriveTime;
        cell._fromCity.text = [BookingModel shareBookingModel]._selectTrain._fromStationName;
        cell._toCity.text = [BookingModel shareBookingModel]._selectTrain._toStationName;
        cell._service.text = [NSString stringWithFormat:@"产品服务费：¥%@",[BookingModel shareBookingModel]._service._serviceCost];

        return cell;
    }
    else if (indexPath.section == 1){
        static NSString * identifierTwo = @"identifierTwo";
        TrainSectionTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierTwo];
        if (cell== nil) {
            cell = [[[TrainSectionTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierTwo] autorelease];
            [cell._bookButton addTarget:self action:@selector(reserve:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell._bookButton.tag = indexPath.row;
        TrainSeats * seat = [[BookingModel shareBookingModel]._selectTrain._trainSeats objectAtIndex:indexPath.row];
        cell._seatName.text = seat._name;
        cell._seatPrice.text = seat._price;
        cell._cabinCount.text = seat._count;
        if ([[BookingModel shareBookingModel]._selectTrain._canBuyNow boolValue] && (!([seat._count isEqualToString:@"无"]||[seat._count isEqualToString:@"--"])) && ![seat._count isEqualToString:@"0"]) {
            cell._bookButton.enabled = TRUE;
            [cell._bookButton setBackgroundImage:[UIImage imageNamed:@"cabinButton.png"] forState:UIControlStateNormal];
        }
        else
        {
            cell._bookButton.enabled = FALSE;
            [cell._bookButton setBackgroundImage:[UIImage imageNamed:@"预定灰.png"] forState:UIControlStateNormal];
        }
        
        return cell;
    }
    else if (indexPath.section == 2){
        static NSString * Identifier1 = @"Identifier1";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier1];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier1] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:[UILabel labelWithTitle:@"温馨提示：坐席随机出票，卧铺暂收下铺价格\n出票后按实际票价进行支付" frame:CGRectMake(10,0,ViewWidth-40,10) font:[UIFont systemFontOfSize:13] color:[UIColor grayColor] alignment:NSTextAlignmentLeft autoSize:YES]];
        }
        return cell;
    }
    return nil;
}
-(void)reserve:(UIButton *)sender
{
    TrainSeats * seat = [[BookingModel shareBookingModel]._selectTrain._trainSeats objectAtIndex:sender.tag];
    NSLog(@"selectedSeat:%@",seat);
    [BookingModel shareBookingModel]._selectTrain._selectSeat = seat;
    self._VCType = Member;
    if (self.isLogin) {
        [self loginSuccessFul];
    }
}
-(void) loginSuccessFul
{
    [BookingModel shareBookingModel]._userId = [UserInfo sharedUserInfo].userID;
//    [BookingModel shareBookingModel]._linkmanInfo._telPhone = [UserInfo sharedUserInfo].telePhone;

    WoyinTrainOrderSubmitViewController *trainVC = [[WoyinTrainOrderSubmitViewController alloc] init];
    [NavigationController pushViewController:trainVC animated:YES];
    [trainVC release];
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
