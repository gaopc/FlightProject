//
//  RangeSlider.h
//  RangeSlider
//  Created by 崔立东 on 9/23/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoubleSlider : UIControl{
    float minimumValue; //最小值
    float maximumValue; //最大值
    float minimumRange; //两个按钮间的最小间隔
    float selectedMinimumValue;//选中最小值
    float selectedMaximumValue;//选中最大值
    float mindistanceFromCenter; 
    float maxdistanceFromCenter;
	
    float _padding;
    
    BOOL _maxThumbOn;
    BOOL _minThumbOn;
     
    UIImageView * _minThumb; //左滑动按钮
    UIImageView * _maxThumb; //右滑动按钮
    UIImageView * _track;     //滑动后背景
    UIImageView * _trackBackground; //默认背景
    
    NSArray* timePeriodArray; //时间段数组
    UIImageView *lowerCue;  //左滑动提示栏图片
    UIImageView *upperCue;  //右滑动提示栏图片
    int intervalNumber;     //底部展示图片的间隔数
    int elementNumber;      //底部展示图片的数量

    CGPoint startPoint;
    
}

@property(nonatomic) float minimumValue;
@property(nonatomic) float maximumValue;
@property(nonatomic) float minimumRange;
@property(nonatomic) float selectedMinimumValue;
@property(nonatomic) float selectedMaximumValue;

- (id)initWithFrame:(CGRect)frame WithArray:(NSArray *)itemArray withMinimumValue:(float)aminimumValue withMaximumValue:(float)amaximumValue withMinimumRange:(float)aminimumRange withIntervalNumber:(int)aintervalNumber withElementNumber:(int)aelementNumber;
@end
