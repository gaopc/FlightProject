//
//  HelpViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HelpViewController.h"
#import "GCCustomSectionController.h"
#import "HelpDetailViewController.h"

@interface HelpViewController ()

@property (nonatomic, retain) NSArray* retractableControllers;

@end

@implementation HelpViewController
@synthesize retractableControllers;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"使用帮助";
    UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 0, 52, 30) backImage:[UIImage imageNamed:@"backPre.png"] target:self action:@selector(backHome)];
    UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    UIButton  * rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 7, 52, 30) backImage:[UIImage imageNamed:@"backHome.png"] target:self action:@selector(goHome)];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
	// Do any additional setup after loading the view.
    GCCustomSectionController* customController1 = [[GCCustomSectionController alloc] initWithArray:[NSArray arrayWithObjects:@"机票预订",@"航班动态",@"机票预约",@"自动降价",@"我的航旅",@"服务信息", nil] title:@"机票" viewController:self];
    GCCustomSectionController* customController2 = [[GCCustomSectionController alloc] initWithArray:nil title:@"酒店" viewController:self];
    GCCustomSectionController* customController3 = [[GCCustomSectionController alloc] initWithArray:nil title:@"租车" viewController:self];
    GCCustomSectionController* customController4 = [[GCCustomSectionController alloc] initWithArray:nil title:@"畅达币" viewController:self];
    GCCustomSectionController* customController5 = [[GCCustomSectionController alloc] initWithArray:nil title:@"行程单" viewController:self];
    GCCustomSectionController* customController6 = [[GCCustomSectionController alloc] initWithArray:nil title:@"支付方式" viewController:self];
    self.retractableControllers = [NSArray arrayWithObjects:customController1, customController2, customController3, customController4,customController5,customController6, nil];
    customController1.tableView.tag = 1;
    customController2.tableView.tag = 2;
    customController3.tableView.tag = 3;
    customController4.tableView.tag = 4;
    customController5.tableView.tag = 5;
    customController6.tableView.tag = 6;
    [customController1 release];
    [customController2 release];
    [customController3 release];
    [customController4 release];
    [customController5 release];
    [customController6 release];
}

-(void) backHome
{
    [NavigationController popViewControllerAnimated:YES];
}
-(void)goHome
{
	[NavigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.retractableControllers count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:section];
    return sectionController.numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController cellForRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row)
    {
        HelpDetailViewController *helpDetail = [[HelpDetailViewController alloc] init];
//        if(indexPath.row!=0)
//        {
//            switch (indexPath.row) {
//                case 1:
//                {
//                    NSArray *imageNames = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"机票查询帮助"], [NSString stringWithFormat:@"选择航班帮助"],[NSString stringWithFormat:@"是否经停帮助"],[NSString stringWithFormat:@"订单填写帮助"],[NSString stringWithFormat:@"订单确认帮助"],nil];
//                    helpDetail.imageNames = imageNames;
//                    [imageNames release];
//                }
//                    break;
//                case 2:
//                {
//                    NSArray *imageNames = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"航班动态帮助"],nil];
//                    helpDetail.imageNames = imageNames;
//                    [imageNames release];
//                }
//                    break;
//                case 3:
//                {
//                    NSArray *imageNames = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"机票预约帮助"],nil];
//                    helpDetail.imageNames = imageNames;
//                    [imageNames release];
//                }
//                    break;
//                case 4:
//                {
//                    NSArray *imageNames = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"自动降价帮助"], [NSString stringWithFormat:@"自动降价列表帮助"],nil];
//                    helpDetail.imageNames = imageNames;
//                    [imageNames release];
//                }
//                    break;
//                case 5:
//                {
//                    NSArray *imageNames = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"我的航旅帮助"], [NSString stringWithFormat:@"会员登录帮助"],[NSString stringWithFormat:@"用户注册帮助"],[NSString stringWithFormat:@"重置密码帮助"],nil];
//                    helpDetail.imageNames = imageNames;
//                    [imageNames release];
//                }
//                    break;
//                default:
//                {
//                    NSArray *imageNames = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"服务信息帮助"],nil];
//                    helpDetail.imageNames = imageNames;
//                    [imageNames release];
//                }
//                    break;
//            }
//        }
        
        [NavigationController pushViewController:helpDetail animated:YES];
        [helpDetail release];
        return;
    }
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController didSelectCellAtRow:indexPath.row];
}

- (void)dealloc
{
    self.retractableControllers = nil;
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
