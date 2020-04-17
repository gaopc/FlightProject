//
//  MyFlightViewController.m
//  FlightProject
//
//  Created by longcd on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyFlightViewController.h"

@implementation MyFlightCell

@synthesize imageV,titleLabel,detailLabel;
-(void)dealloc
{
    self.imageV = nil;
    self.titleLabel = nil;
    self.detailLabel = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [UIImageView ImageViewWithFrame:CGRectMake(10, 7, 60, 60)];
        [self addSubview:self.imageV];
        
        self.titleLabel = [UILabel labelWithTitle:@"" frame:CGRectMake(75, 9, 225, 20) font: [UIFont boldSystemFontOfSize:18] alignment:UITextAlignmentLeft];
        [self addSubview:self.titleLabel];
        
        self.detailLabel = [UILabel labelWithTitle:@"" frame:CGRectMake(75, 22, 225, 60) font: [UIFont systemFontOfSize:14] alignment:UITextAlignmentLeft];
        [self addSubview:self.detailLabel];
    }
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@interface MyFlightViewController ()

@end

@implementation MyFlightViewController
@synthesize dataArray;
-(void)dealloc
{
    self.dataArray = nil;
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
-(void) bulidDataArray
{
    self.dataArray = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"mem_info.png",@"我的信息",@"选择我的信息，您可以查看您的基本资料，畅达币等信息。",nil],[NSArray arrayWithObjects:@"mem_order.png",@"订单管理",@"选择订单管理，您可以查看订单最新状态，对订单进行操作。",nil],[NSArray arrayWithObjects:@"mem_money.png",@"我的畅达币",@"选择我的畅达币，您可以查看你的畅达币历史信息以及畅达币获取规则。",nil],[NSArray arrayWithObjects:@"mem_activity.png",@"更低票价推送",@"选择更低票价推送，您可以查看更低票价推送的订单列表。",nil],[NSArray arrayWithObjects:@"mem_plan.png",@"机票预约",@"选择机票预约，可以轻松预约您理想的机票。",nil],nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self bulidDataArray];
    UITableView * myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    MyFlightCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[MyFlightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    NSArray * record = [self.dataArray objectAtIndex:indexPath.row];
    cell.imageV.image = [UIImage imageNamed:[record objectAtIndex:0]];
    cell.titleLabel.text = [record objectAtIndex:1];
    cell.detailLabel.text = [record objectAtIndex:2];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
