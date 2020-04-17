//
//  WaitView.h
//  TestProject
//
//  Created by  on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/* 本类用于显示等待页面 */
#import <UIKit/UIKit.h>
#import "LoadingView.h"

@protocol WaitViewDelegate;

@interface WaitView : UIView
{
    UIActivityIndicatorView * activityIV;
    UIView * aView;
    
}
@property(nonatomic,assign) id <WaitViewDelegate> delegate;
@property(nonatomic,retain) LoadingView *loadingView;
+(WaitView *)shareWaitView;
-(void)showWaitView;
-(void)hiddenWaitView;
-(void)cancelConnection;
- (void)hiddenLoadingButton:(BOOL)state;
@end

@protocol WaitViewDelegate <NSObject>
-(void)cancelRequst;
@end