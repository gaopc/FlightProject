//
//  OrderTicketInfoCell.m
//  FlightProject
//
//  Created by 高鹏程 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderTicketInfoCell.h"

@implementation OrderTicketInfoCell

@synthesize ticketName, userName, paperwork, paperworkNum;

- (void)dealloc
{
    self.ticketName = nil;
    self.userName = nil;
    self.paperwork = nil;
    self.paperworkNum = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 50) image:[UIImage imageNamed:@"航班动态向下拉伸"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 14, 12, 15) image:[UIImage imageNamed:@"用户icon.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 34, 13, 15) image:[UIImage imageNamed:@"证件icon.png"]]];
        
        self.userName = [UISubLabel labelWithTitle:@"凡尘" frame:CGRectMake(50, 10, 165, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self.ticketName = [UISubLabel labelWithTitle:@"成人票" frame:CGRectMake(215, 12, 60, 20) font:FontSize20 color:FontColor656565 alignment:NSTextAlignmentRight];
        
        self.paperwork = [UISubLabel labelWithTitle:@"身份证" frame:CGRectMake(50, 30, 80, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self.paperworkNum = [UISubLabel labelWithTitle:@"150204189209081829" frame:CGRectMake(100, 30, 200, 20) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self.userName];
        [self addSubview:self.ticketName];
        [self addSubview:self.paperwork];
        [self addSubview:self.paperworkNum];
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

@implementation OrderTicketClickCell
@synthesize moveButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth-20, 20) image:[UIImage imageNamed:@"航班动态向下拉伸"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth-20, 1) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"乘机人信息" frame:CGRectMake(22, 5, 70, 15) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        self.moveButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake((ViewWidth - 54)/2, 0, 54, 10) backImage:[UIImage imageNamed:@"抽屉.png"] target:nil action:nil];
        
//        [self addSubview:self.moveButton];
        
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc
{
    self.moveButton = nil;
    [super dealloc];
}
@end

@implementation OrderTicketPhoneCell
@synthesize telNum;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 70) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 10, ViewWidth - 43, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 43, 12, 15) image:[UIImage imageNamed:@"手机icon.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"联系方式" frame:CGRectMake(22, 17, 100, 20) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        self.telNum = [UISubLabel labelWithTitle:@"13801012345" frame:CGRectMake(45, 40, 100, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self.telNum];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc
{
    self.telNum = nil;
    [super dealloc];
}

@end

@implementation OrderTicketAddresCell

@synthesize ticketType, ticketState, ticketAddress, _ifPrint;
@synthesize positionButton;
@synthesize areaView, addView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        self.areaView = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 100) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]];
        
        [self addSubview:self.areaView];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 2, ViewWidth - 43, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        self.addView = [UIImageView ImageViewWithFrame:CGRectMake(30, 38, 12, 15) image:[UIImage imageNamed:@"地址icon.png"]];
        
        self.ticketType = [UISubLabel labelWithTitle:@"" frame:CGRectMake(22, 12, 100, 20) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft];
        
        self.ticketState = [UISubLabel labelWithTitle:@"" frame:CGRectMake(45, 35, 100, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self.ticketAddress = [UISubLabel labelWithTitle:@"" frame:CGRectMake(45, 58, ViewWidth - 80, 40) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.positionButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"查终端机位置" backImage:nil frame:CGRectMake(ViewWidth - 120, 35, 100, 20) font:FontSize22 color:FontColor2B8DD0 target:nil action:nil];
        self.positionButton.hidden = YES;
        
        self._ifPrint = [UISubLabel labelWithTitle:@"" frame:CGRectMake(45, 58, ViewWidth - 60, 20) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self.addView];
        [self addSubview:self.positionButton];
        [self addSubview:self.ticketType];
        [self addSubview:self.ticketState];
        [self addSubview:self.ticketAddress];
        [self addSubview:self._ifPrint];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc
{
    self._ifPrint = nil;
    self.areaView = nil;
    self.ticketState = nil;
    self.ticketType = nil;
    self.ticketAddress = nil;
    [super dealloc];
}

@end

@implementation OrderTicketServiceCell

@synthesize serviceState;
@synthesize moreButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 65) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 5, ViewWidth - 43, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 65, ViewWidth - 20, 5) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30, 38, 12, 15) image:[UIImage imageNamed:@"降价icon.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"自动降价服务" frame:CGRectMake(22, 12, 100, 20) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        self.serviceState = [UISubLabel labelWithTitle:@"已选取服务" frame:CGRectMake(45, 35, 90, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"了解更多" frame:CGRectMake(ViewWidth - 87, 35, 55, 20) font:FontSize22 color:FontColor2585CF target:nil action:nil];
        [self.moreButton setTitleColor:FontColor636363 forState:UIControlStateHighlighted];
        
        [self addSubview:self.serviceState];
        [self addSubview:self.moreButton];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc
{
    self.serviceState = nil;
    self.moreButton = nil;
    [super dealloc];
}

@end

@implementation OrderTicketTotalMoneyCell

@synthesize priceLab;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 40) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(17, 0, ViewWidth - 34, 40) backgroundColor:FontColorFFFFFF]];
        
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(17, 7, ViewWidth - 34, 1) backgroundColor:FontColorFF8813]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"总价" frame:CGRectMake(ViewWidth - 140, 20, 40, 15) font:FontSize26 color:FontColor696969 alignment:NSTextAlignmentRight]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 95, 20, 11, 12) image:[UIImage imageNamed:@"符号.png"]]];
        self.priceLab = [UISubLabel labelWithTitle:@"1450" frame:CGRectMake(ViewWidth - 80, 10, 100, 30) font:FontSize40 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self.priceLab];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)dealloc
{
    self.priceLab = nil;
    [super dealloc];
}

@end

@implementation OrderTicketTitleCell

@synthesize titleLab, contentLab;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 40) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(17, 0, ViewWidth - 34, 40) backgroundColor:FontColorFFFFFF]];
        
        self.titleLab = [UISubLabel labelWithTitle:@"成人单程：" frame:CGRectMake(22, 5, 120, 15) font:FontSize22 color:FontColor696969 alignment:NSTextAlignmentLeft];
        self.contentLab = [UISubLabel labelWithTitle:@"（机票 ￥880 + 机建燃油 ￥80 + 保险 ￥20）* 2张" frame:CGRectMake(20, 20, ViewWidth - 35, 15) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentLeft];

        [self addSubview:self.titleLab];
        [self addSubview:self.contentLab];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)dealloc
{
    self.contentLab = nil;
    self.titleLab = nil;
    [super dealloc];
}
@end

@implementation OrderTicketHeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 20) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(17, 14, ViewWidth - 34, 6) backgroundColor:FontColorFFFFFF]];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end


@implementation OrderTicketWaitManCell
@synthesize _waiterName, _waiterPhone;

- (void)dealloc
{
    self._waiterPhone = nil;
    self._waiterName = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 60) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 10, ViewWidth - 43, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        
        [self addSubview:[UISubLabel labelWithTitle:@"接机人" frame:CGRectMake(22, 17, 100, 20) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        self._waiterName = [UISubLabel labelWithTitle:@"无" frame:CGRectMake(30, 40, 100, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._waiterPhone = [UISubLabel labelWithTitle:@"" frame:CGRectMake(100, 40, 100, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._waiterName];
        [self addSubview:self._waiterPhone];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end


@implementation OrderTicketDoubleWaitManCell
@synthesize _waiterName, _waiterPhone, _waiterName1, _waiterPhone1;

- (void)dealloc
{
    self._waiterPhone = nil;
    self._waiterName = nil;
    self._waiterPhone1 = nil;
    self._waiterName1 = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 85) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 10, ViewWidth - 43, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]]];
        
        
        [self addSubview:[UISubLabel labelWithTitle:@"接机人" frame:CGRectMake(22, 17, 100, 20) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"去程接机人" frame:CGRectMake(30, 40, 100, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        self._waiterName = [UISubLabel labelWithTitle:@"无" frame:CGRectMake(120, 40, 100, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._waiterPhone = [UISubLabel labelWithTitle:@"" frame:CGRectMake(180, 40, 100, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UISubLabel labelWithTitle:@"返程接机人" frame:CGRectMake(30, 63, 100, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        self._waiterName1 = [UISubLabel labelWithTitle:@"无" frame:CGRectMake(120, 63, 100, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._waiterPhone1 = [UISubLabel labelWithTitle:@"" frame:CGRectMake(180, 63, 100, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._waiterName];
        [self addSubview:self._waiterPhone];
        [self addSubview:self._waiterName1];
        [self addSubview:self._waiterPhone1];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end