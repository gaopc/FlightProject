//
//  HomeButtonsView.m
//  FlightProject
//
//  Created by 月 小 on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HomeButtonsView.h"

@implementation HomeButtonsView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        float offx = (ViewWidth - 320)/2;
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(19.5 + offx, 0, 281, 313) image:[UIImage imageNamed:@"AKVC_buttonBackGround.png"]]];
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(121 + offx, 4, 78, 78) backImage:[UIImage imageNamed:@"AKVC_weather.png"] target:self action:@selector(clickButton:)]];
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(220 + offx, 62, 78, 78) backImage:[UIImage imageNamed:@"AKVC_ passengerNotice.png"] target:self action:@selector(clickButton:)]];
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:2 title:nil frame:CGRectMake(220 + offx, 173, 78, 78) backImage:[UIImage imageNamed:@"AKVC_airportInfo.png"] target:self action:@selector(clickButton:)]];
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:3 title:nil frame:CGRectMake(121 + offx, 232, 78, 78) backImage:[UIImage imageNamed:@"AKVC_company.png"] target:self action:@selector(clickButton:)]];
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:4 title:nil frame:CGRectMake(22 + offx, 173, 78, 78) backImage:[UIImage imageNamed:@"AKVC_flightQuery.png"] target:self action:@selector(clickButton:)]];
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:5 title:nil frame:CGRectMake(22 + offx, 62, 78, 78) backImage:[UIImage imageNamed:@"AKVC-airportBus.png"] target:self action:@selector(clickButton:)]];
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:6 title:nil frame:CGRectMake(121 + offx, 114, 78, 78) backImage:[UIImage imageNamed:@"AKVC_facilitiesServices.png"] target:self action:@selector(clickButton:)]];
    }
    return self;
}

-(void)clickButton:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickButton:)]) {
        [self.delegate performSelector:@selector(clickButton:) withObject:sender];
    }
}

- (void)dealloc
{
    delegate = nil;
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
