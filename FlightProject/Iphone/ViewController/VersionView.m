//
//  VersionView.m
//  FlightProject
//
//  Created by gaopengcheng on 13-3-5.
//
//

#import "VersionView.h"
#import "Header.h"

@implementation VersionView
@synthesize versionView, delegate;

- (void)dealloc
{
    self.versionView = nil;
    [super dealloc];
}

+ (VersionView *)shareVersionView
{
    static VersionView * instance = nil;
    if (instance == nil) {
        instance = [[VersionView alloc] initWithFrame:CGRectMake(0, 586, ViewWidth, 568)];
    }
    return instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        int viewHight = [[UIScreen mainScreen] applicationFrame].size.height;
        
        UIImageView *backView = [UIImageView ImageViewWithFrame:self.bounds image:[UIImage imageNamed:@"loading蒙版.png"]];
        [self addSubview:backView];
        
        UIImageView *imgView = [UIImageView ImageViewWithFrame:CGRectMake(30, (viewHight - 260)/2, 260, 260) image:[UIImage imageNamed:@"弹出层背景.png"]];
        imgView.userInteractionEnabled = YES;
        
        UISubTextView *textView = [[UISubTextView alloc] initWithFrame:CGRectMake(10, 18, 240, 170)];
		textView.font = FontSize28;
		textView.text = @"";
//		textView.editable = NO;
//        textView.userInteractionEnabled = YES;
		textView.backgroundColor = [UIColor clearColor];
        textView.delegate = self;
		[imgView addSubview:textView];
		versionView = textView;
		[textView release];
        
        selectButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(165, (viewHight - 260)/2 + 260 - 50, 112, 34) backImage:[UIImage imageNamed:@"立即升级.png"] target:self action:@selector(clickSelect:)];
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(43, (viewHight - 260)/2 + 260 - 50, 112, 34) backImage:[UIImage imageNamed:@"稍后升级.png"] target:self action:@selector(clickCancel:)];
        backgroundView = [UIImageView ImageViewWithFrame:CGRectMake(39, (viewHight - 260)/2 + 260 - 52, 241, 38) image:[UIImage imageNamed:@"按钮底.png"]];
        
        [self addSubview:imgView];
        [self addSubview:backgroundView];
        [self addSubview:selectButton];
        [self addSubview:cancelButton];
    }
    return self;
}

- (void)clickSelect:(id)sender
{
    NSString *updateurl = @"http://itunes.apple.com/cn/app/zhang-shang-hang-lu/id433135814?mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateurl]];
    exit(0);
}

- (void)clickCancel:(id)sender
{
    CGRect afterRect = self.frame;
    afterRect.origin.y += afterRect.size.height;
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDuration:0.7f];
//    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    self.frame = afterRect;
//    [UIView commitAnimations];
    
    if (delegate && [delegate respondsToSelector:@selector(removeVersionView)]) {
        [delegate performSelector:@selector(removeVersionView)];
    }
}

- (void)showVersionView
{
//    [UIView beginAnimations:@"" context:NULL];
//    [UIView setAnimationDuration:0.7];
    self.frame = CGRectMake(0, 0, ViewWidth, self.frame.size.height);
//    [UIView commitAnimations];
    [[[(AppDelegate *)[UIApplication sharedApplication] delegate] window] addSubview:self];
}

- (void)hideCancelButton
{
    selectButton.frame = CGRectMake(87, (480 - 260)/2 + 260 - 65, 145, 37);
    [selectButton setBackgroundImage:[UIImage imageNamed:@"强制升级.png"] forState:UIControlStateNormal];
    cancelButton.hidden = YES;
    backgroundView.hidden = YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}
@end
