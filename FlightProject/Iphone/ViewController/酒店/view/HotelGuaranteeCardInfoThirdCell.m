//
//  HotelGuaranteeCardInfoThirdCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelGuaranteeCardInfoThirdCell.h"

@implementation HotelGuaranteeCardInfoThirdCell
@synthesize personName,bankIcon,bankName,cardNum,cardNumLast,validityDateTextField,cvvNumTextField;

- (void)dealloc
{
    self.personName = nil;
    self.bankName = nil;
    self.bankIcon = nil;
    self.cardNum = nil;
    self.cardNumLast = nil;
    self.validityDateTextField = nil;
    self.cvvNumTextField = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 170) image:[UIImage imageNamed:@"中间.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 170, ViewWidth - 20, 7) image:[UIImage imageNamed:@"尾.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 0, ViewWidth - 40, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 115, ViewWidth - 40, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        self.personName = [UISubLabel labelWithTitle:nil frame:CGRectMake(25, 10, 150, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.bankIcon = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth/2, 10, 20, 20) image:[UIImage imageNamed:@""]];
        self.bankName = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth/2 + 65, 10, 65, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentRight];
        [self addSubview:self.personName];
        [self addSubview:self.bankIcon];
        [self addSubview:self.bankName];
        
        
        [self addSubview:[UISubLabel labelWithTitle:@"卡号:" frame:CGRectMake(25, 42, 50, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        self.cardNum = [UISubLabel labelWithTitle:nil frame:CGRectMake(80, 42, 40, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        [self addSubview:self.cardNum];
        [self addSubview:[UISubLabel labelWithTitle:@"* * * *      * * * *" frame:CGRectMake(130, 44, 160, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        self.cardNumLast = [UISubLabel labelWithTitle:nil frame:CGRectMake(250, 42, 40, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        [self addSubview:self.cardNumLast];
        
        
        [self addSubview:[UISubLabel labelWithTitle:@"有效期:" frame:CGRectMake(ViewWidth - 150, 74, 50, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 95, 72, 67, 30) image:[UIImage imageNamed:@"房间数.png"]]];
        self.validityDateTextField = [UISubTextField TextFieldWithFrame:CGRectMake(ViewWidth - 95, 72, 67, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentCenter placeholder:@"输入有效期" font:FontSize26];
        self.validityDateTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.validityDateTextField.textColor = FontColor3B3B3B;
        self.validityDateTextField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self.validityDateTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.validityDateTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.validityDateTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:self.validityDateTextField];
        
        
        
        
        
        [self addSubview:[UISubLabel labelWithTitle:@"CVV2:" frame:CGRectMake(25, 74, 50, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(80, 72, 75, 30) image:[UIImage imageNamed:@"房间数.png"]]];
        self.cvvNumTextField = [UISubTextField TextFieldWithFrame:CGRectMake(80, 72, 75, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentCenter placeholder:@"卡背面后3位" font:FontSize26];         
        self.cvvNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.cvvNumTextField.textColor = FontColor3B3B3B;
        self.cvvNumTextField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self.cvvNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.cvvNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.cvvNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:self.cvvNumTextField];

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
