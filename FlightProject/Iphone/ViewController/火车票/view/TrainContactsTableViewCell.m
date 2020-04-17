//
//  TrainContactsTableViewCell.m
//  FlightProject
//
//  Created by gaopengcheng on 15-7-17.
//
//

#import "TrainContactsTableViewCell.h"

@implementation TrainContactsTableViewCell
@synthesize _addPickUpPerson,_labelDescription;

-(void)dealloc
{
    self._labelDescription = nil;
    self._addPickUpPerson = nil;
    [super dealloc];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];//50
    if (self) {
        self._labelDescription = [UISubLabel labelWithTitle:@"接机人" frame:CGRectMake(20, 0, ViewWidth - 20, 50) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._addPickUpPerson =  [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"selectContacts.png"] frame:CGRectMake(ViewWidth - 140, 10, 112, 30) font:FontSize32 color:FontColor909090 target:nil action:nil];
        if ([[UserInfo sharedUserInfo].userID isEqualToString: @""])
        {
            [self._addPickUpPerson setBackgroundImage:[UIImage imageNamed:@"selectContacts.png"] forState:UIControlStateNormal];
        }
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 1, ViewWidth - 20, 50) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:self._labelDescription];
        [self addSubview:self._addPickUpPerson];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}
@end


@implementation TrainContactsInfoCell
@synthesize _labelDescription,_passengerLabel,_passengerNumLabel;
@synthesize _backGroundImageV;

-(void)dealloc
{
    self._labelDescription = nil;
    self._passengerLabel = nil;
    self._passengerNumLabel = nil;
    self._backGroundImageV = nil;
    [super dealloc];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self._labelDescription = [UISubLabel labelWithTitle:@"非必填项，可不填" frame:CGRectMake(10, 0, ViewWidth - 20, 30) font:FontSize26 color:FontColorFF6113 alignment:NSTextAlignmentLeft];
        self._passengerLabel = [UISubLabel labelWithTitle:nil frame:CGRectMake(10, 0, 100, 30)  font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._passengerNumLabel = [UISubLabel labelWithTitle:nil frame:CGRectMake(110, 0, 150, 30)  font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 20, 44) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]] ;
        self._backGroundImageV = [UIImageView ImageViewWithFrame:CGRectMake(20, 7, ViewWidth - 40, 30) image:[UIImage imageNamed:@"输入框.png"]];
        [self addSubview:self._backGroundImageV];
        [self._backGroundImageV addSubview:self._labelDescription];
        [self._backGroundImageV addSubview:self._passengerLabel];
        [self._backGroundImageV addSubview:self._passengerNumLabel];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}
@end