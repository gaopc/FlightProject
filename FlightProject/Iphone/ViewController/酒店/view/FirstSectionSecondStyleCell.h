//
//  FirstSectionSecondStyleCell.h
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AsyncImageView;
@interface FirstSectionSecondStyleCell : UITableViewCell
@property(nonatomic,retain)UISubLabel *checkInDate;
@property(nonatomic,retain)UISubLabel *checkOutDate;
@property(nonatomic,retain)UISubLabel *hotelName;
@property(nonatomic,retain)UISubLabel *singlePrice;
@property(nonatomic,retain)UISubLabel *reviews;//点评
@property(nonatomic,retain)UISubLabel *districtName;//商圈
@property(nonatomic,retain)UISubLabel *returnLcdFee;//返回畅达币
@property(nonatomic,retain)AsyncImageView  *smallPicture;//小图

@property (nonatomic,retain) UIView * _returnLcdView;

-(void)setStartsCount:(NSInteger)count;
-(void)setDiamondCount:(NSInteger)count;
@end
