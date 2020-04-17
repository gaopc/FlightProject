//
//  StationsViewCell.m
//  FlightProject
//
//  Created by 小月 on 13-1-7.
//
//

#import "StationsViewCell.h"

@implementation StationsViewCell
@synthesize startStationButton,endStationButton,stationsChange;

- (void)dealloc
{
    self.startStationButton = nil;
    self.endStationButton = nil;
    self.stationsChange = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth-20, 130) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 120, ViewWidth-20, 18) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"出发" frame:CGRectMake(18, 3, ViewWidth-35, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-40, 25, 8, 14) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(70, 60, ViewWidth-100, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"到达" frame:CGRectMake(18, 63, ViewWidth-35, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        
        self.stationsChange = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"trainChange.png"] frame:CGRectMake(15, 20, 53, 71) target:nil action:nil];//53，71
        [self addSubview:stationsChange];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-40, 85, 8, 14) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
        
        self.startStationButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(70, 18, ViewWidth-130, 40) backImage:nil target:self action:nil];
        [self.startStationButton.titleLabel setFont:FontBlodSize48];
        self.endStationButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(70, 78, ViewWidth-130, 40) backImage:nil target:self action:nil];
        [self.endStationButton.titleLabel setFont:FontBlodSize48];
        [self addSubview:self.startStationButton];
        [self addSubview:self.endStationButton];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
