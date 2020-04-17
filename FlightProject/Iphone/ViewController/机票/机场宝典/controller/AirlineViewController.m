//
//  AirlineViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AirlineViewController.h"
#import "DataClass.h"
#import "JSON.h"

@implementation AirlineCell
@synthesize iconImageView,dottedLine,name,tel,callPhone,delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(7, 0, ViewWidth - 14, 46) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        self.dottedLine = [UIImageView ImageViewWithFrame:CGRectMake(19, 45, ViewWidth - 38, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]];
        [self addSubview:self.dottedLine];
        self.iconImageView = [UIImageView ImageViewWithFrame:CGRectMake(20, 10, 27, 27) image:[UIImage imageNamed:@"MU.png"]];
        self.name = [UISubLabel labelWithTitle:@"" frame:CGRectMake(50, 10, 100, 30) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.tel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth - 182, 10, 120, 30) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentRight];
        self.callPhone = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth - 50, 10, 27, 27) backImage:[UIImage imageNamed:@"AKVC-3.png"] target:self action:@selector(callTel:)];
        [self addSubview:self.iconImageView];
        [self addSubview:self.name];
        [self addSubview:self.tel];
        [self addSubview:self.callPhone];
        
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];

    return self;
}
-(void)callMyTel:(NSString *)tel{}
-(void)callTel:(UIButton*)sender
{
    NSLog(@"打电话");
    if (self.delegate && [self.delegate respondsToSelector:@selector(callMyTel:)]) {
        [self.delegate performSelector:@selector(callMyTel:) withObject:sender];
    }
}
- (void)dealloc
{
    self.iconImageView = nil;
    self.dottedLine = nil;
    self.name = nil;
    self.tel = nil;
    self.callPhone = nil;
    delegate = nil;
    [super dealloc];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end

@interface AirlineViewController ()

@end

@implementation AirlineViewController
@synthesize alinesArray;
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
    self.title = @"航空公司";
    [self gettFlightCompanys];
	// Do any additional setup after loading the view.
   
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(7, 7, ViewWidth - 14, ViewHeight-44-22) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(7, ViewHeight-44-22+7-1,306, 10) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
    [self.view addSubview:[UISubLabel labelWithTitle:@"航空公司" frame:CGRectMake(30, 12, 50, 15) font:FontSize20 color:FontColorA0A0A0 alignment:NSTextAlignmentLeft]];
    [self.view addSubview:[UISubLabel labelWithTitle:@"电话" frame:CGRectMake(ViewWidth - 70, 12, 30, 15) font:FontSize20 color:FontColorA0A0A0 alignment:NSTextAlignmentLeft]];
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(17, 27, ViewWidth - 34, 0.5) image:[UIImage imageNamed:@"fengexian.png"]]];
    
    
    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 32, ViewWidth, ViewHeight-44-47) style:UITableViewStylePlain];
    aTableView.backgroundColor = [UIColor clearColor];
    aTableView.dataSource = self;
    aTableView.delegate = self;
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    aTableView.allowsSelection = NO;
    [self.view addSubview:aTableView];
    [aTableView release];
}

- (NSString*)infoWithIndex:(int)index
{
    NSString* companyText=@"";
    if (index<[self.alinesArray count])
    {
        NSString* name = [[self.alinesArray objectAtIndex:index] objectForKey:@"name"];
        NSString* number = [[self.alinesArray objectAtIndex:index] objectForKey:@"code"];
        companyText = [name stringByAppendingString:number];
    }
    return companyText;
}
-(void)gettFlightCompanys
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"国内航空公司" ofType:@"json"];
    NSString *str = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [str JSONValue];
    [str release];
    NSMutableArray *aArray = [[NSMutableArray alloc] init];
    for (id elem in array) 
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[elem objectForKey:@"code"] forKey:@"code"];
        [dic setObject:[elem objectForKey:@"name"] forKey:@"name"];
        [dic setObject:[elem objectForKey:@"telPhone"] forKey:@"telPhone"];
        [aArray addObject:dic];
        [dic release];
    }
    [aArray removeObjectAtIndex:7];//机场宝典中不加春秋航空
    self.alinesArray = aArray;
    [aArray release];
}

- (void)dealloc
{
    self.alinesArray = nil;
    [super dealloc];
}

-(void)callMyTel:(UIButton*)sender
{
    [self callTel:[(NSDictionary*)[self.alinesArray objectAtIndex:sender.tag] objectForKey:@"telPhone"]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.alinesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * selectAirportidentifier = @"selectAirportidentifier";
    AirlineCell * cell = [tableView dequeueReusableCellWithIdentifier:selectAirportidentifier];
    if (cell == nil) {
        cell = [[[AirlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectAirportidentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;  
    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[(NSDictionary*)[self.alinesArray objectAtIndex:indexPath.row] objectForKey:@"code"]]];
    cell.name.text = [(NSDictionary*)[self.alinesArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.tel.text = [(NSDictionary*)[self.alinesArray objectAtIndex:indexPath.row] objectForKey:@"telPhone"];
    cell.callPhone.tag = indexPath.row;
    cell.delegate = self;
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



@end
