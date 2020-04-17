//
//  UIAlertSubView.m
//  AlertViewController
//
//  Created by 晓婷 张 on 12-10-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIAlertSubView.h"
#import "QueryFlightTicket.h"

@implementation UIAlertSubView
@synthesize delegate;
-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;     
}

-(id)initWithLeftTitle:(NSString *) leftTitle subLeftTitle:(NSString *) subLeftTitle centerTitle:(NSString *)centerTitle subCenterTitles:(NSArray *)subCenterTitles rightTitle:(NSString *)rightTitle subRightTitle:(NSString *)subRightTitle  frame:(CGRect)frame
{
    if ( self == [super initWithFrame:frame] ){
        UIView * background = [[UIView alloc] initWithFrame:self.bounds];
        background.backgroundColor = [UIColor clearColor];
        [self addSubview:background];
        [background release];

        CustomScorllView * view = [[CustomScorllView alloc] initWithLeftTitle:leftTitle subLeftTitle:subLeftTitle centerTitle:centerTitle subCenterTitles:subCenterTitles rightTitle:rightTitle subRightTitle:subRightTitle frame:frame];
        view.delegate = self;
        [self addSubview:view];
        [view release];
    }
    return self;
}
-(void)showWaitView
{
    self.hidden = NO;
    [[[(AppDelegate *)[UIApplication sharedApplication] delegate] window] addSubview:self];
}
-(void)hiddenWaitView
{
    self.hidden = YES;
    [self removeFromSuperview];
}

-(void) sureButtonClick:(id)instance
{
    [self hiddenWaitView];

    if (self.delegate && [self.delegate respondsToSelector:@selector(sureButtonClick:)]) {
        [self.delegate performSelector:@selector(sureButtonClick:) withObject:instance];
    }
}
-(void) cancelButtonClick
{
    [self hiddenWaitView];

    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClick)]) {
        [self.delegate performSelector:@selector(cancelButtonClick)];
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
