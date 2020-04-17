//
//  AirportInfoViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AirportInfoViewController.h"


@interface AirportInfoViewController ()

@end

@implementation AirportInfoViewController
@synthesize data,myWebView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    activityIV = nil;
    
    self.myWebView = nil;
    self.data = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNameLabelText:self.data];
    self.title = @"机场服务电话";
    self.delegate = self;
     NSLog(@"%f",self.view.frame.size.height);//460
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 61, ViewWidth, ViewHeight-44-116+49)];
    myView.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view.
    
    UIWebView *aWebView =  [[UIWebView alloc] initWithFrame:CGRectMake(10, 0, ViewWidth, ViewHeight-44-116+40)];
    self.myWebView = aWebView;
    self.myWebView.delegate = self;
    [aWebView release];
    [self.myWebView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(-4, self.myWebView.bounds.size.height,308, 5) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
    self.myWebView.backgroundColor = [UIColor clearColor];
    [myView addSubview:self.myWebView];
    
    activityIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIV.center = self.view.center;
    activityIV.hidden = YES;
    [myView addSubview:activityIV];
    [activityIV release];
    
    [self setMyCureentView:myView];
    [myView release];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    activityIV.hidden = NO;
    [activityIV startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    activityIV.hidden = YES;
    [activityIV stopAnimating];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    activityIV.hidden = YES;
    [activityIV stopAnimating];
}

-(void)backHome
{
//    if (webView.canGoBack) {
//        [webView goBack];
//    }
//    else
    {
        [NavigationController popViewControllerAnimated:YES];
    }
}
-(void)reloadViewData
{
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
    if(self.enterAirlinesVC)
    {
        [self.airportNameLabel setText:self.airPortData.airportName];
    }
    self.enterAirlinesVC = NO;
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/airportTel?airportCode=%@",ThreeStagesUrl,self.airPortData.airportCode]]]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
