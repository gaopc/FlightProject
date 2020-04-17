//
//  HotelListCell.h
//  FlightProject
//
//  Created by green kevin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface HotelListCell : UITableViewCell
{
	
	UIImageView *leftImageView;
	UIImageView *rightImageView;

	
}

@property (nonatomic,retain) AsyncImageView *hotelImageView;

@property (nonatomic,retain) UIImageView *lowerImageView;
@property (nonatomic,retain) UIImageView *returnLcdImage;
@property (nonatomic,retain) UISubLabel *lowestPrice;
@property (nonatomic,retain) UISubLabel *returnLcdFee;

@property (nonatomic,retain) UISubLabel *hotelName;
@property (nonatomic,retain) UISubLabel *rating;
@property (nonatomic,retain) UISubLabel *districtName;

@property (nonatomic,retain) UIView * _returnLcdView;
@property (nonatomic,retain) UIView * markValueView;

-(void)drawStarCodeView:(int) markValue;
-(void)drawDiamondCodeView:(int) markValue;


@end

@interface HotelTJListCell : UITableViewCell
{
	UIImageView *leftImageView;
	UIImageView *rightImageView;
}
@property (nonatomic,retain) UISubLabel *title;
@property (nonatomic,retain) UISubLabel *number;
@property (nonatomic,retain) UIImageView *tjImageView;

@end