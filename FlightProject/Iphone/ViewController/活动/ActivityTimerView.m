//
//  ActivityTimerView.m
//  FlightProject
//
//  Created by gaopengcheng on 14-12-17.
//
//

#import "ActivityTimerView.h"

@implementation ActivityTimerView
@synthesize _activityTimer, _activitySecond, _activityMileage, _activityShareUrl;

- (void)dealloc
{
    self._activityTimer = nil;
    self._activitySecond = nil;
    self._activityMileage = nil;
    self._activityShareUrl = nil;
    [super dealloc];
}

+ (ActivityTimerView *)shareTimerView
{
    static ActivityTimerView * instance = nil;
    if (instance == nil) {
        instance = [[ActivityTimerView alloc] initWithFrame:CGRectMake((ViewWidth - 90)/2, 80, 90, 65)];//220*98 80, 35
        instance._activityMileage = @"0";
//        instance.layer.borderColor = [UIColor grayColor].CGColor;
//        instance.layer.borderWidth = 1;
    }
    return instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:pan];
        [pan release];
        
        countView = [UIImageView ImageViewWithFrame:CGRectMake(5, 15, 80, 35) image:[UIImage imageNamed:@"悬浮计时器.png"]];
        minuteLab = [UILabel labelWithTitle:@"00" frame:CGRectMake(0, 0, 37, 35) font:[UIFont boldSystemFontOfSize:16] color:[UIColor brownColor] alignment:NSTextAlignmentRight];
        secondLab = [UILabel labelWithTitle:@"00" frame:CGRectMake(48, 0, 32, 35) font:[UIFont boldSystemFontOfSize:16] color:[UIColor brownColor] alignment:NSTextAlignmentLeft];
        
        [countView addSubview:minuteLab];
        [countView addSubview:secondLab];
        [self addSubview:countView];
        
        countView.center = CGPointMake(self.frame.size.width/2, countView.frame.size.height/2);
        
    }
    return self;
}

- (void)showTimerView
{
    self._isAactivation = YES;
    countNum = 0;
    self._activitySecond = @"0";
    
    if (![self._activityTimer isValid]) {
        self._activityTimer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startCount) userInfo:nil repeats:YES];
    }
    [ActivityTimerView shareTimerView].hidden = NO;
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    
}

- (void)hiddenTimerView
{
    self._activitySecond = [NSString stringWithFormat:@"%d", countNum];
    [ActivityTimerView shareTimerView].hidden = YES;
    if ([self._activityTimer isValid]) {
        [self._activityTimer invalidate];
        self._activityTimer = nil;
    }
    [self removeFromSuperview];
}

- (void)pauseTimerView
{
    if ([self._activityTimer isValid]) {
        [self._activityTimer setFireDate:[NSDate distantFuture]];
    }
}

- (void)stopTimerView
{
    self._isAactivation = NO;
    self._activitySecond = @"0";
    countNum = 0;
    secondLab.text = @"00";
    minuteLab.text = @"00";
}

- (void)playTimerView
{
    if ([self._activityTimer isValid]) {
        [self._activityTimer setFireDate:[NSDate date]];
    }
}

- (void)startCount
{

    countNum ++;
    NSString *minute = [NSString stringWithFormat:@"%d", countNum/60];
    NSString *second = [NSString stringWithFormat:@"%d", countNum%60];
    if (minute.length < 2) {
        minute = [NSString stringWithFormat:@"0%@", minute];
    }
    if (second.length < 2) {
        second = [NSString stringWithFormat:@"0%@", second];
    }
    secondLab.text = second;
    minuteLab.text = minute;
}

/* 识别拖动 */
- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:[[[UIApplication sharedApplication] delegate] window]];

    self.center = location;
    
    CGRect rect = self.frame;
    
    if (rect.origin.x < 0) {
        rect.origin.x = 0;
    }
    else if (rect.origin.x > [[UIScreen mainScreen] applicationFrame].size.width -self.frame.size.width) {
        rect.origin.x = [[UIScreen mainScreen] applicationFrame].size.width -self.frame.size.width;
    }
    
    if (rect.origin.y < 0) {
        rect.origin.y = 0;
    }
    else if (rect.origin.y > [[UIScreen mainScreen] applicationFrame].size.height + ViewStartY - self.frame.size.height) {
        rect.origin.y = [[UIScreen mainScreen] applicationFrame].size.height + ViewStartY - self.frame.size.height;
    }
    self.frame = rect;

    [gestureRecognizer setTranslation:location inView:[[[UIApplication sharedApplication] delegate] window]];
}
@end
