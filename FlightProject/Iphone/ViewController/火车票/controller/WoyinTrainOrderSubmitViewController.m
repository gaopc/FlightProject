//
//  WoyinTrainOrderSubmitViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 15-6-4.
//
//

#import "WoyinTrainOrderSubmitViewController.h"
#import "KeyBoardTopBar.h"
#import "WoyinPassagerListViewController.h"
#import "WoyinAddPassagerViewController.h"
#import "TrainContactsTableViewCell.h"
#import "TrainModel.h"
#import "WoyinOrderPayViewController.h"
#import "PassengersAddressViewController.h"
#import "PassengerInfoDataResponse.h"
#import "TrainContactsViewController.h"


@interface WoyinOrderTrainCell : UITableViewCell

@property (nonatomic, retain) UISubLabel *_trainNumberLab;
@property (nonatomic, retain) UISubLabel *_startDateLab;
@property (nonatomic, retain) UISubLabel *_fromCityLab;
@property (nonatomic, retain) UISubLabel *_toCityLab;
@property (nonatomic, retain) UISubLabel *_fromTimeLab;
@property (nonatomic, retain) UISubLabel *_toTimeLab;

@end

@implementation WoyinOrderTrainCell

@synthesize _toCityLab,_fromCityLab,_fromTimeLab,_startDateLab,_toTimeLab,_trainNumberLab;
- (void)dealloc
{
    self._toCityLab = nil;
    self._fromCityLab = nil;
    self._fromTimeLab = nil;
    self._startDateLab = nil;
    self._toTimeLab = nil;
    self._trainNumberLab = nil;
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self._fromCityLab = [UISubLabel labelWithTitle:@"北京" frame:CGRectMake(20, 7, 60, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._fromCityLab.numberOfLines = 1;
        self._toCityLab = [UISubLabel labelWithTitle:@"上海" frame:CGRectMake(80, 7, 260, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._toCityLab.numberOfLines = 1;
        self._fromTimeLab = [UISubLabel labelWithTitle:@"15:25" frame:CGRectMake(20, 27, 60, 20) font:FontSize24 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        self._toTimeLab = [UISubLabel labelWithTitle:@"17:18" frame:CGRectMake(80, 27, 60, 20) font:FontSize24 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        self._startDateLab = [UISubLabel labelWithTitle:@"2012-08-16" frame:CGRectMake((ViewWidth - 75)/2, 27, 75, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self._trainNumberLab = [UISubLabel labelWithTitle:@"D330" frame:CGRectMake(ViewWidth - 120, 27, 100, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentRight];
        
        
        [self addSubview:self._fromCityLab];
        [self addSubview:self._toCityLab];
        [self addSubview:self._fromTimeLab];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(60, 32, 14, 12) image:[UIImage imageNamed:@"指向.png"]]];
        [self addSubview:self._toTimeLab];
        [self addSubview:self._startDateLab];
        [self addSubview:self._trainNumberLab];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(12, 50, ViewWidth - 24, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];

    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@interface WoyinTrainOrderPassengerTitleCell : UITableViewCell
@property (nonatomic,retain) UIButton * _addChildBtn;
@property (nonatomic,retain) UIButton * _addAdultBtn;

@end
@implementation WoyinTrainOrderPassengerTitleCell
@synthesize _addAdultBtn,_addChildBtn;
- (void)dealloc
{
    self._addChildBtn = nil;
    self._addAdultBtn = nil;
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(13,0, ViewWidth - 26, 7) image:[UIImage imageNamed:@"CenterView1.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 1, ViewWidth - 20, 59) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"乘客" frame:CGRectMake(20, 20, ViewWidth - 40, 30) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        
        self._addChildBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"addChild.png"] frame:CGRectMake(65, 20, 112, 30) font:FontSize32 color:FontColor909090 target:nil action:nil];
        [self addSubview: self._addChildBtn];
        
        self._addAdultBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"addAdult.png"] frame:CGRectMake(ViewWidth - 140, 20, 112, 30) font:FontSize32 color:FontColor909090 target:nil action:nil];
        [self addSubview:self._addAdultBtn];
        
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

@end

@interface WoyinTrainOrderPassengersCell : UITableViewCell
//@property (nonatomic,retain) UISubLabel * _labelDescription;
//@property (nonatomic,retain) UISubLabel * _passengerLabel;
//@property (nonatomic,retain) UISubLabel * _passengerNumLabel;
@property (nonatomic,retain) UIImageView * _backGroundImageV;
@property (nonatomic,retain) UISubTextField * _passengerTextField;

@end
@implementation WoyinTrainOrderPassengersCell
//@synthesize _labelDescription;//,_passengerLabel,_passengerNumLabel;
@synthesize _backGroundImageV;
@synthesize _passengerTextField;
-(void)dealloc
{
//    self._labelDescription = nil;
//    self._passengerLabel = nil;
//    self._passengerNumLabel = nil;
    self._backGroundImageV = nil;
    self._passengerTextField = nil;
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 44) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]] ;

        self._passengerTextField = [UISubTextField TextFieldWithFrame:self._backGroundImageV.bounds borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:nil font:FontSize26 fontColor:FontColor333333];
        self._passengerTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"您需要添加乘客" attributes:@{NSForegroundColorAttributeName: FontColorFF6113}];
        self._passengerTextField.background = [UIImage imageNamed:@"输入框.png"];
        [self._passengerTextField textRectForBounds:CGRectMake(5, 0, self._passengerTextField.frame.size.width-20, self._passengerTextField.frame.size.height)];
        [self._passengerTextField placeholderRectForBounds:CGRectMake(5, 0, self._passengerTextField.frame.size.width-20, self._passengerTextField.frame.size.height)];
        self._passengerTextField.rightView = [UIImageView ImageViewWithFrame:CGRectMake(self._passengerTextField.frame.size.width-15, (self._passengerTextField.frame.size.height-10)/2, 7, 10) image:[UIImage imageNamed:@"arrows2.png"]];
        self._passengerTextField.rightViewMode = UITextFieldViewModeAlways;
        [self._passengerTextField rightViewRectForBounds:CGRectMake(self._passengerTextField.frame.size.width-15, (self._passengerTextField.frame.size.height-10)/2, 7, 10)];
        [self addSubview:self._passengerTextField];

    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

@end

@interface WoyinTrainOrderTelephoneCell : UITableViewCell
@property (nonatomic,retain) UISubTextField * _telephoneTextField;
@end
@implementation WoyinTrainOrderTelephoneCell
@synthesize _telephoneTextField;
-(void)dealloc
{
    self._telephoneTextField = nil;
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 70) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 2, ViewWidth - 40, 1) image:[UIImage imageNamed:@"cabinDottedLine.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"联系人" frame:CGRectMake(20, 7, 100, 30) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 40, ViewWidth - 40, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 47, 12, 15) image:[UIImage imageNamed:@"OrderInfoTelephonicon.png"]]];
        [self addSubview:[UILabel labelWithTitle:@"联系方式：" frame:CGRectMake(45, 45, 65, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        
        UISubTextField * textField =  [UISubTextField TextFieldWithFrame:CGRectMake(110, 45, ViewWidth - 130, 20) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"手机号码用于接收车票短信" font:FontSize26];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.textColor = FontColor333333;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self._telephoneTextField = textField;
        [self addSubview:textField];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

@end

@interface WoyinTrainOrderItineraryCell : UITableViewCell
@property (nonatomic,retain) UIButton * _leftButton1;
@property (nonatomic,retain) UIButton * _leftButton2;
@property (nonatomic,retain) UIButton * _mailButton;
@property (nonatomic,retain) UISubLabel * _mailAddressLabel;
@property (nonatomic,retain) UISubLabel * _labelDescription;
@property (nonatomic,retain) UISubTextField * _passengerTextField;

@end

@implementation WoyinTrainOrderItineraryCell
@synthesize _leftButton1,_leftButton2;
@synthesize _mailButton,_mailAddressLabel;
@synthesize _passengerTextField,_labelDescription;
-(void)dealloc
{
    self._leftButton1 = nil;
    self._leftButton2 = nil;
    self._mailButton = nil;
    self._mailAddressLabel = nil;
    self._passengerTextField = nil;
    self._labelDescription = nil;
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.autoresizesSubviews = YES;
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 330+44) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 20, ViewWidth - 40, 1) image:[UIImage imageNamed:@"cabinDottedLine.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 330+44-10, ViewWidth-20, 18) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];

        
//        [self addSubview:[UISubLabel labelWithTitle:@"行程单" frame:CGRectMake(20, 7, 100, 30) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        self._leftButton1 = [UIButton buttonWithTag:0 image:[UIImage imageNamed: @"FilterSingleSelected.png"] title:@"铁旅通关怀服务    ¥10"  imageEdge:UIEdgeInsetsMake(2, 2, 2, 130  - 30 +2)  frame:CGRectMake(20, 40,200, 30) font:FontSize32 color:FontColor333333 target:nil action:nil];
        [self addSubview:self._leftButton1];
        [self addSubview:[UILabel labelWithTitle:@"服务内容包括：意外交通险20万+目的地天气情况及列车时刻信息短信提醒" frame:CGRectMake(25, 70,ViewWidth-50, 50) font:FontSize28 color:[UIColor grayColor] alignment:NSTextAlignmentLeft autoSize:NO]];
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"保险说明" frame:CGRectMake(25, 120,80, 30)  font:FontSize32 color:[UIColor colorWithRed:0x00/255.0f green:0x77/255.0f blue:0xff/255.0f alpha:1] target:self action:@selector(showService)]];
        
        self._leftButton2 = [UIButton buttonWithTag:0 image:[UIImage imageNamed: @"FilterSingleUnSelected.png"] title:@"需要邮寄发票"  imageEdge:UIEdgeInsetsMake(2, 2, 2, 130  - 30 +2)  frame:CGRectMake(20, 150,130, 30) font:FontSize32 color:FontColor333333 target:nil action:nil];
        [self addSubview:self._leftButton2];
        if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
            self._mailButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil backImage:[UIImage imageNamed:[NSString stringWithFormat:@"ItineraryRight1.png"]] frame:CGRectMake(ViewWidth - 140, 150,112, 30) font:FontSize32 color:FontColor333333 target:nil action:nil];
        }
        else {
            self._mailButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil backImage:[UIImage imageNamed:[NSString stringWithFormat:@"ItineraryRight2.png"]] frame:CGRectMake(ViewWidth - 140, 150,112, 30) font:FontSize32 color:FontColor333333 target:nil action:nil];
        }
        
        [self addSubview:self._mailButton];

        [self addSubview:[UILabel labelWithTitle:@"EMS 广东省¥12外省¥20" frame:CGRectMake(25, 180,ViewWidth-50, 30) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft autoSize:NO]];
        [self addSubview:[UILabel labelWithTitle:@"发票内容包含产品服务费，铁旅通关怀服务，快递费，不包含火车票，发票抬头为产品服务费，快递仅用于邮寄发票，火车票请自行在火车站领取" frame:CGRectMake(25, 210,ViewWidth-50, 60) font:FontSize24 color:[UIColor grayColor] alignment:NSTextAlignmentLeft autoSize:NO]];
        
        self._passengerTextField = [UISubTextField TextFieldWithFrame:CGRectMake(20, 270, ViewWidth - 40, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:nil font:FontSize26 fontColor:FontColor333333];
        self._passengerTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"您需要填写发票抬头" attributes:@{NSForegroundColorAttributeName: FontColorFF6113}];
        self._passengerTextField.background = [UIImage imageNamed:@"输入框.png"];
        [self._passengerTextField textRectForBounds:CGRectMake(10, 0, self._passengerTextField.frame.size.width-20, self._passengerTextField.frame.size.height)];
        [self._passengerTextField placeholderRectForBounds:CGRectMake(10, 0, self._passengerTextField.frame.size.width-20, self._passengerTextField.frame.size.height)];

        [self addSubview:self._passengerTextField];

        self._mailAddressLabel = [UISubLabel labelWithTitle:@"北京市朝阳区惠新东街11号紫光发展大厦B2座8层" frame: CGRectMake(25, 270+44,ViewWidth-50, 50) font: FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];

        [self addSubview:self._mailAddressLabel];
        
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}
-(void)showService
{
    [UIAlertView alertViewWithMessage:@"a)	身故保险责任：在保险期间，被保险人以乘客身份乘坐商业营运的火车期间因遭受意外伤害事故，并自事故发生之日起180日内因该事故身故的，保险人按“火车意外伤害保险金额”给付身故保险金，对被保险人的保险责任终止；\nb)	伤残保险责任：在保险期间，被保险人以乘客身份乘坐商业营运的火车期间因遭受意外伤害事故，并自该事故发生之日起180日内因该事故造成合同所附《人身保险伤残评定标准（行业标准）》所列伤残之一，保险人按所列比例乘以“火车意外伤害保险金额”给付伤残保险金；"];
}
@end


@interface WoyinTrainOrderSubmitViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CustomScorllViewDelegate>
{
    UITableView * myTable;
    UITextField * childTextField;
    UITextField * telphoneTextField;
    UITextField * postTitleTextField;
    UITextField * nowTextField;
    BOOL isAddAdult;
    int requestTimes;
}
@property (nonatomic,retain)NSString * _orderId;
@property (nonatomic,retain)NSMutableArray * _textFieldArr;
@property (nonatomic,retain)NSMutableArray * _adultArr;

@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic, retain) PickPersonInfoItem *_contactsItem;
@end

@implementation WoyinTrainOrderSubmitViewController
@synthesize _orderId;
@synthesize keyboardbar,_textFieldArr;
@synthesize _contactsItem;

- (void)dealloc
{
    self._contactsItem = nil;
    self.keyboardbar = nil;
    self._orderId = nil;
    self._textFieldArr = nil;
    [super dealloc];
}
-(void)loadView
{
    [super loadView];
    
    isAddAdult = NO;
    
    childTextField = [UITextField TextFieldWithFrame:CGRectZero borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:nil font:FontSize32 fontColor:FontColor333333];
    [self.view addSubview:childTextField];

    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight  - 50) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.autoresizingMask =UIViewAutoresizingFlexibleHeight;
    [myTable setEditing:YES animated:YES];
    [self.view addSubview:myTable];
    [myTable release];
    
    
    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"TicketQuerySubmitOrder.png"] frame:CGRectMake(62, ViewHeight -44 - 50+6, 175, 38) font:nil color:nil target:self action:@selector(nextStep)]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单填写";
    self._textFieldArr = [NSMutableArray array];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [myTable reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4; // 航班信息、乘机人列表、联系方式、行程单
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {    // 航班信息
        return 1;
    }
    else if (section == 1) {    // 乘机人列表
        return [[BookingModel shareBookingModel]._passageInfoList count]==0?2:[[BookingModel shareBookingModel]._passageInfoList count]+1;
    }
    else if (section == 2) {    //  联系人
        return 2;
    }
    else if (section == 3) {    // 联系方式行程单
        return 1;
    }
    return 0;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }
    else  if (indexPath.section == 1) { // 乘机人
        if (indexPath.row == 0) {
            return 60;
        }
        return 44;
    }
    else if (indexPath.section == 2) { // 联系人
        if (indexPath.row == 0) {
            return 50;
        }
        return 44;
    }
    else if (indexPath.section == 3) {
        return 340+44;
    }
    return 0;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString * identifier = @"identifier1";
        WoyinOrderTrainCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[WoyinOrderTrainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        cell._fromCityLab.text = [BookingModel shareBookingModel]._selectTrain._fromStationName;
        cell._toCityLab.text = [BookingModel shareBookingModel]._selectTrain._toStationName;
        cell._fromTimeLab.text = [BookingModel shareBookingModel]._selectTrain._startTime;
        cell._toTimeLab.text = [BookingModel shareBookingModel]._selectTrain._arriveTime;
        cell._startDateLab.text = [BookingModel shareBookingModel]._quaryInfo._quaryDate._nameCode;
        cell._trainNumberLab.text = [BookingModel shareBookingModel]._selectTrain._trainNumber;

        return cell;
    }
    if (indexPath.section ==1) { // 乘机人
        if (indexPath.row == 0) {
            static NSString * passengerTitleCell = @"passengerTitleCell";
            WoyinTrainOrderPassengerTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:passengerTitleCell];
            if (cell == nil) {
                cell = [[[WoyinTrainOrderPassengerTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:passengerTitleCell] autorelease];
                cell.backgroundColor = [UIColor clearColor];
                [cell._addAdultBtn addTarget:self action:@selector(addAdultBtn) forControlEvents:UIControlEventTouchUpInside];
                [cell._addChildBtn addTarget:self action:@selector(addChildBtn) forControlEvents:UIControlEventTouchUpInside];
            }
            return cell;
        }
        else {
            static NSString * passengersCell = @"passengersCell";
            WoyinTrainOrderPassengersCell * cell = [tableView dequeueReusableCellWithIdentifier:passengersCell];
            if (cell == nil) {
                cell = [[[WoyinTrainOrderPassengersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:passengersCell] autorelease];
                cell.backgroundColor = [UIColor clearColor];
                cell._passengerTextField.delegate = self;
            }
            cell._passengerTextField.tag = indexPath.row-1;
            if ([[BookingModel shareBookingModel]._passageInfoList count ]== 0) {
                cell._passengerTextField.frame = CGRectMake(20, 7, ViewWidth - 40, 30);
                cell._passengerTextField.enabled = NO;
                cell._passengerTextField.text = nil;
            }
            else {
                cell._passengerTextField.enabled = YES;
                cell._passengerTextField.frame = CGRectMake(40, 7, ViewWidth - 60, 30);
                TrainPassagerInfo * info = [[BookingModel shareBookingModel]._passageInfoList objectAtIndex:indexPath.row-1];
                cell._passengerTextField.text = [NSString stringWithFormat:@"%@(%@)%@ %@",[info._passengerType intValue]==1?info._passageName:info._childrenName ,[info._passengerType intValue]==1?@"成人":@"儿童",info._idNo,info._seat._name];
                NSMutableArray * seatNameArr = [NSMutableArray array];
                for (TrainSeats * seat in [BookingModel shareBookingModel]._selectTrain._trainSeats) {
                    [seatNameArr addObject:seat._name];
                }
                CustomScorllView * inputView = [[CustomScorllView alloc] initWithTitle:@"坐席" centerTitles:seatNameArr frame:CGRectMake(0.0f, 0.0f, ViewWidth, 230) selectStr:nil];
                inputView.delegate = self;
                cell._passengerTextField.inputView = inputView;
                if ([self._textFieldArr count]==indexPath.row-1) {
                    [self._textFieldArr addObject:cell._passengerTextField];
                }
                else
                {
                    [self._textFieldArr replaceObjectAtIndex:indexPath.row-1 withObject:cell._passengerTextField];
                }
            }
            return cell;
        }
    }
    else if (indexPath.section == 2) {
        
//        static NSString * telephoneIdentifer = @"telephoneIdentifer";
//        WoyinTrainOrderTelephoneCell * cell = [tableView dequeueReusableCellWithIdentifier:telephoneIdentifer];
//        if (cell == nil) {
//            cell = [[[WoyinTrainOrderTelephoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:telephoneIdentifer] autorelease];
//            cell.backgroundColor = [UIColor clearColor];
//            cell._telephoneTextField.delegate = self;
//            telphoneTextField = cell._telephoneTextField;
//        }
//        cell._telephoneTextField.text = [BookingModel shareBookingModel]._linkmanInfo._telPhone;
//        return cell;
        
        if (indexPath.row == 0) {
            
            static NSString * pickUpPersonTitleCellIdentifier = @"contactsTitleCellIdentifier";
            TrainContactsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:pickUpPersonTitleCellIdentifier];
            if (cell == nil) {
                cell = [[[TrainContactsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pickUpPersonTitleCellIdentifier] autorelease];
                cell.backgroundColor = [UIColor clearColor];
                [cell._addPickUpPerson addTarget:self action:@selector(addContactsPerson:) forControlEvents:UIControlEventTouchUpInside];
            }
            cell._addPickUpPerson.tag = indexPath.row;
            cell._labelDescription.text = @"联系人";
            
            return cell;
        }
        else {
            static NSString * pickUpPersonCellIdentifier = @"contactsPersonCellIdentifier";
            TrainContactsInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:pickUpPersonCellIdentifier];
            if (cell == nil) {
                cell = [[[TrainContactsInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pickUpPersonCellIdentifier] autorelease];
                cell.backgroundColor = [UIColor clearColor];
            }
            
            PickPersonInfoItem * info = self._contactsItem;
            if (info._id.length==0) {
                cell._labelDescription.hidden = NO;
                cell._labelDescription.text = @"您需要添加联系人";
                cell._passengerLabel.text = nil;
                cell._passengerNumLabel.text = nil;
                cell._backGroundImageV.frame = CGRectMake(20, 7, ViewWidth - 40, 30);
            }
            else {
                cell._backGroundImageV.hidden = NO;
                cell._labelDescription.hidden = YES;
                cell._backGroundImageV.frame = CGRectMake(40, 7, ViewWidth - 60, 30);
                cell._passengerLabel.text = [NSString stringWithFormat:@"%@", info._name];
                cell._passengerNumLabel.text = [NSString stringWithFormat:@"%@", info._phone];
            }
            return cell;
        }
    }
    else if (indexPath.section == 3) { // 行程单
        static NSString * ItineraryIdentifer = @"ItineraryIdentifer";
        WoyinTrainOrderItineraryCell * cell = [tableView dequeueReusableCellWithIdentifier:ItineraryIdentifer];
        if (cell == nil) {
            cell = [[[WoyinTrainOrderItineraryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ItineraryIdentifer] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            [cell._leftButton1 addTarget:self action:@selector(insuranceBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell._leftButton2 addTarget:self action:@selector(mailBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell._mailButton addTarget:self action:@selector(selectAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell._passengerTextField.delegate = self;
            postTitleTextField = cell._passengerTextField;
        }
        
        if ([BookingModel shareBookingModel]._ifneedService) {
            [cell._leftButton1 setImage:[UIImage imageNamed: @"FilterSingleSelected.png"] forState:UIControlStateNormal];
        }
        else
        {
            [cell._leftButton1 setImage:[UIImage imageNamed: @"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
        }
        if ([BookingModel shareBookingModel]._ifneedMail) {
            [cell._leftButton2 setImage:[UIImage imageNamed: @"FilterSingleSelected.png"] forState:UIControlStateNormal];
        }
        else
        {
            [cell._leftButton2 setImage:[UIImage imageNamed: @"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
        }
        cell._mailButton.hidden = ![BookingModel shareBookingModel]._ifneedMail ;
        cell._passengerTextField.hidden = ![BookingModel shareBookingModel]._ifneedMail ;
        cell._mailAddressLabel.hidden = ![BookingModel shareBookingModel]._ifneedMail ;
        
        cell._mailAddressLabel.text = [BookingModel shareBookingModel]._mailInfo._address;
        cell._passengerTextField.text = [BookingModel shareBookingModel]._mailInfo._title;
        return cell;
    }
    return nil;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
    
    return @"删除";
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row !=0) {
            if ([[BookingModel shareBookingModel]._passageInfoList count] ==0) {
                return NO;
            }
            return YES;
        }
    }
    else if (indexPath.section == 2) {
        if (indexPath.row !=0) {
            if ([BookingModel shareBookingModel]._linkmanInfo._telPhone.length < 11) {
                return NO;
            }
            return YES;
        }
    }
    return NO;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 1) {
            if ([[BookingModel shareBookingModel]._passageInfoList count]>0) {
                TrainPassagerInfo * info = [[BookingModel shareBookingModel]._passageInfoList objectAtIndex:indexPath.row-1];
                if ([info._passengerType intValue]==1) {
                    self._adultArr = [NSMutableArray array];
                    for (TrainPassagerInfo * info in [BookingModel shareBookingModel]._passageInfoList) {
                        if ([info._passengerType intValue] == 1) {
                            [self._adultArr addObject:info];
                        }
                    }
                    for (TrainPassagerInfo * adult in self._adultArr) {
                        if ([adult._idNo isEqualToString:info._idNo]) {
                            [self._adultArr removeObject:adult];
                            break;
                        }
                    }
                    [[BookingModel shareBookingModel]._passageInfoList removeAllObjects];
                    [self._textFieldArr removeAllObjects];
                    for (TrainPassagerInfo * adult in self._adultArr) {
                        [[BookingModel shareBookingModel]._passageInfoList addObject:adult];
                        for (TrainPassagerInfo * child in adult._childs) {
                            [[BookingModel shareBookingModel]._passageInfoList addObject:child];
                        }
                    }
                }
                else
                {
                    [[BookingModel shareBookingModel]._passageInfoList removeObject:info];
                    [self._textFieldArr removeObjectAtIndex:indexPath.row-1];
                }
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
//                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath index], nil] withRowAnimation:UITableViewRowAnimationFade]
            }
//            if ([tableView numberOfRowsInSection:1] >2) {
//                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
//            }
//            else {
//                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:1], nil] withRowAnimation:UITableViewRowAnimationFade];
//            }
        }
        else if (indexPath.section == 2) {
            [BookingModel shareBookingModel]._linkmanInfo._telPhone = nil;
            [BookingModel shareBookingModel]._linkmanInfo._linkmanName = nil;
            self._contactsItem = nil;
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}
-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__FUNCTION__);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    nowTextField = textField;
    NSMutableArray * mArr = [NSMutableArray arrayWithArray:self._textFieldArr];
//    [mArr addObject:telphoneTextField];
    if (postTitleTextField.hidden==NO) {
        [mArr addObject:postTitleTextField];
    }

    if (self.keyboardbar == nil) {
        KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:mArr view:self.view ];
        self.keyboardbar = _keyboardbar;
        [_keyboardbar release];
    }else {
        [self.keyboardbar setTextFields:mArr];
    }
    [keyboardbar showBar:textField];  //显示工具条
    
    return TRUE;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == telphoneTextField) {
        [BookingModel shareBookingModel]._linkmanInfo._telPhone = textField.text;
    }
    else if (textField == postTitleTextField) {
        [BookingModel shareBookingModel]._mailInfo._title = postTitleTextField.text;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger textFieldStrLength = textFieldStr.length;
    int textFieldMaxLenth = 10000;
    
    if (textField == telphoneTextField) {
        textFieldMaxLenth = 11;
    }
    if (textField == postTitleTextField) {
        textFieldMaxLenth = 100;
    }
    
    if(textFieldStrLength >= textFieldMaxLenth)
    {
        textField.text = [textFieldStr substringToIndex:textFieldMaxLenth];
        return NO;
    }
    else {
        return YES;
    }
}

-(void)sureButtonClickWithIndex:(CustomScorllView*)sender
{
    [nowTextField resignFirstResponder];
    [keyboardbar HiddenKeyBoard];
    if (nowTextField == childTextField) {
        
        TrainPassagerInfo * info = [self._adultArr objectAtIndex:sender.selectedRow];
        
        WoyinAddPassagerViewController *trainVC = [[WoyinAddPassagerViewController alloc] init];
        trainVC._viewType = @"2";
        trainVC._delegate = self;
        trainVC._isEdit = YES;
        trainVC._passagerData = info;
        [NavigationController pushViewController:trainVC animated:YES];
        [trainVC release];
    }
    else
    {
        TrainPassagerInfo * pInfo = [[BookingModel shareBookingModel]._passageInfoList objectAtIndex:nowTextField.tag];
        pInfo._seat = [[BookingModel shareBookingModel]._selectTrain._trainSeats objectAtIndex:sender.selectedRow];
    }
    [myTable reloadData];
}

- (void)addChildrenName:(id)sender
{
    [myTable reloadData];
}


-(void)cancelButtonClick
{
    [nowTextField resignFirstResponder];
    [keyboardbar HiddenKeyBoard];
}

-(void)addAdultBtn
{
//    if ([BookingModel shareBookingModel]._passageInfoList.count==5) {
//        [UIAlertView alertViewWithMessage:@"最多只能订5人"];
//        return;
//    }
//    WoyinAddPassagerViewController *trainVC = [[WoyinAddPassagerViewController alloc] init];
//    [NavigationController pushViewController:trainVC animated:YES];
//    [trainVC release];
    
    
    WoyinPassagerListViewController *trainVC = [[WoyinPassagerListViewController alloc] init];
    [NavigationController pushViewController:trainVC animated:YES];
    [trainVC release];
}
-(void)addChildBtn
{
    if ([BookingModel shareBookingModel]._passageInfoList.count==5) {
        [UIAlertView alertViewWithMessage:@"最多只能订5人"];
        return;
    }
    self._adultArr = [NSMutableArray array];
    for (TrainPassagerInfo * info in [BookingModel shareBookingModel]._passageInfoList) {
        if ([info._passengerType intValue] == 1) {
            [self._adultArr addObject:info];
        }
    }
    if ([BookingModel shareBookingModel]._passageInfoList.count) {
        NSMutableArray * mArr = [NSMutableArray array];
        for (TrainPassagerInfo * info in self._adultArr) {
            [mArr addObject:[NSString stringWithFormat:@"%@",info._passageName]];
        }
        CustomScorllView * input = [[CustomScorllView alloc] initWithTitle:@"" centerTitles:mArr frame:CGRectMake(0.0f, 0.0f, ViewWidth, 230.0f) selectStr:nil];
        input.delegate = self;
        childTextField.inputView = input;
        [childTextField becomeFirstResponder];
        nowTextField = childTextField;
    }
    else
    {
        [UIAlertView alertViewWithMessage:@"儿童票需要使用随行成人的成人票证件信息，请先添加成人"];
    }
}

-(void)insuranceBtn:(UIButton *)sender
{
    if (sender.tag == 0) {
        [BookingModel shareBookingModel]._ifneedService = NO;
    }
    else if (sender.tag == 1)
    {
        [BookingModel shareBookingModel]._ifneedService = YES;
    }
    sender.tag = (sender.tag+1)%2;
    [myTable reloadData];

}
-(void)mailBtn:(UIButton *)sender
{
    if (sender.tag == 0) {
        [BookingModel shareBookingModel]._ifneedMail = YES;
    }
    else if (sender.tag == 1)
    {
        [BookingModel shareBookingModel]._ifneedMail = NO;
    }
    sender.tag = (sender.tag+1)%2;
    [myTable reloadData];
}
-(void)selectAddressBtn:(UIButton *)sender
{
    PassengersAddressViewController *passAddressVC = [[PassengersAddressViewController alloc] init];
    passAddressVC.sourceType = 0;
    [self.navigationController pushViewController:passAddressVC animated:YES];
    [passAddressVC release];
}
-(void)nextStep
{
    if ([[BookingModel shareBookingModel]._passageInfoList count]==0) {
        [UIAlertView alertViewWithMessage:@"请添加乘客" tag:0 delegate:nil];
        return;
    }
    else
    {
        BOOL isNotHasAdult = TRUE;
        for (TrainPassagerInfo * info in [BookingModel shareBookingModel]._passageInfoList) {
            if ([info._passengerType intValue]==1) {
                isNotHasAdult = FALSE;
            }
        }
        if (isNotHasAdult) {
            [UIAlertView alertViewWithMessage:@"儿童票需要使用随行成人的成人票证件信息，请先添加成人"];
            return;
        }
    }
    if ([[BookingModel shareBookingModel]._linkmanInfo._telPhone length]==0) {
        [UIAlertView alertViewWithMessage:@"请输入联系人手机号码" tag:0 delegate:nil];
        return;
    }
    else if(![[BookingModel shareBookingModel]._linkmanInfo._telPhone hasPrefix:@"1"])
    {
        [UIAlertView alertViewWithMessage:@"请输入正确的手机号码" tag:0 delegate:nil];
        return;
    }
    if ([BookingModel shareBookingModel]._ifneedMail) {
        if ([BookingModel shareBookingModel]._mailInfo._title.length==0) {
            [UIAlertView alertViewWithMessage:@"请填写发票抬头" tag:0 delegate:nil];
            return;
        }
        if ([BookingModel shareBookingModel]._mailInfo._address.length==0) {
            [UIAlertView alertViewWithMessage:@"请选择邮寄地址" tag:0 delegate:nil];
            return;
        }
    }
    TrainPassagerInfo * pInfo = [[BookingModel shareBookingModel]._passageInfoList objectAtIndex:0];
//    [BookingModel shareBookingModel]._linkmanInfo._linkmanName = pInfo._passageName;
    ASIFormDataRequest * theRequest = [InterfaceClass applyForSeat];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onapplyForSeatResult:) Delegate:self needUserType:Default];
}
-(void)onapplyForSeatResult:(NSDictionary *)result
{
    self._orderId = [NSString stringWithFormat:@"%@",[result objectForKey:@"orderId"] ];
    requestTimes = 0;
    
//    WoyinOrderPayViewController *trainVC = [[WoyinOrderPayViewController alloc] init];
//    trainVC._orderItem = [TrainOrderItem TrainOrderPollInfoWithDic:nil];
//    trainVC._orderItem._orderId = self._orderId;
//    [NavigationController pushViewController:trainVC animated:YES];
//    [trainVC release];
    
    [self findOrderPollInfo];
}

-(void)findOrderPollInfo
{
    requestTimes ++ ;
    ASIFormDataRequest * theRequest = [InterfaceClass findOrderPollInfoWithID:self._orderId];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onfindOrderPollInfoResult:) Delegate:self needUserType:Default];
}
-(void)onfindOrderPollInfoResult:(NSDictionary *)result
{
    NSString * statusCode = [NSString stringWithFormat:@"%@",[result objectForKey:@"statusCode"] ];
    NSString * message = [NSString stringWithFormat:@"%@",[result objectForKey:@"message"] ];

    if([statusCode isEqualToString:@"1"]){
        if (requestTimes == 1) {
            sleep(5);
        }
        else if (requestTimes == 2) {
            sleep(3);
        }
        else if (requestTimes < 21)  {
            sleep(2);
        }
        else {
            [UIAlertView alertViewWithMessage:message tag:0 delegate:nil];
            return;
        }
        [self findOrderPollInfo];
    }
    else {
        if ([statusCode isEqualToString:@"0"]) {
            WoyinOrderPayViewController *trainVC = [[WoyinOrderPayViewController alloc] init];
            trainVC._orderItem = [TrainOrderItem TrainOrderPollInfoWithDic:result];
            trainVC._orderItem._orderId = self._orderId;
            [NavigationController pushViewController:trainVC animated:YES];
            [trainVC release];
            [BookingModel dateBack];
        }
        else {
            [UIAlertView alertViewWithMessage:message tag:0 delegate:nil];
        }
    }
}
-(void)backHome
{
    UIAlertView * alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"如果点击返回，你所填写的数据将会被删除，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertV.tag = 99;
    [alertV show];
    [alertV release];
}
-(void)goHome
{
    UIAlertView * alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"如果点击返回主页，你所填写的数据将会被删除，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertV.tag = 100;
    [alertV show];
    [alertV release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 99) {
        if (buttonIndex == 1) {
            [BookingModel dateBackSub];
            [super backHome];
        }
    }
    else if (alertView.tag == 100)
    {
        if (buttonIndex == 1) {
            [BookingModel dateBackSub];
            [super goHome];
        }
    }
}

- (void)addContactsPerson:(UIButton *)sender
{
    PickPersonInfoItem *item = self._contactsItem;
    
    TrainContactsViewController * pickUpPersonListVC = [[TrainContactsViewController alloc] init];
    pickUpPersonListVC._delegate = self;
    pickUpPersonListVC._personData = item;
    [self.navigationController pushViewController:pickUpPersonListVC animated:YES];
    [pickUpPersonListVC release];
}

- (void)selectContacts:(PickPersonInfoItem *)item
{
    [BookingModel shareBookingModel]._linkmanInfo._telPhone = item._phone;
    [BookingModel shareBookingModel]._linkmanInfo._linkmanName = item._name;
    self._contactsItem = item;
    [myTable reloadData];
}
@end
