//
//  TicketHomeViewController.m
//  FlightProject
//
//  Created by longcd on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TicketHomeViewController.h"
#import "TicketQueryViewController.h"
#import "FlightTrendsViewController.h"
#import "TicketAppointmentViewController.h"
#import "AutoDepreciateViewController.h"
#import "AirportKnowledgeViewController.h"
#import "MemberLoginViewController.h"

@interface UIImageViewSubClass : UIImageView
@property (nonatomic,assign)int subTag;
@end
@implementation UIImageViewSubClass
@synthesize subTag;
@end


@implementation CustomTabbarView
@synthesize  viewControllers,defultImages,selectedImages,tabbarDelegate;
-(void)dealloc
{
    self.viewControllers = nil;
    self.defultImages = nil;
    self.selectedImages = nil;
    self.tabbarDelegate = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:self.bounds image:[UIImage imageNamed:@"TabbarBackground.png"] ]];
    }
    return self;
}
-(void)setViewControllers:(NSArray *)array
{
    if (viewControllers != array) {
        [viewControllers release];
        viewControllers = [array retain];
        for (int i=0; i < [viewControllers count]; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom tag:i+1 title:nil frame:CGRectMake(0+ViewWidth/[viewControllers count]*i, 0, ViewWidth/[viewControllers count], self.frame.size.height) backImage:nil target:self action:@selector(buttonClicked:)];
            [self addSubview:button];
            UIImageViewSubClass * imageV =[[UIImageViewSubClass alloc] initWithFrame:CGRectMake(0+ViewWidth/[viewControllers count]*i, 0, 39, 30)];
            imageV.center = button.center;
            imageV.subTag = i+1;
            [self addSubview:imageV];
            [imageV release];
        }
    }
}
-(void)setDefultImages:(NSArray *)array
{
    if (defultImages != array) {
        [defultImages release];
        defultImages = [array retain];
    }
    for (UIImageViewSubClass * elem in [self subviews]) {
        if ([elem isKindOfClass:[UIImageViewSubClass class]]) {
            elem.image = [defultImages objectAtIndex:elem.subTag-1];
        }
    }
}
-(void)setSelectedImages:(NSArray *)array
{
    if (selectedImages != array) {
        [selectedImages release];
        selectedImages = [array retain];
    }
    for (UIImageViewSubClass * elem in [self subviews]) {
        if ([elem isKindOfClass:[UIImageViewSubClass class]]) {
            if (elem.subTag == 1) {
                elem.image = [selectedImages objectAtIndex:elem.subTag-1] ;
                break;
            }

        }
    }
}
-(void) changSelectedV:(NSInteger ) index
{
    for (UIImageViewSubClass * elem in [self subviews]) {
        if ([elem isKindOfClass:[UIImageViewSubClass class]]) {
            if (elem.subTag == index) {
                elem.image = [self.selectedImages objectAtIndex:elem.subTag-1];
            }
            else {
                elem.image = [self.defultImages objectAtIndex:elem.subTag-1];
            }
        }
    }
   
}
-(void)buttonClicked:(UIButton *)button
{
    
    if (tabbarDelegate && [tabbarDelegate respondsToSelector:@selector(customTabbarViewDidSelectViewController:)]) {
        if (![[self.viewControllers objectAtIndex:button.tag-1] isKindOfClass:[UIViewController class]]) {
            return;
        }
        [tabbarDelegate performSelector:@selector(customTabbarViewDidSelectViewController:) withObject:[self.viewControllers objectAtIndex:button.tag-1]];
    }

}
@end

@interface TicketHomeViewController ()

@end

@implementation TicketHomeViewController
@synthesize ticketDelegate,activeView,preView,ticketDataModel;
-(void)dealloc
{
    self.ticketDelegate = nil;
    self.activeView = nil;
    self.ticketDataModel = nil;
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
    //self.navigationItem.rightBarButtonItem = nil;
	
    // Do any additional setup after loading the view.
    
    UIView * activeV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44)];
    activeV.backgroundColor = [UIColor greenColor];
    [self.view addSubview:activeV];
    [activeV release];
    self.activeView = activeV;
    
    TicketQueryViewController * ticketQueryVC = [[TicketQueryViewController alloc] init];
    FlightTrendsViewController * flightTrendsVC = [[FlightTrendsViewController alloc] init];
    TicketAppointmentViewController * ticketAppointmentVC = [[TicketAppointmentViewController alloc] init];
    AutoDepreciateViewController * autodepreciateVC = [[AutoDepreciateViewController alloc] init];
    AirportKnowledgeViewController * airportknowledgeVC = [[AirportKnowledgeViewController alloc] init];
    ticketQueryVC.title = @"机票查询";
    flightTrendsVC.title = @"航班动态";
    ticketAppointmentVC.title = @"机票预约";
    autodepreciateVC.title = @"自动降价";
    airportknowledgeVC.title = @"机场宝典";
    
    if (self.ticketDataModel == nil) {
        TicketQueryDataModel * tempDataModel = [[TicketQueryDataModel alloc] init];
        self.ticketDataModel = tempDataModel;
        [tempDataModel release];
        tempDataModel._fromCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:@"北京"  code:@"PEK" ];
        tempDataModel._toCity = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:@"上海"  code:@"SHA" ];
        tempDataModel._transitCity =  [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:@""  code:@"" ];

        NSString * startDate = [NSDate dateTimeCode:[NSDate date]]; //@"yyyy-MM-dd HH:mm"
        if ([[[[[startDate componentsSeparatedByString:@" "] objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:0] intValue] >=12) {
            tempDataModel._startDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate date] day:1 type:3] code: [NSDate dateafterDay:[NSDate date] day:1 type:1]];
            tempDataModel._arriveDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate date] day:Delay_Days+1 type:3] code: [NSDate dateafterDay:[NSDate date] day:Delay_Days+1 type:1]];
        }
        else{
            tempDataModel._startDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr:[NSDate dateFormateTicketQuery:[NSDate date]] code:[NSDate dateCode:[NSDate date] ]];
            tempDataModel._arriveDate = [TicketQueryDataModelElem TicketQueryDataModelElemWithStr: [NSDate dateafterDay:[NSDate date] day:Delay_Days type:3] code: [NSDate dateafterDay:[NSDate date] day:Delay_Days type:1]];
        }
        tempDataModel._flightType = SingleType;
    }
    ticketQueryVC.queryDataModel = self.ticketDataModel;

    self.ticketDelegate = ticketQueryVC;
    
    self.title = @"机票查询";

    [self.activeView addSubview:ticketQueryVC.view];
    ticketQueryVC.view.frame = self.activeView.frame;
    self.preView = ticketQueryVC.view;
    NSLog(@"%@",self.view);

    tabbarV = [[CustomTabbarView alloc] initWithFrame:CGRectMake(0, ViewHeight-44-44, ViewWidth, 44)];
    tabbarV.viewControllers = [NSArray arrayWithObjects:ticketQueryVC,flightTrendsVC,ticketAppointmentVC,autodepreciateVC,airportknowledgeVC, nil];
    NSMutableArray * defultImages = [NSMutableArray array];
    NSMutableArray * selectedImages = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        [defultImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Tabbar%d-0.png",i]]];
        [selectedImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Tabbar%d-1.png",i]]];
    }
    tabbarV.defultImages = defultImages;
    tabbarV.selectedImages = selectedImages;
    tabbarV.tabbarDelegate = self;
    [self.view addSubview:tabbarV];
    [tabbarV release];

}
-(void)changeModel:(UISegmentedControl *)sender
{
	if (self.ticketDelegate && [self.ticketDelegate respondsToSelector:@selector(changeModel:)]) {
		[self.ticketDelegate performSelector:@selector(changeModel:) withObject:sender];
	}
}
-(void)customTabbarViewDidSelectViewController:(UIViewController *)viewController
{
    self._VCType = Default;
    self.ticketDelegate = viewController;
    if ([viewController isKindOfClass:[AutoDepreciateViewController class]] || [viewController isKindOfClass:[TicketAppointmentViewController class]] ){
        self._VCType = Member;
        if (!self.isLogin) { // 未登录  [[UserInfo sharedUserInfo].userID isEqualToString:@""]  非会员
//            MemberLoginViewController  * memberLoginVC = [[MemberLoginViewController alloc] init];
//            memberLoginVC.delegate = self;
//            [NavigationController pushViewController:memberLoginVC animated:YES];
//            [memberLoginVC release];	
        }
        else {
            [self loginSuccessFul];            
        }   
    }
    else {
        
        NSInteger  index =  [tabbarV.viewControllers indexOfObject:self.ticketDelegate];
        [tabbarV changSelectedV:index +1];
        self.title = self.ticketDelegate.title;
        [self.preView removeFromSuperview];
        [self.activeView addSubview:self.ticketDelegate.view];
        self.ticketDelegate.view.frame = self.activeView.frame;
        self.preView = self.ticketDelegate.view;
        
    }
}
-(void) loginSuccessFul
{
    NSInteger  index =  [tabbarV.viewControllers indexOfObject:self.ticketDelegate];
    [tabbarV changSelectedV:index +1];
    if ([self.ticketDelegate isKindOfClass:[AutoDepreciateViewController class]]) {
        AutoDepreciateViewController * viewController = (AutoDepreciateViewController *) self.ticketDelegate;
        [viewController againQuoteDataSource];
    }
    else if ([self.ticketDelegate isKindOfClass:[TicketAppointmentViewController class]]) {
        TicketAppointmentViewController * viewController = (TicketAppointmentViewController *) self.ticketDelegate;
        [viewController againQuoteDataSource];
    }    
    self.title = self.ticketDelegate.title;
    [self.preView removeFromSuperview];
    [self.activeView addSubview:self.ticketDelegate.view];
    self.ticketDelegate.view.frame = self.activeView.frame;
    self.preView = self.ticketDelegate.view;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (ticketDelegate && [ticketDelegate respondsToSelector:@selector(reloadTableView)]) {
        [ticketDelegate performSelector:@selector(reloadTableView)];
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
}



@end
