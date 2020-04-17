//
//  CarPassengerCell.m
//  FlightProject
//
//  Created by gaopengcheng on 13-5-3.
//
//

#import "CarPassengerCell.h"

@implementation CarPassengerCell
@synthesize _cerNum, _name, _selectImg, _unSelectImg;
@synthesize _selectName;

-(void)dealloc
{
    self._cerNum = nil;
    self._name = nil;
    self._selectImg = nil;
    self._unSelectImg = nil;
    self._selectName = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10.0, 2.0f, ViewWidth - 20, 43.0f) image:[UIImage imageNamed:@"PassengerCell.png"]]];
        
        self._selectImg = [UIImageView ImageViewWithFrame:CGRectMake(20, 11, 20, 20) image:[UIImage imageNamed:@"FilterSingleSelected.png"]];
        
        self._unSelectImg = [UIImageView ImageViewWithFrame:CGRectMake(20, 11, 20, 20) image:[UIImage imageNamed:@"FilterSingleUnSelected.png"]];
        
        self._name = [UISubLabel labelWithTitle:@"高鹏程" frame:CGRectMake(45, 11, 80, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._cerNum = [UISubLabel labelWithTitle:@"150222198510202912" frame:CGRectMake(90, 12, 180, 20) font:FontSize30 color:FontColor333333 alignment:NSTextAlignmentRight];
        
        self._selectName = [UIButton buttonWithTag:0 frame:CGRectMake(120, 0, ViewWidth - 120, 45) target:nil action:nil];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 35, 16.0f, 8.0f, 13.0f) image:[UIImage imageNamed:@"CellArrow.png"]]];
        
        [self addSubview:self._unSelectImg];
        [self addSubview:self._selectImg];
        [self addSubview:self._name];
        [self addSubview:self._cerNum];
        [self addSubview:self._selectName];
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
