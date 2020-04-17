//
//  MemberHotelCell.m
//  FlightProject
//
//  Created by admin on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberHotelCell.h"

@implementation MemberHotelCell
@synthesize _orderNo, _orderState, _scheduleDate, _hotelInfo, _totelMoney, _lcdCurrency , _returnLcdView;

- (void)dealloc
{
    self._hotelInfo = nil;
    self._totelMoney = nil;
    self._lcdCurrency = nil;
    self._orderNo = nil;
    self._orderState = nil;
    self._scheduleDate = nil;
    self._returnLcdView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 200) image:[UIImage imageNamed:@"中间.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(14, 13, ViewWidth - 28, 180) image:[UIImage imageNamed:@"凸显框.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(25, 98, ViewWidth - 50, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"订单号：" frame:CGRectMake(25, 20, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"订单状态：" frame:CGRectMake(25, 45, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"预订日期：" frame:CGRectMake(25, 70, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        self._orderNo = [UISubLabel labelWithTitle:@"38472832" frame:CGRectMake(100, 20, ViewWidth - 120, 20) font:FontSize28 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._orderState = [UISubLabel labelWithTitle:@"已确认" frame:CGRectMake(100, 45, 200, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._scheduleDate = [UISubLabel labelWithTitle:@"2012-10-20" frame:CGRectMake(100, 70, 200, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._hotelInfo = [UISubLabel labelWithTitle:@"北京新锐明德新锐科斯万豪酒店： 标准间 ￥1450 + 双早餐" frame:CGRectMake(25, 105, ViewWidth - 50, 40) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(14, 150, ViewWidth - 28, 1) backgroundColor:FontColorFF8813]];
        
       
        
        [self addSubview:[UISubLabel labelWithTitle:@"房价合计" frame:CGRectMake(170, 166, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];

	UIView * view = [[UIView alloc] initWithFrame:CGRectMake(25, 165, 135.0f, 20.0f)];
	self._returnLcdView = view;
	[view release];
	    
	[self._returnLcdView addSubview:[UISubLabel labelWithTitle:@"返还畅达币：" frame:CGRectMake(0, 0, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
	    
        self._lcdCurrency = [UISubLabel labelWithTitle:@"2238" frame:CGRectMake(65, 0, 45, 20) font:FontSize26 color:FontColorFF8813 alignment:NSTextAlignmentRight];
	[self._returnLcdView addSubview:self._lcdCurrency];    
        [self._returnLcdView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(115, 1, 15, 15) image:[UIImage imageNamed:@"DollarIcon.png"]]];
        

        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(225, 170, 11, 12) image:[UIImage imageNamed:@"符号.png"]]];
        
        self._totelMoney = [UISubLabel labelWithTitle:@"1450" frame:CGRectMake(240, 164, 60, 20) font:FontSize42 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        self._totelMoney.numberOfLines = 1;
        self._totelMoney.minimumFontSize = 10;
        self._totelMoney.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:self._orderNo];
        [self addSubview:self._orderState];
        [self addSubview:self._scheduleDate];
        [self addSubview:self._totelMoney];
 	[self addSubview:self._returnLcdView];
        [self addSubview:self._hotelInfo];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end


@implementation MemberHotelInfoCell
@synthesize _hotelName, _checkInDate, _checkOutDate, _hotelAddress;

- (void)dealloc
{
    self._checkInDate = nil;
    self._checkOutDate = nil;
    self._hotelAddress = nil;
    self._hotelName = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 290) image:[UIImage imageNamed:@"中间.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"付款方式" frame:CGRectMake(30, 10, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 42, 13, 9) image:[UIImage imageNamed:@"付款方式icon.png"]]];

        [self addSubview:[UISubLabel labelWithTitle:@"前台自付" frame:CGRectMake(50, 35, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(25, 65, ViewWidth - 50, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"酒店信息" frame:CGRectMake(30, 75, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 104, 12, 15) image:[UIImage imageNamed:@"酒店信息icon.png"]]];
        
        self._hotelName = [UISubLabel labelWithTitle:@"北京新锐明德新锐科斯万豪酒店" frame:CGRectMake(50, 100, ViewWidth - 70, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._hotelAddress = [UISubLabel labelWithTitle:@"北京市海淀区学院路20号(成府路口东)" frame:CGRectMake(50, 120, ViewWidth - 70, 40) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(25, 170, ViewWidth - 50, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"居住时间" frame:CGRectMake(30, 180, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 209, 13, 12) image:[UIImage imageNamed:@"居住时间icon.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"入住时间" frame:CGRectMake(50, 205, 80, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"离店时间" frame:CGRectMake(50, 230, 80, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        
        self._checkInDate = [UISubLabel labelWithTitle:@"2012-08-21" frame:CGRectMake(130, 205, 250, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._checkOutDate = [UISubLabel labelWithTitle:@"2012-08-24" frame:CGRectMake(130, 230, 250, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(25, 260, ViewWidth - 50, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"入住人" frame:CGRectMake(30, 270, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:self._checkInDate];
        [self addSubview:self._checkOutDate];
        [self addSubview:self._hotelAddress];
        [self addSubview:self._hotelName];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end


@implementation MemberHotelPeopleInfoCell
@synthesize _peopleName;

- (void)dealloc
{
    self._peopleName = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 25) image:[UIImage imageNamed:@"中间.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 9, 12, 15) image:[UIImage imageNamed:@"用户icon.png"]]];
        
        self._peopleName = [UISubLabel labelWithTitle:@"高鹏程" frame:CGRectMake(50, 5, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._peopleName];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end  

@implementation MemberHotelTelePhoneCell
@synthesize _telNum;

- (void)dealloc
{
    self._telNum = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 45) image:[UIImage imageNamed:@"中间.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(25, 10, ViewWidth - 50, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 20, 12, 15) image:[UIImage imageNamed:@"手机icon.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"联系方式" frame:CGRectMake(50, 18, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        
        self._telNum = [UISubLabel labelWithTitle:@"15810000000" frame:CGRectMake(130, 18, 180, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._telNum];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@implementation MemberEndCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 5) image:[UIImage imageNamed:@"尾.png"]]];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@implementation MemberHotelDetailCell
@synthesize _hotelInfo, _totelMoney, _lcdCurrency;
@synthesize _returnLcdView;
- (void)dealloc
{
    self._hotelInfo = nil;
    self._totelMoney = nil;
    self._lcdCurrency = nil;
    self._returnLcdView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 7) image:[UIImage imageNamed:@"头带黑边.png"]]];
         [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 7, ViewWidth - 20, 93) image:[UIImage imageNamed:@"中间.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(14, 13, ViewWidth - 28, 90) image:[UIImage imageNamed:@"凸显框.png"]]];
        
        self._hotelInfo = [UISubLabel labelWithTitle:@"北京新锐明德新锐科斯万豪酒店： 标准间 ￥1450 + 双早餐" frame:CGRectMake(25, 20, ViewWidth - 50, 40) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(14, 65, ViewWidth - 28, 1) backgroundColor:FontColorFF8813]];

        UIView * _view = [[UIView alloc] initWithFrame:CGRectMake(25, 79, 120, 20)];
        self._returnLcdView = _view;
        [_view release];
        
         [self._returnLcdView addSubview:[UISubLabel labelWithTitle:@"返还畅达币：" frame:CGRectMake(0, 0, 80, 20) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        self._lcdCurrency = [UISubLabel labelWithTitle:@"2238" frame:CGRectMake(65, 0, 45, 20) font:FontSize26 color:FontColorFF8813 alignment:NSTextAlignmentRight];
        [self._returnLcdView addSubview:self._lcdCurrency];
        [self._returnLcdView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(110, 2, 15, 15) image:[UIImage imageNamed:@"DollarIcon.png"]]];
        [self addSubview:self._returnLcdView];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(225, 85, 11, 12) image:[UIImage imageNamed:@"符号.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"房价合计" frame:CGRectMake(170, 81, 80, 20) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        self._totelMoney = [UISubLabel labelWithTitle:@"1450" frame:CGRectMake(240, 79, 80, 20) font:FontSize42 color:FontColorFF8813 alignment:NSTextAlignmentLeft];

        [self addSubview:self._totelMoney];
//        [self addSubview:self._lcdCurrency];
        [self addSubview:self._hotelInfo];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end