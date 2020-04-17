//
//  OrderPointView.m
//  FlightProject
//
//  Created by admin on 12-11-7.
//
//

#import "OrderPointView.h"

@implementation OrderPointView
@synthesize _pointLab;

- (void)dealloc
{
    self._pointLab = nil;
    [super dealloc];
}

+(OrderPointView *)shardOrderPointView:( CGRect ) frame
{
    static OrderPointView * orderPoint = nil;
    if (orderPoint == nil) {
        orderPoint = [[OrderPointView alloc] initWithFrame:frame];
    }
    return orderPoint;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, 15, 15) image:[UIImage imageNamed:@"HomeMessageNum.png"]]];
        
        self._pointLab = [UISubLabel labelWithTitle:@"0" frame:CGRectMake(0, 0, 15, 15) font:FontSize20 color:FontColor454545 alignment:NSTextAlignmentCenter];
        [self addSubview:self._pointLab];
    }
    return self;
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
