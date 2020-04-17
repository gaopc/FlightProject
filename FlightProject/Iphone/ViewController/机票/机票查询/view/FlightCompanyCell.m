//
//  FlightCompanyCell.m
//  FlightProject
//
//  Created by longcd on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlightCompanyCell.h"

@implementation FlightCompanyCell
@synthesize imageV,airlineName,airlineTelephone;
-(void)dealloc
{
    self.imageV = nil;
    self.airlineName = nil;
    self.airlineTelephone = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imageV = [UIImageView ImageViewWithFrame:CGRectMake(10, 2, 40, 40)];
        [self addSubview:self.imageV];
        
        self.airlineName = [UISubLabel labelWithTitle:@"" frame:CGRectMake(60, 0, 270, 30) font: [UIFont systemFontOfSize:16] alignment:NSTextAlignmentLeft];
        [self addSubview:self.airlineName];
        
        UISubLabel * telephoneLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(60, 30, 270, 10) font:[UIFont systemFontOfSize:13] alignment:NSTextAlignmentLeft];
        telephoneLabel.textColor = [UIColor grayColor];
        self.airlineTelephone = telephoneLabel;
        [self addSubview:self.airlineTelephone];
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
