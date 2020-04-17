//
//  CarListCell.m
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarListCell.h"

@implementation CarListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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

@implementation CarListHeaderCell

@synthesize _picImageV,_insurance,_typeName,_typeDesc,_dayPrice,_modeLevel,_preAuthorization;
@synthesize _packageBodyView, _packageTitleView;
-(void)dealloc
{
    self._picImageV = nil;
    self._insurance = nil;
    self._typeName = nil;
    self._typeDesc = nil;
    self._dayPrice = nil;
    self._modeLevel = nil;
    self._preAuthorization = nil;
    self._packageBodyView = nil;
    self._packageTitleView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        AsyncImageView *asyncImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(15, 26, 92.5, 34)];
        self._picImageV = asyncImageView;
        [asyncImageView release];
        self._insurance = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 55, 100, 22) font:FontSize24 color:FontColor696969 alignment:NSTextAlignmentLeft];
        self._typeName = [UISubLabel labelWithTitle:nil frame:CGRectMake(110, 5, 115, 30) font:FontSize32 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        self._typeDesc = [UISubLabel labelWithTitle:nil frame:CGRectMake(110, 32, 115, 20) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._preAuthorization = [UISubLabel labelWithTitle:nil frame:CGRectMake(85, 55, 135, 22) font:FontSize24 color:FontColor696969 alignment:NSTextAlignmentRight];
        self._dayPrice = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 115, 23, 77, 30) font:FontBlodSize42 color:FontColorFF8813 alignment:NSTextAlignmentRight];
        
        self._modeLevel = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 82, 55, 70, 20) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
        self._modeLevel.numberOfLines = 1;
        self._modeLevel.minimumFontSize = 10;
        self._modeLevel.adjustsFontSizeToFitWidth = YES;

        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(8, 0, ViewWidth - 15, 80) image:[UIImage imageNamed:@"租车列表.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 33, 0, 22, 22) image:[UIImage imageNamed:@"省钱.png"]]];
        
        [self addSubview:self._picImageV];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 82, 55, 70, 20) image:[UIImage imageNamed:@"CarListModeLevel.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(15, 56, ViewWidth - 110, 1) image:[UIImage imageNamed:@"cabinDottedLine.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"日均价" frame:CGRectMake(ViewWidth - 90, 3, 70, 30) font:FontSize26 color:FontColorFF8813 alignment:NSTextAlignmentRight]];
        //[self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(222, 34, 11, 12) image:[UIImage imageNamed:@"符号.png"]]];
        
        [self addSubview:self._insurance];
        [self addSubview:self._typeName];
        [self addSubview:self._typeDesc];
        [self addSubview:self._preAuthorization];
        [self addSubview:self._dayPrice];
        [self addSubview:self._modeLevel];
        
        [self addSubview:[UISubLabel labelWithTitle:@"/天" frame:CGRectMake(ViewWidth - 37, 30, 30, 20) font:FontSize26 color:FontColorFF8813 alignment:NSTextAlignmentLeft]];
        
        self._packageTitleView = [[CarPackageTitleView alloc] initWithFrame:CGRectMake(10, 76, ViewWidth - 15, 30)];
        self._packageBodyView = [[CarPackageBodyView alloc] initWithFrame:CGRectMake(0, 78, ViewWidth, 70)];
        self._packageTitleView.hidden = YES;
        self._packageBodyView.hidden = YES;        
        [self addSubview:self._packageTitleView];
        [self addSubview:self._packageBodyView];
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

@implementation CarListHeader2Cell

@synthesize _insurance,_modelLevelName,_modeLevel,_preAuthorization;
-(void)dealloc
{
    self._insurance = nil;
    self._modelLevelName = nil;
    self._modeLevel = nil;
    self._preAuthorization = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self._modelLevelName = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 0, 250, 30) font:FontSize36 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        self._insurance = [UISubLabel labelWithTitle:nil frame:CGRectMake(20, 30, 100, 22) font:FontSize24 color:FontColor696969 alignment:NSTextAlignmentLeft];
        self._preAuthorization = [UISubLabel labelWithTitle:nil frame:CGRectMake(85, 30, 135, 22) font:FontSize24 color:FontColor696969 alignment:NSTextAlignmentRight];
        self._modeLevel = [UISubLabel labelWithTitle:nil frame:CGRectMake(238, 28, 70, 20) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
        self._modeLevel.numberOfLines = 1;
        self._modeLevel.minimumFontSize = 10;
        self._modeLevel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 52) image:[UIImage imageNamed:@"carStoreName.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 82, 28, 70, 20) image:[UIImage imageNamed:@"CarListModeLevel.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(15, 29, ViewWidth - 110, 1) image:[UIImage imageNamed:@"cabinDottedLine.png"]]];

        [self addSubview:self._insurance];
        [self addSubview:self._preAuthorization];
        [self addSubview:self._modelLevelName];
        [self addSubview:self._modeLevel];
        
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

@implementation CarListBodyCell

@synthesize _picImageV,_insurance,_typeName,_typeDesc,_dayPrice,_preAuthorization, _payDays;
@synthesize _areaView, _dottedView;
@synthesize _packageBodyView, _packageTitleView;
-(void)dealloc
{
    self._dottedView = nil;
    self._areaView = nil;
    self._picImageV = nil;
    self._insurance = nil;
    self._typeName = nil;
    self._typeDesc = nil;
    self._dayPrice = nil;
    self._preAuthorization = nil;
    self._payDays = nil;
    
    self._packageBodyView = nil;
    self._packageTitleView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        self._areaView = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 78) image:[UIImage imageNamed:@"carStoreAddressName.png"]];
        [self addSubview:self._areaView];
        AsyncImageView *asyncImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(15, 26, 92.5, 34)];
        self._picImageV = asyncImageView;
        [asyncImageView release];
        
        self._typeName = [UISubLabel labelWithTitle:nil frame:CGRectMake(110, 8, 150, 30) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._typeDesc = [UISubLabel labelWithTitle:nil frame:CGRectMake(110, 35, 150, 20) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._insurance = [UISubLabel labelWithTitle:nil frame:CGRectMake(110, 52, 100, 22) font:FontSize22 color:FontColor696969 alignment:NSTextAlignmentLeft];
        
        self._dayPrice = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 115, 27, 77, 30) font:FontBlodSize42 color:FontColorFF8813 alignment:NSTextAlignmentRight];
        self._preAuthorization = [UISubLabel labelWithTitle:nil frame:CGRectMake(0, 53, ViewWidth - 20, 22) font:FontSize22 color:FontColor696969 alignment:NSTextAlignmentRight];
        
        self._dottedView = [UIImageView ImageViewWithFrame:CGRectMake(15, 77, ViewWidth - 30, 1) image:[UIImage imageNamed:@"cabinDottedLine.png"]];

        self._payDays = [UISubLabel labelWithTitle:@"/天" frame:CGRectMake(ViewWidth - 37, 30, 30, 30) font:FontSize26 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UISubLabel labelWithTitle:@"日均价" frame:CGRectMake(ViewWidth - 90, 7, 70, 30) font:FontSize26 color:FontColorFF8813 alignment:NSTextAlignmentRight]];
        
        self._packageTitleView = [[CarPackageTitleView alloc] initWithFrame:CGRectMake(10, 76, ViewWidth - 15, 28)];
        self._packageBodyView = [[CarPackageBodyView alloc] initWithFrame:CGRectMake(0, 80, ViewWidth, 69)];
        self._packageTitleView.hidden = YES;
        self._packageBodyView.hidden = YES;
        
        [self addSubview:self._picImageV];
        [self addSubview:self._insurance];
        [self addSubview:self._typeName];
        [self addSubview:self._typeDesc];
        [self addSubview:self._preAuthorization];
        [self addSubview:self._dayPrice];
        [self addSubview:self._dottedView];
        [self addSubview:self._payDays];
        [self addSubview:self._packageTitleView];
        [self addSubview:self._packageBodyView];
        
//        self._packageOpen = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"周租套餐230元/天" backImage:[UIImage imageNamed:@"CarListModeLevel.png"] frame:CGRectMake(110, 73, 195, 25) font:FontSize24 color:FontColorFFFFFF target:nil action:nil];
//        self._packageClose = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" backImage:[UIImage imageNamed:@"navigationBar.png"] frame:CGRectMake(15, 95, 40, 50) font:FontSize24 color:FontColorFFFFFF target:nil action:nil];
//        self._selectPackage = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" backImage:[UIImage imageNamed:@""] frame:CGRectMake(58, 95, 247, 50) font:FontSize24 color:FontColorFFFFFF target:nil action:nil];
//        
////        self._packageView = [[[UIImageView alloc] initWithFrame:CGRectMake(58, 95, 247, 50)] autorelease];
//        self._packageView = [UIImageView ImageViewWithFrame:CGRectMake(58, 95, 247, 50) image:[UIImage imageNamed:@"navigationBar.png"]];
//        self._packageTitle = [UISubLabel labelWithTitle:@"周租套餐" frame:CGRectMake(0, 15, 70, 20) font:FontSize30 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
//        self._packagePreferential = [UISubLabel labelWithTitle:@"本车享受9.1折优惠！" frame:CGRectMake(90, 5, 150, 20) font:FontSize30 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
//        self._packagePrice = [UISubLabel labelWithTitle:@"均价：168元/天" frame:CGRectMake(90, 25, 70, 20) font:FontSize30 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
//        self._packageTotal = [UISubLabel labelWithTitle:@"合计：2176元" frame:CGRectMake(70, 25, 70, 20) font:FontSize30 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
//        
//        self._packageOpen.hidden = YES;
//        self._packageClose.hidden = YES;
//        self._selectPackage.hidden = YES;
//        self._packageView.hidden = YES;
//        
//        [self._packageView addSubview:self._packageTitle];
//        [self._packageView addSubview:self._packagePreferential];
//        [self._packageView addSubview:self._packagePrice];
//        [self._packageView addSubview:self._packageTotal];
//        
//        [self addSubview:self._packageView];
//        [self addSubview:self._packageOpen];
//        [self addSubview:self._packageClose];
//        [self addSubview:self._selectPackage];
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

@implementation CarServicesCell

@synthesize _serviceButton,_serviceName,_servicePrice;
-(void)dealloc
{
    self._serviceButton = nil;
    self._serviceName = nil;
    self._servicePrice = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 50) image:[UIImage imageNamed:@"carStoreName.png"]]];
        
        self._serviceButton = [UIButton buttonWithTag:0 image:[UIImage imageNamed:@"FilterMoreUnSelected.png"] title:nil imageEdge:UIEdgeInsetsMake(17, 0, 17, 150-14) frame:CGRectMake(20, 0, 150, 50) font:nil color:nil target:nil action:nil];
        self._serviceName = [UISubLabel labelWithTitle:nil frame:CGRectMake(60, 0, 130, 50) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._servicePrice = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 170, 0, 150, 50) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentRight];
        
        [self addSubview:self._serviceButton];
        [self addSubview:self._serviceName];
        [self addSubview:self._servicePrice];

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

@implementation CarPackageTitleView
@synthesize _packageOpen, _packageBackGround;

- (void)dealloc
{
    self._packageBackGround = nil;
    self._packageOpen = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self._packageBackGround = [UIImageView ImageViewWithFrame:self.bounds image:[UIImage imageNamed:@"套餐标题.png"]];
        self._packageBackGround.hidden = YES;
        
        self._packageOpen = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"月租套餐168元/天" backImage:[UIImage imageNamed:@"套餐展开.png"] frame:CGRectMake(73, 0, 225, 25) font:FontSize28 color:FontColorFFFFFF target:nil action:nil];
        self._packageOpen.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight ;
        self._packageOpen.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 10);
        
        [self addSubview:self._packageBackGround];
        [self addSubview:self._packageOpen];
    }
    return self;
}
@end

@implementation CarPackageBodyView
@synthesize _packagePreferential, _packagePrice, _packageTotal;
@synthesize _packageClose, _packageSelect;

- (void)dealloc
{
    self._packageClose = nil;
    self._packageSelect = nil;
    self._packagePrice = nil;
    self._packagePreferential = nil;
    self._packageTotal = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UISubLabel *backGraundLab = [UISubLabel labelWithframe:CGRectMake(12, 0, 296, frame.size.height) backgroundColor:FontColor6DC2E1];
        [self addSubview:backGraundLab];
        
        self._packageClose = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"套餐关闭.png"] frame:CGRectMake(0, 0, 60, frame.size.height) target:nil action:nil];
        self._packageClose.imageEdgeInsets = UIEdgeInsetsMake((frame.size.height - 20)/2, 20, (frame.size.height - 20)/2, 20);
        
        self._packageSelect = [UIButton buttonWithTag:1 frame:CGRectMake(12, 0, 308, frame.size.height) target:nil action:nil];
        [self addSubview:self._packageSelect];
        
        self._packagePreferential = [UISubLabel labelWithTitle:@"本车享受6.8折优惠！取车时需全额支付、不退款" frame:CGRectMake(45, 15, frame.size.width - 40, 20) font:FontSize22 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
        self._packagePrice = [UISubLabel labelWithTitle:@"均价400元/天" frame:CGRectMake(45, 40, (frame.size.width - 40)/2, 20) font:FontSize28 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
        self._packageTotal = [UISubLabel labelWithTitle:@"2957" frame:CGRectMake(frame.size.width/2 + 85, 40, (frame.size.width - 40)/2, 20) font:FontSize40 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
        [self addSubview:[UISubLabel labelWithTitle:@"合计：¥" frame:CGRectMake(frame.size.width/2 + 30, 41, (frame.size.width - 40)/2, 20) font:FontSize28 color:FontColorFFFFFF alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(frame.size.width - 20, (frame.size.height - 10)/2, 5, 10) image:[UIImage imageNamed:@"右箭头.png"]]];
        
        [self addSubview:self._packagePrice];
        [self addSubview:self._packagePreferential];
        [self addSubview:self._packageTotal];
        [self addSubview:self._packageClose];
    }
    return self;
}
@end
