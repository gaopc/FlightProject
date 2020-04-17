//
//  CheckPersonCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CheckPersonCell.h"

@implementation CheckPersonCell
@synthesize checkPerson,lineImageView;
- (void)dealloc
{
    self.checkPerson = nil;
    self.lineImageView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, 300, 50) image:[UIImage imageNamed:@"中间.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 5, 277, 30) image:[UIImage imageNamed:@"输入框.png"]]];
        self.checkPerson = [UISubLabel labelWithTitle:nil frame:CGRectMake(25, 5, 255, 30) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        [self addSubview:self.checkPerson];
        
        self.lineImageView = [UIImageView ImageViewWithFrame:CGRectMake(20, 49, 277, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]];
        [self addSubview:self.lineImageView];
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
