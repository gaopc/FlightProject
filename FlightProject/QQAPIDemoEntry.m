//
//  QQAPIDemoEntry.m
//  FlightProject
//
//  Created by xiemengyue on 13-12-17.
//
//

#import "QQAPIDemoEntry.h"
#import "TencentOpenAPI/QQApiInterface.h"

@implementation QQAPIDemoEntry

#if __QQAPI_ENABLE__
#pragma mark - QQApiInterfaceDelegate
+ (void)onReq:(QQBaseReq *)req
{
    switch (req.type)
    {
        case EGETMESSAGEFROMQQREQTYPE:
        {
            break;
        }
        default:
        {
            break;
        }
    }
}

+ (void)onResp:(QQBaseResp *)resp
{
    NSLog(@"--%@--",resp.result);
    NSLog(@"--%@--",resp.errorDescription);
    NSLog(@"--%@--",resp.extendInfo);
    NSLog(@"--%d--",resp.type);
    
    switch (resp.type)
    {
        case ESENDMESSAGETOQQRESPTYPE:
        {
            NSString *message = [NSString string];
            if([resp.result isEqualToString:@"0"])
                message = @"分享成功";
            else if([resp.result isEqualToString:@"-4"])
                message = @"取消分享";
            else
                message = @"分享失败";
            
            [UIAlertView alertViewWithMessage:message];
            break;
        }
        default:
        {
            break;
        }
    }
}
#endif

@end
