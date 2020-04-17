//
//  IphoneHomeViewController.m
//  FlightProject
//
//  Created by longcd on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IphoneHomeViewController.h"
#import "MySecurity.h"
#import "MemberLoginViewController.h"
#import "LoadingView.h"
#import "WelecomViewContrller.h"
#import "TrainQureyViewController.h"
#import "ZhiYinCardViewController.h"
#import "DIDITaxiViewController.h"
#import "HomeWeatherViewController.h"
#import "WoyinTrainQureyViewController.h"
#import "TripListViewController.h"
#import "MoreItemViewController.h"

@interface HomePageView : UIView
+(UIView *)homePageView:(CGRect) frame;
@end
@implementation HomePageView

+(UIView *)homePageView:(CGRect) frame
{
    UIView * view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView * backgroundImageV = [[UIImageView alloc] initWithFrame:view.bounds];
    backgroundImageV.image = [UIImage imageNamed:@"HomeBackground.png"];
    [view insertSubview:backgroundImageV atIndex:1];
    [backgroundImageV release];
    
    UIImageView * imageV = [UIImageView ImageViewWithFrame:CGRectMake(75, 2+ViewStartY, 170, 50)];
    imageV.image = [UIImage imageNamed:@"HomeTitle.png"];
    [view addSubview:imageV];
    
    HomePageAnimateView * animateView = [[HomePageAnimateView alloc] initWithFrame:CGRectMake(10, 50+ViewStartY, 300, 230)];
    [view addSubview:animateView];
    [animateView release];
    
    for (int i=0; i<5; i++) {
        [view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0+i*75, 280+ViewStartY, 10, 110) image:[UIImage imageNamed:@"HomeShadow.png"]]];
    }
    
    return [view autorelease];
}
//
@end

@interface IphoneHomeViewController ()

{
    IphoneHomeView * homeView;
}

-(void)ticket:(id)sender;
-(void)hotel:(id)sender;
-(void)taxi:(id)sender;
-(void)member:(id)sender;

@end

@implementation IphoneHomeViewController
@synthesize isLaunchOptions;
@synthesize myGecoder, myLocation, myLocationManager, _locationCity, _loginType;

-(void)dealloc
{
    [self.myLocation release];
    [self.myLocationManager release];
    [self.myGecoder release];
    self._locationCity = nil;
    self._loginType = nil;
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
-(void)hiddenCoverV
{
    [coverImageButton removeFromSuperview];
}
-(void)showCoverV
{
    //    // zxt 首页显示醒目的提示注册蒙层
    //    NSString * showView =  [[NSUserDefaults standardUserDefaults] objectForKey:RegistCoverView_ThreeDemain];
    //    if (!showView) {
    //        [[NSUserDefaults standardUserDefaults] setObject:@"RegistCoverView_ThreeDemain" forKey:RegistCoverView_ThreeDemain];
    //        UIImage * image = nil;
    //        if (self.view.frame.size.height > 480) {
    //            image = [UIImage imageNamed:@"coverImageV01.png"];
    //        }
    //        else{
    //            image = [UIImage imageNamed:@"coverImageV00.png"];
    //        }
    //        coverImageButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, ViewWidth, [[[UIApplication sharedApplication] delegate] window].frame.size.height) backImage:image target:self action:@selector(hiddenCoverV)];
    //        [self.view addSubview:coverImageButton];
    //    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [homeView pauseActImage];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    newView.hidden = YES;
    [moreButton setBackgroundImage:[UIImage imageNamed:@"HomeMore.png"] forState:UIControlStateNormal];
    if (self._pointView._pointLab.tag == 0) {
        self._pointView.hidden = YES;
    }
    else {
        if (self._pointView._pointLab.tag > 9) {
            self._pointView._pointLab.text = @"N";
        }
        else{
            self._pointView._pointLab.text = [NSString stringWithFormat:@"%d",self._pointView._pointLab.tag];
        }
        self._pointView.hidden = NO;
    }
    NSLog(@"标签数%@", self._pointView._pointLab.text);
    
    NSString *isRegister = [[NSUserDefaults standardUserDefaults] objectForKey:keyAudioRegister];
    NSLog(@"%@", isRegister);
    //    if ([isRegister boolValue])
    //    {
    //        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:keyAudioLogin];
    //		[[NSUserDefaults standardUserDefaults]  removeObjectForKey:keyLoginUserID];
    //        [UserInfo sharedUserInfo].userID = nil;
    //        userButton.hidden = YES;
    //        loginButton.hidden = YES;
    //        registerButton.hidden = NO;
    //        self._pointView.hidden = YES;
    //        [self showCoverV];
    //    }
    //    else if (!([UserInfo sharedUserInfo].userID && ![[UserInfo sharedUserInfo].userID isEqualToString:@""])){
    //        userButton.hidden = YES;
    //        registerButton.hidden = YES;
    //        loginButton.hidden = NO;
    //        self._pointView.hidden = YES;
    //    }
    //    else{
    //        loginButton.hidden = YES;
    //        registerButton.hidden = YES;
    //        userButton.hidden = NO;
    //    }
    
    if ([UserInfo sharedUserInfo].userID && ![[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
        loginButton.hidden = YES;
        registerButton.hidden = YES;
        userButton.hidden = NO;
        
        //        homeView._userTitleLab.text = @"会员";
        userType = 2;
    }
    else if ([isRegister boolValue])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:keyAudioLogin];
        [[NSUserDefaults standardUserDefaults]  removeObjectForKey:keyLoginUserID];
        [UserInfo sharedUserInfo].userID = nil;
        userButton.hidden = YES;
        loginButton.hidden = YES;
        registerButton.hidden = NO;
        self._pointView.hidden = YES;
        [self showCoverV];
        //        homeView._userTitleLab.text = @"注册";
        userType = 0;
    }
    else if (!([UserInfo sharedUserInfo].userID && ![[UserInfo sharedUserInfo].userID isEqualToString:@""])){
        userButton.hidden = YES;
        registerButton.hidden = YES;
        loginButton.hidden = NO;
        self._pointView.hidden = YES;
        //        homeView._userTitleLab.text = @"登录";
        userType = 1;
    }
    [homeView changeUserTpye:userType withPointView:self._pointView];
    [homeView playActImage];
    
    //    BOOL isAddPointView = FALSE;
    //    for (UIView * elem in [self.view subviews]) {
    //        if ([elem isKindOfClass:[OrderPointView class]]) {
    //
    //            isAddPointView = YES;
    //            break;
    //        }
    //    }
    //    if (!isAddPointView) {
    //        [homeView addSubview:self._pointView];
    //        self._pointView.frame = CGRectMake(35, ViewHeight+ ViewStartY*2, 15, 15);
    //    }
    
    if (isLaunchOptions) {
        isLaunchOptions = NO;
        [self performSelector:@selector(activeted:) withObject:nil afterDelay:0.2];
    }
    //关于评分的标识 崔立东 2013年4月8日添加
    NSString* tempStr = [[NSUserDefaults standardUserDefaults] stringForKey:keyIsFirstGradeMark];
    if ([tempStr isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:keyIsFirstGradeMark];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}
-(void)location
{
    {
        self._locationCity = [[NSUserDefaults standardUserDefaults] objectForKey:WeatherSelectCity];
        if (!self._locationCity) {
            self._locationCity = @"北京";
        }
        NSLog(@"定位前取城市：%@", self._locationCity);

        if([CLLocationManager locationServicesEnabled])
        {
//            self.myLocationManager = [[[CLLocationManager alloc]init] autorelease];
//            self.myLocationManager.delegate = self;
//            self.myLocationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
//            self.myLocationManager.distanceFilter = 1000.0f;
//            
//            if ([[UIDevice currentDevice].systemVersion floatValue] >= 8)  {
//                [self.myLocationManager requestWhenInUseAuthorization];
//            }
//            [self.myLocationManager startUpdatingLocation];
            
            self.myLocationManager = [[CLLocationManager alloc]init];
            self.myLocationManager.delegate = self;
             if ([[UIDevice currentDevice].systemVersion floatValue] >= 8)  {
                 [self.myLocationManager requestWhenInUseAuthorization];
             }
            self.myLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.myLocationManager.distanceFilter = kCLDistanceFilterNone;
            [self.myLocationManager startUpdatingLocation];
        }
        else {
            [self performSelector:@selector(getWeatherInfo:) withObject:self._locationCity ];
            NSLog(@"Location services are not enabled");
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.myLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
            {
                [self.myLocationManager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([ActivityTimerView shareTimerView]._isAactivation) {
        [UIAlertView alertViewWithMessage:@"您已退出活动!"];
        [[ActivityTimerView shareTimerView] hiddenTimerView];
        [[ActivityTimerView shareTimerView] stopTimerView];
    }
}
-(void)loadView
{
    [super loadView];
    homeView = [[IphoneHomeView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight+ViewStartY)];
    homeView.delegate = self;
    [self.view addSubview:homeView];
    [homeView release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    
    WelecomViewContrller* welecomVC = [[WelecomViewContrller alloc]init];
    [NavigationController pushViewController:welecomVC animated:NO];
    [welecomVC release];
    
    [self getactivityList];
    [self location];
    
    
    //    [self.view addSubview:[HomePageView homePageView:CGRectMake(0, 0, ViewWidth, ViewHeight+ViewStartY)]];
    //
    //    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 280+ViewStartY, 75, 110) backImage:[UIImage imageNamed:@"HomeTicket.png" ] target:self action:@selector(ticket:)]];
    //    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(85, 280+ViewStartY, 75, 110) backImage:[UIImage imageNamed:@"HomeHotel.png" ] target:self action:@selector(hotel:)]];
    //    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(160, 280+ViewStartY, 75, 110) backImage:[UIImage imageNamed:@"HomeCar.png" ] target:self action:@selector(taxi:)]];
    //
    //    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(235, 280+ViewStartY, 75, 110) backImage:[UIImage imageNamed:@"HomeTrain" ] target:self action:@selector(train:)]];
    //
    //    userButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, ViewHeight +ViewStartY- 40, 75, 35) backImage:[UIImage imageNamed:@"HomeUser.png" ] target:self action:@selector(member:)];
    //    [self.view addSubview:userButton];
    //
    //    loginButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, ViewHeight+ViewStartY - 40, 75, 35) backImage:[UIImage imageNamed:@"HomeLogin.png" ] target:self action:@selector(userLogin:)];
    //    [self.view addSubview:loginButton];
    //
    //    registerButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, ViewHeight+ViewStartY - 40, 75, 35) backImage:[UIImage imageNamed:@"HomeRegister.png" ] target:self action:@selector(userRegister:)];
    //    [self.view addSubview:registerButton];
    //
    //    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(85, ViewHeight+ViewStartY - 40, 75, 35) backImage:[UIImage imageNamed:@"HomeActive.png"] target:self action:@selector(activeted:)]];
    //    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(160, ViewHeight+ViewStartY - 40, 75, 35) backImage:[UIImage imageNamed:@"HomeTelephone.png"] target:self action:@selector(telephone:)]];
    //    moreButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(235, ViewHeight+ViewStartY - 40, 75, 35)  backImage:[UIImage imageNamed:@"HomeMore.png"] target:self action:@selector(more:)];
    //    [self.view addSubview:moreButton];
    //
    //    newView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight+ViewStartY - 75, ViewWidth, 35)];
    //    newView.hidden = YES;
    //    helpBtton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(90, 0, 75, 35) backImage:[UIImage imageNamed:@"HomeHelp.png"] target:self action:@selector(helpClick:)];
    //    aboutButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(165, 0, 75, 35) backImage:[UIImage imageNamed:@"HomeAbout.png"] target:self action:@selector(aboutClick:)];
    //    opinionButton = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:nil frame:CGRectMake(240, 0, 75, 35) backImage:[UIImage imageNamed:@"HomeOpinion.png"] target:self action:@selector(opinionClick:)];
    //    [newView addSubview:helpBtton];
    //    [newView addSubview:aboutButton];
    //    [newView addSubview:opinionButton];
    //
    //    [self.view addSubview:self._pointView];
    //    [self.view addSubview:newView];
    //    [newView release];
    
    
}


-(void)ticketBtnClick:(UIButton *)sender
{
    [self ticket:nil];
}
-(void)trainBtnClick:(UIButton *)sender
{
    [self train:nil];
}
-(void)hotelBtnClick:(UIButton *)sender
{
    [self hotel:nil];
}
-(void)carBtnClick:(UIButton *)sender
{
    [self taxi:nil];
}
-(void)myBtnClick:(UIButton *)sender
{
    switch (userType) {
        case 0:
        {
            [self userRegister:nil];
            break;
        }
        case 1:
        {
            [self userLogin:nil];
            break;
        }
        case 2:
        {
            [self member:nil];
            break;
        }
        default:
            [self userLogin:nil];
            break;
    }
}
-(void)didiBtnClick:(UIButton *)sender
{
    //滴滴打车
    DIDITaxiViewController * didiVC = [[DIDITaxiViewController alloc] init];
    [self.navigationController pushViewController:didiVC animated:YES];
    [didiVC release];
}
-(void)activtyBtnClick:(UIButton *)sender
{
    [self activeted:nil];
}

- (void)xingchengBtnClick:(UIButton *)sender
{
    NSLog(@"行程");
    self._VCType = Member;
    self._loginType = @"1";
    if (self.isLogin) {
        [self loginSuccessFul];
    }
}

-(void)weatherBtnClick:(UIButton *)sender
{
    HomeWeatherViewController *weatherVC = [[HomeWeatherViewController alloc] init];
    weatherVC._cityName = self._locationCity;
    weatherVC._isCityWeather = YES;
    if (self._queryWeatherInfo) {
        weatherVC._queryWeatherInfo = self._queryWeatherInfo;
    }
    else {
        weatherVC._areaCode = @"北京";
        weatherVC._cityName = @"北京";
        weatherVC._isLoadView = YES;
    }
    
    [self.navigationController pushViewController:weatherVC animated:YES];
    [weatherVC release];
}

-(void)kefuBtnClick:(UIButton *)sender
{
    [self telephone:nil];
}
-(void)moreBtnClick:(UIButton *)sender
{
    [self helpClick:nil];
}
-(void) showActivityDetail:(ActivityItem *)item
{
    //活动详情
    HomeActivityDetailViewController * detailVC = [[HomeActivityDetailViewController alloc] init];
    detailVC._item = item;
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}
-(void)getactivityList
{
    ASIFormDataRequest * theRequest = [InterfaceClass getactivityList];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryactivityListResult:) Delegate:self needUserType:Default];
    
    //    NSDictionary * dic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"60",@"",@"",@"",@"", nil] forKeys:[NSArray arrayWithObjects:@"id",@"imageurl",@"title",@"content",@"state", nil]],[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"60",@"",@"",@"",@"", nil] forKeys:[NSArray arrayWithObjects:@"id",@"imageurl",@"title",@"content",@"state", nil]],[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"60",@"",@"",@"",@"", nil] forKeys:[NSArray arrayWithObjects:@"id",@"imageurl",@"title",@"content",@"state", nil]],[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"60",@"",@"",@"",@"", nil] forKeys:[NSArray arrayWithObjects:@"id",@"imageurl",@"title",@"content",@"state", nil]], nil], nil] forKeys:[NSArray arrayWithObjects:@"activityVos", nil]];
    //
    //    [self onqueryactivityListResult:dic];
    
}

-(void)onqueryactivityListResult:(NSDictionary *)dic
{
    NSArray * array = [dic objectForKey:@"activityVos"];
    if ([array isKindOfClass:[NSArray class]]) {
        NSMutableArray * marr = [NSMutableArray array];
        for (NSDictionary * item in array) {
            [marr addObject:[ActivityItem ActivityItemWithDic:item]];
        }
        [homeView activityViewWithList:marr];
    }
}

- (void)helpClick:(id)sender
{
    NSLog(@"click更多");
    self.navigationController.navigationBarHidden = NO;
    MoreItemViewController *helpViewCtr = [[MoreItemViewController alloc] init];
    [NavigationController pushViewController:helpViewCtr animated:YES];
    [helpViewCtr release];
    
}

-(void)ticket:(id)sender
{
    self.navigationController.navigationBarHidden = NO;
    TicketHomeViewController * ticketHomeVC = [[TicketHomeViewController alloc] init];
    [NavigationController pushViewController:ticketHomeVC animated:YES];
    [ticketHomeVC release];
    //    [[ActivityTimerView shareTimerView] showTimerView];
}
-(void)hotel:(id)sender
{
    self.navigationController.navigationBarHidden = NO;
    HotelHomeViewController * hotelHomeVC = [[HotelHomeViewController alloc] init];
    
    TicketQueryDataModel *_queryDataModel = [[TicketQueryDataModel alloc] init];
    hotelHomeVC.queryDataModel = _queryDataModel;
    [_queryDataModel release];
    
    hotelHomeVC.queryDataModel._fromCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:@"北京"  code:@"0101" ];
    hotelHomeVC.queryDataModel._startDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[NSDate dateFormateTicketQuery:[NSDate date]] code:[NSDate dateCode:[NSDate date] ]];
    hotelHomeVC.queryDataModel._arriveDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate date] day:PushBackOneDay type:3] code: [NSDate dateafterDay:[NSDate date] day:PushBackOneDay type:1]];
    HotelRequestPara *_hotelRequestPara = [[HotelRequestPara alloc]init];
    hotelHomeVC.hotelRequestPara = _hotelRequestPara;
    [_hotelRequestPara release];
    hotelHomeVC.hotelRequestPara._cityCode = hotelHomeVC.queryDataModel._fromCity._nameCode;
    hotelHomeVC.hotelRequestPara._checkInDate = hotelHomeVC.queryDataModel._startDate._nameCode;
    hotelHomeVC.hotelRequestPara._checkOutDate =  hotelHomeVC.queryDataModel._arriveDate._nameCode;
    hotelHomeVC.hotelRequestPara._hotelName =@"";
    hotelHomeVC.hotelRequestPara._highestPrice =@"0";
    hotelHomeVC.hotelRequestPara._lowestPrice =@"0";
    hotelHomeVC.hotelRequestPara._star = 0;
    hotelHomeVC.hotelRequestPara._hotelBrandID =@"0";
    hotelHomeVC.hotelRequestPara._longitude =@"";
    hotelHomeVC.hotelRequestPara._latitude =@"";
    hotelHomeVC.hotelRequestPara._pageIndex = 1;
    hotelHomeVC.hotelRequestPara._byStar =@"";
    hotelHomeVC.hotelRequestPara._byPrice =@"";
    hotelHomeVC.hotelRequestPara._administrativeArea =@"";
    hotelHomeVC.hotelRequestPara._businessArea =@"";
    
    hotelHomeVC.hotelRequestPara._hotelArea = @"";
    hotelHomeVC.hotelRequestPara._priceName = @"房价";
    hotelHomeVC.hotelRequestPara._starName = @"星级";
    hotelHomeVC.hotelRequestPara._hotelBrandName = @"品牌";
    
    [NavigationController pushViewController:hotelHomeVC animated:YES];
    [hotelHomeVC release];
}
-(void)taxi:(id)sender
{
    self.navigationController.navigationBarHidden = NO;
    TaxiHomeViewController * taxiHomeVC = [[TaxiHomeViewController alloc] init];
    
    TaxiHomeDataModel *tempQueryDataModel = [[TaxiHomeDataModel alloc] init];
    taxiHomeVC.carDataModel = tempQueryDataModel;
    [tempQueryDataModel release];
    NSString * nameCode = [DataClass selectFromCarRentalListWithCityName:@"北京"];
    if (nameCode == nil) {
        nameCode = @"1";
    }
    taxiHomeVC.carDataModel._takeCity = [TaxiHomeDataModelElem TaxiHomeDataModelElemWithStr:@"北京" code:nameCode];
    taxiHomeVC.carDataModel._sendCity = [TaxiHomeDataModelElem TaxiHomeDataModelElemWithStr:@"北京" code:nameCode];
    Shops * takeShop =  [[Shops alloc] init];
    takeShop._shopName = @"选择门店地址" ;
    taxiHomeVC.carDataModel._takeDoor =takeShop; //[TaxiHomeDataModelElem TaxiHomeDataModelElemWithStr:@"取车门店" code:@"PEK"];
    [takeShop release];
    Shops * sendShop =  [[Shops alloc] init];
    sendShop._shopName = @"选择门店地址" ;
    taxiHomeVC.carDataModel._sendDoor =sendShop;
    [sendShop release];
    taxiHomeVC.carDataModel._startDate = [TaxiHomeDataModelElem TaxiHomeDataModelElemWithStr: [NSString stringWithFormat:@"%@-10:00",[NSDate dateafterDay:[NSDate date] day:1 type:4]] code: [NSString stringWithFormat:@"%@ 10:00",[NSDate dateafterDay:[NSDate date] day:1 type:1]]];
    taxiHomeVC.carDataModel._endData = [TaxiHomeDataModelElem TaxiHomeDataModelElemWithStr: [NSString stringWithFormat:@"%@-10:00",[NSDate dateafterDay:[NSDate date] day:Delay_Days type:4]] code: [NSString stringWithFormat:@"%@ 10:00",[NSDate dateafterDay:[NSDate date] day:Delay_Days type:1]]];
    
    [NavigationController pushViewController:taxiHomeVC animated:YES];
    [taxiHomeVC release];
}
-(void)member:(id)sender
{
    self.navigationController.navigationBarHidden = NO;
    self._VCType = Member;
    self._loginType = @"0";
    if ([self isLogin])
    {
        [self loginSuccessFul];
    }
    //    else {
    //        MemberLoginViewController  * memberLoginVC = [[MemberLoginViewController alloc] init];
    //        memberLoginVC.delegate = self;
    //        [NavigationController pushViewController:memberLoginVC animated:YES];
    //        [memberLoginVC release];
    //    }
    
}
-(void)train:(id)sender
{
    self.navigationController.navigationBarHidden = NO;
//    TrainQureyViewController *Trainaview = [[TrainQureyViewController alloc] init];
//    [NavigationController pushViewController:Trainaview animated:YES];
//    [Trainaview release];
    
    WoyinTrainQureyViewController *Trainaview = [[WoyinTrainQureyViewController alloc] init];
    [NavigationController pushViewController:Trainaview animated:YES];
    [Trainaview release];

}
- (void)userLogin:(id)sendr
{
    self.navigationController.navigationBarHidden = NO;
    MemberLoginViewController  * memberLoginVC = [[MemberLoginViewController alloc] init];
    memberLoginVC.delegate = self;
    [NavigationController pushViewController:memberLoginVC animated:YES];
    [memberLoginVC release];
}

- (void)userRegister:(id)sendr
{
    self.navigationController.navigationBarHidden = NO;
    MemberRegisterViewController *registerVC = [[MemberRegisterViewController alloc] init];
    registerVC.delegate = self;
    [self.navigationController pushViewController:registerVC animated:YES];
    [registerVC release];
}

-(void) loginSuccessFul
{
    self.navigationController.navigationBarHidden = NO;
    if ([self._loginType intValue] == 0) {
        MemberHomeViewController * memberHomeVC = [[MemberHomeViewController alloc] init];
        [NavigationController pushViewController:memberHomeVC animated:YES];
        [memberHomeVC release];
    }
    else {
        TripListViewController *tripListVC = [[TripListViewController alloc] init];
        [self.navigationController pushViewController:tripListVC animated:YES];
        [tripListVC release];
    }
}

-(void)telephone:(id)sender
{
    [self callTel:@"400-6858-999"];
}
-(void)activeted:(id)sender
{
    self.navigationController.navigationBarHidden = NO;
    ActivityViewController *orderStateVC = [[ActivityViewController alloc] init];
    [NavigationController pushViewController:orderStateVC animated:YES];
    [orderStateVC release];
}
-(void)more:(id)sender
{
    newView.hidden = !newView.hidden;
    if (newView.hidden) {
        [moreButton setBackgroundImage:[UIImage imageNamed:@"HomeMore.png"] forState:UIControlStateNormal];
    }
    else{
        [moreButton setBackgroundImage:[UIImage imageNamed:@"HomeMoreHigh.png"] forState:UIControlStateNormal];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.myLocationManager = nil;
    self.myGecoder = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - self
- (void)getWeatherInfo:(NSString *)cityName
{
    self._locationCity = cityName;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self._locationCity forKey:WeatherSelectCity];
    [defaults synchronize];
    
    ASIFormDataRequest * theRequest = [InterfaceClass queryWeatherInfoByAirportCode:cityName];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onWeatherInfoResult:) Delegate:self needUserType:Default];
}

- (void)onConfigurationPaseredResultFail:(id)sender
{
    //    static BOOL weatherFail = YES;
    //    if (weatherFail) {
    //        weatherFail = !weatherFail;
    //        [self getactivityList];
    //    }
}

- (void)onWeatherInfoResult:(NSDictionary *)dic
{
    [self performSelector:@selector(showWeatherInfo:) withObject:dic afterDelay:1];
}
-(void) showWeatherInfo:(NSDictionary*)dic
{
    //    [self getactivityList];
    if ([[dic objectForKey:@"weatherInfoList"] isKindOfClass:[NSNull class]])
    {
        return;
    }
    
    
    self._queryWeatherInfo = [QueryWeatherInfo GetQueryWeatherInfoByAirportCode:dic];
    [homeView changeCityWeather:self._queryWeatherInfo withCityName:self._locationCity];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (newLocation) {
        NSLog(@"Latitude = %f", newLocation.coordinate.latitude);
        NSLog(@"Longitude = %f", newLocation.coordinate.longitude);
        self.myLocation = newLocation;
        [self.myLocationManager stopUpdatingLocation];
        [self getCityAddress];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self getWeatherInfo:self._locationCity];
}

- (void)getCityAddress
{
    if (!self.myGecoder) {
        self.myGecoder = [[CLGeocoder alloc] init];
    }
    
    static int i = 0;
    i++;
    NSLog(@"I = %d", i);
    if (i > 5) {
        [self getWeatherInfo:self._locationCity];
        return;
    }
    
    [self.myGecoder reverseGeocodeLocation:self.myLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(error == nil && [placemarks count]>0)
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             
             NSLog(@"Country = %@", placemark.country);
             NSLog(@"Postal Code = %@", placemark.postalCode);
             NSLog(@"Locality = %@", placemark.locality);
             NSLog(@"address = %@",placemark.name);
             NSLog(@"administrativeArea = %@",placemark.administrativeArea);
             NSLog(@"subAdministrativeArea = %@",placemark.subAdministrativeArea);
             NSLog(@"locality = %@", placemark.locality);
             NSLog(@"thoroughfare = %@", placemark.thoroughfare);
             
             self._locationCity = [placemark.administrativeArea stringByReplacingOccurrencesOfString:@"市" withString:@""];
             [self getWeatherInfo:self._locationCity];
         }
         else if(error==nil && [placemarks count]==0){
             NSLog(@"No results were returned.");
             [self getCityAddress];
         }
         else if(error != nil) {
             NSLog(@"An error occurred = %@", error);
             [self getCityAddress];
         }
     }];
}
@end
