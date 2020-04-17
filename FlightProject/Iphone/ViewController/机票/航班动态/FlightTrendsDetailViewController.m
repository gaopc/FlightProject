//
//  FlightTrendsDetailViewController.m
//  FlightProject
//
//  Created by longcd on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlightTrendsDetailViewController.h"
#import "GetFlightDynamicByFlightNo.h"
#import "AppDelegate.h"
#import "ShareToSinaViewController.h"
#import "Header.h"

@implementation FlightDetailsCell
@synthesize flightCompany,flightNum,flightdate,weekDay,flightStatus,startCity,arrivalCity;
- (void)dealloc
{
    self.arrivalCity = nil;
    self.weekDay = nil;
    self.startCity = nil;
    self.flightCompany = nil;
    self.flightdate = nil;
    self.flightNum = nil;
    self.flightStatus = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(8, 7, ViewWidth - 16, 110) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(8, 117, ViewWidth - 16, 15) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"日   期" frame:CGRectMake(20, 15, 40, 15) font:FontSize26 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"起飞地" frame:CGRectMake(20, 42, 40, 15) font:FontSize26 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"降落地" frame:CGRectMake(170, 42, 40, 15) font:FontSize26 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"航班号" frame:CGRectMake(20, 69, 40, 15) font:FontSize26 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"航空公司" frame:CGRectMake(20, 96, 55, 15) font:FontSize26 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        
        self.flightdate = [UISubLabel labelWithTitle:@"" frame:CGRectMake(75, 15, 100, 15) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.weekDay = [UISubLabel labelWithTitle:@"" frame:CGRectMake(170, 15, 120, 15) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.startCity = [UISubLabel labelWithTitle:@"" frame:CGRectMake(75, 42, 70, 15) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.arrivalCity = [UISubLabel labelWithTitle:@"" frame:CGRectMake(225, 42, 70, 15) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.startCity.numberOfLines = 1;
        self.arrivalCity.numberOfLines = 1;
        self.flightNum = [UISubLabel labelWithTitle:@"" frame:CGRectMake(75, 69, 70, 15) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.flightCompany = [UISubLabel labelWithTitle:@"" frame:CGRectMake(75, 96, 130, 15) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.flightCompany.numberOfLines = 1;

        self.flightStatus = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 116, 70, 105, 44) image:nil];
        
        [self addSubview:self.flightStatus];
        [self addSubview:self.flightNum];
        [self addSubview:self.startCity];
        [self addSubview:self.flightdate];
        [self addSubview:self.weekDay];
        [self addSubview:self.flightCompany];
        [self addSubview:self.arrivalCity];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end

@implementation DepartureAirportDetailsCell
@synthesize airPortName,planTime,forecastTime,actualTime,timeDifference,timeDifferenceImageView;
- (void)dealloc
{
    self.airPortName = nil;
    self.planTime = nil;
    self.forecastTime = nil;
    self.actualTime = nil;
    self.timeDifference = nil;
    self.timeDifferenceImageView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(8, 3, ViewWidth - 16, 110) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(8, 108, ViewWidth - 16, 13) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 17, 11, 12) image:[UIImage imageNamed:@"航班动态起飞icon.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(32, 57, 113, 0.5) image:[UIImage imageNamed:@"航班动态半段虚线.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(32, 82, 113, 0.5) image:[UIImage imageNamed:@"航班动态半段虚线.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"计划起飞" frame:CGRectMake(40, 40, 60, 15) font:FontSize26 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"预计起飞" frame:CGRectMake(40, 65, 60, 15) font:FontSize26 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"实际起飞" frame:CGRectMake(40, 90, 60, 15) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        self.airPortName = [UISubLabel labelWithTitle:@"" frame:CGRectMake(40, 17, 250, 15) font:FontSize28 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.planTime = [UISubLabel labelWithTitle:@"" frame:CGRectMake(100, 40, 45, 15) font:FontBlodSize26 color:FontColor636363 alignment:NSTextAlignmentLeft];
        self.forecastTime = [UISubLabel labelWithTitle:@"" frame:CGRectMake(100, 65, 45, 15) font:FontBlodSize26 color:FontColor636363 alignment:NSTextAlignmentLeft];
        self.actualTime = [UISubLabel labelWithTitle:@"" frame:CGRectMake(100, 90, 45, 15) font:FontBlodSize26 color:FontColor1C7CBC alignment:NSTextAlignmentLeft];
        self.timeDifference = [UISubLabel labelWithTitle:@"" frame:CGRectMake(170, 86, 132, 22) font:FontSize24 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
        self.timeDifferenceImageView = [UIImageView ImageViewWithFrame:CGRectMake(155, 87, 145, 25) image:nil];
        [self addSubview:self.timeDifferenceImageView];
        [self addSubview:self.airPortName];
        [self addSubview:self.planTime];
        [self addSubview:self.forecastTime];
        [self addSubview:self.actualTime];
        [self addSubview:self.timeDifference];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end

@implementation ArrivalAirportDetailsCell
@synthesize airPortName,planTime,forecastTime,actualTime,timeDifference,timeDifferenceImageView;
- (void)dealloc
{
    self.airPortName = nil;
    self.planTime = nil;
    self.forecastTime = nil;
    self.actualTime = nil;
    self.timeDifference = nil;
    self.timeDifferenceImageView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(8, 3, ViewWidth - 16, 110) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(8, 108, ViewWidth - 16, 13) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 17, 11, 12) image:[UIImage imageNamed:@"航班动态降落icon.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(32, 57, 113, 0.5) image:[UIImage imageNamed:@"航班动态半段虚线.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(32, 82, 113, 0.5) image:[UIImage imageNamed:@"航班动态半段虚线.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"计划降落" frame:CGRectMake(40, 40, 60, 15) font:FontSize26 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"预计降落" frame:CGRectMake(40, 65, 60, 15) font:FontSize26 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"实际降落" frame:CGRectMake(40, 90, 60, 15) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        self.airPortName = [UISubLabel labelWithTitle:@"" frame:CGRectMake(40, 17, 250, 15) font:FontSize28 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.planTime = [UISubLabel labelWithTitle:@"" frame:CGRectMake(100, 40, 45, 15) font:FontBlodSize26 color:FontColor636363 alignment:NSTextAlignmentLeft];
        self.forecastTime = [UISubLabel labelWithTitle:@"" frame:CGRectMake(100, 65, 45, 15) font:FontBlodSize26 color:FontColor636363 alignment:NSTextAlignmentLeft];
        self.actualTime = [UISubLabel labelWithTitle:@"" frame:CGRectMake(100, 90, 45, 15) font:FontBlodSize26 color:FontColor1C7CBC alignment:NSTextAlignmentLeft];
        self.timeDifference = [UISubLabel labelWithTitle:@"" frame:CGRectMake(170, 86, 132, 22) font:FontSize24 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
        self.timeDifferenceImageView = [UIImageView ImageViewWithFrame:CGRectMake(155, 87, 145, 25) image:nil];
        [self addSubview:self.timeDifferenceImageView];
        [self addSubview:self.airPortName];
        [self addSubview:self.planTime];
        [self addSubview:self.forecastTime];
        [self addSubview:self.actualTime];
        [self addSubview:self.timeDifference];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end


@implementation AgoFlightCell
@synthesize agoFlightDesc;

-(void)dealloc
{
    self.agoFlightDesc = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(8, 3, ViewWidth - 16, 50) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(8, 48, ViewWidth - 16, 13) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        
        self.agoFlightDesc = [UISubLabel labelWithTitle:@"" frame:CGRectMake(40, 13, ViewWidth - 80, 15) font:FontSize28 color:FontColor333333 alignment:NSTextAlignmentLeft];
        [self addSubview:self.agoFlightDesc];
    }
    
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end


@interface FlightTrendsDetailViewController ()

@end

@implementation FlightTrendsDetailViewController
@synthesize pageScroll,pageControl,flightNum,cityArray,flightDynamic,strImageDic,attentionBtn,showTerminal;
@synthesize weixinImg,reload,shareData;
-(void)dealloc
{
    self.pageScroll = nil;
    self.pageControl = nil;
    self.flightNum = nil;
    self.cityArray = nil;
    self.flightDynamic = nil;
    self.strImageDic = nil;
    self.attentionBtn = nil;
    self.shareData = nil;
    
    _oauth = nil;
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
    //self.title = @"航班详情";
    self.title = self.flightNum;
    self.showTerminal = YES;
    self.reload = 0;
    self.strImageDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"航班动态计划2.png",@"航班动态起飞2.png",@"航班动态到达2.png",@"航班动态取消2.png",@"航班动态延误2.png",@"航班动态备降2.png", nil] forKeys:[NSArray arrayWithObjects:@"计划", @"起飞",@"到达",@"取消",@"延误",@"备降",nil]];
    UIButton  * shareButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 7, 52, 30) backImage:[UIImage imageNamed:@"share.png"] target:self action:@selector(showAWSheet)];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    
	// Do any additional setup after loading the view.
    UIScrollView *aScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44-45)];
    self.pageScroll = aScrollView;
    [aScrollView release];
    self.pageScroll.delegate = self;
    self.pageScroll.contentSize = CGSizeMake(ViewWidth*[self.flightDynamic.stopoverInfos count], ViewHeight-44-45);
    self.pageScroll.pagingEnabled = YES;
    
    for(int i = 0;i<[self.flightDynamic.stopoverInfos count];i++)
    {
        UITableView * myTable = [[UITableView alloc] initWithFrame:CGRectMake(ViewWidth*i, 0, ViewWidth, ViewHeight-44-45) style:UITableViewStylePlain];
        myTable.tag = i;
        myTable.backgroundColor = [UIColor clearColor];
        myTable.separatorStyle = UITableViewCellSeparatorStyleNone;//设置tableview每行间的分割线
        myTable.dataSource = self;
        myTable.delegate = self;
        [self.pageScroll addSubview:myTable];
        [myTable release];
    }
    [self.view addSubview:self.pageScroll];
    
    UIPageControl *aPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, ViewHeight-44-52, ViewWidth,10)];
    self.pageControl = aPageControl;
    [aPageControl release];
    self.pageControl.numberOfPages = [self.flightDynamic.stopoverInfos count];
    self.pageControl.currentPage = 0;
    self.pageControl.hidesForSinglePage = YES;
    [self.view addSubview:self.pageControl];
    [self scrollViewDidScroll:self.pageScroll];
    
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight-44-50, ViewWidth, 5) image:[UIImage imageNamed:@"航班动态航班号查询结果-改_10.png"]]];
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake((ViewWidth - 296)/2, ViewHeight-44-50+12, 296, 38) image:[UIImage imageNamed:@"航班动态关注背景.png"]]];
     self.attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth - 296)/2 + 5, ViewHeight-44-50+14, 137, 34) backImage:nil target:self action:@selector(attention:)];
    
    if([self.flightDynamic.attentionId isEqualToString:@""])
    {
        self.attentionBtn.tag = 0;
        [self.attentionBtn setBackgroundImage:[UIImage imageNamed:@"航班动态关注.png"] forState:UIControlStateNormal];
    }
    else
    {
        self.attentionBtn.tag = 1;
        [self.attentionBtn setBackgroundImage:[UIImage imageNamed:@"航班动态取消关注.png"] forState:UIControlStateNormal];
    }
    [self.view addSubview:self.attentionBtn];
    [self.view addSubview:[UIButton customButtonTitle:nil image:[UIImage imageNamed:@"航班动态刷新.png"] frame:CGRectMake(ViewWidth/2 + 6, ViewHeight-44-50+14, 137, 34) target:self action:@selector(updateFlightTrendsDetail)]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.reload == 0)
        self.reload++;
    else {
        [self updateFlightTrendsDetail];
    }
}

- (void)showAWSheet
{
    if (IOS8_OR_LATER)
    {
        UIActionSheet *acitonSheet = [[UIActionSheet alloc] initWithTitle:@"好友分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微信", @"朋友圈", @"新浪微博", @"QQ", nil];
        acitonSheet.tag = 50;
        [acitonSheet showInView:self.view];
        [acitonSheet release];
    }
    else {
        AWActionSheet *sheet = [[AWActionSheet alloc] initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
        sheet.tag = 100;
        [sheet showInView:self.view];
        [sheet release];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 4) {
        [self DidTapOnItemAtIndex:buttonIndex];
    }
}

-(int)numberOfItemsInActionSheet
{
    return 4;
}

-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[[AWActionSheetCell alloc] init] autorelease];
    switch (index) {
        case 0:
        {
            cell.iconView.image = [UIImage imageNamed:@"weChat.png"];
            [[cell titleLabel] setText:[NSString stringWithFormat:@"微信"]];
        }
            break;
        case 1:
        {
            cell.iconView.image = [UIImage imageNamed:@"wechatQuan.png"];
            [[cell titleLabel] setText:[NSString stringWithFormat:@"朋友圈"]];
        }
            break;
        case 2:
        {
            cell.iconView.image = [UIImage imageNamed:@"sina.png"];
            [[cell titleLabel] setText:[NSString stringWithFormat:@"新浪微博"]];
        }
            break;
        default:
        {
            cell.iconView.image = [UIImage imageNamed:@"QQ.png"];
            [[cell titleLabel] setText:[NSString stringWithFormat:@"QQ"]];
        }

            break;
    }

    
    cell.index = index;
    return cell;
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    NSString *wxTitle = [NSString stringWithFormat:@"%@ %@", self.flightNum, self.flightDynamic.flightCompany];
    NSString *wxUrl = [NSString stringWithFormat:@"http://tmap.itkt.com.cn:9595/WeChatH5/html/flightInformation.html?flightNo=%@", self.flightNum];
    
    StopoverInfo *aStopoverInfo = [self.flightDynamic.stopoverInfos objectAtIndex:0];
    NSString *destDateString = [NSString stringWithFormat:@"%d月%d日",[[aStopoverInfo.date substringWithRange:NSMakeRange(5, 2)] intValue],[[aStopoverInfo.date substringWithRange:NSMakeRange(8, 2)] intValue]];
    
    NSString *forecastStartTime = [NSString string];//预计起飞时间
    NSString *forecastArriveTime = [NSString string];//预计到达时间
    NSString *actualStartTime = [NSString string];//实际起飞时间
    NSString *actualArriveTime = [NSString string];//实际到达时间
    NSString *startCity = [NSString string];
    NSString *arriveCity = [NSString string];
    
    forecastStartTime = aStopoverInfo.takeOffTime.forecast;
    actualStartTime = aStopoverInfo.takeOffTime.actual;
    startCity = aStopoverInfo.departure;
    
    for(int i = 0;i<[self.flightDynamic.stopoverInfos count];i++)
    {
        forecastArriveTime = ((StopoverInfo*)[self.flightDynamic.stopoverInfos objectAtIndex:i]).reachTime.forecast;
        actualArriveTime = ((StopoverInfo*)[self.flightDynamic.stopoverInfos objectAtIndex:i]).reachTime.actual;
        arriveCity = ((StopoverInfo*)[self.flightDynamic.stopoverInfos objectAtIndex:i]).arrival;
    }
    
    NSString *stateStr = aStopoverInfo.statusCode;
    NSString *wxDesc = [NSString string];
    if([stateStr isEqualToString:@"计划"])
    {
        wxDesc = [NSString stringWithFormat:@"预计于%@从%@起飞，%@降落在%@。",forecastStartTime,startCity,forecastArriveTime,arriveCity];
    }
    else if ([stateStr isEqualToString:@"起飞"])
    {
        wxDesc = [NSString stringWithFormat:@"已于%@从%@起飞，预计于%@降落在%@。",actualStartTime,startCity,forecastArriveTime,arriveCity];
    }
    else if ([stateStr isEqualToString:@"到达"])
    {
        wxDesc = [NSString stringWithFormat:@"已于%@降落在%@。",actualArriveTime,arriveCity];
    }
    else if ([stateStr isEqualToString:@"延误"])
    {
        wxDesc = [NSString stringWithFormat:@"此航班延误中正在等待起飞。"];
    }
    else if ([stateStr isEqualToString:@"备降"])
    {
        wxDesc = [NSString stringWithFormat:@"已于%@从%@起飞，当前状态是备降。",actualStartTime,startCity];
    }
    else //取消
    {
        wxDesc = [NSString stringWithFormat:@"此航班已取消。"];
    }   
    
    self.shareData = wxDesc;
    switch (index) {
        case 0:
        {
            if ([self isWeChatHave]) {
                [UserInfo sharedUserInfo]._isActivityShare = NO;
                [WeiXinExport sendAppContent:wxTitle withDes:wxDesc withImg:[UIImage imageNamed:@"icon.png"] withUrl:wxUrl];
            }
        }
            break;
        case 1:
        {
            if ([self isWeChatHave]) {
                [UserInfo sharedUserInfo]._isActivityShare = NO;
                [WeiXinExport sendAppContentTo:wxTitle withDes:wxDesc withImg:[UIImage imageNamed:@"icon.png"] withUrl:wxUrl];
            }
        }
            break;
        case 2:
        {
           // xmy SDK版新浪微博分享
                
                double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
                if(version >=6.0f)
                {
                    SLComposeViewController *slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
                    [slComposerSheet setInitialText:[NSString stringWithFormat:@"%@#%@#航班，%@ @掌上航旅",destDateString,self.flightNum,wxDesc]];
                    [slComposerSheet addImage:nil];
                    [slComposerSheet addURL:[NSURL URLWithString:@"http://www.itkt.com/jsp/phone.jsp"]];
                    
                    SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
                        NSLog(@"start completion block");
                        NSString *output;
                        switch (result) {
                            case SLComposeViewControllerResultCancelled:
                                output = @"取消分享";
                                break;
                            case SLComposeViewControllerResultDone:
                                output = @"分享成功";
                                break;
                            default:
                                break;
                        }
                        if (result != SLComposeViewControllerResultCancelled)
                        {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                            [alert show];
                            [alert release];
                        }
                        [slComposerSheet dismissViewControllerAnimated:YES completion:Nil];
                    };
                    slComposerSheet.completionHandler = myBlock;
                    [self presentViewController:slComposerSheet animated:YES completion:nil];
                }
                else
                {

                    if ([WeiboSDK isWeiboAppInstalled] ) {
                        WBMessageObject *message = [WBMessageObject message];
                        message.text = [NSString stringWithFormat:@"%@#%@#航班，%@ @掌上航旅",destDateString,self.flightNum,wxDesc];
                        WBSendMessageToWeiboRequest *sendMessageRequest = [WBSendMessageToWeiboRequest requestWithMessage:message];
                        sendMessageRequest.userInfo = @{@"ShareMessageFrom": @"FlightTrendsDetailViewController",
                                                        @"Other_Info_1": [NSNumber numberWithInt:123],
                                                        @"Other_Info_2": @[@"obj1", @"obj2"],
                                                        @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
                        
                        [WeiboSDK sendRequest:sendMessageRequest];
                    }
                    else{
                        NSString * urlStr = [NSString stringWithFormat:@"http://v.t.sina.com.cn/share/share.php?title=%@#%@#航班，%@ @掌上航旅",destDateString,self.flightNum,wxDesc];
                        ShareToSinaViewController * shareVC  = [[ShareToSinaViewController alloc] init];
                        shareVC._url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                        [NavigationController pushViewController:shareVC animated:YES];
                        [shareVC release];
                    }

                }
        }
            break;
        default:
        {
            _oauth = [[TencentOAuth alloc] initWithAppId:QQAPPID
                                             andDelegate:self];
            NSString *str = [NSString stringWithFormat:@"http://tmap.itkt.com.cn:9595/WeChatH5/html/flightInformation.html?flightNo=%@", self.flightNum];
            NSString *utf8String = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *title = [NSString stringWithFormat:@"%@ %@",self.flightNum,self.flightDynamic.flightCompany];

            QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String]
                                                                title:title
                                                          description:self.shareData
                                                      previewImageURL:nil];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
            QQApiSendResultCode send = [QQApiInterface sendReq:req];
            
            [self handleSendResult:send];
            
        }
            break;
    }
}

#pragma mark-QQ
- (void)tencentDidLogin
{

}

- (void)showInvalidTokenOrOpenIDMessage{
    UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
    [alert show];
}

//非网络错误导致登录失败
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
}

- (void)tencentDidNotNetWork
{
    
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
//        case EQQAPISENDFAILD:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//            [msgbox show];
//            break;
//        }
//        case   EQQAPISENDSUCESS:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:nil message:@"分享成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [msgbox show];
//            break;
//        }
        default:
        {
            break;
        }
    }
}


-(void)updateFlightTrendsDetail
{
    ASIFormDataRequest * theRequest = [InterfaceClass getFlightDynamicByFlightNoWithUserId:[UserInfo sharedUserInfo].userID?[UserInfo sharedUserInfo].userID:@"" flightNo:self.flightNum];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onNumPaseredResult:) Delegate:self needUserType:Default];
}

-(void)onNumPaseredResult:(NSDictionary *)dic
{
    if (dic)
    {
        self.flightDynamic = [GetFlightDynamicByFlightNo GetFlightDynamicByFlightNo:dic];
        if([self.flightDynamic.attentionId isEqualToString:@""])
        {
            self.attentionBtn.tag = 0;
            [self.attentionBtn setBackgroundImage:[UIImage imageNamed:@"航班动态关注.png"] forState:UIControlStateNormal];
        }
        else
        {
            self.attentionBtn.tag = 1;
            [self.attentionBtn setBackgroundImage:[UIImage imageNamed:@"航班动态取消关注.png"] forState:UIControlStateNormal];
        }

        [self.pageScroll reloadInputViews];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
    NSArray *subViews = self.pageControl.subviews;
    for (int i = 0; i < [subViews count]; i++) {
        UIView* subView = [subViews objectAtIndex:i];
        if ([NSStringFromClass([subView class]) isEqualToString:NSStringFromClass([UIImageView class])]) {
            ((UIImageView*)subView).image = (self.pageControl.currentPage == i ? [UIImage imageNamed:@"cehua_nomal.png"] : [UIImage imageNamed:@"cehua_press.png"]);
        }
    }
    
    CGFloat pageWidth = self.pageScroll.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 3) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}


-(void)attention:(UIButton*)sender
{
    if(sender.tag == 0)
    {
        ASIFormDataRequest * theRequest = [InterfaceClass setAttentionStateWithUserId:[UserInfo sharedUserInfo].userID flightNo:self.flightNum departure:[cityArray objectAtIndex:0] arrival:[self.cityArray objectAtIndex:1]];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSetPaseredResult:) Delegate:self needUserType:Member];
    }
    else
    {
        ASIFormDataRequest * theRequest = [InterfaceClass cancelAttentionStateWithUserId:[UserInfo sharedUserInfo].userID ids:self.flightDynamic.attentionId];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCancelPaseredResult:) Delegate:self needUserType:Member];
    }
}
-(void)onSetPaseredResult:(NSDictionary *)dic
{
    if([[dic objectForKey:@"statusCode"] intValue] == -99999)
    {
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
    }
    else 
    {
        self.flightDynamic.attentionId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        self.attentionBtn.tag = 1;
         [self.attentionBtn setBackgroundImage:[UIImage imageNamed:@"航班动态取消关注.png"] forState:UIControlStateNormal];
    }
    NSLog(@"关注!");
}
-(void)onCancelPaseredResult:(NSDictionary *)dic
{
    NSLog(@"取消!");
    if([[dic objectForKey:@"statusCode"] intValue] == -99999)
    {
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
    }
    else 
    {
        self.attentionBtn.tag = 0;
        [self.attentionBtn setBackgroundImage:[UIImage imageNamed:@"航班动态关注.png"] forState:UIControlStateNormal];
    }
}
-(NSString *)compareTime:(NSString *)planTime actual:(NSString *)actualTime
{
    NSString * returnTime = nil;
    NSArray * planArray = [planTime componentsSeparatedByString:@":"];
    NSArray * actualArray = [actualTime componentsSeparatedByString:@":"];
    NSInteger planTimeInt = [[planArray objectAtIndex:0] intValue] * 60 + [[planArray objectAtIndex:1] intValue];
    NSInteger actualTimeInt = [[actualArray objectAtIndex:0] intValue] * 60 + [[actualArray objectAtIndex:1] intValue];
    NSInteger returnTimeInt = actualTimeInt - planTimeInt;
    NSInteger hour = abs(returnTimeInt)  / 60;
    NSInteger minute = abs(returnTimeInt) % 60;
    NSString * str ;
    if (returnTimeInt >0) {
        str = @"晚点";
    }
    else {
        str = @"提前";
    }
    NSString * hourStr;
    if (hour == 0) {
        hourStr = @"";
    }
    else {
        hourStr = [NSString stringWithFormat:@"%d小时",hour];
    }
    NSString * minuteStr;
    if (minute == 0) {
        minuteStr = @"";
    }
    else {
        minuteStr = [NSString stringWithFormat:@"%d分钟",minute];
    }
    
    returnTime = [NSString stringWithFormat:@"比计划%@%@%@",str,hourStr,minuteStr];
    
    return returnTime;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 130.0f;
    }
    else if(indexPath.row == 3)
    {
        return 60.0f;
    }
    else
    {
    return 118.0f;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StopoverInfo *stopoverInfo = [self.flightDynamic.stopoverInfos objectAtIndex:tableView.tag];
    if([stopoverInfo.startTerminal isEqualToString:@""] || [stopoverInfo.endTerminal isEqualToString:@""])
    {
        self.showTerminal = NO;
    }
    else {
        self.showTerminal = YES;
    }
    if(indexPath.row == 0)
    {
        static NSString *flightDetailsCellIdentifier = @"flightDetailsCellIdentifier";
        FlightDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:flightDetailsCellIdentifier];
        if(cell == nil){
            cell = [[[FlightDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flightDetailsCellIdentifier] autorelease];
        }
        
        cell.flightNum.text  = self.flightNum;
        cell.flightCompany.text = self.flightDynamic.flightCompany;
        cell.startCity.text = stopoverInfo.departure;
        cell.arrivalCity.text = stopoverInfo.arrival;
        self.cityArray = [NSArray arrayWithObjects:stopoverInfo.departureCode, stopoverInfo.arrivalCode,nil];
        cell.flightdate.text = stopoverInfo.date;
        cell.weekDay.text = [self theWeekOfToday:stopoverInfo.date];
        self.weixinImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.strImageDic objectForKey:stopoverInfo.statusCode]]];
        cell.flightStatus.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.strImageDic objectForKey:stopoverInfo.statusCode]]];
        cell.selected = NO;
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if(indexPath.row == 1)
    {
        static NSString *departureAirportDetailsCellIdentifier = @"departureAirportDetailsCellIdentifier";
        DepartureAirportDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:departureAirportDetailsCellIdentifier];
        if(cell == nil){
            cell = [[[DepartureAirportDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:departureAirportDetailsCellIdentifier] autorelease];
        }
        if(self.showTerminal)
        {
            cell.airPortName.text = [NSString stringWithFormat:@"%@%@",stopoverInfo.startAirport,stopoverInfo.startTerminal];
        }
        else 
        {
            cell.airPortName.text = [NSString stringWithFormat:@"%@",stopoverInfo.startAirport];
        }
        cell.planTime.text = stopoverInfo.takeOffTime.plan;
        cell.forecastTime.text = stopoverInfo.takeOffTime.forecast;
        cell.actualTime.text = stopoverInfo.takeOffTime.actual;
        if ([stopoverInfo.takeOffTime.actual isEqualToString:@""])//当无实际时间时，以预计时间和计划时间对比
        {
            if(!([stopoverInfo.takeOffTime.plan isEqualToString:@" "]))
            {
                cell.timeDifference.text = [self compareTime:stopoverInfo.takeOffTime.plan actual:stopoverInfo.takeOffTime.forecast];
                if(cell.timeDifference.text.length == 5)
                {
                    cell.timeDifference.hidden = YES;
                    cell.timeDifferenceImageView.hidden = YES;
                }
                else {
                    cell.timeDifferenceImageView.frame = CGRectMake(155, 62, 145, 25);
                    cell.timeDifference.frame = CGRectMake(165, 61, 132, 22);
                    cell.timeDifferenceImageView.image = [UIImage imageNamed:@"航班号查询结果"];
                }
            }
        }
        else//当有实际时间后，以实际时间和计划时间对比
        {
            if(!([stopoverInfo.takeOffTime.plan isEqualToString:@" "]))
            {
                cell.timeDifference.text = [self compareTime:stopoverInfo.takeOffTime.plan actual:stopoverInfo.takeOffTime.actual];
                if(cell.timeDifference.text.length == 5)
                {
                    cell.timeDifference.hidden = YES;
                    cell.timeDifferenceImageView.hidden = YES;
                }
                else {
                    cell.timeDifferenceImageView.frame = CGRectMake(155, 87, 145, 25);
                    cell.timeDifference.frame = CGRectMake(165, 86, 132, 22);
                    cell.timeDifferenceImageView.image = [UIImage imageNamed:@"航班号查询结果"];
                }
            }
        }
        return cell;
    }
    else if(indexPath.row == 2)
    {
        static NSString *arrivalAirportDetailsCellIdentifier = @"arrivalAirportDetailsCellIdentifier";
        ArrivalAirportDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:arrivalAirportDetailsCellIdentifier];
        if(cell == nil){
            cell = [[[ArrivalAirportDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:arrivalAirportDetailsCellIdentifier] autorelease];
        }
//        stopoverInfo.reachTime.plan = @"9:30";
        if(self.showTerminal)
        {
            cell.airPortName.text = [NSString stringWithFormat:@"%@%@",stopoverInfo.endAirport,stopoverInfo.endTerminal];
        }
        else 
        {
            cell.airPortName.text = [NSString stringWithFormat:@"%@",stopoverInfo.endAirport];
        }
        cell.planTime.text = stopoverInfo.reachTime.plan;
        cell.forecastTime.text = stopoverInfo.reachTime.forecast;
        cell.actualTime.text = stopoverInfo.reachTime.actual;
        if ([stopoverInfo.reachTime.actual isEqualToString:@""])//当无实际时间时，以预计时间和计划时间对比
        {
            if(!([stopoverInfo.reachTime.plan isEqualToString:@" "]))
            {
                cell.timeDifference.text = [self compareTime:stopoverInfo.reachTime.plan actual:stopoverInfo.reachTime.forecast];
                if(cell.timeDifference.text.length == 5)
                {
                    cell.timeDifference.hidden = YES;
                    cell.timeDifferenceImageView.hidden = YES;
                }
                else {
                    cell.timeDifferenceImageView.frame = CGRectMake(155, 62, 145, 25);
                    cell.timeDifference.frame = CGRectMake(165, 61, 132, 22);
                    cell.timeDifferenceImageView.image = [UIImage imageNamed:@"航班号查询结果"];
                }
            }
        }
        else//当有实际时间后，以实际时间和计划时间对比
        {
            if(!([stopoverInfo.reachTime.plan isEqualToString:@" "]))
            {
                cell.timeDifference.text = [self compareTime:stopoverInfo.reachTime.plan actual:stopoverInfo.reachTime.actual];
                if(cell.timeDifference.text.length == 5)
                {
                    cell.timeDifference.hidden = YES;
                    cell.timeDifferenceImageView.hidden = YES;
                }
                else {
                    cell.timeDifferenceImageView.frame = CGRectMake(155, 87, 145, 25);
                    cell.timeDifference.frame = CGRectMake(165, 86, 132, 22);
                    cell.timeDifferenceImageView.image = [UIImage imageNamed:@"航班号查询结果"];
                }
            }
        }
        return cell;
    }
    else
    {
        static NSString *agoFlightCellIdentifier = @"agoFlightCellIdentifier";
        AgoFlightCell *cell = [tableView dequeueReusableCellWithIdentifier:agoFlightCellIdentifier];
        if(cell == nil){
            cell = [[[AgoFlightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:agoFlightCellIdentifier] autorelease];
        }
        
        if(![self.flightDynamic.agoFlightNo isEqualToString:@""] && ![self.flightDynamic.agoFlightDesc isEqualToString:@""])
        {
            cell.agoFlightDesc.text = self.flightDynamic.agoFlightDesc;
        }
        else
        {
            cell.agoFlightDesc.text = @"暂无前序航班信息";
        }
        CGSize suggestedSize = [cell.agoFlightDesc.text sizeWithFont:FontSize28 constrainedToSize:CGSizeMake(cell.agoFlightDesc.frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        CGRect rect = cell.agoFlightDesc.frame;
        rect.size.height = suggestedSize.height;
        cell.agoFlightDesc.frame = rect;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 3 && ![self.flightDynamic.agoFlightNo isEqualToString:@""] && ![self.flightDynamic.agoFlightDesc isEqualToString:@""])
    {
        ASIFormDataRequest * theRequest = [InterfaceClass getFlightDynamicByFlightNoWithUserId:[UserInfo sharedUserInfo].userID?[UserInfo sharedUserInfo].userID:@"" flightNo:self.flightDynamic.agoFlightNo];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onAgoFlightPaseredResult:) Delegate:self needUserType:Default];
    }
}

-(void)onAgoFlightPaseredResult:(NSDictionary *)dic
{
    if (dic)
    {
        FlightTrendsDetailViewController * flightTrendsDetailVC = [[FlightTrendsDetailViewController alloc] init];
        flightTrendsDetailVC.flightDynamic = (GetFlightDynamicByFlightNo*)[GetFlightDynamicByFlightNo GetFlightDynamicByFlightNo:dic];
        flightTrendsDetailVC.flightNum = self.flightDynamic.agoFlightNo;
        
        [NavigationController pushViewController:flightTrendsDetailVC animated:YES];
        [flightTrendsDetailVC release];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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

#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 123) {//微信
        if (buttonIndex == 1) {
            
            NSString *weChatUrl = [WXApi getWXAppInstallUrl];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weChatUrl]];
        }
    }
//    else if (alertView.tag == 124) {//微信
//        if (buttonIndex == 1) {
//            
//            NSString *weChatUrl = [WXApi getWXAppInstallUrl];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weChatUrl]];
//        }
//    }
}
@end
