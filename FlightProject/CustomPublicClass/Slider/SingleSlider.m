//
//  SingleSlider.m
//  FlightProject
//
//  Created by green kevin on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SingleSlider.h"
@interface SingleSlider (PrivateMethods)
- (void) configurePromptView;
- (void) configureSliderView;
- (void) configureBottomView;
- (void) initRangeLabel;
@end
@implementation SingleSlider
@synthesize mumValue;
/**
 * 单向滑竿使用说明
 * 传递参数 1图片数组:底部展示的全部图片保存到数组中。
 *         2最小值:底部最左边显示的值。
 *         3最大值:底部最右边显示的值。 
 *	   4图片显示的间隔数:底部图片只要求显示，1 ,3 ,5之间间隔的数字为2 此处填写为2. 如果 0 ,3, 6, 9  之间间隔的数字为3 此处填写为3.
 *         5图片展示的数量:  底部图片要展示的数量。比如底部展示图片要从数组中展示10张图片此处填写为10。  底部展示图片要从数组中展示9张图片此处填写为9
 */

- (id)initWithFrame:(CGRect)frame WithArray:(NSArray *)itemArray withMinimumValue:(float)aminimumValue withMaximumValue:(float)amaximumValue withMinimumRange:(float)aminimumRange withElementNumber:(int)aelementNumber
{
	self = [super initWithFrame:frame];
	if (self) {
		
		if (singleArray) {
			[singleArray release];
		}
		singleArray = [[NSArray alloc] initWithArray:itemArray];
		
		singleSlider = [[UISlider alloc] initWithFrame:CGRectMake(5, 25, 280, 22)];
		
		[self addSubview:singleSlider]; 
		singleSlider.minimumValue = aminimumValue; 
		singleSlider.maximumValue = amaximumValue;
		singleSlider.value = aminimumRange;
		
		elementNumber = aelementNumber;

		[self configurePromptView];
		[self initRangeLabel];
		[self configureSliderView];
		[self configureBottomView];
		
	}
	
	return self;
}

// 初始化提示栏目
- (void) configurePromptView
{
	lowerCue = [UIImageView ImageViewWithFrame:CGRectMake(5, 5, 33, 9)];
	lowerCue.image = [UIImage imageNamed:[NSString stringWithFormat:@"salePrompt_%d.png",(int)singleSlider.minimumValue]];
	[self addSubview:lowerCue];	
}

// 初始化滑竿
- (void) configureSliderView
{
	//折扣滑动栏目
	UIImage *stetchLeftTrack= [UIImage imageNamed:@"bar-background.png"];
	UIImage *stetchRightTrack = [UIImage imageNamed:@"bar-highlight.png"];
	UIImage *thumbImage = [UIImage imageNamed:@"handle-hover.png"];
	
	[singleSlider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
	[singleSlider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
	//注意这里要加UIControlStateHightlighted的状态，否则当拖动滑块时滑块将变成原生的控件
	[singleSlider setThumbImage:thumbImage forState:UIControlStateHighlighted];
	[singleSlider setThumbImage:thumbImage forState:UIControlStateNormal];
	//滑块拖动时的事件
	[singleSlider addTarget:self action:@selector(updateRangeLabel:) forControlEvents:UIControlEventValueChanged];
	//滑动拖动后的事件
	[singleSlider addTarget:self action:@selector(updateRangeLabel:) forControlEvents:UIControlEventTouchUpInside];
	
	[singleSlider release];
}

// 初始化底部栏目
- (void) configureBottomView
{
	long origin_x = 15.0f;
	
	int eNumber =(int)(self.frame.size.width/elementNumber);
	for (int i=0; i<singleArray.count; i++) {
		UIImageView* imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[singleArray objectAtIndex:i]]];
		[imgView setFrame:CGRectMake(origin_x, 55, 33, 9)];
		origin_x+=eNumber;
		[self addSubview:imgView];      
		[imgView release];
	}
	

	
}

//拖动时的事件
-(void)updateRangeLabel:(SingleSlider *)slider{  

	self.mumValue = singleSlider.value;
	//NSInteger v = singleSlider.value+0.5;
	UIImageView *imageView = [singleSlider.subviews objectAtIndex:2];
	CGRect theRect = [self convertRect:imageView.frame fromView:imageView.superview];
	[lowerCue setFrame:CGRectMake(theRect.origin.x, theRect.origin.y-18, lowerCue.frame.size.width, lowerCue.frame.size.height)];
	lowerCue.image = [UIImage imageNamed:[NSString stringWithFormat:@"salePrompt_%d.png",(int)(self.mumValue +0.5)]];
}  


-(void)initRangeLabel{  
	
//	self.mumValue = singleSlider.value;
//	UIImageView *imageView = [singleSlider.subviews objectAtIndex:2];
//	CGRect theRect = [self convertRect:imageView.frame fromView:imageView.superview];
//	[lowerCue setFrame:CGRectMake(theRect.origin.x, theRect.origin.y-18, lowerCue.frame.size.width, lowerCue.frame.size.height)];
//	lowerCue.image = [UIImage imageNamed:[NSString stringWithFormat:@"salePrompt_%d.png",(int)(self.mumValue +0.5)]];
	
	
	self.mumValue = singleSlider.value;
	
	if (singleSlider.subviews.count >0) {
		UIImageView *imageView = [singleSlider.subviews objectAtIndex:2];
		CGRect theRect = [self convertRect:imageView.frame fromView:imageView.superview];
		[lowerCue setFrame:CGRectMake(theRect.origin.x, theRect.origin.y-18, lowerCue.frame.size.width, lowerCue.frame.size.height)];
		lowerCue.image = [UIImage imageNamed:[NSString stringWithFormat:@"salePrompt_%d.png",(int)(self.mumValue +0.5)]];
	}else{
		[lowerCue setFrame:CGRectMake(132, singleSlider.frame.origin.y-14, lowerCue.frame.size.width, lowerCue.frame.size.height)];
		lowerCue.image = [UIImage imageNamed:[NSString stringWithFormat:@"salePrompt_%d.png",(int)(self.mumValue +0.5)]];
		
	}
}

@end
