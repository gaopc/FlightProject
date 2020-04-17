//
//  RootViewController.m
//  FlightProject
//
//  Created by longcd on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "NSDate+convenience.h"
#import "NOMemberLoginViewController.h"
#import "MemberLoginViewController.h"
#import "UserInfo.h"
#import "GetConfiguration.h"
@interface RootViewController ()

@end

@implementation RootViewController
@synthesize _pointView;
@synthesize _VCType;
@synthesize _moveView;
- (void)dealloc
{
    self._VCType = Default;
    self._pointView = nil;
    self._moveView = nil;
    [super dealloc];
}
-(void)didCityInfoResult:(NSArray *)cityArray
{
}
- (void)didBasicInfoResult:(NSDictionary *)dic
{
    NSString * errorMessage = [dic objectForKey:@"errorMessage"];
    NSLog(@"统一配置返回");
    if (errorMessage) {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@%@",NetFailMessage,errorMessage] :@"提示"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:[GetConfiguration shareGetConfiguration]._isFirst forKey:keyAudioRegister];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        self._pointView._pointLab.tag = [[GetConfiguration shareGetConfiguration]._unPayOrders intValue];
        
        if ([[GetConfiguration shareGetConfiguration]._version._mandatoryCode intValue] > MyVersionCode) {
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"发现新版本,升级体验下吧" delegate:self
                                                     cancelButtonTitle:nil destructiveButtonTitle:@"版本升级" otherButtonTitles:nil,nil];
            [sheet showInView:self.view];
            [sheet release];
        }
        else if ([[GetConfiguration shareGetConfiguration]._version._code intValue] > MyVersionCode){
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"发现新版本,升级体验下吧" delegate:self
                                                     cancelButtonTitle:@"稍后升级" destructiveButtonTitle:@"版本升级" otherButtonTitles:nil,nil];
            [sheet showInView:self.view];
            [sheet release];
        }
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        NSString *updateurl = @"http://itunes.apple.com/cn/app/zhang-shang-hang-lu/id433135814?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateurl]];
        exit(0);
    }
}

-(void)showHome
{
    [NavigationController popViewControllerAnimated:NO];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  frame: (CGRect) frame
{
    if (!self._moveView) {
        _moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0 )];
        _moveView.backgroundColor = [UIColor blackColor];
    }
    _moveView.alpha = 0.5;
    self._moveView.frame = frame;
    [self._moveView removeFromSuperview];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell addSubview:self._moveView];
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	_moveView.alpha = 0;
	[UIView commitAnimations];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) backHome
{
    [NavigationController popViewControllerAnimated:YES];
}
-(void)goHome
{
	[NavigationController popToRootViewControllerAnimated:YES];
}
//友盟添加事件  [MobClick event:@"AlixPay"];
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[GetConfiguration shareGetConfiguration]._umeng boolValue]) {
        [MobClick beginLogPageView:[NSString stringWithFormat:@"%@",[self class]]];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([[GetConfiguration shareGetConfiguration]._umeng boolValue]){
        [MobClick endLogPageView:[NSString stringWithFormat:@"%@",[self class]]];
    }
}
 -(void)loadView
{
    [super loadView];
    UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight*2+ViewStartY+20)];
    imageV.image = [UIImage imageNamed:@"background@2x.png"]; //background@2x.png
    [self.view insertSubview:imageV atIndex:0];
    [imageV release];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

//    self.view.frame = CGRectMake(0, 20, ViewWidth, ViewHeight);
//    self.edgesForExtendedLayout = UIRectEdgeAll;
//    if (!IS_IPAD)
    {
	

	    
       
        UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 0, 52, 30) backImage:[UIImage imageNamed:@"backPre.png"] target:self action:@selector(backHome)];
        UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = leftBar;
        [leftBar release];
	    
	    UIButton  * rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 7, 52, 30) backImage:[UIImage imageNamed:@"backHome.png"] target:self action:@selector(goHome)];
	    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
	    self.navigationItem.rightBarButtonItem = rightBar;
	    [rightBar release];
	    
	    self._pointView = [OrderPointView shardOrderPointView:CGRectMake(35, ViewHeight - 45+ViewStartY, 15, 15)] ;
    }

	// Do any additional setup after loading the view.
}
-(BOOL)isAutoLoginOut
{
    if (![UserInfo sharedUserInfo]._isAutoLogin && ([UserInfo sharedUserInfo].userID && ![[UserInfo sharedUserInfo].userID isEqualToString: @""]) ) {
        NSString * startDateTime = [NSString stringWithFormat:@"%@:00",[UserInfo sharedUserInfo]._loginTime];
        NSDate * startDate = [ NSDate dateFromString:startDateTime withFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeInterval start = [startDate timeIntervalSinceNow] *1;
        start = abs((int)start);
        NSTimeInterval nomalValue = 1;
        if (  (start/3600) < nomalValue) {
            if ((int)(start / 60) < AutoLoginOutTime) {
                [UserInfo sharedUserInfo]._loginTime = [NSDate laterDateStr:[NSDate date]];
                return NO;
            }
            else{
                [UserInfo sharedUserInfo].userID = nil;
                if (self._VCType == NoMember) {
                    self._VCType = Member;
                }
                return YES;
            }
        }
        else {
            [UserInfo sharedUserInfo].userID = nil;
            if (self._VCType == NoMember) {
                self._VCType = Member;
            }
            return YES;
        }
    }
    return NO;
}
-(BOOL)isLogin
{
    if (![UserInfo sharedUserInfo]._isAutoLogin && ([UserInfo sharedUserInfo].userID && ![[UserInfo sharedUserInfo].userID isEqualToString: @""]) ) {
        NSString * startDateTime = [NSString stringWithFormat:@"%@:00",[UserInfo sharedUserInfo]._loginTime];
        NSDate * startDate = [ NSDate dateFromString:startDateTime withFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeInterval start = [startDate timeIntervalSinceNow] *1;
        start = abs((int)start);
        NSTimeInterval nomalValue = 1;
        if (  (start/3600) < nomalValue) {
            if ((int)(start / 60) < AutoLoginOutTime) {
                [UserInfo sharedUserInfo]._loginTime = [NSDate laterDateStr:[NSDate date]];
                [UserInfo sharedUserInfo]._isAutoLoginOut = NO;
            }
            else{
                [UserInfo sharedUserInfo].userID = nil;
                [UserInfo sharedUserInfo]._isAutoLoginOut = YES;
            }
        }
        else {
            [UserInfo sharedUserInfo].userID = nil;
            [UserInfo sharedUserInfo]._isAutoLoginOut = YES;
        }
    }
     if (self._VCType == NoMember)
     {
         if ([UserInfo sharedUserInfo]._isAutoLoginOut) {
                 self._VCType = Member;
         }
     }
        
    if ( [UserInfo sharedUserInfo].userID && ![[UserInfo sharedUserInfo].userID isEqualToString:@""])
    {
         return YES;
    }
    if (self._VCType == DidNoMember  ) {
       
        NOMemberLoginViewController  * memberLoginVC = [[NOMemberLoginViewController alloc] init];
        memberLoginVC.delegate = self;
        [NavigationController pushViewController:memberLoginVC animated:YES];
        [memberLoginVC release];

    }
    else if (self._VCType == NoMember  ) {
        if (![[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
            NOMemberLoginViewController  * memberLoginVC = [[NOMemberLoginViewController alloc] init];
            memberLoginVC.delegate = self;
            [NavigationController pushViewController:memberLoginVC animated:YES];
            [memberLoginVC release];
        }
        else {
            [self loginSuccessFul];
        }
    }
    else if (self._VCType == Member) {
        MemberLoginViewController  * memberLoginVC = [[MemberLoginViewController alloc] init];
        memberLoginVC.delegate = self;
        [NavigationController pushViewController:memberLoginVC animated:YES];
        [memberLoginVC release];
    }
    return NO;
}
-(void) loginSuccessFul
{}
- (NSString*)theWeekOfToday:(NSString*)aDate
{
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
    NSDate *now;
   // NSDateComponents *comps = [[[NSDateComponents alloc] init]autorelease];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | 
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    if(aDate)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        if(aDate.length == 10)
        {
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        }
        else
        {
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
        
        now = [dateFormatter dateFromString:aDate]; 
        NSLog(@"%@", now); 
        [dateFormatter release]; 
    }
    else
    {
        now=[NSDate date];
    }
    NSDateComponents *comps = [calendar components:unitFlags fromDate:now];
    int week = [comps weekday];
    NSString* weekString=nil;
    switch (week)
    {
        case 0:
            weekString = @"星期六";
            break;
        case 1:
            weekString = @"星期日";
            break;
        case 2:
            weekString = @"星期一";
            break;
        case 3:
            weekString = @"星期二";
            break;
        case 4:
            weekString = @"星期三";
            break;
        case 5:
            weekString = @"星期四";
            break;
        case 6:
            weekString = @"星期五";
            break;    
        default:
            break;
    }
    return weekString;
}
- (NSString *) theStrOfToday
{
    NSDateFormatter* format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString* time = [format stringFromDate: [NSDate date]];
    [format release];
    return time;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    if (!IS_IPAD) {
//        return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
//    }
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)isPhone{
	NSString *deviceModel = [NSString stringWithString:[UIDevice currentDevice].model];
	//if(DEBUG) NSLog(@"device model = %@", deviceModel);
	if ([deviceModel rangeOfString:@"iPhone"].location != NSNotFound) {
		if ([deviceModel rangeOfString:@"Simulator"].location == NSNotFound) {
			return YES;
		}
	}
	return NO;
}

-(void)callTel:(NSString *)telNum
{
    BOOL isPhone=[self isPhone];
	if(isPhone){
        NSString *telephoneStr = [[NSString alloc] initWithFormat:@"tel://%@", telNum];
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:telephoneStr];// 貌似tel:// 或者 tel: 都行
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        
        [self.view addSubview:callWebview];
        [telephoneStr release];
        [callWebview release];
	}else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"当前设备不支持电话功能！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}
@end
