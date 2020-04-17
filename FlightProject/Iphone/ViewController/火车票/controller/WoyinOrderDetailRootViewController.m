//
//  WoyinOrderDetailRootViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 15-6-5.
//
//

#import "WoyinOrderDetailRootViewController.h"
@interface WoyinOrderTrainView : UIView

@property (nonatomic, retain) UISubLabel *_trainNumberLab;
@property (nonatomic, retain) UISubLabel *_startDateLab;
@property (nonatomic, retain) UISubLabel *_fromCityLab;
@property (nonatomic, retain) UISubLabel *_toCityLab;
@property (nonatomic, retain) UISubLabel *_fromTimeLab;
@property (nonatomic, retain) UISubLabel *_toTimeLab;

@end

@implementation WoyinOrderTrainView

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

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self._fromCityLab = [UISubLabel labelWithTitle:@"北京" frame:CGRectMake(20, 7, 60, 20) font:FontBlodSize36 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._fromCityLab.numberOfLines = 1;
        self._toCityLab = [UISubLabel labelWithTitle:@"上海" frame:CGRectMake(80, 7, 260, 20) font:FontBlodSize36 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._toCityLab.numberOfLines = 1;
        self._fromTimeLab = [UISubLabel labelWithTitle:@"15:25" frame:CGRectMake(20, 27, 60, 20) font:FontSize24 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        self._toTimeLab = [UISubLabel labelWithTitle:@"17:18" frame:CGRectMake(80, 27, 100, 20) font:FontSize24 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        self._startDateLab = [UISubLabel labelWithTitle:@"2012-08-16" frame:CGRectMake(40, 27, ViewWidth, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
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
    return self;
}

@end

@interface WoyinPassengerView : UIView

@property (nonatomic, retain) UISubLabel *_nameLab;
@property (nonatomic, retain) UISubLabel *_ticketTypeLab;
@property (nonatomic, retain) UISubLabel *_idNoLab;
@property (nonatomic, retain) UISubLabel *_seatLab;
@property (nonatomic, retain) UISubLabel *_priceLab;
@property (nonatomic, retain) UILabel *_stateView;
@end

@implementation WoyinPassengerView
@synthesize _idNoLab,_nameLab,_seatLab,_ticketTypeLab,_priceLab, _stateView;

- (void)dealloc
{
    self._stateView = nil;
    self._idNoLab = nil;
    self._nameLab = nil;
    self._seatLab = nil;
    self._ticketTypeLab = nil;
    self._priceLab = nil;
    
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self._nameLab = [UILabel labelWithTitle:@"姓    名：张三" frame:CGRectMake(10, 0, frame.size.width-20, frame.size.height/3) font:FontSize26 color:[UIColor colorWithWhite:0.2 alpha:1] alignment:NSTextAlignmentLeft];
        self._idNoLab = [UILabel labelWithTitle:@"身份证：000000000000000000" frame:CGRectMake(10, frame.size.height/3, frame.size.width-20, frame.size.height/3) font:FontSize26 color:[UIColor colorWithWhite:0.2 alpha:1] alignment:NSTextAlignmentLeft];
        self._seatLab = [UILabel labelWithTitle:@"硬    卧：9车厢29号上铺" frame:CGRectMake(10, frame.size.height/3*2, frame.size.width-20, frame.size.height/3) font:FontSize26 color:[UIColor colorWithWhite:0.2 alpha:1] alignment:NSTextAlignmentLeft];
        self._ticketTypeLab = [UILabel labelWithTitle:@"成人票" frame:CGRectMake(0, 0, frame.size.width, frame.size.height/3) font:FontSize26 color:[UIColor colorWithWhite:0.2 alpha:1] alignment:NSTextAlignmentCenter];
        
        self._priceLab = [UILabel labelWithTitle:@"500" frame:CGRectMake(frame.size.width-65, 5, 100, frame.size.height/3) font:FontSize36 color:FontColorFF6113 alignment:NSTextAlignmentLeft];
        
        self._stateView = [UISubLabel labelWithTitle:@"已退票" frame:CGRectMake(frame.size.width-75, frame.size.height/3*2 - 2, 50, 20) font:FontSize22 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
        self._stateView.backgroundColor = [UIColor brownColor];
        self._stateView.hidden = YES;
        
        [self addSubview:self._nameLab];
        [self addSubview:self._idNoLab];
        [self addSubview:self._seatLab];
        [self addSubview:self._ticketTypeLab];
        [self addSubview:[UILabel labelWithTitle:@"¥" frame:CGRectMake(frame.size.width-75, 5+9, 7, 7) font:FontSize24 color:FontColorFF6113 alignment:NSTextAlignmentLeft]];
        [self addSubview:self._priceLab];
        [self addSubview:self._stateView];
        
    }
    return self;
}

@end

@interface NomalRow : UIView
@property(nonatomic,retain) UISubLabel * _desLab;
@end
@implementation NomalRow

@synthesize _desLab;
- (void)dealloc
{
    self._desLab = nil;
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self._desLab = [UILabel labelWithTitle:@"联系人：张三" frame:CGRectMake(10, 0, frame.size.width-20, frame.size.height) font:FontSize26 color:[UIColor colorWithWhite:0.2 alpha:1] alignment:NSTextAlignmentLeft];
        [self addSubview:self._desLab];
    }
    return self;
}

@end

@interface ComplexRow : UIView
@property(nonatomic,retain) UISubLabel * _tItleLab;
@property(nonatomic,retain) UISubLabel * _moneyLab;
@property(nonatomic,retain) UISubLabel * _countLab;

@end
@implementation ComplexRow

@synthesize _tItleLab,_countLab,_moneyLab;
- (void)dealloc
{
    self._tItleLab = nil;
    self._countLab = nil;
    self._moneyLab = nil;

    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat labelHeight = frame.size.height;
        
        self._tItleLab = [UILabel labelWithTitle:@"产品服务费：" frame:CGRectMake(10, 0, frame.size.width-20, labelHeight) font:FontSize26 color:[UIColor colorWithWhite:0.2 alpha:1] alignment:NSTextAlignmentLeft];
        [self addSubview:self._tItleLab];
        
        [self addSubview:[UILabel labelWithTitle:@"¥" frame:CGRectMake(frame.size.width-80, 7, 10, 10) font:FontSize14 color:FontColorFF6113 alignment:NSTextAlignmentLeft]];
        self._moneyLab = [UILabel labelWithTitle:@"" frame:CGRectMake(frame.size.width-70, 0, 90, labelHeight) font:FontSize26 color:FontColorFF6113 alignment:NSTextAlignmentLeft];
        [self addSubview:self._moneyLab];
        self._countLab = [UILabel labelWithTitle:@"" frame:CGRectMake(frame.size.width-55, 0, 70, labelHeight) font:FontSize26 color:[UIColor colorWithWhite:0.2 alpha:1] alignment:NSTextAlignmentLeft];
        [self addSubview:self._countLab];

    }
    return self;
}

@end

@interface WoyinLinkmanView : UIView

@property (nonatomic, retain) NomalRow *_nameRow;
@property (nonatomic, retain) NomalRow *_phoneRow;
@property (nonatomic, retain) ComplexRow *_serviceRow;
@property (nonatomic, retain) ComplexRow *_insuranceRow;
@property (nonatomic, retain) ComplexRow *_mailMoneyRow;
@property (nonatomic, retain) NomalRow *_mailTitleRow;
@property (nonatomic, retain) NomalRow *_mailAdrressRow;

@end
@implementation WoyinLinkmanView
@synthesize   _insuranceRow,_mailAdrressRow,_mailMoneyRow,_mailTitleRow,_nameRow,_phoneRow,_serviceRow;


- (void)dealloc
{
    self._insuranceRow = nil;
    self._mailAdrressRow = nil;
    self._mailMoneyRow = nil;
    self._mailTitleRow = nil;
    self._nameRow = nil;
    self._phoneRow = nil;
    self._serviceRow = nil;

    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withData:(TrainOrderItem *)item
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];

        CGFloat labelHeight = 20;
        CGFloat startY = 0;
        
        BOOL isNeedService = [item._ifInsurance boolValue];
        BOOL isNeedMail = [item._ifMail boolValue];
        
        self._nameRow = [[[NomalRow alloc] initWithFrame:CGRectMake(0, startY, frame.size.width, labelHeight) ] autorelease];
        self._nameRow._desLab.text = [NSString stringWithFormat:@"联系人：%@",item._linkmanInfo._linkmanName];
        [self addSubview:self._nameRow];

        startY+= labelHeight;
        
        self._phoneRow = [[[NomalRow alloc] initWithFrame:CGRectMake(0, startY, frame.size.width, labelHeight) ] autorelease];
        self._phoneRow._desLab.text = [NSString stringWithFormat:@"手机号：%@",item._linkmanInfo._telPhone];
        [self addSubview:self._phoneRow];

        startY+= labelHeight;
        
        self._serviceRow = [[[ComplexRow alloc] initWithFrame:CGRectMake(0,startY, frame.size.width, labelHeight) ] autorelease];
        self._serviceRow._tItleLab.text =@"产品服务费：";
        self._serviceRow._moneyLab.text = item._serviceCost;
        self._serviceRow._countLab.text = [NSString stringWithFormat:@"（%d份）",(int)[item._orderPassengerList count]];
        [self addSubview:self._serviceRow];

        startY+= labelHeight;
        
        if (isNeedService) {
            self._insuranceRow = [[[ComplexRow alloc] initWithFrame:CGRectMake(0, startY, frame.size.width, labelHeight) ] autorelease];
            self._insuranceRow._tItleLab.text =@"关怀服务费：";
            self._insuranceRow._moneyLab.text = item._insuranceCost;
            self._insuranceRow._countLab.text = [NSString stringWithFormat:@"（%d份）",(int)[item._orderPassengerList count]];
            [self addSubview:self._insuranceRow];

            startY+= labelHeight;
        }
        
        if (isNeedMail) {
            self._mailMoneyRow = [[[ComplexRow alloc] initWithFrame:CGRectMake(0, startY, frame.size.width, labelHeight) ] autorelease];
            startY+= labelHeight;

            self._mailTitleRow = [[[NomalRow alloc] initWithFrame:CGRectMake(0, startY, frame.size.width, labelHeight) ] autorelease];
            startY+= labelHeight;

            self._mailAdrressRow = [[[NomalRow alloc] initWithFrame:CGRectMake(0, startY, frame.size.width, labelHeight) ] autorelease];
            startY+= labelHeight;

            self._mailMoneyRow._tItleLab.text = @"发票快递费：";
            self._mailMoneyRow._moneyLab.text = item._mailInfo._mailPrice;
            self._mailTitleRow._desLab.text = [NSString stringWithFormat:@"发票抬头：%@",item._mailInfo._title];
            self._mailAdrressRow._desLab.text = [NSString stringWithFormat:@"发票邮寄地址：%@",item._mailInfo._address];
            
            [self addSubview:self._mailMoneyRow];
            [self addSubview:self._mailTitleRow];
            [self addSubview:self._mailAdrressRow];
            
        }
    }
    return self;

}

@end

@interface WoyinOrderDetailRootViewController ()

@end
@interface WoyinPayMoneyView : UIView

@property (nonatomic, retain) UISubLabel *_priceLab;
@end

@implementation WoyinPayMoneyView
@synthesize _priceLab;

- (void)dealloc
{
    self._priceLab = nil;
    
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:[UILabel labelWithTitle:@"总价：" frame:CGRectMake(0,0, 150, frame.size.height) font:FontBlodSize48 color:[UIColor colorWithWhite:0.2 alpha:1] alignment:NSTextAlignmentRight]];
        
        [self addSubview:[UILabel labelWithTitle:@"¥" frame:CGRectMake(150, frame.size.height-25, 15, 7) font:FontSize20 color:[UIColor redColor] alignment:NSTextAlignmentCenter]];
        
        self._priceLab = [UILabel labelWithTitle:@"1050" frame:CGRectMake(150+15, 0, frame.size.width-(150+15), frame.size.height) font:FontBlodSize48 color:[UIColor redColor] alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._priceLab];
        
    }
    return self;
}

@end

@implementation WoyinOrderDetailRootViewController
@synthesize _orderItem;
- (void)dealloc
{
    self._orderItem = nil;
    [super dealloc];
}
-(void)loadView
{
    [super loadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    
    CGFloat bottomHeight = 100.0f;
    
    switch ([self._orderItem._orderStatus intValue]) {
        case 1:
        {
            bottomHeight = 100.0f;
        }
            break;
        case 2:
        {
            bottomHeight = 20.0f;
        }
            break;
        case 3:
        {
            bottomHeight = 50.0f;
        }
            break;
        case 4:
        {
            bottomHeight = 50.0f;
        }
            break;
        case 5:
        {
            bottomHeight = 20.0f;
        }
            break;
        case 7:
        {
            bottomHeight = 50.0f;
        }
            break;
        case 8:
        {
            bottomHeight = 20.0f;
        }
            break;
        default:
            break;
    }

    
    WoyinOrderTrainView * topV = [[WoyinOrderTrainView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 50)];
    [self.view addSubview:topV];
    [topV release];
    topV._fromCityLab.text = self._orderItem._fromStation;
    topV._toCityLab.text = self._orderItem._toStation;
    topV._fromTimeLab.text = self._orderItem._startTime;
    topV._toTimeLab.text = [NSString stringWithFormat:@"(%@)%@",self._orderItem._arriveDays,self._orderItem._endTime];
    topV._startDateLab.text = self._orderItem._startDate;
    topV._trainNumberLab.text = self._orderItem._trainCode;

    
    UIView * centerV = [[UIView alloc] initWithFrame:CGRectMake(0, 50, ViewWidth, ViewHeight-44-50-bottomHeight)];
    [self.view addSubview:centerV];
    [centerV release];
    [centerV addSubview:[UIImageView ImageViewWithFrame:centerV.bounds image:[[UIImage imageNamed:@"cabinListCell.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
    UIScrollView * scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 5, ViewWidth, centerV.frame.size.height-10)];
    [centerV addSubview:scrollV];
    [scrollV release];
    
    CGFloat startY = 0;
    if ([self._orderItem._orderStatus intValue] == 3) {
        UILabel * label = [UILabel labelWithTitle:[NSString stringWithFormat:@"  取票单号：%@",self._orderItem._ticketId] frame:CGRectMake(0, startY, scrollV.frame.size.width, 30) font:FontBlodSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        label.backgroundColor = [UIColor whiteColor];
        [scrollV addSubview:label];
        startY+=30;
    }
    [scrollV addSubview:[UILabel labelWithTitle:@"火车票信息" frame:CGRectMake(10, startY, scrollV.frame.size.width-20, 30) font:FontBlodSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]] ;
    startY+=30;
    for (int i=0; i<[self._orderItem._orderPassengerList count]; i++) {
        if (i>0) {
            [scrollV addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, startY, scrollV.frame.size.width-20, 1) image:[UIImage imageNamed:@"cabinDottedLine.png"]]];
            startY += 1;
        }
        
        WoyinPassengerView * pV = [[WoyinPassengerView alloc] initWithFrame:CGRectMake(0,startY, scrollV.frame.size.width, 60)];
        pV.backgroundColor = [UIColor whiteColor];
        [scrollV addSubview:pV];
        [pV release];
        TrainPassagerInfo * passager = [self._orderItem._orderPassengerList objectAtIndex:i];
        NSLog(@"%@",passager);
        /*
         1:二代身份证，C:
         港澳通行证，G:台湾通行证，B:
         护照
         */
        NSDictionary * certDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"二代身份证", @"港澳通行证",@"台湾通行证", @"护照", nil] forKeys:[NSArray arrayWithObjects:@"1", @"C",@"G", @"B", nil]];

        pV._nameLab.text = [NSString stringWithFormat:@"姓名：%@",passager._passageName];
        pV._idNoLab.text = [NSString stringWithFormat:@"%@：%@",[certDic objectForKey:passager._idType], passager._idNo];
        pV._seatLab.text = [NSString stringWithFormat:@"%@：%@",passager._seat._name,passager._seat._seat];
        pV._priceLab.text = [NSString stringWithFormat:@"%@",passager._seat._price];
        pV._ticketTypeLab.text = [passager._passengerType intValue]==1?@"成人票":@"儿童票";
        
        if ([self._orderItem._orderStatus intValue] == 7 && [passager._ticketState intValue] == 3)
        {
            pV._stateView.text = @"已出票";
            pV._stateView.hidden = NO;
            pV._stateView.backgroundColor = [UIColor colorWithRed:0x20/255.0 green:0x99/255.0 blue:0x00/255.0 alpha:1];
        }
        
        if ([passager._ticketState intValue] == 7 || [passager._ticketState intValue] == 6)
        {
            pV._stateView.hidden = NO;
        }
        else if ([passager._ticketState intValue] == 8) {
            pV._stateView.text = @"退票中";
            pV._stateView.hidden = NO;
        }
        else if ([passager._ticketState intValue] == 9) {
            pV._stateView.text = @"退票失败";
            pV._stateView.hidden = NO;
        }
        startY += 60;
    }
    if ([self._orderItem._orderPassengerList count]>0) {
        startY += 10;
    }
    BOOL isNeedService = [self._orderItem._ifInsurance boolValue];
    BOOL isNeedMail = [self._orderItem._ifMail boolValue];
    WoyinLinkmanView * manV = [[WoyinLinkmanView alloc] initWithFrame:CGRectMake(0, startY, scrollV.frame.size.width, 140-(isNeedService?0:20)-(isNeedMail?0:60)) withData:self._orderItem];
    [scrollV addSubview:manV];
    [manV release];

    
    startY+= (manV.frame.size.height+10);
    
    CGFloat bottomStartY = scrollV.frame.size.height - 60;
    if (startY < bottomStartY) {
        startY = bottomStartY;
    }
    
    WoyinPayMoneyView * payV = [[WoyinPayMoneyView alloc] initWithFrame:CGRectMake(0, startY, scrollV.frame.size.width, 50)];
    payV.backgroundColor = [UIColor whiteColor];
    [scrollV addSubview:payV];
    [payV release];
    payV._priceLab.text = self._orderItem._orderTotal;
    
    startY += 60;
    scrollV.contentSize = CGSizeMake(scrollV.frame.size.width, startY);

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
