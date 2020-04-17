//
//  InterfaceClass.m
//  FlightProject
//
//  Created by longcd on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InterfaceClass.h"
#import "TrainModel.h"


@implementation OrderInfo
@synthesize _userId;
@synthesize _contactorPhone;
@synthesize _postInfo;
@synthesize _isAcceptSevice;
@synthesize _isBuyInsurance;
@synthesize _getItineraryType;
@synthesize _flightType;
@synthesize _isSpecialFlight;

@synthesize _passengers;
@synthesize _airline;
@synthesize _flightNo;

@synthesize _planeType;

@synthesize _cabinCode;
@synthesize _baseCabin;
@synthesize _baseCabinPrice;

@synthesize _departureDate;
@synthesize _arrivalDate;

@synthesize _startAirport;
@synthesize _endAirPort;
@synthesize _discount;
@synthesize _fuelTaxForAdult,_fuelTaxForChild;

@synthesize _airportForAdult,_airportForChild;
@synthesize _ticketPriceForAdult;
@synthesize _specialFlightNum;

@synthesize _dropFee,_returnLcdFeeRatio;
@synthesize _source;
@synthesize _pick;
-(void)dealloc
{
    self._userId = nil;
    self._contactorPhone  = nil;
    self._postInfo  = nil;
   self. _isAcceptSevice = nil;
   self. _isBuyInsurance = nil;
    self._getItineraryType = nil;
    self._flightType = nil;
    self._isSpecialFlight = nil;
    
    self._passengers = nil;
    self._airline = nil;
    self._flightNo = nil;
    self._planeType = nil;

    self._cabinCode = nil;
    self._baseCabin = nil;
    self._baseCabinPrice = nil;

    self._departureDate = nil;
    self._arrivalDate = nil;

    self._startAirport = nil;
    self._endAirPort = nil;
    self._discount = nil;
    self._fuelTaxForAdult = nil;
    self._fuelTaxForChild = nil;
    self._airportForAdult = nil;
    self._airportForChild = nil;
    self._ticketPriceForAdult = nil;
    self._specialFlightNum = nil;
    
    self._dropFee = nil;
    self._returnLcdFeeRatio = nil;
    self._source = nil;
    self._pick = nil;
    [super dealloc];
}

@end


@implementation InterfaceClass

// 三期访问接口

+(ASIFormDataRequest *)getConfigurationWithDeviceToken:(NSString *)deviceToken version:(NSString *)version userId:(NSString *)userId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getConfiguration",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:deviceToken  forKey:@"deviceToken"];
    [theRequest setPostValue:version      forKey:@"version"];
    [theRequest setPostValue:userId       forKey:@"userId"];
    NSLog (@"deviceToken: %@,version: %@,userId: %@",deviceToken,version,userId);
//    [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"deviceToken: %@,version: %@,userId: %@",deviceToken,version,userId]];
    return theRequest;
}

+(ASIFormDataRequest *)updateAirportList //2
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/updateAirportList",ThreeStagesUrl]]];
    return theRequest;
}

+(ASIFormDataRequest *)updateAirportCityList //3
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/updateAirportCityList",ThreeStagesUrl]]];
    return theRequest;
}
+(ASIFormDataRequest *)updateHotelCityList //4
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/updateHotelCityList",ThreeStagesHotelUrl]]];
    return theRequest;
}
+(ASIFormDataRequest *)updateRentCityList //5
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/updateRentCityList",ThreeStagesCarUrl]]];
    return theRequest;
}
+(ASIFormDataRequest *)updateWeatherCityList //5
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/weatherCityList",ThreeStagesUrl]]];
    return theRequest;
}
+(ASIFormDataRequest *)queryFlightTicketWithDeparture:(NSString *)departure arrival:(NSString *)arrival transitCity:(NSString *)transitCity startDate:(NSString *)startDate returnDate:(NSString *)returnDate flightType:(NSString *)flightType //6
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/queryFlightTicket",ThreeStagesUrl]]];
    [theRequest setPostValue:departure   forKey:@"departure"];
    [theRequest setPostValue:arrival     forKey:@"arrival"];
    [theRequest setPostValue:transitCity forKey:@"transitCity"];
    [theRequest setPostValue:startDate   forKey:@"startDate"];
    [theRequest setPostValue:returnDate  forKey:@"returnDate"];
    [theRequest setPostValue:flightType forKey:@"flightType"];
    [theRequest setPostValue:MyVersion forKey:@"versionName"];// zxt 查询海航机票，添加版本，区别以前版本
    return theRequest;
}

+(ASIFormDataRequest *)queryFlightTicketDetailWithDeparture :(NSString *)departure arrival:(NSString *)arrival flightNo:(NSString *)flightNo departureDate:(NSString *)departureDate airline:(NSString *)airline planeType:(NSString *)planeType  isStop:(NSString *)isStop startAirportCode:(NSString *)startAirportCode endAirportCode:(NSString *)endAirportCode isAdultTax:(NSString *)isAdultTax//7
{
    //startAirportCode: "起飞机场三字码",
    //endAirportCode: "降落机场三字码",
    
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/queryFlightTicketDetail",ThreeStagesUrl]]];
    [theRequest setPostValue:departure   forKey:@"departure"];
    [theRequest setPostValue:arrival     forKey:@"arrival"];
    [theRequest setPostValue:flightNo forKey:@"flightNo"];
    [theRequest setPostValue:departureDate  forKey:@"departureDate"];
    [theRequest setPostValue:airline   forKey:@"airline"];
    [theRequest setPostValue:planeType  forKey:@"planeType"];
    [theRequest setPostValue:isStop  forKey:@"isStop"];
    [theRequest setPostValue:startAirportCode  forKey:@"startAirportCode"];
    [theRequest setPostValue:endAirportCode  forKey:@"endAirportCode"];
    [theRequest setPostValue:isAdultTax  forKey:@"isAdultTax"];

    return theRequest;
}

+(ASIFormDataRequest *)submitOrder:(OrderInfo *)orderInfo
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/submitOrder",ThreeStagesUrl]]];

    [theRequest setPostValue:orderInfo._userId          forKey:@"userId"];
    [theRequest setPostValue:orderInfo._contactorPhone  forKey:@"contactorPhone"];
    [theRequest setPostValue:orderInfo._postInfo        forKey:@"postInfo"];
    [theRequest setPostValue:[NSString stringWithFormat:@"%@",orderInfo._isAcceptSevice]  forKey:@"isAcceptService"];
    [theRequest setPostValue:[NSString stringWithFormat:@"%@",orderInfo._isBuyInsurance]   forKey:@"isBuyInsurance"];
    [theRequest setPostValue:orderInfo._getItineraryType  forKey:@"getItineraryType"];
    [theRequest setPostValue:orderInfo._flightType       forKey:@"flightType"];
    [theRequest setPostValue:orderInfo._isSpecialFlight   forKey:@"isSpecialFlight"];
    
    [theRequest setPostValue:orderInfo._passengers       forKey:@"passengers"];
    [theRequest setPostValue:orderInfo._airline          forKey:@"airline"];  
    [theRequest setPostValue:orderInfo._flightNo         forKey:@"flightNo"];
    [theRequest setPostValue:orderInfo._planeType        forKey:@"planeType"];
    [theRequest setPostValue:orderInfo._cabinCode        forKey:@"cabinCode"];
    [theRequest setPostValue:orderInfo._baseCabin        forKey:@"baseCabin"];
    [theRequest setPostValue:orderInfo._baseCabinPrice        forKey:@"baseCabinPrice"];
    [theRequest setPostValue:orderInfo._departureDate        forKey:@"departureDate"];
    [theRequest setPostValue:orderInfo._arrivalDate          forKey:@"arrivalDate"];
    [theRequest setPostValue:orderInfo._startAirport     forKey:@"startAirport"];
    [theRequest setPostValue:orderInfo._endAirPort       forKey:@"endAirport"];
    [theRequest setPostValue:orderInfo._discount         forKey:@"discount"];
    [theRequest setPostValue:orderInfo._fuelTaxForAdult          forKey:@"fuelTaxForAdult"];
    [theRequest setPostValue:orderInfo._fuelTaxForChild          forKey:@"fuelTaxForChild"];
    [theRequest setPostValue:orderInfo._airportForAdult          forKey:@"airportTaxForAdult"];
    [theRequest setPostValue:orderInfo._airportForChild          forKey:@"airportTaxForChild"];
    [theRequest setPostValue:orderInfo._ticketPriceForAdult       forKey:@"ticketPriceForAdult"];
    [theRequest setPostValue:orderInfo._specialFlightNum forKey:@"specialFlightNum"];
    [theRequest setPostValue:orderInfo._dropFee       forKey:@"dropFee"];
    [theRequest setPostValue:orderInfo._returnLcdFeeRatio forKey:@"returnLcdFeeRatio"];
    [theRequest setPostValue:orderInfo._source forKey:@"source"];
    [theRequest setPostValue:orderInfo._pick forKey:@"pick"];

    return theRequest;
}

+(ASIFormDataRequest *)getPassengerList:(NSString *)userId //9
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getPassengerList",ThreeStagesUrl]]];
    [theRequest setPostValue:userId forKey:@"userId"];
    return theRequest;
}

+(ASIFormDataRequest *)addPassengersWithUserId:(NSString *)userId name:(NSString *)name type:(NSString *)type certType:(NSString *)certType birthday:(NSString *)birthday
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/addPassengers",ThreeStagesUrl]]];
    [theRequest setPostValue:userId     forKey:@"userId"];
    [theRequest setPostValue:name       forKey:@"name"];
    [theRequest setPostValue:[NSNumber numberWithInt:[type intValue]]     forKey:@"type"];
    [theRequest setPostValue:[NSNumber numberWithInt:[certType intValue]] forKey:@"certType"];
    [theRequest setPostValue:birthday   forKey:@"birthday"];
    return theRequest;
}

+(ASIFormDataRequest *)deletePassengersWithUserId:(NSString *)userId ids:(NSString *)Ids //11
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/deletePassengers",ThreeStagesUrl]]];
    [theRequest setPostValue:userId     forKey:@"userId"];
    [theRequest setPostValue:Ids        forKey:@"Ids"];
    return theRequest;
}

+(ASIFormDataRequest *)updatePassengersWithUserId:(NSString *)userId ids:(NSString *)ids name:(NSString *)name type:(NSString *)type certType:(NSString *)certType birthday:(NSString *)birthday //12
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/updatePassengers",ThreeStagesUrl]]];
    [theRequest setPostValue:userId     forKey:@"userId"];
    [theRequest setPostValue:ids         forKey:@"id"];
    [theRequest setPostValue:name       forKey:@"name"];
    [theRequest setPostValue:[NSNumber numberWithInt:[type intValue]]       forKey:@"type"];
    [theRequest setPostValue:[NSNumber numberWithInt:[certType intValue]]   forKey:@"certType"];
    [theRequest setPostValue:birthday   forKey:@"birthday"];
    return theRequest;
}

+(ASIFormDataRequest *)getUserAddress:(NSString *)userId //13
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getUserAddress",ThreeStagesUrl]]];
    [theRequest setPostValue:userId     forKey:@"userId"];
    return theRequest;
}



+(ASIFormDataRequest *)deleteUserAddressWithUserId:(NSString *)userId ids:(NSString *)Ids //16
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/deleteUserAddress",ThreeStagesUrl]]];
    
    [theRequest setPostValue:userId     forKey:@"userId"];
    [theRequest setPostValue:Ids        forKey:@"Ids"];

    return theRequest;
}

+(ASIFormDataRequest *)getMessageState:(NSString *)userId withOrderId:(NSString *)orderId withPayMoney:(NSString *)payMoney withPayCoin:(NSString *)payCoin withPayType:(NSString *)payType //17
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ssl/getMessageState",ThreeStagesHttpsUrl]]];
	[theRequest setPostValue:userId     forKey:@"userId"];	
	[theRequest setPostValue:orderId    forKey:@"orderId"];
    [theRequest setPostValue:payMoney   forKey:@"payMoney"];
    [theRequest setPostValue:payCoin    forKey:@"payCoin"];
    [theRequest setPostValue:payType   forKey:@"payType"];
    if ([payType isEqualToString:@"5"]) {
        [theRequest setPostValue:@"192.168.1.1"   forKey:@"ip"];
    }
    else
    {
        [theRequest setPostValue:@""   forKey:@"ip"];
    }
	return theRequest;
}

+(ASIFormDataRequest *)getOrdersState:(NSString *)userId withOrderId:(NSString *)orderId withTimes:(NSString *)times withPayType:(NSString *)payType withPackets:(NSString *)packets //18
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ssl/getOrdersState",ThreeStagesHttpsUrl]]];
	[theRequest setPostValue:userId     forKey:@"userId"];	
	[theRequest setPostValue:orderId    forKey:@"orderId"];
    [theRequest setPostValue:[NSNumber numberWithInt:[times intValue]]   forKey:@"times"];
    [theRequest setPostValue:[NSNumber numberWithInt:[payType intValue]] forKey:@"payType"];
    [theRequest setPostValue:packets    forKey:@"packets"];
	return theRequest;
}

+(ASIFormDataRequest *)getFlightDynamicByFlightNoWithUserId:(NSString *)userId flightNo:(NSString *)flightNo //19
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getFlightDynamicByFlightNo",ThreeStagesUrl]]];
    
    [theRequest setPostValue:userId     forKey:@"userId"];
    [theRequest setPostValue:flightNo        forKey:@"flightNo"];
    
    return theRequest;
}
+(ASIFormDataRequest *)getFlightDynamicByStartArrival:(NSString *)departure arrival:(NSString *)arrival //20
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getFlightDynamicByStartArrival",ThreeStagesUrl]]];
    
    [theRequest setPostValue:departure     forKey:@"departure"];
    [theRequest setPostValue:arrival        forKey:@"arrival"];
    
    return theRequest;
}
+(ASIFormDataRequest *)getMyAttentionListWithUserId:(NSString *)userId //21
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getMyAttentionList",ThreeStagesUrl]]];
    
    [theRequest setPostValue:userId     forKey:@"userId"];
    
    return theRequest;
}
+(ASIFormDataRequest *)setAttentionStateWithUserId:(NSString *)userId flightNo:(NSString *)flightNo departure:(NSString*)departure arrival:(NSString*)arrival //22
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/setAttentionState",ThreeStagesUrl]]];
    
    [theRequest setPostValue:userId     forKey:@"userId"];
    [theRequest setPostValue:flightNo     forKey:@"flightNo"];
    [theRequest setPostValue:departure     forKey:@"departure"];
    [theRequest setPostValue:arrival     forKey:@"arrival"];
    
    return theRequest;
}
+(ASIFormDataRequest *)cancelAttentionStateWithUserId:(NSString *)userId ids:(NSString *)Ids //23
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/cancelAttentionState",ThreeStagesUrl]]];
    
    [theRequest setPostValue:userId     forKey:@"userId"];
    [theRequest setPostValue:Ids     forKey:@"id"];
    
    return theRequest;
}
+(ASIFormDataRequest *)memberLoginWithTelephone:(NSString *)telephone password:(NSString *)password //24
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/memberLogin",ThreeStagesUrl]]];
    
    [theRequest setPostValue:telephone  forKey:@"telephone"];
    [theRequest setPostValue:password   forKey:@"password"];

    return theRequest;
}

+(ASIFormDataRequest *)memberRegisterWithTelephone:(NSString *)telephone password:(NSString *)password checkCode:(NSString *)checkCode recommendCode:(NSString *)recommendCode //25
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/memberRegister",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:telephone     forKey:@"telephone"];
    [theRequest setPostValue:password      forKey:@"password"];
    [theRequest setPostValue:checkCode     forKey:@"checkCode"];
    [theRequest setPostValue:recommendCode forKey:@"recommendCode"];
    return theRequest;
}

+(ASIFormDataRequest *)getVerificationCode:(NSString *)telephone //26
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ssl/getVerificationCode",ThreeStagesHttpsUrl]]];
    [theRequest setPostValue:telephone     forKey:@"telephone"];
    return theRequest;
}

+(ASIFormDataRequest *)updatePasswordWithUserId:(NSString *)userId oldPassword:(NSString *)oldPassword password:(NSString *)password //27
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/updatePassword",ThreeStagesUrl]]];
    [theRequest setPostValue:userId      forKey:@"userId"];
    [theRequest setPostValue:oldPassword forKey:@"oldPassword"];
    [theRequest setPostValue:password    forKey:@"password"];
    return theRequest;
}

+(ASIFormDataRequest *)forgetPasswordWithUserId:(NSString *)userId password:(NSString *)password checkCode:(NSString *)checkCode //28
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/forgetPassword",ThreeStagesUrl]]];
    [theRequest setPostValue:userId     forKey:@"userId"];
    [theRequest setPostValue:password   forKey:@"password"];
    [theRequest setPostValue:checkCode  forKey:@"checkCode"];
    return theRequest;
}

+(ASIFormDataRequest *)deleteReservation:(NSString *)id //39
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/deleteReservation",ThreeStagesUrl]]];
    [theRequest setPostValue:id         forKey:@"id"];
    return theRequest;
}

+(ASIFormDataRequest *)queryAutomaticallyDroppedList:(NSString *)userId //40
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/queryAutomaticallyDroppedList",ThreeStagesUrl]]];
    [theRequest setPostValue:userId     forKey:@"userId"];
    return theRequest;
}


+(ASIFormDataRequest *)getNewPassengerList:(NSString *)userId //9
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getPassengerList",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];	
	return theRequest;
}

+(ASIFormDataRequest *)addPassengers:(NSString *)userId withName:(NSString *)name withType:(NSString *)type withCertType:(NSString *)certType withCertNum:(NSString *)certNum withBirthday:(NSString *)birthday withSex:(NSString *)sex//10
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/addPassengers",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:name forKey:@"name"];
	[theRequest setPostValue:type forKey:@"type"];
	[theRequest setPostValue:certType forKey:@"certType"];
	[theRequest setPostValue:certNum forKey:@"certNum"];
	[theRequest setPostValue:birthday forKey:@"birthday"];
    [theRequest setPostValue:sex forKey:@"gender"];
	return theRequest;
}

+(ASIFormDataRequest *)deletePassengers:(NSString *)userId withIds:(NSString *)Ids //11
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/deletePassengers",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];	
	[theRequest setPostValue:Ids forKey:@"ids"];
	return theRequest;
}

+(ASIFormDataRequest *)updatePassengers:(NSString *)userId withId:(NSString *)aid withName:(NSString *)name withType:(NSString *)type withCertType:(NSString *)certType withCertNum:(NSString *)certNum withBirthday:(NSString *)birthday withGender:(NSString *)gender//12
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/updatePassengers",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:aid forKey:@"id"];
	[theRequest setPostValue:name forKey:@"name"];
	[theRequest setPostValue:type forKey:@"type"];
	[theRequest setPostValue:certType forKey:@"certType"];
	[theRequest setPostValue:certNum forKey:@"certNum"];
	[theRequest setPostValue:birthday forKey:@"birthday"];
    [theRequest setPostValue:gender forKey:@"gender"];
	return theRequest;
}


+(ASIFormDataRequest *)getNewUserAddress:(NSString *)userId //13
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getUserAddress",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];	
	return theRequest;
}

+(ASIFormDataRequest *)addUserAddress:(NSString *)userId withName:(NSString *)name withPostCode:(NSString *)postCode withPostalAddress:(NSString *)postalAddress withMobile:(NSString *)mobile withProvince:(NSString *)province withCity:(NSString *)city withCounty:(NSString *)county//14
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/addUserAddress",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:name forKey:@"name"];
	[theRequest setPostValue:postCode forKey:@"postCode"];
	[theRequest setPostValue:postalAddress forKey:@"postalAddress"];
	[theRequest setPostValue:mobile forKey:@"mobile"];
    [theRequest setPostValue:county forKey:@"area"];
    [theRequest setPostValue:city forKey:@"city"];
    [theRequest setPostValue:province forKey:@"province"];
	
	return theRequest;
}
+(ASIFormDataRequest *)updateUserAddress:(NSString *)userId withId:(NSString *)aid withName:(NSString *)name withPostCode:(NSString *)postCode withPostalAddress:(NSString *)postalAddress withMobile:(NSString *)mobile withProvince:(NSString *)province withCity:(NSString *)city withCounty:(NSString *)county//15
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/updateUserAddress",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:aid forKey:@"id"];
	[theRequest setPostValue:name forKey:@"name"];
	[theRequest setPostValue:postCode forKey:@"postCode"];
	[theRequest setPostValue:postalAddress forKey:@"postalAddress"];
	[theRequest setPostValue:mobile forKey:@"mobile"];
    [theRequest setPostValue:county forKey:@"area"];
    [theRequest setPostValue:city forKey:@"city"];
    [theRequest setPostValue:province forKey:@"province"];
	
	return theRequest;
}
+(ASIFormDataRequest *)deleteUserAddress:(NSString *)userId withIds:(NSString *)Ids//16
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/deleteUserAddress",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];	
	[theRequest setPostValue:Ids forKey:@"Ids"];
	return theRequest;
}

+(ASIFormDataRequest *)memberLogin:(NSString *)telephone withUserPassword:(NSString *)password //24
{
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/memberLogin",ThreeStagesUrl]];
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:url];
	
	[theRequest setPostValue:telephone forKey:@"telephone"];
	[theRequest setPostValue:password forKey:@"password"];
	
	return theRequest;
}

+(ASIFormDataRequest *)memberNewRegister:(NSString *)telephone withUserPassword:(NSString *)password withCheckCode:(NSString *)checkCode WithrecommendCode:(NSString *)recommendCode //25
{
	
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/memberRegister",ThreeStagesUrl]]];
	[theRequest setPostValue:telephone forKey:@"telephone"];
	[theRequest setPostValue:password forKey:@"password"];
	[theRequest setPostValue:checkCode forKey:@"checkCode"];
	[theRequest setPostValue:recommendCode forKey:@"recommendCode"];

	return theRequest;
}

+(ASIFormDataRequest *)getNewVerificationCode:(NSString *)telephone withType:(NSString *)type //26
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ssl/getVerificationCode",ThreeStagesHttpsUrl]]];
	
	[theRequest setPostValue:telephone forKey:@"telephone"];
	[theRequest setPostValue:type forKey:@"type"];
	return theRequest;
}

+(ASIFormDataRequest *)updateNewPassword:(NSString *)userId withOldPassword:(NSString *)oldPassword withNewPassword:(NSString *)password//27
{
       ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/updatePassword",ThreeStagesUrl]]];
       [theRequest setPostValue:userId forKey:@"userId"];
       [theRequest setPostValue:oldPassword forKey:@"oldPassword"];
       [theRequest setPostValue:password forKey:@"password"];

       return theRequest;
}

+(ASIFormDataRequest *)forgetPassword:(NSString *)telephone withPassword:(NSString *)password withCheckCode:(NSString *)checkCode//28
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/forgetPassword",ThreeStagesUrl]]];
	[theRequest setPostValue:telephone forKey:@"telephone"];
	[theRequest setPostValue:password forKey:@"password"];
	[theRequest setPostValue:checkCode forKey:@"checkCode"];
	
	return theRequest;
}

+(ASIFormDataRequest *)editPersonalInformation:(NSString *)userId withName:(NSString *)name withEmail:(NSString *)email withSex:(NSString *)sex withBirthday:(NSString *)birthday withPostalAddress:(NSString *)postalAddress withPostCode:(NSString *)postCode withCardNo:(NSString *)cardNo//29

{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/editPersonalInformation",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:name forKey:@"name"];
	[theRequest setPostValue:email forKey:@"email"];
	[theRequest setPostValue:sex forKey:@"sex"];
	[theRequest setPostValue:birthday forKey:@"birthday"];
	[theRequest setPostValue:postalAddress forKey:@"postalAddress"];
	[theRequest setPostValue:postCode forKey:@"postCode"];
	[theRequest setPostValue:[NSString stringWithFormat:@"%d",0] forKey:@"cardType"];
	[theRequest setPostValue:cardNo forKey:@"cardNo"];
	return theRequest;
}
+(ASIFormDataRequest *)myLCDCoin:(NSString *)userId withPage:(NSString *)page //30
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/myLCDCoin",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:page forKey:@"page"];
	
	return theRequest;
}

+(ASIFormDataRequest *)flightsOrdersList:(NSString *)userId withPageIndex:(NSString *)pageIndex//31
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/flightsOrdersList",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:pageIndex forKey:@"pageIndex"];
	return theRequest;
}

+(ASIFormDataRequest *)flightsOrderDetails:(NSString *)orderId //32
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/flightsOrderDetails",ThreeStagesUrl]]];
	[theRequest setPostValue:orderId forKey:@"orderId"];
	
	return theRequest;
}

+ (ASIFormDataRequest *)updateOrder:(NSString *)orderId withContactorPhone:(NSString *)telephone withItineraryType:(NSString *)getItineraryType withPostInfo:(NSString *)postInfo withAcceptService:(NSString *)isAcceptService //33
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/updateOrder",ThreeStagesUrl]]];
	[theRequest setPostValue:orderId forKey:@"orderId"];
    [theRequest setPostValue:telephone forKey:@"contactorPhone"];
    [theRequest setPostValue:getItineraryType forKey:@"getItineraryType"];
    [theRequest setPostValue:postInfo forKey:@"postInfo"];
    [theRequest setPostValue:isAcceptService forKey:@"isAcceptService"];
	
	return theRequest;
}

+ (ASIFormDataRequest *)queryTicketNumberInformation:(NSString *)ticketNumber   //34
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/queryTicketNumberInformation",ThreeStagesUrl]]];
	[theRequest setPostValue:ticketNumber forKey:@"ticketNumber"];
	return theRequest;
}

+ (ASIFormDataRequest *)refund:(NSString *)ticketNumber withRefundType:(NSString *)refundType //35
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Refund",ThreeStagesUrl]]];
	[theRequest setPostValue:ticketNumber forKey:@"ticketNumber"];
	[theRequest setPostValue:refundType forKey:@"refundType"];
	return theRequest;
}

+(ASIFormDataRequest *)submitAdvise:(NSString *)userId withProblem:(NSString *)problem withMobilNumber:(NSString *)mobilNumber withEmail:(NSString *)email //47
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/feedback",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:problem forKey:@"message"];
	[theRequest setPostValue:mobilNumber forKey:@"phone"];
	[theRequest setPostValue:email forKey:@"email"];
	return theRequest;
}


+(ASIFormDataRequest *)addReservation:(NSString *)userId withCabinDiscount:(NSString *)cabinDiscount withDeparture:(NSString *)departure withArrival:(NSString *)arrival withStarteDate:(NSString *)starteDate withEndDate:(NSString *)endDate withFlyPeriod:(NSString *)flyPeriod withEndPeriod:(NSString *)endPeriod  withSmsTime:(NSString *)smsTime withEndSmsTime:(NSString *)endSmsTime //36
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/addReservation",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:cabinDiscount forKey:@"cabinDiscount"];
	[theRequest setPostValue:departure forKey:@"departure"];
	[theRequest setPostValue:arrival forKey:@"arrival"];
	[theRequest setPostValue:starteDate forKey:@"starteDate"];
	[theRequest setPostValue:endDate forKey:@"endDate"];
	[theRequest setPostValue:flyPeriod forKey:@"flyPeriod"];
	[theRequest setPostValue:endPeriod forKey:@"endPeriod"];
	[theRequest setPostValue:smsTime forKey:@"smsTime"];
	[theRequest setPostValue:endSmsTime forKey:@"endSmsTime"];
	return theRequest;
}
+(ASIFormDataRequest *)queryReservationList:(NSString *)userId; //37
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/queryReservationList",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	return theRequest;
}
+(ASIFormDataRequest *)queryReservationDetail:(NSString *)aid; //38
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/queryReservationDetail",ThreeStagesUrl]]];
	[theRequest setPostValue:aid forKey:@"id"];
	return theRequest;
}
+(ASIFormDataRequest *)deleteNewReservation:(NSString *)aid; //39
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/deleteReservation",ThreeStagesUrl]]];
	[theRequest setPostValue:aid forKey:@"id"];
	return theRequest;
}

+(ASIFormDataRequest *)queryNewAutomaticallyDroppedList:(NSString *)userId; //40
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/queryAutomaticallyDroppedList",ThreeStagesUrl]]];
	[theRequest setRequestMethod:@"POST"];
	[theRequest setPostValue:userId forKey:@"userId"];
	return theRequest;
}

+(ASIFormDataRequest *)queryAutomaticallyDroppedDetail:(NSString *)ticketNo; //41
{
	NSLog(@"ticketNo= %@",ticketNo);
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/queryAutomaticallyDroppedDetail",ThreeStagesUrl]]];
	[theRequest setPostValue:ticketNo forKey:@"ticketNo"];
	return theRequest;
}

+(ASIFormDataRequest *)queryWeatherInfoByAirportCode:(NSString *)airportCode //42
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/queryWeatherInfo",ThreeStagesUrl]]];
	[theRequest setPostValue:airportCode forKey:@"airportCode"];
	return theRequest;
}

+(ASIFormDataRequest *)queryFacilityServiceByAirportCode:(NSString *)airportCode
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/queryFacilityService",ThreeStagesUrl]]];
	[theRequest setPostValue:airportCode forKey:@"airportCode"];
	return theRequest;
}


+(ASIFormDataRequest *)gelaysByAirportCode:(NSString *)airportCode
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/gelays",ThreeStagesUrl]]];
	[theRequest setPostValue:airportCode forKey:@"airportCode"];
	return theRequest;
}



+(ASIFormDataRequest *)orderCarListByUserId:(NSString *)userId withPageIndex:(NSString *)pageIndex//69
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/orderCarList",ThreeStagesCarUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:pageIndex forKey:@"pageIndex"];
	return theRequest;
}

+(ASIFormDataRequest *)orderCarInformationByorderId:(NSString *)orderId//70
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/orderCarInformation",ThreeStagesCarUrl]]];
	[theRequest setPostValue:orderId forKey:@"orderId"];
	return theRequest;
}

+(ASIFormDataRequest *)deleteOrderCarByorderId:(NSString *)orderId//71
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/deleteOrderCar",ThreeStagesCarUrl]]];
	[theRequest setPostValue:orderId forKey:@"orderId"];
	return theRequest;
}

+(ASIFormDataRequest *)searchRule:(NSString *)airCode withCabin:(NSString *)cabin withTime:flightStartTime withSpecialFlightNum:(NSString *)specialFlightNum //72
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/searchRule",ThreeStagesUrl]]];
	[theRequest setPostValue:airCode            forKey:@"airCode"];
    [theRequest setPostValue:cabin              forKey:@"cabin"];
    [theRequest setPostValue:flightStartTime    forKey:@"flightStartTime"];
    [theRequest setPostValue:specialFlightNum   forKey:@"specialFlightNum"];
	return theRequest;
}

+(ASIFormDataRequest *)bookingShowMessages:(NSString *)flightNo withCabin:(NSString *)cabin withBaseCabin:(NSString *)baseCabin withdeparture:(NSString *)departure withArrival:(NSString *)arrival   withDepartureDate:(NSString *)departureDate withArrivalDate:(NSString *)arrivalDate   returnFlightNo:(NSString *)returnFlightNo withreturnCabin:(NSString *)returnCabin withreturnBaseCabin:(NSString *)returnBaseCabin withreturnDeparture:(NSString *)returnDeparture withreturnArrival:(NSString *)returnArrival   withreturnDepartureDate:(NSString *)returnDepartureDate withreturnArrivalDate:(NSString *)returnArrivalDate

{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/bookingShowMessages",ThreeStagesUrl]]];
    [theRequest setPostValue:flightNo            forKey:@"flightNo"];
    [theRequest setPostValue:cabin              forKey:@"cabin"];
    [theRequest setPostValue:baseCabin    forKey:@"baseCabin"];
    [theRequest setPostValue:departure   forKey:@"departure"];
    [theRequest setPostValue:arrival              forKey:@"arrival"];
    [theRequest setPostValue:departureDate    forKey:@"departureDate"];
    [theRequest setPostValue:arrivalDate   forKey:@"arrivalDate"];
    [theRequest setPostValue:returnFlightNo            forKey:@"returnFlightNo"];
    [theRequest setPostValue:returnCabin              forKey:@"returnCabin"];
    [theRequest setPostValue:returnBaseCabin    forKey:@"returnBaseCabin"];
    [theRequest setPostValue:returnDeparture   forKey:@"returnDeparture"];
    [theRequest setPostValue:returnArrival              forKey:@"returnArrival"];
    [theRequest setPostValue:returnDepartureDate    forKey:@"returnDepartureDate"];
    [theRequest setPostValue:returnArrivalDate   forKey:@"returnArrivalDate"];
    return theRequest;
}

+(ASIFormDataRequest *)getTerminalCityList //78
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getTerminalCityList",ThreeStagesUrl]]];
	return theRequest;
}

+(ASIFormDataRequest *)getTerminalInfoByCity:(NSString *)cityCode //77
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getTerminalInfoByCity",ThreeStagesUrl]]];
	[theRequest setPostValue:cityCode            forKey:@"cityCode"];
	return theRequest;
}

+(ASIFormDataRequest *)hotelQueryCreditCard:(HotelQueryCreditCard *)querycard //57
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/queryCreditCard",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:querycard.hotelId             forKey:@"hotelId"];
    [theRequest setPostValue:querycard.roomTypeId          forKey:@"roomTypeId"];
    [theRequest setPostValue:querycard.checkInDate         forKey:@"checkInDate"];
    [theRequest setPostValue:querycard.checkOutDate        forKey:@"checkOutDate"];
    [theRequest setPostValue:querycard.arrivePeriod        forKey:@"arrivePeriod"];
    [theRequest setPostValue:querycard.count               forKey:@"count"];
    [theRequest setPostValue:querycard.rotalPrice          forKey:@"rotalPrice"];
    [theRequest setPostValue:querycard.totalLcdFee          forKey:@"totalLcdFee"];
    [theRequest setPostValue:querycard.minCheckinRooms     forKey:@"minCheckinRooms"];
    [theRequest setPostValue:querycard.firstDayPrice       forKey:@"firstDayPrice"];
    [theRequest setPostValue:querycard.isArriveTimeVouch   forKey:@"isArriveTimeVouch"];
    [theRequest setPostValue:querycard.isRoomCountVouch    forKey:@"isRoomCountVouch"];
    [theRequest setPostValue:querycard.arriveEndTime       forKey:@"arriveEndTime"];
    [theRequest setPostValue:querycard.arriveStartTime     forKey:@"arriveStartTime"];
    [theRequest setPostValue:querycard.roomCount           forKey:@"roomCount"];
    [theRequest setPostValue:querycard.vouchMoneyType      forKey:@"vouchMoneyType"];
    [theRequest setPostValue:querycard.ratePlanId          forKey:@"ratePlanId"];
    [theRequest setPostValue:querycard.lcdActivityId          forKey:@"lcdActivityId"];
	return theRequest;
}

 +(ASIFormDataRequest *)addCreditCard:(UpdateCreditCard *)card //59
 {
     ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/ssl/addCreditCard",ThreeStagesHotelUrl]]];
     [theRequest setPostValue:card._userId forKey:@"userId"];
     [theRequest setPostValue:card._username forKey:@"username"];
     [theRequest setPostValue:card._idCard forKey:@"idCard"];
     [theRequest setPostValue:card._bank forKey:@"bank"];
     [theRequest setPostValue:card._bankId forKey:@"bankId"];
     [theRequest setPostValue:card._bankIdCard forKey:@"bankIdCard"];
     [theRequest setPostValue:card._validityDate forKey:@"validityDate"];
     return theRequest;
 }
 
 +(ASIFormDataRequest *)updateCreditCard:(UpdateCreditCard *)card // 60
 {
     ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/ssl/updateCreditCard",ThreeStagesHotelUrl]]];
     [theRequest setPostValue:[UserInfo sharedUserInfo].userID forKey:@"userId"];
     [theRequest setPostValue:card._id forKey:@"id"];
     [theRequest setPostValue:card._username forKey:@"username"];
     [theRequest setPostValue:card._idCard forKey:@"idCard"];
     [theRequest setPostValue:card._bank forKey:@"bank"];
     [theRequest setPostValue:card._bankId forKey:@"bankId"];
     [theRequest setPostValue:card._bankIdCard forKey:@"bankIdCard"];
     [theRequest setPostValue:card._validityDate forKey:@"validityDate"];
     return theRequest;
 }
+(ASIFormDataRequest *)deleteCreditCard:(NSString *)ids //61
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/ssl/deleteCreditCard",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:ids forKey:@"id"];
	return theRequest;
}
+(ASIFormDataRequest *)submitOrderHotel:(SubmitOrderHotel *)hotelOrder // 62
 {
     ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/ssl/submitOrderHotel",ThreeStagesHotelUrl]]];
     [theRequest setPostValue:hotelOrder._userId forKey:@"userId"];
     [theRequest setPostValue:hotelOrder._roomCount forKey:@"roomCount"];
     [theRequest setPostValue:hotelOrder._guestNames forKey:@"guestNames"];
     [theRequest setPostValue:hotelOrder._connectorMobile forKey:@"connectorMobile"];
     [theRequest setPostValue:hotelOrder._arriveTimeEarly forKey:@"arriveTimeEarly"];
     [theRequest setPostValue:hotelOrder._arriveTimeLate forKey:@"arriveTimeLate"];
     [theRequest setPostValue:hotelOrder._roomTypeId forKey:@"roomTypeId"];
     [theRequest setPostValue:hotelOrder._hotelId forKey:@"hotelId"];
     [theRequest setPostValue:hotelOrder._checkInDate forKey:@"checkInDate"];
     [theRequest setPostValue:hotelOrder._checkOutDate forKey:@"checkOutDate"];
     [theRequest setPostValue:hotelOrder._totalPrice forKey:@"totalPrice"];
     [theRequest setPostValue:hotelOrder._username forKey:@"username"];
     [theRequest setPostValue:hotelOrder._idCard forKey:@"idCard"];
     [theRequest setPostValue:hotelOrder._bankIdCard forKey:@"bankIdCard"];
     [theRequest setPostValue:hotelOrder._bankId forKey:@"bankId"];
     [theRequest setPostValue:hotelOrder._validityDate forKey:@"validityDate"];
     [theRequest setPostValue:hotelOrder._cVV2Code forKey:@"cVV2Code"];
     [theRequest setPostValue:hotelOrder._vouchMoney forKey:@"vouchMoney"];
     [theRequest setPostValue:hotelOrder._vouchSetType forKey:@"vouchSetType"];
     [theRequest setPostValue:hotelOrder._guestType forKey:@"guestType"];
     [theRequest setPostValue:hotelOrder._ratePlanId  forKey:@"ratePlanId"];
     [theRequest setPostValue:hotelOrder._breakfast  forKey:@"breakfast"];
      [theRequest setPostValue:hotelOrder._userType  forKey:@"userType"];
      [theRequest setPostValue:hotelOrder._lcdRate  forKey:@"lcdRate"];
      [theRequest setPostValue:hotelOrder._lcdValue  forKey:@"lcdValue"];
      [theRequest setPostValue:hotelOrder._lcdCurrency  forKey:@"lcdCurrency"];
     [theRequest setPostValue:hotelOrder._lcdActivityId  forKey:@"lcdActivityId"];
     return theRequest;
}
+(ASIFormDataRequest *)orderHotelListByUserId:(NSString *)userId withPageIndex:(NSString *)pageIndex//63
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/orderHotelList",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:pageIndex forKey:@"pageIndex"];
	return theRequest;
}
+(ASIFormDataRequest *)queryCarStore:(NSString *)cityCode //64
{
    ASIFormDataRequest *theRequset = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/queryCarStore",ThreeStagesCarUrl]]];
    [theRequset setPostValue:cityCode forKey:@"cityCode"];
    return theRequset;
};
+(ASIFormDataRequest *)queryCarModel:(SubmitOrderCarInfo *)carModel pageIndex:(int) pageIndex // 65
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/queryCarModel",ThreeStagesCarUrl]]];
    [theRequest setPostValue:carModel._cityCode forKey:@"cityCode"];
    [theRequest setPostValue:carModel._storeCode forKey:@"storeCode"];
    [theRequest setPostValue:carModel._fromDate forKey:@"fromDate"];
    [theRequest setPostValue:carModel._toStoreCode forKey:@"toStoreCode"];
    [theRequest setPostValue:carModel._toDate forKey:@"toDate"];
    [theRequest setPostValue:carModel._toCityCode forKey:@"toCityCode"];
    
//    [theRequest setPostValue:[NSString stringWithFormat:@"%d",pageIndex] forKey:@"pageIndex"];
    return theRequest;
}

+(ASIFormDataRequest *)queryCarService:(SubmitOrderCarInfo *)carService withCode:(NSString *)code// 66
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/queryCarService",ThreeStagesCarUrl]]];
    [theRequest setPostValue:carService._cityCode forKey:@"cityCode"];
    [theRequest setPostValue:carService._storeCode forKey:@"storeCode"];
    [theRequest setPostValue:carService._fromDate forKey:@"fromDate"];
    [theRequest setPostValue:carService._toCityCode forKey:@"toCityCode"];
    [theRequest setPostValue:carService._toStoreCode forKey:@"toStoreCode"];
    [theRequest setPostValue:carService._toDate forKey:@"toDate"];
    [theRequest setPostValue:carService._modeCode forKey:@"modeCode"];
    [theRequest setPostValue:carService._name forKey:@"name"];
    [theRequest setPostValue:carService._identityNumber forKey:@"identityNumber"];
    [theRequest setPostValue:carService._mobileNumber forKey:@"mobileNumber"];
    [theRequest setPostValue:carService._orderType forKey:@"orderType"];
    [theRequest setPostValue:carService._uuid forKey:@"uuid"];
    [theRequest setPostValue:carService._validId forKey:@"validId"];
    [theRequest setPostValue:code forKey:@"validCode"];
    
    return theRequest;
}

+(ASIFormDataRequest *)submitOrderCar:(SubmitOrderCarInfo *)carOrder // 67
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/submitOrderCar",ThreeStagesCarUrl]]];
    [theRequest setPostValue:carOrder._cityCode forKey:@"cityCode"];
    [theRequest setPostValue:carOrder._storeCode forKey:@"storeCode"];
    [theRequest setPostValue:carOrder._toCityCode forKey:@"toCityCode"];
    [theRequest setPostValue:carOrder._toStoreCode forKey:@"toStoreCode"];
    [theRequest setPostValue:carOrder._fromDate forKey:@"fromDate"];
    [theRequest setPostValue:carOrder._toDate forKey:@"toDate"];
    [theRequest setPostValue:carOrder._modeCode forKey:@"modeCode"];
    [theRequest setPostValue:carOrder._vehicleLevel forKey:@"vehicleLevel"];
    [theRequest setPostValue:carOrder._serviceId forKey:@"serviceId"];
    [theRequest setPostValue:carOrder._activityId forKey:@"activityId"];
    [theRequest setPostValue:carOrder._levelType forKey:@"levelType"];
    [theRequest setPostValue:carOrder._selectPackage forKey:@"selectPackage"];
    [theRequest setPostValue:carOrder._uuid forKey:@"uuid"];
    [theRequest setPostValue:carOrder._orderType forKey:@"orderType"];
    [theRequest setPostValue:carOrder._productType forKey:@"productType"];
    return theRequest;
}

+(ASIFormDataRequest *)submitOrderCarInfo:(SubmitOrderCarInfo *)carOrder // 68
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/submitOrderCarInfo",ThreeStagesCarUrl]]];
    [theRequest setPostValue:carOrder._userId forKey:@"userId"];
    [theRequest setPostValue:carOrder._name forKey:@"name"];
    [theRequest setPostValue:carOrder._identityNumber forKey:@"identityNumber"];
    [theRequest setPostValue:carOrder._mobileNumber forKey:@"mobileNumber"];
    [theRequest setPostValue:carOrder._fromDate forKey:@"takeDate"];
    [theRequest setPostValue:carOrder._storeCode forKey:@"takeShopCode"];
    [theRequest setPostValue:carOrder._cityCode forKey:@"takeCity"];
    [theRequest setPostValue:carOrder._toDate forKey:@"returnDate"];
    [theRequest setPostValue:carOrder._toCityCode forKey:@"returnCity"];
    [theRequest setPostValue:carOrder._toStoreCode forKey:@"returnShopCode"];
    [theRequest setPostValue:carOrder._modeCode forKey:@"modeCode"];
    [theRequest setPostValue:carOrder._vehicleLevel forKey:@"vehicleLevel"];
    [theRequest setPostValue:carOrder._serviceId forKey:@"serviceId"];
    [theRequest setPostValue:carOrder._activityId forKey:@"activityId"];
    [theRequest setPostValue:carOrder._deptype forKey:@"deptype"];
    [theRequest setPostValue:carOrder._submitOrderCarRes._lcdRate forKey:@"lcdRate"];
    [theRequest setPostValue:carOrder._submitOrderCarRes._lcdValue forKey:@"lcdValue"];
    [theRequest setPostValue:carOrder._levelType forKey:@"levelType"];
    [theRequest setPostValue:carOrder._selectPackage forKey:@"selectPackage"];
    [theRequest setPostValue:carOrder._uuid forKey:@"uuid"];
    [theRequest setPostValue:carOrder._orderType forKey:@"orderType"];
    [theRequest setPostValue:carOrder._productType forKey:@"productType"];
    return theRequest;
}

+(ASIFormDataRequest *)queryHotel :(HotelRequestPara *) hotelRequestPara //50
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/queryhotel",ThreeStagesHotelUrl]]];
	
	
	[theRequest setPostValue:hotelRequestPara._cityCode forKey:@"cityCode"];
	[theRequest setPostValue:hotelRequestPara._checkInDate forKey:@"checkInDate"];
	[theRequest setPostValue:hotelRequestPara._checkOutDate forKey:@"checkOutDate"];
	[theRequest setPostValue:hotelRequestPara._hotelName forKey:@"hotelName"];
	[theRequest setPostValue:hotelRequestPara._highestPrice forKey:@"highestPrice"];
	[theRequest setPostValue:hotelRequestPara._lowestPrice forKey:@"lowestPrice"];
	[theRequest setPostValue:[NSString stringWithFormat:@"%d",hotelRequestPara._star] forKey:@"star"];
	[theRequest setPostValue:hotelRequestPara._hotelBrandID forKey:@"hotelBrandID"];
	[theRequest setPostValue:hotelRequestPara._longitude forKey:@"longitude"];
	[theRequest setPostValue:hotelRequestPara._latitude forKey:@"latitude"];
	[theRequest setPostValue:[NSString stringWithFormat:@"%d",hotelRequestPara._pageIndex]forKey:@"pageIndex"];
	[theRequest setPostValue:hotelRequestPara._byStar forKey:@"byStar"];
	[theRequest setPostValue:hotelRequestPara._byPrice forKey:@"byPrice"];
	[theRequest setPostValue:hotelRequestPara._administrativeArea forKey:@"administrativeArea"];
	[theRequest setPostValue:hotelRequestPara._isSpecialOffer ? @"true" : @"false" forKey:@"isSpecialOffer"];
	[theRequest setPostValue:hotelRequestPara._businessArea forKey:@"businessArea"];
	return theRequest;
}

+(ASIFormDataRequest *)filterHotel:(NSString *)cityName //51
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/filterHotel",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:cityName forKey:@"cityCode"];
	return theRequest;
}

+(ASIFormDataRequest *)hotelInformation:(NSString *)hotelId withCheckInDate:(NSString *)checkInDate withCheckOutDate:(NSString *)checkOutDate  withLcdRate:(NSString *)lcdRate withLcdValue:(NSString *)lcdValue withUserId:(NSString *)userId//52
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/hotelInformation",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:hotelId forKey:@"hotelId"];
	[theRequest setPostValue:checkInDate forKey:@"checkInDate"];
	[theRequest setPostValue:checkOutDate forKey:@"checkOutDate"];
        [theRequest setPostValue:lcdRate forKey:@"lcdRate"];
	[theRequest setPostValue:lcdValue forKey:@"lcdValue"];
	[theRequest setPostValue:userId forKey:@"userId"];
	return theRequest;
}

+(ASIFormDataRequest *)queryComment:(NSString *)hotelId withPageIndex:(int)pageIndex  //53
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/queryComment",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:hotelId forKey:@"hotelId"];
        [theRequest setPostValue:[NSString stringWithFormat:@"%d",pageIndex]forKey:@"pageIndex"];
	return theRequest;
}

+(ASIFormDataRequest *)checkPersonnelList:(NSString *)userId  //54
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/checkPersonnelList",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	return theRequest;
}

+(ASIFormDataRequest *)addCheckPersonnel:(NSString *)userId withName:(NSString *)name //55
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/addCheckPersonnel",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:name forKey:@"name"];
	return theRequest;
}

+(ASIFormDataRequest *)deleteCheckPersonnel:(NSString *)ids //56
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/deleteCheckPersonnel",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:ids forKey:@"id"];
	return theRequest;
}

+(ASIFormDataRequest *)payLcdCoin:(NSString *)userId withOrderId:(NSString *)orderId withPayCoin:(NSString *)payCoin //80
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ssl/payLcdCoin",ThreeStagesHttpsUrl]]];
	[theRequest setPostValue:userId     forKey:@"userId"];
	[theRequest setPostValue:orderId    forKey:@"orderId"];
    [theRequest setPostValue:payCoin    forKey:@"payCoin"];
	return theRequest;
}
+(ASIFormDataRequest *)creditCardList:(NSString *)userId  //58
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/creditCardList",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	return theRequest;
}

+ (ASIFormDataRequest *)recommendFlightWithDeparture:(NSString *)departure withArrival:(NSString *)arrival withStartDate:(NSString *)startDate //73
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/recommendFlight",ThreeStagesUrl]]];
	[theRequest setPostValue:departure forKey:@"departure"];
	[theRequest setPostValue:arrival forKey:@"arrival"];
    [theRequest setPostValue:startDate forKey:@"startDate"];
    [theRequest setPostValue:MyVersion forKey:@"versionName"];// zxt 查询海航机票，添加版本，区别以前版本
	return theRequest;
}
+ (ASIFormDataRequest *)recommendHotelWithCityName:(NSString *)cityName withCheckInDate:(NSString *)checkInDate //74 cityName 实为 cityCode
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/recommendHotel",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:cityName forKey:@"cityCode"];
    [theRequest setPostValue:checkInDate forKey:@"checkInDate"];
	return theRequest;
}
+ (ASIFormDataRequest *)recommendCarWithCityCode:(NSString *)cityCode withFromDate:(NSString *)fromDate withToDate:(NSString *)toDate //75
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/recommendCar",ThreeStagesCarUrl]]];
	[theRequest setPostValue:cityCode forKey:@"cityCode"];
    [theRequest setPostValue:fromDate forKey:@"fromDate"];
    [theRequest setPostValue:toDate forKey:@"toDate"];
	return theRequest;
}
+(ASIFormDataRequest *)getPersonalInformation:(NSString *)userId  //76
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getPersonalInformation",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	return theRequest;
}

+ (ASIFormDataRequest *)cancelOrder:(NSString *)userId withOrderId:(NSString *)orderId //81
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/cancelOrder",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:orderId forKey:@"orderId"];
	return theRequest;
}

+ (ASIFormDataRequest *)creditCarardPay:(NSString *)userId withOrderId:(NSString *)orderId withPayMoney:(NSString *)payMoney withPayCoin:(NSString *)payCoin withCard:(UpdateCreditCard *)card withPhone:(NSString *)telePhone //82
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ssl/creditCarardPay",ThreeStagesHttpsUrl]]];
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:orderId forKey:@"orderId"];
    [theRequest setPostValue:payMoney forKey:@"payMoney"];
    [theRequest setPostValue:payCoin forKey:@"payCoin"];
    [theRequest setPostValue:telePhone forKey:@"phone"];
    
    [theRequest setPostValue:card._username forKey:@"username"];
    [theRequest setPostValue:card._idCard forKey:@"idCard"];
    [theRequest setPostValue:card._bankId forKey:@"bankId"];
    [theRequest setPostValue:card._bankIdCard forKey:@"bankIdCard"];
    [theRequest setPostValue:card._validityDate forKey:@"validityDate"];
    [theRequest setPostValue:card._cVV2Code forKey:@"cVV2Code"];
    return theRequest;
}

+(ASIFormDataRequest *)updatePassengersName:(NSString *)userId nameIds:(NSString *)nameIds names:(NSString*)names //84
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/updatePassengersName",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:nameIds forKey:@"id"];
    [theRequest setPostValue:names forKey:@"name"];
	return theRequest;
}

+(ASIFormDataRequest *)getBankList //85
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getBankList",ThreeStagesUrl]]];
	return theRequest;
}

+(ASIFormDataRequest *)validateVersion:(NSString *)type versionCode:(NSString*)versionCode //87
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/validateVersion",ThreeStagesUrl]]];
	[theRequest setPostValue:type forKey:@"type"];
	[theRequest setPostValue:versionCode forKey:@"versionCode"];
	return theRequest;
}

// 火车票
+(ASIFormDataRequest *)stationList
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/stationList",ThreeStagesTrainUrl]]];
	return theRequest;
}

+(ASIFormDataRequest *)getTrainVersion
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/version",ThreeStagesTrainUrl]]];
    //ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://192.168.101.110:5500/itkt_train/mvc/train/version"]];
    
	return theRequest;
}

+(ASIFormDataRequest *)searchTrain:(NSString*)startStation endStation:(NSString*)endStation trainNumber:(NSString*)trainNumber searchType:(NSString*)searchType
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/searchTrain2",ThreeStagesTrainUrl]]];
	[theRequest setPostValue:startStation forKey:@"startCity"];
    [theRequest setPostValue:endStation forKey:@"endCity"];
    [theRequest setPostValue:trainNumber forKey:@"trainNumber"];
    [theRequest setPostValue:searchType forKey:@"searchType"];
	return theRequest;
}

+(ASIFormDataRequest *)searchTrainDetail:(NSString *)trainNumber
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/searchTrainDetail",ThreeStagesTrainUrl]]];
    [theRequest setPostValue:trainNumber forKey:@"trainNumber"];
	return theRequest;
}

+ (ASIFormDataRequest *)getCarRentalList:(NSString *)userId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/getCarRentalList",ThreeStagesCarUrl]]];
    [theRequest setPostValue:userId forKey:@"userId"];
	return theRequest;
}

+ (ASIFormDataRequest *)addCarRental:(NSString *)userId name:(NSString *)name identityNumber:(NSString *)num telePhone:(NSString *)tel
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/addCarRental",ThreeStagesCarUrl]]];
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:name forKey:@"name"];
    [theRequest setPostValue:num forKey:@"identityNumber"];
    [theRequest setPostValue:tel forKey:@"tel"];
	return theRequest;
}

+ (ASIFormDataRequest *)updateCarRental:(NSString *)userId orderId:(NSString *)ids name:(NSString *)name identityNumber:(NSString *)num telePhone:(NSString *)tel
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/updateCarRental",ThreeStagesCarUrl]]];
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:ids forKey:@"id"];
    [theRequest setPostValue:name forKey:@"name"];
    [theRequest setPostValue:num forKey:@"identityNumber"];
    [theRequest setPostValue:tel forKey:@"tel"];
	return theRequest;
}

+ (ASIFormDataRequest *)removeCarRental:(NSString *)userId orderId:(NSString *)ids
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/removeCarRental",ThreeStagesCarUrl]]];
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:ids forKey:@"id"];
	return theRequest;
}

+ (ASIFormDataRequest *)getBill:(NSString *)userId//92
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/bill",ThreeStagesUrl]]];
    [theRequest setPostValue:userId forKey:@"userId"];
	return theRequest;
}

+ (ASIFormDataRequest *)registeredForZhiYinCard:(NSString *)userId name:(NSString*)name sex:(NSString*)sex type:(NSString*)type idCard:(NSString*)idCard birthday:(NSString*)birthday telePhone:(NSString*)telePhone tel:(NSString*)tel email:(NSString*)email postCode:(NSString*)postCode postalAddress:(NSString*)postalAddress//93
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/registeredForZhiYinCard",ThreeStagesUrl]]];
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:name forKey:@"name"];
    [theRequest setPostValue:sex forKey:@"sex"];
    [theRequest setPostValue:type forKey:@"type"];
    [theRequest setPostValue:idCard forKey:@"idCard"];
    [theRequest setPostValue:birthday forKey:@"birthday"];
    [theRequest setPostValue:telePhone forKey:@"telePhone"];
    [theRequest setPostValue:tel forKey:@"tel"];
    [theRequest setPostValue:email forKey:@"email"];
    [theRequest setPostValue:postCode forKey:@"postCode"];
    [theRequest setPostValue:postalAddress forKey:@"postalAddress"];
	return theRequest;
}

+(ASIFormDataRequest *)getLcdCurrency:(NSString*)userId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getLcdCurrency",ThreeStagesUrl]]];
    [theRequest setPostValue:userId forKey:@"userId"];
	return theRequest;
}

+ (ASIFormDataRequest *)getHotelOrderById:(NSString *)orderId withUserId:(NSString *)userId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/getHotelOrderById",ThreeStagesHotelUrl]]];
    [theRequest setPostValue:orderId forKey:@"orderNo"];
    [theRequest setPostValue:userId forKey:@"userId"];
	return theRequest;
}

+ (ASIFormDataRequest *)recommendSoft:(NSString *)pageIdndex
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/recommendSoft",ThreeStagesUrl]]];
    [theRequest setPostValue:pageIdndex forKey:@"pageIndex"];
	return theRequest;
}

+(ASIFormDataRequest *)collectionList:(NSString *)userId withPageIndex:(NSString *)pageIndex//67
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/collectionList",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:pageIndex forKey:@"pageIndex"];
	return theRequest;
}


+(ASIFormDataRequest *)collection:(NSString *)userId withHotelId:(NSString *)hotelId//65
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/collection",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:hotelId forKey:@"hotelId"];
	return theRequest;
}

+(ASIFormDataRequest *)cancelCollection:(NSString *)userId withHotelId:(NSString *)hotelId//65
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/cancelCollection",ThreeStagesHotelUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:hotelId forKey:@"hotelId"];
	return theRequest;
}

+(ASIFormDataRequest *)softDownLoad:(NSString *)softId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/softDownLoad",ThreeStagesUrl]]];
	[theRequest setPostValue:softId forKey:@"softId"];
	return theRequest;
}

+(ASIFormDataRequest *)getPickList:(NSString *)userId
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getPickList",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	return theRequest;
}
+(ASIFormDataRequest *)addPick:(NSString *)userId name:(NSString *)name phone:(NSString *)phone
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/addPick",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:name forKey:@"name"];
	[theRequest setPostValue:phone forKey:@"phone"];
	return theRequest;
}
+(ASIFormDataRequest *)deletePick:(NSString *)userId ids:(NSString *)ids
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/deletePick",ThreeStagesUrl]]];
	[theRequest setPostValue:userId     forKey:@"userId"];
	[theRequest setPostValue:ids        forKey:@"ids"];
	return theRequest;
}
+(ASIFormDataRequest *)updatePick:(NSString *)userId ids:(NSString *)ids name:(NSString *)name phone:(NSString *)phone
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/updatePick",ThreeStagesUrl]]];
	[theRequest setPostValue:userId forKey:@"userId"];
	[theRequest setPostValue:ids forKey:@"id"];
	[theRequest setPostValue:name forKey:@"name"];
	[theRequest setPostValue:phone forKey:@"phone"];
	return theRequest;
}
+(ASIFormDataRequest *)saveDeviceToken:(NSString *)deviceToken //107
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/saveDeviceToken",ThreeStagesUrl]]];
	[theRequest setPostValue:deviceToken forKey:@"deviceToken"];
	return theRequest;
}

+(ASIFormDataRequest *)getCityList
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/areaPostcode",ThreeStagesUrl]]];
	return theRequest;
}

+ (ASIFormDataRequest *)getValidCode:(NSString *)phone
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/car/getValidCode",ThreeStagesCarUrl]]];
    [theRequest setPostValue:phone forKey:@"phoneNo"];
    return theRequest;
}

+ (ASIFormDataRequest *)getactivityList
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/activityList",ThreeStagesUrl]]];
    return theRequest;
}

+ (ASIFormDataRequest *)paySecondReturnPayCoin:(NSString *)orderId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/paySecondReturnPayCoin",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:[UserInfo sharedUserInfo].userID forKey:@"userId"];
    [theRequest setPostValue:orderId forKey:@"orderNo"];
    [theRequest setPostValue:[ActivityTimerView shareTimerView]._activitySecond forKey:@"paySecond"];
    return theRequest;
}

+ (ASIFormDataRequest *)totalMileageReturnPayCoin
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/totalMileageReturnPayCoin",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:[UserInfo sharedUserInfo].userID forKey:@"userId"];
    [theRequest setPostValue:[ActivityTimerView shareTimerView]._activityMileage forKey:@"mileage"];
    return theRequest;
}

//沃银火车票接口

+ (ASIFormDataRequest *)findTrainList // 	火车票查询
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/trainMobileController/findTrainList",ThreeStagesWoyinTrainUrl]]];
    [theRequest setPostValue:[BookingModel shareBookingModel]._quaryInfo._quaryDate._nameCode forKey:@"startDate"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._quaryInfo._toStationCode forKey:@"toStationCode"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._quaryInfo._fromStationCode forKey:@"fromStationCode"];
    return theRequest;
}
+ (ASIFormDataRequest *)findTrainListWithStartDate:(NSString *)startDate   // 	火车票查询
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/trainMobileController/findTrainList",ThreeStagesWoyinTrainUrl]]];
    [theRequest setPostValue:startDate forKey:@"startDate"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._quaryInfo._toStationCode forKey:@"toStationCode"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._quaryInfo._fromStationCode forKey:@"fromStationCode"];
    return theRequest;
}
+ (ASIFormDataRequest *)findStationList   // 	车站查询
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/trainMobileController/findStationList",ThreeStagesWoyinTrainUrl]]];
    return theRequest;
}
+ (ASIFormDataRequest *)findPreSalePeriod // 	预售期查询
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/trainMobileController/findPreSalePeriod",ThreeStagesWoyinTrainUrl]]];
    return theRequest;
}
+ (ASIFormDataRequest *)findOrderSimpleList   // 	订单查询
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/orderMobileController/findOrderSimpleList",ThreeStagesWoyinTrainUrl]]];
    [theRequest setPostValue:[UserInfo sharedUserInfo].userID forKey:@"userId"];
    [theRequest setPostValue:[NSString stringWithFormat:@"%d", MyVersionCode] forKey:@"version"];
    [theRequest setPostValue:@"1" forKey:@"pageIndex"];

    return theRequest;
}
+ (ASIFormDataRequest *)findOrderPollInfoWithID:(NSString *)orderId   // 	订单轮询查询
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/orderMobileController/findOrderPollInfo",ThreeStagesWoyinTrainUrl]]];
    [theRequest setPostValue:orderId forKey:@"orderId"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)findOrderDetailListWithID:(NSString *)orderId   // 	订单详情查询
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/orderMobileController/findOrderDetailList",ThreeStagesWoyinTrainUrl]]];
    [theRequest setPostValue:orderId forKey:@"orderId"];
    [theRequest setPostValue:[NSString stringWithFormat:@"%d", MyVersionCode] forKey:@"version"];
    
    return theRequest;
}
+ (ASIFormDataRequest *)applyForSeat;   // 	提交订单
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/orderMobileController/applyForSeat",ThreeStagesWoyinTrainUrl]]];
    
    NSArray * keys = nil;
    NSArray * values = nil;
    
//    keys = [NSArray arrayWithObjects:@"useId", @"trainNumber",@"fromStationName",@"fromStationCode",@"toStationName",@"toStationCode",@"trainDate",@"fromStationTime",@"toStationTime",nil];
//    values = [NSArray arrayWithObjects:[BookingModel shareBookingModel]._userId, [BookingModel shareBookingModel]._selectTrain._trainNumber,[BookingModel shareBookingModel]._quaryInfo._fromStationName,[BookingModel shareBookingModel]._quaryInfo._fromStationCode,[BookingModel shareBookingModel]._quaryInfo._toStationName,[BookingModel shareBookingModel]._quaryInfo._toStationCode,[BookingModel shareBookingModel]._quaryInfo._quaryDate._nameCode,[BookingModel shareBookingModel]._selectTrain._startTime,[BookingModel shareBookingModel]._selectTrain._arriveTime,nil];
//    
//    NSDictionary * trainInfo = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    
    keys = [NSArray arrayWithObjects:@"linkmanId",@"linkmanName",@"telPhone", nil];
    values = [NSArray arrayWithObjects:[BookingModel shareBookingModel]._linkmanInfo._linkmanId,[BookingModel shareBookingModel]._linkmanInfo._linkmanName,[BookingModel shareBookingModel]._linkmanInfo._telPhone, nil];
    NSDictionary * linkmanTicketInfo = [NSDictionary dictionaryWithObjects:values forKeys:keys];

    NSMutableArray * orderPassengerList = [NSMutableArray array];
    NSLog(@"%@", [BookingModel shareBookingModel]._passageInfoList);
    for (TrainPassagerInfo * info in [BookingModel shareBookingModel]._passageInfoList)
    {
        NSLog(@"%@",info);
        keys = [NSArray arrayWithObjects:@"passengerId",@"passengerName",@"passengerType",@"childName",@"idType",@"idNo",@"sex",@"birthday",@"seatType",@"seatTypeName",@"seatPrice",@"insuranceType",@"insurancePrice",@"servicePrice", nil];
        values = [NSArray arrayWithObjects:info._passengerId,info._passageName,info._passengerType, info._childrenName,info._idType,info._idNo,info._sex,info._birthDay,info._seat._type,info._seat._name,info._seat._price,info._service._insuranceType,info._service._insuranceCost,info._service._serviceCost, nil];
        NSDictionary * pDic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
        [orderPassengerList addObject:pDic];
    }
    
    [theRequest setPostValue:[BookingModel shareBookingModel]._userId forKey:@"useId"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._selectTrain._trainNumber forKey:@"trainNumber"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._quaryInfo._fromStationName  forKey:@"fromStationName"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._quaryInfo._fromStationCode forKey:@"fromStationCode"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._quaryInfo._toStationName forKey:@"toStationName"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._quaryInfo._toStationCode forKey:@"toStationCode"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._quaryInfo._quaryDate._nameCode forKey:@"trainDate"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._selectTrain._startTime forKey:@"fromStationTime"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._selectTrain._arriveTime forKey:@"toStationTime"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._selectTrain._runTime forKey:@"runTime"];
    [theRequest setPostValue:[BookingModel shareBookingModel]._selectTrain._arriveDays forKey:@"arriveDays"];
    [theRequest setPostValue:[orderPassengerList JSONRepresentation] forKey:@"passengerTicketList"];
    [theRequest setPostValue:[linkmanTicketInfo JSONRepresentation] forKey:@"linkmanTicketInfo"];
    
    keys = [NSArray arrayWithObjects:@"ifInvoice",@"mailType",@"addressee",@"telPhone",@"address",@"invoiceTitle",@"mailPostalcode",nil];
    values = [NSArray arrayWithObjects:[BookingModel shareBookingModel]._ifneedMail?@"true":@"false",[BookingModel shareBookingModel]._mailInfo._mailType,[BookingModel shareBookingModel]._mailInfo._addressee,[BookingModel shareBookingModel]._mailInfo._telPhone,[BookingModel shareBookingModel]._mailInfo._address,[BookingModel shareBookingModel]._mailInfo._title,[BookingModel shareBookingModel]._mailInfo._mailPostalcode,nil];
    NSDictionary * mailTicketInfo = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    [theRequest setPostValue:[mailTicketInfo JSONRepresentation] forKey:@"mailTicketInfo"];

    return theRequest;
}
+ (ASIFormDataRequest *)confirmTicketWithID:(NSString *)orderId   // 	获取报文
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/orderMobileController/confirmPay",ThreeStagesWoyinTrainUrl]]];
    
    
    [theRequest setPostValue:orderId forKey:@"orderId"];
    
    return theRequest;
}
+ (ASIFormDataRequest *)findOrderPayStatusInfoWithID:(NSString *)orderId   // 	订单支付状态查询
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/orderMobileController/findOrderPayStatusInfo",ThreeStagesWoyinTrainUrl]]];
    [theRequest setPostValue:orderId forKey:@"orderId"];
    
    return theRequest;
}
+ (ASIFormDataRequest *)rollbackPayWithID:(NSString *)orderId;   // 	支付回调
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/orderMobileController/rollbackPay",ThreeStagesWoyinTrainUrl]]];
    [theRequest setPostValue:orderId forKey:@"orderId"];
    
    return theRequest;
}
+ (ASIFormDataRequest *)cancelOrderInfoWithID:(NSString *)orderId  // 	取消订单
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/orderMobileController/cancelOrderInfo",ThreeStagesWoyinTrainUrl]]];
    [theRequest setPostValue:orderId forKey:@"orderId"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)getTrainPasserngerList:(NSString *)userId  // 	乘客列表
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/passengerMobileController/findPassengerList",ThreeStagesWoyinTrainUrl]]];
    [theRequest setPostValue:userId forKey:@"userId"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)addTrainPasserngerInfo:(NSString *)userId withName:(NSString *)name withType:(NSString *)type withNo:(NSString *)idNo withBirthday:(NSString *)birthDay withGender:(NSString *)gender // 	添加旅客信息
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/passengerMobileController/addPassengerInfo",ThreeStagesWoyinTrainUrl]]];

    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:name forKey:@"passengerName"];
    [theRequest setPostValue:type forKey:@"idType"];
    [theRequest setPostValue:idNo forKey:@"idNo"];
    [theRequest setPostValue:birthDay forKey:@"birthday"];
    [theRequest setPostValue:gender forKey:@"gender"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)updateTrainPasserngerInfo:(NSString *)userId withPassergerId:(NSString *)pId withName:(NSString *)name withType:(NSString *)type withNo:(NSString *)idNo withBirthday:(NSString *)birthDay withGender:(NSString *)gender // 	修改旅客信息
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/passengerMobileController/modifyPassengerInfo",ThreeStagesWoyinTrainUrl]]];
    
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:pId forKey:@"passengerId"];
    [theRequest setPostValue:name forKey:@"passengerName"];
    [theRequest setPostValue:type forKey:@"idType"];
    [theRequest setPostValue:idNo forKey:@"idNo"];
    [theRequest setPostValue:birthDay forKey:@"birthday"];
    [theRequest setPostValue:gender forKey:@"gender"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)delTrainPassernger:(NSString *)userId withPassergerId:(NSString *)pId // 	删除旅客
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sys/mobile/passengerMobileController/delPassengerInfo",ThreeStagesWoyinTrainUrl]]];

    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:pId forKey:@"ids"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)getTripForTicket:(NSString *)userId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/searchNoTakeOffTicketList", ThreeStagesUrl]]];
    
    [theRequest setPostValue:userId forKey:@"userId"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)getTripForHotel:(NSString *)userId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/ehotel/orderNotStayingHotelList", ThreeStagesHotelUrl]]];
    
    [theRequest setPostValue:userId forKey:@"userId"];
    [theRequest setPostValue:@"1" forKey:@"pageIndex"];
    [theRequest setPostValue:@"4" forKey:@"lcdStatusFlag"];
    
    return theRequest;
}
@end