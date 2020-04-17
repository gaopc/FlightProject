//
//  CarQueryDoubleCustomCell.m
//  FlightProject
//
//  Created by longcd on 12-10-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarQueryDoubleCustomCell.h"

@implementation CarQueryDoubleCustomCell
@synthesize _backCityName,_takeCityName;
-(void)dealloc
{
    self._takeCityName = nil;
    self._backCityName = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth - 20, 60) image:[UIImage imageNamed:@"TicketQueryCenter.png"]]];
        
        [self addSubview: [UIImageView ImageViewWithFrame:CGRectMake(25, 10, 23, 35) image:[UIImage imageNamed:@"CityIcon.png"]]];
        [self addSubview: [UISubLabel labelWithTitle:@"取车城市" frame:CGRectMake(50, 0, (ViewWidth - 20-50) / 2, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        [self addSubview: [UISubLabel labelWithTitle:@"还车城市" frame:CGRectMake(50+(ViewWidth - 20-50) / 2, 0, (ViewWidth - 20-50) / 2, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        //buttonWithType:(UIButtonType)buttonType tag:(NSInteger)tag title:(NSString *)title frame:(CGRect)frame backImage:(UIImage*) image target:(id)target action:(SEL)action
        
        self._takeCityName = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(50, 18, (ViewWidth - 20-50) / 2, 40) font:FontBlodSize42 color:FontColor333333 target:nil action:nil];
        self._backCityName = [UIButton buttonWithType:UIButtonTypeCustom tag:3 title:nil frame:CGRectMake(55+(ViewWidth - 20-50) / 2, 18, (ViewWidth - 20-50) / 2-10, 40) font:FontBlodSize42 color:FontColor333333 target:nil action:nil];
        
        [self addSubview:self._takeCityName];
        [self addSubview:self._backCityName];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(50+(ViewWidth - 20-50) / 2, (60-13) / 2, 8, 13) image:[UIImage imageNamed:@"CellArrow.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 40, (60-13) / 2, 8, 13) image:[UIImage imageNamed:@"CellArrow.png"]]];

        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 58, ViewWidth - 40, 1) image:[UIImage imageNamed:@"cabinDottedLine.png"]]];
        
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
