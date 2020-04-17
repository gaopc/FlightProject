//
//  ActivityTimerView.h
//  FlightProject
//
//  Created by gaopengcheng on 14-12-17.
//
//

#import <UIKit/UIKit.h>

@interface ActivityTimerView : UIView <UIGestureRecognizerDelegate>
{
    UILabel *countLab;
    UILabel *minuteLab;
    UILabel *secondLab;
    UIImageView *countView;
    int countNum;
}
@property (nonatomic, retain) NSTimer *_activityTimer;
@property (nonatomic, retain) NSString *_activitySecond;
@property (nonatomic, retain) NSString *_activityMileage;
@property (nonatomic, retain) NSString *_activityShareUrl;
@property (assign) BOOL _isAactivation;

+ (ActivityTimerView *)shareTimerView;
- (void)showTimerView;
-(void)hiddenTimerView;
- (void)pauseTimerView;
- (void)playTimerView;
- (void)stopTimerView;
@end
