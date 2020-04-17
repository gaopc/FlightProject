//
//  HomeActivityDetailViewController.h
//  FlightProject
//
//  Created by 张晓婷 on 14-12-5.
//
//

#import <UIKit/UIKit.h>
#import "IphoneHomeView.h"
#import "WeiXinExport.h"

@interface HomeActivityDetailViewController : RootViewController<UIWebViewDelegate,WXApiDelegate, UIAlertViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIV;
}

@property (nonatomic, retain) ActivityItem * _item;
@property (nonatomic, retain) NSString *_activityUrl;
@property (nonatomic, retain) NSString *_activityDetailUrl;
@property (nonatomic, retain) NSString *_activityType;
@property (nonatomic, retain) NSString *_activityDes;
@end
