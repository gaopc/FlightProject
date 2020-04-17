//
//  CarSwitchCell.m
//  FlightProject
//
//  Created by longcd on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarSwitchCell.h"

@implementation CarSwitchCell
@synthesize _switch;
-(void)dealloc
{
    self._switch = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth - 20, 50) image:[UIImage imageNamed:@"TicketQueryCenter.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"同一门店还车" frame:CGRectMake(20, 0, ViewWidth - 40, 50) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        
	CustomUISwitch * aSwitch = [[CustomUISwitch alloc] initWithFrame:CGRectMake(110, 13, 60, 22)];
	self._switch = aSwitch;
	//self._switch.on = YES;
	[self._switch setOn:YES animated:YES];
	[aSwitch release];
	    
//        UISwitch * aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(110, 10, 30, 30)];
//        self._switch = aSwitch;
//        self._switch.on = YES;
//        [aSwitch release];
        
        [self addSubview:self._switch];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 48, ViewWidth - 40, 1) image:[UIImage imageNamed:@"cabinDottedLine.png"]]];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
