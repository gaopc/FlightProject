//
//  LoginView.m
//  FlightProject
//
//  Created by longcd on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

+(LoginView *)shareLoginView
{
    static LoginView * view = nil;
    if (view == nil) {
        view = [[LoginView alloc] initWithFrame:CGRectMake(20,20,280,350)];
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
        [self addSubview:[UILabel labelWithTitle:@"会员密码" frame:CGRectMake(20, 90, 100, 30) font: [UIFont boldSystemFontOfSize:18] alignment:UITextAlignmentLeft]];
        [self addSubview:[UILabel labelWithTitle:@"保存密码" frame:CGRectMake(20, 140, 100, 30) font: [UIFont boldSystemFontOfSize:18] alignment:UITextAlignmentLeft]];
        
        [self addSubview : [UIButton buttonWithType:UIButtonTypeRoundedRect tag:0 title:@"注册" frame:CGRectMake(20, 240, 100, 35) backImage:nil  target:self action:@selector(signIn:)] ];
        [self addSubview : [UIButton buttonWithType:UIButtonTypeRoundedRect tag:0 title:@"登陆" frame:CGRectMake(160, 240, 100, 35) backImage:nil  target:self action:@selector(loginIn:)] ];

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
    [self.superview addSubview:[SignView shareSignView] animated:YES];
    [self removeFromSuperviewWithAnimated:NO];
}
-(void)loginIn:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
    TelephoneLogin * loginRequestModel = [TelephoneLogin shareRootRequestModel];
    loginRequestModel.telephone = @"15010035497";
    loginRequestModel.password = @"123456";
    NSMutableURLRequest * theRequest = [InterfaceClass userSignIn:loginRequestModel];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest withSelector:@selector(onPaseredResult:) withDelegate :self];
}
-(void)onPaseredResult:(NSArray *)resultArray
{
    UserInfo * userInfo =  [TelePhoneLoginResponse telePhoneLoginResponseWithArray:resultArray];
    if (userInfo) {
        [self removeFromSuperviewWithAnimated:NO];
    }
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
