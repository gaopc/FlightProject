//
//  TooltipView.h
//  FlightProject
//
//  Created by admin on 12-11-20.
//
//

#import <UIKit/UIKit.h>
#import "MyExtend.h"

@interface TooltipView : UIView <UITextViewDelegate>
@property (nonatomic, retain) UISubLabel *_toolTitle;
@property (nonatomic, retain) UISubTextView *_toolSubTitle;
@property (nonatomic, retain) UIImageView *_backView;
@property (nonatomic, retain) UIButton *_cancelButton;
@end
