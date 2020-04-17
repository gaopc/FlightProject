//
//  GetTravelItineraryViewController.m
//  FlightProject
//
//  Created by longcd on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetTravelItineraryViewController.h"
#import "DevicePositionMapViewController.h"

@interface GetTravelItineraryViewController ()

@end

@implementation GetTravelItineraryViewController

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
    self.title = @"行程单获取方式";
	// Do any additional setup after loading the view.
    
    /*
     *高鹏程
     *用来测试地图界面
     *2012-09-19
     */
    
    queryPositionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    queryPositionButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [queryPositionButton setTitle:@"终端机位置" forState:UIControlStateNormal];
    [queryPositionButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [queryPositionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    queryPositionButton.frame = CGRectMake(120, 200, 80, 20);
    queryPositionButton.backgroundColor = [UIColor clearColor];
    [queryPositionButton addTarget:self action:@selector(moveToMap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queryPositionButton];
}

- (void)moveToMap:(id)sender
{
    DevicePositionMapViewController * devicePositionVC = [[DevicePositionMapViewController alloc] init];
    [self.navigationController pushViewController:devicePositionVC animated:YES];
    [devicePositionVC release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
