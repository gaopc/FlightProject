//
//  RoomPicViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface RoomPicViewController : RootViewController<UIScrollViewDelegate>
{
	AsyncImageView *hotelImageView;
	UIImageView *picImg;
	UIButton *picButton;
	
	
}


@property(nonatomic, retain) NSMutableArray *picUrlArray;
@property(nonatomic, retain) HotelInfo *hotelInfo;
@property(nonatomic, retain) UIPageControl *pageControl;
@property(nonatomic, retain) UIScrollView *scrollView;
@end
