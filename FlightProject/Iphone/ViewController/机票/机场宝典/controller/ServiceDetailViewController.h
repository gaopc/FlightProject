//
//  ServiceDetailViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-11-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceDetailViewController : RootViewController<UIWebViewDelegate>
{
    UIActivityIndicatorView *activityIV;
    UIWebView *myWebView;
}
@property(nonatomic,retain)NSString *urlStr;
@end
