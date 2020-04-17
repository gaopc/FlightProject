//
//  TrainModel.m
//  FlightProject
//
//  Created by 张晓婷 on 15-6-4.
//
//

#import "TrainModel.h"
#import "NSDate+convenience.h"

@implementation TrainModel

@end

@implementation TrainQuaryInfo

@synthesize _fromStationCode,_fromStationName,_quaryDate,_toStationCode,_toStationName;
- (void)dealloc
{
    self._fromStationCode=nil;
    self._fromStationName=nil;
    self._quaryDate=nil;
    self._toStationCode=nil;
    self._toStationName=nil;
    [super dealloc];
}
-(instancetype)init
{
    if ( self = [super init]) {
        self._fromStationName = @"北京";
        self._fromStationCode = @"BJP";
        self._toStationName = @"上海";
        self._toStationCode = @"SHH";

        NSString * startDate = [NSDate dateTimeCode:[NSDate date]]; //@"yyyy-MM-dd HH:mm"
        if ([[[[[startDate componentsSeparatedByString:@" "] objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:0] intValue] >=12) {
            self._quaryDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[NSDate dateafterDay:[NSDate date] day:1 type:3] code:[NSDate dateafterDay:[NSDate date] day:1 type:1]];
        }
        else{
            self._quaryDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[NSDate dateFormateTicketQuery:[NSDate date]] code:[NSDate dateCode:[NSDate date] ]];
        }
    }
    return self;
}
@end

@implementation TrainSeats
@synthesize _count,_name,_price,_type;
@synthesize _seat;
- (void)dealloc
{
    self._count=nil;
    self._name=nil;
    self._price=nil;
    self._type=nil;
    self._seat=nil;
    
    [super dealloc];
}
-(instancetype)init
{
    if ( self = [super init]) {
        self._count=@"";
        self._name=@"";
        self._price=@"";
        self._type=@"";
        self._seat=@"";
    }
    return self;
}
+(TrainSeats *) TrainSeatsWithDic:(NSDictionary *)dic
{
    TrainSeats * item = [[TrainSeats alloc] init];
    item._count=[NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]];
    item._name=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    item._price=[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];
    item._type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]];
    item._seat=[NSString stringWithFormat:@"%@",[dic objectForKey:@"seat"]];
    item._price = [item._price stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    return [item autorelease];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"{TrainSeats {count:%@ name:%@ price:%@ type:%@ seat:%@ price:%@}}\n",self._count,self._name,self._price,self._type,self._seat,self._price];
}
@end

@implementation Service

@synthesize _insuranceCost,_serviceCost,_insuranceType;
- (void)dealloc
{
    self._insuranceCost=nil;
    self._serviceCost=nil;
    self._insuranceType=nil;
    [super dealloc];
}
-(instancetype)init
{
    if ( self = [super init]) {
        self._insuranceCost = @"10";
        self._serviceCost = @"5";
        self._insuranceType = @"1";
    }
    return self;
}

+(Service *) ServiceWithDic:(NSDictionary *)dic
{
    Service * item = [[Service alloc] init];
    item._insuranceCost=[NSString stringWithFormat:@"%@",[dic objectForKey:@"insuranceCost"]];
    item._serviceCost=[NSString stringWithFormat:@"%@",[dic objectForKey:@"serviceCost"]];
    item._insuranceType=[NSString stringWithFormat:@"%@",[dic objectForKey:@"insuranceType"]];
    
    return [item autorelease];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"{Service {insuranceCost:%@ serviceCost:%@ insuranceType:%@}}\n",self._insuranceCost,self._serviceCost,self._insuranceType];
}
@end

@implementation TrainPassagerInfo

@synthesize _idNo,_idType,_passageName,_passengerId,_passengerType;
@synthesize _seat;
@synthesize _birthDay,_sex;
@synthesize _service;
@synthesize _childs;
@synthesize _childrenName;
@synthesize _ticketState;


- (void)dealloc
{
    self._ticketState = nil;
    self._childrenName = nil;
    self._idNo=nil;
    self._idType=nil;
    self._passageName=nil;
    self._chileName=nil;
    self._passengerId=nil;
    self._passengerType=nil;
    self._birthDay=nil;
    self._sex=nil;
    self._seat = nil;
    self._service = nil;
    self._childs = nil;
    [super dealloc];
}
-(instancetype)init
{
    if ( self = [super init]) {
        self._idNo=@"";
        self._idType=@"";
        self._passageName=@"";
        self._chileName=@"";
        self._passengerId=@"";
        self._passengerType=@"";
        self._birthDay=@"";
        self._sex=@"";
        self._childrenName = @"";
        self._ticketState = @"";
        self._seat = [[[TrainSeats alloc] init] autorelease];
        self._service = [[[Service alloc] init] autorelease];
    }
    return self;
}
+(TrainPassagerInfo *) TrainPassagerInfoWithDic:(NSDictionary *)dic
{
    TrainPassagerInfo * item = [[TrainPassagerInfo alloc] init];
    item._passengerId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"passengerId"]];
    item._idNo=[NSString stringWithFormat:@"%@",[dic objectForKey:@"idNo"]];
    item._idType=[NSString stringWithFormat:@"%@",[dic objectForKey:@"idType"]];
    item._passageName=[NSString stringWithFormat:@"%@",[dic objectForKey:@"passengerName"]];
    item._passengerType=[NSString stringWithFormat:@"%@",[dic objectForKey:@"passengerType"]];
    item._ticketState = [NSString stringWithFormat:@"%@", [dic objectForKey:@"ticketStatus"]];
    
    TrainSeats * seat = [[TrainSeats alloc] init];
    seat._type = [NSString stringWithFormat:@"%@",[dic objectForKey:@"seatType"]];
    seat._name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"seatTypeName"]];
    seat._price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"seatPrice"]];
    seat._seat = [NSString stringWithFormat:@"%@",[dic objectForKey:@"seat"]];
    item._seat = seat;
    [seat release];
    Service * _s = [[Service alloc] init];
    _s._insuranceType = [NSString stringWithFormat:@"%@",[dic objectForKey:@"insuranceType"]];
    _s._insuranceCost = [NSString stringWithFormat:@"%@",[dic objectForKey:@"insurancePrice"]];
    _s._serviceCost = [NSString stringWithFormat:@"%@",[dic objectForKey:@"servicePrice"]];
    item._service = _s;
    [_s release];
    return [item autorelease];
}

+ (TrainPassagerInfo *)TrainListInfoWithDic:(NSDictionary *)dic
{
    TrainPassagerInfo * item = [[TrainPassagerInfo alloc] init];
    item._passengerId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"passengerId"]];
    item._idNo = [NSString stringWithFormat:@"%@", [dic objectForKey:@"idNo"]];
    item._idType = [NSString stringWithFormat:@"%@", [dic objectForKey:@"idType"]];
    item._passageName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"passengerName"]];
    item._birthDay = [NSString stringWithFormat:@"%@", [dic objectForKey:@"birthday"]];
    item._sex = [NSString stringWithFormat:@"%@", [dic objectForKey:@"gender"]];
    item._passengerType = @"1";
    return [item autorelease];
}

+ (TrainPassagerInfo *)PassengerListInfoWithDic:(NSDictionary *)dic
{
    TrainPassagerInfo * item = [[TrainPassagerInfo alloc] init];
    item._passengerId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]];
    item._idNo = [NSString stringWithFormat:@"%@", [dic objectForKey:@"certNum"]];
    item._idType = [NSString stringWithFormat:@"%@", [dic objectForKey:@"certType"]];
    item._passageName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
    item._birthDay = [NSString stringWithFormat:@"%@", [dic objectForKey:@"birthday"]];
    item._sex = [NSString stringWithFormat:@"%@", [dic objectForKey:@"gender"]];
    item._passengerType = [NSString stringWithFormat:@"%@", [dic objectForKey:@"type"]];
    return [item autorelease];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"{TrainPassagerInfo {passengerId:%@ idNo:%@ idType:%@ passageName:%@ passengerType:%@ seat:%@ service:%@}}\n",self._passengerId,self._idNo,self._idType,self._passageName,self._passengerType,self._seat,self._service];
}
@end

@implementation TrainLinkmanInfo

@synthesize _linkmanId,_linkmanName,_telPhone;
- (void)dealloc
{
    self._linkmanId=nil;
    self._linkmanName=nil;
    self._telPhone=nil;

    [super dealloc];
}
-(instancetype)init
{
    if ( self = [super init]) {
        self._linkmanId=@"";
        self._linkmanName=@"";
        self._telPhone=@"";
    }
    return self;
}
+(TrainLinkmanInfo *) TrainLinkmanInfoWithDic:(NSDictionary *)dic
{
    TrainLinkmanInfo * item = [[TrainLinkmanInfo alloc] init];
    item._linkmanId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"linkmanId"]];
    item._linkmanName=[NSString stringWithFormat:@"%@",[dic objectForKey:@"linkmanName"]];
    item._telPhone=[NSString stringWithFormat:@"%@",[dic objectForKey:@"telPhone"]];
    return [item autorelease];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"{TrainLinkmanInfo {linkmanId:%@ linkmanName:%@ telPhone:%@}}\n",self._linkmanId,self._linkmanName,self._telPhone];
}
@end

@implementation TrainMailInfo

@synthesize _telPhone,_address,_addressee,_mailDescript,_mailPrice,_mailType;
@synthesize _title,_mailPostalcode;
- (void)dealloc
{
    self._telPhone=nil;
    self._address=nil;
    self._addressee=nil;
    self._mailDescript=nil;
    self._mailPrice=nil;
    self._mailType=nil;
    self._title=nil;
    self._mailPostalcode = nil;
    [super dealloc];
}

-(instancetype)init
{
    if (self = [super init]) {
        self._mailDescript = @"快递费用广东省内12元，外省20元.不支持到付";
        self._mailType = @"1";
        self._mailPrice = @"12";
        self._telPhone=@"";
        self._address=@"";
        self._addressee=@"";
        self._title=@"";
        self._mailPostalcode=@"";
    }
    return self;
}

+(TrainMailInfo *) TrainMailInfoWithDic:(NSDictionary *)dic
{
    TrainMailInfo * item = [[TrainMailInfo alloc] init];
    item._telPhone=[NSString stringWithFormat:@"%@",[dic objectForKey:@"telPhone"]];
    item._address=[NSString stringWithFormat:@"%@",[dic objectForKey:@"address"]];
    item._addressee=[NSString stringWithFormat:@"%@",[dic objectForKey:@"addressee"]];
    item._mailDescript=[NSString stringWithFormat:@"%@",[dic objectForKey:@"mailDescript"]];
    item._mailPrice=[NSString stringWithFormat:@"%@",[dic objectForKey:@"mailPrice"]];
    item._mailType=[NSString stringWithFormat:@"%@",[dic objectForKey:@"mailType"]];
    item._title=[NSString stringWithFormat:@"%@",[dic objectForKey:@"invoiceTitle"]];

    return [item autorelease];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"{TrainMailInfo {telPhone:%@ address:%@ addressee:%@ mailDescript:%@ mailPrice:%@ mailType:%@}}\n",self._telPhone,self._address,self._addressee,self._mailDescript,self._mailPrice,self._mailType];
}
@end


@implementation TrainItemInfo

@synthesize _toStationName,_fromStationName,_arriveDays,_arriveTime,_canBuyNow,_ifEnd,_ifStart,_runTime,_startDate,_startTime,_trainType,_week,_trainNumber,_trainSeats;
@synthesize _selectSeat;
@synthesize _seatStr;
@synthesize _lowerPrice;
- (void)dealloc
{
    self._toStationName=nil;
    self._fromStationName=nil;
    self._arriveDays=nil;
    self._arriveTime=nil;
    self._canBuyNow=nil;
    self._trainSeats=nil;
    self._ifEnd=nil;
    self._ifStart=nil;
    self._runTime=nil;
    self._startDate=nil;
    self._startTime=nil;
    self._trainNumber=nil;
    self._trainType=nil;
    self._week=nil;
    self._selectSeat = nil;
    self._seatStr = nil;
    self._lowerPrice = nil;

    [super dealloc];
}
+(TrainItemInfo *) TrainItemInfoWithDic:(NSDictionary *)dic
{
    TrainItemInfo * item = [[TrainItemInfo alloc] init];
    item._toStationName=[NSString stringWithFormat:@"%@",[dic objectForKey:@"toStationName"]];
    item._fromStationName=[NSString stringWithFormat:@"%@",[dic objectForKey:@"fromStationName"]];
    item._arriveDays=[NSString stringWithFormat:@"%@",[dic objectForKey:@"arriveDays"]];
    item._arriveTime=[NSString stringWithFormat:@"%@",[dic objectForKey:@"arriveTime"]];
    item._canBuyNow=[NSString stringWithFormat:@"%@",[dic objectForKey:@"canBuyNow"]];
    item._ifEnd=[NSString stringWithFormat:@"%@",[dic objectForKey:@"ifEnd"]];
    item._ifStart=[NSString stringWithFormat:@"%@",[dic objectForKey:@"ifStart"]];
    item._runTime=[NSString stringWithFormat:@"%@",[dic objectForKey:@"runTime"]];
    item._startDate=[NSString stringWithFormat:@"%@",[dic objectForKey:@"startDate"]];
    item._startTime=[NSString stringWithFormat:@"%@",[dic objectForKey:@"startTime"]];
    item._trainNumber=[NSString stringWithFormat:@"%@",[dic objectForKey:@"trainNumber"]];
    item._trainType=[NSString stringWithFormat:@"%@",[dic objectForKey:@"trainType"]];
    item._week=[NSString stringWithFormat:@"%@",[dic objectForKey:@"week"]];
    item._seatStr = @"";
    item._lowerPrice = @"";
    NSArray * arr = [dic objectForKey:@"trainSeats"];
    if ([arr isKindOfClass:[NSArray class]]) {
        NSMutableArray * mArr = [NSMutableArray array];
        CGFloat lowerPrice = FLT_MAX;
        for (NSDictionary * elem in arr) {
            TrainSeats * seat = [TrainSeats TrainSeatsWithDic:elem];
            if ([seat._price floatValue]>0 && [seat._price floatValue]<lowerPrice) {
                lowerPrice = [seat._price floatValue];
                item._lowerPrice = seat._price;
            }
            [mArr addObject:seat];
            item._seatStr = [item._seatStr stringByAppendingString:[NSString stringWithFormat:@"%@ %@    ",seat._name,seat._count]];
        }
        item._trainSeats = mArr;
    }
    return [item autorelease];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"{TrainItemInfo {toStationName:%@,fromStationName:%@,arriveDays:%@,arriveTime:%@,canBuyNow:%@,ifEnd:%@,ifStart:%@,runTime:%@,startDate:%@,startTime:%@,trainNumber:%@,trainType:%@,week:%@,seatStr:%@,trainSeats:%@}}\n",self._toStationName,self._fromStationName,self._arriveDays,self._arriveTime,self._canBuyNow,self._ifEnd,self._ifStart,self._runTime,self._startDate,self._startTime,self._trainNumber,self._trainType,self._week,self._seatStr,self._trainSeats];
}
@end

@implementation BookingModel
@synthesize _linkmanInfo,_mailInfo,_passageInfoList,_quaryInfo,_userId;
@synthesize _selectTrain;
@synthesize _service;
@synthesize _preSalePeriodDescript,_preSalePeriod;
@synthesize _ifneedMail,_ifneedService,_ifonlyGTrain;
- (void)dealloc
{
    self._ifneedMail=false;
    self._ifneedService=false;
    self._ifonlyGTrain = false;
    self._linkmanInfo=nil;
    self._mailInfo=nil;
    self._passageInfoList=nil;
    self._quaryInfo=nil;
    self._userId=nil;
    self._selectTrain=nil;
    self._service=nil;
    self._preSalePeriodDescript=nil;
    self._preSalePeriod=nil;
    [super dealloc];
}
-(void)set_ifneedService:(BOOL)ifneedService
{
    _ifneedService = ifneedService;
    if(_ifneedService)
    {
        self._service._insuranceCost = @"10";
        self._service._insuranceType = @"1";
    }
    else
    {
        self._service._insuranceCost = @"0";
        self._service._insuranceType = @"0";
    }
}
+(BookingModel *)shareBookingModel
{
    static BookingModel * sender = nil;
    if (sender == nil) {
        sender = [[BookingModel alloc] init];
        sender._userId = [UserInfo sharedUserInfo].userID;
        sender._ifneedMail = NO;
        sender._ifneedService = YES;
        sender._ifonlyGTrain = NO;
        sender._service = [[Service alloc] init];
        sender._preSalePeriod = @"60";
        sender._preSalePeriodDescript=nil;
        sender._quaryInfo = [[TrainQuaryInfo alloc] init];
        sender._passageInfoList = [NSMutableArray array];
        sender._mailInfo = [[TrainMailInfo alloc] init];
        sender._linkmanInfo = [[TrainLinkmanInfo alloc] init];
    }
    return sender;
}
+(void)dateBack
{
    [BookingModel shareBookingModel]._userId = [UserInfo sharedUserInfo].userID;
    [BookingModel shareBookingModel]._ifonlyGTrain = NO;
    [BookingModel shareBookingModel]._service = [[Service alloc] init];
    [BookingModel shareBookingModel]._preSalePeriod = @"60";
    [BookingModel shareBookingModel]._preSalePeriodDescript=nil;
    [BookingModel shareBookingModel]._quaryInfo = [[TrainQuaryInfo alloc] init];
    
    [BookingModel shareBookingModel]._ifneedMail = NO;
    [BookingModel shareBookingModel]._ifneedService = YES;
    [BookingModel shareBookingModel]._passageInfoList = [NSMutableArray array];
    [BookingModel shareBookingModel]._mailInfo = [[TrainMailInfo alloc] init];
    [BookingModel shareBookingModel]._linkmanInfo = [[TrainLinkmanInfo alloc] init];
}

+(void)dateBackSub
{
    [BookingModel shareBookingModel]._ifneedMail = NO;
    [BookingModel shareBookingModel]._ifneedService = YES;
    [BookingModel shareBookingModel]._passageInfoList = [NSMutableArray array];
    [BookingModel shareBookingModel]._mailInfo = [[TrainMailInfo alloc] init];
    [BookingModel shareBookingModel]._linkmanInfo = [[TrainLinkmanInfo alloc] init];
}

@end

@implementation TrainOrderItem

@synthesize _fromStation,_orderDate,_orderId,_orderStatus,_orderTotal,_startDate,_toStation,_trainCode;

@synthesize _startTime,_endTime,_ifMail,_linkmanInfo,_mailInfo,_orderPassengerList,_ticketId;

@synthesize _serviceCost, _insuranceCost,_insuranceType;
@synthesize _ifInsurance;
@synthesize _arriveDays;
- (void)dealloc
{
    self._fromStation = nil;
    self._orderDate = nil;
    self._orderId = nil;
    self._orderStatus = nil;
    self._orderTotal = nil;
    self._startDate = nil;
    self._toStation = nil;
    self._trainCode = nil;
    
    self._startTime = nil;
    self._endTime = nil;
    self._ifMail = nil;
    self._ifInsurance = nil;

    self._linkmanInfo = nil;
    self._mailInfo = nil;
    self._orderPassengerList = nil;
    
    self._serviceCost = nil;
    self._insuranceCost = nil;
    self._insuranceType = nil;
    
    self._ticketId = nil;
    self._arriveDays = nil;

    [super dealloc];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"{TrainItemInfo {fromStation:%@,orderDate:%@,orderId:%@,orderStatus:%@,orderTotal:%@,startDate:%@,toStation:%@,trainCode:%@,startTime:%@,endTime:%@,ifMail:%@,linkmanInfo:%@,mailInfo:%@,orderPassengerList:%@,serviceCost:%@,insuranceCost:%@,insuranceType:%@,ticketId:%@}}\n",self._fromStation,self._orderDate,self._orderId,self._orderStatus,self._orderTotal,self._startDate,self._toStation,self._trainCode,self._startTime,self._endTime,self._ifMail,self._linkmanInfo,self._mailInfo,self._orderPassengerList,self._serviceCost,self._insuranceCost,self._insuranceType,self._ticketId];
}
+(TrainOrderItem *) TrainOrderListItemInfoWithDic:(NSDictionary *)dic
{
    TrainOrderItem * item = [[TrainOrderItem alloc] init];
    item._fromStation=[NSString stringWithFormat:@"%@",[dic objectForKey:@"fromStationName"]];
    item._orderDate=[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderDate"]];
    item._orderId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderId"]];
    item._orderStatus=[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderStatus"]];
    item._orderTotal=[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderTotal"]];
    item._startDate=[NSString stringWithFormat:@"%@",[dic objectForKey:@"startDate"]];
    item._toStation=[NSString stringWithFormat:@"%@",[dic objectForKey:@"toStationName"]];
    item._trainCode=[NSString stringWithFormat:@"%@",[dic objectForKey:@"trainNumber"]];
    
    return [item autorelease];
}
+(TrainOrderItem *) TrainOrderDetailIInfoWithDic:(NSDictionary *)dic
{
    TrainOrderItem * item = [[TrainOrderItem alloc] init];
    item._orderId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderId"]];
    item._orderDate=[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderDate"]];
    item._ticketId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderNumber"]];
    item._ticketId = [item._ticketId stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
    item._ticketId = [item._ticketId stringByReplacingOccurrencesOfString:@"null" withString:@""];
    item._ticketId = [item._ticketId stringByReplacingOccurrencesOfString:@"<NULL>" withString:@""];
    item._ticketId = [item._ticketId stringByReplacingOccurrencesOfString:@"NULL" withString:@""];
    
//    if ([[item._ticketId lowercaseString] containsString:@"null"]) {
//        item._ticketId= @"";
//    }

    item._orderStatus=[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderStatus"]];
    item._trainCode=[NSString stringWithFormat:@"%@",[dic objectForKey:@"trainNumber"]];
    item._arriveDays=[NSString stringWithFormat:@"%@",[dic objectForKey:@"arriveDays"]];
    item._orderTotal=[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderTotal"]];

    item._fromStation=[NSString stringWithFormat:@"%@",[dic objectForKey:@"fromStationName"]];
    item._toStation=[NSString stringWithFormat:@"%@",[dic objectForKey:@"toStationName"]];
    item._startTime=[NSString stringWithFormat:@"%@ ",[dic objectForKey:@"startDate"]];
    item._endTime=[NSString stringWithFormat:@"%@ ",[dic objectForKey:@"endDate"]];
    

    NSArray * orderPassengerList = [dic objectForKey:@"orderPassengerList"];
    if ([orderPassengerList isKindOfClass:[NSArray class]]) {
        item._orderPassengerList = [NSMutableArray array];
        for (NSDictionary * elem in orderPassengerList) {
            TrainPassagerInfo * pInfo = [TrainPassagerInfo TrainPassagerInfoWithDic:elem];
            [item._orderPassengerList addObject:pInfo];
            item._serviceCost=[NSString stringWithFormat:@"%d",[pInfo._service._serviceCost intValue]*(int)[orderPassengerList count]];

            if ([pInfo._service._insuranceCost intValue] == 0) {
                item._ifInsurance = @"false";
            }
            else
            {
                item._ifInsurance = @"true";
                item._insuranceType=pInfo._service._insuranceType;
                item._insuranceCost=[NSString stringWithFormat:@"%d",[pInfo._service._insuranceCost intValue]*(int)[orderPassengerList count]];
            }
        }
    }
    NSDictionary * linkmanTicketInfo = [dic objectForKey:@"linkmanTicketInfo"];
    if ([linkmanTicketInfo isKindOfClass:[NSDictionary class]]) {
        item._linkmanInfo = [TrainLinkmanInfo TrainLinkmanInfoWithDic:linkmanTicketInfo];
    }
    NSDictionary * mailingTicketInfo = [dic objectForKey:@"mailingTicketInfo"];
    if ([mailingTicketInfo isKindOfClass:[NSDictionary class]]) {
        item._mailInfo = [TrainMailInfo TrainMailInfoWithDic:mailingTicketInfo];
        item._ifMail=[NSString stringWithFormat:@"%@",[mailingTicketInfo objectForKey:@"ifMail"]];
    }
    return [item autorelease];
}
+(TrainOrderItem *) TrainOrderPollInfoWithDic:(NSDictionary *)dic
{
    TrainOrderItem * item = [[TrainOrderItem alloc] init];
    /*
     {"message":null,"orderInfo":{"endDate":"10:17","fromStationName":"北京","linkmanTicketInfo":{"linkmanId":null,"linkmanName":null,"telPhone":null},"mailingTicketInfo":{"address":"","addressee":"","ifMail":true,"invoiceTitle":"","mailPrice":12,"mailType":"1","telPhone":""},"message":null,"orderId":"94","orderNumber":null,"orderPassengerList":[{"idNo":"411081199001209057","idType":"1","insurancePrice":10,"insuranceType":"1","passengerName":"张海涛","passengerType":"1","seat":"01车厢,113号","seatPrice":64.5,"seatType":"1","seatTypeName":"硬座","servicePrice":5}],"orderStatus":"1","orderTotal":79.5,"startDate":"04:40","statusCode":"0","toStationName":"邯郸","trainNumber":"K219"},"statusCode":"0"}

     */
    NSDictionary * orderInfo = [dic objectForKey:@"orderInfo"];
    if ([orderInfo isKindOfClass:[NSDictionary class]]) {
        item._orderId=[NSString stringWithFormat:@"%@",[orderInfo objectForKey:@"orderId"]];
        item._trainCode = [NSString stringWithFormat:@"%@",[orderInfo objectForKey:@"trainNumber"]];
        item._orderStatus=[NSString stringWithFormat:@"%@",[orderInfo objectForKey:@"ticketStatus"]];
        item._fromStation = [NSString stringWithFormat:@"%@",[orderInfo objectForKey:@"fromStationName"]];
        item._toStation = [NSString stringWithFormat:@"%@",[orderInfo objectForKey:@"toStationName"]];
        item._startTime = [NSString stringWithFormat:@"%@",[orderInfo objectForKey:@"startDate"]];
        item._endTime = [NSString stringWithFormat:@"%@",[orderInfo objectForKey:@"endDate"]];
        item._arriveDays=[NSString stringWithFormat:@"%@",[orderInfo objectForKey:@"arriveDays"]];
        item._orderTotal=[NSString stringWithFormat:@"%@",[orderInfo objectForKey:@"orderTotal"]];
        
        item._orderDate=nil;
        item._ticketId=nil;
        item._startDate=[BookingModel shareBookingModel]._quaryInfo._quaryDate._nameCode;
        
        NSArray * passengerTicketList = [orderInfo objectForKey:@"orderPassengerList"];
        if ([passengerTicketList isKindOfClass:[NSArray class]]) {
            item._orderPassengerList = [NSMutableArray array];
            for (NSDictionary * elem in passengerTicketList) {
                TrainPassagerInfo * pInfo = [TrainPassagerInfo TrainPassagerInfoWithDic:elem];
                [item._orderPassengerList addObject:pInfo];
                item._serviceCost=[NSString stringWithFormat:@"%d",[pInfo._service._serviceCost intValue]*(int)[passengerTicketList count]];
                
                if ([pInfo._service._insuranceCost intValue] == 0) {
                    item._ifInsurance = @"false";
                }
                else
                {
                    item._ifInsurance = @"true";
                    item._insuranceType=pInfo._service._insuranceType;
                    item._insuranceCost=[NSString stringWithFormat:@"%d",[pInfo._service._insuranceCost intValue]*(int)[passengerTicketList count]];
                }

            }
        }
        NSDictionary * linkmanTicketInfo = [orderInfo objectForKey:@"linkmanTicketInfo"];
        if ([linkmanTicketInfo isKindOfClass:[NSDictionary class]]) {
            item._linkmanInfo = [TrainLinkmanInfo TrainLinkmanInfoWithDic:linkmanTicketInfo];
        }
        NSDictionary * mailingTicketInfo = [orderInfo objectForKey:@"mailingTicketInfo"];
        if ([mailingTicketInfo isKindOfClass:[NSDictionary class]]) {
            item._mailInfo = [TrainMailInfo TrainMailInfoWithDic:mailingTicketInfo];
            item._ifMail = [NSString stringWithFormat:@"%@",[mailingTicketInfo objectForKey:@"ifMail"]];
        }
    }
    
        return [item autorelease];
}


@end


