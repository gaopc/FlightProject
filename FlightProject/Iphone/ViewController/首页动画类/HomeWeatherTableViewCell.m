//
//  HomeWeatherTableViewCell.m
//  FlightProject
//
//  Created by gaopengcheng on 14-12-19.
//
//

#import "HomeWeatherTableViewCell.h"

@implementation HomeWeatherTableViewCell
@synthesize _areaLab, _areaBut, _imgView, _qualityLab, _temperatureLab, _updateLab, _weatherLab, _windLab;

- (void)dealloc
{
    self._areaLab = nil;
    self._areaBut = nil;
    self._imgView = nil;
    self._qualityLab = nil;
    self._temperatureLab = nil;
    self._updateLab = nil;
    self._weatherLab = nil;
    self._windLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self._areaBut = [UIButton buttonWithTag:0 frame:CGRectMake(0, 0, ViewWidth, 47) target:nil action:nil];
        self._areaLab = [UILabel labelWithTitle:@"北京" frame:CGRectMake(20, 0, ViewWidth - 40, 47) font:FontSize36 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        
        self._temperatureLab = [UILabel labelWithTitle:@"" frame:CGRectMake(20, 60, ViewWidth, 35) font:[UIFont systemFontOfSize:30] color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        self._weatherLab = [UILabel labelWithTitle:@"" frame:CGRectMake(20, 110, ViewWidth/2, 15) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft];
        self._windLab = [UILabel labelWithTitle:@"" frame:CGRectMake(20, 125, ViewWidth/2 + 40, 15) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft];
        self._windLab.adjustsFontSizeToFitWidth = YES;
        self._qualityLab = [UILabel labelWithTitle:@"" frame:CGRectMake(20, 140, ViewWidth/2, 15) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft];
        self._updateLab = [UILabel labelWithTitle:@"" frame:CGRectMake(190, 140, ViewWidth - 190, 15) font:FontSize22 color:FontColor656565 alignment:NSTextAlignmentLeft];
        
        self._imgView = [[[AsyncImageView alloc] initWithFrame:CGRectMake(ViewWidth - 100, 50, 80, 80)] autorelease];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 30, 17.0f, 8.0f, 13.0f) image:[UIImage imageNamed:@"CellArrow.png"]]];
        [self addSubview:[UILabel labelWithframe:CGRectMake(0, 45, ViewWidth, 2) backgroundColor:[UIColor colorWithWhite:0.9 alpha:1]]];
        [self addSubview:self._areaLab];
        [self addSubview:self._areaBut];
        [self addSubview:self._temperatureLab];
        [self addSubview:self._weatherLab];
        [self addSubview:self._windLab];
        [self addSubview:self._qualityLab];
        [self addSubview:self._updateLab];
        [self addSubview:self._imgView];
        
    }
    return self;
}
@end


@implementation HomeWeatherListTableViewCell
@synthesize _imgView, _temperatureLab, _weatherLab, _dateLab;

- (void)dealloc
{
    self._imgView = nil;
    self._temperatureLab = nil;
    self._weatherLab = nil;
    self._dateLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self._dateLab = [UILabel labelWithTitle:@"明天" frame:CGRectMake(20, 5, 60, 30) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._weatherLab = [UILabel labelWithTitle:@"晴转多云" frame:CGRectMake(80, 5, 90, 30) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentCenter];
        self._imgView = [[[AsyncImageView alloc] initWithFrame:CGRectMake(180, 5, 30, 30)] autorelease];
        self._temperatureLab = [UILabel labelWithTitle:@"10℃/21℃" frame:CGRectMake(220, 5, 80, 30) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentCenter];
        
        UILabel *lineLab = [UILabel labelWithframe:CGRectMake(15, 39, ViewWidth - 30, 1) backgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
        
        [self addSubview:self._dateLab];
        [self addSubview:self._weatherLab];
        [self addSubview:self._imgView];
        [self addSubview:self._temperatureLab];
        [self addSubview:lineLab];
    }
    return self;
}
@end
