//
//  WoyinTrainQureyViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 15-6-4.
//
//

#import "WoyinTrainQureyViewController.h"
#import "StationsHistoryCell.h"
#import "TrainNumberHistoryCell.h"


@interface  TrainQueryCell: UITableViewCell

@property(nonatomic, retain)UIButton *startStationButton;
@property(nonatomic, retain)UIButton *endStationButton;
@property(nonatomic, retain)UIButton *stationsChange;


@property (nonatomic,retain)UIImageView * titleImageV;
@property (nonatomic,retain)UIButton * sigleButton;
@property (nonatomic,retain)UIButton * roundButton;

@property (nonatomic,retain)UIButton * fromCityButton;
@property (nonatomic,retain)UIButton * toCityButton;
@property (nonatomic,retain)UIButton * exchangeButton;

@property (nonatomic,retain)UIView * sigleDataView;
@property (nonatomic,retain)UIButton * sigleFromDataButton;
@property (nonatomic,retain)UISubLabel * sigleDataOneLabel;
@property (nonatomic,retain)UISubLabel * sigleDataTwoLabel;


@property (nonatomic,assign) id delegate;
@end

@implementation TrainQueryCell
@synthesize sigleButton,titleImageV,roundButton,fromCityButton,toCityButton,exchangeButton,sigleDataView, sigleDataOneLabel,sigleDataTwoLabel,delegate;
@synthesize startStationButton,endStationButton,stationsChange;

-(void)dealloc
{
    self.sigleButton = nil;
    self.titleImageV = nil;
    self.roundButton = nil;
    self.fromCityButton = nil;
    self.toCityButton = nil;
    self.exchangeButton = nil;
    self.sigleDataView = nil;
    self.sigleDataOneLabel = nil;
    self.sigleDataTwoLabel = nil;
    self.sigleFromDataButton = nil;
    self.delegate = nil;
    
    self.startStationButton = nil;
    self.endStationButton = nil;
    self.stationsChange = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth-20, 220) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 230-18, ViewWidth-20, 18) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"出发车站" frame:CGRectMake(8, 3, ViewWidth-15, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-40, 25, 8, 14) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(70, 60, ViewWidth-100, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"到达车站" frame:CGRectMake(8, 63, ViewWidth-15, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        
        self.stationsChange = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"trainChange.png"] frame:CGRectMake(15, 20, 53, 71) target:self action:@selector(exchangeCity)];//53，71
        [self addSubview:stationsChange];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-40, 85, 8, 14) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
        
        self.startStationButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"北京" frame:CGRectMake(70, 18, ViewWidth-130, 40) backImage:nil target:self action:@selector(selectCity:)];
        [self.startStationButton.titleLabel setFont:FontBlodSize48];
        self.endStationButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"上海" frame:CGRectMake(70, 78, ViewWidth-130, 40) backImage:nil target:self action:@selector(selectCity:)];
        [self.endStationButton.titleLabel setFont:FontBlodSize48];
        [self addSubview:self.startStationButton];
        [self addSubview:self.endStationButton];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 120, ViewWidth-40, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        UIView * sigleV = [[UIView alloc] initWithFrame:CGRectMake(10, 125, 300, 60)];
        [sigleV addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 20, 28, 28) image:[UIImage imageNamed:@"TicketQueryData.png"]]];
        [sigleV addSubview:[UISubLabel labelWithTitle:@"出发日期" frame: CGRectMake(0, 0, 300, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        self.sigleFromDataButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(100, 20, 100, 40) backImage:nil target:self action:@selector(selectData:)];
        self.sigleDataOneLabel = [UISubLabel labelWithTitle:@"周五09月" frame: CGRectMake(100, 20, 30, 40) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self.sigleDataTwoLabel = [UISubLabel labelWithTitle:@"28" frame: CGRectMake(120, 20, 70, 40) font:FontBlodSize80 color:FontColor333333 alignment:NSTextAlignmentCenter];
        [sigleV addSubview:self.sigleFromDataButton];
        [sigleV addSubview:self.sigleDataOneLabel];
        [sigleV addSubview:self.sigleDataTwoLabel];
        [sigleV addSubview:[UISubLabel labelWithTitle:@"日" frame: CGRectMake(180, 35, 20, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        [sigleV addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-50, 23, 8, 14) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
        self.sigleDataView = sigleV;
        [sigleV release];
        
        [self addSubview:self.sigleDataView];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 190, ViewWidth-40, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UIButton buttonWithTag:0 image:[UIImage imageNamed: @"FilterSingleUnSelected.png"] title:@"只需高铁/动车"  imageEdge:UIEdgeInsetsMake(2, 2, 2, 130  - 30 +2)  frame:CGRectMake(30, 190,130, 30) font:FontSize32 color:FontColor333333 target:self action:@selector(trainListWithG:)]];

        
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
-(void)trainListWithG:(UIButton *)sender
{
    if (sender.tag == 0) {
        sender.tag = 1;
        [sender setImage:[UIImage imageNamed: @"FilterSingleSelected.png"] forState:UIControlStateNormal];
    }
    else {
        sender.tag = 0;
        [sender setImage:[UIImage imageNamed: @"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
    }
    [BookingModel shareBookingModel]._ifonlyGTrain = sender.tag;
}
-(void)selectCity:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCity:)]) {
        [self.delegate performSelector:@selector(selectCity:) withObject:sender];
    }
}
-(void)selectData:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectData:)]) {
        [self.delegate performSelector:@selector(selectData:) withObject:sender];
    }
}
-(void)exchangeCity
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(exchangeCity)]) {
        [self.delegate performSelector:@selector(exchangeCity)];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@interface WoyinTrainQureyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _h_tableView;
}
@property(nonatomic,assign) NSInteger cityType;

@end

@implementation WoyinTrainQureyViewController
@synthesize cityType;
@synthesize stationsHistory;
-(void)dealloc
{
    self.cityType = 0;
    self.stationsHistory = nil;
    [super dealloc];
}
-(void)loadView
{
    [super loadView];
    _h_tableView = [[UITableView alloc] initWithFrame:CGRectMake(10.0f ,5.0,ViewWidth-20,ViewHeight-44.0f) style:UITableViewStylePlain];
    _h_tableView.backgroundColor = [UIColor clearColor];
    _h_tableView.dataSource = self;
    _h_tableView.delegate = self;
    _h_tableView.showsVerticalScrollIndicator= NO;
    _h_tableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:_h_tableView];
    
    UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, _h_tableView.frame.size.width, 28.0f)];
    [topView setImage:[UIImage imageNamed:@"appointmentFrameTop.png"]];
    _h_tableView.tableHeaderView = topView;
    
    [self findPreSalePeriod];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"列车查询";
    
    if (!self._isReturn) {
        [BookingModel shareBookingModel]._quaryInfo._fromStationName = @"北京";
        [BookingModel shareBookingModel]._quaryInfo._fromStationCode = @"BJP";
        [BookingModel shareBookingModel]._quaryInfo._toStationName = @"上海";
        [BookingModel shareBookingModel]._quaryInfo._toStationCode = @"SHH";
    }
    
    NSString * startDate = [NSDate dateTimeCode:[NSDate date]]; //@"yyyy-MM-dd HH:mm"
    if ([[[[[startDate componentsSeparatedByString:@" "] objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:0] intValue] >=12) {
        [BookingModel shareBookingModel]._quaryInfo._quaryDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[NSDate dateafterDay:[NSDate date] day:1 type:3] code:[NSDate dateafterDay:[NSDate date] day:1 type:1]];
    }
    else{
        [BookingModel shareBookingModel]._quaryInfo._quaryDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[NSDate dateFormateTicketQuery:[NSDate date]] code:[NSDate dateCode:[NSDate date] ]];
    }
    
    self.stationsHistory = [NSArray arrayWithArray:[DataClass selectFromTrain_Search_History]];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.stationsHistory = [NSArray arrayWithArray:[DataClass selectFromTrain_Search_History]];
    [_h_tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section == 0) {
        return 0;
    }
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *str = @"历史查询";
    if ([self.stationsHistory count] == 0) {
        str = @"";
    }
    return [UISubLabel labelWithTitle:str frame: CGRectMake(0, 0, ViewWidth, 30) font:FontSize24 color:FontColor636363 alignment:NSTextAlignmentCenter];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 230;
        }
        if (indexPath.row == 1) {
            if ([BookingModel shareBookingModel]._preSalePeriodDescript==nil) {
                return 0;
            }
        }
    }
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    else {
        return ([self.stationsHistory count]%2)==(0)?([self.stationsHistory count]/2):([self.stationsHistory count]/2+1);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
        {
            static NSString * Identifier0 = @"Identifier0";
            TrainQueryCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier0];
            if (cell == nil) {
                cell = [[[TrainQueryCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier0] autorelease];
                cell.delegate = self;
            }
            [cell.startStationButton setTitle:[BookingModel shareBookingModel]._quaryInfo._fromStationName forState:UIControlStateNormal];
            [cell.endStationButton setTitle:[BookingModel shareBookingModel]._quaryInfo._toStationName forState:UIControlStateNormal];
            cell.sigleDataOneLabel.text = [[[BookingModel shareBookingModel]._quaryInfo._quaryDate._nameStr componentsSeparatedByString:@"-"] objectAtIndex:0];
            cell.sigleDataTwoLabel.text = [[[BookingModel shareBookingModel]._quaryInfo._quaryDate._nameStr componentsSeparatedByString:@"-"] objectAtIndex:1];
            
            return cell;
        }
        else if (indexPath.row == 1)
        {
            static NSString * Identifier1 = @"Identifier1";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier1];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier1] autorelease];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
                UILabel * label = [UILabel labelWithTitle:[BookingModel shareBookingModel]._preSalePeriodDescript frame:CGRectMake(10,0,ViewWidth-40,60) font:[UIFont systemFontOfSize:15] color:[UIColor grayColor] alignment:NSTextAlignmentLeft autoSize:NO];
                label.tag = 99;
                [cell addSubview:label];
            }
            UILabel * label = (UILabel * )[cell viewWithTag:99];
            label.text = [BookingModel shareBookingModel]._preSalePeriodDescript;
            return cell;
        }
        else
        {
            static NSString * Identifier2 = @"Identifier2";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier2];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier2] autorelease];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
                
                [cell addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:99 title:nil frame:CGRectMake((ViewWidth-20 - 226)/2, 2, 226, 45) backImage:[UIImage imageNamed:@"WhenRealQuery.png"]  target:self action:@selector(searchTrain:)]];
            }
            return cell;
        }
    }
    else {
        static NSString *thirdSectionIdentifier2 = @"thirdSectionIdentifier2";
        StationsHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdSectionIdentifier2];
        if(cell == nil){
            cell = [[[StationsHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdSectionIdentifier2] autorelease];
        }
        int thenum = indexPath.row*2;
        
        [cell.leftButton setTitle:[NSString stringWithFormat:@"%@-%@",[[self.stationsHistory objectAtIndex:thenum] objectAtIndex:0],[[self.stationsHistory objectAtIndex:thenum] objectAtIndex:2]] forState:UIControlStateNormal];
        cell.leftButton.tag = thenum;
        [cell.leftButton addTarget:self action:@selector(changeTrainCities:) forControlEvents:UIControlEventTouchUpInside];
        if (!([self.stationsHistory count] % 2 == 1 && [self.stationsHistory count] - thenum == 1)) {
            [cell.rightButton setTitle:[NSString stringWithFormat:@"%@-%@",[[self.stationsHistory objectAtIndex:thenum+1] objectAtIndex:0],[[self.stationsHistory objectAtIndex:thenum+1] objectAtIndex:2]] forState:UIControlStateNormal];
            [cell.rightButton addTarget:self action:@selector(changeTrainCities:) forControlEvents:UIControlEventTouchUpInside];
            cell.rightButton.tag = thenum+1;
            [cell.rightButton setHidden:NO];
        }
        else
        {
            [cell.rightButton setHidden:YES];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)selectCity:(UIButton *)sender
{
    self.cityType = sender.tag;
    NSArray * array =  [DataClass selectFromTrainCitysList];
    if ( [GetConfiguration shareGetConfiguration].needUpdateTrainCitysList || [array count] == 0) {
        GetBasicInfoFromServer *temp = [[GetBasicInfoFromServer alloc] init];
        temp.cityDelegate = self;
        [temp getTrainCitysList];
    }
    else {
        [self didCityInfoResult:array];
    }
}
- (void)didCityInfoResult:(NSArray *)cityArray
{
    CityListViewController * cityListVC = [[CityListViewController alloc] init];
    cityListVC.citysArray = cityArray;
    cityListVC.title = self.cityType==0?@"选择出发":@"选择到达";
    cityListVC.cityType = TrainCityList;
    cityListVC.delegate = self;
    [NavigationController pushViewController:cityListVC animated:YES];
    [cityListVC release];
}
-(void)didSelectedCityFinshed:(id)city // zxt 20121027 添加  选择完城市的代理方法
{
    Citys * _city = (Citys *)city;
    if (self.cityType==0) {
        [BookingModel shareBookingModel]._quaryInfo._fromStationCode =_city._city_code;
        [BookingModel shareBookingModel]._quaryInfo._fromStationName =_city._city_name;
    }
    if (self.cityType==1) {
        [BookingModel shareBookingModel]._quaryInfo._toStationCode =_city._city_code;
        [BookingModel shareBookingModel]._quaryInfo._toStationName =_city._city_name;
    }
    
    [_h_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
}
-(void)selectData:(UIButton *)sender
{
    DatePickerViewController *datePickerVC = [[DatePickerViewController alloc] init];
    datePickerVC.dateType = StarDate;
    datePickerVC.pushBackDay = PushBackZeroDay;
    datePickerVC.allowShowMonths = AllowShowTwoMonths;
    datePickerVC.allowShowDays = [[BookingModel shareBookingModel]._preSalePeriod intValue]-1;
    datePickerVC.startDateTicketQueryDataModel = [BookingModel shareBookingModel]._quaryInfo._quaryDate;
    [NavigationController pushViewController:datePickerVC animated:YES];
    [datePickerVC release];
}
-(void)exchangeCity
{
    NSString *code = [[BookingModel shareBookingModel]._quaryInfo._fromStationCode retain];
    NSString *name = [[BookingModel shareBookingModel]._quaryInfo._fromStationName retain];
    [BookingModel shareBookingModel]._quaryInfo._fromStationCode =[BookingModel shareBookingModel]._quaryInfo._toStationCode;
    [BookingModel shareBookingModel]._quaryInfo._fromStationName = [BookingModel shareBookingModel]._quaryInfo._toStationName;
    [BookingModel shareBookingModel]._quaryInfo._toStationCode =code;
    [BookingModel shareBookingModel]._quaryInfo._toStationName =name;
    [code release];[name release];
    [_h_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];

}

- (void)changeTrainCities:(UIButton *)sender
{
    [BookingModel shareBookingModel]._quaryInfo._fromStationName = [[self.stationsHistory objectAtIndex:sender.tag] objectAtIndex:0];
    [BookingModel shareBookingModel]._quaryInfo._fromStationCode = [[self.stationsHistory objectAtIndex:sender.tag] objectAtIndex:1];
    [BookingModel shareBookingModel]._quaryInfo._toStationName = [[self.stationsHistory objectAtIndex:sender.tag] objectAtIndex:2];
    [BookingModel shareBookingModel]._quaryInfo._toStationCode = [[self.stationsHistory objectAtIndex:sender.tag] objectAtIndex:3];
    [_h_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)searchTrain:(UIButton *)sender
{
    if ([[BookingModel shareBookingModel]._quaryInfo._fromStationCode isEqualToString:[BookingModel shareBookingModel]._quaryInfo._toStationCode]) {
        [UIAlertView alertViewWithMessage:@"出发车站和到达车站相同，请重新选择。" :@"提示"];
        return;
    }
    
    ASIFormDataRequest * theRequest = [InterfaceClass findTrainList];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onfindTrainListResult:) Delegate:self needUserType:Default];
}
-(void)onfindTrainListResult:(NSDictionary *)result
{
    NSArray * trainList = [result objectForKey:@"trainInfos"];
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
    if ([_mArr count]==0) {
        [UIAlertView alertViewWithMessage:@"暂无符合查询条件的车次信息":@"提示"];
        return;
    }
    
    [DataClass insertIntoTrain_Searth_HistoryWithArray:[NSArray arrayWithObjects:[NSArray arrayWithObjects:[BookingModel shareBookingModel]._quaryInfo._fromStationName, [BookingModel shareBookingModel]._quaryInfo._fromStationCode, [BookingModel shareBookingModel]._quaryInfo._toStationName, [BookingModel shareBookingModel]._quaryInfo._toStationCode, nil], nil]];
    
    WoyinTrainListViewController *trainVC = [[WoyinTrainListViewController alloc] init];
    trainVC._dataArrayAll = _mArr;
    [NavigationController pushViewController:trainVC animated:YES];
    [trainVC release];
}
-(void)findPreSalePeriod
{
    ASIFormDataRequest * theRequest = [InterfaceClass findPreSalePeriod];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onfindPreSalePeriodResult:) Delegate:self needUserType:Default];
}
-(void)onfindPreSalePeriodResult:(NSDictionary *)result
{
    [BookingModel shareBookingModel]._preSalePeriod = [NSString stringWithFormat:@"%@",[result objectForKey:@"preSalePeriod"]];
    [BookingModel shareBookingModel]._preSalePeriodDescript = [NSString stringWithFormat:@"%@",[result objectForKey:@"descript"]];
    [_h_tableView reloadData];
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
