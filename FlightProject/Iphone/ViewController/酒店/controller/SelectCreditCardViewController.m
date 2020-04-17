//
//  SelectCreditCardViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectCreditCardViewController.h"
#import "CreditCardCell.h"
#import "HotelGuaranteeViewController.h"
#import "EditCreditCardInfoViewController.h"
@interface SelectCreditCardViewController ()

@end

@implementation SelectCreditCardViewController
@synthesize myTableView,getCreditCardList,creditCardInfo,titleLabel;
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
    self.getCreditCardList = nil;
    self.creditCardInfo = nil;
    self.titleLabel = nil;
    [super dealloc];
}
- (void)loadView{
	[super loadView];
//    self.title = @"选择常用信用卡";
    [self.view addSubview:[UISubLabel labelWithTitle:@"常用信用卡列表" frame:CGRectMake(25, 15, 150, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
    [self.view addSubview:[UIButton customButtonTitle:nil image:[UIImage imageNamed:@"新增信用卡.png"] frame:CGRectMake(ViewWidth - 135, 12, 120, 30) target:self action:@selector(addCreditCard:)]];
    
    self.titleLabel = [UISubLabel labelWithTitle:@"您还没有常用信用卡，请新增信用卡。" frame:CGRectMake(15.0f, 60.0f, ViewWidth - 20, 25.0f) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
    self.titleLabel.hidden = YES;
    [self.view addSubview:self.titleLabel];//您暂无常用信用卡
    

    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,50.0f,ViewWidth,ViewHeight-44.0f-50) style:UITableViewStylePlain];
    self.myTableView = aTableView;
    [aTableView release];
	self.myTableView.backgroundColor = [UIColor clearColor];
	self.myTableView.dataSource = self;
	self.myTableView.delegate = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:self.myTableView];
}

static NSInteger sortArrayByStartTimeId(id item1, id item2, void *context){
    UpdateCreditCard *info1 = item1;
	UpdateCreditCard *info2 = item2;
	
	int v1 = [info1._id intValue];
	int v2 = [info2._id intValue];
	
	if (v1 < v2)
        return NSOrderedDescending;
    else if (v1 > v2)
        return NSOrderedAscending;
    else
        return NSOrderedSame;
}

-(void)onCreditCardListdPaseredResult:(NSDictionary*)dic
{
    
    self.getCreditCardList = (GetCreditCardList*)[GetCreditCardList GetCreditCardList:dic];
    NSArray *array = [self.getCreditCardList.creditCardList sortedArrayUsingFunction:sortArrayByStartTimeId context:NULL];
    self.getCreditCardList.creditCardList = (NSMutableArray*)array;
    if([self.getCreditCardList.creditCardList count] == 0)
    {
        self.titleLabel.hidden = NO;
    }
   
    [self.myTableView reloadData];
}

-(void)addCreditCard:(UIButton*)sender
{
    NSLog(@"addCreditCard");
    EditCreditCardInfoViewController *addCreditCardInfoVC = [[EditCreditCardInfoViewController alloc] init];
    addCreditCardInfoVC.title = @"新增常用信用卡";
    UpdateCreditCard *aUpdateCreditCard = [[UpdateCreditCard alloc] init];
    addCreditCardInfoVC.updateCreditCard = aUpdateCreditCard;
    [aUpdateCreditCard release];
    addCreditCardInfoVC->hotelGuaranteeViewController = self->hotelGuaranteeViewController;
    
    addCreditCardInfoVC->orderByCardPayViewController = self->orderByCardPayViewController;
    
    addCreditCardInfoVC.ifAddCreditCard = YES;
    [NavigationController pushViewController:addCreditCardInfoVC animated:YES];
    [addCreditCardInfoVC release];
}

//删除信用卡请求
- (void)loadDelDataSource 
{
    if([self->hotelGuaranteeViewController.creditCardInfo._id isEqualToString:self.creditCardInfo._id] || [self->orderByCardPayViewController.creditCardInfo._id isEqualToString:self.creditCardInfo._id])
    {
        self->hotelGuaranteeViewController.viewNum = 1;
        self->hotelGuaranteeViewController.creditCardInfo = nil;
        self->hotelGuaranteeViewController.deleteCreditCard = YES;
        
        self->orderByCardPayViewController.viewNum = 1;
        self->orderByCardPayViewController.creditCardInfo = nil;
        self->orderByCardPayViewController.deleteCreditCard = YES;
        
        NSUserDefaults  * userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:NULL forKey:username_ThreeDemain];
        [userDefault setObject:NULL forKey:bank_ThreeDemain];
        [userDefault setObject:NULL forKey:bankId_ThreeDemain];
        [userDefault setObject:NULL forKey:bankIdCard_ThreeDemain];
        [userDefault setObject:NULL forKey:id_ThreeDemain];
        [userDefault setObject:NULL forKey:idCard_ThreeDemain];
        [userDefault setObject:NULL forKey:validityDate_ThreeDemain];
    }
	ASIFormDataRequest * theRequest = [InterfaceClass deleteCreditCard:[NSString stringWithFormat:@"%@", self.creditCardInfo._id]];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDeleteCreditCard:) Delegate:self needUserType:Member];
	
}

- (void)onDeleteCreditCard:(NSDictionary *)dic
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.getCreditCardList.creditCardList];
    [array removeObject:self.creditCardInfo];
    self.getCreditCardList.creditCardList = array;
    if([self.getCreditCardList.creditCardList count] == 0)
    {
        self.titleLabel.hidden = NO;
    }
    else
    {
        self.titleLabel.hidden = YES;
    }
    [self.myTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    ASIFormDataRequest * theRequest = [InterfaceClass creditCardList:[UserInfo sharedUserInfo].userID];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCreditCardListdPaseredResult:) Delegate:self needUserType:Member];
}
#pragma mark mark_tableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.getCreditCardList.creditCardList count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cellIdentifier%d", indexPath.row];
    CreditCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell== nil) {
        cell = [[[CreditCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        [cell._editBut addTarget:self action:@selector(editInfo:) forControlEvents:UIControlEventTouchUpInside];
        cell._editBut.tag = indexPath.row;
    }
    UpdateCreditCard *aCreditCardInfo = (UpdateCreditCard*)[self.getCreditCardList.creditCardList objectAtIndex:indexPath.row];
    [cell.userName setText:aCreditCardInfo._username];
    
    NSString *subString0 = [aCreditCardInfo._bankIdCard substringWithRange:NSMakeRange(0, 4)];
	NSString *subString1 =  [aCreditCardInfo._bankIdCard substringWithRange:NSMakeRange(4, 8)];
	NSCharacterSet *cs = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
	NSString *subString2 = [[subString1 componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@"*"];
    NSString *subString3 = [aCreditCardInfo._bankIdCard substringFromIndex:12];
    [cell.cardNum setText:[NSString stringWithFormat:@"%@%@%@",subString0,subString2,subString3]];
    [cell.bankName setText:aCreditCardInfo._bank];
    cell.unSelectImageView.hidden = NO;
    cell.selectImageView.hidden = YES;//选中
    if(!self.sourceType)
    {
        cell.unSelectImageView.hidden = YES;
        cell.userName.frame = CGRectMake(23, 15, 65, 20);
        cell.cardNum.frame = CGRectMake(95, 15, 130, 20);
        cell.bankName.frame = CGRectMake(ViewWidth - 110, 15,70, 20);
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.sourceType)
    {
        NSLog(@"editCreditCard");
        EditCreditCardInfoViewController *editCreditCardInfoVC = [[EditCreditCardInfoViewController alloc] init];
        editCreditCardInfoVC.title = @"常用信用卡详情";
        UpdateCreditCard *cardInfo = [self.getCreditCardList.creditCardList objectAtIndex:indexPath.row];
        editCreditCardInfoVC.updateCreditCard = cardInfo;
        editCreditCardInfoVC->hotelGuaranteeViewController = self->hotelGuaranteeViewController;
        
        editCreditCardInfoVC->orderByCardPayViewController = self->orderByCardPayViewController;
        
        editCreditCardInfoVC.ifAddCreditCard = NO;
        [NavigationController pushViewController:editCreditCardInfoVC animated:YES];
        [editCreditCardInfoVC release];
        return;
    }
    UpdateCreditCard *cardInfo = [self.getCreditCardList.creditCardList objectAtIndex:indexPath.row];
    
//    if (![self compareValidityDate:cardInfo._validityDate]) {
//        [UIAlertView alertViewWithMessage:@"信用卡信息已过期，请重新选择。"];
//        return;
//    }
    
    CreditCardCell *cell = (CreditCardCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectImageView.hidden = NO;//选中
    hotelGuaranteeViewController.creditCardInfo = [self.getCreditCardList.creditCardList objectAtIndex:indexPath.row];
    hotelGuaranteeViewController.myValidityDate = hotelGuaranteeViewController.creditCardInfo._validityDate;
    hotelGuaranteeViewController.creditCardInfo._validityDate = @"";
    hotelGuaranteeViewController.viewNum = 3;
    
    orderByCardPayViewController.creditCardInfo = [self.getCreditCardList.creditCardList objectAtIndex:indexPath.row];
    orderByCardPayViewController.creditCardInfo._validityDate = @"";
    orderByCardPayViewController.viewNum = 3;
    [NavigationController popViewControllerAnimated:YES];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
	
	return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { 
	return YES; 
} 


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) { 
		
		self.creditCardInfo = (UpdateCreditCard *)[self.getCreditCardList.creditCardList objectAtIndex:indexPath.row];
		[self loadDelDataSource];
        
//		[self.getCreditCardList.creditCardList removeObjectAtIndex:indexPath.row]; 
//		[self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		
	}    
	else if (editingStyle == UITableViewCellEditingStyleInsert) { 
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view. 
	} 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)editInfo:(UIButton *)sender
{
    NSLog(@"editCreditCard");
    EditCreditCardInfoViewController *editCreditCardInfoVC = [[EditCreditCardInfoViewController alloc] init];
    editCreditCardInfoVC.title = @"常用信用卡详情";
    UpdateCreditCard *cardInfo = [self.getCreditCardList.creditCardList objectAtIndex:sender.tag];
    editCreditCardInfoVC.updateCreditCard = cardInfo;
    editCreditCardInfoVC->hotelGuaranteeViewController = self->hotelGuaranteeViewController;
    
    editCreditCardInfoVC->orderByCardPayViewController = self->orderByCardPayViewController;
    
    editCreditCardInfoVC.ifAddCreditCard = NO;
    [NavigationController pushViewController:editCreditCardInfoVC animated:YES];
    [editCreditCardInfoVC release];
}

- (BOOL)compareValidityDate:(NSString *)date
{
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyMM"];
    NSString *todayTime = [formatter stringFromDate:today];
    
    NSString *validityDate = [NSString stringWithFormat:@"%@%@", [date substringFromIndex:2], [date substringToIndex:2]];
    if ([validityDate intValue] - [todayTime intValue] >= 0) {
        return YES;
    }
    else {
        return NO;
    }
}
@end
