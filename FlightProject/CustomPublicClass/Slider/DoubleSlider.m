//
//  RangeSlider.m
//  RangeSlider
//
//  Created by 崔立东 on 9/23/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//  双向滑竿
//

#import "DoubleSlider.h"
#define  Edge_Distance (25*self.bounds.size.width/300 )

@interface DoubleSlider (PrivateMethods)
-(float)xForValue:(float)value;
-(float)valueForX:(float)x;
-(void)updateTrackHighlight;
- (void) configurePromptView;
- (void) configureSliderView;
- (void) configureBottomView;

@end

@implementation DoubleSlider

@synthesize minimumValue, maximumValue, minimumRange, selectedMinimumValue, selectedMaximumValue;

/**
 * 双向滑竿使用说明
 * 传递参数 1图片数组:底部展示的全部图片保存到数组中。
 *         2最小值:底部最左边显示的值。
 *         3最大值:底部最右边显示的值。 
 *	   4图片显示的间隔数:底部图片只要求显示，1 ,3 ,5之间间隔的数字为2 此处填写为2. 如果 0 ,3, 6, 9  之间间隔的数字为3 此处填写为3.
 *         5图片展示的数量:  底部图片要展示的数量。比如底部展示图片要从数组中展示10张图片此处填写为10。  底部展示图片要从数组中展示9张图片此处填写为9
 */

- (id)initWithFrame:(CGRect)frame WithArray:(NSArray *)itemArray withMinimumValue:(float)aminimumValue withMaximumValue:(float)amaximumValue withMinimumRange:(float)aminimumRange withIntervalNumber:(int)aintervalNumber withElementNumber:(int)aelementNumber
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (timePeriodArray) {
			[timePeriodArray release];
		}
		timePeriodArray = [[NSArray alloc] initWithArray:itemArray];
        minimumValue = aminimumValue; 
        maximumValue = amaximumValue;
        minimumRange = aminimumRange;
        selectedMinimumValue = aminimumValue;
        selectedMaximumValue = amaximumValue;
        intervalNumber = aintervalNumber;
        elementNumber = aelementNumber;
	    
        [self configureSliderView];
        [self configurePromptView];
        [self configureBottomView];
      
    }
    
    return self;
}



- (void)dealloc 
{
	[timePeriodArray release];
    timePeriodArray = nil;
	[super dealloc];
}

// 初始化提示栏目
- (void) configurePromptView
{
    lowerCue = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 28.5*self.frame.size.width/300, 12*self.frame.size.height/75)];
    lowerCue.image = [UIImage imageNamed:[NSString stringWithFormat:@"prompt_%d.png",(int)minimumValue]];
    [self addSubview:lowerCue];
    upperCue = [UIImageView ImageViewWithFrame:CGRectMake(self.frame.size.width-28.5*self.frame.size.width/300, 0, 28.5*self.frame.size.width/300, 12*self.frame.size.height/75)];
    upperCue.image = [UIImage imageNamed:[NSString stringWithFormat:@"prompt_%d.png", (int)maximumValue]];
    [self addSubview:upperCue];
    
}

// 初始化滑竿
- (void) configureSliderView
{
    _minThumbOn = false;
    _maxThumbOn = false;
    _padding = 0;
    
    _trackBackground = [UIImageView ImageViewWithFrame:CGRectMake(5, 0, self.bounds.size.width-5, 11) image:[UIImage imageNamed:@"bar-background.png"]];
    _trackBackground.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    [self addSubview:_trackBackground];
    
    _track =[UIImageView ImageViewWithFrame:CGRectMake(5, 0, self.bounds.size.width-5, 11) image:[UIImage imageNamed:@"bar-highlight.png"]];
    _track.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    [self addSubview:_track];
    
    _minThumb = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"handle-hover.png"] highlightedImage:[UIImage imageNamed:@"handle-hover.png"]] autorelease];
    _minThumb.frame = CGRectMake(0,0, 50*self.bounds.size.width/300, 50*self.bounds.size.height/75);
    _minThumb.contentMode = UIViewContentModeCenter;
    [self addSubview:_minThumb];
    
    _maxThumb = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"handle-hover.png"] highlightedImage:[UIImage imageNamed:@"handle-hover.png"]] autorelease];
    _maxThumb.frame = CGRectMake(0,0, 50*self.bounds.size.width/300,50*self.bounds.size.height/75);
    _maxThumb.contentMode = UIViewContentModeCenter;
    [self addSubview:_maxThumb];
    
	[self addTarget:self action:@selector(updateRangeLabel:) forControlEvents:UIControlEventValueChanged];
	[self addTarget:self action:@selector(updateRangeLabel:) forControlEvents:UIControlEventTouchUpInside];
    

}

// 初始化底部栏目
- (void) configureBottomView
{
    float origin_x = 0.0f;
    int i=0;
    float bottom_distance =(self.frame.size.width - 23*self.frame.size.width/300)/(elementNumber-1);
    
    for (i=(int)minimumValue; i<=timePeriodArray.count; i=i+intervalNumber) {
        UIImageView* imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[timePeriodArray objectAtIndex:i]]];
        [imgView setFrame:CGRectMake(origin_x, self.frame.size.height -10*self.frame.size.height/75  , 23*self.frame.size.width/300, 10*self.frame.size.height/75)];
        origin_x+=bottom_distance;
        [self addSubview:imgView];      //self.center.y+_minThumb.frame.size.height/2.0
        [imgView release];
    }
    
}


-(void)layoutSubviews
{
    // Set the initial state
    _minThumb.center = CGPointMake([self xForValue:selectedMinimumValue], self.bounds.size.height/2);
    
    _maxThumb.center = CGPointMake([self xForValue:selectedMaximumValue], self.bounds.size.height/2);
    
    [self updateTrackHighlight];
    
    
}


//滑动事件
-(void)updateRangeLabel:(DoubleSlider *)slider{
	
	CGPoint lowerCenter = lowerCue.center;
	lowerCenter.x = (_minThumb.center.x + self.bounds.origin.x);
	lowerCue.center = lowerCenter;
	lowerCue.image = [UIImage imageNamed:[NSString stringWithFormat:@"prompt_%d.png",(int)(self.selectedMinimumValue+ 0.5f)]];
	
	CGPoint upperCenter = upperCue.center;
	upperCenter.x = (_maxThumb.center.x + self.bounds.origin.x);
	upperCue.center = upperCenter;
	upperCue.image = [UIImage imageNamed:[NSString stringWithFormat:@"prompt_%d.png",(int)(self.selectedMaximumValue+ 0.5f)]];
	
}

-(float)xForValue:(float)value{
    return (self.frame.size.width-( Edge_Distance))*((value - minimumValue) / (maximumValue - minimumValue))+Edge_Distance/2;
}

-(float) valueForX:(float)x{
    return minimumValue + (x-Edge_Distance/2) / (self.frame.size.width-(Edge_Distance)) * (maximumValue - minimumValue);
    //return minimumValue + (x-Edge_Distance) / (self.frame.size.width-(Edge_Distance*2)) * (maximumValue - minimumValue);
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    if(!_minThumbOn && !_maxThumbOn){
        return YES;
    }

    CGPoint touchPoint = [touch locationInView:self];
    float dx = DX(touchPoint, startPoint);
    float dy = DY(touchPoint, startPoint);

    if ((dx > SWIPE_DRAG_MIN) && (ABS(dy) < DRAGLIMIT_MAX)){ // hswipe left 
	    if ((selectedMaximumValue-selectedMinimumValue)==minimumRange) {
		    _minThumbOn = true;
	    } 
    }else if((dx > SWIPE_DRAG_MIN) && (ABS(dy) > DRAGLIMIT_MAX)){
	    if ((selectedMaximumValue-selectedMinimumValue)==minimumRange) {
		    _minThumbOn = true;
	    } 
    }else if ((-dx > SWIPE_DRAG_MIN) && (ABS(dy) < DRAGLIMIT_MAX)){ // hswipe right
	    if ((selectedMaximumValue-selectedMinimumValue)==minimumRange) {
		    _maxThumbOn = true;
	    }  
    }else if ((-dx > SWIPE_DRAG_MIN) && (ABS(dy) > DRAGLIMIT_MAX)){ // hswipe right
	    
	    if ((selectedMaximumValue-selectedMinimumValue)==minimumRange) {
		    _maxThumbOn = true;
	    }  
		
    }	
	
	
    if(_minThumbOn){
        _minThumb.center = CGPointMake(MAX([self xForValue:minimumValue],
					   MIN(touchPoint.x - mindistanceFromCenter, 
					       [self xForValue:selectedMaximumValue - minimumRange])), _minThumb.center.y);
        
	    selectedMinimumValue = [self valueForX:_minThumb.center.x];
        
    }
    if(_maxThumbOn){
        _maxThumb.center = CGPointMake(MIN([self xForValue:maximumValue], MAX(touchPoint.x - maxdistanceFromCenter, [self xForValue:selectedMinimumValue + minimumRange])), _maxThumb.center.y);
        
	    selectedMaximumValue = [self valueForX:_maxThumb.center.x]  ;
    }
    [self updateTrackHighlight];
    [self setNeedsLayout];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

-(BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    //CGPoint touchPoint = [touch locationInView:self];
    startPoint = [touch locationInView:self];
    
    if(CGRectContainsPoint(_minThumb.frame, startPoint)){
	    
        _minThumbOn = true;
        mindistanceFromCenter = startPoint.x - _minThumb.center.x;

    }
    else if(CGRectContainsPoint(_maxThumb.frame, startPoint)){
        _maxThumbOn = true;
        maxdistanceFromCenter = startPoint.x - _maxThumb.center.x;

    }
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    _minThumbOn = false;
    _maxThumbOn = false;
}

-(void)updateTrackHighlight{
	_track.frame = CGRectMake(
                              _minThumb.center.x,
                              _track.center.y - (_track.frame.size.height/2),
                              _maxThumb.center.x - _minThumb.center.x,
                              _track.frame.size.height
                              );
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
