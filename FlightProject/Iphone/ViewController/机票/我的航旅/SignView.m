//
//  SignView.m
//  FlightProject
//
//  Created by longcd on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SignView.h"

@implementation SignView
+(SignView *)shareSignView
{
    static SignView * view = nil;
    if (view == nil) {
        view = [[SignView alloc] initWithFrame:CGRectMake(20,20,280,350)];
    }
    return view;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor grayColor];
        [self addSubview : [UIButton buttonWithType:UIButtonTypeRoundedRect tag:0 title:@"X" frame:CGRectMake(255, 5, 20, 20) backImage:nil  target:self action:@selector(close:)] ];
        
        [self addSubview:[UILabel labelWithTitle:@"手机号码" frame:CGRectMake(20, 40, 100, 30) font: [UIFont boldSystemFontOfSize:18] alignment:UITextAlignmentLeft]];
        [self addSubview:[UILabel labelWithTitle:@"用户密码" frame:CGRectMake(20, 90, 100, 30) font: [UIFont boldSystemFontOfSize:18] alignment:UITextAlignmentLeft]];
        [self addSubview:[UILabel labelWithTitle:@"显示密码" frame:CGRectMake(20, 140, 100, 30) font: [UIFont boldSystemFontOfSize:18] alignment:UITextAlignmentLeft]];
        [self addSubview:[UILabel labelWithTitle:@"短信验证码" frame:CGRectMake(20, 190, 100, 30) font: [UIFont boldSystemFontOfSize:18] alignment:UITextAlignmentLeft]];
        [self addSubview:[UILabel labelWithTitle:@"推荐人号码" frame:CGRectMake(20, 240, 100, 30) font: [UIFont boldSystemFontOfSize:18] alignment:UITextAlignmentLeft]];
        
        [self addSubview : [UIButton buttonWithType:UIButtonTypeRoundedRect tag:0 title:@"注册" frame:CGRectMake(20, 290, 100, 35) backImage:nil  target:self action:@selector(signIn:)] ];
        [self addSubview : [UIButton buttonWithType:UIButtonTypeRoundedRect tag:0 title:@"重置" frame:CGRectMake(160, 290, 100, 35) backImage:nil  target:self action:@selector(reset:)] ];

    }
    return self;
}
-(void)close:(id)sender
{
    [self removeFromSuperviewWithAnimated:NO];
}
-(void)signIn:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)reset:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
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
