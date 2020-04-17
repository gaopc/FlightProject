//
//  DIDITaxiViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 14-12-5.
//
//

#import "DIDITaxiViewController.h"

@interface DIDITaxiViewController ()

@end

@implementation DIDITaxiViewController

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
    self.title = @"打车";
    activityIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIV.center = self.view.center;
    activityIV.hidden = YES;
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight - 44)];
    webView.delegate = self;
    webView.backgroundColor = [UIColor clearColor];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://pay.xiaojukeji.com/api/v2/webapp?channel=1242&city="]]];//http://pay.xiaojukeji.com/api/v2/webapp?city=北京 &maptype=wgs84&fromlat=39.98096907577634&fr omlng= 116.30000865410719&fromaddr=银科⼤大厦 &toaddr=⻄西⼆二旗&toshop=得实⼤大厦 &channel=1210&d=130002030203
    
    //[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.7.123:8080/ClientActivity/advertDetail.html"]]];
    
    [self.view addSubview:webView];
    [webView release];
    //    webView.scalesPageToFit = YES;
    [self.view addSubview:activityIV];
    [activityIV release];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    activityIV.hidden = NO;
    [activityIV startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)myWebView
{
    [myWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
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
    if (webView.canGoBack) {
        [webView goBack];
    }
    else
    {
        [NavigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
