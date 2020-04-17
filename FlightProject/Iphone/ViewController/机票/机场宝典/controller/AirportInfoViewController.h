//
//  AirportInfoViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirportKnowledgeRootViewController.h"

@interface AirportInfoViewController : AirportKnowledgeRootViewController<UIWebViewDelegate>
{
    UIActivityIndicatorView *activityIV;
}
@property(nonatomic,retain)AirportData *data;
@property(nonatomic,retain)UIWebView *myWebView;
@end
