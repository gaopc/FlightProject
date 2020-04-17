//
//  TicketQueryCell.m
//  FlightProject
//
//  Created by longcd on 12-6-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TicketQueryCell.h"

@implementation TicketQueryCell

@synthesize titleLable,detailLable;
-(void)dealloc
{
    self.titleLable = nil;
    self.detailLable = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.titleLable = [UISubLabel labelWithTitle:@"" frame:CGRectMake(15, 7, 100, 30) font: [UIFont boldSystemFontOfSize:18] alignment:NSTextAlignmentLeft];
        [self addSubview:self.titleLable];
        
        self.detailLable = [UISubLabel labelWithTitle:@"" frame:CGRectMake(100, 7, 200, 30) font: [UIFont systemFontOfSize:18] alignment:NSTextAlignmentLeft];
        [self addSubview:self.detailLable];
    }
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
