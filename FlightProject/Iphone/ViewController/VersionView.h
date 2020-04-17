//
//  VersionView.h
//  FlightProject
//
//  Created by gaopengcheng on 13-3-5.
//
//

#import <UIKit/UIKit.h>

@protocol VersionViewDelegate;

@interface VersionView : UIView <UITextViewDelegate>
{
    UIButton *cancelButton;
    UIButton *selectButton;
    UIImageView *backgroundView;
}
@property (nonatomic, retain) UISubTextView *versionView;
@property(nonatomic,assign) id <VersionViewDelegate> delegate;

+ (VersionView *)shareVersionView;
- (void)showVersionView;
- (void)hideCancelButton;
@end


@protocol VersionViewDelegate <NSObject>
- (void)removeVersionView;
@end