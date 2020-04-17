//
//  AirportTrafficViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AirportTrafficViewController.h"

@interface AirportTrafficViewController ()

@end

@implementation AirportTrafficViewController
@synthesize myView,mywebView,data,trafficArray;
@synthesize busImageView,taxiImageView,parkImageView,trackImageView,wharfImageView;
@synthesize airportImageView,downtownImageView,cityImageView,airportBtn,downtownBtn,cityBtn;
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
    self.title = @"机场交通";
    [self setNameLabelText:self.data];
    self.delegate = self;
    
    NSArray *driectionAry1 = [NSArray arrayWithObjects:@"0",@"1",@"2", nil];
    NSArray *driectionAry2 = [NSArray arrayWithObjects:@"0",@"1", nil];
    NSArray *driectionAry3 = [NSArray array];
    NSArray *driectionAry4 = [NSArray array];
    NSArray *driectionAry5 = [NSArray array];
    self.trafficArray = [NSArray arrayWithObjects:driectionAry1,driectionAry2,driectionAry3,driectionAry4,driectionAry5, nil];
    
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0,61, ViewWidth, ViewHeight-44-61)];
    self.myView = aview;
    [aview release];
    self.airportImageView = [UIImageView ImageViewWithFrame:CGRectMake(10, 2, (ViewWidth - 10)/3, 38) image:[UIImage imageNamed:@"去机场2.png"]];
    self.downtownImageView = [UIImageView ImageViewWithFrame:CGRectMake((ViewWidth - 10)/3 + 10, 2, (ViewWidth - 10)/3, 38) image:[UIImage imageNamed:@"去市区1.png"]];
    self.cityImageView = [UIImageView ImageViewWithFrame:CGRectMake((ViewWidth - 10)*2/3 + 10, 2, (ViewWidth - 10)/3, 38) image:[UIImage imageNamed:@"去城市1.png"]];
    [myView addSubview:self.airportImageView];
    [myView addSubview:self.downtownImageView];
    [myView addSubview:self.cityImageView];
    self.airportBtn = [UIButton buttonWithTag:0 frame:CGRectMake(10, 2, (ViewWidth - 10)/3, 38) target:self action:@selector(clickTopButton:)];
    self.downtownBtn = [UIButton buttonWithTag:1 frame:CGRectMake((ViewWidth - 10)/3 + 10, 2, (ViewWidth - 10)/3, 38) target:self action:@selector(clickTopButton:)];
    self.cityBtn = [UIButton buttonWithTag:2 frame:CGRectMake((ViewWidth - 10)*2/3 + 10, 2, (ViewWidth - 10)/3, 38) target:self action:@selector(clickTopButton:)];
    [myView addSubview:self.airportBtn];
    [myView addSubview:self.downtownBtn];
    [myView addSubview:self.cityBtn];
    
    UIWebView *aWeb = [[UIWebView alloc] initWithFrame:CGRectMake(10, 38, ViewWidth - 20, ViewHeight-44-61-55)];
    self.mywebView = aWeb;
    self.mywebView.delegate = self;
    self.mywebView.dataDetectorTypes = UIDataDetectorTypeNone;
    [aWeb release];
    [myView addSubview:self.mywebView];
    
    UIView *belowView = [[UIView alloc] initWithFrame:CGRectMake(10, ViewHeight-44-61-60, ViewWidth - 20, 50)];
    [belowView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth - 20, 50) image:[UIImage imageNamed:@"belowBackground.png"]]];
    
    int offx = (ViewWidth - 20)/5;
    self.busImageView = [UIImageView ImageViewWithFrame:CGRectMake(10, 5, 40,40) image:[UIImage imageNamed:@"大巴2.png"]];
    self.trackImageView = [UIImageView ImageViewWithFrame:CGRectMake(10 + offx, 5, 40,40) image:[UIImage imageNamed:@"轨道1.png"]];
    self.taxiImageView = [UIImageView ImageViewWithFrame:CGRectMake(10 + offx*2, 5, 40,40) image:[UIImage imageNamed:@"出租车1.png"]];
    self.wharfImageView = [UIImageView ImageViewWithFrame:CGRectMake(10 + offx*3, 5, 40,40) image:[UIImage imageNamed:@"码头1.png"]];
    self.parkImageView = [UIImageView ImageViewWithFrame:CGRectMake(10 + offx*4, 5, 40,40) image:[UIImage imageNamed:@"停车场1.png"]];
    
    [belowView addSubview:self.busImageView];
    [belowView addSubview:self.trackImageView];
    [belowView addSubview:self.taxiImageView];
    [belowView addSubview:self.wharfImageView];
    [belowView addSubview:self.parkImageView];

    [belowView addSubview:[UIButton buttonWithTag:0 frame:CGRectMake(0, 0, 60, 50) target:self action:@selector(clickBelowButton:)]];
    [belowView addSubview:[UIButton buttonWithTag:1 frame:CGRectMake(offx, 0, 60, 50) target:self action:@selector(clickBelowButton:)]];
    [belowView addSubview:[UIButton buttonWithTag:2 frame:CGRectMake(offx*2, 0, 60, 50) target:self action:@selector(clickBelowButton:)]];
    [belowView addSubview:[UIButton buttonWithTag:3 frame:CGRectMake(offx*3, 0, 60, 50) target:self action:@selector(clickBelowButton:)]];
    [belowView addSubview:[UIButton buttonWithTag:4 frame:CGRectMake(offx*4, 0, 60, 50) target:self action:@selector(clickBelowButton:)]];
    [myView addSubview:belowView];
    [belowView release];
    clickTopTag = 0;
    clickBelowTag = 0;
    
    activityIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIV.center = self.view.center;
    activityIV.hidden = YES;
    
    [myView addSubview:activityIV];
    [activityIV release];
    
    [self setMyCureentView:myView];
    // Do any additional setup after loading the view.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    activityIV.hidden = NO;
    [activityIV startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{                                                  
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];//禁止弹出菜单
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect ='none';"];//禁止选中
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
    if(self.enterAirlinesVC)
    {
        [self.airportNameLabel setText:self.airPortData.airportName];
    }
    self.enterAirlinesVC = NO;
    [self reloadMyWeb];
}

-(void)clickTopButton:(UIButton*)sender
{
    [self setTopImageView:sender.tag];
    [self reloadMyWeb];
}
-(void)clickBelowButton:(UIButton*)sender
{
    [self setBelowImageView:sender.tag];
    [self reloadMyWeb];
}
-(void)reloadMyWeb
{
    if(clickBelowTag == 0 || clickBelowTag==1 )
    {
        self.mywebView.frame = CGRectMake(10, 38, ViewWidth - 20, ViewHeight-44-61-55);
        if(clickBelowTag == 0)
        {
            if(clickTopTag == 0)
            {
                [self.airportImageView setImage:[UIImage imageNamed:@"去机场2.png"]];
                [self.downtownImageView setImage:[UIImage imageNamed:@"去市区1.png"]];
            }
            if(clickTopTag == 1)
            {
                [self.airportImageView setImage:[UIImage imageNamed:@"去机场1.png"]];
                [self.downtownImageView setImage:[UIImage imageNamed:@"去市区2.png"]];
            }
            
            self.airportImageView.frame = CGRectMake(10, 2, 100, 38);
            self.downtownImageView.frame = CGRectMake(110, 2, 100, 38);
            self.cityImageView.frame = CGRectMake(210, 2, 100, 38);
            self.airportImageView.hidden = NO;
            self.downtownImageView.hidden = NO;
            self.cityImageView.hidden = NO;
            
            self.airportBtn.frame = CGRectMake(10, 2, 100, 38);
            self.downtownBtn.frame = CGRectMake(110, 2, 100, 38);
            self.cityBtn.frame = CGRectMake(210, 2, 100, 38);
            self.airportBtn.hidden = NO;
            self.downtownBtn.hidden = NO;
            self.cityBtn.hidden = NO;
        }
        else 
        {
            if(clickTopTag == 0)
            {
                
                [self.airportImageView setImage:[UIImage imageNamed:@"去机场大2.png"]];
                [self.downtownImageView setImage:[UIImage imageNamed:@"去市区大1.png"]];
            }
            else  if(clickTopTag == 1)
            {
                [self.airportImageView setImage:[UIImage imageNamed:@"去机场大1.png"]];
                [self.downtownImageView setImage:[UIImage imageNamed:@"去市区大2.png"]];
            }
            else {
                [self.airportImageView setImage:[UIImage imageNamed:@"去机场大2.png"]];
                [self.downtownImageView setImage:[UIImage imageNamed:@"去市区大1.png"]];
            }
            self.airportImageView.frame = CGRectMake(10, 2, (ViewWidth - 20)/2, 38);
            self.downtownImageView.frame = CGRectMake((ViewWidth - 20)/2 + 10, 2, (ViewWidth - 20)/2, 38);
            self.airportImageView.hidden = NO;
            self.downtownImageView.hidden = NO;
            self.cityImageView.hidden = YES;
            
            self.airportBtn.frame = CGRectMake(10, 2, (ViewWidth - 20)/2, 38);
            self.downtownBtn.frame = CGRectMake((ViewWidth - 20)/2 + 10, 2, (ViewWidth - 20)/2, 38);
            self.airportBtn.hidden = NO;
            self.downtownBtn.hidden = NO;
            self.cityBtn.hidden = YES;
        }
        
        
        if(clickBelowTag == 0 || (clickBelowTag == 1 && clickTopTag != 2))
        {
            
            NSLog(@"%@",[NSString stringWithFormat:@"%@/airportTraffic?airportCode=%@&mode=%ld&direction=%ld",ThreeStagesUrl,self.airPortData.airportCode,(long)clickBelowTag,(long)clickTopTag]);
            
            [self.mywebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/airportTraffic?airportCode=%@&mode=%ld&direction=%ld",ThreeStagesUrl,self.airPortData.airportCode,(long)clickBelowTag,(long)clickTopTag]]]];
        }
        if(clickBelowTag == 1 && clickTopTag == 2)
        {
            
            NSLog(@"%@",[NSString stringWithFormat:@"%@/airportTraffic?airportCode=%@&mode=%ld&direction=0",ThreeStagesUrl,self.airPortData.airportCode,(long)clickBelowTag]);
            
        [self.mywebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/airportTraffic?airportCode=%@&mode=%ld&direction=0",ThreeStagesUrl,self.airPortData.airportCode,(long)clickBelowTag]]]];
        }
    }
    else {
        self.airportImageView.hidden = YES;
        self.downtownImageView.hidden = YES;
        self.cityImageView.hidden = YES;
        self.mywebView.frame = CGRectMake(10, 0, ViewWidth - 20, ViewHeight-44-61-15);
        NSLog(@"%@",[NSString stringWithFormat:@"%@/airportTraffic?airportCode=%@&mode=%ld&direction=0",ThreeStagesUrl,self.airPortData.airportCode,(long)clickBelowTag]);
        [self.mywebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/airportTraffic?airportCode=%@&mode=%ld&direction=0",ThreeStagesUrl,self.airPortData.airportCode,(long)clickBelowTag]]]];
    }
}
-(void)setTopImageView:(NSInteger)tag
{
    if(tag == clickTopTag)
    {
        return;
    }
    clickTopTag = tag;
    [self.airportImageView setImage:[UIImage imageNamed:@"去机场1.png"]];
    [self.downtownImageView setImage:[UIImage imageNamed:@"去市区1.png"]];
    [self.cityImageView setImage:[UIImage imageNamed:@"去城市1.png"]];
    
    switch (tag) {
        case 0:
        {
            if(clickBelowTag == 1)
            {
                [self.airportImageView setImage:[UIImage imageNamed:@"去机场大2.png"]];
                [self.downtownImageView setImage:[UIImage imageNamed:@"去市区大1.png"]];
            }
            else
            {
                [self.airportImageView setImage:[UIImage imageNamed:@"去机场2.png"]];
            }
        }
            break;
        case 1:
        {
            if (clickBelowTag == 1)
            {
                [self.airportImageView setImage:[UIImage imageNamed:@"去机场大1.png"]];
                [self.downtownImageView setImage:[UIImage imageNamed:@"去市区大2.png"]]; 
            }
            else
            {
                [self.downtownImageView setImage:[UIImage imageNamed:@"去市区2.png"]];
            }
        }
            break;
        case 2:
            [self.cityImageView setImage:[UIImage imageNamed:@"去城市2.png"]];
            break;
        default:
            break;
    }
}

-(void)setBelowImageView:(NSInteger)tag
{
    if(tag == clickBelowTag)
    {
        return;
    }
    clickBelowTag = tag;
    [self.busImageView setImage:[UIImage imageNamed:@"大巴1.png"]];
    [self.trackImageView setImage:[UIImage imageNamed:@"轨道1.png"]];
    [self.taxiImageView setImage:[UIImage imageNamed:@"出租车1.png"]];
    [self.wharfImageView setImage:[UIImage imageNamed:@"码头1.png"]];
    [self.parkImageView setImage:[UIImage imageNamed:@"停车场1.png"]];
    
    switch (tag) {
        case 0:
            [self.busImageView setImage:[UIImage imageNamed:@"大巴2.png"]];
            break;
        case 1:
            [self.trackImageView setImage:[UIImage imageNamed:@"轨道2.png"]];
            break;
        case 2:
            [self.taxiImageView setImage:[UIImage imageNamed:@"出租车2.png"]];
            break;
        case 3:
            [self.wharfImageView setImage:[UIImage imageNamed:@"码头2.png"]];
            break;
        case 4:
            [self.parkImageView setImage:[UIImage imageNamed:@"停车场2.png"]];
            break;
        default:
            break;
    }

}
- (void)dealloc
{
    activityIV = nil;
    self.myView = nil;
    self.mywebView = nil;
    self.data = nil;
    self.trafficArray = nil;
    self.busImageView = nil;
    self.wharfImageView = nil;
    self.taxiImageView = nil;
    self.trackImageView = nil;
    self.parkImageView = nil;
    self.airportImageView = nil;
    self.downtownImageView = nil;
    self.cityImageView = nil;
    self.airportBtn = nil;
    self.downtownBtn =nil;
    self.cityBtn = nil;
    
    [super dealloc];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
