//
//  CarQueryCustomCell.m
//  FlightProject
//
//  Created by longcd on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarQueryCustomCell.h"

@implementation CarQueryCustomCell
@synthesize _imageV,_nameButton,_titleLabel;
-(void)dealloc
{
    self._imageV = nil;
    self._nameButton = nil;
    self._titleLabel = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth - 20, 60) image:[UIImage imageNamed:@"TicketQueryCenter.png"]]];
        
        self._imageV = [UIImageView ImageViewWithFrame:CGRectMake(20, 10, 30, 30) ];
        self._titleLabel = [UISubLabel labelWithTitle:nil frame:CGRectMake(10, 0, ViewWidth - 40, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter];
        
        self._nameButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(50, 18, ViewWidth - 20 - 100, 40) font:FontBlodSize42 color:FontColor000000 target:nil action:nil];
        //[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(50, 18, 200, 40) backImage:nil target:nil action:nil];
        [self addSubview:self._imageV];
        [self addSubview:self._titleLabel];
        [self addSubview:self._nameButton];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 58, ViewWidth - 40, 1) image:[UIImage imageNamed:@"cabinDottedLine.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 40, (60-13) / 2, 8, 13) image:[UIImage imageNamed:@"CellArrow.png"]]];
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
