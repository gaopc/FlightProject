//
//  ActivityViewController.h
//  FlightProject
//
//  Created by admin on 12-11-5.
//
//

#import <UIKit/UIKit.h>
#import "WeiXinExport.h"

@interface ActivityViewController : RootViewController<UIWebViewDelegate,WXApiDelegate, UIAlertViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIV;
}
@property (nonatomic, retain) NSString *_activityUrl;
@property (nonatomic, retain) NSString *_activityDetailUrl;
@property (nonatomic, retain) NSString *_activityType;
@property (nonatomic, retain) NSString *_activityDes;
@end
