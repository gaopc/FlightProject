//
//  WeiXinExport.h
//  FlightProject
//
//  Created by gaopengcheng on 13-7-5.
//
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "payRequsestHandler.h"

@interface WeiXinExport : NSObject <UIAlertViewDelegate>

+ (void) sendAppContent:(NSString *)title withDes:(NSString *)desc withImg:(UIImage *)image withUrl:(NSString *)url;
+ (void) sendAppContentTo:(NSString *)title withDes:(NSString *)desc withImg:(UIImage *)image withUrl:(NSString *)url;
+(void) sendPay:(NSDictionary*)dic;
+(void) sendPay_Demo:(NSDictionary*)dic;
@end
