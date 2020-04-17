//
//  LoadingView.m
//  FlightProject
//
//  Created by admin on 12-11-7.
//
//

#import "LoadingView.h"

@implementation LoadingView
@synthesize _cancelButton, _titleLab;
@synthesize imageIndex;
@synthesize loadImgView;
@synthesize timer;
- (void)dealloc
{
    self._cancelButton = nil;
    self._titleLab = nil;
    self.loadImgView = nil;
    self.timer = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, 297, 120) image:[UIImage imageNamed:@"loading背景.png"]]];
        
        self._titleLab = [UISubLabel labelWithTitle:@"请稍等，正在为您加载..." frame:CGRectMake(90, 0, 170, 120) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft ];
        
        self._cancelButton = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"loading关闭.png"] frame:CGRectMake(250, 7, 30, 30) target:nil action:nil];
        self._cancelButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
        
        loadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 30, 52, 52)];
        loadImgView.image = [UIImage imageNamed:@"载入0.png"];
        imageIndex = 1;
//        NSMutableArray *imgArray = [NSMutableArray array];
//        for (int i = 0; i < 10; i ++) {
//            [imgArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"载入%d.png", i]]];
//        }
//        loadImgView.animationImages = imgArray;
//        [loadImgView setImage:[UIImage imageNamed:@"载入9.png"]];
//        
//        loadImgView.animationDuration=3.0;
//        loadImgView.animationRepeatCount=10;
//        [loadImgView startAnimating];
        
        [self addSubview:loadImgView];
        [self addSubview:self._cancelButton];
        [self addSubview:self._titleLab];
        [loadImgView release];
        self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(replaceImage) userInfo:nil repeats:YES];
    }
    return self;

}
-(void) replaceImage
{
    loadImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"载入%d.png", imageIndex++]];
    if (imageIndex == 24) {
        imageIndex = 0;
    }
}
@end
