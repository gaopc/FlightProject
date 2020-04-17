//
//  PassengerNoticeViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PassengerNoticeViewController.h"

@interface PassengerNoticeViewController ()

@end

@implementation PassengerNoticeViewController
@synthesize myWebView;
@synthesize firstImageView,secondImageView,thirdImageView,fourthImageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"乘客须知";
	// Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xingli" ofType:@"html"];
    UIWebView *aWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 7, 300, ViewHeight-44-7-40-15)];
    [aWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    aWebView.backgroundColor = [UIColor clearColor];
    self.myWebView = aWebView;
    self.myWebView.delegate = self;
    [self.view addSubview:self.myWebView];
    [aWebView release];
    
    UIView * belowButtonsView = [[UIView alloc] initWithFrame:CGRectMake(9, ViewHeight-44-7-40-8,300, 50)];
    [belowButtonsView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0,301.5, 50) image:[UIImage imageNamed:@"belowBackground.png"]]];
    self.firstImageView = [UIImageView ImageViewWithFrame:CGRectMake(13.5, 5,48, 40) image:[UIImage imageNamed:@"行李托运2.png"]];
    self.secondImageView = [UIImageView ImageViewWithFrame:CGRectMake(88.5, 5, 48, 40) image:[UIImage imageNamed:@"登机签证1.png"]];
    self.thirdImageView = [UIImageView ImageViewWithFrame:CGRectMake(163.5, 5,48, 40) image:[UIImage imageNamed:@"安全检验1.png"]];
    self.fourthImageView = [UIImageView ImageViewWithFrame:CGRectMake(238.5, 5,48, 40) image:[UIImage imageNamed:@"乘机时间1.png"]];
    [belowButtonsView addSubview:self.firstImageView];
    [belowButtonsView addSubview:self.secondImageView];
    [belowButtonsView addSubview:self.thirdImageView];
    [belowButtonsView addSubview:self.fourthImageView];
    [belowButtonsView addSubview:[UIButton buttonWithTag:0 frame:CGRectMake(0, 0, 75, 50) target:self action:@selector(clickButton:)]];
    [belowButtonsView addSubview:[UIButton buttonWithTag:1 frame:CGRectMake(75, 0, 75, 50) target:self action:@selector(clickButton:)]];
    [belowButtonsView addSubview:[UIButton buttonWithTag:2 frame:CGRectMake(150, 0, 75, 50) target:self action:@selector(clickButton:)]];
    [belowButtonsView addSubview:[UIButton buttonWithTag:3 frame:CGRectMake(225, 0, 75, 50) target:self action:@selector(clickButton:)]];
    
    [self.view addSubview:belowButtonsView];
    [belowButtonsView release];
    
    activityIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIV.center = self.view.center;
    activityIV.hidden = YES;
    [self.view addSubview:activityIV];
    [activityIV release];
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

- (void)dealloc
{
    activityIV = nil;
    self.myWebView = nil;
    self.firstImageView = nil;
    self.secondImageView = nil;
    self.thirdImageView = nil;
    self.fourthImageView = nil;
    [super dealloc];
}

-(void)clickButton:(UIButton*)sender
{
    self.firstImageView.image = [UIImage imageNamed:@"行李托运1.png"];
    self.secondImageView.image = [UIImage imageNamed:@"登机签证1.png"];
    self.thirdImageView.image = [UIImage imageNamed:@"安全检验1.png"];
    self.fourthImageView.image = [UIImage imageNamed:@"乘机时间1.png"];
    switch (sender.tag) {
        case 0:
        {
            [myWebView stopLoading];
            self.firstImageView.image = [UIImage imageNamed:@"行李托运2.png"];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"xingli" ofType:@"html"];
            [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
        }
        break;
        case 1:
        {
            [myWebView stopLoading];
            self.secondImageView.image = [UIImage imageNamed:@"登机签证2.png"];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"dengji" ofType:@"html"];
            [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
        }
            break;
        case 2:
        {
            [myWebView stopLoading];
            self.thirdImageView.image = [UIImage imageNamed:@"安全检验2.png"];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"anquan" ofType:@"html"];
            [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
        }
            break;
        case 3:
        {
            [myWebView stopLoading];
            self.fourthImageView.image = [UIImage imageNamed:@"乘机时间2.png"];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"gotime" ofType:@"html"];
            [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
        }
            break;
        default:
            break;
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
