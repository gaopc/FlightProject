//
//  MyCustomViewController.m
//  FlightProject
//
//  Created by 晓婷 张 on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TicketOrderInfoViewController.h"
#import "UserInfo.h"
#import "InterfaceClass.h"
#import "DevicePositionMapViewController.h"
#import "EditPassgersInfoViewController.h"
#import "EditPassgersAddressViewController.h"
#import "CustomUISwitch.h"
#import "MyRegex.h"

#import "PickUpPersonListViewController.h"
#import "PickUpPersonDetailViewController.h"

@implementation OrderInfoDataModel

@synthesize _postAddressItem,_contactorPhone,_isAcceptSevice,_isBuyInsurance,_passengerArray,_flightsInfoArray,_getItineraryType,_orderInfo;
@synthesize _adlutCount,_childCount;
@synthesize _pickUpPersonArray;
-(void)dealloc
{
    self._postAddressItem = nil;
    self._contactorPhone = nil;
    self._passengerArray = nil;
    self._flightsInfoArray = nil;
    self._getItineraryType = nil;
    self._orderInfo = nil;
    self._pickUpPersonArray = nil;
    [super dealloc];
}

@end

@interface TicketOrderPassengerTitleCell : UITableViewCell
@property (nonatomic,retain) UISubLabel * _titleLabel;
@property (nonatomic,retain) UIButton * _addPassenger;
@property (nonatomic,retain) UIButton * _moveButton;
@property (nonatomic,retain) UISubLabel * _suggestionLab;
@property (nonatomic,retain) UIImageView * _backImageV;
@property (nonatomic,retain) UIImageView * _DottedLineImageV;
@property (nonatomic,retain) UIButton * _showAllMsgBtn;


@end
@implementation TicketOrderPassengerTitleCell

@synthesize _titleLabel,_addPassenger;
@synthesize _moveButton;
@synthesize _suggestionLab,_backImageV;
@synthesize _showAllMsgBtn,_DottedLineImageV;
-(void)dealloc
{
    self._titleLabel = nil;
    self._addPassenger = nil;
    self._moveButton = nil;
    self._suggestionLab = nil;
    self._backImageV = nil;
    self._showAllMsgBtn = nil;
    self._DottedLineImageV = nil;
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(13,0, ViewWidth - 26, 7) image:[UIImage imageNamed:@"CenterView1.png"]]];
        self._backImageV = [UIImageView ImageViewWithFrame:CGRectMake(10, 1, ViewWidth - 20, 109) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]];
        [self addSubview:self._backImageV];
        
        self._moveButton = [UIButton buttonWithTag:0 image:[UIImage imageNamed:@"抽屉.png"] title:nil  imageEdge:UIEdgeInsetsMake(0, (120-54) /2, 30-10, (120-54) /2)  frame:CGRectMake((ViewWidth-120) / 2, 0, 120, 30) font:nil color:nil target:nil action:nil];
        [self addSubview:self._moveButton];
        
        self._suggestionLab = [UISubLabel labelWithTitle:@"温馨提示：了sdk放假啊是；客流量是看得见发牢骚；add了skf煎熬；偶是打飞机饿哦的流口水附近哦随碟附送来了sdk放假了sdk放假的洛杉矶飞sdk减肥来打开减肥了sdk金是电风扇的了开发简单来说科技发哪里看到手机费打开了放假了sdk放假定接口辽阔的设计费来打开是分级连哭都是了看的是分级了；时间佛诶urejfldksjf" frame:CGRectMake(20, 20, ViewWidth - 40, 30) font:FontSize26 color:[UIColor redColor] alignment:NSTextAlignmentLeft autoSize:YES];
        //        self._suggestionLab.numberOfLines = 3;
        self._suggestionLab.backgroundColor = [UIColor clearColor];
        [self addSubview:self._suggestionLab];
        
        self._showAllMsgBtn = [UIButton buttonWithTag:0 image:[UIImage imageNamed:@"航班提示显示全部.png"] title:nil  imageEdge:UIEdgeInsetsMake(3, (112-79), 2, 0)  frame:CGRectMake(ViewWidth - 140, 20, 112, 30) font:nil color:nil target:nil action:nil];
        [self addSubview:self._showAllMsgBtn];
        
        self._DottedLineImageV = [UIImageView ImageViewWithFrame:CGRectMake(20, 5, ViewWidth - 40, 1) image:[UIImage imageNamed:@"cabinDottedLine.png"]];
        [self addSubview:self._DottedLineImageV];

        
        self._titleLabel = [UISubLabel labelWithTitle:@"乘机人列表" frame:CGRectMake(20, 20, ViewWidth - 40, 30) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        [self addSubview:self._titleLabel];

        self._addPassenger =  [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"addPassenger.png"] frame:CGRectMake(ViewWidth - 140, 20, 112, 30) font:FontSize32 color:FontColor909090 target:nil action:nil];
        [self addSubview:self._addPassenger];

        if ([[UserInfo sharedUserInfo].userID isEqualToString: @""])
           [self._addPassenger setBackgroundImage:[UIImage imageNamed:@"addNewPassenger.png"] forState:UIControlStateNormal];

    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

@end

@interface TicketOrderPassengersCell : UITableViewCell
@property (nonatomic,retain) UISubLabel * _labelDescription;
@property (nonatomic,retain) UISubLabel * _passengerLabel;
@property (nonatomic,retain) UISubLabel * _passengerNumLabel;
@property (nonatomic,retain) UIImageView * _backGroundImageV;
@end
@implementation TicketOrderPassengersCell
@synthesize _labelDescription,_passengerLabel,_passengerNumLabel;
@synthesize _backGroundImageV;
-(void)dealloc
{
    self._labelDescription = nil;
    self._passengerLabel = nil;
    self._passengerNumLabel = nil;
    self._backGroundImageV = nil;
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self._labelDescription = [UISubLabel labelWithTitle:@"您需要添加乘机人" frame:CGRectMake(10, 0, ViewWidth - 50, 30) font:FontSize32 color:FontColorFF6113 alignment:NSTextAlignmentLeft];
        self._passengerLabel = [UISubLabel labelWithTitle:nil frame:CGRectMake(10, 0, 100, 30)  font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._passengerNumLabel = [UISubLabel labelWithTitle:nil frame:CGRectMake(110, 0, 150, 30)  font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 44) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]] ;
        [self addSubview:self._backGroundImageV];
        self._backGroundImageV = [UIImageView ImageViewWithFrame:CGRectMake(20, 7, ViewWidth - 40, 30) image:[UIImage imageNamed:@"输入框.png"]];
        [self addSubview:self._backGroundImageV];
        [self._backGroundImageV addSubview:self._labelDescription];
        [self._backGroundImageV addSubview:self._passengerLabel];
        [self._backGroundImageV addSubview:self._passengerNumLabel];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

@end

@interface TicketOrderTelephoneCell : UITableViewCell
@property (nonatomic,retain) UISubTextField * _telephoneTextField;
@end
@implementation TicketOrderTelephoneCell
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
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 100) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 2, ViewWidth - 40, 1) image:[UIImage imageNamed:@"cabinDottedLine.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"联系人" frame:CGRectMake(20, 7, 100, 30) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 40, ViewWidth - 40, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 47, 12, 15) image:[UIImage imageNamed:@"OrderInfoTelephonicon.png"]]];
        [self addSubview:[UILabel labelWithTitle:@"联系方式：" frame:CGRectMake(45, 45, 65, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        
        UISubTextField * textField =  [UISubTextField TextFieldWithFrame:CGRectMake(110, 45, ViewWidth - 130, 20) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"手机号码用于接收机票信息短信" font:FontSize26];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.textColor = FontColor333333;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self._telephoneTextField = textField;
        [self addSubview:textField];
//        [self addSubview:[UISubLabel labelWithTitle:@"联系人电话用于接收机票信息短信" frame:CGRectMake(0, 75, ViewWidth , 20)font:FontSize26 color:FontColor636363 alignment:NSTextAlignmentCenter]];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

@end

@implementation TicketOrderItineraryCell
@synthesize _leftButton1,_leftButton2;
@synthesize _terminalButton,_mailButton,_mailAddressLabel;
-(void)dealloc
{
    self._leftButton1 = nil;
    self._leftButton2 = nil;
    self._terminalButton = nil;
    self._mailButton = nil;
    self._mailAddressLabel = nil;
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.autoresizesSubviews = YES;
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 180) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 2, ViewWidth - 40, 1) image:[UIImage imageNamed:@"cabinDottedLine.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"行程单" frame:CGRectMake(20, 7, 100, 30) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        self._terminalButton = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:nil backImage:[UIImage imageNamed:[NSString stringWithFormat:@"ItineraryRight0.png"]] frame:CGRectMake(ViewWidth - 140, 40,112, 30) font:FontSize32 color:FontColor333333 target:nil action:nil];
        if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
            self._mailButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil backImage:[UIImage imageNamed:[NSString stringWithFormat:@"ItineraryRight1.png"]] frame:CGRectMake(ViewWidth - 140, 84,112, 30) font:FontSize32 color:FontColor333333 target:nil action:nil];
        }
        else {
            self._mailButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil backImage:[UIImage imageNamed:[NSString stringWithFormat:@"ItineraryRight2.png"]] frame:CGRectMake(ViewWidth - 140, 84,112, 30) font:FontSize32 color:FontColor333333 target:nil action:nil];
        }
        
        self._leftButton1 = [UIButton buttonWithTag:2 image:[UIImage imageNamed: @"FilterSingleSelected.png"] title:@"终端机打印"  imageEdge:UIEdgeInsetsMake(2, 2, 2, 130  - 30 +2)  frame:CGRectMake(20, 40,130, 30) font:FontSize32 color:FontColor333333 target:nil action:nil];
        self._leftButton2 = [UIButton buttonWithTag:1 image:[UIImage imageNamed: @"FilterSingleUnSelected.png"] title:@"免费邮寄"  imageEdge:UIEdgeInsetsMake(2, 2, 2, 130  - 30 +2)  frame:CGRectMake(20, 84,130, 30) font:FontSize32 color:FontColor333333 target:nil action:nil];
        self._mailAddressLabel = [UISubLabel labelWithTitle:@"" frame: CGRectMake(25, 120,ViewWidth-50, 50) font: FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        [self addSubview:self._leftButton1];
        [self addSubview:self._leftButton2];
        [self addSubview:self._terminalButton];
        [self addSubview:self._mailButton];
        [self addSubview:self._mailAddressLabel];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

@end

@interface TicketOrderBottomSwitchCell : UITableViewCell
@property (nonatomic,retain) CustomUISwitch * _switch1;
@property (nonatomic,retain) CustomUISwitch * _switch2;
@property (nonatomic,retain) CustomUISwitch * _switch3;
@end
@implementation TicketOrderBottomSwitchCell
@synthesize _switch1,_switch2,_switch3;
-(void)dealloc
{
    self._switch3 = nil;
    self._switch2 = nil;
    self._switch1 = nil;
    [super dealloc];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(13, 50-5, (ViewWidth - 26)/2, 7) image:[UIImage imageNamed:@"CenterView3.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 50) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(13, 0, ViewWidth - 26, 50) image:[UIImage imageNamed:@"CenterViewBottomView.png"]]];
       
        CustomUISwitch * aSwitch = [[CustomUISwitch alloc] initWithFrame:CGRectMake(((ViewWidth - 20)/3 - 60)/2 + 13, 5, 60, 22)];
        self._switch1 = aSwitch;
        self._switch1.tag = 0;
	[self._switch1 setOn:NO animated:YES];
        [aSwitch release];
        aSwitch = [[CustomUISwitch alloc] initWithFrame:CGRectMake(((ViewWidth - 20)/3 - 60)/2 + 13 + (ViewWidth - 20)/3, 5, 60, 22)];
        //aSwitch.on = YES;
        self._switch2 = aSwitch;
        self._switch2.tag = 1;
	[self._switch2 setOn:YES animated:YES];
        [aSwitch release];
        aSwitch = [[CustomUISwitch alloc] initWithFrame:CGRectMake(((ViewWidth - 20)/3 - 60)/2 + 13 + (ViewWidth - 20)*2/3, 5, 60, 22)];
        self._switch3 = aSwitch;
        self._switch3.tag = 2;
	[self._switch3 setOn:NO animated:YES];
        [aSwitch release];
        NSArray * array = [NSArray arrayWithObjects:@"自动降价", @"需要保险", @"需要行程单", nil];
        for (int i=0; i<3; i++) {
            [self addSubview:[UISubLabel labelWithTitle:[array objectAtIndex:i] frame:CGRectMake( 10 + i*(ViewWidth - 20)/3, 30, (ViewWidth - 20)/3, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        }
        [self addSubview:self._switch1];
        [self addSubview:self._switch2];
        [self addSubview:self._switch3];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

@end

@interface PickUpPersonTitleCell : UITableViewCell
@property (nonatomic,retain) UIButton * _addPickUpPerson;
@property (nonatomic,retain) UISubLabel * _labelDescription;

@end

@implementation PickUpPersonTitleCell

@synthesize _addPickUpPerson,_labelDescription;
-(void)dealloc
{
    self._labelDescription = nil;
    self._addPickUpPerson = nil;
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];//50
    if (self) {
        self._labelDescription = [UISubLabel labelWithTitle:@"接机人" frame:CGRectMake(20, 0, ViewWidth - 20, 50) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._addPickUpPerson =  [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"addPicker.png"] frame:CGRectMake(ViewWidth - 140, 10, 112, 30) font:FontSize32 color:FontColor909090 target:nil action:nil];
        if ([[UserInfo sharedUserInfo].userID isEqualToString: @""])
        {
            [self._addPickUpPerson setBackgroundImage:[UIImage imageNamed:@"addNewPicker.png"] forState:UIControlStateNormal];
        }
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 1, ViewWidth - 20, 50) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:self._labelDescription];
        [self addSubview:self._addPickUpPerson];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

@end

@interface PickUpPersonCell : UITableViewCell

@property (nonatomic,retain) UISubLabel * _labelDescription;
@property (nonatomic,retain) UISubLabel * _passengerLabel;
@property (nonatomic,retain) UISubLabel * _passengerNumLabel;
@property (nonatomic,retain) UIImageView * _backGroundImageV;
@end
@implementation PickUpPersonCell
@synthesize _labelDescription,_passengerLabel,_passengerNumLabel;
@synthesize _backGroundImageV;
-(void)dealloc
{
    self._labelDescription = nil;
    self._passengerLabel = nil;
    self._passengerNumLabel = nil;
    self._backGroundImageV = nil;
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self._labelDescription = [UISubLabel labelWithTitle:@"非必填项，可不填" frame:CGRectMake(10, 0, ViewWidth - 20, 30) font:FontSize32 color:FontColorFF6113 alignment:NSTextAlignmentLeft];
        self._passengerLabel = [UISubLabel labelWithTitle:nil frame:CGRectMake(10, 0, 100, 30)  font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._passengerNumLabel = [UISubLabel labelWithTitle:nil frame:CGRectMake(110, 0, 150, 30)  font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 44) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]] ;
        self._backGroundImageV = [UIImageView ImageViewWithFrame:CGRectMake(20, 7, ViewWidth - 40, 30) image:[UIImage imageNamed:@"输入框.png"]];
        [self addSubview:self._backGroundImageV];
        [self._backGroundImageV addSubview:self._labelDescription];
        [self._backGroundImageV addSubview:self._passengerLabel];
        [self._backGroundImageV addSubview:self._passengerNumLabel];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}


@end

@interface TicketOrderInfoViewController ()
{
    BOOL showAllMsg ;
}
@end

@implementation TicketOrderInfoViewController
@synthesize headerView,centerView,footerView,isExpend,flightsInfoArray,orderInfoData,queryDataModel;
@synthesize textFieldArray,keyboardbar,orderInfo,shengPZArray;
-(void)dealloc
{
    deleteButton = nil;
    cancelButton = nil;
    self.headerView = nil;
    self.centerView = nil;
    self.footerView = nil;
    self.flightsInfoArray = nil;
    self.orderInfoData = nil;
    self.queryDataModel = nil;
    
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    self.orderInfo = nil;
    self.shengPZArray = nil;
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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


-(void)initFooterView
{
    UIView * view3 = [[UIView alloc] initWithFrame:CGRectMake(10, ViewHeight -44 - 50, 300, 50)];
    [view3 addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"TicketQuerySubmitOrder.png"] frame:CGRectMake(62, 6, 175, 38) font:nil color:nil target:self action:@selector(nextStep)]];//
    view3.backgroundColor = [UIColor clearColor];
    self.footerView = view3;
    [view3 release];
    [self.view addSubview:self.footerView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    showAllMsg = NO;
    self.title = @"订单填写";
    self.isExpend = FALSE;
    OrderInfoDataModel * model = [[OrderInfoDataModel alloc] init];
    self.orderInfoData = model;
    [model release];
    self.orderInfoData._flightsInfoArray = self.flightsInfoArray;
    self.orderInfoData._getItineraryType = @"0";
    self.orderInfoData._isAcceptSevice = FALSE;
    self.orderInfoData._isBuyInsurance = TRUE;
    self.orderInfoData._passengerArray = [NSMutableArray array];
    self.orderInfoData._pickUpPersonArray = [NSMutableArray array];
    PickPersonInfoItem * info = [[PickPersonInfoItem alloc] init];
    info._id = @"";
    info._name = @"";
    info._phone = @"";
    [self.orderInfoData._pickUpPersonArray addObject:info];
    [info release];
    if (self.queryDataModel._flightType == RoundTypeBack) {
        PickPersonInfoItem * info = [[PickPersonInfoItem alloc] init];
        info._id = @"";
        info._name = @"";
        info._phone = @"";
        [self.orderInfoData._pickUpPersonArray addObject:info];
        [info release];
    }
    self.orderInfoData._contactorPhone = [UserInfo sharedUserInfo].telePhone;
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight  - 50) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.autoresizingMask =UIViewAutoresizingFlexibleHeight;
    [myTable setEditing:YES animated:YES];
    [self.view addSubview:myTable];
    [myTable release];
    [self initFooterView];
    
    boxImgView = [[TooltipView alloc] initWithFrame:CGRectMake(15, -300, 290, 175)];
    boxImgView.hidden = YES;
    [boxImgView._cancelButton addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [myTable addSubview:boxImgView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6; // 航班信息、乘机人列表、（20140415新增接机人）、联系方式行程单、switch
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {    // 航班信息
        return [self.orderInfoData._flightsInfoArray count];
    }
    else if (section == 1) {    // 乘机人列表
        
        return [self.orderInfoData._passengerArray count]==0?2:[self.orderInfoData._passengerArray count]+1;
    }
    else if (section == 2) {    // （20140415新增接机人）
    
        return 1;
    }
    else if (section == 3) {    // （20140415新增接机人）
        NSLog(@"%d",self.queryDataModel._flightType);
         if (self.queryDataModel._flightType == RoundTypeBack )
         {
             return 4;
         }
        return 2;
    }
    else if (section == 4) {    // 联系方式行程单
//        if ([self.orderInfoData._getItineraryType intValue] == 0) {
//            return 2;
//        }
        return 1;
    }
    else {    // switch
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.isExpend) {
            return 100;
        }
        else {
            return 50;
        }
    }
    else  if (indexPath.section == 1) { // 乘机人
        if (indexPath.row == 0) {
            NSString * showMsg =@"";
            CGFloat height = 0;
            for (FlightInfo * flght  in self.orderInfoData._flightsInfoArray) {
                if (flght._suggestionMsg) {
                    showMsg = [showMsg stringByAppendingString:flght._suggestionMsg];
                }
            }
            if (showMsg.length>0) {
                CGFloat   showAllMsgBtnHeight = 0;
                CGSize suggestedSize = [showMsg sizeWithFont:FontSize26 constrainedToSize:CGSizeMake(ViewWidth-40, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
                height = suggestedSize.height ;
                if (!showAllMsg) {
                    if (height >60) {
                        height = 60;
                    }
                    else
                    {
                        showAllMsgBtnHeight = 30;
                    }
                }
                return 110 + height - showAllMsgBtnHeight;
            }
            else
            {
                return 60;
            }
      }
        return 44;
    }
    else if (indexPath.section == 2) {
        return 100;
    }
    else  if (indexPath.section == 3) { // 接机人
        if (indexPath.row %2 ) {
            return 44;
        }
        return 50;

    }
    else if (indexPath.section == 4) {
        if ([self.orderInfoData._getItineraryType intValue] == 0) {
            return 60;
        }
        if ([self.orderInfoData._getItineraryType intValue] == 1) {// 邮寄方式
            return 180;
        }
        return 180;
    }
    else  {
        return 55; // 底部switch
    }
}
- (void)moveViewDown:(id)sender
{
    NSLog(@"抽屉按钮点击！");
    boxImgView.hidden = YES;
    self.isExpend = !self.isExpend;
    NSMutableArray *arryCell = [[NSMutableArray alloc] init];
    for (int i = 0; i < [myTable numberOfRowsInSection:0]; i ++) {
        [arryCell addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [arryCell addObject:[NSIndexPath indexPathForRow:0 inSection:1]];
    [myTable reloadRowsAtIndexPaths:arryCell withRowAnimation:UITableViewRowAnimationFade];
    [arryCell release];
}
-(void)showMsgBtn:(UIButton *)sender
{
    showAllMsg = !showAllMsg;
    NSMutableArray *arryCell = [[NSMutableArray alloc] init];
    for (int i = 0; i < [myTable numberOfRowsInSection:0]; i ++) {
        [arryCell addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [arryCell addObject:[NSIndexPath indexPathForRow:0 inSection:1]];
    [myTable reloadRowsAtIndexPaths:arryCell withRowAnimation:UITableViewRowAnimationFade];
    [arryCell release];
}
-(void) orderTicketToPerchCell:(OrderTicketToPerchCell *  )cell :(FlightInfo *)info :(NSInteger )i
{
    if ([myTable numberOfRowsInSection:0] == i + 1) {
        cell.lineView.hidden = YES;
    }else {
        cell.lineView.hidden = NO;
    }
    if ([myTable numberOfRowsInSection:0] > 1) 
    {
        if (i == 0)
        {
            cell._stateName.text = @"去程";
        }
        else {
            cell._stateName.text = @"返程";
        }
    }
    
    cell.departureDate.text = [info._startDate substringFromIndex:11];
    
    cell.departureCity.text = self.queryDataModel._fromCity._nameStr;
    cell.arrCity.text = self.queryDataModel._toCity._nameStr;
    cell._stateName.text = @"单程";
    
    if (self.queryDataModel._flightType == ConnectTypeSecond ) {
        if (i == 0) {
            cell.departureCity.text = self.queryDataModel._fromCity._nameStr;
            cell.arrCity.text = self.queryDataModel._transitCity._nameStr;
            cell._stateName.text = @"第一航程";
        }
        else {
            cell.departureCity.text = self.queryDataModel._transitCity._nameStr;
            cell.arrCity.text = self.queryDataModel._toCity._nameStr;
            cell._stateName.text = @"第二航程";
        }
    }
    else if (self.queryDataModel._flightType == RoundTypeBack) {
        if (i == 0) {
            cell.departureCity.text = self.queryDataModel._toCity._nameStr;
            cell.arrCity.text = self.queryDataModel._fromCity._nameStr;
            cell._stateName.text = @"去程";
        }
        else {
            cell.departureCity.text = self.queryDataModel._fromCity._nameStr;
            cell.arrCity.text = self.queryDataModel._toCity._nameStr;
            cell._stateName.text = @"返程";
        }
    }
    
    cell.arrDate.text = [info._endTime substringFromIndex:11];
    cell.departureTime.text = [info._startDate substringToIndex:10];
    cell.companyView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[info._flightNo substringToIndex:2]]];
    cell.companyName.text = [NSString stringWithFormat:@"%@%@",info._airline, info._flightNo];
    cell.roomLab.text = [NSString stringWithFormat:@"%@(%@)",info._selectedCabin._cabinTypeName,info._selectedCabin._cabinCode];
    
}
-(void) orderTicketToPerchDoubleCell:(OrderTicketToPerchDoubleCell *  )cell :(FlightInfo *)info :(NSInteger )i
{
    if ([myTable numberOfRowsInSection:0] == i + 1) {
        cell.lineView.hidden = YES;
    }else {
        cell.lineView.hidden = NO;
    }
    
    if ([myTable numberOfRowsInSection:0] > 1) 
    {
        if (i == 0)
        {
            cell._stateName.text = @"去程";
        }
        else {
            cell._stateName.text = @"返程";
        }
    }
    
    cell.planModels.text = [NSString stringWithFormat:@"机型: %@",info._planeType];
    cell.departureTime.text = [info._startDate substringToIndex:10];
    cell.companyView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[info._flightNo substringToIndex:2]]];
    cell.companyName.text =  [NSString stringWithFormat:@"%@%@",info._airline, info._flightNo];
    cell.departureCity.text = self.queryDataModel._fromCity._nameStr;
    cell.arrCity.text = self.queryDataModel._toCity._nameStr;
    cell._stateName.text = @"单程";
    
    if (self.queryDataModel._flightType == ConnectTypeSecond ) {
        if (i == 0) {
            cell.departureCity.text = self.queryDataModel._fromCity._nameStr;
            cell.arrCity.text = self.queryDataModel._transitCity._nameStr;
            cell._stateName.text = @"第一航程";
        }
        else {
            cell.departureCity.text = self.queryDataModel._transitCity._nameStr;
            cell.arrCity.text = self.queryDataModel._toCity._nameStr;
            cell._stateName.text = @"第二航程";
        }
    }  
    else if (self.queryDataModel._flightType == RoundTypeBack) {
        if (i == 0) {
            cell.departureCity.text = self.queryDataModel._toCity._nameStr;
            cell.arrCity.text = self.queryDataModel._fromCity._nameStr;
            cell._stateName.text = @"去程";
        }
        else {
            cell.departureCity.text = self.queryDataModel._fromCity._nameStr;
            cell.arrCity.text = self.queryDataModel._toCity._nameStr;
            cell._stateName.text = @"返程";
        }
    }
    
    cell.airport1.text = [NSString stringWithFormat:@"%@%@",info._startAirport,info._startTerminal];
    cell.departureDate.text = [info._startDate substringFromIndex:11];
    
    cell.airport2.text = [NSString stringWithFormat:@"%@%@",info._endAirport,info._endTerminal];
    cell.arrDate.text = [info._endTime substringFromIndex:11];
    cell.roomLab.text = [NSString stringWithFormat:@"%@(%@)",info._selectedCabin._cabinTypeName,info._selectedCabin._cabinCode];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (!self.isExpend) 
        {
            NSString * identifier = @"identifier1";
            OrderTicketToPerchCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketToPerchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
		    cell.backgroundColor = [UIColor clearColor];
            }
            FlightInfo * info = [self.orderInfoData._flightsInfoArray objectAtIndex:indexPath.row];
            [self orderTicketToPerchCell:cell :info:indexPath.row];
            return cell;
        }
        else 
        {
            NSString * identifier = @"identifier11";
            OrderTicketToPerchDoubleCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[OrderTicketToPerchDoubleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
                [cell.ruleButton addTarget:self action:@selector(ruleInfo:) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
		     cell.backgroundColor = [UIColor clearColor];
            }
            cell.ruleButton.tag = indexPath.row;
            FlightInfo * info = [self.orderInfoData._flightsInfoArray objectAtIndex:indexPath.row];
            [self orderTicketToPerchDoubleCell :cell :info:indexPath.row];
            return cell;
        }
        
    }
    if (indexPath.section ==1) { // 乘机人
        if (indexPath.row == 0) {
            static NSString * passengerTitleCell = @"passengerTitleCell";
            TicketOrderPassengerTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:passengerTitleCell];
            if (cell == nil) {
                cell = [[[TicketOrderPassengerTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:passengerTitleCell] autorelease];
                cell.backgroundColor = [UIColor clearColor];
		       [cell._addPassenger addTarget:self action:@selector(addPassengers) forControlEvents:UIControlEventTouchUpInside];
                [cell._moveButton addTarget:self action:@selector(moveViewDown:) forControlEvents:UIControlEventTouchUpInside];
                [cell._showAllMsgBtn addTarget:self action:@selector(showMsgBtn:) forControlEvents:UIControlEventTouchUpInside];

            }
            NSString * imageName = self.isExpend? @"抽屉2.png":@"抽屉.png";
            NSLog(@"%@",imageName);
            [cell._moveButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            
            NSString * showMsg =@"";
            CGFloat height = 0;
            for (FlightInfo * flght  in self.orderInfoData._flightsInfoArray) {
                if(flght._suggestionMsg){
                    showMsg = [showMsg stringByAppendingString:flght._suggestionMsg];
                }
            }
            if (showMsg.length>0) {
                CGSize suggestedSize = [showMsg sizeWithFont:FontSize26 constrainedToSize:CGSizeMake(ViewWidth-40, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
                height = suggestedSize.height ;
                cell._suggestionLab.numberOfLines = 0;
                CGFloat   showAllMsgBtnHeight = 0;
                imageName = @"航班提示收起.png";
                if (!showAllMsg)
                {
                    imageName = @"航班提示显示全部.png";
                    cell._suggestionLab.numberOfLines = 3;
                    if (height >60) {
                        height = 60;
                    }
                    else
                    {
                        cell._showAllMsgBtn.hidden = YES;
                        showAllMsgBtnHeight = cell._showAllMsgBtn.frame.size.height;
                    }
                }
                cell._suggestionLab.text = showMsg;
                cell._suggestionLab.frame = CGRectMake(cell._suggestionLab.frame.origin.x, cell._suggestionLab.frame.origin.y, cell._suggestionLab.frame.size.width, height);
                [cell._showAllMsgBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                
                cell._showAllMsgBtn.frame = CGRectMake(cell._showAllMsgBtn.frame.origin.x, cell._suggestionLab.frame.origin.y+ cell._suggestionLab.frame.size.height, cell._showAllMsgBtn.frame.size.width, cell._showAllMsgBtn.frame.size.height );
                cell._DottedLineImageV.frame = CGRectMake(cell._DottedLineImageV.frame.origin.x, cell._showAllMsgBtn.frame.origin.y+ cell._showAllMsgBtn.frame.size.height+10-showAllMsgBtnHeight, cell._DottedLineImageV.frame.size.width, cell._DottedLineImageV.frame.size.height );
                cell._titleLabel.frame = CGRectMake(cell._titleLabel.frame.origin.x, cell._showAllMsgBtn.frame.origin.y+ cell._showAllMsgBtn.frame.size.height +20-showAllMsgBtnHeight, cell._titleLabel.frame.size.width, cell._titleLabel.frame.size.height );
                cell._addPassenger.frame = CGRectMake(cell._addPassenger.frame.origin.x, cell._showAllMsgBtn.frame.origin.y+ cell._showAllMsgBtn.frame.size.height+20-showAllMsgBtnHeight, cell._addPassenger.frame.size.width, cell._addPassenger.frame.size.height );
                cell._backImageV.frame = CGRectMake(cell._backImageV.frame.origin.x, cell._backImageV.frame.origin.y, cell._backImageV.frame.size.width, 110+height-showAllMsgBtnHeight);
            }
            else
            {
                cell._suggestionLab.hidden = YES;
                cell._showAllMsgBtn.hidden = YES;
                cell._DottedLineImageV.hidden = YES;
                cell._backImageV.frame = CGRectMake(cell._backImageV.frame.origin.x, cell._backImageV.frame.origin.y, cell._backImageV.frame.size.width, 60);
            }
            return cell;
        }
        else {
            static NSString * passengersCell = @"passengersCell";
            TicketOrderPassengersCell * cell = [tableView dequeueReusableCellWithIdentifier:passengersCell];
            if (cell == nil) {
                cell = [[[TicketOrderPassengersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:passengersCell] autorelease];
             cell.backgroundColor = [UIColor clearColor];
	        }
            if ([self.orderInfoData._passengerArray count ]== 0) {
                cell._labelDescription.hidden = NO;
               // cell._backGroundImageV.hidden = YES  ;
                cell._backGroundImageV.frame = CGRectMake(20, 7, ViewWidth - 40, 30);
                cell._passengerLabel.text = nil;
                cell._passengerNumLabel.text = nil;
            }
            else {
                cell._backGroundImageV.hidden = NO;
                cell._backGroundImageV.frame = CGRectMake(40, 7, ViewWidth - 60, 30);
                cell._labelDescription.hidden = YES;
                PassengerInfoItem * info = [self.orderInfoData._passengerArray objectAtIndex:indexPath.row-1];
                cell._passengerLabel.text = [NSString stringWithFormat:@"%@",info._name];
//		cell._passengerNumLabel.text = [NSString stringWithFormat:@"%@",info._certNum];
                if ([info._type intValue]==0)
                {
                    cell._passengerNumLabel.text = [NSString stringWithFormat:@"%@",info._certNum];
                }
                if ([info._type intValue]==1)  
                {
                if ([ info._certNum isEqualToString:@"<null>"] || [ info._certNum isEqualToString:@""])
                {
                    info._certNum =@"";
                }
                if (![ info._certNum isEqualToString:@""]) {
                    cell._passengerNumLabel.text  = [NSString stringWithFormat:@"%@",info._certNum];
                }else{
                    cell._passengerNumLabel.text  = [NSString stringWithFormat:@"%@",info._birthday];
                }
    //			cell._passengerNumLabel.text = [NSString stringWithFormat:@"%@",info._birthday];
                    }
                }
            return cell;
        }
    }
    else if (indexPath.section == 2) {
        
        static NSString * telephoneIdentifer = @"telephoneIdentifer";
        TicketOrderTelephoneCell * cell = [tableView dequeueReusableCellWithIdentifier:telephoneIdentifer];
        if (cell == nil) {
            cell = [[[TicketOrderTelephoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:telephoneIdentifer] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            cell._telephoneTextField.delegate = self;
            contactorPhone = cell._telephoneTextField;
            self.textFieldArray = [NSArray arrayWithObjects:cell._telephoneTextField, nil];
        }
        cell._telephoneTextField.text = self.orderInfoData._contactorPhone;
        return cell;
    }
    else if (indexPath.section == 3) { // 接机人
        if (indexPath.row %2 ) {
            static NSString * pickUpPersonCellIdentifier = @"pickUpPersonCellIdentifier";
            PickUpPersonCell * cell = [tableView dequeueReusableCellWithIdentifier:pickUpPersonCellIdentifier];
            if (cell == nil) {
                cell = [[[PickUpPersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pickUpPersonCellIdentifier] autorelease];
                cell.backgroundColor = [UIColor clearColor];
	        }

            PickPersonInfoItem * info = [self.orderInfoData._pickUpPersonArray objectAtIndex:indexPath.row/2];
            if (info._id.length==0) {                   
                cell._labelDescription.hidden = NO;
                // cell._backGroundImageV.hidden = YES;
                cell._passengerLabel.text = nil;
                cell._passengerNumLabel.text = nil;
                cell._backGroundImageV.frame = CGRectMake(20, 7, ViewWidth - 40, 30);
            }
            else {
                cell._backGroundImageV.hidden = NO;
                cell._backGroundImageV.frame = CGRectMake(40, 7, ViewWidth - 60, 30);
                cell._labelDescription.hidden = YES;
                cell._passengerLabel.text = [NSString stringWithFormat:@"%@",info._name];
                cell._passengerNumLabel.text = [NSString stringWithFormat:@"%@",info._phone];
            }
            return cell;
        }
        else
        {
            static NSString * pickUpPersonTitleCellIdentifier = @"pickUpPersonTitleCellIdentifier";
            PickUpPersonTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:pickUpPersonTitleCellIdentifier];
            if (cell == nil) {
                cell = [[[PickUpPersonTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pickUpPersonTitleCellIdentifier] autorelease];
                cell.backgroundColor = [UIColor clearColor];
                [cell._addPickUpPerson addTarget:self action:@selector(addPickUpPerson:) forControlEvents:UIControlEventTouchUpInside];
            }
            cell._addPickUpPerson.tag = indexPath.row;
            if (self.queryDataModel._flightType == RoundTypeBack ) {
                if (indexPath.row == 0) {
                    cell._labelDescription.text = @"去程接机人";
                }
                else
                {
                    cell._labelDescription.text = @"返程接机人";
                }
            }
            else
            {
                cell._labelDescription.text = @"接机人";
            }

            return cell;
        }

    }
    else if (indexPath.section == 4) { // 行程单
        
        if ([self.orderInfoData._getItineraryType intValue] == 0) {
            static NSString * dafaultIdenfifer = @"dafaultIdenfifer";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:dafaultIdenfifer];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dafaultIdenfifer] autorelease];
                [cell addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 60) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            return cell;
        }
        else{
            static NSString * ItineraryIdentifer = @"ItineraryIdentifer";
            TicketOrderItineraryCell * cell = [tableView dequeueReusableCellWithIdentifier:ItineraryIdentifer];
            if (cell == nil) {
                cell = [[[TicketOrderItineraryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ItineraryIdentifer] autorelease];
                cell.backgroundColor = [UIColor clearColor];
                [cell._leftButton1 addTarget:self action:@selector(ItinerarySelect:) forControlEvents:UIControlEventTouchUpInside];
                [cell._leftButton2 addTarget:self action:@selector(ItinerarySelect:) forControlEvents:UIControlEventTouchUpInside];
                [cell._mailButton addTarget:self action:@selector(ItineraryrightButton:) forControlEvents:UIControlEventTouchUpInside];
                [cell._terminalButton addTarget:self action:@selector(ItineraryrightButton:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            if (self.orderInfoData._postAddressItem._province.length > 0) {
                
                cell._mailAddressLabel.text = [NSString stringWithFormat:@"%@%@%@ %@", self.orderInfoData._postAddressItem._province, self.orderInfoData._postAddressItem._city, self.orderInfoData._postAddressItem._county, self.orderInfoData._postAddressItem._postAddress];
            }
            else {
                cell._mailAddressLabel.text = self.orderInfoData._postAddressItem._postAddress;
            }
            if ([self.orderInfoData._getItineraryType intValue] == 1) {
                [cell._leftButton1 setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
                [cell._leftButton2 setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
                cell._mailAddressLabel.hidden = NO;
            }
            else {
                [cell._leftButton1 setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
                [cell._leftButton2 setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
                cell._mailAddressLabel.hidden = YES;
            }
            return cell;
            
        }
        
    }
    else { // switch
        static NSString * switchIdentifer = @"switchIdentifer";
        TicketOrderBottomSwitchCell * cell = [tableView dequeueReusableCellWithIdentifier:switchIdentifer];
        if (cell == nil)
        {
            cell = [[[TicketOrderBottomSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:switchIdentifer] autorelease];
            cell.backgroundColor = [UIColor clearColor];
		    cell._switch1.delegate = self;
            cell._switch2.delegate = self;
            cell._switch3.delegate = self;
        }
        CGSize tableSize = myTable.contentSize;
        NSLog(@"%f", tableSize.height);
        boxImgView.frame = CGRectMake(15, tableSize.height - 55 - 175, 290, 175);
        
        return cell;
    }
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
            if ([self.orderInfoData._passengerArray count] ==0) {
                return NO;
            }
            return YES;
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row %2 )
        {
            PickPersonInfoItem * info = [self.orderInfoData._pickUpPersonArray objectAtIndex:indexPath.row/2];
            if (info._id.length>0)
            {
                return YES;
            }
            return NO;
        }
        return NO;
    }
    return NO;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 1) {
            if ([self.orderInfoData._passengerArray count]>0) {
                PassengerInfoItem * info = [self.orderInfoData._passengerArray objectAtIndex:indexPath.row-1];
                [self.orderInfoData._passengerArray removeObject:info];
            }
            if ([tableView numberOfRowsInSection:1] >2) {
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            }
            else {
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:1], nil] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
        if (indexPath.section == 3) {
            PickPersonInfoItem * info = [self.orderInfoData._pickUpPersonArray objectAtIndex:indexPath.row/2];
            info._id = @"";
            info._name = @"";
            info._phone = @"";
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:3], nil] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}
-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    boxImgView.hidden = YES;
    NSLog(@"%s",__FUNCTION__);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.keyboardbar == nil) {
        KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
        self.keyboardbar = _keyboardbar;
        [_keyboardbar release];
    }
    [keyboardbar showBar:textField];  //显示工具条 
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 11;

	if(textFieldStrLength >= textFieldMaxLenth)
	{
		textField.text = [textFieldStr substringToIndex:textFieldMaxLenth];
		return NO;
	}
	else {
		if ([string intValue] <=9 || [string intValue]>=0 ) {
            return YES;
        }
        return NO;
	}
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.orderInfoData._contactorPhone = textField.text;
}
-(void)ruleInfo:(UIButton *)sender
{
    boxImgView.hidden = YES;
    selectFlightInfoIndex = sender.tag;
    FlightInfo * info = [self.orderInfoData._flightsInfoArray objectAtIndex:sender.tag];
    if (info._selectedCabin._rule == nil) {
        ASIFormDataRequest * theRequest = [InterfaceClass searchRule:[info._flightNo substringToIndex:2] withCabin: info._selectedCabin._cabinCode withTime:[info._startDate substringToIndex:11] withSpecialFlightNum:info._selectedCabin._specialFlightNum]; 
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onRulePaseredResult:) Delegate:self needUserType:Default];
    }
    else {
        [UIAlertView alertViewWithMessage:info._selectedCabin._rule :@"退改签规则"];
    }
    
}
-(void)onRulePaseredResult:(NSDictionary *)relustDic
{
    FlightInfo * info = [self.orderInfoData._flightsInfoArray objectAtIndex:selectFlightInfoIndex];
    CabinInfo * cabin = info._selectedCabin;
    cabin._rule = [NSString stringWithFormat:@"%@",[relustDic objectForKey:@"rule"]];
    [UIAlertView alertViewWithMessage:cabin._rule :@"退改签规则"];
}
-(void)addPickUpPerson:(UIButton *)sender
{
    pickUpPersonType = sender.tag;
    if (sender.tag == 2) {
        pickUpPersonType = 1;
    }
    PickPersonInfoItem* item =[self.orderInfoData._pickUpPersonArray objectAtIndex:pickUpPersonType];

    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) { // 非会员预订
        PickUpPersonDetailViewController * pickUpPersonDetailVC = [[PickUpPersonDetailViewController alloc] init];
        pickUpPersonDetailVC.delegate = self;
        pickUpPersonDetailVC.passengerInfoItem = nil;
//        if (item._id.length>0) {
//            pickUpPersonDetailVC.passengerInfoItem = item;
//        }
        [self.navigationController pushViewController:pickUpPersonDetailVC animated:YES];
        [pickUpPersonDetailVC release];
    }
    else {
        PickUpPersonListViewController * pickUpPersonListVC = [[PickUpPersonListViewController alloc] init];
        pickUpPersonListVC.delegate = self;
        pickUpPersonListVC.pickPersonItem = nil;
        if (item._id.length>0) {
            pickUpPersonListVC.pickPersonItem = item;
        }
        [self.navigationController pushViewController:pickUpPersonListVC animated:YES];
        [pickUpPersonListVC release];
    }
}
-(void)addPickUpPersonDelegateWithItem:(id)person
{
    [self.orderInfoData._pickUpPersonArray replaceObjectAtIndex:pickUpPersonType withObject:person];
}
-(void)addPassengers
{
    boxImgView.hidden = YES;
    FlightInfo * firstInfo = [self.orderInfoData._flightsInfoArray objectAtIndex:0];
    NSString * customDate = firstInfo._startDate;
	
	NSInteger ticketCount = 100;
	for (FlightInfo * info in  self.orderInfoData._flightsInfoArray) {
		if ([info._selectedCabin._ticketCount length] > 1) {
            if (ticketCount > 9) {
				ticketCount = 9;
			}
		}
		else  {
			if (ticketCount > [info._selectedCabin._ticketCount intValue]) {
				ticketCount = [info._selectedCabin._ticketCount intValue];
			}
		}
	}
    
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) { // 非会员预订
        if ([self.orderInfoData._passengerArray count] ==9) {
            [UIAlertView alertViewWithMessage:@"乘机人最多可以添加9位!" :@"提示"];
		    return;
        }
	    if (ticketCount == [self.orderInfoData._passengerArray count]) {
		    [UIAlertView alertViewWithMessage:@"该舱位剩余票数不足!" :@"提示"];
		    return;
	    }
        EditPassgersInfoViewController * editPassegersInfoVC = [[EditPassgersInfoViewController alloc] init];
        editPassegersInfoVC.delegate = self;
	    editPassegersInfoVC.passengerInfoItem = nil;
	    editPassegersInfoVC.currentYear = [NSDate dateFromString:customDate withFormat:@"yyyy-MM-dd HH:mm"];
        if (self.orderInfoData._flightsInfoArray.count>1) {
            FlightInfo * secondInfo = [self.orderInfoData._flightsInfoArray objectAtIndex:1];
            editPassegersInfoVC.currentYearBack = [NSDate dateFromString:secondInfo._startDate withFormat:@"yyyy-MM-dd HH:mm"];
        }
        [self.navigationController pushViewController:editPassegersInfoVC animated:YES];
        [editPassegersInfoVC release];
    }
    else {
        PassengersInfoViewController * passengersVC = [[PassengersInfoViewController alloc] init];
        passengersVC.surplusTicket = ticketCount;
        passengersVC.currentYear = [NSDate dateFromString:customDate withFormat:@"yyyy-MM-dd HH:mm"];
        if (self.orderInfoData._flightsInfoArray.count>1) {
            FlightInfo * secondInfo = [self.orderInfoData._flightsInfoArray objectAtIndex:1];
            passengersVC.currentYearBack = [NSDate dateFromString:secondInfo._startDate withFormat:@"yyyy-MM-dd HH:mm"];
        }
        passengersVC->memberVC = self;
	    passengersVC.sourceType = OrderSourceType;
        [self.navigationController pushViewController:passengersVC animated:YES];
        [passengersVC release];
    }
  
}
-(void)addPassengerOverWithItem:(PassengerInfoItem *)passengerItem // 代理 editPassegersInfoVC.delegate
{
    [self.orderInfoData._passengerArray addObject:passengerItem];
    [myTable reloadData];
}
-(void)ItineraryrightButton:(UIButton *)sender
{
    boxImgView.hidden = YES;
    NSLog(@"ItineraryrightButton:%d",sender.tag);
    if (sender.tag == 2) {
        DevicePositionMapViewController * devicePositionVC = [[DevicePositionMapViewController alloc] init];
        [self.navigationController pushViewController:devicePositionVC animated:YES];
        [devicePositionVC release];
    }
    else {
        if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) { // 非会员预订
            EditPassgersAddressViewController *passAddressVC = [[EditPassgersAddressViewController alloc] init];
            passAddressVC.delegate = self;
            [self.navigationController pushViewController:passAddressVC animated:YES];
            [passAddressVC release];
            
        }
        else {
            PassengersAddressViewController *passAddressVC = [[PassengersAddressViewController alloc] init];
            passAddressVC->memberVC = self;
            [self.navigationController pushViewController:passAddressVC animated:YES];
            [passAddressVC release];
        }
    }
}
-(void)addAddressOverWithAddressItem:(PassengerAddressItem *)addressItem // 代理 passAddressVC.delegate
{
    self.orderInfoData._postAddressItem = addressItem;
    [myTable reloadData];
}

-(void)ItinerarySelect:(UIButton *)sender
{
    [self.keyboardbar HiddenKeyBoard];
    boxImgView.hidden = YES;
    NSLog(@"ItinerarySelect:%d",sender.tag);
    self.orderInfoData._getItineraryType = [NSString stringWithFormat:@"%d",sender.tag];
    if ([self.orderInfoData._getItineraryType intValue] == 2) {
        [UIAlertView alertViewWithMessage:@"行程单打印验证码会在您航班起飞前以短信发送给您，请您在7日内打印！" :@"提示"];
    }
    [myTable reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
    if (sender.tag == 1) {
        if (self.orderInfoData._postAddressItem == nil) {
            [self ItineraryrightButton:sender];
        }
    }
}
- (void)valueChangedInView:(CustomUISwitch *)sender
//-(void) switchChangeValue:(UISwitch * )sender
{
    [self.keyboardbar HiddenKeyBoard];
    switch (sender.tag) {
        case 0:
        {
            self.orderInfoData._isAcceptSevice = sender.on;
            
            boxImgView.hidden = !sender.on;
            CGSize tableSize = myTable.contentSize;
            boxImgView.frame = CGRectMake(15, tableSize.height - 55 - 175, 290, 175);
            [self setboxImgViewContect:0];
        }
            break;
        case 1:
        {
            self.orderInfoData._isBuyInsurance = sender.on;
            
            boxImgView.hidden = !sender.on;
            CGSize tableSize = myTable.contentSize;
            boxImgView.frame = CGRectMake(15, tableSize.height - 55 - 175, 290, 175);
            [self setboxImgViewContect:1];
        } 
            break;
        case 2:
        {
            self.orderInfoData._getItineraryType = sender.on?@"2":@"0";
            if ([self.orderInfoData._getItineraryType intValue] == 2) {
                
                [UIAlertView alertViewWithMessage:@"行程单打印验证码会在您航班起飞前以短信发送给您，请您在7日内打印！" :@"提示"];
            }
            boxImgView.hidden = YES;
            [myTable reloadData];
        }    
            break;
        default:
            break;
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.keyboardbar HiddenKeyBoard];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [myTable reloadData];
}
-(void)nextStep
{
    
   if ([self.orderInfoData._passengerArray count] == 0) {
        [UIAlertView alertViewWithMessage:@"请你添加乘机人！" :@"提示"];
        return;
    }
   else {
       int childCount = 0; //儿童数量
       int adultCount = 0; //成人数量
       for (PassengerInfoItem *tmp in self.orderInfoData._passengerArray) {           
               if ([tmp._type isEqualToString:@"0"]) adultCount++;
               if ([tmp._type isEqualToString:@"1"]) childCount++;
       }
       if (childCount>adultCount*2) {
           [UIAlertView alertViewWithMessage:@"按航空公司规则，儿童乘机需要有成人陪伴，一名成人最多只能携带两名儿童!" :@"提示"];
           return;
       }
   }
    
    if (0 == [self.orderInfoData._contactorPhone length]) {
		[UIAlertView alertViewWithMessage:@"请输入联系人手机号码！" :@"提示"];
		return;
	}else if (11 > [self.orderInfoData._contactorPhone length]) {
		[UIAlertView alertViewWithMessage:@"请输入11位手机号码！" :@"提示"];
		return;
	}else if (![self.orderInfoData._contactorPhone isMatchedByRegex:PHONENO]) {
		[UIAlertView alertViewWithMessage:@"请输入正确的手机号码！" :@"提示"];
        return;
	}
    
    if ([self.orderInfoData._getItineraryType isEqualToString: @"1"]) {
        if (! self.orderInfoData._postAddressItem._postAddress )
        {
            [UIAlertView alertViewWithMessage:@"请添加行程单邮寄地址！" :@"提示"];
            return;
        }
    }
    
    OrderInfo *aOrderInfo = [[OrderInfo alloc] init];
    self.orderInfo = aOrderInfo;
    [aOrderInfo release];
    orderInfo._userId = [UserInfo sharedUserInfo].userID;
    orderInfo._contactorPhone = self.orderInfoData._contactorPhone;
    orderInfo._getItineraryType = self.orderInfoData._getItineraryType;
    if([orderInfo._getItineraryType intValue] ==1)
    {
        orderInfo._postInfo = self.orderInfoData._postAddressItem._id;
    }
    else
    {
        orderInfo._postInfo = @"";
    }
    orderInfo._isAcceptSevice = self.orderInfoData._isAcceptSevice?@"true":@"false";
    //[NSString stringWithFormat:@"%d",self.orderInfoData._isAcceptSevice] ;
    orderInfo._isBuyInsurance = self.orderInfoData._isBuyInsurance?@"true":@"false";
    //[NSString stringWithFormat:@"%d",self.orderInfoData._isBuyInsurance];
    NSLog(@"%@", orderInfo._isBuyInsurance);
    NSString * flightTypeStr ;
    NSString * isSpecialFlightStr = @"1"; 
    switch (self.queryDataModel._flightType) {
        case SingleType:
            flightTypeStr = @"1";
            isSpecialFlightStr = @"1";
            break;
        case RoundTypeGo :
        case  RoundTypeBack:
            flightTypeStr = @"2";
            //isSpecialFlightStr = self.orderInfoData._flightsInfoArray
            break;
        case ConnectTypeFirst :
        case ConnectTypeSecond:
            flightTypeStr = @"3";
            
            break;
        default:
            break;
    }
    orderInfo._flightType = flightTypeStr;
    orderInfo._isSpecialFlight = isSpecialFlightStr;
    for( PassengerInfoItem * item in self.orderInfoData._passengerArray)
    {
        orderInfo._passengers =orderInfo._passengers? [NSString stringWithFormat:@"%@&%@",orderInfo._passengers,item._id]: [NSString stringWithFormat:@"%@",item._id];
    }
    
    for(FlightInfo * info in self.orderInfoData._flightsInfoArray)
    {
        orderInfo._airline = orderInfo._airline?  [NSString stringWithFormat:@"%@&%@",orderInfo._airline,[info._flightNo substringToIndex:2]]:[NSString stringWithFormat:@"%@",[info._flightNo substringToIndex:2]];
        orderInfo._flightNo = orderInfo._flightNo? [NSString stringWithFormat:@"%@&%@",orderInfo._flightNo,info._flightNo ]:[NSString stringWithFormat:@"%@",info._flightNo ];
        orderInfo._planeType = orderInfo._planeType? [NSString stringWithFormat:@"%@&%@",orderInfo._planeType,info._planeType ]: [NSString stringWithFormat:@"%@",info._planeType ];
        orderInfo._cabinCode =orderInfo._cabinCode?  [NSString stringWithFormat:@"%@&%@",orderInfo._cabinCode,info._selectedCabin._cabinCode ]:[NSString stringWithFormat:@"%@",info._selectedCabin._cabinCode ];
        orderInfo._baseCabin = orderInfo._baseCabin? [NSString stringWithFormat:@"%@&%@",orderInfo._baseCabin,info._selectedCabin._baseCabin ]:[NSString stringWithFormat:@"%@",info._selectedCabin._baseCabin ];
        
        NSString * baseCabinCode = info._selectedCabin._baseCabin;
        NSString * baseCabinPrice = @"";
        for(CabinInfo * cabin in info._cabinInfo)
        {
            if ([baseCabinCode isEqualToString:cabin._cabinCode]) {
                baseCabinPrice = [NSString stringWithFormat:@"%d",[cabin._ticketPrice intValue] + [cabin._dropFee intValue]];
                break;
            }
        }
        if ([baseCabinPrice isEqualToString:@""]) { // 从舱位个数为0的数组中查询基准舱价格
            for(CabinInfo * cabin in info._cabinCountZeroArray)
            {
                if ([baseCabinCode isEqualToString:cabin._cabinCode]) {
                    baseCabinPrice = [NSString stringWithFormat:@"%d",[cabin._ticketPrice intValue] + [cabin._dropFee intValue]];
                    break;
                }
            }
        }
        
        orderInfo._baseCabinPrice = orderInfo._baseCabinPrice? [NSString stringWithFormat:@"%@&%@",orderInfo._baseCabinPrice,baseCabinPrice ]:[NSString stringWithFormat:@"%@",baseCabinPrice ];
        
        orderInfo._departureDate =orderInfo._departureDate? [NSString stringWithFormat:@"%@&%@",orderInfo._departureDate ,info._startDate ]:[NSString stringWithFormat:@"%@",info._startDate ];
        orderInfo._arrivalDate =orderInfo._arrivalDate? [NSString stringWithFormat:@"%@&%@",orderInfo._arrivalDate,info._endTime ]:[NSString stringWithFormat:@"%@",info._endTime  ];
        orderInfo._startAirport =orderInfo._startAirport? [NSString stringWithFormat:@"%@&%@",orderInfo._startAirport,info._startAirportCode ]:[NSString stringWithFormat:@"%@",info._startAirportCode ];
        orderInfo._endAirPort =orderInfo._endAirPort? [NSString stringWithFormat:@"%@&%@",orderInfo._endAirPort,info._endAirportCode ]: [NSString stringWithFormat:@"%@",info._endAirportCode ];
        orderInfo._discount =orderInfo._discount? [NSString stringWithFormat:@"%@&%@",orderInfo._discount,info._selectedCabin._discount ]:[NSString stringWithFormat:@"%@",info._selectedCabin._discount ];
        orderInfo._fuelTaxForAdult =orderInfo._fuelTaxForAdult? [NSString stringWithFormat:@"%@&%@",orderInfo._fuelTaxForAdult,info._fuelTaxForAdult ]:[NSString stringWithFormat:@"%@",info._fuelTaxForAdult ];
        orderInfo._fuelTaxForChild =orderInfo._fuelTaxForChild? [NSString stringWithFormat:@"%@&%@",orderInfo._fuelTaxForChild,info._fuelTaxForChild ]:[NSString stringWithFormat:@"%@",info._fuelTaxForChild ];
        orderInfo._airportForAdult =orderInfo._airportForAdult? [NSString stringWithFormat:@"%@&%@",orderInfo._airportForAdult,info._airportTaxForAdult ]: [NSString stringWithFormat:@"%@",info._airportTaxForAdult ];
        orderInfo._airportForChild =orderInfo._airportForChild? [NSString stringWithFormat:@"%@&%@",orderInfo._airportForChild,info._airportTaxForChild ]:[NSString stringWithFormat:@"%@",info._airportTaxForChild ];
        
        NSString * ticketPrice = info._selectedCabin._ticketPrice;
        NSString * dropFree = info._selectedCabin._dropFee;
        NSString * totolePrice = [NSString stringWithFormat:@"%d",[ticketPrice intValue] + [dropFree intValue]];
        
        orderInfo._ticketPriceForAdult =orderInfo._ticketPriceForAdult? [NSString stringWithFormat:@"%@&%@",orderInfo._ticketPriceForAdult,totolePrice ]:[NSString stringWithFormat:@"%@",totolePrice ];
        
        orderInfo._specialFlightNum =orderInfo._specialFlightNum? [NSString stringWithFormat:@"%@&%@",orderInfo._specialFlightNum,info._selectedCabin._specialFlightNum ]:[NSString stringWithFormat:@"%@",info._selectedCabin._specialFlightNum ];
        
        orderInfo._dropFee = orderInfo._dropFee? [NSString stringWithFormat:@"%@&%@",orderInfo._dropFee,info._selectedCabin._dropFee ]:[NSString stringWithFormat:@"%@",info._selectedCabin._dropFee ];
        orderInfo._returnLcdFeeRatio = orderInfo._returnLcdFeeRatio? [NSString stringWithFormat:@"%@&%@",orderInfo._returnLcdFeeRatio,info._selectedCabin._returnLcdFeeRatio ]:[NSString stringWithFormat:@"%@",info._selectedCabin._returnLcdFeeRatio ];
        orderInfo._source = orderInfo._source? [NSString stringWithFormat:@"%@&%@",orderInfo._source,info._selectedCabin._source ]:[NSString stringWithFormat:@"%@",info._selectedCabin._source ];
    }
    if ([orderInfo._specialFlightNum isEqualToString:@"&"]) {
        orderInfo._specialFlightNum = @"";
    }
    self.orderInfo._pick = @"";
    for (int i=0;i< [self.orderInfoData._pickUpPersonArray count];i++) {
        PickPersonInfoItem * pick = [self.orderInfoData._pickUpPersonArray objectAtIndex:i];
        NSString * _idstr = pick._id;
        if (i>0) {
            _idstr = [NSString stringWithFormat:@"&%@",_idstr];
        }
        self.orderInfo._pick = [self.orderInfo._pick stringByAppendingString:_idstr];

    }
    ASIFormDataRequest * theRequest = [InterfaceClass submitOrder:self.orderInfo];
    
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onsubmitOrderPaseredResult:) Delegate:self needUserType:NoMember];
    
}
-(void)onsubmitOrderPaseredResult:(NSDictionary *)resultDic
{
    NSLog(@"%@",resultDic);
    
    if([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"statusCode"]] isEqualToString:@"-10003"])
    {
        NSString *message = nil;
        if ([[resultDic objectForKey:@"shengPZ"] isKindOfClass:[NSNull class]]) {
            self.shengPZArray = nil;
            message = [resultDic objectForKey:@"message"];
        }
        else{
            self.shengPZArray = (NSMutableArray*)[[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"shengPZ"]] componentsSeparatedByString:@";"];
            //message = [NSString stringWithFormat:@"%@\n%@",[resultDic objectForKey:@"shengPZ"],[resultDic objectForKey:@"message"]];
            message =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"message"]];
        }
        
        UIAlertView * alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alertV.tag = 999;
        [alertV show];
        [alertV release];
    }
    else
    {
        if([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"statusCode"]] isEqualToString:@"0"])
        {
            self.orderInfoData._orderInfo = [SubmitOrderResponse SubmitOrderResponse:resultDic ];
            
//            NSMutableArray * mArray = [NSMutableArray array];
//            for(int i = 0 ; i< [self.orderInfoData._flightsInfoArray count];i++)
//            {
//                FlightInfo * info = [self.orderInfoData._flightsInfoArray objectAtIndex:i];
//                NSString * priceForChild = [self.orderInfoData._orderInfo._ticketPriceForChild objectAtIndex:i];
//                priceForChild = [NSString stringWithFormat:@"%d",[priceForChild intValue] - [info._selectedCabin._dropFee intValue]];
//                [mArray addObject:priceForChild];
//            }
//            self.orderInfoData._orderInfo._ticketPriceForChild = mArray;
            NSInteger count = [self.orderInfoData._orderInfo._ticketPriceForChild count];
            if ([self.orderInfoData._flightsInfoArray count] < count) {
                count = [self.orderInfoData._flightsInfoArray count];
            }
            NSMutableArray * mArray = [NSMutableArray array];
            for(int i = 0 ; i< count ; i++)
            {
                FlightInfo * info = [self.orderInfoData._flightsInfoArray objectAtIndex:i];
                NSString * priceForChild = [self.orderInfoData._orderInfo._ticketPriceForChild objectAtIndex:i];
                priceForChild = [NSString stringWithFormat:@"%d",[priceForChild intValue] - [info._selectedCabin._dropFee intValue]];
                [mArray addObject:priceForChild];
            }
            self.orderInfoData._orderInfo._ticketPriceForChild = mArray;
            
            NSInteger aCount = 0; // 成人个数
            NSInteger cCount = 0; // 儿童个数
            for (PassengerInfoItem * item in self.orderInfoData._passengerArray) {
                if ([item._type intValue] ==0) {
                    aCount++;
                }
                else {
                    cCount++;
                }
            }
            self.orderInfoData._adlutCount = aCount;
            self.orderInfoData._childCount = cCount;
            
            self._pointView._pointLab.tag += 1;
            
            OrderTicketToPerchViewController * ticketToPerchVC = [[OrderTicketToPerchViewController alloc] init];
            ticketToPerchVC.orderInfoData = self.orderInfoData;
            ticketToPerchVC.queryDataModel = self.queryDataModel;
            ticketToPerchVC.navigationItem.hidesBackButton = YES;
            [NavigationController pushViewController:ticketToPerchVC animated:YES];
            
            [ticketToPerchVC release];
        }
        else {
            [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"message"]]];
        }
    }
}

-(void)onupdatePassengersName:(NSDictionary*)dic
{
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"statusCode"]] isEqualToString:@"0"])
    {
        for (int i=0;i<[self.shengPZArray count];i++) { // 将当前数组中的姓名改为拼音
            NSArray * array = [[shengPZArray objectAtIndex:i] componentsSeparatedByString:@"|"];
            for (PassengerInfoItem * item in self.orderInfoData._passengerArray) {
                if ([item._id isEqualToString:[array objectAtIndex:3]]) {
                    item._name = [array objectAtIndex:2];
                }
            }
        }
        ASIFormDataRequest * theRequest = [InterfaceClass submitOrder:self.orderInfo];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onsubmitOrderPaseredResult:) Delegate:self needUserType:NoMember];
    }
}

-(void)getOtherFlightData
{
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)cancelClick:(id)sender
{
    NSLog(@"cancelClick");
    boxImgView.hidden = YES;
}

- (void)deleteClick:(id)sender
{
    NSLog(@"deleteClick");
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
            [super backHome];
        }
    }
    else if (alertView.tag == 100)
    {
        if (buttonIndex == 1) {
            [super goHome];
        }
    }
    else if(alertView.tag == 999)
    {
        //if (buttonIndex == 1)
        {
            /*************以下是有生僻字情况下去调的接口**************/
            
            NSString *nameId = [NSString string];
            NSString *name = [NSString string];
            for(int i=0;i<[self.shengPZArray count];i++)
            {
                if(i != 0)
                {
                    nameId = [nameId stringByAppendingString:[NSString stringWithFormat:@"&%@",[[[shengPZArray objectAtIndex:i] componentsSeparatedByString:@"|"] objectAtIndex:3]]];
                    name = [name stringByAppendingString:[NSString stringWithFormat:@"&%@",[[[shengPZArray objectAtIndex:i] componentsSeparatedByString:@"|"] objectAtIndex:2]]];
                }
                else 
                {
                    nameId = [nameId stringByAppendingString:[[[shengPZArray objectAtIndex:i] componentsSeparatedByString:@"|"] objectAtIndex:3]];
                    name = [name stringByAppendingString:[[[shengPZArray objectAtIndex:i] componentsSeparatedByString:@"|"] objectAtIndex:2]];
                }
            }
            ASIFormDataRequest * theRequest = [InterfaceClass updatePassengersName:[UserInfo sharedUserInfo].userID nameIds:nameId names:name];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onupdatePassengersName:) Delegate:self needUserType:Default];
        }
    }
}

- (void)setboxImgViewContect:(int)index
{
    if (index == 0) {
        boxImgView._backView.image = [UIImage imageNamed:@"弹出层服务.png"];
        boxImgView._toolTitle.text = @"自动降价说明";
        boxImgView._toolSubTitle.text = ServiceText;
    }
    else {
        boxImgView._backView.image = [UIImage imageNamed:@"弹出层.png"];
        boxImgView._toolTitle.text = @"保险说明";
        boxImgView._toolSubTitle.text = @"1.保险名称：平安航空旅客意外伤害保险\n2.保险金额：航空意外伤害保障保额80万元人民币\n3.保险期限：当次航班";
    }
}
@end
