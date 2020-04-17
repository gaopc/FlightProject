//
//  SingleSlider.h
//  FlightProject
//
//  Created by green kevin on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleSlider : UIControl
{
    UISlider *singleSlider;//单滑动栏
    UIImageView * _minThumb; //左滑动按钮
    UIImageView * _maxThumb; //右滑动按钮
    UIImageView * _track;     //滑动后背景
    UIImageView * _trackBackground; //默认背景

    float mumValue; //选中值
	
    NSArray* singleArray; //折扣段数组
    UIImageView *lowerCue;  //左滑动提示栏图片
    UIImageView *upperCue;  //右滑动提示栏图片
    int intervalNumber;     //底部展示图片的间隔数
    int elementNumber;      //底部展示图片的数量
}

@property(nonatomic) float mumValue;

- (id)initWithFrame:(CGRect)frame WithArray:(NSArray *)itemArray withMinimumValue:(float)aminimumValue withMaximumValue:(float)amaximumValue withMinimumRange:(float)aminimumRange withElementNumber:(int)aelementNumber;

@end
