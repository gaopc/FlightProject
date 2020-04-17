//
//  WeiXinExport.m
//  FlightProject
//
//  Created by gaopengcheng on 13-7-5.
//
//

#import "WeiXinExport.h"
#import "NSObject+JSON.h"

@implementation WeiXinExport

+ (BOOL)isWeChatHave
{
    if (![WXApi isWXAppInstalled]) {
        WeiXinExport * export = [[WeiXinExport alloc] init];
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:@"您还没有安装微信客户端。点击确定，立即安装。"
                                                            delegate:export
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"确定",nil];
        [alertView setTag:123];
        [alertView show];
        [alertView release];
        return NO;
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 123) {//微信
        if (buttonIndex == 1) {
            NSString *weChatUrl = [WXApi getWXAppInstallUrl];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weChatUrl]];
        }
        [self release];
    }
}

+ (void) sendAppContent:(NSString *)title withDes:(NSString *)desc withImg:(UIImage *)image withUrl:(NSString *)url
{
    // 发送内容给微信
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    [message setThumbImage:image];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

+ (void) sendAppContentTo:(NSString *)title withDes:(NSString *)desc withImg:(UIImage *)image withUrl:(NSString *)url
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    [message setThumbImage:image];
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
    //    ext.extInfo = @"<xml>test</xml>";
    ext.url = url;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}


+(void) sendPay:(NSDictionary*)dic
{
    if (![self isWeChatHave]) {
        return;
    }
    if(dic != nil){
        NSString *retcode = [NSString stringWithFormat:@"%@",[dic objectForKey:@"statusCode"]];
        if (retcode.intValue == 0){
            NSString * packets = [NSString stringWithFormat:@"%@",[dic objectForKey:@"packets"]];
            if (packets.length>0) {
                NSDictionary * packetsDic = [packets JSONValue];
                if ([packetsDic isKindOfClass:[NSDictionary class]]) {
                    //调起微信支付
                    PayReq* req           = [[[PayReq alloc] init]autorelease];
                    req.openID              = [packetsDic objectForKey:@"appid"];
                    req.partnerId           = [packetsDic objectForKey:@"partnerid"];
                    req.prepayId           = [packetsDic objectForKey:@"prepayid"];
                    req.nonceStr           = [packetsDic objectForKey:@"noncestr"];
                    NSString *stamp     = [packetsDic objectForKey:@"timestamp"];
                    req.timeStamp        = stamp.intValue;
                    req.package            = [packetsDic objectForKey:@"package"];
                    req.sign                   = [packetsDic objectForKey:@"sign"];
                    [WXApi sendReq:req];
                    //日志输出
                    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                }
                else
                {
                    [self alert:@"提示信息" msg:[dic objectForKey:@"message"]];
                }
            }
            else
            {
                [self alert:@"提示信息" msg:[dic objectForKey:@"message"]];
            }
        }else{
            [self alert:@"提示信息" msg:[dic objectForKey:@"message"]];
        }
    }else{
        [self alert:@"提示信息" msg:[dic objectForKey:@"message"]];
    }
    
//    //从服务器获取支付参数，服务端自定义处理逻辑和格式
//    //订单标题
//    NSString *ORDER_NAME    = @"Ios服务器端签名支付 测试";
//    //订单金额，单位（元）
//    NSString *ORDER_PRICE   = @"0.01";
//    
//    //根据服务器端编码确定是否转码
//    NSStringEncoding enc;
//    //if UTF8编码
//    //enc = NSUTF8StringEncoding;
//    //if GBK编码
//    enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString *urlString = [NSString stringWithFormat:@"%@?plat=ios&order_no=%@&product_name=%@&order_price=%@",
//                           SP_URL,
//                           [[NSString stringWithFormat:@"%ld",time(0)] stringByAddingPercentEscapesUsingEncoding:enc],
//                           [ORDER_NAME stringByAddingPercentEscapesUsingEncoding:enc],
//                           ORDER_PRICE];
//    
//    //解析服务端返回json数据
//    NSError *error;
//    //加载一个NSURL对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    if ( response != nil) {
//        NSMutableDictionary *dict = NULL;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//        
//        NSLog(@"url:%@",urlString);
//        if(dict != nil){
//            NSMutableString *retcode = [dict objectForKey:@"retcode"];
//            if (retcode.intValue == 0){
//                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//                
//                //调起微信支付
//                PayReq* req             = [[[PayReq alloc] init]autorelease];
//                req.openID              = [dict objectForKey:@"appid"];
//                req.partnerId           = [dict objectForKey:@"partnerid"];
//                req.prepayId            = [dict objectForKey:@"prepayid"];
//                req.nonceStr            = [dict objectForKey:@"noncestr"];
//                req.timeStamp           = stamp.intValue;
//                req.package             = [dict objectForKey:@"package"];
//                req.sign                = [dict objectForKey:@"sign"];
//                [WXApi sendReq:req];
//                //日志输出
//                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//            }else{
//                [self alert:@"提示信息" msg:[dict objectForKey:@"retmsg"]];
//            }
//        }else{
//            [self alert:@"提示信息" msg:@"服务器返回错误，未获取到json对象"];
//        }
//    }else{
//        [self alert:@"提示信息" msg:@"服务器返回错误"];
//    }

}
+(void) sendPay_Demo:(NSDictionary*)dic
{
    //{{{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    
    //创建支付签名对象
    payRequsestHandler *req = [[payRequsestHandler alloc] autorelease];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    //}}}
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alert:@"提示信息" msg:debug];
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[[PayReq alloc] init]autorelease];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
}
//客户端提示信息
+ (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
    [alter release];
}
@end
