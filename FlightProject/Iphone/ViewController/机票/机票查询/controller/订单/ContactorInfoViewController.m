//
//  ContactorInfoViewController.m
//  FlightProject
//
//  Created by longcd on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ContactorInfoViewController.h"
#import "TicketInfoViewController.h"
#import "PassengersInfoCell.h"
#import "TicketOrderInfoViewController.h"
#define ISSELECTED @"√"

@interface ContactorInfoViewController ()

@end

@implementation ContactorInfoViewController

@synthesize dataArray,ticketOrderInfoData,currentIndex;
-(void)dealloc
{
    self.dataArray = nil;
    self.ticketOrderInfoData = nil;
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
- (void) getContactorInfo // 获取乘机人列表
{
    NSMutableURLRequest * mRequest = [InterfaceClass getContactInfoList:[UserInfo sharedUserInfo].userID];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:mRequest withSelector:@selector(onPaseredResult:) withDelegate:self];
}
-(void)onPaseredResult:(NSArray *)resultArray
{
    self.dataArray = nil;
    NSArray * array = [GetContactorInfosResponse getContactorInfosResponseWithArray:resultArray];
    if (array) {
        NSMutableArray * mArray = [NSMutableArray array];
        for ( int i=0; i< [array count]; i++) {
            ContactorInfo * info = [array objectAtIndex:i];
            BOOL isSelected = FALSE;
            for (ContactorInfo * sectionContactor in self.ticketOrderInfoData._sectionDataArray) {
                if ([sectionContactor.contactorID isEqualToString:info.contactorID]) {
                    self.currentIndex = i;
                    isSelected = YES;
                    break;
                }
            }
            [mArray addObject:[NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects: isSelected?ISSELECTED:@"",info, nil] forKeys:[NSArray arrayWithObjects:@"isSelected",@"contactorInfo", nil]]];
        }
        self.dataArray = mArray;
    }
    [myTable reloadData];
}
-(void) addPassenger: (id)sender
{
}
-(void) makeSure: (id)sender
{
    if (self.currentIndex != -1) {
        self.ticketOrderInfoData._sectionDataArray = [NSMutableArray array];
        [self.ticketOrderInfoData._sectionDataArray addObject:[[self.dataArray objectAtIndex:self.currentIndex] objectForKey:@"contactorInfo"]];
    }
    [NavigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"联系人信息";
    self.currentIndex = -1;
	// Do any additional setup after loading the view.
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"＋" forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0, 44, 44);
    rightButton.backgroundColor = [UIColor blueColor];
    [rightButton addTarget:self action:@selector(addPassenger:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44-44) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
    
    UIButton * makeSure = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"确  认" frame:CGRectMake(0, 460-44-44, 320, 44) backImage:nil target:self action:@selector(makeSure:)];
    makeSure.backgroundColor = [UIColor clearColor];
    [self.view addSubview:makeSure];
    
    [self getContactorInfo];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(void) editContactorInfo:(UIButton *)button
{
    ContactorInfo * contactorInfo =  [[self.dataArray objectAtIndex:button.tag] objectForKey:@"contactorInfo"];
    NSLog(@"%@",contactorInfo.contactorID);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    PassengersInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[PassengersInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    ContactorInfo * contactorInfo =  [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"contactorInfo"];
//    cell._nameStr.text = [NSString stringWithFormat:@"%@",contactorInfo.contactorName];
//    cell._identityCode.text = [NSString stringWithFormat:@"%@",contactorInfo.contactorMobile];
//    cell._identityType.text = [NSString stringWithFormat:@"%@",contactorInfo.contactorTelephone];
//    cell._isSelected.text =  [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"isSelected"];
//    [cell._editPassenger addTarget:self action:@selector(editContactorInfo:) forControlEvents:UIControlEventTouchUpInside];
//    cell._editPassenger.tag = indexPath.row;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary * elem = [self.dataArray objectAtIndex:indexPath.row];
    if ([[elem objectForKey:@"isSelected"] isEqualToString:@""]) {
        [elem setValue:ISSELECTED forKey:@"isSelected"];
        
        if (self.currentIndex != indexPath.row) {  // 控制只选一行
            if (self.currentIndex != -1) {
                NSMutableDictionary * oldCurrentDic = [self.dataArray objectAtIndex:self.currentIndex];
                [oldCurrentDic setValue:@"" forKey:@"isSelected"];
            }
            self.currentIndex = indexPath.row;
        }
    }
    else {
        [elem setValue:@"" forKey:@"isSelected"];
    }
    [tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
