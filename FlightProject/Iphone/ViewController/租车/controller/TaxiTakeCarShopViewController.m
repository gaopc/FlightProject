//
//  TaxiTakeCarShopViewController.m
//  FlightProject
//
//  Created by longcd mac mini 04 on 12-10-22.
//
//

#import "TaxiTakeCarShopViewController.h"
#import "InterfaceClass.h"
#import "CarShopCell.h"

@interface TaxiTakeCarShopViewController ()

@end


@implementation TaxiTakeCarShopViewController
@synthesize carStoreArray;
@synthesize delegate;
@synthesize selectAddressIndexPath;
-(void)dealloc
{
    self.carStoreArray = nil;    
    self.delegate = nil;
    self.selectAddressIndexPath = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewLift

-(void)viewDidLoad
{
    [super viewDidLoad];
    selectSection =0;
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10.0f, ViewWidth, ViewHeight-44.0f) style:UITableViewStylePlain] ;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myTableView];
    [myTableView release];
}

#pragma mark -
#pragma mark UITableViewDataSourceDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 7)];
    [view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10.0f, -5.0f, ViewWidth-20, 7.0f) image:[UIImage imageNamed:@"carStoreAddressNameShadow.png"]]];
    return [view autorelease];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.carStoreArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isExtendSectionTitle && (selectSection == section) ) {
        CarStore *carStore = [self.carStoreArray objectAtIndex:section];
        return [carStore._shops count] + 1;
    }
    else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 44;
    }
    else if ( isExtendAddress && [self.selectAddressIndexPath compare:indexPath] == NSOrderedSame ) {
        CarStore * carShop = [self.carStoreArray objectAtIndex:indexPath.section];
        Shops * shop = [carShop._shops objectAtIndex:indexPath.row - 1];
        NSString * str = shop._shopAddress;
        CGSize size = [str sizeWithFont:FontSize24 constrainedToSize:CGSizeMake(ViewWidth - 50, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        return 55 + size.height + 10;
    }
    return 55.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarStore * carShop = [self.carStoreArray objectAtIndex:indexPath.section];
    if (indexPath.row == 0) {
        NSString * carShopTitleCellIdentifier = [NSString stringWithFormat:@"Identifier%d", indexPath.section];
        CarShopTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:carShopTitleCellIdentifier ];
        if (cell == nil) {
            cell = [[[CarShopTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carShopTitleCellIdentifier] autorelease];
        }
        if (selectSection == indexPath.section) {
            if (isExtendSectionTitle) {
                cell._imageV.image = [UIImage imageNamed:@"HeaderInSection_B.png"];
            }
            else {
                cell._imageV.image = [UIImage imageNamed:@"HeaderInSection_A.png"];
            }
        }
        else {
            cell._imageV.image = [UIImage imageNamed:@"HeaderInSection_A.png"];
        }
        cell._shopTitle.text = carShop._areaName;
        return cell;
    }
    else {
        static NSString * carShopNameCellIdentifier = @"carShopNameCellIdentifier";
        CarShopNameCell * cell = [tableView dequeueReusableCellWithIdentifier:carShopNameCellIdentifier];
        if (cell == nil) {
            cell = [[[CarShopNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carShopNameCellIdentifier] autorelease];
            [cell._shopAddressButton addTarget:self action:@selector(addressDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell._shopAddressButton.tag = [[NSString stringWithFormat:@"%d%d",(ButtonSection + indexPath.section),indexPath.row] intValue];
        Shops * shop = [carShop._shops objectAtIndex:indexPath.row - 1];
        cell._shopName.text = shop._shopName;
        cell._shopOpenTime.text = [NSString stringWithFormat:@"%@ -- %@",shop._startOpeningHours,shop._endOpeningHours];
        NSString * str = shop._shopAddress;
        CGSize size = [str sizeWithFont:FontSize24 constrainedToSize:CGSizeMake(270, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        CGRect labelRect = cell._shopAddressDetail.frame;
        labelRect.size.height = size.height+10;
        cell._shopAddressDetail.frame = labelRect;
        cell._shopAddressDetail.text = shop._shopAddress;
        if ( isExtendAddress && [self.selectAddressIndexPath compare:indexPath] == NSOrderedSame ) 
        {
             cell._shopAddressDetail.hidden = NO;
            CGRect backVrect = cell._backgroundV.frame;
            backVrect.size.height = 55 +size.height +10;
            cell._backgroundV.frame = backVrect;
        }
        else {
            cell._shopAddressDetail.hidden = YES;
            cell._backgroundV.frame = CGRectMake(10, 0, 300, 55);
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        isExtendAddress = NO;
        if (selectSection == indexPath.section) {
            isExtendSectionTitle = !isExtendSectionTitle;
        }
        else {
            isExtendSectionTitle = YES;
        }
        selectSection = indexPath.section;
        [myTableView reloadData];
//        [myTableView reloadSections:[NSIndexSet indexSetWithIndex:selectSection] withRowAnimation:UITableViewRowAnimationFade];
    }
    else {
        CarStore *carStore = [self.carStoreArray objectAtIndex:indexPath.section];
        Shops *shops = [carStore._shops objectAtIndex:indexPath.row - 1];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedStoreFinshed:)]) {
            [self.delegate performSelector:@selector(didSelectedStoreFinshed:) withObject:shops];
        }
        [NavigationController popViewControllerAnimated:YES];
    }
}

-(void)addressDetail:(UIButton *)sender
{

    NSString * selectRow = [NSString stringWithFormat:@"%d",sender.tag];
    NSInteger section = [[selectRow substringToIndex:3] intValue] - ButtonSection;
    NSInteger row = [[selectRow substringFromIndex:3] intValue];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    
    if ([indexPath compare:self.selectAddressIndexPath] == NSOrderedSame) {
        isExtendAddress = !isExtendAddress;
    }
    else {
        isExtendAddress = YES;
    }
    self.selectAddressIndexPath = indexPath;
     
    [myTableView reloadData];
    
   // [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:selectAddressIndexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark -
#pragma mark UITableViewDelegate

#pragma mark -
#pragma mark UIScrollView



#pragma mark -
#pragma mark LoadData


#pragma mark - 
#pragma mark IBAction

#pragma mark -
#pragma mark 自定方法
//求字体size
//-(CGSize)sizeForFont:(NSString *)str with:(UIFont *)font 
//{
//    CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(SIZEWIDTH, SIZEHEIGHT) lineBreakMode:UILineBreakModeWordWrap];
//    return size;
//}

-(void)viewDidUnload
{
    [super viewDidUnload];
}

@end










