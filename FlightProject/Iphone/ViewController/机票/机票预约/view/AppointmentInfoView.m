//
//  AppointmentInfoView.m
//  FlightProject
//
//  Created by green kevin on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppointmentInfoView.h"

@implementation AppointmentInfoView
@synthesize flightLabel,arriveLabel,flightDateLabel,arriveDateLabel,saleLabel,submitDateLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
	    long origin_x = 10.0f;
	    long origin_y = 5.0f;
	    
	    flightSmallIcons=[UIImageView ImageViewWithFrame:CGRectMake(origin_x, origin_y+7.0f, 11.0f, 12.0f)];
	    flightSmallIcons.image=[UIImage imageNamed:@"flightSmallIcon.png"];
	    [self addSubview:flightSmallIcons];
	    
	    origin_x+= flightSmallIcons.frame.size.width+5.0f;
	    
	    self.flightLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, origin_y, 80.0f, 25.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
	    self.flightLabel.textColor = FontColor333333;
	    [self addSubview:self.flightLabel];
	    
	    origin_x+= flightLabel.frame.size.width;
	    
	    self.flightDateLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, origin_y, 70.0f, 25.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
        self.flightDateLabel.adjustsFontSizeToFitWidth = YES;
	    self.flightDateLabel.textColor = FontColor333333;
	    [self addSubview:self.flightDateLabel];
	    
	    origin_x+= flightDateLabel.frame.size.width+12.0f;
	    
	    
	    
	    self.saleLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, origin_y, 16.0f, 35.0f) font:FontBlodSize56 alignment:NSTextAlignmentLeft];
	    self.saleLabel.textColor = FontColor1C7CBC;
	    [self addSubview:self.saleLabel];
	    
	    origin_x+= saleLabel.frame.size.width+1.0f;
	    
	    origin_y+=14.0f;
	    
	    UISubLabel *font1Label = [UISubLabel labelWithTitle:@"折" frame:CGRectMake(origin_x, origin_y+2.0f, 12.0f, 15.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	    font1Label.textColor = FontColor1C7CBC;
	    [self addSubview:font1Label];
	    
	    origin_x+= font1Label.frame.size.width+10.0f;
	    
	    self.submitDateLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, origin_y, 70.0f, 15.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
        self.submitDateLabel.adjustsFontSizeToFitWidth = YES;
	    self.submitDateLabel.textColor = FontColor333333;
	    [self addSubview:self.submitDateLabel];
	    
	    
	    origin_x = 10.0f;
	    origin_y = 8.0f;
	    origin_y+= flightSmallIcons.frame.size.height+5.0f;
	    
	    arriveSmallIcons=[UIImageView ImageViewWithFrame:CGRectMake(origin_x, origin_y+7.0f, 11.0f, 12.0f)];
	    arriveSmallIcons.image=[UIImage imageNamed:@"arriveSmallIcon.png"];
	    [self addSubview:arriveSmallIcons];
	    
	    origin_x+= arriveSmallIcons.frame.size.width+5.0f;
	    
	    self.arriveLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, origin_y, 80.0f, 25.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
	    self.arriveLabel.textColor = FontColor333333;
	    [self addSubview:self.arriveLabel];
	    
	    origin_x+= flightLabel.frame.size.width;
	    
	    self.arriveDateLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(origin_x, origin_y, 70.0f, 25.0f) font:FontSize24 alignment:NSTextAlignmentLeft];
        self.arriveDateLabel.adjustsFontSizeToFitWidth = YES;
	    self.arriveDateLabel.textColor = FontColor333333;
	    [self addSubview:self.arriveDateLabel];
    }
    return self;
}

- (void) dealloc {
	
	self.flightLabel = nil;
	self.arriveLabel = nil;
	self.flightDateLabel = nil;
	self.arriveDateLabel = nil;
	self.saleLabel = nil;
	self.submitDateLabel = nil;
	
	[super dealloc];
}


@end
