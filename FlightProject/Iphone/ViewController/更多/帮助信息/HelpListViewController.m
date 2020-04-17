//
//  HelpListViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-11-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HelpListViewController.h"
@interface HelpListViewController ()

@end

@implementation HelpListViewController

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
	// Do any additional setup after loading the view.
	self.title = @"使用帮助";
    activityIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIV.center = self.view.center;
    activityIV.hidden = YES;
    
    myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight - 44)];
    myWebView.delegate = self;
    myWebView.backgroundColor = [UIColor clearColor];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"help1" ofType:@"html"];
    [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
        
    [self.view addSubview:myWebView];
    [myWebView release];
    
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
    if (myWebView.canGoBack) {
        [myWebView goBack];
    }
    else
    {
        [NavigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
