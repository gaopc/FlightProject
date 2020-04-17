//
//  HotelInformationViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelInformationViewController.h"

@interface HotelInformationViewController ()

@end

@implementation HotelInformationViewController
@synthesize _hotelDetailInfo;

- (void)dealloc
{
    myTable = nil;
    bottomButton = nil;
    self._hotelDetailInfo = nil;
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
	self.title = @"订单详情";
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, ViewWidth, ViewHeight-44-15-50) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
  
    lineView = [UIImageView ImageViewWithFrame:CGRectMake(10, ViewHeight-44-50-5, ViewWidth-20, 5) image:[UIImage imageNamed:@"分割线.png"]];
    bottomButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(92, ViewHeight-44-50+5, 136, 33) backImage:[UIImage imageNamed:@"取消订单.png"] target:self action:@selector(bottomClick:)];
    
    if ([self._hotelDetailInfo.stateCode intValue] != 4) {
        bottomButton.hidden = YES;
        lineView.hidden = YES;
        myTable.frame = CGRectMake(0, 10, ViewWidth, ViewHeight-44-15);
    }
    
    [self.view addSubview:myTable];
    [self.view addSubview:lineView];
    [self.view addSubview:bottomButton];
    [myTable release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



#pragma mark - Table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return [[self._hotelDetailInfo.peopleName componentsSeparatedByString:@"&"] count];
            break;
        case 2:
            return 1;
            break;
//        case 3:
//            return 1;
//            break;
        default:
            return 0;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return 200;
                break;
            case 1:
                return 290;
                break;
                
            default:
                return 0;
                break;
        }
    }
    else if (indexPath.section == 1){
        return 25;
    }
//    else if (indexPath.section == 2){
//        return 45;
//    }
    else {
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = [NSString stringWithFormat:@"identifier%d%d", indexPath.section, indexPath.row];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) 
        {
            MemberHotelCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberHotelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                switch ([self._hotelDetailInfo.stateCode intValue]) {
                    case 0:
                        cell._orderState.text = @"处理中";
                        break;
                    case 1:
                        cell._orderState.text = @"未入住";
                        break;
                    case 2:
                        cell._orderState.text = @"已结账";
                        break;
                    case 3:
                        cell._orderState.text = @"已取消";
                        break;
                    case 4:
                        cell._orderState.text = @"已确认";
                        break;
                        
                    default:
                        cell._orderState.text = @"";
                        break;
                }
                cell._orderNo.text = self._hotelDetailInfo.orderNo;
                cell._scheduleDate.text = self._hotelDetailInfo.scheduleDate;
                //cell._hotelInfo.text = [NSString stringWithFormat:@"%@：%@", self._hotelDetailInfo.hotelName, self._hotelDetailInfo.roomTypeName];
                cell._hotelInfo.text = [NSString stringWithFormat:@"%@：%@ + %@", self._hotelDetailInfo.hotelName, self._hotelDetailInfo.roomTypeName,  self._hotelDetailInfo.breakfast];
                int aLcdCurrency=0;
                int atotalPrice=0;
                (((int)([self._hotelDetailInfo.lcdCurrency floatValue]*100))%100)?(aLcdCurrency = (int)[self._hotelDetailInfo.lcdCurrency floatValue]+1):(aLcdCurrency = (int)[self._hotelDetailInfo.lcdCurrency floatValue]);
                (((int)([self._hotelDetailInfo.totelMoney floatValue]*100))%100)?(atotalPrice = (int)[self._hotelDetailInfo.totelMoney floatValue]+1):(atotalPrice = (int)[self._hotelDetailInfo.totelMoney floatValue]);
                
                
                if ([[UserInfo sharedUserInfo].userID isEqualToString:@""] || aLcdCurrency == 0) {
                    
                    cell._returnLcdView.hidden = YES;
                }
                else {
                    cell._lcdCurrency.text = [NSString stringWithFormat:@"返 %d",aLcdCurrency];
                }
		
                cell._totelMoney.text = [NSString stringWithFormat:@"%d",atotalPrice];
//                cell._lcdCurrency.text = self._hotelDetailInfo.lcdCurrency;
//                cell._totelMoney.text = self._hotelDetailInfo.totelMoney;
                
            }
            return cell;
        }
        else {
            MemberHotelInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                cell = [[[MemberHotelInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell._hotelName.text = self._hotelDetailInfo.hotelName;
                cell._hotelAddress.text = self._hotelDetailInfo.hotelAddress;
                cell._checkInDate.text = self._hotelDetailInfo.checkInDate;
                cell._checkOutDate.text = self._hotelDetailInfo.checkOutDate;
            }
            return cell;
        }
    }
    else if (indexPath.section == 1)
    {
        MemberHotelPeopleInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[MemberHotelPeopleInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        //if (indexPath.row >0) 
        {
            cell._peopleName.text = [[self._hotelDetailInfo.peopleName componentsSeparatedByString:@"&"] objectAtIndex:indexPath.row];
        }
        return cell;
    }
//    else if (indexPath.section == 2)
//    {
//        MemberHotelTelePhoneCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (cell == nil)
//        {
//            cell = [[[MemberHotelTelePhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
////            cell._telNum.text = self.connectorMobile;
//        }
//        return cell;
//    }
    else
    {
        MemberEndCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[MemberEndCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell点击事件");
}

#pragma mark - self click

- (void)bottomClick:(id)sender
{
    [self callTel:@"400-6858-999"];
}
@end
