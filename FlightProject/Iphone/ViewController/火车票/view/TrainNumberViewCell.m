//
//  TrainNumberViewCell.m
//  FlightProject
//
//  Created by 小月 on 13-1-7.
//
//

#import "TrainNumberViewCell.h"

@implementation TrainNumberViewCell
@synthesize trainNumberText;
- (void)dealloc
{
    self.trainNumberText = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth-20, 130) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 120, ViewWidth-20, 18) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        
        [self addSubview:[UISubLabel labelWithTitle:@"列车车次" frame:CGRectMake(18, 25, ViewWidth-35, 20) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(25, 50, ViewWidth-50, 33) image:[UIImage imageNamed:@"输入框.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"车   次:" frame:CGRectMake(32, 55, 60, 20) font:FontSize32 color:FontColor454545 alignment:NSTextAlignmentCenter]];
        
        self.trainNumberText = [UISubTextField TextFieldWithFrame:CGRectMake(87, 55, ViewWidth- 120, 20) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"可直接输入数字"];
        self.trainNumberText.textColor = FontColor454545;
        [self addSubview:self.trainNumberText];
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
