//
//  HelpListViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-11-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpListViewController : RootViewController<UIWebViewDelegate>
{
    UIWebView *myWebView;
    UIActivityIndicatorView *activityIV;
}
@end
