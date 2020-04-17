//
//  InterfaceClass.h
//  FlightProject
//
//  Created by longcd on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/* 本类用于生成请求数据 */
#import <Foundation/Foundation.h>
#import "Header.h"
#import "UserInfo.h"

#import "HotelQueryDataResponse.h"
#import "ASIFormDataRequest.h"

#import "UpdateCreditCard.h"
#import "SubmitOrderHotel.h"
#import "SubmitOrderCarInfo.h"
#import "SubmitOrderCar.h"
#import "QueryCarService.h"
#import "QueryCarModel.h"
#import "HotelQueryCreditCard.h"

#import "NSObject+JSON.h"

@interface OrderInfo : NSObject
@property (nonatomic,retain)NSString * _userId;
@property (nonatomic,retain)NSString * _contactorPhone;
@property (nonatomic,retain)NSString * _postInfo;
@property (nonatomic,assign)NSString *       _isAcceptSevice;
@property (nonatomic,assign)NSString  *      _isBuyInsurance;
@property (nonatomic,retain)NSString * _getItineraryType;
@property (nonatomic,retain)NSString * _flightType;
@property (nonatomic,retain)NSString * _isSpecialFlight;

@property (nonatomic,retain)NSString * _passengers;
@property (nonatomic,retain)NSString * _airline;
@property (nonatomic,retain)NSString * _flightNo;

@property (nonatomic,retain)NSString * _planeType;

@property (nonatomic,retain)NSString * _cabinCode;
@property (nonatomic,retain)NSString * _baseCabin;
@property (nonatomic,retain)NSString * _baseCabinPrice;

@property (nonatomic,retain)NSString * _departureDate;
@property (nonatomic,retain)NSString * _arrivalDate;

@property (nonatomic,retain)NSString * _startAirport;
@property (nonatomic,retain)NSString * _endAirPort;
@property (nonatomic,retain)NSString * _discount;
@property (nonatomic,retain)NSString * _fuelTaxForAdult;
@property (nonatomic,retain)NSString * _fuelTaxForChild;
@property (nonatomic,retain)NSString * _airportForAdult;
@property (nonatomic,retain)NSString * _airportForChild;
@property (nonatomic,retain)NSString * _ticketPriceForAdult;
@property (nonatomic,retain)NSString * _specialFlightNum;

@property (nonatomic,retain)NSString * _dropFee;
@property (nonatomic,retain)NSString * _returnLcdFeeRatio;
@property (nonatomic,retain)NSString * _source;
@property (nonatomic,retain)NSString * _pick;

@end


@interface InterfaceClass : NSObject



// 三期接口访问
+(ASIFormDataRequest *)getConfigurationWithDeviceToken:(NSString *)deviceToken version:(NSString *)version userId:(NSString *)userId; //1
+(ASIFormDataRequest *)updateAirportList; //2
+(ASIFormDataRequest *)updateAirportCityList; //3
+(ASIFormDataRequest *)updateHotelCityList; //4
+(ASIFormDataRequest *)updateRentCityList; //5
+(ASIFormDataRequest *)updateWeatherCityList ;//天气城市列表
+(ASIFormDataRequest *)queryFlightTicketWithDeparture:(NSString *)departure arrival:(NSString *)arrival transitCity:(NSString *)transitCity startDate:(NSString *)startDate returnDate:(NSString *)returnDate flightType:(NSString *)flightType; //6
+(ASIFormDataRequest *)queryFlightTicketDetailWithDeparture :(NSString *)departure arrival:(NSString *)arrival flightNo:(NSString *)flightNo departureDate:(NSString *)departureDate airline:(NSString *)airline planeType:(NSString *)planeType isStop:(NSString *)isStop startAirportCode:(NSString *)startAirportCode endAirportCode:(NSString *)endAirportCode isAdultTax:(NSString *)isAdultTax;//7
+(ASIFormDataRequest *)submitOrder:(OrderInfo *)orderInfo; //8
+(ASIFormDataRequest *)getPassengerList:(NSString *)userId; //9
+(ASIFormDataRequest *)addPassengersWithUserId:(NSString *)userId name:(NSString *)name type:(NSString *)type certType:(NSString *)certType birthday:(NSString *)birthday; //10
+(ASIFormDataRequest *)deletePassengersWithUserId:(NSString *)userId ids:(NSString *)Ids; //11
+(ASIFormDataRequest *)updatePassengersWithUserId:(NSString *)userId ids:(NSString *)ids name:(NSString *)name type:(NSString *)type certType:(NSString *)certType birthday:(NSString *)birthday; //12
+(ASIFormDataRequest *)getUserAddress:(NSString *)userId; //13
+(ASIFormDataRequest *)deleteUserAddressWithUserId:(NSString *)userId ids:(NSString *)Ids; //16
+(ASIFormDataRequest *)getMessageState:(NSString *)userId withOrderId:(NSString *)orderId withPayMoney:(NSString *)payMoney withPayCoin:(NSString *)payCoin withPayType:(NSString *)payType; //17
+(ASIFormDataRequest *)getOrdersState:(NSString *)userId withOrderId:(NSString *)orderId withTimes:(NSString *)times withPayType:(NSString *)payType withPackets:(NSString *)packets; //18
+(ASIFormDataRequest *)getFlightDynamicByFlightNoWithUserId:(NSString *)userId flightNo:(NSString *)flightNo; //19
+(ASIFormDataRequest *)getFlightDynamicByStartArrival:(NSString *)departure arrival:(NSString *)arrival; //20
+(ASIFormDataRequest *)getMyAttentionListWithUserId:(NSString *)userId; //21
+(ASIFormDataRequest *)setAttentionStateWithUserId:(NSString *)userId flightNo:(NSString *)flightNo departure:(NSString*)departure arrival:(NSString*)arrival; //22
+(ASIFormDataRequest *)cancelAttentionStateWithUserId:(NSString *)userId ids:(NSString *)Ids; //23


+(ASIFormDataRequest *)memberLoginWithTelephone:(NSString *)telephone password:(NSString *)password; //24
+(ASIFormDataRequest *)memberRegisterWithTelephone:(NSString *)telephone password:(NSString *)password checkCode:(NSString *)checkCode recommendCode:(NSString *)recommendCode; //25
+(ASIFormDataRequest *)getVerificationCode:(NSString *)telephone; //26
+(ASIFormDataRequest *)updatePasswordWithUserId:(NSString *)userId oldPassword:(NSString *)oldPassword password:(NSString *)password; //27
+(ASIFormDataRequest *)forgetPasswordWithUserId:(NSString *)userId password:(NSString *)password checkCode:(NSString *)checkCode; //28
+(ASIFormDataRequest *)deleteReservation:(NSString *)id; //39
+(ASIFormDataRequest *)queryAutomaticallyDroppedList:(NSString *)userId; //40

+(ASIFormDataRequest *)memberLogin:(NSString *)telephone withUserPassword:(NSString *)password; //24
+(ASIFormDataRequest *)memberNewRegister:(NSString *)telephone withUserPassword:(NSString *)password withCheckCode:(NSString *)checkCode WithrecommendCode:(NSString *)recommendCode; //25
+(ASIFormDataRequest *)getNewVerificationCode:(NSString *)telephone withType:(NSString *)type ; //26
+(ASIFormDataRequest *)updateNewPassword:(NSString *)userId withOldPassword:(NSString *)oldPassword withNewPassword:(NSString *)password; //27
+(ASIFormDataRequest *)forgetPassword:(NSString *)telephone withPassword:(NSString *)password withCheckCode:(NSString *)checkCode ;//28
+(ASIFormDataRequest *)editPersonalInformation:(NSString *)userId withName:(NSString *)name withEmail:(NSString *)email withSex:(NSString *)sex withBirthday:(NSString *)birthday withPostalAddress:(NSString *)postalAddress withPostCode:(NSString *)postCode withCardNo:(NSString *)cardNo; //29
+(ASIFormDataRequest *)myLCDCoin:(NSString *)userId withPage:(NSString *)page; //30

+(ASIFormDataRequest *)getNewPassengerList:(NSString *)userId; //9
+(ASIFormDataRequest *)addPassengers:(NSString *)userId withName:(NSString *)name withType:(NSString *)type withCertType:(NSString *)certType withCertNum:(NSString *)certNum withBirthday:(NSString *)birthday withSex:(NSString *)sex; //10
+(ASIFormDataRequest *)deletePassengers:(NSString *)userId withIds:(NSString *)Ids; //11
+(ASIFormDataRequest *)updatePassengers:(NSString *)userId withId:(NSString *)aid withName:(NSString *)name withType:(NSString *)type withCertType:(NSString *)certType withCertNum:(NSString *)certNum withBirthday:(NSString *)birthday withGender:(NSString *)gender;//12 


+(ASIFormDataRequest *)getNewUserAddress:(NSString *)userId; //13
+(ASIFormDataRequest *)addUserAddress:(NSString *)userId withName:(NSString *)name withPostCode:(NSString *)postCode withPostalAddress:(NSString *)postalAddress withMobile:(NSString *)mobile withProvince:(NSString *)province withCity:(NSString *)city withCounty:(NSString *)county; //14
+(ASIFormDataRequest *)updateUserAddress:(NSString *)userId withId:(NSString *)aid withName:(NSString *)name withPostCode:(NSString *)postCode withPostalAddress:(NSString *)postalAddress withMobile:(NSString *)mobile withProvince:(NSString *)province withCity:(NSString *)city withCounty:(NSString *)county; //14
+(ASIFormDataRequest *)deleteUserAddress:(NSString *)userId withIds:(NSString *)Ids; //16

+(ASIFormDataRequest *)submitAdvise:(NSString *)userId withProblem:(NSString *)problem withMobilNumber:(NSString *)mobilNumber withEmail:(NSString *)email; //47

+(ASIFormDataRequest *)flightsOrdersList:(NSString *)userId withPageIndex:(NSString *)pageIndex; //31
+(ASIFormDataRequest *)flightsOrderDetails:(NSString *)orderId; //32

+ (ASIFormDataRequest *)updateOrder:(NSString *)orderId withContactorPhone:(NSString *)telephone withItineraryType:(NSString *)getItineraryType withPostInfo:(NSString *)postInfo withAcceptService:(NSString *)isAcceptService; //33
+ (ASIFormDataRequest *)queryTicketNumberInformation:(NSString *)ticketNumber; //34
+ (ASIFormDataRequest *)refund:(NSString *)ticketNumber withRefundType:(NSString *)refundType; //35


+(ASIFormDataRequest *)addReservation:(NSString *)userId withCabinDiscount:(NSString *)cabinDiscount withDeparture:(NSString *)departure withArrival:(NSString *)arrival withStarteDate:(NSString *)starteDate withEndDate:(NSString *)endDate withFlyPeriod:(NSString *)flyPeriod withEndPeriod:(NSString *)endPeriod  withSmsTime:(NSString *)smsTime withEndSmsTime:(NSString *)endSmsTime; //36
+(ASIFormDataRequest *)queryReservationList:(NSString *)userId; //37
+(ASIFormDataRequest *)queryReservationDetail:(NSString *)aid; //38
+(ASIFormDataRequest *)deleteNewReservation:(NSString *)aid; //39

+(ASIFormDataRequest *)queryNewAutomaticallyDroppedList:(NSString *)userId; //40
+(ASIFormDataRequest *)queryAutomaticallyDroppedDetail:(NSString *)ticketNo; //41

+(ASIFormDataRequest *)queryWeatherInfoByAirportCode:(NSString *)airportCode; //42
+(ASIFormDataRequest *)queryFacilityServiceByAirportCode:(NSString *)airportCode;//45
+(ASIFormDataRequest *)gelaysByAirportCode:(NSString *)airportCode;//47

+(ASIFormDataRequest *)orderHotelListByUserId:(NSString *)userId withPageIndex:(NSString *)pageIndex;
+(ASIFormDataRequest *)orderCarListByUserId:(NSString *)userId withPageIndex:(NSString *)pageIndex;//69
+(ASIFormDataRequest *)orderCarInformationByorderId:(NSString *)orderId;//70
+(ASIFormDataRequest *)deleteOrderCarByorderId:(NSString *)orderId;//71

+(ASIFormDataRequest *)searchRule:(NSString *)airCode withCabin:(NSString *)cabin withTime:flightStartTime withSpecialFlightNum:(NSString *)specialFlightNum; //70

+(ASIFormDataRequest *)bookingShowMessages:(NSString *)flightNo withCabin:(NSString *)cabin withBaseCabin:(NSString *)baseCabin withdeparture:(NSString *)departure withArrival:(NSString *)arrival   withDepartureDate:(NSString *)departureDate withArrivalDate:(NSString *)arrivalDate   returnFlightNo:(NSString *)returnFlightNo withreturnCabin:(NSString *)returnCabin withreturnBaseCabin:(NSString *)returnBaseCabin withreturnDeparture:(NSString *)returnDeparture withreturnArrival:(NSString *)returnArrival   withreturnDepartureDate:(NSString *)returnDepartureDate withreturnArrivalDate:(NSString *)returnArrivalDate   ; //70


+ (ASIFormDataRequest *)getTerminalCityList; //78
+ (ASIFormDataRequest *)getTerminalInfoByCity:(NSString *)cityCode; //77
+ (ASIFormDataRequest *)cancelOrder:(NSString *)userId withOrderId:(NSString *)orderId; //81

+(ASIFormDataRequest *)hotelQueryCreditCard:(HotelQueryCreditCard *)querycard; //57
+(ASIFormDataRequest *)addCreditCard:(UpdateCreditCard *)card; //59
+(ASIFormDataRequest *)updateCreditCard:(UpdateCreditCard *)card; // 60
+(ASIFormDataRequest *)submitOrderHotel:(SubmitOrderHotel *)hotelOrder; // 62

+(ASIFormDataRequest *)queryCarStore:(NSString *)cityCode; //64
+(ASIFormDataRequest *)queryCarModel:(SubmitOrderCarInfo *)carModel pageIndex:(int) pageIndex; // 65
+(ASIFormDataRequest *)queryCarService:(SubmitOrderCarInfo *)carService withCode:(NSString *)code; // 66
+(ASIFormDataRequest *)submitOrderCar:(SubmitOrderCarInfo *)carOrder; // 67
+(ASIFormDataRequest *)submitOrderCarInfo:(SubmitOrderCarInfo *)carOrder; // 68

+(ASIFormDataRequest *)queryHotel :(HotelRequestPara *) hotelRequestPara; //50
+(ASIFormDataRequest *)filterHotel:(NSString *)cityName; //51
+(ASIFormDataRequest *)hotelInformation:(NSString *)hotelId withCheckInDate:(NSString *)checkInDate withCheckOutDate:(NSString *)checkOutDate withLcdRate:(NSString *)lcdRate withLcdValue:(NSString *)lcdValue withUserId:(NSString *)userId; //52
+(ASIFormDataRequest *)queryComment:(NSString *)hotelId withPageIndex:(int)pageIndex; //53
+(ASIFormDataRequest *)checkPersonnelList:(NSString *)userId;  //54
+(ASIFormDataRequest *)addCheckPersonnel:(NSString *)userId withName:(NSString *) name; //55
+(ASIFormDataRequest *)deleteCheckPersonnel:(NSString *)ids; //56
+ (ASIFormDataRequest *)payLcdCoin:(NSString *)userId withOrderId:(NSString *)orderId withPayCoin:(NSString *)payCoin; //80
+(ASIFormDataRequest *)creditCardList:(NSString *)userId;  //58
+(ASIFormDataRequest *)deleteCreditCard:(NSString *)ids; //61
+ (ASIFormDataRequest *)recommendFlightWithDeparture:(NSString *)departure withArrival:(NSString *)arrival withStartDate:(NSString *)startDate; //73
+ (ASIFormDataRequest *)recommendHotelWithCityName:(NSString *)cityName withCheckInDate:(NSString *)checkInDate; //74
+ (ASIFormDataRequest *)recommendCarWithCityCode:(NSString *)cityCode withFromDate:(NSString *)fromDate withToDate:(NSString *)toDate; //75
+(ASIFormDataRequest *)getPersonalInformation:(NSString *)userId; //76
+ (ASIFormDataRequest *)creditCarardPay:(NSString *)userId withOrderId:(NSString *)orderId withPayMoney:(NSString *)payMoney withPayCoin:(NSString *)payCoin withCard:(UpdateCreditCard *)card withPhone:(NSString *)telePhone; //82
+(ASIFormDataRequest *)updatePassengersName:(NSString *)userId nameIds:(NSString *)nameIds names:(NSString*)names;//84
+(ASIFormDataRequest *)getBankList;//85
+(ASIFormDataRequest *)validateVersion:(NSString *)type versionCode:(NSString*)versionCode; //87

// 火车票 
+(ASIFormDataRequest *)stationList;//
+(ASIFormDataRequest *)getTrainVersion;
+(ASIFormDataRequest *)searchTrain:(NSString *)startStation endStation:(NSString*)endStation trainNumber:(NSString*)trainNumber searchType:(NSString*)searchType;
+ (ASIFormDataRequest *)searchTrainDetail:(NSString *)trainNumber;
+ (ASIFormDataRequest *)getCarRentalList:(NSString *)userId;//获取租车人列表
+ (ASIFormDataRequest *)addCarRental:(NSString *)userId name:(NSString *)name identityNumber:(NSString *)num telePhone:(NSString *)tel;
+ (ASIFormDataRequest *)updateCarRental:(NSString *)userId orderId:(NSString *)ids name:(NSString *)name identityNumber:(NSString *)num telePhone:(NSString *)tel;
+ (ASIFormDataRequest *)removeCarRental:(NSString *)userId orderId:(NSString *)ids;


+ (ASIFormDataRequest *)getBill:(NSString *)userId;//92
+ (ASIFormDataRequest *)registeredForZhiYinCard:(NSString *)userId name:(NSString*)name sex:(NSString*)sex type:(NSString*)type idCard:(NSString*)idCard birthday:(NSString*)birthday telePhone:(NSString*)telePhone tel:(NSString*)tel email:(NSString*)email postCode:(NSString*)postCode postalAddress:(NSString*)postalAddress;//93
+(ASIFormDataRequest *)getLcdCurrency:(NSString*)userId;//94

+ (ASIFormDataRequest *)getHotelOrderById:(NSString *)orderId withUserId:(NSString *)userId;//酒店订单详情 

+ (ASIFormDataRequest *)recommendSoft:(NSString *)pageIdndex;//推荐软件

+(ASIFormDataRequest *)collectionList:(NSString *)userId withPageIndex:(NSString *)pageIndex;//67
+(ASIFormDataRequest *)collection:(NSString *)userId withHotelId:(NSString *)hotelId;//65
+(ASIFormDataRequest *)cancelCollection:(NSString *)userId withHotelId:(NSString *)hotelId;//65

+(ASIFormDataRequest *)softDownLoad:(NSString *)softId;//102

+(ASIFormDataRequest *)getPickList:(NSString *)userId;//20
+(ASIFormDataRequest *)addPick:(NSString *)userId name:(NSString *)name phone:(NSString *)phone;//21
+(ASIFormDataRequest *)deletePick:(NSString *)userId ids:(NSString *)ids;//22
+(ASIFormDataRequest *)updatePick:(NSString *)userId ids:(NSString *)ids name:(NSString *)name phone:(NSString *)phone;//23

+(ASIFormDataRequest *)saveDeviceToken:(NSString *)deviceToken ; //107
+(ASIFormDataRequest *)getCityList;
+ (ASIFormDataRequest *)getValidCode:(NSString *)phone;

+ (ASIFormDataRequest *)getactivityList;
+ (ASIFormDataRequest *)paySecondReturnPayCoin:(NSString *)orderId;
+ (ASIFormDataRequest *)totalMileageReturnPayCoin;


//沃银火车票接口
+ (ASIFormDataRequest *)findTrainList;   // 	火车票查询
+ (ASIFormDataRequest *)findTrainListWithStartDate:(NSString *)startDate;   // 	火车票查询
+ (ASIFormDataRequest *)findStationList;   // 	车站查询
+ (ASIFormDataRequest *)findPreSalePeriod;   // 	预售期查询
+ (ASIFormDataRequest *)findOrderSimpleList;   // 	订单查询
+ (ASIFormDataRequest *)findOrderPollInfoWithID:(NSString *)orderId;   // 	订单轮询查询
+ (ASIFormDataRequest *)findOrderPayStatusInfoWithID:(NSString *)orderId;   // 	订单支付状态查询
+ (ASIFormDataRequest *)findOrderDetailListWithID:(NSString *)orderId;   // 	订单详情查询
+ (ASIFormDataRequest *)applyForSeat;   // 	提交订单
+ (ASIFormDataRequest *)confirmTicketWithID:(NSString *)orderId;   // 	获取报文
+ (ASIFormDataRequest *)rollbackPayWithID:(NSString *)orderId;   // 	支付回调
+ (ASIFormDataRequest *)cancelOrderInfoWithID:(NSString *)orderId;   // 	取消订单

+ (ASIFormDataRequest *)getTrainPasserngerList:(NSString *)userId;       //火车乘客列表
+ (ASIFormDataRequest *)addTrainPasserngerInfo:(NSString *)userId withName:(NSString *)name withType:(NSString *)type withNo:(NSString *)idNo withBirthday:(NSString *)birthDay withGender:(NSString *)gender; // 	添加旅客信息
+ (ASIFormDataRequest *)updateTrainPasserngerInfo:(NSString *)userId withPassergerId:(NSString *)pId withName:(NSString *)name withType:(NSString *)type withNo:(NSString *)idNo withBirthday:(NSString *)birthDay withGender:(NSString *)gender; // 	修改旅客信息
+ (ASIFormDataRequest *)delTrainPassernger:(NSString *)userId withPassergerId:(NSString *)pId;  // 	删除旅客
+ (ASIFormDataRequest *)getTripForTicket:(NSString *)userId;
+ (ASIFormDataRequest *)getTripForHotel:(NSString *)userId;
@end
