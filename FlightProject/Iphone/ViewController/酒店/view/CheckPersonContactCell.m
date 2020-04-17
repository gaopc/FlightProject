//
//  CheckPersonContactCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CheckPersonContactCell.h"

@implementation CheckPersonContactCell
@synthesize _phoneNumTF;

- (void)dealloc
{
    self._phoneNumTF = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, 300, 70) image:[UIImage imageNamed:@"中间.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 10, 277, 37) image:[UIImage imageNamed:@"输入框.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 20, 12, 15) image:[UIImage imageNamed:@"手机icon.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"联系方式:" frame:CGRectMake(45, 17, 90, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        
        self._phoneNumTF = [UISubTextField TextFieldWithFrame:CGRectMake(113, 18, 180, 20) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入联系人电话" font:FontSize30];
        self._phoneNumTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self._phoneNumTF.textColor = FontColor3B3B3B;
        self._phoneNumTF.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self._phoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self._phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
        
        [self addSubview:self._phoneNumTF];
        
        [self addSubview:[UISubLabel labelWithTitle:@"该联系方式用于接收入住人和酒店信息的短信" frame:CGRectMake(55, 48, 230, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 69, 277, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
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
