//
//  TicketQueryViewController.m
//  FlightProject
//
//  Created by longcd on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TicketQueryViewController.h"
#import "DatePickerViewController.h"
#import "NSDate+convenience.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "DataClass.h"

@interface  TicketQueryCellForFirstSection: UITableViewCell
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

@property (nonatomic,retain)UIView * roundDataView;
@property (nonatomic,retain)UIButton * roundFromDataButton;
@property (nonatomic,retain)UIButton * roundToDataButton;
@property (nonatomic,retain)UISubLabel * roundFromDataOneLabel;
@property (nonatomic,retain)UISubLabel * roundFromDataTwoLabel;
@property (nonatomic,retain)UISubLabel * roundToDataOneLabel;
@property (nonatomic,retain)UISubLabel * roundToDataTwoLabel;

@property (nonatomic,assign) id delegate;
@end

@implementation TicketQueryCellForFirstSection
@synthesize sigleButton,titleImageV,roundButton,fromCityButton,toCityButton,exchangeButton,sigleDataView,roundDataView, sigleDataOneLabel,sigleDataTwoLabel,roundToDataOneLabel,roundToDataTwoLabel,roundFromDataOneLabel,roundFromDataTwoLabel,sigleFromDataButton,roundToDataButton,roundFromDataButton,delegate;
-(void)dealloc
{
    self.sigleButton = nil;
    self.titleImageV = nil;
    self.roundButton = nil;
    self.fromCityButton = nil;
    self.toCityButton = nil;
    self.exchangeButton = nil;
    self.sigleDataView = nil;
    self.roundDataView = nil;
    self.sigleDataOneLabel = nil;
    self.sigleDataTwoLabel = nil;
    self.roundToDataOneLabel = nil;
    self.roundToDataTwoLabel = nil;
    self.roundFromDataOneLabel = nil;
    self.roundFromDataTwoLabel = nil;
    self.sigleFromDataButton = nil;
    self.roundToDataButton = nil;
    self.roundFromDataButton = nil;
    self.delegate = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        self.titleImageV = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 60) image:[UIImage imageNamed:@"TicketQuerySigle.png"]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 60, ViewWidth - 20, 130) image:[UIImage imageNamed:@"TicketQueryCenter.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 180, ViewWidth - 20, 18) image:[UIImage imageNamed:@"TicketQueryShadow.png"]]];
        self.sigleButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 0, ViewWidth/2 - 10, 50) backImage:nil target:self action:@selector(changeModel:)];
        self.roundButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(ViewWidth/2, 0, ViewWidth/2 - 10, 50) backImage:nil target:self action:@selector(changeModel:)];

        [self addSubview:[UISubLabel labelWithTitle:@"出发城市" frame: CGRectMake(20, 60, 120, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        [self addSubview:[UISubLabel labelWithTitle:@"到达城市" frame: CGRectMake(ViewWidth - 140, 60, 120, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        
        self.fromCityButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(20, 80, 110, 40) backImage:nil target:self action:@selector(selectCity:)];
        [self.fromCityButton.titleLabel setFont:FontBlodSize42];
        self.toCityButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(ViewWidth - 133, 80, 110, 40) backImage:nil target:self action:@selector(selectCity:)];
        [self.toCityButton.titleLabel setFont:FontBlodSize42];
        self.exchangeButton = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"TicketQueryChange.png"] frame:CGRectMake((ViewWidth - 54)/2, 71, 54, 54) target:self action:@selector(exchangeCity) ];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 125, ViewWidth - 40, 1) image:[UIImage imageNamed:@"TicketQueryDottedLine.png"]]];
        
        UIView * sigleV = [[UIView alloc] initWithFrame:CGRectMake((ViewWidth - 300)/2, 125, 300, 60)];
        [sigleV addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 20, 28, 28) image:[UIImage imageNamed:@"TicketQueryData.png"]]];
        [sigleV addSubview:[UISubLabel labelWithTitle:@"出发日期" frame: CGRectMake(0, 0, 300, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        self.sigleFromDataButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(100, 20, 100, 40) backImage:nil target:self action:@selector(selectData:)];
        self.sigleDataOneLabel = [UISubLabel labelWithTitle:@"周五09月" frame: CGRectMake(100, 20, 30, 40) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self.sigleDataTwoLabel = [UISubLabel labelWithTitle:@"28" frame: CGRectMake(120, 20, 70, 40) font:FontBlodSize80 color:FontColor333333 alignment:NSTextAlignmentCenter];
        [sigleV addSubview:self.sigleFromDataButton];
        [sigleV addSubview:self.sigleDataOneLabel];
        [sigleV addSubview:self.sigleDataTwoLabel];
        [sigleV addSubview:[UISubLabel labelWithTitle:@"日" frame: CGRectMake(180, 35, 20, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        [sigleV addSubview:[UIImageView ImageViewWithFrame:CGRectMake(280,32,8,14) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
        self.sigleDataView = sigleV;
        [sigleV release];
        
        UIView * roundV = [[UIView alloc] initWithFrame:CGRectMake((ViewWidth - 300)/2, 125, 300, 60)];
        [roundV addSubview:[UISubLabel labelWithTitle:@"出发日期" frame: CGRectMake(10, 0, 120, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        [roundV addSubview:[UISubLabel labelWithTitle:@"返回日期" frame: CGRectMake(170, 0, 120, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        
        self.roundFromDataButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(20, 20, 100, 40) backImage:nil target:self action:@selector(selectData:)];
        self.roundFromDataOneLabel = [UISubLabel labelWithTitle:@"周五09月" frame: CGRectMake(20, 20, 30, 40) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self.roundFromDataTwoLabel = [UISubLabel labelWithTitle:@"28" frame: CGRectMake(40, 20, 70, 40) font:FontBlodSize80 color:FontColor333333 alignment:NSTextAlignmentCenter];
        
        self.roundToDataButton = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:nil frame:CGRectMake(180, 20, 100, 40) backImage:nil target:self action:@selector(selectData:)];
        self.roundToDataOneLabel = [UISubLabel labelWithTitle:@"周五09月" frame: CGRectMake(180, 20, 30, 40) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self.roundToDataTwoLabel = [UISubLabel labelWithTitle:@"30" frame: CGRectMake(200, 20, 70, 40) font:FontBlodSize80 color:FontColor333333 alignment:NSTextAlignmentCenter];
        
        [roundV addSubview:self.roundFromDataButton];
        [roundV addSubview:self.roundToDataButton];
        [roundV addSubview:self.roundFromDataOneLabel];
        [roundV addSubview:self.roundFromDataTwoLabel];
        [roundV addSubview:self.roundToDataOneLabel];
        [roundV addSubview:self.roundToDataTwoLabel];
        [roundV addSubview:[UISubLabel labelWithTitle:@"日" frame: CGRectMake(100, 35, 20, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        [roundV addSubview:[UISubLabel labelWithTitle:@"日" frame: CGRectMake(260, 35, 20, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        
        [roundV addSubview:[UIImageView ImageViewWithFrame:CGRectMake(120,32,8,14) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
        [roundV addSubview:[UIImageView ImageViewWithFrame:CGRectMake(280,32,8,14) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
        self.roundDataView = roundV;
        [roundV release];
        
        [self addSubview:self.titleImageV];
        [self addSubview:self.sigleButton];
        [self addSubview:self.roundButton];
        [self addSubview:self.fromCityButton];
        [self addSubview:self.toCityButton];
        [self addSubview:self.exchangeButton];
        [self addSubview:self.sigleDataView];
       // [self addSubview:self.roundDataView];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(127,93,8,14) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(290,93,8,14) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
        
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
-(void)changeModel:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeModel:)]) {
        [self.delegate performSelector:@selector(changeModel:) withObject:sender];
    }
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

@interface  TicketQueryCellForSectionSection: UITableViewCell
@property (nonatomic,retain)UIButton * firstButton;
@property (nonatomic,retain)UIButton * secondButton;
@end

@implementation TicketQueryCellForSectionSection
@synthesize firstButton,secondButton;
-(void)dealloc
{
    self.firstButton = nil;
    self.secondButton = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.firstButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"TicketQueryHistory.png"] frame:CGRectMake(ViewWidth/2 - 150, 2, 148, 46) font:FontSize28 color:FontColor454545 target:nil action:nil];

        self.secondButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"TicketQueryHistory.png"] frame:CGRectMake(ViewWidth/2 + 2, 2, 148, 46) font:FontSize28 color:FontColor454545 target:nil action:nil];
        [self addSubview:self.firstButton];
        [self addSubview:self.secondButton];
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



@implementation TicketQueryDataModelElem

@synthesize _nameStr,_nameCode,_isUserChoose;
-(void)dealloc
{
    self._nameCode = nil;
    self._nameStr = nil;
    self._isUserChoose = FALSE;
    [super dealloc];
}
+(TicketQueryDataModelElem *)TicketQueryDataModelElemWithStr:(NSString *)str  code:(NSString *)code
{
    TicketQueryDataModelElem * model = [[TicketQueryDataModelElem alloc] init];
    model._nameStr = str;
    model._nameCode = code;
    model._isUserChoose = FALSE;
    return [model autorelease];
}
@end

@implementation TicketQueryDataModel
@synthesize _startDate,_arriveDate,_fromCity,_toCity,_transitCity,_flightType;
-(void)dealloc
{
    self._startDate = nil;
    self._arriveDate = nil;
    self._fromCity = nil;
    self._toCity = nil;
    self._transitCity = nil;

    [super dealloc];
}
@end

@interface TicketQueryViewController ()

@end

@implementation TicketQueryViewController

@synthesize myTable;
@synthesize server, buttonSelect;
//@synthesize connectRequest;
//@synthesize briefInfoRequest;

@synthesize queryDataModel,queryTicket,historyRecord,curentRecord;

-(void)dealloc
{
    self.buttonSelect = nil;
    self.server  = nil;
    self.myTable = nil;
    self.queryDataModel = nil;
    self.queryTicket = nil;
    self.historyRecord = nil;
    self.curentRecord = nil;
    [alertSubView release];
    alertSubView = nil;
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
     self.view.backgroundColor = [UIColor redColor];

    flightType = SingleType;
    animateFinished = YES;
    self.historyRecord = [DataClass selectFromFlight_Search_History];
    self.curentRecord = [NSArray arrayWithObjects:self.queryDataModel._fromCity._nameCode,self.queryDataModel._fromCity._nameStr,self.queryDataModel._toCity._nameCode,self.queryDataModel._toCity._nameStr, nil];
    
    myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44-44) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTable];
    [myTable release];
    
}

-(void)changeModel:(UIButton *)sender
{
    self.queryDataModel._fromCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[self.curentRecord objectAtIndex:1] code:[self.curentRecord objectAtIndex:0] ];
    self.queryDataModel._toCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[self.curentRecord objectAtIndex:3] code:[self.curentRecord objectAtIndex:2] ];
    switch (sender.tag) {
        case 0:
            flightType = SingleType;
            self.queryDataModel._flightType = SingleType;
            break;
        case 1:
            flightType = RoundTypeGo;
            self.queryDataModel._flightType = RoundTypeGo;
            break;   
        default:
            break;
    }
    [self.myTable reloadData];
}

-(void)selectCity:(UIButton *)sender
{
    self.buttonSelect = [NSString stringWithFormat:@"%ld", (long)sender.tag];
    
    NSArray * array =  [DataClass selectFromAirportCityList];
    if ( [GetConfiguration shareGetConfiguration].needUpdateAirportCityInfo || [array count] == 0) {
        GetBasicInfoFromServer *temp = [[GetBasicInfoFromServer alloc] init];
        temp.cityDelegate = self;
        self.server = temp;
        [self.server getAirportCityInfo];
        [temp release];
    }
    else {
        [self didCityInfoResult:array];
    }

    if (sender.tag == 0) {
        currentDataModelElem = self.queryDataModel._fromCity;
    }
    else
    {
        currentDataModelElem = self.queryDataModel._toCity;
    }

}

- (void)didCityInfoResult:(NSArray *)cityArray
{
    CityListViewController * citylistVC = [[CityListViewController alloc] init];
    citylistVC.citysArray = cityArray;
    citylistVC.cityType = AirportCityList;
    citylistVC.delegate = self;
    if ([self.buttonSelect intValue] == 0) {
        currentDataModelElem = self.queryDataModel._fromCity;
        citylistVC.title = @"出发城市";
    }
    else
    {
        currentDataModelElem = self.queryDataModel._toCity;
        citylistVC.title = @"到达城市";
    }
    
    [ NavigationController pushViewController:citylistVC animated:YES];
    [citylistVC release];
}

-(void)didSelectedCityFinshed:(id)city // zxt 20121027 添加  选择完城市的代理方法
{  
    Citys * _city = (Citys *)city;
    currentDataModelElem._nameStr = _city._city_name;
    currentDataModelElem._nameCode = _city._city_code;
    self.curentRecord = [NSArray arrayWithObjects:self.queryDataModel._fromCity._nameCode,self.queryDataModel._fromCity._nameStr,self.queryDataModel._toCity._nameCode,self.queryDataModel._toCity._nameStr, nil];
    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)selectData:(UIButton *)sender
{
    DatePickerViewController *datePickerVC = [[DatePickerViewController alloc] init];
    if (sender.tag < 2) {
        datePickerVC.dateType = StarDate;
	    datePickerVC.pushBackDay = PushBackZeroDay;
    }
    else {
        datePickerVC.dateType = BackDate;
	      datePickerVC.pushBackDay = PushBackTwoDay;
    }
    datePickerVC.allowShowMonths = AllowShowElevenMonths;
    datePickerVC.startDateTicketQueryDataModel = self.queryDataModel._startDate;
    datePickerVC.backDateTicketQueryDataModel= self.queryDataModel._arriveDate;
    [NavigationController pushViewController:datePickerVC animated:YES];
    [datePickerVC release];
}
-(void)exchangeCity
{
    TicketQueryDataModelElem * oneDataModel = self.queryDataModel._fromCity;
    TicketQueryDataModelElem * tempDataModel = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:oneDataModel._nameStr code:oneDataModel._nameCode];
    self.queryDataModel._fromCity = self.queryDataModel._toCity;
    self.queryDataModel._toCity = tempDataModel;
    self.curentRecord = [NSArray arrayWithObjects:self.queryDataModel._fromCity._nameCode,self.queryDataModel._fromCity._nameStr,self.queryDataModel._toCity._nameCode,self.queryDataModel._toCity._nameStr, nil];
    [myTable reloadData];
}

-(void)reloadTableView
{
    self.queryDataModel._flightType = flightType;
    self.queryDataModel._transitCity._nameStr = @"";
    self.queryDataModel._transitCity._nameCode = @"";
     [self.myTable reloadData];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section == 0) {
        return 0;
    }
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString* tempStr = [[NSUserDefaults standardUserDefaults] stringForKey:ticketSearchHistory_ThreeDemain];
    if (!tempStr) {
        tempStr = @"热门航线";
    }
    if ([self.historyRecord count] == 0) {
        return [UISubLabel labelWithTitle:@"" frame: CGRectMake(0, 0, ViewWidth, 30) font:FontSize24 color:FontColor636363 alignment:NSTextAlignmentCenter];
    }
    return [UISubLabel labelWithTitle:tempStr frame: CGRectMake(0, 0, ViewWidth, 30) font:FontSize24 color:FontColor636363 alignment:NSTextAlignmentCenter];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 200;
        }
    }
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    if (section == 0) {
        return 2;
    }
    else {
        if ([self.historyRecord count] == 0) {
            return 0;
        }
        return [self.historyRecord count] /2 + [self.historyRecord count] %2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString * sectionOneIdentifier = @"sectionOneIdentifier";
            TicketQueryCellForFirstSection * cell = [tableView dequeueReusableCellWithIdentifier:sectionOneIdentifier];
            if (cell == nil) {
                cell = [[[TicketQueryCellForFirstSection alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:sectionOneIdentifier] autorelease];
                cell.delegate = self;
            }
            cell.fromCityButton.tag = 0;
            cell.toCityButton.tag = 1;
            depButton = cell.fromCityButton;
            arriveButton = cell.toCityButton;
            if (self.queryDataModel._flightType == SingleType) {
                cell.titleImageV.image = [UIImage imageNamed:@"TicketQuerySigle.png"];
                [cell.roundDataView removeFromSuperview];
                [cell addSubview:cell.sigleDataView];
                TicketQueryDataModelElem * sigleData = self.queryDataModel._startDate;
                cell.sigleDataOneLabel.text = [[sigleData._nameStr componentsSeparatedByString:@"-"] objectAtIndex:0];
                cell.sigleDataTwoLabel.text = [[sigleData._nameStr componentsSeparatedByString:@"-"] objectAtIndex:1];
            }
            else if(self.queryDataModel._flightType == RoundTypeGo) {
                cell.titleImageV.image = [UIImage imageNamed:@"TicketQueryRound.png"];
                [cell.sigleDataView removeFromSuperview];
                [cell addSubview:cell.roundDataView];
                TicketQueryDataModelElem * roundFromData =self.queryDataModel._startDate;
                cell.roundFromDataOneLabel.text = [[roundFromData._nameStr componentsSeparatedByString:@"-"] objectAtIndex:0];
                cell.roundFromDataTwoLabel.text = [[roundFromData._nameStr componentsSeparatedByString:@"-"] objectAtIndex:1];
                TicketQueryDataModelElem * roundToData =self.queryDataModel._arriveDate;
                cell.roundToDataOneLabel.text = [[roundToData._nameStr componentsSeparatedByString:@"-"] objectAtIndex:0];
                cell.roundToDataTwoLabel.text = [[roundToData._nameStr componentsSeparatedByString:@"-"] objectAtIndex:1];
            }
            TicketQueryDataModelElem * fromCity = self.queryDataModel._fromCity;
            TicketQueryDataModelElem * toCity = self.queryDataModel._toCity;
            [cell.fromCityButton setTitle:fromCity._nameStr forState:UIControlStateNormal];
            [cell.toCityButton setTitle:toCity._nameStr forState:UIControlStateNormal];
            return cell ;
        }
        else {
            static NSString * sectionOneSearchIdentifier = @"sectionOneSearchIdentifier";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:sectionOneSearchIdentifier];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionOneSearchIdentifier] autorelease];
                [cell.contentView addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:99 title:nil frame:CGRectMake((ViewWidth - 226)/2, 2, 226, 45) backImage:[UIImage imageNamed:@"WhenRealQuery.png"]  target:self action:@selector(searchTicket:)]];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.backgroundColor = [UIColor clearColor];

            return cell ;
        }
    }
    else {
        static NSString * sectionTwoIdentifier = @"sectionTwoIdentifier";
        TicketQueryCellForSectionSection * cell = [tableView dequeueReusableCellWithIdentifier:sectionTwoIdentifier];
        if (cell == nil) {
            cell = [[[TicketQueryCellForSectionSection alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionTwoIdentifier] autorelease];
            [cell.firstButton addTarget:self action:@selector(searchHistory:) forControlEvents:UIControlEventTouchUpInside];
            [cell.secondButton addTarget:self action:@selector(searchHistory:) forControlEvents:UIControlEventTouchUpInside];
        }
        NSArray * array1 = [self.historyRecord objectAtIndex:indexPath.row*2];
        cell.firstButton.tag = indexPath.row*2;
        [cell.firstButton setTitle:[NSString stringWithFormat:@"%@-%@",[array1 objectAtIndex:1],[array1 objectAtIndex:3]] forState:UIControlStateNormal];
        
        if (([self.historyRecord count] %2 == 1)  && ( indexPath.row == [self.historyRecord count] / 2)) {
            cell.secondButton.hidden = YES;
        }
        else {
            NSArray * array2 = [self.historyRecord objectAtIndex:indexPath.row*2 +1];
            cell.secondButton.tag = indexPath.row*2+1;
            [cell.secondButton setTitle:[NSString stringWithFormat:@"%@-%@",[array2 objectAtIndex:1],[array2 objectAtIndex:3]] forState:UIControlStateNormal];
            cell.secondButton.hidden = NO;
        }
        return cell ;
    }
}
-(void) animateHistory
{
    animateFinished = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationDidStopSelector:@selector(animateFinishedHistory)];
    depButton.frame = CGRectMake(depButton.frame.origin.x, depButton.frame.origin.y-15, depButton.frame.size.width, depButton.frame.size.height);
    arriveButton.frame = CGRectMake(arriveButton.frame.origin.x, arriveButton.frame.origin.y-15, arriveButton.frame.size.width, arriveButton.frame.size.height);
    depButton.alpha = 0;
    arriveButton.alpha = 0;
    [UIView commitAnimations];
}
-(void) animateFinishedHistory
{
    depButton.frame = CGRectMake(depButton.frame.origin.x, depButton.frame.origin.y+30, depButton.frame.size.width, depButton.frame.size.height);
    arriveButton.frame = CGRectMake(arriveButton.frame.origin.x, arriveButton.frame.origin.y+30, arriveButton.frame.size.width, arriveButton.frame.size.height);
    TicketQueryDataModelElem * fromCity = self.queryDataModel._fromCity;
    TicketQueryDataModelElem * toCity = self.queryDataModel._toCity;
    [depButton setTitle:fromCity._nameStr forState:UIControlStateNormal];
    [arriveButton setTitle:toCity._nameStr forState:UIControlStateNormal];
    self.curentRecord = [NSArray arrayWithObjects:self.queryDataModel._fromCity._nameCode,self.queryDataModel._fromCity._nameStr,self.queryDataModel._toCity._nameCode,self.queryDataModel._toCity._nameStr, nil];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5f];
    depButton.frame = CGRectMake(depButton.frame.origin.x, depButton.frame.origin.y-15, depButton.frame.size.width, depButton.frame.size.height);
    arriveButton.frame = CGRectMake(arriveButton.frame.origin.x, arriveButton.frame.origin.y-15, arriveButton.frame.size.width, arriveButton.frame.size.height);
    depButton.alpha = 1;
    arriveButton.alpha = 1;
    [UIView commitAnimations];
    animateFinished = YES;
}
-(void)searchHistory:(UIButton *)sender
{
    if (animateFinished) {
        NSArray * cityArray = [self.historyRecord objectAtIndex:sender.tag];
        self.queryDataModel._fromCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[cityArray objectAtIndex:1] code:[cityArray objectAtIndex:0] ];
        self.queryDataModel._toCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[cityArray objectAtIndex:3] code:[cityArray objectAtIndex:2] ];
        self.queryDataModel._transitCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:@"" code:@""];
        self.queryDataModel._flightType = flightType;
        [self animateHistory];
    }
    //[self searchTicket];
}
-(void)searchTicket:(id)sender
{
//    self.queryDataModel._fromCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[self.curentRecord objectAtIndex:1] code:[self.curentRecord objectAtIndex:0] ];
//    self.queryDataModel._toCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[self.curentRecord objectAtIndex:3] code:[self.curentRecord objectAtIndex:2] ];
    self.queryDataModel._transitCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:@"" code:@""];
    self.queryDataModel._flightType = flightType;
    [self searchTicket];
}

-(void)searchTicket
{
    TicketQueryDataModelElem * dptDataModel = self.queryDataModel._fromCity;
    TicketQueryDataModelElem * dstDataModel = self.queryDataModel._toCity;
    TicketQueryDataModelElem * goDataModel = self.queryDataModel._startDate;
    TicketQueryDataModelElem * backDataModel = self.queryDataModel._arriveDate;
    
    if ([dptDataModel._nameCode isEqualToString: dstDataModel._nameCode]) {
        [UIAlertView alertViewWithMessage:@"出发城市和到达城市相同，请重新选择。" :@"提示"];
        return;
    }
    
    NSString * fType = nil ;
    switch (self.queryDataModel._flightType) {
        case SingleType:
            fType = @"1";
            break;
        case RoundTypeGo :
        case  RoundTypeBack:
            fType = @"1";
            break;
        case ConnectTypeFirst :
        case ConnectTypeSecond:
            fType = @"3";
            break;
        default:
            break;
    }
    
    if (self.queryDataModel._flightType != SingleType && [goDataModel._nameCode compare:backDataModel._nameCode]>0) {
        [UIAlertView alertViewWithMessage:@"出发时间大于到达时间，请重新选择。" :@"提示"];
        return;
    }
    
    if (self.queryDataModel._flightType == SingleType) {
        if (([goDataModel._nameCode compare:activeStartDate] < 0 || [goDataModel._nameCode compare:activeEndDate] > 0) && [ActivityTimerView shareTimerView]._isAactivation) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"不在活动订票时间范围内，没有畅达币赠送，是否继续订票" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 71;
            [alert show];
            [alert release];
            return;
        }
    }
    else {
        if (([goDataModel._nameCode compare:activeStartDate] < 0 || [backDataModel._nameCode compare:activeEndDate] > 0) && [ActivityTimerView shareTimerView]._isAactivation) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"不在活动订票时间范围内，没有畅达币赠送，是否继续订票" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 71;
            [alert show];
            [alert release];
            return;
        }
    }
    
    ASIFormDataRequest * theRequest = [InterfaceClass queryFlightTicketWithDeparture:dptDataModel._nameCode arrival:dstDataModel._nameCode transitCity:self.queryDataModel._transitCity._nameCode startDate:goDataModel._nameCode returnDate:backDataModel._nameCode flightType:fType]; // 暂时写为1
    
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryFlightTicketWithDeparturePaseredResult:) Delegate:self needUserType:Default];

}

-(void)onqueryFlightTicketWithDeparturePaseredResult:(NSDictionary *)resultDic
{
    self.queryTicket= [QueryFlightTicket QueryFlightTicket:resultDic];

    if (self.queryDataModel._flightType == ConnectTypeFirst) {
        if ([queryTicket._firstFlightInfo count]==0) {
            [UIAlertView alertViewWithMessage:@"您查询的航班起飞，或该航线当天无航班，请查询后一天的航班。" :@"提示"];
            return;
        }
        self.curentRecord = [NSArray arrayWithObjects:self.queryDataModel._fromCity._nameCode,self.queryDataModel._fromCity._nameStr,self.queryDataModel._toCity._nameCode,self.queryDataModel._toCity._nameStr, nil];
        
        [DataClass insertIntoFlight_Search_HistoryWithArray:[NSArray arrayWithObjects:[NSArray arrayWithObjects:self.queryDataModel._fromCity._nameCode, self.queryDataModel._fromCity._nameStr,self.queryDataModel._toCity._nameCode,self.queryDataModel._toCity._nameStr,nil], nil]];
        [[NSUserDefaults standardUserDefaults] setObject:@"历史查询航线" forKey:ticketSearchHistory_ThreeDemain];
        self.historyRecord = [DataClass selectFromFlight_Search_History];
        [myTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        
        TicketQueryConnectDetailViewController * ticketDetailVC = [[TicketQueryConnectDetailViewController alloc] init];
        ticketDetailVC.queryTicket = self.queryTicket;
        ticketDetailVC.dataArray = (NSMutableArray *) queryTicket._firstFlightInfo;
        ticketDetailVC.filterDataArray = ticketDetailVC.dataArray;
        ticketDetailVC.queryDataModel = self.queryDataModel;
        ticketDetailVC.title = [NSString stringWithFormat:@"%@-%@",self.queryDataModel._fromCity._nameStr,self.queryDataModel._transitCity._nameStr];
        ticketDetailVC.sortArrayBy = TimeAesc;
        [NavigationController pushViewController:ticketDetailVC animated:YES];
        [ticketDetailVC release];
    }
    else if ([queryTicket._isDirect boolValue]) {

        self.curentRecord = [NSArray arrayWithObjects:self.queryDataModel._fromCity._nameCode,self.queryDataModel._fromCity._nameStr,self.queryDataModel._toCity._nameCode,self.queryDataModel._toCity._nameStr, nil];
        [DataClass insertIntoFlight_Search_HistoryWithArray:[NSArray arrayWithObjects:[NSArray arrayWithObjects:self.queryDataModel._fromCity._nameCode, self.queryDataModel._fromCity._nameStr,self.queryDataModel._toCity._nameCode,self.queryDataModel._toCity._nameStr,nil], nil]];
        [[NSUserDefaults standardUserDefaults] setObject:@"历史查询航线" forKey:ticketSearchHistory_ThreeDemain];
         self.historyRecord = [DataClass selectFromFlight_Search_History];       
        [myTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        
        TicketQueryDetailViewController * ticketDetailVC = nil;
        if (self.queryDataModel._flightType == SingleType) {
            ticketDetailVC = [[TicketQueryDetailViewController alloc] init];
        }
        else {
             ticketDetailVC = [[TicketQueryRoundDetailViewController alloc] init];
        }
        ticketDetailVC.queryTicket = self.queryTicket;
        ticketDetailVC.dataArray = (NSMutableArray *)self.queryTicket._firstFlightInfo;
        ticketDetailVC.filterDataArray = ticketDetailVC.dataArray;
        ticketDetailVC.queryDataModel = self.queryDataModel;
        ticketDetailVC.title = [NSString stringWithFormat:@"%@-%@",self.queryDataModel._fromCity._nameStr,self.queryDataModel._toCity._nameStr];
        ticketDetailVC.sortArrayBy = TimeAesc;
        [NavigationController pushViewController:ticketDetailVC animated:YES];
        [ticketDetailVC release];
    }
    else { 
        if ([queryTicket._transitCity count]>0) {
            alertSubView = [[UIAlertSubView alloc] initWithLeftTitle:@"出发城市"  subLeftTitle:self.queryDataModel._fromCity._nameStr centerTitle:@"中转城市" subCenterTitles:queryTicket._transitCity rightTitle:@"到达城市" subRightTitle:self.queryDataModel._toCity._nameStr frame:CGRectMake(0, 0, ViewWidth, 568) ];
            alertSubView.delegate = self;
            [alertSubView showWaitView];
        }
    }
}
-(void) sureButtonClick:(TransitCity * )city
{
    NSLog(@"%@,%@",city._name,city._code);
    self.queryDataModel._transitCity._nameCode = city._code;
    self.queryDataModel._transitCity._nameStr = city._name;
    self.queryDataModel._flightType = ConnectTypeFirst;
    [self searchTicket];
}
-(void)cancelButtonClick
{
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[ActivityTimerView shareTimerView] hiddenTimerView];
        [[ActivityTimerView shareTimerView] stopTimerView];
        [self searchTicket];
    }
}
@end
