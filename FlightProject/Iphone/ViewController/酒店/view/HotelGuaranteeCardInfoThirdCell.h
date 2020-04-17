//
//  HotelGuaranteeCardInfoThirdCell.h
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelGuaranteeCardInfoThirdCell : UITableViewCell
@property(nonatomic,retain)UISubLabel *personName;
@property(nonatomic,retain)UISubLabel *bankName;
@property(nonatomic,retain)UISubLabel *cardNum;
@property(nonatomic,retain)UISubLabel *cardNumLast;//卡号后四位
@property(nonatomic,retain)UISubTextField *validityDateTextField;
@property(nonatomic,retain)UISubTextField *cvvNumTextField;
@property(nonatomic,retain)UIImageView *bankIcon;
@end
