//
//  SelectRetentionTimeViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectRetentionTimeViewController.h"
#import "SelcetTimeCell.h"
#import "HotelOrdersViewController.h"
@interface SelectRetentionTimeViewController ()

@end

@implementation SelectRetentionTimeViewController
@synthesize timeArray,myTableView,selectTimeRow,checkIsNowDate,selectNowTimeRow;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.timeArray = nil;
    self.myTableView = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"选择房间保留时间";
	// Do any additional setup after loading the view.
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, 360, 30) image:[UIImage imageNamed:@"HotelFilterSectionBg.png"]]];
    [self.view addSubview:[UISubLabel labelWithTitle:@"选择房间保留时间" frame:CGRectMake(60, 3, 200, 20) font:FontSize26 color:FontColorAAAAAA alignment:NSTextAlignmentLeft]];

    UITableView* aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,30.0f,ViewWidth,ViewHeight-44.0f-30.0f) style:UITableViewStylePlain];  
	aTableView.dataSource = self;
	aTableView.delegate = self;
    self.myTableView = aTableView;
	[self.view addSubview:self.myTableView];
    [aTableView release];
    self.myTableView.contentOffset = CGPointMake(0, selectNowTimeRow * 44) ;
}

#pragma mark mark_tableviewdelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.timeArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * firstIdentifier = @"firstIdentifier";
    SelcetTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:firstIdentifier];
    if (cell== nil) {
        cell = [[[SelcetTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstIdentifier] autorelease];
    }
    [cell.timeLabel setText:[timeArray objectAtIndex:indexPath.row]];
    if(indexPath.row == selectNowTimeRow)
    {
        cell.selectImageView.hidden = NO;//选中
        
    }
    else
    {
        cell.selectImageView.hidden = YES;//未选中
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.selectTimeRow && self.checkIsNowDate)
    {
        [UIAlertView alertViewWithMessage:@"房间保留时间已过，请您重新选择房间保留时间" :@"提示"];
    }
    else
    {
        SelcetTimeCell *cell = (SelcetTimeCell*)[tableView cellForRowAtIndexPath:indexPath];
        cell.selectImageView.hidden = NO;//选中
        hotelOrdersViewController.retentionTime = [timeArray objectAtIndex:indexPath.row];
        hotelOrdersViewController.selectNowTimeRow = indexPath.row;
        [NavigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
