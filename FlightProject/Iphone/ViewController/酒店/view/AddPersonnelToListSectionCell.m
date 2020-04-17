//
//  AddPersonnelToListSectionCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AddPersonnelToListSectionCell.h"

@implementation AddPersonnelToListSectionCell
@synthesize addPersonnelButton;
- (void)dealloc
{
    self.addPersonnelButton = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth-20, 60) image:[UIImage imageNamed:@"中间.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"入住人列表" frame:CGRectMake(25, 15, 100, 18) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        self.addPersonnelButton = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"HotelPersonne1.png"] frame:CGRectMake(ViewWidth-145, 12, 105, 28) target:nil action:nil];
	if ([[UserInfo sharedUserInfo].userID isEqualToString: @""])
	[self.addPersonnelButton setImage:[UIImage imageNamed:@"添加入住人.png"] forState:UIControlStateNormal];
		    
	    
	    [self addSubview:self.addPersonnelButton];
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
