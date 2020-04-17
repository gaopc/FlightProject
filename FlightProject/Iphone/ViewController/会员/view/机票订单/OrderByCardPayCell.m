//
//  OrderByCardPayCell.m
//  FlightProject
//
//  Created by admin on 12-11-2.
//
//

#import "OrderByCardPayCell.h"

@implementation OrderByCardPayCell
@synthesize _cardPrice;

- (void)dealloc
{
    self._cardPrice = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        
        [self addSubview:[UISubLabel labelWithTitle:@"使用信用卡支付机票" frame:CGRectMake(20, 12, 250, 20) font:FontSize36 color:FontColor000000 alignment:NSTextAlignmentLeft]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"支付金额" frame:CGRectMake(ViewWidth - 185, 46, 80, 20) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentRight]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 98, 50, 11, 12) image:[UIImage imageNamed:@"符号.png"]]];
        
        self._cardPrice = [UISubLabel labelWithTitle:@"1450" frame:CGRectMake(ViewWidth - 83, 44, 80, 20) font:FontSize42 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UISubLabel labelWithTitle:@"信用卡手机支付严格按照支付卡行业数据安全标准储存、处理、传输客人的相关信息。信用卡信息及相关个人资料在传输中采用SSL加密处理，整个过程非常安全。" frame:CGRectMake(20, 80, ViewWidth - 40, 20) font:FontSize26 color:FontColor454545 alignment:NSTextAlignmentLeft autoSize:YES]];
        
        [self addSubview:self._cardPrice];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end
