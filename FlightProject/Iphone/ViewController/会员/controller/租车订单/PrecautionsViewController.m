//
//  PrecautionsViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PrecautionsViewController.h"

@interface PrecautionsViewController ()

@end

@implementation PrecautionsViewController

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
    self.title = @"订单注意事项";
	// Do any additional setup after loading the view.
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 20, 300, ViewHeight-44-45) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, ViewHeight-44-5-20, 300, 15) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
    [self.view addSubview:[UISubLabel labelWithTitle:@"订单注意事项" frame:CGRectMake(20, 30, 280, 20) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentCenter autoSize:YES]];
    [self.view addSubview:[UISubLabel labelWithTitle:@"1. 修改订单，请您至少在预订取车时限开始前6小时致电400-6858-999修改，逾时订单不能修改；\n\n2. 如需取消订单，请您至少在预订取车时限开始前6小时登录客户端或隆畅达官网取消该订单；\n\n3. 系统将为您保留一年之内的订单，如需查询更早的订单，请致电24小时热线。" frame:CGRectMake(25, 70, 270, 20) font:FontSize26 color:FontColor636363 alignment:NSTextAlignmentLeft autoSize:YES]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
