//
//  FlightTrendsListViewController.m
//  FlightProject
//
//  Created by longcd on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlightTrendsListViewController.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"

@implementation FlightTrendsListCell
@synthesize flightIcon,flightStatus,arrowImage,flightNum,flightStartCity,flightArrivalCity,flightStartTime,flightArrivalTime;
-(void)dealloc
{
    self.flightIcon = nil;
    self.flightStatus = nil;
    self.arrowImage = nil;
    self.flightNum = nil;
    self.flightStartCity = nil;
    self.flightArrivalCity = nil;
    self.flightStartTime = nil;
    self.flightArrivalTime = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(7.5, 5, ViewWidth - 15, 63) image:[UIImage imageNamed:@"航班动态起降地列表_03.png"]]];
        self.flightIcon = [[AsyncImageView alloc]initWithFrame:CGRectMake(18, 10, 15, 15)];
        self.flightIcon.defaultImage = 1;
        self.flightNum = [UISubLabel labelWithTitle:@"" frame:CGRectMake(38, 9, 150, 15) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.flightStatus = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 100, 16, 72, 31) image:nil];
        self.flightStartCity = [UISubLabel labelWithTitle:@"" frame:CGRectMake(8, 25, 84, 23) font:FontSize28 alignment:NSTextAlignmentCenter];
        self.flightArrivalCity = [UISubLabel labelWithTitle:@"" frame:CGRectMake(133, 25, 84, 23) font:FontSize28 alignment:NSTextAlignmentCenter];
        self.arrowImage = [UIImageView ImageViewWithFrame:CGRectMake(100, 25, 25, 23) image:nil];
        self.flightStartTime = [UISubLabel labelWithTitle:@"06:45" frame:CGRectMake(8, 45, 84, 23) font:FontSize24 color:FontColor454545 alignment:NSTextAlignmentCenter];
        self.flightArrivalTime = [UISubLabel labelWithTitle:@"09:20" frame:CGRectMake(133, 45, 84, 23) font:FontSize24 color:FontColor454545 alignment:NSTextAlignmentCenter];
        [self addSubview:self.flightIcon];
        [self addSubview:self.flightStatus];
        [self addSubview:self.arrowImage];
        [self addSubview:self.flightNum];
        [self addSubview:self.flightStartCity];
        [self addSubview:self.flightArrivalCity];
        [self addSubview:self.flightStartTime];
        [self addSubview:self.flightArrivalTime];
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

@implementation HeaderView
@synthesize flightIcon,flighCompanyName;
- (void)dealloc
{
    self.flightIcon = nil;
    self.flighCompanyName = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame image:(UIImage*)image companyName:(NSString*)companyName
{
    self = [super init];
    if (self) {
        // Custom initialization

        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 2, 320, 27) image:[UIImage imageNamed:@"航班动态起降地列表hederview.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 6, 15, 15) image:image]];
        [self addSubview:[UISubLabel labelWithTitle:companyName frame: CGRectMake(26, 3, 150, 20) font:FontSize18 color:FontColorFFFFFF alignment:NSTextAlignmentLeft]];
    }
    return self;
}
@end

@interface FlightTrendsListViewController ()

@end

@implementation FlightTrendsListViewController
@synthesize myTableView,strImageDic,flightDynamics,flightNo,airCompanyDic,airCompanyKeys,timeOrderBtn,flightOrderBtn,viewStatus;
-(void)dealloc
{
    self.myTableView = nil;
    self.strImageDic = nil;
    self.flightDynamics = nil;
    self.flightNo = nil;
    self.airCompanyDic = nil;
    self.airCompanyKeys = nil;
    self.timeOrderBtn = nil;
    self.flightOrderBtn = nil;
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
    self.title = @"航班动态";

    self.strImageDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"航班动态计划.png",@"航班动态起飞.png",@"航班动态到达.png",@"航班动态取消.png",@"航班动态延误.png",@"航班动态备降.png", nil] forKeys:[NSArray arrayWithObjects:@"计划", @"起飞",@"到达",@"取消",@"延误",@"备降",nil]];

    self.timeOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, ViewWidth/2, 35) backImage:[UIImage imageNamed:@"航班动态排序2.png"] target:self action:@selector(setListOrder:)];
    self.flightOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(ViewWidth/2, 0, ViewWidth/2, 35) backImage:[UIImage imageNamed:@"航班动态排序02.png"] target:self action:@selector(setListOrder:)];
    [self.view addSubview:self.timeOrderBtn];
    [self.view addSubview:self.flightOrderBtn];
    viewStatus = 1;
    
	// Do any additional setup after loading the view.
    self.flightDynamics.flightDynamicAry = [self.flightDynamics.flightDynamicAry sortedArrayUsingFunction:sortArrayByStartTimeAsc context:NULL];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    self.airCompanyDic = dic2;
    [dic2 release];
    
    UITableView *aTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 34, ViewWidth, ViewHeight-44-34) style:UITableViewStylePlain];
    self.myTableView = aTable;
    [aTable release];
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
}
-(void)setListOrder:(UIButton*)sender
{
    [self.myTableView setContentOffset:CGPointMake(0, 0)];
    if(sender.tag == 0)
    {
        [self.airCompanyDic removeAllObjects];
        if(self.viewStatus == 1)
        {
            self.viewStatus = 2;//降序
            [self.timeOrderBtn setBackgroundImage:[UIImage imageNamed:@"航班动态排序1.png"] forState:UIControlStateNormal];
            self.flightDynamics.flightDynamicAry = [self.flightDynamics.flightDynamicAry sortedArrayUsingFunction:sortArrayByStartTimeDes context:NULL];
        }
        else 
        {
            self.viewStatus = 1;//升序
            [self.timeOrderBtn setBackgroundImage:[UIImage imageNamed:@"航班动态排序2.png"] forState:UIControlStateNormal];
            [self.flightOrderBtn setBackgroundImage:[UIImage imageNamed:@"航班动态排序02.png"] forState:UIControlStateNormal];
            self.flightDynamics.flightDynamicAry = [self.flightDynamics.flightDynamicAry sortedArrayUsingFunction:sortArrayByStartTimeAsc context:NULL];
        }
        [self.myTableView reloadData];
    }
    else
    {
        if(self.viewStatus == 3)
        {
            self.viewStatus = 4;//降序
            [self initAirCompanyDic];
            [self.flightOrderBtn setBackgroundImage:[UIImage imageNamed:@"航班动态排序3.png"] forState:UIControlStateNormal];
        }
        else 
        {
            self.viewStatus = 3;//升序
            [self initAirCompanyDic];
            [self.flightOrderBtn setBackgroundImage:[UIImage imageNamed:@"航班动态排序4.png"] forState:UIControlStateNormal];
            [self.timeOrderBtn setBackgroundImage:[UIImage imageNamed:@"航班动态排序01.png"] forState:UIControlStateNormal];
        };
        
        [self.myTableView reloadData];
    }
}
static NSInteger sortArrayByStartTimeAsc(id item1, id item2, void *context){//升序
    FlightDynamic3 *info1 = item1;
	FlightDynamic3 *info2 = item2;
	int v1 = [[info1.takeOffTime.plan stringByReplacingOccurrencesOfString:@":" withString:@""] intValue];
	int v2 = [[info2.takeOffTime.plan stringByReplacingOccurrencesOfString:@":" withString:@""] intValue];
	if (v1 < v2)
        return NSOrderedAscending;//升序
    else if (v1 > v2)
        return NSOrderedDescending;//降序
    else
        return NSOrderedSame;
}

static NSInteger sortArrayByStartTimeDes(id item1, id item2, void *context){//降序
    FlightDynamic3 *info1 = item1;
	FlightDynamic3 *info2 = item2;
	int v1 = [[info1.takeOffTime.plan stringByReplacingOccurrencesOfString:@":" withString:@""] intValue];
	int v2 = [[info2.takeOffTime.plan stringByReplacingOccurrencesOfString:@":" withString:@""] intValue];
	
	if (v1 < v2)
        return NSOrderedDescending;
    else if (v1 > v2)
        return NSOrderedAscending;
    else
        return NSOrderedSame;
}
-(void)initAirCompanyDic{
	[self.airCompanyDic removeAllObjects];
	if(self.flightDynamics.flightDynamicAry == nil){
		return;
	}

	//init airCompanyKeys
    NSMutableArray *dks = [[NSMutableArray alloc] init];
	for (int i = 0; i < [self.flightDynamics.flightDynamicAry count]; i ++)
    {
        BOOL isExist = NO;
		id aResult = [self.flightDynamics.flightDynamicAry objectAtIndex: i];
		if ([aResult isKindOfClass: [FlightDynamic3 class]]){
			FlightDynamic3 *info = aResult;
            for(int j = 0;j<[dks count];j++)
            {
                if([[dks objectAtIndex:j] isEqualToString:info.flightCompang])
                {
                    isExist = YES;
                    break;
                }
            }
            if(!isExist)
            {
                NSLog(@"===%@===",info.flightCompang);
                [dks addObject:info.flightCompang];
            }
		}
	}
    
    
    //SetCodeOrder以下注掉内容功能为，得到的航空公司信息里不在本地航空公司文件中，去掉不显示
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"国内航空公司" ofType:@"json"];
//    NSString *str = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    NSArray *array = [str JSONValue];
//    [str release];
//    NSMutableDictionary *aDic = [[NSMutableDictionary alloc] init];
//    for (int e=0;e<[array count];e++) 
//    {
//        [aDic setObject:[[array objectAtIndex:e]objectForKey:@"name"] forKey:[NSString stringWithFormat:@"%d",e]];
//    }
//    
//    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"国际航空公司" ofType:@"json"];
//    NSString *str2 = [[NSString alloc] initWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
//    NSArray *array2 = [str2 JSONValue];
//    [str2 release];
//    for (int e=0;e<[array2 count];e++)
//    {
//        [aDic setObject:[[array2 objectAtIndex:e]objectForKey:@"name"] forKey:[NSString stringWithFormat:@"%d",e]];
//    }
//    
//    NSMutableArray *deleteCodeAry = [NSMutableArray array];
//    for(int k=0;k<[aDic count];k++)
//    {
//        for (int i = 0; i < [dks count]; i ++)
//        {
//            if([[dks objectAtIndex:i] isEqualToString:[aDic objectForKey:[NSString stringWithFormat:@"%d",k]]])
//            {
//                [deleteCodeAry addObject:[dks objectAtIndex:i]];
//                break;
//            }
//        }
//    }
//     [aDic release];
//    [dks removeAllObjects];
//    for(id elem in deleteCodeAry) 
//    {
//        [dks addObject:elem];
//    }
    
    
	// init airCompanyDic
	for (NSString *sectionName in dks){
		NSMutableArray *dvs = [[NSMutableArray alloc] init];
		for (int i = 0; i < [self.flightDynamics.flightDynamicAry count]; i ++)
        {
			id aResult = [self.flightDynamics.flightDynamicAry objectAtIndex: i];
			if ([aResult isKindOfClass: [FlightDynamic3 class]])
            {
				FlightDynamic3 *info = aResult;
				if ([info.flightCompang isEqualToString:sectionName])
                {
					[dvs addObject:info];
				}
			}
		}
		[self.airCompanyDic setObject:dvs forKey:sectionName];
		[dvs release];
	}
	self.airCompanyKeys = dks;//[self.airCompanyDic allKeys];
    [dks release];
    if(self.viewStatus == 4)
    {
        NSMutableArray *orderArray = [[NSMutableArray alloc] init];
        for (int k=[self.airCompanyKeys count]-1; k >= 0 ; k--) {
            id obj = [self.airCompanyKeys objectAtIndex:k];
            [orderArray addObject:obj];
        }
        self.airCompanyKeys = orderArray;
        [orderArray release];
    }
}

-(NSArray*)setCompanyOrder:(NSArray*)_keys
{
    NSArray *array = [NSArray array];
    NSMutableArray *topArray = [NSMutableArray array];
    for(NSString* elem in _keys)
    {
        if([elem isEqualToString:@"CZ"])
        {
            [topArray addObject:elem];
        }
    }
    return array;
}
#pragma mark tableviewdelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView{
    if(self.viewStatus ==1 || self.viewStatus ==2 || [self.airCompanyDic count] <= 0)
    {
        return 1;
    }
    else 
    {
        return [self.airCompanyKeys count];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if(self.viewStatus ==1 || self.viewStatus ==2 || [self.airCompanyDic count] <= 0)
    {
        return 0;
    }
    else 
    {
        return 27;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *key = [self.airCompanyKeys objectAtIndex:section];
    NSArray *nameSection = [self.airCompanyDic objectForKey:key];
    FlightDynamic3* flightDynamic = [nameSection objectAtIndex: 0];
    NSString *imageName = [NSString stringWithFormat:@"%@.png",[flightDynamic.flightNo substringToIndex:2]];

    UIView *headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 50) image:[UIImage imageNamed:imageName] companyName:key];
    return [headerView autorelease];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.flightDynamics.flightDynamicAry == nil){
		return 0;
    }else{
		if(self.viewStatus ==1 || self.viewStatus ==2 || [self.airCompanyDic count] <= 0){
            return [self.flightDynamics.flightDynamicAry count];

		}else{
            NSString *key = [self.airCompanyKeys objectAtIndex:section];
			NSArray *nameSection = [self.airCompanyDic objectForKey:key];
			return [nameSection count];
		}
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"idertifier";
    FlightTrendsListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[FlightTrendsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    if(self.viewStatus ==1 || self.viewStatus ==2 || [self.airCompanyDic count] <= 0)
    {
        FlightDynamic3 * flightDynamic = [self.flightDynamics.flightDynamicAry objectAtIndex:indexPath.row];
 
        [cell.flightIcon setUrlString:flightDynamic.flightLogo];
        cell.flightStartCity.text = flightDynamic.departure;
        cell.flightArrivalCity.text = flightDynamic.arrival;
        cell.flightNum.text = [flightDynamic.flightCompang stringByAppendingFormat:@"%@",flightDynamic.flightNo];
        cell.flightStartTime.text = flightDynamic.takeOffTime.plan;
        cell.flightArrivalTime.text = flightDynamic.reachTime.plan;
        cell.flightStatus.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.strImageDic objectForKey:flightDynamic.statusName]]];
        if([flightDynamic.statusName isEqualToString:@"到达"] || [flightDynamic.statusName isEqualToString:@"起飞"] || [flightDynamic.statusName isEqualToString:@"备降"])
        {
            cell.arrowImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"航班动态我的关注箭头.png"]];
        }
        else {
            cell.arrowImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"航班动态我的关注箭头02.png"]];
        }
        if([flightDynamic.statusName isEqualToString:@"到达"] || [flightDynamic.statusName isEqualToString:@"起飞"] || [flightDynamic.statusName isEqualToString:@"备降"])
        {
            [cell.flightStartCity setTextColor:FontColor0066CC];
        }
        else{
            [cell.flightStartCity setTextColor:FontColor707070];
        }
        if([flightDynamic.statusName isEqualToString:@"到达"])
        {
            [cell.flightArrivalCity setTextColor:FontColor0066CC];
        }
        else{
            [cell.flightArrivalCity setTextColor:FontColor707070];
        }
    }
    else
    {
        NSUInteger section = [indexPath section];
        NSString *key = [self.airCompanyKeys objectAtIndex:section];
        NSArray *nameSection = [self.airCompanyDic objectForKey:key];
        id aResult = [nameSection objectAtIndex: indexPath.row];
        if ([aResult isKindOfClass: [FlightDynamic3 class]])
        {
            FlightDynamic3 * flightDynamic = aResult;
            [cell.flightIcon setUrlString:flightDynamic.flightLogo];
            cell.flightStartCity.text = flightDynamic.departure;
            cell.flightArrivalCity.text = flightDynamic.arrival;
            cell.flightNum.text = [flightDynamic.flightCompang stringByAppendingFormat:@"%@",flightDynamic.flightNo]; 
            cell.flightStartTime.text = flightDynamic.takeOffTime.plan;
            cell.flightArrivalTime.text = flightDynamic.reachTime.plan;
            cell.flightStatus.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.strImageDic objectForKey:flightDynamic.statusName]]];
            if([flightDynamic.statusName isEqualToString:@"到达"] || [flightDynamic.statusName isEqualToString:@"起飞"] || [flightDynamic.statusName isEqualToString:@"备降"])
            {
                cell.arrowImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"航班动态我的关注箭头.png"]];
            }
            else {
                cell.arrowImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"航班动态我的关注箭头02.png"]];
            }
            if([flightDynamic.statusName isEqualToString:@"到达"] || [flightDynamic.statusName isEqualToString:@"起飞"] || [flightDynamic.statusName isEqualToString:@"备降"])
            {
                [cell.flightStartCity setTextColor:FontColor0066CC];
            }
            else{
                [cell.flightStartCity setTextColor:FontColor333333];
            }
            if([flightDynamic.statusName isEqualToString:@"到达"])
            {
                [cell.flightArrivalCity setTextColor:FontColor0066CC];
            }
            else{
                [cell.flightArrivalCity setTextColor:FontColor333333];
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 4, 300, 70)];
    if(self.viewStatus ==1 || self.viewStatus ==2 || [self.airCompanyDic count] <= 0)
    {
        FlightDynamic3 * flightDynamic = [self.flightDynamics.flightDynamicAry objectAtIndex:indexPath.row];
        self.flightNo = flightDynamic.flightNo;
    }
    else
    {
		NSUInteger section = [indexPath section];
		NSString *key = [self.airCompanyKeys objectAtIndex:section];
		NSArray *nameSection = [self.airCompanyDic objectForKey:key];
		FlightDynamic3 *aResult = [nameSection objectAtIndex:indexPath.row];
        self.flightNo = aResult.flightNo;
	}

    NSLog(@"查询航班号：%@",self.flightNo);
    ASIFormDataRequest * theRequest = [InterfaceClass getFlightDynamicByFlightNoWithUserId:[UserInfo sharedUserInfo].userID?[UserInfo sharedUserInfo].userID:@"" flightNo:self.flightNo];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onNumPaseredResult:) Delegate:self needUserType:Default];
}
-(void)onNumPaseredResult:(NSDictionary *)dic
{
    if (dic)
    {
        FlightTrendsDetailViewController * flightTrendsDetailVC = [[FlightTrendsDetailViewController alloc] init];
        flightTrendsDetailVC.flightDynamic = (GetFlightDynamicByFlightNo*)[GetFlightDynamicByFlightNo GetFlightDynamicByFlightNo:dic];
        flightTrendsDetailVC.flightNum = self.flightNo;
        [NavigationController pushViewController:flightTrendsDetailVC animated:YES];
        [flightTrendsDetailVC release];
    }  
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
