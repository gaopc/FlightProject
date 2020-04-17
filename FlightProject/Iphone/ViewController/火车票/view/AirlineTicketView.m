//
//  AirlineTicketView.m
//  FlightProject
//
//  Created by z1 on 13-3-28.
//
//

#import "AirlineTicketView.h"

@implementation AirlineTicketView
@synthesize clickButton,cellPrice, cellCities,cellClick;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
	    self.clickButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(0, 0, ViewWidth, 41) backImage:[UIImage imageNamed:@"ticketReCommentTop.png"] target:nil action:nil];
	    [self addSubview:self.clickButton];
	    self.cellCities = [UISubLabel labelWithTitle:@"" frame:CGRectMake(0, 0, ViewWidth-210, 35) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
	    self.cellPrice = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-210, 0, ViewWidth-175, 35) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
	    self.cellClick = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-65,0, ViewWidth-260, 35) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
	    [self addSubview:self.cellPrice];
	    [self addSubview:self.cellCities];
	    [self addSubview:self.cellClick];
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

- (void)dealloc
{
	self.clickButton = nil;
	self.cellCities = nil;
	self.cellPrice = nil;
	self.cellClick = nil;
	[super dealloc];
}
@end
