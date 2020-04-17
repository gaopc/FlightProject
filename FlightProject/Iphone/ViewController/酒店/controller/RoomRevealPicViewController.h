//
//  RoomRevealPicViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "HotelQueryDataResponse.h"

@interface RoomRevealPicViewController : RootViewController<UIScrollViewDelegate>
{
	

	HotelPicUrl *hotelPicUrl;
	UISubLabel *showNumberLabel;//显示数量Label;
	
	UIImageView *leftArrowsImageView; //左三角背景图片
	UIImageView *rightArrowsImageView;//右三角背景图片
	
	UIButton *leftArrowsButton; //左边点击按钮
	UIButton *rightArrowsButton; //右边点击按钮	
}
@property(nonatomic, retain) NSMutableArray *picUrlArray;
@property(nonatomic, retain) HotelInfo *hotelInfo;
@property (nonatomic, retain)  UIPageControl *pageControl;
@property (nonatomic, retain)  UIScrollView *scrollView;
@property (nonatomic) int currentPage;

@end
