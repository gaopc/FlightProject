//
//  PersonnelListViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PersonnelListViewController.h"
#import "EditPersonnelViewController.h"
#import "HotelPassengerDataResponse.h"
#import "HotelOrdersViewController.h"
#import "InterfaceClass.h"
#import "SendRequstCatchQueue.h"

@interface PersonnelListViewController ()
-(void) getPassengersInfo; // 获取乘机人列表
-(void) addPassenger:(id)sender; //新增乘机人
-(void) add:(id)sender; //添加乘机人

@end

@implementation PersonnelListViewController

@synthesize passengersInfoArray ;
@synthesize p_tableView;
@synthesize stateDictionary;
@synthesize sourceType,hotelPersonnelInfo,surplusRoom;

#pragma mark -
#pragma mark View系统方法



- (void)loadView{
	
	[super loadView];
	
	UISubLabel *titleLabel = [UISubLabel labelWithTitle:@"常用入住人列表" frame:CGRectMake(15.0f, 15.0f, 140.0f, 40.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
	titleLabel.textColor = FontColor333333;
	[self.view addSubview:titleLabel];
	
	passengerAddButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(198.0f, 18.0f, 115.0f, 32.0f) backImage:[UIImage imageNamed:@"HotelPersonne2.png"] target:self action:@selector(addPassenger:)];
	[self.view addSubview:passengerAddButton];
	
	self.p_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 60.0f, ViewWidth, ViewHeight -44 - 110) style:UITableViewStylePlain];
	self.p_tableView.backgroundColor = [UIColor clearColor];
	self.p_tableView.dataSource = self;
	self.p_tableView.delegate = self;
	self.p_tableView.separatorColor = [UIColor clearColor];
	[self.view addSubview:self.p_tableView];
	
	UIImageView *bottomButtonImgView=[UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight-98.0f, ViewWidth, 50.0f)];
	bottomButtonImgView.image=[UIImage imageNamed:@"PassBottomButtonBg.png"];
	[self.view addSubview:bottomButtonImgView];
	
	submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(85.0f,  ViewHeight-88.0f, 145.0f, 38.0f) backImage:[UIImage imageNamed:@"ConfirmationPassButton.png"] target:self action:@selector(add:)];
	[self.view addSubview:submitButton];
	
	
}


-(void)dealloc
{
	self.p_tableView = nil;
	self.passengersInfoArray = nil;
	self.stateDictionary = nil;
	self.hotelPersonnelInfo = nil;
	self.sourceType = 0;
	self.surplusRoom = 0;
	[super dealloc];
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self getPassengersInfo];
}
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"选择入住人";
	
	//self.surplusRoom = 3;
	// Do any additional setup after loading the view.
	self.stateDictionary = [NSMutableDictionary dictionary];
	
	if (memberVC.passInfoArray.count>0) {
		
		for (HotelPersonnelInfo *tmp in memberVC.passInfoArray) {
			//NSNumber *checked = [self.stateDictionary objectForKey:tmp._id];
			NSNumber *checked = nil;
			[self.stateDictionary setObject:(checked = [NSNumber numberWithBool:YES]) forKey:tmp._id];
		}
	}
	
	
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
}


#pragma mark -
#pragma mark 数据加载方法

- (void)getPassengersInfo // 获取乘机人列表
{
	ASIFormDataRequest * theRequest = [InterfaceClass checkPersonnelList:[UserInfo sharedUserInfo].userID]; //测试的UserID69743
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(oncheckPersonnelListPaseredResult:) Delegate:self needUserType:Member];
}
- (void)oncheckPersonnelListPaseredResult:(NSDictionary *)dic
{
    isRequestList = TRUE;
	self.passengersInfoArray =  [HotelPassengerDataResponse checkPersonnelList:dic];
	[self.p_tableView reloadData];
}

//删除入住人
-(void) loadDelDataSource
{
	ASIFormDataRequest * theRequest = [InterfaceClass deleteCheckPersonnel:self.hotelPersonnelInfo._id];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelPaseredResult:) Delegate:self needUserType:Member];
	
	
	
}

//删除请求返回处理
- (void)onDelPaseredResult:(NSDictionary *)dic
{
	
	if (memberVC.passInfoArray.count>0) {
		if ([memberVC.passInfoArray containsObject:self.hotelPersonnelInfo]) {
			[memberVC.passInfoArray removeObject:self.hotelPersonnelInfo];
		}
		
	}
	
}

#pragma mark -
#pragma mark 自定义方法
//新增入住人
-(void) addPassenger:(id)sender
{
	EditPersonnelViewController * editPassegersInfoVC = [[EditPersonnelViewController alloc] init];
	editPassegersInfoVC->passengersInfoVC = self;
	[self.navigationController pushViewController:editPassegersInfoVC animated:YES];
	[editPassegersInfoVC release];
}
-(void)backHome
{
    if (isRequestList) {
        NSMutableArray * mArray = [NSMutableArray array];
        [mArray addObjectsFromArray:memberVC.passInfoArray];
        for (HotelPersonnelInfo * item in mArray)
        {
            BOOL inAllArray = FALSE;
            for (HotelPersonnelInfo *tmp in self.passengersInfoArray)
            {
                if ([tmp._id isEqualToString:item._id]) {
                    inAllArray = TRUE;
                }
            }
            if (inAllArray == FALSE) {
                [memberVC.passInfoArray removeObject:item];
            }
        }
        for (int i=0;i< [memberVC.passInfoArray count];i++)
        {
            HotelPersonnelInfo * item = [memberVC.passInfoArray objectAtIndex:i];
            for (HotelPersonnelInfo *tmp in self.passengersInfoArray)
            {
                if ([tmp._id isEqualToString:item._id]) {
                    [memberVC.passInfoArray replaceObjectAtIndex:i withObject:tmp];
                }
            }
        }

    }
    [super backHome];
}


//添加入住
-(void) add:(id)sender
{
        int checkedCount = 0; //选择的数量
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	//if (memberVC.passInfoArray.count>0) [memberVC.passInfoArray removeAllObjects];
        for (HotelPersonnelInfo *tmp in self.passengersInfoArray) {
		NSNumber *checked = [self.stateDictionary objectForKey:tmp._id];
		if (checked) {
			if ([checked intValue]==1) {
				[tempArray addObject:tmp];
				//[memberVC.passInfoArray addObject:tmp];
				checkedCount++;
			}
		}
		
	}
        if (checkedCount==0) 
	{
		[UIAlertView alertViewWithMessage:@"请选择入住人!" :@"提示"];
		[tempArray release];
		return;
	}
	if (checkedCount>self.surplusRoom) 
	{
		[UIAlertView alertViewWithMessage:@"入住人数量必须和房间数一致，请重新输入!" :@"提示"];
		[tempArray release];
		return;
	}
	if (memberVC.passInfoArray.count>0) [memberVC.passInfoArray removeAllObjects];
	memberVC.passInfoArray = tempArray;
	[tempArray release];
	[self.navigationController popViewControllerAnimated:YES];
	
	//	[self.navigationController popViewControllerAnimated:YES];
	
}



#pragma mark -
#pragma mark UITableView方法
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
	
	return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { 
	return YES; 
} 


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	
	if (editingStyle == UITableViewCellEditingStyleDelete) { 
		
		self.hotelPersonnelInfo = (HotelPersonnelInfo *)[self.passengersInfoArray objectAtIndex:indexPath.row];
		[self loadDelDataSource];
		[self.passengersInfoArray removeObjectAtIndex:indexPath.row]; 
		[self.p_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade]; 
		
	}    
	else if (editingStyle == UITableViewCellEditingStyleInsert) { 
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view. 
	} 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 65.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.passengersInfoArray count];
	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * identifier = @"identifier";
	PersonnelListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[PersonnelListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		cell.backgroundColor = [UIColor clearColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
	}
	HotelPersonnelInfo *passInfo = nil;
	passInfo = (HotelPersonnelInfo *)[self.passengersInfoArray objectAtIndex:indexPath.row];
	cell.delegate = self;
	cell.name.text = passInfo._name;
	NSNumber *checked = [self.stateDictionary objectForKey:passInfo._id];
	if (!checked) [self.stateDictionary setObject:(checked = [NSNumber numberWithBool:NO]) forKey:passInfo._id];
	cell.btnView.hidden = checked.boolValue ? NO :YES;
	
	return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{	
	PersonnelListCell *cell = (PersonnelListCell*)[self.p_tableView cellForRowAtIndexPath:indexPath];
	HotelPersonnelInfo *passInfoItem = [self.passengersInfoArray objectAtIndex:indexPath.row];
	NSString *kId = passInfoItem._id;
	BOOL isChecked = !([[self.stateDictionary objectForKey:kId] boolValue]);
	NSNumber *checked = [NSNumber numberWithBool:isChecked];
	[self.stateDictionary setObject:checked forKey:kId];
	cell.btnView.hidden = isChecked ? NO : YES;

}
@end
