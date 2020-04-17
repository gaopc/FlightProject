//
//  TrainModel.h
//  FlightProject
//
//  Created by 张晓婷 on 15-6-4.
//
//

#import <Foundation/Foundation.h>
#import "TicketQueryViewController.h"

@interface TrainModel : NSObject

@end

@interface TrainQuaryInfo : NSObject
@property (nonatomic,retain)NSString *_fromStationName;//"："北京", // 出发站名
@property (nonatomic,retain)NSString *_fromStationCode;//"："XX", // 出发站名简码
@property (nonatomic,retain)NSString *_toStationName;//"："上海", // 到达站名
@property (nonatomic,retain)NSString *_toStationCode;//"："XXX", // 到达站名简码
@property (nonatomic,retain)TicketQueryDataModelElem *_quaryDate;//"："XXX", // 到达站名简码

@end

@interface TrainSeats : NSObject
@property (nonatomic,retain)NSString * _name;//"："硬座", //名称
@property (nonatomic,retain)NSString * _type;//"："1", //类型
@property (nonatomic,retain)NSString * _count;//"："111", //余票
@property (nonatomic,retain)NSString * _price;//"："189", //价格
@property (nonatomic,retain)NSString * _seat;//"："11车12号", //车厢座位

+(TrainSeats *) TrainSeatsWithDic:(NSDictionary *)dic;

@end

@interface Service : NSObject
@property (nonatomic,retain)NSString * _serviceCost;//"：5, //服务费
@property (nonatomic,retain)NSString * _insuranceType;//"："1", //保险类型
@property (nonatomic,retain)NSString * _insuranceCost;// "：10, //保险费用

+(Service *) ServiceWithDic:(NSDictionary *)dic;

@end

@interface TrainPassagerInfo : NSObject
@property (nonatomic,retain)NSString * _passengerId; //"："123", // 乘客Id
@property (nonatomic,retain)NSString * _passageName; //"："张三", // 乘客姓名
@property (nonatomic,retain)NSString * _chileName; //"："张三", // 乘客姓名儿童

@property (nonatomic,retain)NSString * _passengerType; //"："1", //乘客类型
@property (nonatomic,retain)NSString * _idType; //"："1", //证件类型
@property (nonatomic,retain)NSString * _idNo; //"："1123213213", //证件号码
@property (nonatomic,retain)NSString * _sex; //"："1", //性别
@property (nonatomic,retain)NSString * _birthDay; //"："", //出生日期
@property (nonatomic,retain)TrainSeats * _seat; //"："xxx", //座位信息
@property (nonatomic,retain)Service * _service; //"："xxx", //保险
@property (nonatomic,retain)NSMutableArray * _childs; //"："xxx", //大人名下的儿童
@property (nonatomic,retain)NSString *_childrenName; //"："", //儿童姓名
@property (nonatomic ,retain) NSString *_ticketState; //票状态

+(TrainPassagerInfo *) TrainPassagerInfoWithDic:(NSDictionary *)dic;
+ (TrainPassagerInfo *)TrainListInfoWithDic:(NSDictionary *)dic;
+ (TrainPassagerInfo *)PassengerListInfoWithDic:(NSDictionary *)dic;
@end

@interface TrainLinkmanInfo : NSObject
@property (nonatomic,retain)NSString * _linkmanId;//"："213", // 联系人ID
@property (nonatomic,retain)NSString * _linkmanName;//"："张三", //姓名
@property (nonatomic,retain)NSString * _telPhone;//"："1123213213", //电话
+(TrainLinkmanInfo *) TrainLinkmanInfoWithDic:(NSDictionary *)dic;
@end

@interface TrainMailInfo : NSObject
@property (nonatomic,retain)NSString * _mailType;//"："1", // 邮寄方式
@property (nonatomic,retain)NSString * _mailDescript;//"："123213123213", //邮寄描述
@property (nonatomic,retain)NSString * _mailPrice;//"："12", //邮寄费用
@property (nonatomic,retain)NSString * _addressee;//"："张三", //收件人
@property (nonatomic,retain)NSString * _telPhone;//"："123213123213", //电话
@property (nonatomic,retain)NSString * _address;//"："北京昌平", //邮寄地址
@property (nonatomic,retain)NSString * _title;//"："", //发票抬头
@property (nonatomic,retain)NSString * _mailPostalcode;//"："", //邮编

+(TrainMailInfo *) TrainMailInfoWithDic:(NSDictionary *)dic;
@end



@interface TrainItemInfo : NSObject
@property (nonatomic,retain)NSString * _trainNumber;//"："D21", // 车次
@property (nonatomic,retain)NSString * _trainType;//"：2,  //列车类型
@property (nonatomic,retain)NSString * _canBuyNow;//"：true, // 是否可以接受预定
@property (nonatomic,retain)NSString * _fromStationName;//"："北京", // 出发站名
@property (nonatomic,retain)NSString * _toStationName;//"："上海", // 到达站名
@property (nonatomic,retain)NSString * _ifStart;//"：true, //出发站是否为始发站
@property (nonatomic,retain)NSString * _ifEnd;//"：true, //到达站是否为终到站
@property (nonatomic,retain)NSString * _startDate;//"："2015-06-01", //出发日期
@property (nonatomic,retain)NSString * _week;//"："2", //星期
@property (nonatomic,retain)NSString * _startTime;//"："08:00", //出发时刻
@property (nonatomic,retain)NSString * _arriveTime;//"："15:00", //到达时刻
@property (nonatomic,retain)NSString * _runTime;//"："7小时", //历时
@property (nonatomic,retain)NSString * _arriveDays;//"："次日到达", //运行天数
@property (nonatomic,retain)TrainSeats * _selectSeat;//"："数组", //座位
@property (nonatomic,retain)NSString * _seatStr;//"："字符串", //座位

@property (nonatomic,retain)NSArray * _trainSeats;//"："数组", //座位
@property (nonatomic,retain)NSString * _lowerPrice;//"："字符串", //座位


+(TrainItemInfo *) TrainItemInfoWithDic:(NSDictionary *)dic;

@end

@interface BookingModel : NSObject
@property (nonatomic,retain)TrainQuaryInfo *_quaryInfo;//"："xx", // 查询信息
@property (nonatomic,retain)TrainItemInfo *_selectTrain;//"："xx", // 选中的车次
@property (nonatomic,retain)NSMutableArray *_passageInfoList;//"："XX", // 乘客信息
@property (nonatomic,retain)TrainLinkmanInfo *_linkmanInfo;//"："xx", // 联系人信息
@property (nonatomic,retain)TrainMailInfo *_mailInfo;//"："XXX", // 邮寄信息
@property (nonatomic,retain)NSString *_userId;// 用户id
@property (nonatomic,assign)BOOL _ifneedService;// 是否邮寄发票凭证
@property (nonatomic,assign)BOOL _ifneedMail;// 是否邮寄发票凭证
@property (nonatomic,assign)BOOL _ifonlyGTrain;// 是否只需要高铁或动车
@property (nonatomic,retain)Service * _service; //"："xxx", //保险
@property (nonatomic,retain)NSString *_preSalePeriod;//预售天数
@property (nonatomic,retain)NSString *_preSalePeriodDescript;//预售天数描述

+(BookingModel *)shareBookingModel;
+(void)dateBack;
+(void)dateBackSub;
@end

@interface TrainOrderItem : NSObject
@property (nonatomic,retain)NSString *_orderId;//"："123", // 订单号
@property (nonatomic,retain)NSString *_orderDate;//"："2015-06-01 12:00", // 订单日期
@property (nonatomic,retain)NSString *_trainCode;//"："D21", //车次
@property (nonatomic,retain)NSString *_fromStation;//"："北京", //出发站名
@property (nonatomic,retain)NSString *_toStation;//"："上海", // 到达站名
@property (nonatomic,retain)NSString *_startDate;//"："2015-06-01", //出发日期
@property (nonatomic,retain)NSString *_startTime;//"："16:00", //出发时间
@property (nonatomic,retain)NSString *_endTime;//"："16:00", //到达时间
@property (nonatomic,retain)NSString *_orderStatus;//"："1", //订单状态：
@property (nonatomic,retain)NSString *_ticketId;//"："123", // 取票号
@property (nonatomic,retain)NSString *_arriveDays;//"："第2天", // 运行天数
@property (nonatomic,retain)NSString *_orderTotal;//"："255.5", //订单总价

@property (nonatomic,retain)NSString *_serviceCost;//"："5", //服务费
@property (nonatomic,retain)NSString *_insuranceType;//"："1", //保险类型
@property (nonatomic,retain)NSString *_insuranceCost ;//"："10", //保险费用
@property (nonatomic,retain)NSString *_ifInsurance;//"：true, //是否需要保险服务

@property (nonatomic,retain)NSMutableArray *_orderPassengerList;//"："XX", // 乘客信息
@property (nonatomic,retain)NSString *_ifMail;//"：true, //是否邮寄报销凭证
@property (nonatomic,retain)TrainMailInfo *_mailInfo;//"："XXX", // 邮寄信息
@property (nonatomic,retain)TrainLinkmanInfo *_linkmanInfo;//"："xx", // 联系人信息

+(TrainOrderItem *) TrainOrderPollInfoWithDic:(NSDictionary *)dic;
+(TrainOrderItem *) TrainOrderListItemInfoWithDic:(NSDictionary *)dic;
+(TrainOrderItem *) TrainOrderDetailIInfoWithDic:(NSDictionary *)dic;
@end

