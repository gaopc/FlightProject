//
//  HotelOrdersViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelOrdersViewController.h"
#import "FirstSectionFirstStyleCell.h"
#import "FirstSectionSecondStyleCell.h"
#import "SetRoomCountSectionCell.h"
#import "AddPersonnelToListSectionCell.h"
#import "NOCheckPersonCell.h"
#import "CheckPersonCell.h"
#import "CheckPersonContactCell.h"
#import "RetentionTimeCell.h"
#import "SelectRetentionTimeViewController.h"
#import "InterfaceClass.h"
#import "HotelDetailViewController.h"
#import "HotelGuaranteeViewController.h"
#import "PersonnelListViewController.h"
#import "HotelPassengerDataResponse.h"
#import "EditPersonnelViewController.h"
#import "MyRegex.h"
#import "AsyncImageView.h"
#import "HotelQueryCreditCard.h"
@interface HotelOrdersViewController ()

@end

@implementation HotelOrdersViewController
@synthesize myTableView,retentionTime,hotelInfo,hotelRoomType,checkInDate,checkOutDate,keyboardbar,contactNum,timeArray,selectTimeRow,selectNowTimeRow,checkIsNowDate,nowRomeCount;
@synthesize fisrtStyle,passInfoArray,checkCity,lcdValue,lcdRate,lcdActivityId;
@synthesize hasPerson;
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
    self.retentionTime = nil;
    self.hotelInfo = nil;
    self.hotelRoomType = nil;
    self.checkOutDate = nil;
    self.checkInDate = nil;
    self.keyboardbar = nil;
    self.contactNum = nil;
    self.passInfoArray = nil;
    self.checkCity = nil;
    self.timeArray = nil;
    self.lcdRate = nil;
    self.lcdValue = nil;
    self.lcdActivityId = nil;
    [super dealloc];
}
- (void)loadView{
	[super loadView];
    self.title = @"订单填写";
    self.fisrtStyle = YES;
    self.hasPerson = NO;
    roomCount = 1;
    insertSectionNum = 0;
    
    self.timeArray = [NSArray arrayWithObjects:@"06:00-09:00",@"07:00-10:00",@"08:00-11:00",@"09:00-12:00",@"10:00-13:00",@"11:00-14:00",@"12:00-15:00",@"13:00-16:00",@"14:00-17:00",@"15:00-18:00", @"16:00-19:00",@"17:00-20:00",@"18:00-21:00",@"19:00-22:00",@"20:00-23:00",@"21:00-23:59",@"22:00-次日1:00",@"23:00-次日2:00",@"次日0:00-次日3:00",@"次日1:00-次日4:00",@"次日2:00-次日5:00",@"次日3:00-次日6:00",nil];
    [self getMyRetentionTime];
    
    UITableView *aTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,ViewHeight-44.0f-48.f) style:UITableViewStylePlain];
    self.myTableView = aTable;
    [aTable release];
	self.myTableView.backgroundColor = [UIColor clearColor];
	self.myTableView.dataSource = self;
	self.myTableView.delegate = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:self.myTableView];
    
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight-44-49, ViewWidth, 5) image:[UIImage imageNamed:@"航班动态航班号查询结果-改_10.png"]]];
    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(72.5, ViewHeight-44-50+10, 175, 38) backImage:[UIImage imageNamed:@"OrderInfoNextStep.png"] target:self action:@selector(Next)]];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.passInfoArray = [NSMutableArray array];
}

-(void)getMyRetentionTime
{
    NSDate *nowDate=[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSArray *array = [[formatter stringFromDate:nowDate] componentsSeparatedByString:@" "];
    [formatter release];
    NSString *date = [array objectAtIndex:0];
    NSString *time = [array objectAtIndex:1];
    if([self.checkInDate isEqualToString:date])
    {
        NSArray *array2 = [time componentsSeparatedByString:@":"];
        int timeNum = [[array2 objectAtIndex:0] intValue];
        if([[array2 objectAtIndex:1] isEqualToString:@"00"])
        {
            timeNum = timeNum+1;
        }
        else
        {
            timeNum = timeNum+2;
        }
        self.retentionTime = [self.timeArray objectAtIndex:timeNum-6];
        self.selectTimeRow = timeNum-6;
        self.checkIsNowDate = YES;
        selectNowTimeRow = selectTimeRow;
    }
    else
    {
        self.retentionTime = @"14:00-17:00";
        self.selectTimeRow = 8;
        self.checkIsNowDate = NO;
        selectNowTimeRow = selectTimeRow;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(insertSectionNum == 5)
    {
        [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    if(insertSectionNum == 3)
    {
        [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
    }
    insertSectionNum = 0;
}

-(void)drawerClick:(UIButton*)sender
{
    NSLog(@"drawerClick");
    self.fisrtStyle = !self.fisrtStyle;
    [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)setRomesCount:(UIButton*)sender
{
    NSLog(@"setRomesCount");
    if(sender.tag == 0)
    {
        if(roomCount == 1)
            return;
        roomCount--;
    }
    else {
        if(roomCount == (nowRomeCount > 5?5:nowRomeCount))
            return;
        roomCount++;
    }
    [self.myTableView reloadData];
}
-(void)addHotelPersonOverWithPersonItem:(HotelPersonnelInfo *)infoItem // zxt 20121029 添加实现非会员预订添加入住人的代理
{
    [self.passInfoArray addObject:infoItem];
    [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:insertSectionNum] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)addPerson:(UIButton*)sender
{
    NSLog(@"addPerson");
	
    insertSectionNum = 3;
    
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
        EditPersonnelViewController * editPassegersInfoVC = [[EditPersonnelViewController alloc] init];
        editPassegersInfoVC.delegate = self;
        [NavigationController pushViewController:editPassegersInfoVC animated:YES];
        [editPassegersInfoVC release];
    }
    else {
        PersonnelListViewController * passengersVC = [[PersonnelListViewController alloc] init];
        passengersVC->memberVC = self;
        passengersVC.surplusRoom = roomCount;
        [NavigationController pushViewController:passengersVC animated:YES];
        [passengersVC release];
    }
	
}

-(void)selectRetentionTime:(UIButton*)sender
{
    NSLog(@"selectRetentionTime");
    insertSectionNum = 5;
    SelectRetentionTimeViewController *selectRetentionTimeVC = [[SelectRetentionTimeViewController alloc] init];
    selectRetentionTimeVC.timeArray = self.timeArray;
    selectRetentionTimeVC.selectTimeRow = self.selectTimeRow;
    selectRetentionTimeVC.checkIsNowDate = self.checkIsNowDate;
    selectRetentionTimeVC.selectNowTimeRow = self.selectNowTimeRow;
    selectRetentionTimeVC->hotelOrdersViewController = self;
    [NavigationController pushViewController:selectRetentionTimeVC animated:YES];
    [selectRetentionTimeVC release];
}

-(void)Next
{
    NSLog(@"Next");
    
    if([self.passInfoArray count] != roomCount)
    {
        [UIAlertView alertViewWithMessage:@"入住人数量必须和房间数一致，请重新输入" :@"提示"];
        return;
    }
    if(self.contactNum.length < 11 )
    {
        [UIAlertView alertViewWithMessage:@"请输入11位手机号码" :@"提示"];
        return;
    }
    if (![self.contactNum isMatchedByRegex:PHONENO]) 
    {
		[UIAlertView alertViewWithMessage:@"请输入正确的手机号!" :@"提示"];
        return;
    }
    
    HotelQueryCreditCard *hotelQueryCreditCard = [[HotelQueryCreditCard alloc] init];
    hotelQueryCreditCard.hotelId = self.hotelInfo._hotelId;
    hotelQueryCreditCard.roomTypeId = self.hotelRoomType._roomTypeId;
    hotelQueryCreditCard.checkInDate = self.checkInDate;
    hotelQueryCreditCard.checkOutDate = self.checkOutDate;
    hotelQueryCreditCard.arrivePeriod = self.retentionTime;
    hotelQueryCreditCard.count = [NSString stringWithFormat:@"%d",roomCount];
    hotelQueryCreditCard.rotalPrice = [NSString stringWithFormat:@"%.2f",self.hotelRoomType._totalPrice];
    hotelQueryCreditCard.totalLcdFee = self.hotelRoomType._totalLcdFee;
    hotelQueryCreditCard.minCheckinRooms = [NSString stringWithFormat:@"%d",self.hotelRoomType._minCheckinRooms];
    hotelQueryCreditCard.firstDayPrice = [NSString stringWithFormat:@"%.2f",self.hotelRoomType._firstDayPrice];
    (self.hotelRoomType._isArriveTimeVouch)?(hotelQueryCreditCard.isArriveTimeVouch = @"true"):(hotelQueryCreditCard.isArriveTimeVouch = @"false");
    hotelQueryCreditCard.isRoomCountVouch = self.hotelRoomType._isRoomCountVouch;
    hotelQueryCreditCard.arriveEndTime = self.hotelRoomType._arriveEndTime;
    hotelQueryCreditCard.arriveStartTime = self.hotelRoomType._arriveStartTime;
    hotelQueryCreditCard.roomCount = self.hotelRoomType._roomCount;
    hotelQueryCreditCard.vouchMoneyType = self.hotelRoomType._vouchMoneyType;
    hotelQueryCreditCard.ratePlanId = [NSString stringWithFormat:@"%d",self.hotelRoomType._ratePlanId];
    hotelQueryCreditCard.lcdActivityId = [NSString stringWithFormat:@"%@",self.lcdActivityId];
    
    ASIFormDataRequest * theRequest = [InterfaceClass hotelQueryCreditCard:hotelQueryCreditCard];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onQueryCreditCardPaseredResult:) Delegate:self needUserType:Default];
    [hotelQueryCreditCard release];
}

-(void)onQueryCreditCardPaseredResult:(NSDictionary*)dic
{
    if(![dic objectForKey:@"statusCode"])
    {
        //[UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
        return;
    }
    if([[dic objectForKey:@"vouchSetType"] intValue] == 0)
    {
        //        调到酒店订单页面
        HotelDetailViewController *hotelDetailVC = [[HotelDetailViewController alloc]init];
        hotelDetailVC.onHotelQueryCreditCard = [OnHotelQueryCreditCard GetOnHotelQueryCreditCard:dic];

        hotelDetailVC.checkCity = self.checkCity;
        hotelDetailVC.hotelInfo = self.hotelInfo;
        hotelDetailVC.hotelRoomType = self.hotelRoomType;
        hotelDetailVC.checkInDate = self.checkInDate;
        hotelDetailVC.checkOutDate = self.checkOutDate;
        hotelDetailVC.passInfoArray = self.passInfoArray;
        hotelDetailVC.roomCount = [NSString stringWithFormat:@"%d",roomCount];
        hotelDetailVC.connectorMobile = self.contactNum;
        hotelDetailVC.retentionTime = self.retentionTime;
        hotelDetailVC.lcdRate = self.lcdRate;
        hotelDetailVC.lcdValue = self.lcdValue;
        hotelDetailVC.lcdActivityId = self.lcdActivityId;
        [NavigationController pushViewController:hotelDetailVC animated:YES];
        [hotelDetailVC release];
        
    }
    else 
    {
        //        调到酒店担保页面
        HotelGuaranteeViewController *hotelGuaranteeVC = [[HotelGuaranteeViewController alloc] init];
        hotelGuaranteeVC.onHotelQueryCreditCard = [OnHotelQueryCreditCard GetOnHotelQueryCreditCard:dic];

        hotelGuaranteeVC.checkCity = self.checkCity;
        hotelGuaranteeVC.hotelInfo = self.hotelInfo;
        hotelGuaranteeVC.hotelRoomType = self.hotelRoomType;
        hotelGuaranteeVC.checkInDate = self.checkInDate;
        hotelGuaranteeVC.checkOutDate = self.checkOutDate;
        hotelGuaranteeVC.passInfoArray = self.passInfoArray;
        hotelGuaranteeVC.roomCount = [NSString stringWithFormat:@"%d",roomCount];
        hotelGuaranteeVC.connectorMobile = self.contactNum;
        hotelGuaranteeVC.retentionTime = self.retentionTime;
        hotelGuaranteeVC.lcdRate = self.lcdRate;
        hotelGuaranteeVC.lcdValue = self.lcdValue;
        hotelGuaranteeVC.lcdActivityId = self.lcdActivityId;
        [NavigationController pushViewController:hotelGuaranteeVC animated:YES];
        [hotelGuaranteeVC release];
    }
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(self.keyboardbar == nil )
    {
        KeyBoardTopBar *aKeyboardbar = [[KeyBoardTopBar alloc] init:[NSArray arrayWithObject:textField] view:self.view ];
        self.keyboardbar = aKeyboardbar;
        [aKeyboardbar release];
    }
    else {
        keyboardbar.textFields = [NSArray arrayWithObject:textField];
    }
    //KeyBoardTopBar的实例对象调用显示键盘方法
    
    [self.keyboardbar showBar:textField];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.contactNum = textField.text;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 11;
	
	if(textFieldStrLength >= textFieldMaxLenth)
	{
		textField.text = [textFieldStr substringToIndex:textFieldMaxLenth];
		return NO;
	}
	else {
		return YES;
	}
	

}


#pragma mark mark_tableviewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView
{
	return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 3)
    {
        if([self.passInfoArray count] == 0)
        {
            return 1;
        }
        else 
        {
            return [self.passInfoArray count];
        }
    }
	return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if(fisrtStyle)
                return 40;
            else 
                return 95;
        }
            break;
        case 1:
            return 80;
            break;   
        case 2:
            return 60;
            break;
        case 3:
            return 50;
            break;
        case 4:
            return 70;
            break;
        default:
            return 70;
            break;
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if(fisrtStyle)
            {
                static NSString * firstIdentifier = @"firstIdentifier";
                FirstSectionFirstStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:firstIdentifier];
                if (cell== nil) {
                    cell = [[[FirstSectionFirstStyleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstIdentifier] autorelease];
                }
                cell.hotelName.text = self.hotelInfo._hotelName;
                cell.checkInDate.text = self.checkInDate;
                cell.checkOutDate.text = self.checkOutDate;
                ((int)(self.hotelRoomType._totalPrice*100)%100)?(cell.singlePrice.text = [NSString stringWithFormat:@"%d",(int)self.hotelRoomType._totalPrice+1]):(cell.singlePrice.text = [NSString stringWithFormat:@"%d",(int)self.hotelRoomType._totalPrice]);
                cell.singlePrice.numberOfLines = 1;
                cell.singlePrice.minimumFontSize = 10;
                cell.singlePrice.adjustsFontSizeToFitWidth = YES;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            else 
            {
                static NSString * firstIdentifierStyleSecond = @"firstIdentifierStyleSecond";
                FirstSectionSecondStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:firstIdentifierStyleSecond];
                if (cell== nil) {
                    cell = [[[FirstSectionSecondStyleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstIdentifierStyleSecond] autorelease];
                }
                
                if ([[UserInfo sharedUserInfo].userID isEqualToString:@""] || [self.hotelRoomType._totalLcdFee intValue] == 0) { // zxt 添加非会员预订显示
                    cell._returnLcdView.hidden = YES;
                }
                cell.checkInDate.text = self.checkInDate;
                cell.checkOutDate.text = self.checkOutDate;
                cell.hotelName.text = self.hotelInfo._hotelName;
                
                ((int)(self.hotelRoomType._totalPrice*100)%100)?(cell.singlePrice.text = [NSString stringWithFormat:@"%d",(int)self.hotelRoomType._totalPrice+1]):(cell.singlePrice.text = [NSString stringWithFormat:@"%d",(int)self.hotelRoomType._totalPrice]);
                cell.singlePrice.numberOfLines = 1;
                cell.singlePrice.minimumFontSize = 10;
                cell.singlePrice.adjustsFontSizeToFitWidth = YES;
                cell.reviews.text = [NSString stringWithFormat:@"%1.1f",self.hotelInfo._rating];
                cell.districtName.text = self.hotelInfo._districtName;
                cell.returnLcdFee.text = [NSString stringWithFormat:@"返%@",self.hotelRoomType._totalLcdFee];
		if(self.hotelInfo._diamond){
			[cell setDiamondCount:self.hotelInfo._starCode];
		}else{
			[cell setStartsCount:self.hotelInfo._starCode];
		}
                
                [cell.smallPicture setUrlString:self.hotelInfo._picUrl];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
            break;
        case 1:
        {
            static NSString * secondIdentifier = @"secondIdentifier";
            SetRoomCountSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:secondIdentifier];
            if (cell== nil) {
                cell = [[[SetRoomCountSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondIdentifier] autorelease];
            }
            if(self.fisrtStyle)
            {
                [cell.drawerButton setImage:[UIImage imageNamed:@"抽屉.png"] forState:UIControlStateNormal];
            }
            else
            {
                [cell.drawerButton setImage:[UIImage imageNamed:@"抽屉2.png"] forState:UIControlStateNormal];
            }
            cell.reduceButton.tag = 0;
            cell.addRoomButton.tag = 1;
            [cell.roomCount setText:[NSString stringWithFormat:@"%d",roomCount]];
            [cell.drawerButton addTarget:self action:@selector(drawerClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.reduceButton addTarget:self action:@selector(setRomesCount:) forControlEvents:UIControlEventTouchUpInside];
            [cell.addRoomButton addTarget:self action:@selector(setRomesCount:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
            static NSString * thirdIdentifier = @"thirdIdentifier";
            AddPersonnelToListSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier];
            if (cell== nil) {
                cell = [[[AddPersonnelToListSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdIdentifier] autorelease];
            }
            [cell.addPersonnelButton addTarget:self action:@selector(addPerson:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }   
            break;
        case 3:
        {
            if([self.passInfoArray count] == 0)
            {
                static NSString * noCheckPersoIdentifier = @"noCheckPersoIdentifier";
                NOCheckPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:noCheckPersoIdentifier];
                if (cell== nil) {
                    cell = [[[NOCheckPersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noCheckPersoIdentifier] autorelease];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            else
            {
                static NSString * checkPersonCellIdentifier = @"checkPersonCellIdentifier";
                CheckPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:checkPersonCellIdentifier];
                if (cell== nil) {
                    cell = [[[CheckPersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:checkPersonCellIdentifier] autorelease];
                }
                if(indexPath.row != [self.passInfoArray count]-1)
                {
                    cell.lineImageView.hidden = YES;
                }
                cell.checkPerson.text = ((HotelPersonnelInfo*)[self.passInfoArray objectAtIndex:indexPath.row])._name;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
            break;
        case 4:
        {
            static NSString * CheckPersonContactIdentifier = @"CheckPersonContactIdentifier";
            CheckPersonContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CheckPersonContactIdentifier];
            if (cell== nil) {
                cell = [[[CheckPersonContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CheckPersonContactIdentifier] autorelease];
            }
            cell._phoneNumTF.delegate = self;
            if(![[UserInfo sharedUserInfo].userID isEqualToString:@""])
            {
                self.contactNum = [UserInfo sharedUserInfo].telePhone;
                cell._phoneNumTF.text = [UserInfo sharedUserInfo].telePhone;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        break;
        default:
        {
            static NSString * retentionTimeIdentifier = @"retentionTimeIdentifier";
            RetentionTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:retentionTimeIdentifier];
            if (cell== nil) {
                cell = [[[RetentionTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:retentionTimeIdentifier] autorelease];
            }
            NSArray *array = [self.retentionTime componentsSeparatedByString:@"-"];
            [cell.retentionTime setText:[NSString stringWithFormat:@"%@--%@",[array objectAtIndex:0],[array objectAtIndex:1]]];
            [cell.selectTime addTarget:self action:@selector(selectRetentionTime:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
    }


}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
	
	return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { 
    if(indexPath.section == 3 && [self.passInfoArray count] > 0)
    {
    	return YES; 
    }
    else {
        return NO;
    }
} 

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) { 
		NSLog(@"%d",indexPath.row);
		[self.passInfoArray removeObjectAtIndex:indexPath.row]; 
        [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
		
	}    
	else if (editingStyle == UITableViewCellEditingStyleInsert) { 
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view. 
	} 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(self.keyboardbar)
//    {
//        [self.keyboardbar HiddenKeyBoard];
//    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
