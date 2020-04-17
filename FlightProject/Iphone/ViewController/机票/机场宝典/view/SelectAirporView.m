//
//  SelectAirporView.m
//  FlightProject
//
//  Created by 月 小 on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectAirporView.h"

@implementation SelectAirporView
@synthesize airportName,delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 7, 300, 56) image:[UIImage imageNamed:@"AKVC-selectAirport.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"机场选择" frame:CGRectMake(30, 13, 50, 12) font:FontSize24 alignment:NSTextAlignmentLeft]];
        self.airportName = [UISubLabel labelWithTitle:@"北京首都国际机场" frame:CGRectMake(30, 28, 200, 20) font:FontSize30 color:FontColor0066CC alignment:NSTextAlignmentLeft];
        [self addSubview:self.airportName];
        [self addSubview:[UIButton buttonWithTag:99 frame:CGRectMake(10, 7, 300, 56) target:self action:@selector(selectAirport:)]];
    }
    return self;
}

-(void)selectAirport:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectAirport:)]) {
        [self.delegate performSelector:@selector(selectAirport:) withObject:sender];
    }
}

- (void)dealloc
{
    self.airportName = nil;
    delegate = nil;
    [super dealloc];
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
