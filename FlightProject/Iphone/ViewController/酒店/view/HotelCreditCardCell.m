//
//  CreditCardCell.m
//  FlightProject
//
//  Created by green kevin on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelCreditCardCell.h"

@implementation HotelCreditCardCell
@synthesize name,bankIdCard,bank;
@synthesize btnView = _btnView;
@synthesize radioButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
	    passengersBgView=[UIImageView ImageViewWithFrame:CGRectMake(10.0f, 5.0f, 300.0f, 65.0f)];
	    passengersBgView.image=[UIImage imageNamed:@"PassengerCell.png"];
	    [self.contentView addSubview:passengersBgView];
	    
	    radioImgView=[UIImageView ImageViewWithFrame:CGRectMake(15.0f, 22.0f, 25.0f, 25.0f)];
	    radioImgView.image=[UIImage imageNamed:@"Radio_A.png"];
	    [self.contentView addSubview:radioImgView];
	    
	    self.btnView=[UIImageView ImageViewWithFrame:CGRectMake(15.0f, 22.0f, 25.0f, 25.0f)];
	    self.btnView.image=[UIImage imageNamed:@"Radio_B.png"];
	    [self.contentView addSubview:self.btnView];
	    self.btnView.hidden =YES;
	    
	    self.name = [UISubLabel labelWithTitle:@"" frame:CGRectMake(45.0, 22.0f, 60.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	    self.name.textColor = FontColor696969;
	    [self.contentView addSubview:self.name];
	    

	    
	    self.bankIdCard = [UISubLabel labelWithTitle:@"" frame:CGRectMake(105.0, 22.0f, 130.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
	    self.bankIdCard.textColor = FontColor696969;
	    [self.contentView addSubview:self.bankIdCard];
	    

	    
	    self.bank = [UISubLabel labelWithTitle:@"" frame:CGRectMake(230.0,  22.0f, 75.0f, 25.0f) font:FontSize22 alignment:NSTextAlignmentLeft];
	    self.bank.textColor = FontColor696969;
	    [self.contentView addSubview:self.bank];

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
