//
//  GetTexiShopCell.m
//  FlightProject
//
//  Created by longcd mac mini 04 on 12-10-22.
//
//

#import "CarShopCell.h"

@implementation CarShopTitleCell

@synthesize _imageV,_shopTitle;
-(void)dealloc
{
    self._shopTitle = nil;
    self._imageV = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self._shopTitle = [UISubLabel labelWithTitle:nil frame:CGRectMake(30, 7, 100, 30) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._imageV = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 44) image:[UIImage imageNamed:@"HeaderInSection_A.png"]]; //HeaderInSection_A.png
        UIImageView * backgroundV = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 44) image:[UIImage imageNamed:@"carStoreAddressName.png"]];
        [self addSubview:backgroundV];
        [self addSubview:self._imageV];
        [self addSubview:self._shopTitle];
        
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end

@implementation CarShopNameCell

@synthesize _shopName,_shopOpenTime,_shopAddressButton,_shopAddressImageV;
@synthesize _shopAddressDetail,_backgroundV;
-(void)dealloc
{
    self._shopName = nil;
    self._shopOpenTime = nil;
    self._shopAddressButton = nil;
    self._shopAddressImageV = nil;
    self._shopAddressDetail = nil;
    self._backgroundV = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self._shopName = [UISubLabel labelWithTitle:nil frame:CGRectMake(30, 3, ViewWidth - 60, 30) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._shopOpenTime = [UISubLabel labelWithTitle:nil frame:CGRectMake(30,  25, 100, 25) font:FontSize24 color:FontColor909090 alignment:NSTextAlignmentLeft];
        self._shopAddressImageV = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 40, (55-15)/2, 15, 15) image:[UIImage imageNamed:@"TicketListBottomRight1.png"]]; //
        self._shopAddressButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth - 95,  (55-30)/2, 80, 44) font:nil color:nil target:nil action:nil];
        
        self._shopAddressDetail = [UISubLabel labelWithTitle:nil frame:CGRectMake(15 , 55 , ViewWidth - 50, 0) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._backgroundV = [UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 55) image:[UIImage imageNamed:@"carStoreAddressName.png"]];
        
        [self addSubview:self._backgroundV];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(15, 2, ViewWidth - 30, 49) image:[UIImage imageNamed:@"carStoreName.png"]]];
        [self addSubview:self._shopName];
        [self addSubview:self._shopOpenTime];
        [self addSubview:[UISubLabel labelWithTitle:@"详细地址" frame:CGRectMake(ViewWidth - 95, 0, 100, 55) font:FontSize24 color:FontColor2685CF alignment:NSTextAlignmentLeft]];
        [self addSubview:self._shopAddressImageV];
        [self addSubview:self._shopAddressButton];
        
        [self._backgroundV addSubview:self._shopAddressDetail];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end
