//
//  FirstSectionSecondStyleCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstSectionSecondStyleCell.h"
#import "AsyncImageView.h"

@implementation FirstSectionSecondStyleCell
@synthesize checkInDate,checkOutDate,hotelName,singlePrice,reviews,districtName,returnLcdFee,smallPicture;
@synthesize _returnLcdView;
- (void)dealloc
{
    self.checkInDate = nil;
    self.checkOutDate = nil;
    self.hotelName = nil;
    self.singlePrice = nil;
    self.reviews = nil;
    self.districtName = nil;
    self.returnLcdFee = nil;
    self.smallPicture = nil;
    self._returnLcdView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 3, ViewWidth-20, 80) image:[UIImage imageNamed:@"酒店订单拐弯图.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"入住:" frame:CGRectMake(15, 13, 50, 15) font:FontSize24 color:FontColor2685CF alignment:NSTextAlignmentLeft]];
        self.checkInDate = [UISubLabel labelWithTitle:nil frame:CGRectMake(45,13,75,15) font:FontSize24 color:FontColor2685CF alignment:NSTextAlignmentLeft];
        [self addSubview:self.checkInDate];
        [self addSubview:[UISubLabel labelWithTitle:@"离店:" frame:CGRectMake(127, 13, 50, 15) font:FontSize24 color:FontColor2685CF alignment:NSTextAlignmentLeft]];
        self.checkOutDate = [UISubLabel labelWithTitle:nil frame:CGRectMake(157,13,75,15) font:FontSize24 color:FontColor2685CF alignment:NSTextAlignmentLeft];
        [self addSubview:self.checkOutDate];
        
        self.hotelName = [UISubLabel labelWithTitle:nil frame:CGRectMake(25, 37, 145, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        [self addSubview:self.hotelName];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-153, 45, 6, 7) image:[UIImage imageNamed:@"cabinListRMB.png"]]];
        self.singlePrice = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth-145,27,60,30) font:FontBlodSize48 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        [self addSubview:self.singlePrice];
        
        [self addSubview:[UISubLabel labelWithTitle:@"点评：" frame:CGRectMake(25,65,40,15) font:FontSize24 color:FontColor767676 alignment:NSTextAlignmentLeft]];
        self.reviews = [UISubLabel labelWithTitle:nil frame:CGRectMake(55,65,20,15) font:FontSize24 color:FontColor767676 alignment:NSTextAlignmentLeft];
        [self addSubview:self.reviews];
        
        self.districtName = [UISubLabel labelWithTitle:nil frame:CGRectMake(100,65,80,15) font:FontSize24 color:FontColor767676 alignment:NSTextAlignmentCenter];
        [self addSubview:self.districtName];
        
        UIView * _view = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth-148, 65, 75, 15)];
        self._returnLcdView = _view;
        [_view release];
        
        self.returnLcdFee = [UISubLabel labelWithTitle:nil frame:CGRectMake(0,0,45,15) font:FontSize24 color:FontColorFF8813 alignment:NSTextAlignmentRight];
        [self._returnLcdView addSubview:self.returnLcdFee];
        [self._returnLcdView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(45,0,15,15) image:[UIImage imageNamed:@"DollarIcon.png"]]];
        
        AsyncImageView *asyncImageView = [[AsyncImageView alloc]initWithFrame:CGRectMake(ViewWidth-85.5, 6.5, 71, 71)];
        self.smallPicture = asyncImageView;
        [asyncImageView release];
        self.smallPicture.defaultImage = 1;
        [self addSubview:self.smallPicture];
        [self addSubview:self._returnLcdView];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

-(void)setStartsCount:(NSInteger)count
{
    for (int i=0; i<count; i++) {
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10*i+25, 83, 10, 10) image:[UIImage imageNamed:@"star_green.png"]]];
    }
    for (int j=count; j<5; j++) {
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10*j+25, 83, 10, 10) image:[UIImage imageNamed:@"Star_Gray.png"]]];
    }
}

-(void)setDiamondCount:(NSInteger)count
{
	for (int i=0; i<count; i++) {
		[self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(11*i+25, 84, 10, 9) image:[UIImage imageNamed:@"Diamond_Golden.png"]]];
	}
	for (int j=count; j<5; j++) {
		[self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(11*j+25, 84, 10, 9) image:[UIImage imageNamed:@"Diamond_Gray.png"]]];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
