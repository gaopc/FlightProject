//
//  MemberCarCell.m
//  FlightProject
//
//  Created by admin on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberCarCell.h"

@implementation MemberCarCell
@synthesize _lcdFee, _orderType, _priceInfo, _submitDate, _orderNumber, _orderStatus, _totalCarRentMoney,_returnLcdView;

- (void)dealloc
{
    self._lcdFee = nil;
    self._orderType = nil;
    self._priceInfo = nil;
    self._submitDate = nil;
    self._orderNumber = nil;
    self._orderStatus = nil;
    self._totalCarRentMoney = nil;
    self._returnLcdView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 225) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(14, 13, ViewWidth - 28, 205) image:[UIImage imageNamed:@"凸显框.png"]]];
        
        
        [self addSubview:[UISubLabel labelWithTitle:@"订单号：" frame:CGRectMake(25, 20, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"订单状态：" frame:CGRectMake(25, 45, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"订单类型：" frame:CGRectMake(25, 70, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"预订日期：" frame:CGRectMake(25, 95, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        self._orderNumber = [UISubLabel labelWithTitle:@"38472832" frame:CGRectMake(100, 20, 200, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._orderStatus = [UISubLabel labelWithTitle:@"已确认" frame:CGRectMake(100, 45, 200, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._orderType = [UISubLabel labelWithTitle:@"非预订" frame:CGRectMake(100, 70, 200, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._submitDate = [UISubLabel labelWithTitle:@"2012-10-20" frame:CGRectMake(100, 95, 200, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(25, 123, ViewWidth - 50, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"费用明细：" frame:CGRectMake(25, 132, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        self._priceInfo = [UISubLabel labelWithTitle:@"租金 ￥348 + 保险 ￥34 + 增值服务 ￥0 + 其他费用 ￥34" frame:CGRectMake(90, 130, ViewWidth - 110, 40) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(14, 175, ViewWidth - 28, 1) backgroundColor:FontColorFF8813]];
        
	UIView * view = [[UIView alloc] initWithFrame:CGRectMake(25, 190, 135.0f, 20.0f)];
	self._returnLcdView = view;
	[view release];
	    
        [self._returnLcdView addSubview:[UISubLabel labelWithTitle:@"返还畅达币：" frame:CGRectMake(0, 0, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
	self._lcdFee = [UISubLabel labelWithTitle:@"返2238" frame:CGRectMake(58, 0, 52, 20) font:FontSize26 color:FontColorFF8813 alignment:NSTextAlignmentRight];
	[self._returnLcdView addSubview:self._lcdFee];
	[self._returnLcdView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(113, 1, 15, 15) image:[UIImage imageNamed:@"DollarIcon.png"]]];
	
	    
        [self addSubview:[UISubLabel labelWithTitle:@"租金合计" frame:CGRectMake(170, 191, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(225, 195, 11, 12) image:[UIImage imageNamed:@"符号.png"]]];
        
        self._totalCarRentMoney = [UISubLabel labelWithTitle:@"1450" frame:CGRectMake(240, 189, 80, 20) font:FontSize42 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._returnLcdView];
        [self addSubview:self._orderNumber];
        [self addSubview:self._orderStatus];
        [self addSubview:self._orderType];
        [self addSubview:self._priceInfo];
        [self addSubview:self._submitDate];
        [self addSubview:self._totalCarRentMoney];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@implementation MemberCarInfoCell
@synthesize _cellNum, _takeDate, _takeShop, _takeTime, _typeDesc, _typeName, _telephone, _peopleName, _returnDate, _returnShop, _returnTime;

- (void)dealloc
{
    self._cellNum = nil;
    self._takeDate = nil;
    self._takeShop = nil;
    self._takeTime = nil;
    self._typeDesc = nil;
    self._typeName = nil;
    self._telephone = nil;
    self._peopleName = nil;
    self._returnDate = nil;
    self._returnShop = nil;
    self._returnTime = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 320) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"租车人" frame:CGRectMake(30, 10, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 39, 12, 15) image:[UIImage imageNamed:@"用户icon.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"姓名" frame:CGRectMake(50, 35, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        self._peopleName = [UISubLabel labelWithTitle:@"高鹏程" frame:CGRectMake(120, 35, 180, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 64, 14, 15) image:[UIImage imageNamed:@"证件icon.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"身份证" frame:CGRectMake(50, 60, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        self._cellNum = [UISubLabel labelWithTitle:@"150222198510202912" frame:CGRectMake(120, 60, 180, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 89, 12, 15) image:[UIImage imageNamed:@"手机icon.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"电话" frame:CGRectMake(50, 85, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        self._telephone = [UISubLabel labelWithTitle:@"15810709603" frame:CGRectMake(120, 85, 180, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(25, 115, ViewWidth - 50, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"车型信息" frame:CGRectMake(30, 125, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(23, 154, 24, 12) image:[UIImage imageNamed:@"车型信息icon.png"]]];
        self._typeName = [UISubLabel labelWithTitle:@"别克凯越" frame:CGRectMake(50, 150, 220, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._typeDesc = [UISubLabel labelWithTitle:@"两厢/1.6手动" frame:CGRectMake(140, 150, 160, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
//        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(25, 180, 270, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
                
        [self addSubview:[UISubLabel labelWithTitle:@"租用信息" frame:CGRectMake(30, 190, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(23, 219, 24, 15) image:[UIImage imageNamed:@"取车时间icon.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"取车时间" frame:CGRectMake(50, 215, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        self._takeDate = [UISubLabel labelWithTitle:@"2012-10-20 12：00" frame:CGRectMake(140, 215, 160, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
//        self._takeTime = [UISubLabel labelWithTitle:@"10:00" frame:CGRectMake(220, 215, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        [self addSubview:[UISubLabel labelWithTitle:@"取车门店" frame:CGRectMake(50, 240, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        self._takeShop = [UISubLabel labelWithTitle:@"国贸店" frame:CGRectMake(140, 240, 160, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(23, 269, 24, 15) image:[UIImage imageNamed:@"还车时间icon.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"还车时间" frame:CGRectMake(50, 265, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        self._returnDate = [UISubLabel labelWithTitle:@"2012-10-20 12：00" frame:CGRectMake(140, 265, 160, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
//        self._returnTime = [UISubLabel labelWithTitle:@"10:00" frame:CGRectMake(220, 265, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        [self addSubview:[UISubLabel labelWithTitle:@"还车门店" frame:CGRectMake(50, 290, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        self._returnShop = [UISubLabel labelWithTitle:@"国贸店" frame:CGRectMake(140, 290, 160, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        
        [self addSubview:self._peopleName];
        [self addSubview:self._cellNum];
        [self addSubview:self._returnDate];
        [self addSubview:self._returnShop];
        [self addSubview:self._returnTime];
        [self addSubview:self._takeDate];
        [self addSubview:self._takeShop];
        [self addSubview:self._takeTime];
        [self addSubview:self._telephone];
        //[self addSubview:self._typeDesc];
        [self addSubview:self._typeName];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end



@implementation MemberCarInsuranceCell
@synthesize _insuranceAmount;

- (void)dealloc
{
    self._insuranceAmount = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 60) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(25, 2, ViewWidth - 50, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"保险服务" frame:CGRectMake(30, 10, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];

        [self addSubview:[UISubLabel labelWithTitle:@"基本保险" frame:CGRectMake(50, 35, 80, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        
        self._insuranceAmount = [UISubLabel labelWithTitle:@"60元" frame:CGRectMake(220, 35, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];

        [self addSubview:self._insuranceAmount];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@implementation MemberCarServiceTitleCell
@synthesize _serviceLabel;
-(void)dealloc
{
    self._serviceLabel = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 30) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(25, 2, ViewWidth - 50, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        self._serviceLabel = [UISubLabel labelWithTitle:nil frame:CGRectMake(30, 10, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft];
        [self addSubview:self._serviceLabel];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@implementation MemberCarServiceInfoCell
@synthesize _serviceType, _servicePrice;

- (void)dealloc
{
    self._serviceType = nil;
    self._servicePrice = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 30) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        self._serviceType = [UISubLabel labelWithTitle:@"儿童座椅" frame:CGRectMake(50, 2, 220, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._servicePrice = [UISubLabel labelWithTitle:@"60元" frame:CGRectMake(220, 2, 100, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
    
        [self addSubview:self._servicePrice];
        [self addSubview:self._serviceType];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@implementation MemberCarSubmitCell
@synthesize _lcdFee, _priceInfo, _totalCarRentMoney;
@synthesize _memberLcdView;
- (void)dealloc
{
    self._lcdFee = nil;
    self._priceInfo = nil;
    self._totalCarRentMoney = nil;
    self._memberLcdView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 105) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(14, 13, ViewWidth - 28, 90) image:[UIImage imageNamed:@"凸显框.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"费用明细：" frame:CGRectMake(25, 22, 80, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        self._priceInfo = [UISubLabel labelWithTitle:@"租金 ￥348 + 保险 ￥34 + 增值服务 ￥0 + 其他费用 ￥34" frame:CGRectMake(90, 20, ViewWidth - 110, 40) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(14, 65, ViewWidth - 28, 1) backgroundColor:FontColorFF8813]];
        
        
        UIView * _view =  [[UIView alloc] initWithFrame:CGRectMake(25, 81, 120, 20)];
        self._memberLcdView =_view;
        [_view release];
        [self._memberLcdView addSubview:[UISubLabel labelWithTitle:@"返还畅达币：" frame:CGRectMake(0, 0, 80, 20) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        [self._memberLcdView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(105, 2, 15, 15) image:[UIImage imageNamed:@"DollarIcon.png"]]];
        self._lcdFee = [UISubLabel labelWithTitle:@"2238" frame:CGRectMake(55, 0, 45, 20) font:FontSize26 color:FontColorFF8813 alignment:NSTextAlignmentRight];
        [self._memberLcdView addSubview:self._lcdFee];
        
        
        [self addSubview:[UISubLabel labelWithTitle:@"租金合计" frame:CGRectMake(170, 81, 80, 20) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft]];

        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(225, 85, 11, 12) image:[UIImage imageNamed:@"符号.png"]]];
        
        self._totalCarRentMoney = [UISubLabel labelWithTitle:@"1450" frame:CGRectMake(240, 79, 80, 20) font:FontSize42 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._priceInfo];
        [self addSubview:self._totalCarRentMoney];
        [self addSubview:self._memberLcdView];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@implementation MemberCarPackageInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 95) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(25, 5, ViewWidth - 50, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UILabel labelWithTitle:@"1.本订单仅为客户租车预约登记，提交该订单后，客户需到门店办理。\n2.套餐订单不可修改为普通订单，取车时先付全部租金；一经支付，租金不退。" frame:CGRectMake(30, 10, ViewWidth - 60, 80) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft]];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end