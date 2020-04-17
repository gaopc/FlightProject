//
//  HotelGuaranteeCardInfoSecondCell.h
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelGuaranteeCardInfoSecondCell : UITableViewCell
@property(nonatomic,retain)UISubLabel *personName;
@property(nonatomic,retain)UISubLabel *bankName;
@property(nonatomic,retain)UISubLabel *cardNum;
@property(nonatomic,retain)UISubLabel *cvvNum;
@property(nonatomic,retain)UISubLabel *validityDate;
@property(nonatomic,retain)UIImageView *bankIcon;
@property(nonatomic,retain)UIButton *editCardInfo;
@end
