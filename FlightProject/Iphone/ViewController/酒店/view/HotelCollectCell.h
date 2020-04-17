//
//  HotelCollectCell.h
//  FlightProject
//
//  Created by z1 on 13-6-26.
//
//

#import <UIKit/UIKit.h>

@interface HotelCollectCell : UITableViewCell

@property (nonatomic,retain) UISubLabel *hotelName;
@property (nonatomic,retain) UISubLabel *rating;
@property (nonatomic,retain) UISubLabel *districtName;

@property (nonatomic,retain) UIView * markValueView;

-(void)drawStarCodeView:(int) markValue;
-(void)drawDiamondCodeView:(int) markValue;

@end
