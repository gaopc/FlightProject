//
//  MemberOrderDetailCell.m
//  FlightProject
//
//  Created by admin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberOrderDetailCell.h"

@implementation MemberOrderDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 20) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"机票信息" frame:CGRectMake(22, 0, 50, 20) font:FontSize22 color:FontColor696969 alignment:NSTextAlignmentLeft]];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end


@implementation MemberOrderPersonCell
@synthesize _cerNum, _cerType, _birthday, _ticketNum1, _personName, _personType, _ticketState1, _ticketNum2, _ticketState2;
@synthesize _returnTicket1, _returnTicket2, _phoneButton1, _phoneButton2;

- (void)dealloc
{
    self._personName = nil;
    self._personType = nil;
    self._cerNum = nil;
    self._cerType = nil;
    self._ticketNum1 = nil;
    self._ticketNum2 = nil;
    self._ticketState1 = nil;
    self._ticketState2 = nil;
    
    self._returnTicket1 = nil;
    self._returnTicket2 = nil;
    self._phoneButton1 = nil;
    self._phoneButton2 = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        if (type == 0) {
            [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 70) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
            
            [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(18, 5, ViewWidth - 36, 62) image:[UIImage imageNamed:@"凸显框.png"]]];
        }
        else if (type == 1){
            [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 110) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
            
            [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(18, 5, ViewWidth - 36, 102) image:[UIImage imageNamed:@"凸显框.png"]]];
        }
        else {
            [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 150) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
            
            [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(18, 5, ViewWidth - 36, 142) image:[UIImage imageNamed:@"凸显框.png"]]];
        }
        
        [self addSubview:[UISubLabel labelWithTitle:@"姓名" frame:CGRectMake(25, 15, 60, 20) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        self._personName = [UISubLabel labelWithTitle:@"李正" frame:CGRectMake(70, 15, 170, 20) font:FontSize28 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._personType = [UISubLabel labelWithTitle:@"成人票" frame:CGRectMake(ViewWidth - 80, 15, 50, 20) font:FontSize20 color:FontColor565656 alignment:NSTextAlignmentRight];
        
        self._cerType = [UISubLabel labelWithTitle:@"身份证" frame:CGRectMake(25, 40, 70, 20) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._cerNum = [UISubLabel labelWithTitle:@"150204189209081829" frame:CGRectMake(70, 40, 200, 20) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        if (type > 0) {
            [self addSubview:[UISubLabel labelWithframe:CGRectMake(25, 70, 270, 1) backgroundColor:FontColor979797]];
            
            [self addSubview:[UISubLabel labelWithTitle:@"票号" frame:CGRectMake(25, 80, 60, 20) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentLeft]];
            self._ticketNum1 = [UISubLabel labelWithTitle:@"" frame:CGRectMake(60, 80, 100, 20) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentLeft];
            self._ticketState1 = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth - 150, 80, 50, 20) font:FontSize22 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
            self._phoneButton1 = [UIButton buttonWithTag:0 frame:CGRectMake(ViewWidth - 150, 80, 50, 20) target:nil action:nil];
            self._ticketState1.backgroundColor = [UIColor brownColor];
            self._returnTicket1 = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(ViewWidth - 95, 78, 64, 24) backImage:[UIImage imageNamed:@"退票.png"] target:nil action:nil];
            self._returnTicket1.hidden = YES;
            self._phoneButton1.hidden = YES;
        }
        
        if (type > 1)
        {
            [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(25, 105, 275, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
            
            [self addSubview:[UISubLabel labelWithTitle:@"票号" frame:CGRectMake(25, 115, 60, 20) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentLeft]];
            self._ticketNum2 = [UISubLabel labelWithTitle:@"" frame:CGRectMake(60, 115, 100, 20) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentLeft];
            self._ticketState2 = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth - 150, 115, 50, 20) font:FontSize22 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
            self._ticketState2.backgroundColor = [UIColor brownColor];
            self._phoneButton2 = [UIButton buttonWithTag:0 frame:CGRectMake(ViewWidth - 150, 115, 50, 20) target:nil action:nil];
            self._returnTicket2 = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:nil frame:CGRectMake(ViewWidth - 95, 113, 64, 24) backImage:[UIImage imageNamed:@"退票.png"] target:nil action:nil];
            self._returnTicket2.hidden = YES;
            self._phoneButton2.hidden = YES;
        }
        
        [self addSubview:self._personName];
        [self addSubview:self._personType];
        [self addSubview:self._cerType];
        [self addSubview:self._cerNum];
        [self addSubview:self._ticketNum1];
        [self addSubview:self._ticketState1];
        [self addSubview:self._ticketNum2];
        [self addSubview:self._ticketState2];
        
        [self addSubview:self._returnTicket1];
        [self addSubview:self._returnTicket2];
        [self addSubview:self._phoneButton1];
        [self addSubview:self._phoneButton2];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@implementation MemberOrderContactCell
@synthesize _contactNum;

- (void)dealloc
{
    self._contactNum = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 30) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 8, 12, 15) image:[UIImage imageNamed:@"手机icon.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"联系方式:" frame:CGRectMake(45, 5, 90, 20) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        
        self._contactNum = [UISubLabel labelWithTitle:@"13801012345" frame:CGRectMake(110, 5, 180, 20) font:FontSize26 color:FontColor696969 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._contactNum];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end


@implementation MemberOrdercancelCell
@synthesize _allCancelButton;

- (void)dealloc
{
    self._allCancelButton = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, -5, ViewWidth - 20, 50) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 45, ViewWidth - 20, 5) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        
        self._allCancelButton = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"取消订单.png"] frame:CGRectMake((ViewWidth - 136)/2, 5, 136, 33) target:nil action:nil];
        
        [self addSubview:self._allCancelButton];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@implementation MemberOrderModifyTelephoneCell
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
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 70) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 15, ViewWidth - 43, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 25, ViewWidth - 43, 37) image:[UIImage imageNamed:@"输入框.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 36, 12, 15) image:[UIImage imageNamed:@"手机icon.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"联系方式:" frame:CGRectMake(45, 34, 90, 20) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft]];
        
        self._phoneNumTF = [UISubTextField TextFieldWithFrame:CGRectMake(110, 34, ViewWidth - 140, 20) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"" font:FontSize22];
        self._phoneNumTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self._phoneNumTF.textColor = FontColor3B3B3B;
        self._phoneNumTF.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self._phoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self._phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
        
        [self addSubview:self._phoneNumTF];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end


@implementation MemberOrderModifyItineraryCell
@synthesize _leftButton1,_leftButton2;
@synthesize _terminalButton,_mailButton,_mailAddressLabel;
@synthesize _itinerarySwitch;
@synthesize _areaView;
-(void)dealloc
{
    self._leftButton1 = nil;
    self._leftButton2 = nil;
    self._terminalButton = nil;
    self._mailButton = nil;
    self._mailAddressLabel = nil;
    self._areaView = nil;
    
    self._itinerarySwitch =nil;
	
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self._areaView = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 190) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]];
        [self addSubview:self._areaView];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 2, ViewWidth - 43, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"行程单" frame:CGRectMake(22, 7, 100, 20) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 32, 13, 15) image:[UIImage imageNamed:@"行程单icon.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"需要行程单" frame:CGRectMake(50, 30, 100, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        
        self._itinerarySwitch = [[[CustomUISwitch alloc] initWithFrame:CGRectMake(130, 25, 60, 22)] autorelease];
        
        self._terminalButton = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:nil backImage:[UIImage imageNamed:[NSString stringWithFormat:@"ItineraryRight0.png"]] frame:CGRectMake(ViewWidth - 140, 65,112, 30) font:FontSize32 color:FontColor909090 target:nil action:nil];
        
        self._mailButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil backImage:[UIImage imageNamed:[NSString stringWithFormat:@"ItineraryRight1.png"]] frame:CGRectMake(ViewWidth - 140, 110,112, 30) font:FontSize32 color:FontColor909090 target:nil action:nil];
        
        self._leftButton1 = [UIButton buttonWithTag:2 image:[UIImage imageNamed: @"FilterSingleSelected.png"] title:@"终端机打印"  imageEdge:UIEdgeInsetsMake(2, 2, 2, 120  - 30 +2)  frame:CGRectMake(25, 65, 120, 30) font:FontSize26 color:FontColor909090 target:nil action:nil];
        
        self._leftButton2 = [UIButton buttonWithTag:1 image:[UIImage imageNamed: @"FilterSingleUnSelected.png"] title:@"免费邮寄"  imageEdge:UIEdgeInsetsMake(2, 2, 2, 120  - 30 +2)  frame:CGRectMake(25, 110, 120, 30) font:FontSize26 color:FontColor909090 target:nil action:nil];
        
        self._mailAddressLabel = [UISubLabel labelWithTitle:@"邮寄地址：北京市朝阳区惠新东街11号 紫光发展大厦B2座8层" frame: CGRectMake(25, 145, ViewWidth - 50, 40) font: FontSize26 color:FontColor909090 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._itinerarySwitch];
        [self addSubview:self._leftButton1];
        [self addSubview:self._leftButton2];
        [self addSubview:self._terminalButton];
        [self addSubview:self._mailButton];
        [self addSubview:self._mailAddressLabel];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end


@implementation MemberOrderModifyServiceCell
@synthesize _serviceSwitch, _moreButton, _serviceState;

- (void)dealloc
{
    _moreButton = nil;
    _serviceState = nil;
    self._serviceSwitch = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 65) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 5, ViewWidth - 43, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 38, 12, 15) image:[UIImage imageNamed:@"降价icon.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"自动降价服务" frame:CGRectMake(22, 12, 100, 20) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        
        self._serviceState = [UISubLabel labelWithTitle:@"选取服务" frame:CGRectMake(45, 35, 90, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self._moreButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"了解更多" frame:CGRectMake(ViewWidth - 87, 35, 55, 20) font:FontSize22 color:FontColor2585CF target:nil action:nil];
        [self._moreButton setTitleColor:FontColor636363 forState:UIControlStateHighlighted];
        
        self._serviceSwitch = [[[CustomUISwitch alloc] initWithFrame:CGRectMake((ViewWidth - 60)/2, 30, 60, 22)] autorelease];
        
        [self addSubview:self._serviceState];
        [self addSubview:self._moreButton];
        [self addSubview:self._serviceSwitch];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@implementation MemberOrderTicketInfoCell
@synthesize _fee, _ticketNum, _returnPrice, _totailPrice;

- (void)dealloc
{
    self._fee = nil;
    self._totailPrice = nil;
    self._returnPrice = nil;
    self._ticketNum = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(12, 8, ViewWidth - 24, 120) image:[UIImage imageNamed:@"凸显框.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"票号" frame:CGRectMake(30, 30, 60, 20) font:FontSize24 color:FontColor696969 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"总票价" frame:CGRectMake(30, 60, 60, 20) font:FontSize24 color:FontColor696969 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"退票手续费" frame:CGRectMake(ViewWidth/2, 60, 80, 20) font:FontSize24 color:FontColor696969 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"退款金额" frame:CGRectMake(30, 90, 60, 20) font:FontSize24 color:FontColor696969 alignment:NSTextAlignmentLeft]];
        
        self._ticketNum = [UISubLabel labelWithTitle:@"8802225202419" frame:CGRectMake(85, 27, 200, 25) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._totailPrice = [UISubLabel labelWithTitle:@"￥1234" frame:CGRectMake(85, 57, 60, 25) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._fee = [UISubLabel labelWithTitle:@"￥234" frame:CGRectMake(ViewWidth/2 + 65, 57, 80, 25) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._returnPrice = [UISubLabel labelWithTitle:@"￥1000" frame:CGRectMake(85, 87, 60, 25) font:FontSize30 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        
        
        
        [self addSubview:self._ticketNum];
        [self addSubview:self._totailPrice];
        [self addSubview:self._returnPrice];
        [self addSubview:self._fee];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end


@implementation MemberOrderRulesInfoCell
@synthesize _rulesContect, _boxView;

- (void)dealloc
{
    self._rulesContect = nil;
    self._boxView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withRule:(NSString *)rules
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        self._boxView = [UIImageView ImageViewWithFrame:CGRectMake(12, 5, ViewWidth - 24, 40) image:[UIImage imageNamed:@"凸显框.png"]];
        
        [self addSubview:self._boxView];
        
        [self addSubview:[UISubLabel labelWithTitle:@"退改签说明" frame:CGRectMake((ViewWidth - 100)/2, 20, 100, 20) font:FontSize36 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        
        self._rulesContect = [UISubLabel labelWithTitle:rules frame:CGRectMake(20, 45, ViewWidth - 40, 150) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft autoSize:YES];
        
        [self addSubview:self._rulesContect];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end


@implementation MemberOrderReturnCell
@synthesize _lcdReturn, _normalReturn;

- (void)dealloc
{
    self._lcdReturn = nil;
    self._normalReturn = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 3, ViewWidth - 20, 5) image:[UIImage imageNamed:@"分割线.png"]]];
        
        self._normalReturn = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(15, 10, 137, 34) backImage:[UIImage imageNamed:@"原支付退款.png"] target:nil action:nil];
        self._lcdReturn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth - 15 - 137, 10, 137, 34) backImage:[UIImage imageNamed:@"畅达币退款.png"] target:nil action:nil];
        
        [self addSubview:self._normalReturn];
        [self addSubview:self._lcdReturn];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end


@implementation MemberOrderItineraryCell
@synthesize _mapButton;
@synthesize _itineraryLabel, _mailAddressLabel, _stateInfoLabel;
@synthesize _areaView, _iconView;
- (void)dealloc
{
    self._mapButton = nil;
    self._itineraryLabel = nil;
    self._mailAddressLabel = nil;
    self._stateInfoLabel = nil;
    self._areaView = nil;
    self._iconView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self._areaView = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 80) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]];
        
        [self addSubview:self._areaView];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 2, ViewWidth - 43, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        self._iconView = [UIImageView ImageViewWithFrame:CGRectMake(30, 15, 12, 15) image:[UIImage imageNamed:@"地址icon.png"]];
        
        self._itineraryLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(45, 12, 100, 20) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
//        self._stateInfoLabel = [UISubLabel labelWithTitle:@"已邮寄" frame:CGRectMake(200, 12, 90, 20) font:FontSize26 color:FontColor696969 alignment:NSTextAlignmentRight];
        
        self._mailAddressLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(45, 38, ViewWidth - 80, 40) font:FontSize26 color:FontColor696969 alignment:NSTextAlignmentLeft];
        
        self._mapButton = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:nil backImage:[UIImage imageNamed:[NSString stringWithFormat:@"ItineraryRight0.png"]] frame:CGRectMake(ViewWidth -140, 25,112, 30) font:FontSize32 color:FontColor909090 target:nil action:nil];
        self._mapButton.hidden = YES;
        
        [self addSubview:self._iconView];
        [self addSubview:self._stateInfoLabel];
        [self addSubview:self._mailAddressLabel];
        [self addSubview:self._itineraryLabel];
        [self addSubview:self._mapButton];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end
