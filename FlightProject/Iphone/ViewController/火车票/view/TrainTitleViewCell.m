//
//  TrainTitleViewCell.m
//  FlightProject
//
//  Created by 小月 on 13-1-7.
//
//

#import "TrainTitleViewCell.h"

@implementation TrainTitleViewCell

@synthesize titleBackGround,stationsButton,trainNumberButton;
- (void)dealloc
{
    self.titleBackGround = nil;
    self.stationsButton = nil;
    self.trainNumberButton = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.titleBackGround = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth-20, 60) image:nil];
        self.stationsButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 0, (ViewWidth-20/2), 50) backImage:nil target:self action:nil];
        self.trainNumberButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(160, 0, (ViewWidth-20/2), 50) backImage:nil target:self action:nil];
        [self addSubview:self.titleBackGround];
        [self addSubview:self.stationsButton];
        [self addSubview:self.trainNumberButton];
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
