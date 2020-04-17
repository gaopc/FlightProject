//
//  TripForTicketTableViewCell.m
//  FlightProject
//
//  Created by gaopengcheng on 15-11-9.
//
//

#import "TripForTicketTableViewCell.h"

@implementation TripForTicketTableViewCell
@synthesize _companyImageV,_flightNo,_startDate ,_fromCity,_fromAirport,_fromWearther,_toCity,_toAirport,_toWearther,_startTime,_arrivlTime,_planType, _cabinType;

-(void)dealloc
{
    self._companyImageV = nil;
    self._flightNo = nil;
    self._startDate = nil;
    self._fromCity = nil;
    self._fromAirport = nil;
    self._fromWearther = nil;
    self._toCity = nil;
    self._toAirport = nil;
    self._toWearther = nil;
    self._startTime = nil;
    self._arrivlTime = nil;
    self._planType = nil;
    self._cabinType = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
//        UIImageView *groundView = [UIImageView ImageViewWithFrame:CGRectMake(5, 0, ViewWidth - 10, 132) image:[[UIImage imageNamed:@"cabinListCell.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        
        UILabel *groundView = [UILabel labelWithframe:CGRectMake(5, 0, ViewWidth - 10, 132) backgroundColor:FontColorFFFFFF];
        groundView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        groundView.layer.borderWidth = 1;
        groundView.layer.cornerRadius = 1;
        
        self._planType = [UISubLabel labelWithTitle:nil frame:CGRectMake(15, 8, 100, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        self._companyImageV = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 120 - 6, 9, 15, 15)];
        self._flightNo = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 105 - 5, 6, 100, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:groundView];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(13, 30, 118, 68) image:[UIImage imageNamed:@"cabinWeartherBackground.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 131, 30, 118, 68) image:[UIImage imageNamed:@"cabinWeartherBackground.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake((ViewWidth - 24)/2, 50, 24, 21) image:[UIImage imageNamed:@"cabinArrows.png"]]];
        
        UISubLabel * label1 = [[UISubLabel alloc] initWithFrame:CGRectMake(23, 35, 60, 23) ];
        [label1 setTextAlignment:NSTextAlignmentLeft];
        [label1 setBackgroundColor:[UIColor clearColor]];
        label1.font = FontSize40;
        label1.textColor = FontColor000000;
        label1.minimumFontSize = 10;
        label1.adjustsFontSizeToFitWidth = YES;
        label1.highlightedTextColor = [UIColor whiteColor];
        self._fromCity = label1;
        [label1 release];
        UISubLabel * label2 = [[UISubLabel alloc] initWithFrame:CGRectMake(ViewWidth - 120, 35, 60, 23)];
        [label2 setTextAlignment:NSTextAlignmentLeft];
        [label2 setBackgroundColor:[UIColor clearColor]];
        label2.font = FontSize40;
        label2.textColor = FontColor000000;
        label2.minimumFontSize = 10;
        label2.adjustsFontSizeToFitWidth = YES;
        label2.highlightedTextColor = [UIColor whiteColor];
        self._toCity = label2;
        [label2 release];
        
        self._startTime = [UISubLabel labelWithTitle:nil frame:CGRectMake(23, 60, 100, 20) font:FontSize40 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        self._arrivlTime = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 120 -3, 60, 100, 20) font:FontSize40 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        
        self._fromAirport = [UISubLabel labelWithTitle:nil frame:CGRectMake(23, 77, 200, 20) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        self._toAirport = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 120 - 3, 77, 200, 20) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        
        AsyncImageView * _sd1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(88, 23 + 10, 40, 40)];
        AsyncImageView * _sd2 = [[AsyncImageView alloc] initWithFrame:CGRectMake(ViewWidth - 60 + 2, 23 + 10, 40, 40)];
        _sd1.tag = 0;
        _sd2.tag = 1;
        self._fromWearther =_sd1;
        self._toWearther = _sd2;
        [_sd1 release];
        [_sd2 release];
        
        self._startDate = [UISubLabel labelWithTitle:nil frame:CGRectMake(23, 105, 150, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._cabinType = [UILabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 120, 105, 100, 20) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentRight];
        
        [self addSubview:self._companyImageV];
        [self addSubview:self._flightNo];
        [self addSubview:self._startDate];
        [self addSubview:self._fromWearther];
        [self addSubview:self._toWearther];
        [self addSubview:self._fromCity];
        [self addSubview:self._toCity];
        [self addSubview:self._startTime];
        [self addSubview:self._arrivlTime];
        [self addSubview:self._fromAirport];
        [self addSubview:self._toAirport];
        [self addSubview:self._planType];
        [self addSubview:self._cabinType];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // cabinListCell.png
}

@end

@implementation TripForHotelTableViewCell
@synthesize _checkInDateLab, _checkOutDateLab, _hotelAddressLab, _hotelNameLab, _peopleNameLab, _roomTypeLab;

- (void)dealloc
{
    self._checkInDateLab = nil;
    self._checkOutDateLab = nil;
    self._hotelAddressLab = nil;
    self._hotelNameLab = nil;
    self._peopleNameLab = nil;
    self._roomTypeLab = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *groundView = [UILabel labelWithframe:CGRectMake(5, 0, ViewWidth - 10, 132) backgroundColor:FontColorFFFFFF];
        groundView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        groundView.layer.borderWidth = 1;
        groundView.layer.cornerRadius = 1;
        
        self._hotelNameLab = [UILabel labelWithTitle:@"北京饭店" frame:CGRectMake(20, 10 , ViewWidth - 100, 30) font:FontSize38 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._hotelNameLab.adjustsFontSizeToFitWidth = YES;
        
        self._roomTypeLab = [UILabel labelWithTitle:@"标准间" frame:CGRectMake(ViewWidth - 100, 17, 80, 20) font:FontSize28 color:FontColor333333 alignment:NSTextAlignmentRight];
        UILabel *lineLab = [UILabel labelWithframe:CGRectMake(18, 42, ViewWidth - 36, 1) backgroundColor:[UIColor colorWithWhite:0.9 alpha:0.5]];
        self._hotelAddressLab = [UILabel labelWithTitle:@"北京市朝阳区惠新东街11区紫光发展大厦b2座7层" frame:CGRectMake(20, 50, ViewWidth - 40 , 60) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft autoSize:YES];
        self._checkInDateLab = [UILabel labelWithTitle:@"入住日期：2015-11-11" frame:CGRectMake(20, 82, ViewWidth/2, 30) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._checkOutDateLab = [UILabel labelWithTitle:@"离店日期：2015-11-12" frame:CGRectMake(ViewWidth/2, 82, ViewWidth/2 - 20, 30) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentRight];
        self._peopleNameLab = [UILabel labelWithTitle:@"入住旅客：高鹏程" frame:CGRectMake(20, 102, ViewWidth - 40, 30) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        
        [self addSubview:groundView];
        [self addSubview:self._hotelNameLab];
        [self addSubview:self._roomTypeLab];
        [self addSubview:lineLab];
        [self addSubview:self._hotelAddressLab];
        [self addSubview:self._checkInDateLab];
        [self addSubview:self._checkOutDateLab];
        [self addSubview:self._peopleNameLab];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
