//
//  CreditCardCell.h
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditCardCell : UITableViewCell
@property(nonatomic,retain)UIImageView *selectImageView;
@property(nonatomic,retain)UIImageView *unSelectImageView;
@property(nonatomic,retain)UISubLabel *userName;
@property(nonatomic,retain)UISubLabel *cardNum;
@property(nonatomic,retain)UISubLabel *bankName;
@property (nonatomic, retain) UIButton *_editBut;
@end
