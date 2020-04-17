//
//  LoadingView.h
//  FlightProject
//
//  Created by admin on 12-11-7.
//
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

@property (nonatomic, retain) UISubLabel *_titleLab;
@property (nonatomic, retain) UIButton *_cancelButton;
@property (nonatomic, assign)NSInteger imageIndex;
@property (nonatomic, retain) UIImageView *loadImgView;
@property (nonatomic, retain) NSTimer * timer;

@end
