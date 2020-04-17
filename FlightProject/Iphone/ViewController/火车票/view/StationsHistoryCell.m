//
//  StationsHistoryCell.m
//  FlightProject
//
//  Created by 小月 on 13-1-7.
//
//

#import "StationsHistoryCell.h"

@implementation StationsHistoryCell
@synthesize leftButton,rightButton;

- (void)dealloc
{
    self.leftButton = nil;
    self.rightButton = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"航班动态历史记录.png"] frame:CGRectMake(7, 2, ViewWidth/2-11, 48) font:FontSize28 color:FontColor454545 target:nil action:nil];
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil backImage:[UIImage imageNamed:@"航班动态历史记录.png"] frame:CGRectMake(ViewWidth/2-1, 2, ViewWidth/2-11, 48) font:FontSize28 color:FontColor454545 target:nil action:nil];
        
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
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
