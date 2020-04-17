//
//  RoomCommCell.m
//  FlightProject
//
//  Created by green kevin on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelCommCell.h"

@implementation HotelCommCell
@synthesize name,time,evaluate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
	    
	    [self.contentView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 5, ViewWidth-20, 100) image:[UIImage imageNamed:@"cabinListCell.png"]]];
	   
	    self.evaluate = [UISubLabel labelWithTitle:@"" frame:CGRectMake(20.0f, 5, 280.0f, 65) font: FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft ];
	    self.evaluate.lineBreakMode = UILineBreakModeTailTruncation;
	    self.evaluate.numberOfLines = 0;
	    [self addSubview:self.evaluate];
	    
	    UIImageView *lineImageView=[UIImageView ImageViewWithFrame:CGRectMake(20.0f, 70.0f, ViewWidth-40, 1.0f)];
	    lineImageView.image=[UIImage imageNamed:@"TicketQueryDottedLine.png"];
	    [self.contentView addSubview:lineImageView];
	    // 名字
	    self.name = [UISubLabel labelWithTitle:@"" frame:CGRectMake(20, 75, 160, 20) font:FontSize24 color:FontColor454545  alignment:NSTextAlignmentLeft];
	    [self.contentView addSubview:self.name];
	    
	    // 时间
	    self.time = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-135, 75, 140, 20) font:FontSize24 color:FontColor454545  alignment:NSTextAlignmentLeft];
	    [self.contentView addSubview:self.time];
	    
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) dealloc {
	
        self.name = nil;
	self.time = nil;
	self.evaluate = nil;
	[super dealloc];	
}

@end
