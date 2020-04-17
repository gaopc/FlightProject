//
//  HomePageAnimateView.m
//  FlightProject
//
//  Created by longcd on 12-9-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HomePageAnimateView.h"

@implementation HomePageAnimateView
@synthesize animateImageArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        groupIndex = 0;
        memberIndex = 0;
        self.animateImageArray = [NSArray arrayWithObjects:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, 75, 230)], [UIImageView ImageViewWithFrame:CGRectMake(75, 0, 75, 230)],[UIImageView ImageViewWithFrame:CGRectMake(150, 0, 75, 230)],[UIImageView ImageViewWithFrame:CGRectMake(225, 0, 75, 230)],nil];
        for (int i = 0;i<[animateImageArray count];i++) {
            UIImageView * elem = (UIImageView *)[animateImageArray objectAtIndex:i]; 
            elem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d-%d",groupIndex,i]];
            [self addSubview:elem];
        }
        groupIndex ++;
        [self startAnimate];
    }
    return self;
}
-(void)startAnimate
{
    @autoreleasepool {
        CATransition * transition = [CATransition animation];
        transition.duration = 1;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        transition.type = kCATransitionFade;
        [transition setFillMode:kCAFillModeForwards];
        transition.delegate = self;
        
        UIImageView * imageV = [self.animateImageArray objectAtIndex:memberIndex];
        [imageV.layer addAnimation:transition forKey:nil];        
        [imageV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-%d.png",groupIndex,memberIndex]]];
        
        memberIndex ++;
        
        if (memberIndex == [self.animateImageArray count]) {
            memberIndex = 0;
            groupIndex ++;
            if (groupIndex == 5) {
                groupIndex = 0;
            }
        }
    }
}
- (void)animationDidStart:(CAAnimation *)anim
{
    float timeInterval;
    if (memberIndex == 0) {
        timeInterval = 3;
    }
    else {
        timeInterval = 0.5;
    }
    [self performSelector:@selector(startAnimate) withObject:self afterDelay:timeInterval];

}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
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
