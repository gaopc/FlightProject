//
//  AirportTrafficViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirportKnowledgeRootViewController.h"

@interface AirportTrafficViewController : AirportKnowledgeRootViewController<UIWebViewDelegate>
{
    NSInteger clickTopTag;
    NSInteger clickBelowTag;
    UIActivityIndicatorView *activityIV;
}
@property(nonatomic,retain)UIView *myView;
@property(nonatomic,retain)UIWebView *mywebView;
@property(nonatomic,retain)AirportData *data;
@property(nonatomic,retain)NSArray *trafficArray;
@property(nonatomic,retain)UIImageView *busImageView;
@property(nonatomic,retain)UIImageView *trackImageView;
@property(nonatomic,retain)UIImageView *taxiImageView;
@property(nonatomic,retain)UIImageView *wharfImageView;
@property(nonatomic,retain)UIImageView *parkImageView;
@property(nonatomic,retain)UIImageView *airportImageView;
@property(nonatomic,retain)UIImageView *downtownImageView;
@property(nonatomic,retain)UIImageView *cityImageView;
@property(nonatomic,retain)UIButton *airportBtn;
@property(nonatomic,retain)UIButton *downtownBtn;
@property(nonatomic,retain)UIButton *cityBtn;

-(void)clickTopButton:(UIButton*)sender;
-(void)clickBelowButton:(UIButton*)sender;
@end
