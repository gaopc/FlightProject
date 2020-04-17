//
//  SelectBankViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectBankViewController.h"
#import "HotelQueryDataResponse.h"
#import "EditCreditCardInfoViewController.h"
#import "SelcetTimeCell.h"
#import "GetBankList.h"
@interface SelectBankViewController ()

@end

@implementation SelectBankViewController
@synthesize myTableView;
@synthesize payType,bankList;
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
    self.myTableView = nil;
    self.bankList = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"选择所属银行";
    
	// Do any additional setup after loading the view.
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, 360, 30) image:[UIImage imageNamed:@"HotelFilterSectionBg.png"]]];
    [self.view addSubview:[UISubLabel labelWithTitle:@"选择所属银行" frame:CGRectMake(60, 3, 200, 20) font:FontSize26 color:FontColorAAAAAA alignment:NSTextAlignmentLeft]];
    UITableView* aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,30.0f,ViewWidth,ViewHeight-44.0f-30.0f) style:UITableViewStylePlain];  
	aTableView.dataSource = self;
	aTableView.delegate = self;
    self.myTableView = aTableView;
	[self.view addSubview:self.myTableView];
    [aTableView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark mark_tableviewdelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bankList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString * firstIdentifier = @"firstIdentifier";
    SelcetTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:firstIdentifier];
    if (cell== nil) {
        cell = [[[SelcetTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstIdentifier] autorelease];
    }
    [cell.timeLabel setText:((BankListInfo*)[bankList objectAtIndex:indexPath.row])._bankName];
    cell.selectImageView.hidden = YES;//未选中
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelcetTimeCell *cell = (SelcetTimeCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectImageView.hidden = NO;//选中
    
    editCreditCardInfoVC.bankInfo = (BankListInfo*)[self.bankList objectAtIndex:indexPath.row];
    editCreditCardInfoVC.ifReloadData = YES;

    [NavigationController popViewControllerAnimated:YES];
}



@end
