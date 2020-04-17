//
//  HotelGuaranteeCardInfoFirstCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelGuaranteeCardInfoFirstCell.h"

@implementation HotelGuaranteeCardInfoFirstCell
@synthesize addCreditCard;
- (void)dealloc
{
    self.addCreditCard = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier //height:(int)height
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
         [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 170) image:[UIImage imageNamed:@"中间.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 170, ViewWidth - 20, 7) image:[UIImage imageNamed:@"尾.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(18, 20, ViewWidth - 36, 45) image:[UIImage imageNamed:@"其他支付.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"新增信用卡" frame:CGRectMake(25, 20, ViewWidth - 20, 45) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        
        self.addCreditCard = [UIButton customButtonTitle:nil image:nil frame:CGRectMake(18, 22, ViewWidth - 36, 45) target:nil action:nil];
        [self addSubview:self.addCreditCard];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 80, ViewWidth - 40, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
