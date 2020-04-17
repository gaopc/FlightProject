//
//  TrainNumberHistoryCell.m
//  FlightProject
//
//  Created by 小月 on 13-1-7.
//
//

#import "TrainNumberHistoryCell.h"

@implementation TrainNumberHistoryCell
@synthesize leftButton,rightButton,leftNumber,leftStation,rightNumber,rightStation;
- (void)dealloc
{
    self.leftButton = nil;
    self.rightButton = nil;
    self.leftNumber = nil;
    self.leftStation = nil;
    self.rightNumber = nil;
    self.rightStation = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.leftButton = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"航班动态历史记录.png"] frame:CGRectMake(8, 2, ViewWidth/2-12, 48) target:nil action:nil];
        self.rightButton = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"航班动态历史记录.png"] frame:CGRectMake(ViewWidth/2-1, 2, ViewWidth/2-12, 48) target:nil action:nil];

        
        self.leftNumber = [UISubLabel labelWithTitle:@"" frame:CGRectMake(8,11,ViewWidth/2-14,15) font:FontSize28 color:FontColor454545 alignment:NSTextAlignmentCenter];
        self.leftStation = [UISubLabel labelWithTitle:@"" frame:CGRectMake(8,28,ViewWidth/2-14,12) font:FontSize28 color:FontColor707070 alignment:NSTextAlignmentCenter];
        
        self.rightNumber = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth/2-1,11,ViewWidth/2-14,15) font:FontSize28 color:FontColor454545 alignment:NSTextAlignmentCenter];
        self.rightStation = [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth/2-1,28,ViewWidth/2-14,12) font:FontSize28 color:FontColor707070 alignment:NSTextAlignmentCenter];
    
        
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.leftNumber];
        [self addSubview:self.rightNumber];
        [self addSubview:self.leftStation];
        [self addSubview:self.rightStation];
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
