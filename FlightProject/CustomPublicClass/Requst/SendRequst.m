
//  SendRequst.m
//  FlightProject
//
//  Created by longcd on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SendRequst.h"
#import "JSON.h"
#import "RecommendClass.h"
#import "WelecomViewContrller.h"
@implementation SendRequst
@synthesize delegate;//,catchQueueIndex;

@synthesize delegateVC,delegateSelector;
@synthesize currentViewController;
@synthesize myRequest;

-(void)dealloc
{
    self.delegate = nil;
    self.delegateVC = nil;
    self.delegateSelector = nil;
    self.currentViewController = nil;
    [self.myRequest clearDelegatesAndCancel];
    self.myRequest  = nil;
    [super dealloc];
}

-(void)sendRequstAsiFormHttp:(ASIFormDataRequest *)theRequest
{
    self.myRequest = theRequest;
    //[theRequest setPostValue:[TerminalId TerminalId] forKey:@"terminalId"];
    [theRequest setPostValue:[TerminalId TerminalId]  forKey:@"terminalId"];
    /*
     当allowCompressedResponse 设置为YES时，ASIHTTPRequest将向request中增加一个Accept-Encoding头，表示我们可以接收gzip压缩过的数据。如果响应头中包含一个Content-Encoding头指明数据是压缩过的，那么调用responseData 或者responseString 将会得到解压缩后的数据。你也可以通过调用rawResponseData来获得原始未压缩的数据。
     */
    [theRequest setAllowCompressedResponse:YES];
    [theRequest setShouldWaitToInflateCompressedResponses:NO];
    [theRequest setRequestMethod:@"POST"];
    [theRequest setTimeOutSeconds:60];
    theRequest.delegate = self;
    
    //NSLog(@" -------- >  %d",self.catchQueueIndex);
    
    [theRequest startAsynchronous];
}
//+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef*)outTrust fromPKCS12Data:(NSData *)inPKCS12Data
//{
//    @autoreleasepool {
//        OSStatus securityError = errSecSuccess;
//        
//        CFStringRef password = CFSTR("123456"); //证书密码
//        const void *keys[] =   { kSecImportExportPassphrase };
//        const void *values[] = { password };
//        
//        CFDictionaryRef optionsDictionary = CFDictionaryCreate(NULL, keys,values, 1,NULL, NULL);
//        
//        CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
//        securityError = SecPKCS12Import((CFDataRef)inPKCS12Data,optionsDictionary,&items);
//        
//        if (securityError == 0) {
//            CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
//            const void *tempIdentity = NULL;
//            tempIdentity = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemIdentity);
//            *outIdentity = (SecIdentityRef)tempIdentity;
//            const void *tempTrust = NULL;
//            tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
//            *outTrust = (SecTrustRef)tempTrust;
//        } else {
//            NSLog(@"Failed with error code %d",(int)securityError);
//            return NO;
//        }
//        return YES;
//    }
//}

-(void)sendRequstAsiFormHttps:(ASIFormDataRequest *)theRequest
{
    self.myRequest = theRequest;
    [theRequest setPostValue:[TerminalId TerminalId]  forKey:@"terminalId"];
    /*
     当allowCompressedResponse 设置为YES时，ASIHTTPRequest将向request中增加一个Accept-Encoding头，表示我们可以接收gzip压缩过的数据。如果响应头中包含一个Content-Encoding头指明数据是压缩过的，那么调用responseData 或者responseString 将会得到解压缩后的数据。你也可以通过调用rawResponseData来获得原始未压缩的数据。
     */
    [theRequest setAllowCompressedResponse:YES];
    [theRequest setShouldWaitToInflateCompressedResponses:NO];
    [theRequest setRequestMethod:@"POST"];
    [theRequest setTimeOutSeconds:60];
    theRequest.delegate = self;
    
    SecIdentityRef identity = NULL;
    SecTrustRef trust = NULL;
    
    //绑定证书，证书放在Resources文件夹中
    NSData *PKCS12Data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"]];//证书文件名和文件类型
    [SendRequst extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data];
    
//    theRequest = [ASIHTTPRequest requestWithURL:httpsUrl];
    
    [theRequest setClientCertificateIdentity:identity];//设定访问路径
    [theRequest setValidatesSecureCertificate:NO];//是否验证服务器端证书，如果此项为yes那么服务器端证书必须为合法的证书机构颁发的，而不能是自己用openssl 或java生成的证书
    
    
//    [theRequest startSynchronous];
    [theRequest startAsynchronous];
    
    NSError *error = [theRequest error];
    if (!error) {
        NSString *response = [theRequest responseString];
        NSLog(@"response is : %@",response);
    } else {
        NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
        NSLog(@"%@",[error userInfo]);
    }
    
//    SecIdentityRef identity = NULL;
//    SecTrustRef trust = NULL;
//    
//    //绑定证书，证书放在Resources文件夹中
//    NSData *PKCS12Data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"]];
//    BOOL sendResult = [SendRequst extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data];
//    
//    if (sendResult) {
////        [theRequest setClientCertificateIdentity:identity];
//        [theRequest setClientCertificates:[NSArray arrayWithObjects:(id)identity,nil]];
//        [theRequest setValidatesSecureCertificate:NO];
//        
//        [theRequest startAsynchronous];
//    }
//    else{
//        [UIAlertView alertViewWithMessage:@"联网请求的证书验证失败！" :@"提示"];
//    }
//    
//    
//    NSError *error = [theRequest error];
//    if (!error) {
//        NSString *response = [theRequest responseString];
//        NSLog(@"response is : %@",response);
//    } else {
//        NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
//        NSLog(@"%@",[error userInfo]);
//    }
}

+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef*)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    
    
    OSStatus securityError = errSecSuccess;
    
    CFStringRef password = CFSTR("123456"); //证书密码
    const void *keys[] =   { kSecImportExportPassphrase };
    const void *values[] = { password };
    
    CFDictionaryRef optionsDictionary = CFDictionaryCreate(NULL, keys,values, 1,NULL, NULL);
        
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((CFDataRef)inPKCS12Data,optionsDictionary,&items);
    
    if (securityError == 0) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failed with error code %d",(int)securityError);
        return NO;
    }
    return YES;
}

-(void)requestFailed:(ASIFormDataRequest *)request
{
    NSLog(@"%s",__FUNCTION__);
    NSError * err = request.error;
    NSString * errorMess = nil;
    if (ShowNetErrorMessage) {
        errorMess = [NSString stringWithFormat:@"\n\n错误代码：%d\n错误描述：%@\n服务器返回字符串：%@",err.code, err.localizedDescription,request.responseString];
    }
    else{
        errorMess = @"";
    }
    NSDictionary * dic = [NSDictionary dictionaryWithObject:errorMess forKey:@"errorMessage"];
    [self requestResultStr:@"connectiondidFail" Dic:dic ];
}
-(void)requestFinished:(ASIFormDataRequest *)request
{
    NSLog(@"数据是否被压缩过：%d",[request isResponseCompressed]);
    NSString * str =  request.responseString;
    NSLog(@"%@",str);
    NSError * err = request.error;
    NSString * errorMess = nil;
    if (ShowNetErrorMessage) {
        errorMess = [NSString stringWithFormat:@"\n\n错误代码：%d\n错误描述：%@\n服务器返回字符串：%@",err.code, err.localizedDescription,request.responseString];
    }
    else{
        errorMess = @"";
    }
    if ([request responseData])
    {
        /* 
         
         //  2013年03月26日将替代字符串的下列语句去除，防止json解析失败导致一些页面无法进入，同时添加了UISubLabel，重写setText方法，将项目中用到的UILabel类替换成UISubLabel、UITextField类替换成UISubTextField、UITextView类替换成UISubTextView，针对服务器返回的数组类型做了专门判断，防止对字符串调用count方法或者进行快速枚举。
         
         str = [str stringByReplacingOccurrencesOfString:@"	" withString:@""];
         str = [str stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
         str = [str stringByReplacingOccurrencesOfString:@"+null" withString:@"+"];
         str = [str stringByReplacingOccurrencesOfString:@"null\"" withString:@"\""];
         str = [str stringByReplacingOccurrencesOfString:@"\"null" withString:@"\""];
         str = [str stringByReplacingOccurrencesOfString:@"\"null\"" withString:@"\"\""];
         str = [str stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
         */
        
	    NSDictionary * dic = [ str JSONValue ];
        if (dic) {
            [self requestResultStr:@"0" Dic:dic];
        }
        else {
            [self requestResultStr:@"connectiondidFail" Dic:[NSDictionary dictionaryWithObject:errorMess forKey:@"errorMessage"] ];
        }
    }
    else
    {
        [self requestResultStr:@"connectiondidFail" Dic:[NSDictionary dictionaryWithObject:errorMess forKey:@"errorMessage"] ];
    }
}
-(void)onConfigurationPaseredResultFail:(id)parm{}
-(void)requestResultStr:(NSString *) _resultStr Dic:(NSDictionary *)resultDic
{
    if (self.delegateVC   && [delegateVC respondsToSelector:self.delegateSelector] )
    {
        if ([self.currentViewController isEqualToString:[NSString stringWithFormat:@"%@",[[NavigationController.viewControllers lastObject] class]]])
        {
            if ([_resultStr isEqualToString:@"connectiondidFail"])
            {
                // if ([self.currentViewController isEqualToString:[NSString stringWithFormat:@"%@",[WelecomViewContrller class]]])
                if ((self.delegateVC && [self.delegateVC respondsToSelector:@selector(onConfigurationPaseredResultFail:)]) )
                //if ([self.currentViewController isEqualToString:[NSString stringWithFormat:@"%@",[WelecomViewContrller class]]])
                {
                    [self.delegateVC performSelector:@selector(onConfigurationPaseredResultFail:) withObject:resultDic];
                    self.delegateVC = nil;
                }
                else {
                    NSArray * ticketArray = [NSArray arrayWithObjects:@"onqueryFlightTicketWithDeparturePaseredResult:", @"onsubmitOrderPaseredResult:", @"onCreditCardPayPaseredResult:", @"getMessageStateResult:", nil];
                    NSArray * hotelArray = [NSArray arrayWithObjects:@"onPaseredHotelListResult:", @"onqueryHotelPaseredResult:", @"onQueryCreditCardPaseredResult:", @"onSubmitOrderHotelPaseredResult:", nil];
                    NSArray * carArray = [NSArray arrayWithObjects:@"onqueryCarStorePaseredResult:", @"onQueryCarServicePaseredResult:", @"onSubmitOrderCarInfoResult:",  nil];
                    NSArray * doNotAlertArray = [NSArray arrayWithObjects:@"onmyLCDCoinPaseredResult:",@"ongetPassengerListPaseredResult:",@"ongetNewUserAddressPaseredResult:",@"onCreditCardListdPaseredResult:",@"oncheckPersonnelListPaseredResult:",@"onRecommendFlightPaseredResult:",@"onRecommendHotelPaseredResult:",@"onRecommendCarPaseredResult:",@"getReturnPayCoinResult:",@"onBookingShowMessages:",@"onfindPreSalePeriodResult:", nil];
                    NSString * errorMessage = [resultDic objectForKey:@"errorMessage"];
                    if ([ticketArray containsObject:NSStringFromSelector(self.delegateSelector) ]) {
                        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@%@",TicketNetFailMessage,errorMessage] :@"提示"];
                    }
                    else if ([hotelArray containsObject:NSStringFromSelector(self.delegateSelector) ]) {
                        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@%@",HotelNetFailMessage,errorMessage] :@"提示"];
                    }
                    else if ([carArray containsObject:NSStringFromSelector(self.delegateSelector) ]) {
                        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@%@",CarNetFailMessage,errorMessage] :@"提示"];
                    }
                    else {
                        if (![doNotAlertArray containsObject:NSStringFromSelector(self.delegateSelector) ]) {
                            [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@%@",NetFailMessage,errorMessage] :@"提示"];
                        }
                    }
                }
            }
            else
            {
                @try //onCreditCardListdPaseredResult
                {
                    NSArray * toYouOptionArray = [NSArray arrayWithObjects:@"getOrdersStateResult:",@"onsubmitOrderPaseredResult:",@"onCreditCardPayPaseredResult:",@"getPayCDCoinResult:",@"ongetNewUserAddressPaseredResult:",@"ongetPassengerListPaseredResult:",@"onCreditCardListdPaseredResult:",@"onGetCarRentalListResult:", @"onWeatherCityPaseredResult:", @"onWeatherInfoResult:", @"onListPaseredResult:",@"onBookingShowMessages:",@"onfindOrderPollInfoResult:", @"onTicketPaseredResult:", @"onHotelPaseredResult:", nil];
                    if ([[resultDic objectForKey:@"statusCode"] intValue] == 0  || ( [toYouOptionArray containsObject:NSStringFromSelector(self.delegateSelector) ] )) {
                        [self.delegateVC performSelector:self.delegateSelector withObject:resultDic];
                    }
                    else
                    {
                        NSArray * doNotAlertArray = [NSArray arrayWithObjects:@"onmyLCDCoinPaseredResult:",@"ongetPassengerListPaseredResult:",@"ongetNewUserAddressPaseredResult:",@"onCreditCardListdPaseredResult:",@"oncheckPersonnelListPaseredResult:",@"onRecommendFlightPaseredResult:",@"onRecommendHotelPaseredResult:",@"onRecommendCarPaseredResult:",@"onfindPreSalePeriodResult:",  nil];
                        if (! [doNotAlertArray containsObject:NSStringFromSelector(self.delegateSelector) ] ) {
                            if ([self.currentViewController isEqualToString:[NSString stringWithFormat:@"%@",[WelecomViewContrller class]]])
                            {
                                [self.delegateVC performSelector:@selector(onConfigurationPaseredResultFail:) withObject:nil];
                            }
                            else
                            {
                                [UIAlertView alertViewWithMessage:[resultDic objectForKey:@"message"]];
                            }
                        }
                    }
                }
                @catch (NSException *exception) {
                    NSLog(@"%s,%@",__FUNCTION__,exception);
                }
            }
        }
        else{
            NSArray * citysListRequests = [NSArray arrayWithObjects:@"onAirportListPaseredResult:",@"onAirportCityInfoPaseredResult:",@"onHotelCityListPaseredResult:",@"onCarRentalListPaseredResult:",@"onTrainVersionResult:",@"onTrainCitysListPaseredResult:",@"onWeatherCityListPaseredResult:", nil];
            if (![_resultStr isEqualToString:@"connectiondidFail"] && [citysListRequests containsObject:NSStringFromSelector(self.delegateSelector)] ) {
                if ([[resultDic objectForKey:@"statusCode"] intValue] == 0 ) {
                    [self.delegateVC performSelector:self.delegateSelector withObject:resultDic];
                }
            }
        }
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(requestResult:)]) {
        [self.delegate performSelector:@selector(requestResult:) withObject:self];
    }
}


#pragma mark --
#pragma mark NSXMLParserDelegate
//-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
//{
//	[self.resultStr appendString:string];
//}
//
//- (void)parserDidEndDocument:(NSXMLParser *)parser{
//	NSString *JSONString = [self.resultStr stringByReplacingOccurrencesOfString:@"<![CDATA[[" withString:@""];
//	JSONString = [JSONString stringByReplacingOccurrencesOfString:@"]]>" withString:@""];
//    //NSLog(@"%@",JSONString);
//    NSArray * array = [JSONString JSONValue];
//    if (delegate &&[delegate respondsToSelector:@selector(requestResultStr:Arr:)])
//    {
//        @try {
//            [delegate performSelector:@selector(requestResultStr:Arr:) withObject:@"0" withObject:array];
//        }
//        @catch (NSException *exception) {
//            NSLog(@"%s,%@",__FUNCTION__,exception);
//        }
//    }
//
//}

//// post asiHttpRequest
//-(void)sendRequstAsiHttp:(NSMutableURLRequest *)theRequest
//{
//    NSMutableData * tempData = [[NSMutableData alloc] init];
//    NSMutableString * tempStr = [[NSMutableString alloc] init];
//    self.reciveData = tempData;
//    self.resultStr = tempStr;
//    [tempData release];
//    [tempStr release];
//
//    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:theRequest.URL];
//    [request setRequestMethod:@"POST"];
//    [request setTimeOutSeconds:45];
//    request.delegate = self;
//
//
//    request.requestHeaders = (NSMutableDictionary*)theRequest.allHTTPHeaderFields;
//
//    [request appendPostData:theRequest.HTTPBody];
//    [request startAsynchronous];
//
//}
//-(void)requestFailed:(ASIHTTPRequest *)request
//{
//    NSLog(@"%s",__FUNCTION__);
//    NSError * err = request.error;
//    NSArray * requestArr=[NSArray arrayWithObjects:err.localizedDescription, nil];
//    [delegate requestResultStr:@"connectiondidFail" Arr:requestArr];
//}
//-(void)requestFinished:(ASIHTTPRequest *)request
//{
//    if (request.responseData)
//    {
//        NSXMLParser * tempxmlParser = [[NSXMLParser alloc] initWithData: request.responseData];
//        self.xmlParser = tempxmlParser;
//        [tempxmlParser release];
//
//		[self.xmlParser setDelegate: self];
//		[self.xmlParser setShouldResolveExternalEntities: NO];
//		[self.xmlParser parse];
//	}
//    else
//    {
//        [delegate requestResultStr:@"array nil" Arr:nil];
//    }
//    
//}

@end
