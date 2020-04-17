//
//  HomeActivityDetailViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 14-12-5.
//
//

#import "HomeActivityDetailViewController.h"
#import "TicketHomeViewController.h"
#import "MemberLoginViewController.h"

@interface HomeActivityDetailViewController ()

@end

@implementation HomeActivityDetailViewController
@synthesize _item, _activityUrl, _activityDetailUrl, _activityType, _activityDes;
- (void)dealloc
{
    self._item = nil;
    self._activityUrl = nil;
    self._activityDetailUrl = nil;
    self._activityType = nil;
    self._activityDes = nil;
    [super dealloc];
}
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
    self.title = @"活动详情";
//    [self showDetail];
    activityIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIV.center = self.view.center;
    activityIV.hidden = YES;
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight - 44)];
    webView.delegate = self;
    webView.backgroundColor = [UIColor clearColor];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/activityInfo.action?id=%@",ThreeStagesUrl,self._item._id]]]];
    
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://style177.sinaapp.com/year_act/wysd.html"]]];
    [self.view addSubview:webView];
    [webView release];
    //    webView.scalesPageToFit = YES;
    [self.view addSubview:activityIV];
    [activityIV release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[ActivityTimerView shareTimerView] hiddenTimerView];
    [[ActivityTimerView shareTimerView] stopTimerView];
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
- (BOOL)webView:(UIWebView *)webView1 shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *urlString = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",urlString);
    NSMutableArray * arr = [NSMutableArray array];
    [arr addObjectsFromArray:[urlString componentsSeparatedByString:@"#"]];
    [arr removeObjectAtIndex:0];
    NSArray *arrFucnameAndParameter =arr;
    if ([arrFucnameAndParameter count]>0) {
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:0];
        if (1 == [arrFucnameAndParameter count])
        {
            // 没有参数
            if([funcStr isEqualToString:@"shareToWechat"])
            {
                /*调用本地函数1*/
                NSLog(@"shareToWechat");
            }
            else if ([funcStr isEqualToString:@"competition"]) {
                
                self._activityType = @"competition";
                
                
                self._VCType = Member;
                if ([self isLogin]) {
                    [self loginSuccessFul];
                    
                }
                
                
                
                
                return NO;
            }
        }
        else
        {
            // 有参数
            if([funcStr isEqualToString:@"shareToWechat"])
            {
                
                BOOL isHave = [self isWeChatHave];
                if (isHave) {
                    [UserInfo sharedUserInfo]._isActivityShare = NO;
                    UIImage *exampleImg = nil;
                    
                    NSData *data = UIImageJPEGRepresentation([self getImageFromURL:[arrFucnameAndParameter objectAtIndex:3]], 0);
                    NSLog(@"data长度：%d", data.length);
                    exampleImg = [UIImage imageWithData:data];
                    [WeiXinExport sendAppContent:[arrFucnameAndParameter objectAtIndex:1] withDes:[arrFucnameAndParameter objectAtIndex:2] withImg:exampleImg withUrl:[arrFucnameAndParameter objectAtIndex:4]];
                }
            }
            else if([funcStr isEqualToString:@"shareToTimeline"])
            {
                BOOL isHave = [self isWeChatHave];
                if (isHave) {
                    [UserInfo sharedUserInfo]._isActivityShare = NO;
                    UIImage *exampleImg = nil;
                    NSData *data = UIImageJPEGRepresentation([self getImageFromURL:[arrFucnameAndParameter objectAtIndex:3]], 0);
                    NSLog(@"data长度：%d", data.length);
                    if (data.length != 0) {
                        exampleImg = [UIImage imageWithData:data];
                    }
                    else {
                        exampleImg = [UIImage imageNamed:@"icon.png"];
                    }
                    
                    [WeiXinExport sendAppContentTo:[arrFucnameAndParameter objectAtIndex:1] withDes:[arrFucnameAndParameter objectAtIndex:2] withImg:exampleImg withUrl:[arrFucnameAndParameter objectAtIndex:4] ];
                }
            }
            else if([funcStr isEqualToString:@"shareToActtivity"])
            {
                BOOL isHave = [self isWeChatHave];
                if (isHave) {
                    self._activityDes = [arrFucnameAndParameter objectAtIndex:2];
                    [UserInfo sharedUserInfo]._isActivityShare = YES;
                    [ActivityTimerView shareTimerView]._activityMileage = [arrFucnameAndParameter objectAtIndex:3];
                    NSString *isShareAct = [arrFucnameAndParameter objectAtIndex:4];
                    
                    if ([isShareAct boolValue]) {
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"多次分享赠送一次畅达币，是否继续分享？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                        alert.tag = 52;
                        [alert show];
                        [alert release];
                    }
                    else {
                        [WeiXinExport sendAppContentTo:self._activityDes withDes:self._activityDes withImg:[UIImage imageNamed:@"icon.png"] withUrl:self._activityUrl];
                    }
                }
            }
            else if ([funcStr isEqualToString:@"competition"]) {
                
                self._activityType = @"competition";
                [ActivityTimerView shareTimerView]._activityShareUrl = [arrFucnameAndParameter objectAtIndex:1];
                
                
                
                self._VCType = Member;
                if ([self isLogin]) {
                    [self loginSuccessFul];
                    
                }
                
                return NO;
            }
            else if([funcStr isEqualToString:@"basksingle"]) {
                
                self._activityUrl = [NSString stringWithFormat:@"%@&type=weChat", [arrFucnameAndParameter objectAtIndex:2]];
                self._activityDetailUrl = [NSString stringWithFormat:@"%@", [arrFucnameAndParameter objectAtIndex:1]];
                
                self._activityType = @"basksingle";
                
                self._VCType = Member;
                if ([self isLogin]) {
                    [self loginSuccessFul];
                }
                
                
            }
            return NO;
        }
    }
    return YES;
}
- (UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[fileURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    result = [UIImage imageWithData:data];
    return result;
}


- (BOOL)isWeChatHave
{
    if (![WXApi isWXAppInstalled]) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:@"您还没有安装微信客户端，请安装后进行分享。点击确定，立即安装。"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"确定",nil];
        [alertView setTag:123];
        [alertView show];
        [alertView release];
        return NO;
    }
    return YES;
}

#pragma mark - UIAlerViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 123) {
        if (buttonIndex == 1) {
            NSString *weChatUrl = [WXApi getWXAppInstallUrl];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weChatUrl]];
        }
    }
    else if (alertView.tag == 51) {
        if (buttonIndex == 1) {
            TicketHomeViewController * ticketHomeVC = [[TicketHomeViewController alloc] init];
            [NavigationController pushViewController:ticketHomeVC animated:YES];
            [ticketHomeVC release];
        }
    }
    else if (alertView.tag == 52) {
        if (buttonIndex == 1) {
            [WeiXinExport sendAppContentTo:self._activityDes withDes:self._activityDes withImg:[UIImage imageNamed:@"icon.png"] withUrl:self._activityUrl];
        }
    }
}

-(void) showDetail
{
    self.title = self._item._titile;
    
    UIScrollView * scrollv =[[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollv.showsHorizontalScrollIndicator = NO;
    scrollv.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollv];
    [scrollv release];
    
    AsyncImageView * iamgeV = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
    iamgeV.backgroundColor = [UIColor colorWithRed:arc4random()%155/256.0 green:arc4random()%155/256.0 blue:arc4random()%155/256.0 alpha:1];
    iamgeV.urlString = self._item._imageUrl;
    [scrollv addSubview:iamgeV];
    [iamgeV release];
    
    
    CGSize suggestedSize = [self._item._content sizeWithFont:FontSize24 constrainedToSize:CGSizeMake(self.view.frame.size.width-20, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect rect = CGRectMake(10, 190, self.view.frame.size.width-20, suggestedSize.height+40);

    UILabel * label = [UILabel labelWithTitle:self._item._content frame:rect font:FontSize24 color:[UIColor grayColor] alignment:NSTextAlignmentLeft];
    [scrollv addSubview:label];
    
    scrollv.contentSize = CGSizeMake(self.view.frame.size.width, label.frame.origin.y + label.frame.size.height +10);

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onListPaseredResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    NSString *userMileage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"allMileage"]];
    
    if ([statusCode intValue] == 0) {
        if ([userMileage intValue] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您春节期间还没有飞行记录" message:@"快去购票吧" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"去抢机票", nil];
            alert.tag = 51;
            [alert show];
            [alert release];
        }
        else {
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?userid=%@", self._activityDetailUrl, [UserInfo sharedUserInfo].userID]]]];
        }
    }
    else if ([statusCode intValue] == 100) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您春节期间还没有飞行记录" message:@"快去购票吧" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"去抢机票", nil];
        alert.tag = 51;
        [alert show];
        [alert release];
    }
    else {
        [UIAlertView alertViewWithMessage:message];
    }
}

- (void)loginSuccessFul
{
    if ([self._activityType isEqualToString:@"competition"]) {
        TicketHomeViewController * ticketHomeVC = [[TicketHomeViewController alloc] init];
        [NavigationController pushViewController:ticketHomeVC animated:YES];
        [ticketHomeVC release];
        [self performSelector:@selector(showTimerView) withObject:nil afterDelay:1];
    }
    else if ([self._activityType isEqualToString:@"basksingle"]) {
        
        ASIFormDataRequest * theRequest = [InterfaceClass flightsOrdersList:[UserInfo sharedUserInfo].userID withPageIndex:@"-2"]; // -2春节活动
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onListPaseredResult:) Delegate:self needUserType:Default];
    }
}
-(void)showTimerView
{
    [[ActivityTimerView shareTimerView] showTimerView];
}
@end
