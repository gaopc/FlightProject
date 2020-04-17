//
//  PeripheryServicesViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PeripheryServicesViewController.h"
#import "AirPortListViewController.h"
#import "ServiceDetailViewController.h"

@implementation ServiceCell
@synthesize leftButton,rightButton,leftLabel,rightLabel;
- (void)dealloc
{
    self.leftLabel = nil;
    self.rightLabel = nil;
    self.leftButton = nil;
    self.rightButton = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float offx = (ViewWidth - 320)/2;
        // Initialization code
//        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" backImage:[UIImage imageNamed:@"机场宝典-下级菜单.png"] frame:CGRectMake(10, 3, 141, 47) font:FontSize36 color:FontColor000000 target:nil action:nil];
//        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" backImage:[UIImage imageNamed:@"机场宝典-下级菜单.png"] frame:CGRectMake(162, 3, 141, 47) font:FontSize36 color:FontColor000000 target:nil action:nil];
        self.leftButton = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"机场宝典-下级菜单.png"] frame:CGRectMake(10, 3, 145 + offx, 47) target:nil action:nil];
        self.rightButton = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"机场宝典-下级菜单.png"] frame:CGRectMake(165 + offx, 3, 145 + offx, 47) target:nil action:nil];
        self.leftLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(10, 3, 135 + offx, 47) font:FontSize36 color:FontColor000000 alignment:NSTextAlignmentCenter autoSize:NO];
        self.rightLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(165 + offx, 3, 135 + offx, 47) font:FontSize36 color:FontColor000000 alignment:NSTextAlignmentCenter autoSize:NO];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];
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



@interface PeripheryServicesViewController ()

@end

@implementation PeripheryServicesViewController
@synthesize data,queryFacilityService,myTable;
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
    self.title = @"设施服务";
    [self setNameLabelText:self.data];
    self.delegate = self;
	// Do any additional setup after loading the view.
    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 61, ViewWidth, ViewHeight-44-30-40) style:UITableViewStylePlain];
    aTableView.backgroundColor = [UIColor clearColor];
    aTableView.dataSource = self;
    aTableView.delegate = self;
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    aTableView.allowsSelection = NO;
    self.myTable = aTableView;
    [self setMyCureentView:self.myTable];
    [aTableView release];
 
}

-(void)reloadViewData
{
    if(self.enterAirlinesVC)
    {
        [self.airportNameLabel setText:self.airPortData.airportName];
        self.queryFacilityService = nil;
        [self.myTable  reloadData];
        ASIFormDataRequest * theRequest = [InterfaceClass queryFacilityServiceByAirportCode:self.airPortData.airportCode];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onFacilityServicePaseredResult:) Delegate:self needUserType:Default]; 
    }
    self.enterAirlinesVC = NO;
}

-(void)onFacilityServicePaseredResult:(NSDictionary*)dic
{
    self.queryFacilityService = (QueryFacilityService*)[QueryFacilityService GetQueryFacilityServiceByAirportCode:dic];
    self.data = [AirportData AirportDataWithName:self.airPortData.airportName CODE:self.airPortData.airportCode];
    [self.myTable reloadData];
}
-(void)clickButton:(UIButton*)sender
{
    FacilityServiceData* aFacilityServiceData =  [self.queryFacilityService.serviceList objectAtIndex:sender.tag];
    ServiceDetailViewController *serviceDetailVC = [[ServiceDetailViewController alloc] init];
    serviceDetailVC.title = ((FacilityServiceData*)[self.queryFacilityService.serviceList objectAtIndex:sender.tag]).name;
    serviceDetailVC.urlStr = [NSString stringWithFormat:@"%@/queryFacilityServiceDetails?airportCode=%@&serviceId=%@",ThreeStagesUrl,self.airPortData.airportCode,aFacilityServiceData.ids];
    [NavigationController pushViewController:serviceDetailVC animated:YES];
    [serviceDetailVC release];
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ([self.queryFacilityService.serviceList count]%2)==(0)?([self.queryFacilityService.serviceList count]/2):([self.queryFacilityService.serviceList count]/2+1);;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int thenum = indexPath.row*2;
    NSString * serviceCellidentifier = [NSString stringWithFormat:@"serviceCellidentifier%d",thenum];
    ServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:serviceCellidentifier];
    if (cell == nil) {
        cell = [[[ServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:serviceCellidentifier] autorelease];
    }
    [cell.leftLabel setText:((FacilityServiceData*)[self.queryFacilityService.serviceList objectAtIndex:thenum]).name];
    cell.leftLabel.tag = thenum;
    cell.leftButton.tag = thenum;
    [cell.leftButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    if (!([self.queryFacilityService.serviceList count] % 2 == 1 && [self.queryFacilityService.serviceList count] - thenum == 1))
    {
        cell.rightButton.hidden = NO;
        cell.rightLabel.hidden = NO;
        cell.rightLabel.tag = thenum+1;
        [cell.rightLabel setText:((FacilityServiceData*)[self.queryFacilityService.serviceList objectAtIndex:thenum+1]).name];
        cell.rightButton.tag = thenum+1;
        [cell.rightButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        cell.rightButton.hidden = YES;
        cell.rightLabel.hidden = YES;
    }
    return cell;
}

- (void)dealloc
{
    self.data = nil;
    self.queryFacilityService = nil;
    self.myTable = nil;
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
