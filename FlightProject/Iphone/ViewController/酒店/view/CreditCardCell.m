//
//  CreditCardCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CreditCardCell.h"

@implementation CreditCardCell
@synthesize bankName,cardNum,userName,selectImageView,unSelectImageView;
@synthesize _editBut;
- (void)dealloc
{
    self._editBut = nil;
    self.bankName = nil;
    self.cardNum = nil;
    self.userName = nil;
    self.selectImageView = nil;
    self.unSelectImageView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 3, ViewWidth - 20, 45) image:[UIImage imageNamed:@"PassengerCell.png"]]];
        self.unSelectImageView = [UIImageView ImageViewWithFrame:CGRectMake(20, 15, 20, 20) image:[UIImage imageNamed:@"FilterSingleUnSelected.png"]];
        [self addSubview:self.unSelectImageView];
        
        self.selectImageView = [UIImageView ImageViewWithFrame:CGRectMake(20, 15, 20, 20) image:[UIImage imageNamed:@"FilterSingleSelected.png"]];
        self.userName = [UISubLabel labelWithTitle:nil frame:CGRectMake(45, 15, 65, 20) font:FontSize28 color:FontColor3B3B3B alignment:NSTextAlignmentLeft];
        self.cardNum = [UISubLabel labelWithTitle:nil frame:CGRectMake(100, 15, 130, 20) font:FontSize28 color:FontColor3B3B3B alignment:NSTextAlignmentLeft];
        self.bankName = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 110, 15, 70, 20) font:FontSize28 color:FontColor3B3B3B alignment:NSTextAlignmentRight];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 30, 19.0f, 8.0f, 13.0f) image:[UIImage imageNamed:@"CellArrow.png"]]];
        
        self._editBut = [UIButton buttonWithTag:0 frame:CGRectMake(240, 0, ViewWidth - 240, 48) target:nil action:nil];
        [self addSubview:self.selectImageView];
        
        [self addSubview:self.userName];
        [self addSubview:self.cardNum];
        [self addSubview:self.bankName];
        [self addSubview:self._editBut];
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
