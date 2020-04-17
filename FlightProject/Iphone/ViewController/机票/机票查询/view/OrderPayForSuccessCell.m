//
//  OrderPayForSuccessCell.m
//  FlightProject
//
//  Created by admin on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderPayForSuccessCell.h"

@implementation OrderPayForSuccessCell

@synthesize _message,_messageTitle;
@synthesize _activityLab, _shareActBtn;
-(void)dealloc
{
    self._activityLab = nil;
    self._shareActBtn = nil;
    self._messageTitle = nil;
    self._message = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 170) image:[UIImage imageNamed:@"预定成功头.png"]]];
        
        self._messageTitle = [UISubLabel labelWithTitle:@"支付成功！出票成功！" frame:CGRectMake(0, 10, ViewWidth, 25) font:FontBlodSize38 color:FontColorFF8813 alignment:NSTextAlignmentCenter];
        self._message = [UISubLabel labelWithTitle:@"登陆会员：\n1.相关信息会发送短信与您确认\n2.客户起飞后、会返还票面价2%的畅达币到您的会员账户\n非登录会员：\n相关信息会发送短信与您确认。" frame:CGRectMake(20, 25, ViewWidth - 40, 105) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._activityLab = [UILabel labelWithTitle:nil frame:CGRectMake(20, 80, ViewWidth - 40, 40) font:FontSize24 color:[UIColor redColor] alignment:NSTextAlignmentCenter];
        self._shareActBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"好开心，去告诉朋友吧" backImage:[[UIImage imageNamed:@"提交按钮.png"] stretchableImageWithLeftCapWidth:23.5 topCapHeight:22.4] frame:CGRectMake(60, 115, 200, 45) font:FontSize26 color:FontColorFFFFFF target:nil action:nil];
        
        [self addSubview:self._message];
        [self addSubview:self._messageTitle];
        
        [self addSubview:self._activityLab];
        [self addSubview:self._shareActBtn];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@implementation OrderPayForSuccess1Cell
@synthesize leftButton, rightButton, fullButton, caButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {        
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"继续订购" frame:CGRectMake(10, 7, 148, 45) backImage:[UIImage imageNamed:@"订单跳转.png"] target:nil action:nil];
        [self.leftButton setTitleColor:FontColor333333 forState:UIControlStateNormal];
        self.leftButton.titleLabel.font = FontSize28;
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"查看订单" frame:CGRectMake(ViewWidth - 158, 7, 148, 45) backImage:[UIImage imageNamed:@"订单跳转.png"] target:nil action:nil];
        self.rightButton.titleLabel.font = FontSize28;
        [self.rightButton setTitleColor:FontColor333333 forState:UIControlStateNormal];
        
        self.fullButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"继续订购" frame:CGRectMake(10, 7, ViewWidth - 20, 45) backImage:[UIImage imageNamed:@"AKVC-selectAirport.png"] target:nil action:nil];
        [self.fullButton setTitleColor:FontColor333333 forState:UIControlStateNormal];
        self.fullButton.titleLabel.font = FontSize28;
        self.fullButton.hidden = YES;
        
        self.caButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth - 174)/2, 68, 174, 20) backImage:[UIImage imageNamed:@"国航知音.png"] target:nil action:nil];
        [self.caButton setTitleColor:FontColorBlue forState:UIControlStateNormal];
        self.caButton.titleLabel.font = FontSize28;
        self.caButton.hidden = YES;
        
        [self addSubview:self.caButton];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.fullButton];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)dealloc
{
    self.rightButton = nil;
    self.leftButton = nil;
    self.fullButton = nil;
    self.caButton = nil;
    [super dealloc];
}

@end

@implementation OrderPayForSuccess2Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, 122, 23) image:[UIImage imageNamed:@"感兴趣.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"您可能感兴趣" frame:CGRectMake(10, 5, 120, 18) font:FontSize24 color:FontColor636363 alignment:NSTextAlignmentCenter]];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end

@implementation OrderPayForSuccess3Cell
@synthesize clickButton;
@synthesize titleImage;
@synthesize cellPrice, cellStore, cellTitle, cellAddress, cellLine;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {        
        self.clickButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(10, 0, 300, 117) backImage:[UIImage imageNamed:@"酒店.png"] target:nil action:nil];
        
        [self addSubview:self.clickButton];
        
        self.cellLine = [UISubLabel labelWithframe:CGRectMake(11, 0, ViewWidth - 22, 1) backgroundColor:FontColorFFFFFF];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(15, 7, 126, 101) image:[UIImage imageNamed:@"画框.png"]]];
        self.cellTitle = [UISubLabel labelWithTitle:@"新款帕沙特" frame:CGRectMake(150, 7, 140, 20) font:FontSize28 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.cellPrice = [UISubLabel labelWithTitle:@"200元/天" frame:CGRectMake(150, 30, 140, 20) font:FontSize24 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        self.cellStore = [UISubLabel labelWithTitle:@"北京神州租车四惠店" frame:CGRectMake(150, 50, 140, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.cellAddress = [UISubLabel labelWithTitle:@"北京市朝阳区东八里庄西单商场6楼601室" frame:CGRectMake(150, 67, ViewWidth - 180, 40) font:FontSize20 color:FontColor454545 alignment:NSTextAlignmentLeft];
        AsyncImageView * _imageV = [[AsyncImageView alloc] initWithFrame:CGRectMake(19, 20, 118, 72)]; //118 72
        _imageV.defaultImage = 1;
        self.titleImage = _imageV;
        [_imageV release];
        
        [self addSubview:self.cellTitle];
        [self addSubview:self.cellPrice];
        [self addSubview:self.cellStore];
        [self addSubview:self.cellAddress];
        [self addSubview:self.cellLine];
        [self addSubview:self.titleImage];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)dealloc
{
    self.clickButton = nil;
    self.cellTitle = nil;
    self.cellStore = nil;
    self.cellAddress = nil;
    self.cellPrice = nil;
    self.cellLine = nil;
    [super dealloc];
}

@end

@implementation OrderPayForTicketCell
@synthesize clickButton;
@synthesize cellView;
@synthesize cellPrice, cellTitle, celldate, cellCities;

- (void)dealloc
{
    self.clickButton = nil;
    self.cellTitle = nil;
    self.celldate = nil;
    self.cellCities = nil;
    self.cellPrice = nil;
    self.cellView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clickButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(10, 0, ViewWidth - 20, 60) backImage:[UIImage imageNamed:@"酒店.png"] target:nil action:nil];
        
        [self addSubview:self.clickButton];
        
        self.cellTitle = [UISubLabel labelWithTitle:@"中国国航CA2586" frame:CGRectMake(50, 7, 140, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.cellPrice = [UISubLabel labelWithTitle:@"单程820元" frame:CGRectMake(180, 30, 140, 20) font:FontSize24 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        self.cellCities = [UISubLabel labelWithTitle:@"北京-乌鲁木齐" frame:CGRectMake(180, 7, 140, 20) font:FontSize28 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.celldate = [UISubLabel labelWithTitle:@"2012-10-31" frame:CGRectMake(50, 30, 140, 20) font:FontSize20 color:FontColor454545 alignment:NSTextAlignmentLeft];
        self.cellView = [UIImageView ImageViewWithFrame:CGRectMake(20, 15, 25, 25) image:[UIImage imageNamed:@"MU.png"]];
        
        [self addSubview:self.cellTitle];
        [self addSubview:self.cellPrice];
        [self addSubview:self.cellView];
        [self addSubview:self.celldate];
        [self addSubview:self.cellCities];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end


@implementation HotelPayForSuccessCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 110) image:[UIImage imageNamed:@"头.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"预订成功！" frame:CGRectMake(40, 10, ViewWidth-80, 30) font:FontBlodSize42 color:FontColorFF8813 alignment:NSTextAlignmentCenter]];
        [self addSubview:[UISubLabel labelWithTitle:@"到达酒店时，持有有效证件，报预订时填写的入住人姓名办理入住。您可以登录“会员”，进入“酒店订单管理”操作修改/取消，也可以致电400-6858-999人工操作。" frame:CGRectMake(20, 45, ViewWidth - 40, 20) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft autoSize:YES]];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@implementation CarPayForSuccessCell
@synthesize depositLable;

- (void)dealloc
{
    self.depositLable = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 155) image:[UIImage imageNamed:@"头.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"预订成功！" frame:CGRectMake(40, 10, ViewWidth-80, 30) font:FontBlodSize42 color:FontColorFF8813 alignment:NSTextAlignmentCenter]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"重要提示：" frame:CGRectMake(20, 40, ViewWidth-40, 20) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        self.depositLable = [UISubLabel labelWithTitle:@"1.取车时请携带本人有效身份证、驾照、本人信用卡/借记卡，取车时会冻结/刷取3000元租车预授权/押金" frame:CGRectMake(20, 65, ViewWidth-40, 40) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft autoSize:YES];
        
        [self addSubview:[UISubLabel labelWithTitle:@"2.请在2小时内致电4006166666取消订单" frame:CGRectMake(20, 100, ViewWidth-40, 20) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft autoSize:YES]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"2.请在2小时内致电4006166666修改订单，逾期不能修改" frame:CGRectMake(20, 120, ViewWidth-40, 20) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft autoSize:YES]];
        
        [self addSubview:self.depositLable];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end
