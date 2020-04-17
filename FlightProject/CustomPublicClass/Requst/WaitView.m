//
//  WaitView.m
//  TestProject
//
//  Created by  on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WaitView.h"


@implementation WaitView
@synthesize delegate,loadingView;
-(void)dealloc
{
    self.loadingView = nil;
    [super dealloc];
}
+(WaitView *)shareWaitView
{
    static WaitView * instance = nil;
    if (instance == nil) {
        instance = [[WaitView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 568)];
    }
    return instance;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIImageView * imageV = [UIImageView ImageViewWithFrame:self.bounds image:[UIImage imageNamed:@"loading蒙版.png"]];
        [self addSubview:imageV];
        
        self.loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(11, (frame.size.height - 44 - 120)/2, 297, 120)];
        [loadingView._cancelButton addTarget:self action:@selector(cancelConnection) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:loadingView];
        [loadingView release];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)cancelConnection
{
    if (delegate && [delegate respondsToSelector:@selector(cancelRequst)]) {
        [delegate performSelector:@selector(cancelRequst)];
    }
}
-(void)showWaitView
{
    if (![loadingView.timer isValid]) {
        loadingView.timer =  [NSTimer scheduledTimerWithTimeInterval:0.05 target:loadingView selector:@selector(replaceImage) userInfo:nil repeats:YES];
    }
    loadingView.imageIndex = 0;
    loadingView.loadImgView.image = [UIImage imageNamed:@"载入0.png"];
    [WaitView shareWaitView].hidden = NO;
    [[[(AppDelegate *)[UIApplication sharedApplication] delegate] window] addSubview:self];
    
}
-(void)hiddenWaitView
{
    self.hidden = YES;
    if ([loadingView.timer isValid]) {
        [loadingView.timer invalidate];
        loadingView.timer = nil;
    }
    [self removeFromSuperview];
}

- (void)hiddenLoadingButton:(BOOL)state
{
    loadingView._cancelButton.hidden = state;
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
