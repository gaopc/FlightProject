//
//  MemberOrderReturnViewController.m
//  FlightProject
//
//  Created by admin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberOrderReturnViewController.h"

@interface MemberOrderReturnViewController ()

@end

@implementation MemberOrderReturnViewController
@synthesize ticketNumberInfo, _notLoginUser;

- (void)dealloc
{
    self.ticketNumberInfo = nil;
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
    self.title = @"退款方式";
    
    lableViewSize = [self.ticketNumberInfo._rules sizeWithFont:FontSize24 constrainedToSize:CGSizeMake(ViewWidth - 40, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
	
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44-5-50) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.allowsSelection = YES;
    myTable.dataSource = self;
    myTable.delegate = self;
    
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, ViewHeight-44-50-5, ViewWidth - 20, 5) image:[UIImage imageNamed:@"分割线.png"]]];
    
    normalReturn = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(15, ViewHeight-44-50+5, 137, 34) backImage:[UIImage imageNamed:@"原支付退款.png"] target:self action:@selector(ticketReturn:)];
    lcdReturn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth - 15 - 137, ViewHeight-44-50+5, 137, 34) backImage:[UIImage imageNamed:@"畅达币退款.png"] target:self action:@selector(lcdCoinReturn:)];
    
    [self.view addSubview:myTable];
    [self.view addSubview:normalReturn];
    [self.view addSubview:lcdReturn];
    
    [myTable release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



#pragma mark - Table view dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 130;
            break;
        case 1:
            return 65 + lableViewSize.height;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"identifier";
    if (indexPath.row == 0) {
        
        MemberOrderTicketInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[MemberOrderTicketInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];                
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell._ticketNum.text = [NSString stringWithFormat:@"%@", self.ticketNumberInfo._ticketNum];
            cell._totailPrice.text = [NSString stringWithFormat:@"￥%@", self.ticketNumberInfo._totalPrice];
            cell._fee.text = [NSString stringWithFormat:@"￥%@", self.ticketNumberInfo._fee];
            cell._returnPrice.text = [NSString stringWithFormat:@"￥%@", self.ticketNumberInfo._price];
        }
        return cell;
    }
    else {

        MemberOrderRulesInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[MemberOrderRulesInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier withRule:self.ticketNumberInfo._rules] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell._boxView.frame = CGRectMake(12, 5, 296, 60 + lableViewSize.height);
            
//            cell._rulesContect.text = self.ticketNumberInfo._rules;
        }
        return cell;
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell点击事件");
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0) {
        for (UIViewController *temp in NavigationController.viewControllers) {
            if ([temp isKindOfClass:[MemberOrderViewController class]]) {
                [NavigationController popToViewController:temp animated:YES];
            }
        }
    }
    else if (alertView.tag == 1)
    {
        if (buttonIndex == 1) {
            if (self._notLoginUser) {
                ASIFormDataRequest * theRequest = [InterfaceClass refund:self.ticketNumberInfo._ticketNum withRefundType:@"0"];
                [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onTicketReturnResult:) Delegate:self needUserType:Default];
            }
            else {
                ASIFormDataRequest * theRequest = [InterfaceClass refund:self.ticketNumberInfo._ticketNum withRefundType:@"0"];
                [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onTicketReturnResult:) Delegate:self needUserType:Member];
            }
        }
    }
}

#pragma mark - Self
- (void)lcdCoinReturn:(UIButton *)sender
{
    NSString *message = @"您确认将票款以畅达币的方式返还到您的会员账户中吗？";
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@""
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"确定", nil];
    alert.tag = 1;
    [alert show];
    [alert release];
}

- (void)ticketReturn:(UIButton *)sender
{
    NSString *refundType = [NSString stringWithFormat:@"%d", sender.tag];
    
    
    if (self._notLoginUser) {
        ASIFormDataRequest * theRequest = [InterfaceClass refund:self.ticketNumberInfo._ticketNum withRefundType:refundType];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onTicketReturnResult:) Delegate:self needUserType:Default];
    }
    else {
        ASIFormDataRequest * theRequest = [InterfaceClass refund:self.ticketNumberInfo._ticketNum withRefundType:refundType];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onTicketReturnResult:) Delegate:self needUserType:Member];
    }
}

- (void)onTicketReturnResult:(NSDictionary *)dic
{
    NSString *message = [dic objectForKey:@"message"];
    
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@""
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    alert.tag = 0;
    [alert show];
    [alert release];
}
@end
