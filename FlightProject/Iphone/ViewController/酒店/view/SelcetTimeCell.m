//
//  SelcetTimeCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelcetTimeCell.h"

@implementation SelcetTimeCell
@synthesize timeLabel,selectImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 10, 20, 20) image:[UIImage imageNamed:@"FilterSingleUnSelected.png"]]];
        self.selectImageView = [UIImageView ImageViewWithFrame:CGRectMake(20, 10, 20, 20) image:[UIImage imageNamed:@"FilterSingleSelected.png"]];
        self.timeLabel = [UISubLabel labelWithTitle:nil frame:CGRectMake(55, 10, 150, 20) font:FontSize30 color:FontColor3B3B3B alignment:NSTextAlignmentLeft];
        [self addSubview:self.selectImageView];
        [self addSubview:self.timeLabel];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)dealloc
{
    self.timeLabel = nil;
    self.selectImageView = nil;
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
