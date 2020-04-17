//
//  OrderTicketToPerchCell.m
//  FlightProject
//
//  Created by 高鹏程 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderTicketToPerchCell.h"

@implementation OrderTicketToPerchCell
@synthesize departureCity, arrCity, departureDate, arrDate, departureTime, companyName, roomLab, _stateName;
@synthesize pointView, companyView, stateImgView, lineView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    { 
        self.departureCity = [UISubLabel labelWithTitle:@"北京" frame:CGRectMake(20, 7, 60, 20) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.arrCity = [UISubLabel labelWithTitle:@"上海" frame:CGRectMake(80, 7, 60, 20) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.departureDate = [UISubLabel labelWithTitle:@"15:25" frame:CGRectMake(20, 27, 60, 20) font:FontSize24 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        self.arrDate = [UISubLabel labelWithTitle:@"17:18" frame:CGRectMake(80, 27, 60, 20) font:FontSize24 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        self.companyName = [UISubLabel labelWithTitle:@"MU5162" frame:CGRectMake(ViewWidth - 105, 7, 100, 20) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.departureTime = [UISubLabel labelWithTitle:@"2012-08-16" frame:CGRectMake((ViewWidth - 75)/2, 27, 75, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        
        self.roomLab = [UISubLabel labelWithTitle:@"钻石豪华头等舱(F)" frame:CGRectMake(ViewWidth - 120, 27, 100, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentRight];
        
        self.pointView = [UIImageView ImageViewWithFrame:CGRectMake(55, 29, 14, 12) image:[UIImage imageNamed:@"指向.png"]];
        
        self.companyView = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 120, 10, 15, 15) image:[UIImage imageNamed:@"MU.png"]];
        
//        self.stateImgView = [UIImageView ImageViewWithFrame:CGRectMake(136, 10, 47, 15) image:[UIImage imageNamed:@""]];
        
        self._stateName = [UISubLabel labelWithTitle:@"单程" frame:CGRectMake((ViewWidth - 80)/2, 7, 80, 20) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentCenter];
        
        self.lineView = [UIImageView ImageViewWithFrame:CGRectMake(12, 50, ViewWidth - 24, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]];
        
        [self addSubview:self.roomLab];
        [self addSubview:self.companyName];
        [self addSubview:self.departureTime];
        [self addSubview:self.companyView];
        [self addSubview:self.pointView];
        [self addSubview:self.arrCity];
        [self addSubview:self.departureCity];
        [self addSubview:self.departureDate];
        [self addSubview:self.arrDate];
        [self addSubview:self.stateImgView];
        [self addSubview:self.lineView];
        [self addSubview:self._stateName];
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
    self._stateName = nil;
    self.departureCity = nil;
    self.arrCity = nil;
    self.departureDate = nil;
    self.arrDate = nil;
    self.departureTime = nil;
    self.companyName = nil;
    self.companyView = nil;
    self.pointView = nil;
    self.stateImgView = nil;
    self.lineView = nil;
    
    [super dealloc];
}
@end

@implementation OrderTicketToPerchDoubleCell
@synthesize departureCity, arrCity, departureDate, arrDate, departureTime, companyName, roomLab, planModels, airport1, airport2, _stateName;
@synthesize pointView, companyView, stateImgView, lineView;
@synthesize ruleButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    { 
        self.departureTime = [UISubLabel labelWithTitle:@"2012-08-16" frame:CGRectMake((ViewWidth - 75)/2, 77, 75, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter];
        
        self.companyName = [UISubLabel labelWithTitle:@"MU5162" frame:CGRectMake(ViewWidth - 105, 7, 100, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self.companyView = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 120, 10, 15, 15) image:[UIImage imageNamed:@"MU.png"]];
        
        self.planModels = [UISubLabel labelWithTitle:@"中型机 空客330" frame:CGRectMake(20, 7, 150, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(12, 30, 120, 46) image:[UIImage imageNamed:@"背景框.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 132, 30, 120, 46) image:[UIImage imageNamed:@"背景框.png"]]];
        
        self.departureCity = [UISubLabel labelWithTitle:@"北京" frame:CGRectMake(22, 35, 60, 20) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self.arrCity = [UISubLabel labelWithTitle:@"上海" frame:CGRectMake(ViewWidth - 122, 35, 60, 20) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self.departureDate = [UISubLabel labelWithTitle:@"15:25" frame:CGRectMake(65, 38, 60, 20) font:FontSize22 color:FontColor2387CF alignment:NSTextAlignmentRight];
        
        self.arrDate = [UISubLabel labelWithTitle:@"17:18" frame:CGRectMake(ViewWidth - 80, 38, 60, 20) font:FontSize22 color:FontColor2387CF alignment:NSTextAlignmentRight];
        
        self.airport1 = [UISubLabel labelWithTitle:@"乌鲁木齐机场T2" frame:CGRectMake(22, 55, 150, 20) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        
        self.airport2 = [UISubLabel labelWithTitle:@"浦东国际机场T1" frame:CGRectMake(ViewWidth - 122, 55, 150, 20) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        
        self.roomLab = [UISubLabel labelWithTitle:@"钻石豪华头等舱(F)" frame:CGRectMake(ViewWidth - 120, 77, 100, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentRight];
        
        self.ruleButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"退改签规则" backImage:nil frame:CGRectMake(12, 77, 100, 20) font:FontSize24 color:FontColor333333 target:nil action:nil];
        [self.ruleButton setImage:[UIImage imageNamed:@"箭头.png"] forState:UIControlStateNormal];
        [self.ruleButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 85)];
        
        self.pointView = [UIImageView ImageViewWithFrame:CGRectMake((ViewWidth - 28)/2, 33, 28, 24) image:[UIImage imageNamed:@"指向.png"]];
        
        self.stateImgView = [UIImageView ImageViewWithFrame:CGRectMake(136, 10, 47, 15) image:[UIImage imageNamed:@""]];
        self._stateName = [UISubLabel labelWithTitle:@"单程" frame:CGRectMake((ViewWidth - 80)/2, 7, 80, 20) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentCenter];
        
        self.lineView = [UIImageView ImageViewWithFrame:CGRectMake(12, 100, ViewWidth - 24, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]];
        
        [self addSubview:self.roomLab];
        [self addSubview:self.companyName];
        [self addSubview:self.departureTime];
        [self addSubview:self.companyView];
        [self addSubview:self.pointView];
        [self addSubview:self.arrCity];
        [self addSubview:self.departureCity];
        [self addSubview:self.departureDate];
        [self addSubview:self.arrDate];
        [self addSubview:self.stateImgView];
        [self addSubview:self.planModels];
        [self addSubview:self.airport1];
        [self addSubview:self.airport2];
        [self addSubview:self.ruleButton];
        [self addSubview: self.lineView];
        [self addSubview:self._stateName];
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
    self._stateName = nil;
    self.roomLab = nil;
    self.companyName = nil;
    self.departureTime = nil;
    self.companyView = nil;
    self.pointView = nil;
    self.arrCity = nil;
    self.departureCity = nil;
    self.departureDate = nil;
    self.arrDate = nil;
    self.stateImgView = nil;
    self.planModels = nil;
    self.airport1 = nil;
    self.airport2 = nil;
    self.ruleButton = nil;
    self.lineView = nil;
    
    [super dealloc];
}
@end

@implementation OrderTicketPriceCell
@synthesize totalLab, returnCoinLab, totalMoneyCoinLab, moneyLab, ticketLab, fuelLab, insuranceLab, arrMoneyLab, twoFuelLab;
@synthesize areaView, _arrowView;
@synthesize cellButton, moveButton;
@synthesize _returnLcdView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        CGRect viewFrame = CGRectMake(12, -8, ViewWidth - 24, 240);
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 5) image:[UIImage imageNamed:@"航班动态顶.png"]]];
        self.areaView = [UIImageView ImageViewWithFrame:CGRectMake(10, 5, ViewWidth - 20, 100) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]];
        
        [self addSubview:self.areaView];
        
        self.cellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cellButton setBackgroundImage:[UIImage imageNamed:@"机票支付信息.png"] forState:UIControlStateNormal];
        self.cellButton.frame = CGRectMake(viewFrame.origin.x + 2, viewFrame.origin.y + 30, viewFrame.size.width - 4, 70);
        
        [self addSubview:self.cellButton];
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(22, viewFrame.origin.y + 75, 115, 22)];
        self._returnLcdView = view;
        [view release];
        [self._returnLcdView addSubview:[UISubLabel labelWithTitle:@"返畅达币" frame:CGRectMake(0, 0, 60, 20) font:FontSize24 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        [self._returnLcdView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(48, 0, 52, 22) image:[UIImage imageNamed:@"返畅达币.png"]]];
        self.returnCoinLab = [UISubLabel labelWithTitle:@"50" frame:CGRectMake(50, 1, 32, 17) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentRight];
        [self._returnLcdView addSubview:self.returnCoinLab];
        
        
        self.moveButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake((ViewWidth - 54)/2, viewFrame.origin.y + 8, 54, 10) backImage:[UIImage imageNamed:@"抽屉.png"] target:nil action:nil];
        
        self.totalLab = [UISubLabel labelWithTitle:@"总价" frame:CGRectMake(22, viewFrame.origin.y + 35, 50, 20) font:FontSize24 color:FontColor636363 alignment:NSTextAlignmentLeft];

        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(22, viewFrame.origin.y + 59, 11, 12) image:[UIImage imageNamed:@"符号.png"]]];
        
        self.totalMoneyCoinLab = [UISubLabel labelWithTitle:@"1450" frame:CGRectMake(37, viewFrame.origin.y + 53, 80, 20) font:FontSize42 color:FontColorFF8813 alignment:NSTextAlignmentLeft];

        self.ticketLab = [UISubLabel labelWithTitle:@"票价：￥880（1张）" frame:CGRectMake(135, viewFrame.origin.y + 35, 200, 20) font:FontSize22 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self.arrMoneyLab = [UISubLabel labelWithTitle:@"返程票价：￥880（1张）" frame:CGRectMake(135, viewFrame.origin.y + 35, 200, 0) font:FontSize22 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.arrMoneyLab.hidden = YES;
        
        self.fuelLab = [UISubLabel labelWithTitle:@"一程机建燃油费：￥180（1份）" frame:CGRectMake(135, viewFrame.origin.y + 55, 200, 20) font:FontSize22 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self.twoFuelLab = [UISubLabel labelWithTitle:@"二程机建燃油费：￥180（1份）" frame:CGRectMake(135, viewFrame.origin.y + 55, 200, 20) font:FontSize22 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.twoFuelLab.hidden = YES;
        
        self.insuranceLab = [UISubLabel labelWithTitle:@"保险：20（1份）" frame:CGRectMake(135, viewFrame.origin.y + 75, 200, 20) font:FontSize22 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self._arrowView = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 35, viewFrame.origin.y + 65, 7, 11) image:[UIImage imageNamed:@"航班动态列表下级.png"]];
        
        [self addSubview:self.totalLab];
//        [self addSubview:self.returnCoinLab];
        [self addSubview:self.totalMoneyCoinLab];
        [self addSubview:self.moneyLab];
        [self addSubview:self.ticketLab];
        [self addSubview:self.fuelLab];
        [self addSubview:self.insuranceLab];
        [self addSubview:self.moveButton];
        [self addSubview:self.arrMoneyLab];
        [self addSubview:self._arrowView];
        [self addSubview:self.twoFuelLab];
        [self addSubview:self._returnLcdView];
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
    self.twoFuelLab = nil;
    self.areaView = nil;
    self.cellButton = nil;
    self.totalLab = nil;
    self.returnCoinLab = nil;
    self.totalMoneyCoinLab = nil;
    self.moneyLab = nil;
    self.ticketLab = nil;
    self.fuelLab = nil;
    self.moveButton = nil;
    self.insuranceLab = nil;
    self.arrMoneyLab = nil;
    self._returnLcdView = nil;
    [super dealloc];
}
@end

@implementation OrderTicketPrice2Cell
@synthesize ownCoinLab, remainderLab;
@synthesize areaView;
@synthesize coinFiled;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        self.areaView = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 105) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]];
        
        [self addSubview:self.areaView];
        
        [self addSubview:[UISubLabel labelWithTitle:@"使用畅达币支付" frame:CGRectMake(25, 2, 200, 20) font:FontSize24 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        
        self.ownCoinLab = [UISubLabel labelWithTitle:@"可使用 10000 畅达币" frame:CGRectMake(25, 20, 200, 20) font:FontSize20 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        
        self.coinFiled = [UISubTextField TextFieldWithFrame:CGRectMake(125, 2, 130, 40) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"" font:FontSize50];
        self.coinFiled.text = @"0";
        self.coinFiled.background = [UIImage imageNamed:@"畅达币录入.png"];
        self.coinFiled.textAlignment = NSTextAlignmentCenter;
        self.coinFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.coinFiled.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        self.coinFiled.keyboardType = UIKeyboardTypeNumberPad;	// use the default type input method (entire keyboard)
        self.coinFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        [self addSubview:[UISubLabel labelWithframe:CGRectMake(25, 65, ViewWidth - 50,1) backgroundColor:[UIColor lightGrayColor]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"实际支付金额：" frame:CGRectMake(ViewWidth/2 - 140 + 5, 80, 140, 30) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentRight]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth/2 + 5, 90, 11, 12) image:[UIImage imageNamed:@"符号.png"]]];
        
        self.remainderLab = [UISubLabel labelWithTitle:@"30" frame:CGRectMake(ViewWidth/2 + 20, 74, 240, 40) font:FontSize42 color:FontColorF94C00 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self.ownCoinLab];
        [self addSubview:self.coinFiled];
        [self addSubview:self.remainderLab];
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
    self.areaView = nil;
    self.ownCoinLab = nil;
    self.coinFiled = nil;
    self.remainderLab = nil;
    [super dealloc];
}
@end

@interface PayUIButton()
@property (nonatomic,retain) UIImageView * _imageV;
@property (nonatomic,retain) UILabel * _textLab;

@end

@implementation PayUIButton

@synthesize _imageV,_textLab,_button;
@synthesize _level;
- (void)dealloc
{
    self._imageV = nil;
    self._textLab = nil;
    self._button = nil;
    self._level = 0;

    [super dealloc];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        CGFloat imageVHeight = 30;
        
        self._imageV = [UIImageView ImageViewWithFrame:CGRectMake(30,( frame.size.height-imageVHeight)/2, imageVHeight, imageVHeight) image:[UIImage imageNamed:@"58.png"]];
        self._textLab = [UILabel labelWithTitle:@"银联支付" frame:CGRectMake(40+imageVHeight,0,frame.size.width-(40+imageVHeight),frame.size.height) font:[UIFont systemFontOfSize:15] color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        self._button = [UIButton buttonWithTag:0 frame:self.bounds target:nil action:nil];
        [self addSubview:self._imageV];
        [self addSubview:self._textLab];
        [self addSubview:self._button];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(30,frame.size.height-1,frame.size.width-(30)-15,1) image:[UIImage imageNamed:@"分割线支付.png"]]];
        return self;
    }
    return nil;
}
+(PayUIButton *) buttonWithFrame:(CGRect)frame tag:(NSInteger)tag Image:(UIImage *)img text:(NSString *)str
{
    PayUIButton * sender = [[PayUIButton alloc] initWithFrame:frame];
    sender.tag = tag;
    sender._imageV.image = img;
    sender._textLab.text = str;
    sender._button.tag = tag;
    return [sender autorelease];
}
@end

@implementation OrderTicket3Cell
@synthesize leftButton,rightButton, otherButton, telButton, cardButton,weixinButton;
@synthesize _backGroundView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
//        int offx = (ViewWidth - 320)/2;
        self._backGroundView = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 250) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]];
        
        UISubLabel *noticLab = [UISubLabel labelWithTitle:@"请您在15分钟内完成支付，否则订单会被自动取消。" frame:CGRectMake(0, 0, ViewWidth, 20) font:FontSize24 color:[UIColor redColor] alignment:NSTextAlignmentCenter];
        
        self.leftButton =[PayUIButton buttonWithFrame:CGRectMake(0, 25, ViewWidth, 45) tag:1 Image:[UIImage imageNamed:@"支付宝支付.png"] text:@"支付宝支付"] ;
        self.rightButton =[PayUIButton buttonWithFrame:CGRectMake(0, 70, ViewWidth, 45) tag:2 Image:[UIImage imageNamed:@"银联支付.png"] text:@"银联支付"] ;
        self.weixinButton =[PayUIButton buttonWithFrame:CGRectMake(0, 115, ViewWidth, 45) tag:5 Image:[UIImage imageNamed:@"微信支付.png"] text:@"微信支付"] ;
        self.cardButton =[PayUIButton buttonWithFrame:CGRectMake(0, 160, ViewWidth, 45) tag:3 Image:[UIImage imageNamed:@"信用卡支付.png"] text:@"信用卡支付"] ;
        self.telButton =[PayUIButton buttonWithFrame:CGRectMake(0, 205, ViewWidth, 45) tag:4 Image:[UIImage imageNamed:@"电话支付.png"] text:@"电话支付"] ;

        self.rightButton._level = 0;     //排序
        self.weixinButton._level = 1;
        self.telButton._level = 2;
        self.leftButton._level = 3;
        self.cardButton._level = 4;
        
        
        
//        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"" frame:CGRectMake(20 + offx, 27, 136, 33) backImage:[UIImage imageNamed:@"支付宝支付.png"] target:nil action:nil];
//        
//        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"" frame:CGRectMake(164 + offx, 27, 136, 33) backImage:[UIImage imageNamed:@"银联支付.png"] target:nil action:nil];
//        
//        self.cardButton = [UIButton buttonWithType:UIButtonTypeCustom tag:3 title:@"" frame:CGRectMake(20 + offx, 75, 136, 33) backImage:[UIImage imageNamed:@"行用卡支付.png"] target:nil action:nil];
//        
//        self.telButton = [UIButton buttonWithType:UIButtonTypeCustom tag:4 title:@"" frame:CGRectMake(164 + offx, 75, 136, 33) backImage:[UIImage imageNamed:@"电话支付.png"] target:nil action:nil];
//        
//        self.weixinButton = [UIButton buttonWithType:UIButtonTypeCustom tag:5 title:@"" frame:CGRectMake(20 + offx, 75, 136, 33) backImage:[UIImage imageNamed:@"微信支付.png"] target:nil action:nil];

        
//        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 130, 300, 5) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        
//        self.otherButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"" frame:CGRectMake(17, 75, 286, 56) backImage:[UIImage imageNamed:@"其他支付.png"] target:nil action:nil];
//        
//        [self addSubview:self.otherButton];
        
//        [self addSubview:[UISubLabel labelWithTitle:@"选择其他方式支付" frame:CGRectMake(25, 93, 180, 20) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        
        self.leftButton.hidden = YES;
        self.rightButton.hidden = YES;
        self.cardButton.hidden = YES;
        self.telButton.hidden = YES;
        self.weixinButton.hidden = YES;
        
        [self addSubview:self._backGroundView];
        [self addSubview:noticLab];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.weixinButton];
        [self addSubview:self.telButton];
        [self addSubview:self.cardButton];
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
    self.rightButton = nil;
    self.leftButton = nil;
    self.otherButton = nil;
    self.cardButton = nil;
    self.telButton = nil;
    self._backGroundView = nil;
    [super dealloc];
}
@end

@implementation OrderTicketPayCell
@synthesize payButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {   
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 65) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
//        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 65, ViewWidth - 20, 5) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        
        self.payButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"" frame:CGRectMake((ViewWidth - 136)/2, 27, 136, 33) backImage:[UIImage imageNamed:@"机票支付.png"] target:nil action:nil];
        
        [self addSubview:self.payButton];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)dealloc
{
    self.payButton = nil;
    [super dealloc];
}
@end

@implementation OrderTicketCancelCell
@synthesize cancelButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {   
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, -5, ViewWidth - 20, 60) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        //        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 55, ViewWidth - 20, 5) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"" frame:CGRectMake((ViewWidth - 136)/2, 12, 136, 33) backImage:[UIImage imageNamed:@"取消订单.png"] target:nil action:nil];
        
        [self addSubview:self.cancelButton];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)dealloc
{
    self.cancelButton = nil;
    [super dealloc];
}
@end

