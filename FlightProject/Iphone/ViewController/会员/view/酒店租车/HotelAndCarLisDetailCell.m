//
//  HotelAndCarLisDetailCell.m
//  FlightProject
//
//  Created by 月 小 on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelAndCarLisDetailCell.h"

@implementation HotelAndCarLisDetailCell
@synthesize name,typeName,scheduleDate,checkInDate,checkOutDate,totelMoney,stateCodeImageV,label1,label2;
-(void)dealloc
{
    self.name = nil;
    self.typeName = nil;
    self.scheduleDate = nil;
    self.checkInDate = nil;
    self.checkOutDate = nil;
    self.totelMoney = nil;
    self.stateCodeImageV = nil;
    self.label1 = nil;
    self.label2 = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 100, 75) image:[UIImage imageNamed:@"TicketListLeft.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 90, 0, 80, 75) image:[UIImage imageNamed:@"TicketListRight.png"]]];
        
        self.name = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 10, ViewWidth - 120, 20) font:FontSize30 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        
        self.label1 = [UISubLabel labelWithTitle:@"入住:" frame:CGRectMake(20, 32, 30, 15) font:FontSize24 color:FontColor909090 alignment:NSTextAlignmentLeft];
        self.label2 = [UISubLabel labelWithTitle:@"离店:" frame:CGRectMake(ViewWidth - 193, 32, 30, 15) font:FontSize24 color:FontColor909090 alignment:NSTextAlignmentLeft];
        
        self.checkInDate = [UISubLabel labelWithTitle:nil frame:CGRectMake(50, 32, 70, 15) font:FontSize24 color:FontColor909090 alignment:NSTextAlignmentLeft];
        self.checkInDate.adjustsFontSizeToFitWidth = YES;
        self.checkOutDate = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 163, 32, 70, 15) font:FontSize24 color:FontColor909090 alignment:NSTextAlignmentLeft];
        self.checkOutDate.adjustsFontSizeToFitWidth = YES;
       
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 52, ViewWidth - 120, 1) image:[UIImage imageNamed:@"TicketListxuxian.png"]]];
        
        
         self.scheduleDate = [UISubLabel labelWithTitle:nil frame:CGRectMake(10, 52, 100, 20) font:FontSize22 color:FontColor565656 alignment:NSTextAlignmentRight];
        self.typeName = [UISubLabel labelWithTitle:nil frame:CGRectMake(160, 52, 70, 20) font:FontSize22 color:FontColor767676 alignment:NSTextAlignmentLeft];

        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 85, 32, 8, 8) image:[UIImage imageNamed:@"TicketListRMB.png"]]];
        
//        UISubLabel * label1 = [[UISubLabel alloc] initWithFrame:CGRectMake(20, 35, 60, 23) ];
//        [label1 setTextAlignment:NSTextAlignmentLeft];
//        [label1 setBackgroundColor:[UIColor clearColor]];
//        label1.font = FontSize40;
//        label1.textColor = FontColor000000;
//        label1.minimumFontSize = 10;
//        label1.adjustsFontSizeToFitWidth = YES;
//        label1.highlightedTextColor = [UIColor whiteColor];
        
        self.totelMoney =   [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 75, 20, 60, 20) font:FontSize48 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        self.totelMoney.numberOfLines = 1;
        self.totelMoney.minimumFontSize = 10;
        self.totelMoney.adjustsFontSizeToFitWidth = YES;
        
        self.stateCodeImageV = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 75, 50, 52, 20)];
        
        [self addSubview:self.name];
        [self addSubview:self.typeName];
        [self addSubview:self.scheduleDate];
        [self addSubview:self.label1];
        [self addSubview:self.label2];
        [self addSubview:self.checkInDate];
        [self addSubview:self.checkOutDate];
        [self addSubview:self.totelMoney];
        [self addSubview:self.stateCodeImageV];
        
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
