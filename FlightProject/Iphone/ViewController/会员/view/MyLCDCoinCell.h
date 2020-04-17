//
//  MyLCDCoinCell.h
//  FlightProject
//
//  Created by lidong  cui on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLCDCoinCell : UITableViewCell


@property (nonatomic, retain) UIImageView *lcdBgView; 
@property (nonatomic, retain) UISubLabel *typeLabel;
@property (nonatomic, retain) UISubLabel *content;
@property (nonatomic, retain) UISubLabel *amountFlagLabel;
@property (nonatomic, retain) UISubLabel *amountLabel;
@property (nonatomic, retain) UISubLabel *dateLabel;


@end
