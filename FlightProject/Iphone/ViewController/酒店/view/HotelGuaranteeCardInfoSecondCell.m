//
//  HotelGuaranteeCardInfoSecondCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelGuaranteeCardInfoSecondCell.h"

@implementation HotelGuaranteeCardInfoSecondCell
@synthesize personName,bankIcon,bankName,cardNum,cvvNum,validityDate,editCardInfo;

- (void)dealloc
{
    self.personName = nil;
    self.bankName = nil;
    self.bankIcon = nil;
    self.cardNum = nil;
    self.cvvNum = nil;
    self.validityDate = nil;
    self.editCardInfo = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 170) image:[UIImage imageNamed:@"中间.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 170, ViewWidth - 20, 12) image:[UIImage imageNamed:@"尾.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 0, ViewWidth - 40, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 115, ViewWidth - 40, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        self.personName = [UISubLabel labelWithTitle:nil frame:CGRectMake(25, 10, 150, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.bankIcon = [UIImageView ImageViewWithFrame:CGRectMake(160, 10, 20, 20) image:[UIImage imageNamed:@""]];
        self.bankName = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 120, 10, 65, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentRight];
        [self addSubview:self.personName];
        [self addSubview:self.bankIcon];
        [self addSubview:self.bankName];
        
        [self addSubview:[UISubLabel labelWithTitle:@"卡号:" frame:CGRectMake(25, 42, 50, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        self.cardNum = [UISubLabel labelWithTitle:nil frame:CGRectMake(80, 42, 195, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.editCardInfo = [UIButton customButtonTitle:nil image:nil frame:CGRectMake(10, 0, ViewWidth - 20, 115) target:nil action:nil];
//        self.editCardInfo.backgroundColor = [UIColor redColor];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 40, 45, 8, 12) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
        [self addSubview:self.cardNum];
        [self addSubview:self.editCardInfo];
    
        [self addSubview:[UISubLabel labelWithTitle:@"CVV2:" frame:CGRectMake(25, 74, 50, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        self.cvvNum = [UISubLabel labelWithTitle:nil frame:CGRectMake(80, 74, 90, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        [self addSubview:self.cvvNum];
        
        [self addSubview:[UISubLabel labelWithTitle:@"有效期:" frame:CGRectMake(ViewWidth - 150, 74, 50, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        self.validityDate = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 95, 74, 90, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        [self addSubview:self.validityDate];
        
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
