//
//  PassengerNoticeViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassengerNoticeViewController : RootViewController<UIWebViewDelegate>
{
    UIActivityIndicatorView *activityIV;
}
@property(nonatomic,retain)UIWebView *myWebView;
@property(nonatomic,retain)UIImageView *firstImageView;
@property(nonatomic,retain)UIImageView *secondImageView;
@property(nonatomic,retain)UIImageView *thirdImageView;
@property(nonatomic,retain)UIImageView *fourthImageView;
@end
