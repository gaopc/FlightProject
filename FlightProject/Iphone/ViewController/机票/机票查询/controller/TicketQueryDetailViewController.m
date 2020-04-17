//
//  TicketQueryDetailViewController.m
//  FlightProject
//
//  Created by longcd on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TicketQueryDetailViewController.h"
#import "TicketQueryViewController.h"
#import "DoubleSlider.h"

@interface TicketQueryDetailCell : UITableViewCell
@property (nonatomic,retain) UIImageView * _lowerImageV;
@property (nonatomic,retain) UIImageView * _companyImageV;
@property (nonatomic,retain) UISubLabel * _startDate;
@property (nonatomic,retain)UISubLabel * _flightNo;
@property (nonatomic,retain)UISubLabel * _airline;
@property (nonatomic,retain)UISubLabel * _planeType;
@property (nonatomic,retain)UISubLabel * _ticketCount;
@property (nonatomic,retain)UISubLabel * _ticketPrice;
@property (nonatomic,retain)UISubLabel * _discount;
@property (nonatomic,retain)UISubLabel * _endTime;
@property (nonatomic,retain)UISubLabel * _startAirport;
@property (nonatomic,retain)UISubLabel * _startTerminal;
@property (nonatomic,retain)UISubLabel * _endAirport;
@property (nonatomic,retain)UISubLabel * _endTerminal;
@property (nonatomic,retain)UISubLabel * _stopNum;
@property (nonatomic,retain)UISubLabel * _returnLcdFee;

@property (nonatomic,retain)UIImageView * _returnLcdImage;

@end
@implementation TicketQueryDetailCell
@synthesize _lowerImageV,_companyImageV,_startDate,_flightNo,_airline,_planeType,_ticketCount,_ticketPrice,_discount,_endTime,_startAirport,_startTerminal,_endAirport,_endTerminal,_stopNum,_returnLcdFee;
@synthesize _returnLcdImage;
-(void)dealloc
{
    self._lowerImageV = nil;
    self._companyImageV = nil;
    self._startDate = nil;
    self._flightNo = nil;
    self._airline = nil;
    self._planeType = nil;
    self._ticketCount = nil;
    self._ticketPrice = nil;
    self._discount = nil;
    self._endTime = nil;
    self._startAirport = nil;
    self._startTerminal = nil;
    self._endAirport = nil;
    self._endTerminal = nil;
    self._stopNum = nil;
    self._returnLcdFee = nil;
    self._returnLcdImage = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth - 100, 75) image:[UIImage imageNamed:@"TicketListLeft.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 90, 0, 85, 75) image:[UIImage imageNamed:@"TicketListRight.png"]]];

        self._lowerImageV = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 35, 0, 20, 20) image:[UIImage imageNamed:@"TicketListLower.png"]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 10, 15, 15) image:[UIImage imageNamed:@"TicketListUp.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 30, 15, 15) image:[UIImage imageNamed:@"TicketListDown.png"]]];
        self._startDate = [UISubLabel labelWithTitle:nil frame:CGRectMake(35, 10, 70, 20) font:FontSize48 color:FontColor2585CF alignment:NSTextAlignmentRight];
        self._endTime = [UISubLabel labelWithTitle:nil frame:CGRectMake(35, 30, 70, 20) font:FontSize38 color:FontColor2F6996 alignment:NSTextAlignmentRight];
        self._startAirport = [UISubLabel labelWithTitle:nil frame:CGRectMake(110, 10, 200, 20) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._endAirport = [UISubLabel labelWithTitle:nil frame:CGRectMake(110, 30, 200, 20) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 52, ViewWidth - 120, 1) image:[UIImage imageNamed:@"TicketListxuxian.png"]]];
        
        self._companyImageV = [UIImageView ImageViewWithFrame:CGRectMake(20, 54, 15, 15)];
        self._flightNo = [UISubLabel labelWithTitle:nil frame:CGRectMake(35, 58, 100, 10) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        self._planeType =  [UISubLabel labelWithTitle:nil frame:CGRectMake(133, 58, 60, 10) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        self._ticketCount =  [UISubLabel labelWithTitle:nil frame:CGRectMake(205, 55, 23, 15) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentCenter];
        
         [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 85, 32, 8, 8) image:[UIImage imageNamed:@"TicketListRMB.png"]]];
        self._ticketPrice =   [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 75, 20, 70, 20) font:FontSize48 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        
        self._returnLcdImage = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 90, 52, 50, 20) image:[UIImage imageNamed:@"TicketListReturnCdb.png"]];
        self._returnLcdFee =   [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 90, 50, 50, 20) font:FontSize24 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
 
        self._discount = [UISubLabel labelWithTitle:nil frame:CGRectMake(ViewWidth - 50, 50, 40, 20) font:FontSize24 color:FontColorFF6113 alignment:NSTextAlignmentRight];
        
        [self addSubview:self._lowerImageV];
        [self addSubview:self._startDate];
        [self addSubview:self._endTime];
        [self addSubview:self._startAirport];
        [self addSubview:self._endAirport];
        [self addSubview:self._companyImageV];
        [self addSubview:self._flightNo];
        [self addSubview:self._planeType];
        [self addSubview:[UISubLabel labelWithTitle:@"票量:" frame:CGRectMake(180, 58, 70, 10) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        [self addSubview:self._ticketCount];
        [self addSubview:self._ticketPrice];
        [self addSubview:self._returnLcdImage];
        [self addSubview:self._returnLcdFee];
        [self addSubview:self._discount];
        [self addSubview:self._flightNo];
    
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

@interface TicketQueryDetailSaleOverCell : TicketQueryDetailCell

@end

@implementation TicketQueryDetailSaleOverCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, 220, 75) image:[UIImage imageNamed:@"TicketListLeft.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(230, 0, 85, 75) image:[UIImage imageNamed:@"TicketListSaleOverRight.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(240, 20, 60, 37) image:[UIImage imageNamed:@"TicketListSaleOver.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 10, 15, 15) image:[UIImage imageNamed:@"TicketListUp.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 30, 15, 15) image:[UIImage imageNamed:@"TicketListDown.png"]]];
        self._startDate = [UISubLabel labelWithTitle:nil frame:CGRectMake(35, 10, 70, 20) font:FontSize48 color:FontColor2585CF alignment:NSTextAlignmentRight];
        self._endTime = [UISubLabel labelWithTitle:nil frame:CGRectMake(35, 30, 70, 20) font:FontSize38 color:FontColor2F6996 alignment:NSTextAlignmentRight];
        self._startAirport = [UISubLabel labelWithTitle:nil frame:CGRectMake(110, 10, 200, 20) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._endAirport = [UISubLabel labelWithTitle:nil frame:CGRectMake(110, 30, 200, 20) font:FontSize24 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 52, 200, 1) image:[UIImage imageNamed:@"TicketListxuxian.png"]]];
        
        self._companyImageV = [UIImageView ImageViewWithFrame:CGRectMake(20, 54, 15, 15)];
        self._flightNo = [UISubLabel labelWithTitle:nil frame:CGRectMake(35, 58, 100, 10) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        self._planeType =  [UISubLabel labelWithTitle:nil frame:CGRectMake(133, 58, 60, 10) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        self._ticketCount =  [UISubLabel labelWithTitle:nil frame:CGRectMake(205, 55, 23, 15) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentCenter];
        
        self._ticketPrice =   [UISubLabel labelWithTitle:nil frame:CGRectMake(245, 20, 70, 20) font:FontSize48 color:FontColorFF8813 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._startDate];
        [self addSubview:self._endTime];
        [self addSubview:self._startAirport];
        [self addSubview:self._endAirport];
        [self addSubview:self._companyImageV];
        [self addSubview:self._flightNo];
        [self addSubview:self._planeType];
        [self addSubview:[UISubLabel labelWithTitle:@"票量:  0张" frame:CGRectMake(180, 58, 70, 10) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft]];
        [self addSubview:self._flightNo];
        
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


@implementation BottomView
@synthesize _leftImageView,_rightImageView,_proLabel,_nextLabel,_dateLabel,_weekLabel,_proButton,_nextButton;
-(void)dealloc
{
    self._leftImageView = nil;
    self._rightImageView = nil;
    self._proLabel = nil;
    self._nextLabel = nil;
    self._dateLabel = nil;
    self._weekLabel = nil;
    self._proButton = nil;
    self._nextButton = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:self.bounds image:[UIImage imageNamed:@"TicketListbottom.png"]]];
        self._leftImageView = [UIImageView ImageViewWithFrame:CGRectMake(10,15,21,21) image:[UIImage imageNamed:@"TicketListBottomLeft2.png"]];
        self._rightImageView = [UIImageView ImageViewWithFrame:CGRectMake(280,15,21,21) image:[UIImage imageNamed:@"TicketListBottomRight1.png"]];
        self._proLabel = [UISubLabel labelWithTitle:@"前一天" frame:CGRectMake(42, 15, 100, 20) font:FontSize26 color:FontColor1B77C3 alignment:NSTextAlignmentLeft];
        self._nextLabel = [UISubLabel labelWithTitle:@"后一天" frame:CGRectMake(235, 15, 100, 20) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
        self._dateLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(0, 7, ViewWidth, 20) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
         self._weekLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(0, 20, ViewWidth, 20) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentCenter];
        
        self._proButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 15, 100, 20) backImage:nil target:nil action:nil];
        self._nextButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(235, 15, 100, 20) backImage:nil target:nil action:nil];
        
        self._proButton.enabled = NO;

        [self addSubview:self._leftImageView];
        [self addSubview:self._rightImageView];
        [self addSubview:self._proLabel];
        [self addSubview:self._nextLabel];
        [self addSubview:self._dateLabel];
        [self addSubview:self._weekLabel];
        [self addSubview:self._proButton];
        [self addSubview:self._nextButton];
    }
    return self;
}

@end

@interface View4SubView : UIView
@property (nonatomic,retain) UIImageView * _selectImageV;
@property (nonatomic,retain) UIImageView * _companyImageV;
@property (nonatomic,retain) UISubLabel * _companyName;
@property (nonatomic,retain) UIButton * _clickButton;
@property (nonatomic,assign) BOOL _isSelected;
@end
@implementation View4SubView

@synthesize _selectImageV,_companyImageV,_companyName,_clickButton,_isSelected;
-(void)dealloc
{
    self._selectImageV = nil;
    self._companyImageV = nil;
    self._companyName = nil;
    
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(8, 5, 30, 30) image:[UIImage imageNamed:@"FilterMoreUnSelected.png"]]];
        self._selectImageV = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 15, 15) ];
        self._companyImageV = [UIImageView ImageViewWithFrame:CGRectMake(14, 12, 20, 20) ];
        self._companyName = [UISubLabel labelWithTitle:nil frame:CGRectMake(0, 30, 60, 20) font:FontSize20 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._clickButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:nil frame:self.bounds font:nil color:nil target:nil action:nil];
        self._isSelected = FALSE;
        [self addSubview:self._companyImageV];
        [self addSubview:self._selectImageV];
        [self addSubview:self._companyName];
        [self addSubview:self._clickButton];
    }
    return self;
}
@end

@interface View23SubView : UIView
@property (nonatomic,retain) UIButton * _selectButton;
@property (nonatomic,retain) UISubLabel *_airportLabel;
@property (nonatomic,assign) BOOL _isSelected;
@end
@implementation View23SubView

@synthesize _selectButton,_airportLabel,_isSelected;
-(void)dealloc
{
    self._selectButton = nil;
    self._airportLabel = nil;
    
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self._selectButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"FilterSingleSelected.png"] frame:CGRectMake(0, 0, 20, 20) font:nil color:nil target:nil action:nil];
        self._airportLabel = [UISubLabel labelWithTitle:@"不限" frame:CGRectMake(25, 0, 100, 20) font:FontSize22 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self._isSelected = FALSE;
        [self addSubview:self._selectButton];
        [self addSubview:self._airportLabel];
    }
    return self;
}
@end

@implementation FilterView
@synthesize _timeRange,_startAirport,_endAirport,_airlines,_FilterDownButton;
@synthesize _selectAirlines,_selectTimeRange,_selectEndAirport,_selectStartAirport;
@synthesize _view1,_view2,_view3,_view4;
@synthesize delegate;
-(void)dealloc
{
    self._timeRange = nil;
    self._startAirport = nil;
    self._endAirport = nil;
    self._airlines = nil;
    self._selectEndAirport = nil;
    self._selectTimeRange = nil;
    self._selectStartAirport = nil;
    self._selectAirlines = nil;
    
    self._FilterDownButton = nil;
    
    self._view1 = nil;
    self._view2 = nil;
    self._view3 = nil;
    self._view4 = nil;
    
    self.delegate = nil;
    [super dealloc];
}

-(void)set_timeRange:(NSMutableArray *)timeRange
{
    if (_timeRange != timeRange) {
        [_timeRange release];
        _timeRange = [timeRange retain];
        
        if (flightTimeSlider == nil) {
            NSMutableArray * timePeriodArray = [[NSMutableArray alloc] init];
            for (int i=0; i<=24; i++) {
                [timePeriodArray addObject:[NSString stringWithFormat:@"bottom_%d.png",i]];
            }
            flightTimeSlider =[[[DoubleSlider alloc]initWithFrame:CGRectMake(25, 10, 270, 60) WithArray:timePeriodArray withMinimumValue:6.0 withMaximumValue:24.0 withMinimumRange:2.0 withIntervalNumber:2 withElementNumber:10]autorelease];
            [self._view1 addSubview:flightTimeSlider];
            [timePeriodArray release];
            
//            [self._view1 addSubview:[UISubLabel labelWithTitle:@"起飞时段" frame:CGRectMake(15, 55, 270, 20)  font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft]];
//            [self._view1 addSubview:[UISubLabel labelWithTitle:@"到达时段" frame:CGRectMake(267, 55, 270, 20)  font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft]];

        }
    }
}
-(void)selectStartAirport:(UIButton *)sender
{
    if ([self._startAirport count] >1) {
        for (View23SubView *view in [self._view2 subviews]) {
            if ([view isKindOfClass:[View23SubView class]]) {
                if (view._selectButton == sender) {
                    view._isSelected = TRUE;
                    [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
                    view._airportLabel.textColor =  FontColor2585CF;
                }
                else {
                    view._isSelected = FALSE;
                    [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
                    view._airportLabel.textColor = FontColor333333;
                }
            }
        }
    }
}
-(void)set_startAirport:(NSMutableArray *)startAirport
{
    for (UIView * sub in [self._view2 subviews]) {
        if (sub.tag !=-1) {
            [sub removeFromSuperview];
        }
//        if ([sub isKindOfClass:[View23SubView class]]) {
//            return;
//        }
    }
    
    if (_startAirport != startAirport) {
        [_startAirport release];
        _startAirport = [startAirport retain];
        if ([startAirport count]>1) {
            View23SubView * view = [[View23SubView alloc] initWithFrame:CGRectMake(12, 10, 120, 20)];
            view.tag = 0;
            view._isSelected = YES;
            [view._selectButton addTarget:self action:@selector(selectStartAirport:) forControlEvents:UIControlEventTouchUpInside];
            [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
            view._airportLabel.text = @"不限";
            view._airportLabel.textColor = FontColor2585CF;
            [self._view2 addSubview:view];
            [view release];
            
            for ( int i=0; i< [startAirport count];i++) {
                View23SubView * view = [[View23SubView alloc] initWithFrame:CGRectMake(70+i*115, 10, 120, 20)];
                view.tag = i+1;
                view._isSelected = YES;
                [view._selectButton addTarget:self action:@selector(selectStartAirport:) forControlEvents:UIControlEventTouchUpInside];
                [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
                view._airportLabel.text = [startAirport objectAtIndex:i] ;
                view._airportLabel.textColor = FontColor333333;
                [self._view2 addSubview:view];
                [view release];

            }
        }
        else if([startAirport count] == 1) {
            View23SubView * view = [[View23SubView alloc] initWithFrame:CGRectMake(12, 10, 120, 20)];
            view.tag = 0;
            view._isSelected = YES;
            [view._selectButton addTarget:self action:@selector(selectStartAirport:) forControlEvents:UIControlEventTouchUpInside];
            [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
            view._airportLabel.text = [startAirport objectAtIndex:0];
            view._airportLabel.textColor = FontColor2585CF;
            [self._view2 addSubview:view];
            [view release];
        }
    }
}
-(void)selectEndAirport:(UIButton *)sender
{
    if ([self._endAirport count] >1) {
        for (View23SubView *view in [self._view3 subviews]) {
            if ([view isKindOfClass:[View23SubView class]]) {
                if (view._selectButton == sender) {
                    view._isSelected = TRUE;
                    [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
                    view._airportLabel.textColor =  FontColor2585CF;
                }
                else {
                    view._isSelected = FALSE;
                    [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
                    view._airportLabel.textColor =  FontColor333333;
                }
            }
        }
    }
}
-(void)set_endAirport:(NSMutableArray *)endAirport
{
    for (UIView * sub in [self._view3 subviews]) {
        if (sub.tag !=-1) {
            [sub removeFromSuperview];
        }
//        if ([sub isKindOfClass:[View23SubView class]]) {
//            return;
//        }
    }
    
    if (_endAirport != endAirport) {
        [_endAirport release];
        _endAirport = [endAirport retain];

        if ([endAirport count]>1) {
            View23SubView * view = [[View23SubView alloc] initWithFrame:CGRectMake(12, 10, 120, 20)];
            view.tag = 0;
            view._isSelected = YES;
            [view._selectButton addTarget:self action:@selector(selectEndAirport:) forControlEvents:UIControlEventTouchUpInside];
            [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
            view._airportLabel.text = @"不限";
            view._airportLabel.textColor = FontColor2585CF;
            [self._view3 addSubview:view];
            [view release];

            for ( int i=0; i< [endAirport count];i++) {
                View23SubView * view = [[View23SubView alloc] initWithFrame:CGRectMake(92+i*115, 10, 120, 20)];
                view.tag = i+1;
                view._isSelected = YES;
                [view._selectButton addTarget:self action:@selector(selectEndAirport:) forControlEvents:UIControlEventTouchUpInside];
                [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
                view._airportLabel.text = [endAirport objectAtIndex:i];
                view._airportLabel.textColor = FontColor333333;
                [self._view3 addSubview:view];
                [view release];
                
            }
        }
        else if([endAirport count] == 1) {
            View23SubView * view = [[View23SubView alloc] initWithFrame:CGRectMake(12, 10, 120, 20)];
            view.tag = 0;
            view._isSelected = YES;
            [view._selectButton addTarget:self action:@selector(selectEndAirport:) forControlEvents:UIControlEventTouchUpInside];
            [view._selectButton setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
            view._airportLabel.text = [endAirport objectAtIndex:0];
            view._airportLabel.textColor = FontColor2585CF;
            [self._view3 addSubview:view];
            [view release];
        }
    }
}
-(void)selectAirlines:(UIButton *)sender
{
    View4SubView * subV = (View4SubView * )sender.superview;
    if ([self._airlines count] > 1) {
        
        if (subV._isSelected ) {
            subV._isSelected = FALSE;
            subV._selectImageV.image = [UIImage imageNamed:@"FilterMoreUnSelected.png"];
            subV._companyName.textColor =  FontColor333333;
            BOOL isAllNotSelected = TRUE;
            for (View4SubView * elem in [self._view4 subviews]) {
                if ([elem isKindOfClass:[View4SubView class]]) {
                    if (elem._isSelected) {
                        isAllNotSelected = FALSE;
                    }
                }
            }
            if (isAllNotSelected) {
                for (View4SubView * elem in [self._view4 subviews]) {
                    if ([elem isKindOfClass:[View4SubView class]]) {
                        if (elem.tag == 0) {
                            elem._isSelected = TRUE;
                            elem._selectImageV.image = [UIImage imageNamed:@"FilterMoreSelected.png"];
                            elem._companyName.textColor =  FontColor2585CF;
                            break;
                        }
                    }
                }
            }
        }
        else {
            subV._isSelected = TRUE;
            subV._selectImageV.image = [UIImage imageNamed:@"FilterMoreSelected.png"];
            subV._companyName.textColor =  FontColor2585CF;
            if (subV.tag == 0) {
                for (View4SubView * elem in [self._view4 subviews]) {
                    if ([elem isKindOfClass:[View4SubView class]]) {
                        if (elem.tag !=0) {
                            elem._isSelected = FALSE;
                             elem._selectImageV.image = [UIImage imageNamed:@"FilterMoreUnSelected.png"];
                             elem._companyName.textColor =  FontColor333333;
                        }
                    }
                }
            }
            else {
                for (View4SubView * elem in [self._view4 subviews]) {
                    if ([elem isKindOfClass:[View4SubView class]]) {
                        if (elem.tag == 0) {
                            elem._isSelected = FALSE;
                            elem._selectImageV.image = [UIImage imageNamed:@"FilterMoreUnSelected.png"];
                            elem._companyName.textColor =  FontColor333333;
                            break;
                        }
                    }
                }
            }
        }
    }
    else if ([self._airlines count] == 1) {
        subV._selectImageV.image = [UIImage imageNamed:@"FilterMoreSelected.png"];
        subV._companyName.textColor =  FontColor2585CF;
    }
}
-(void)set_airlines:(NSMutableArray *)airlines
{
    for (UIView * sub in [self._view4 subviews]) {
        if (sub.tag !=-1) {
            [sub removeFromSuperview];
        }
        
//        if ([sub isKindOfClass:[View4SubView class]]) {
//            return;
//        }
    }
    
    if (_airlines != airlines) {
        [_airlines release];
        _airlines = [airlines retain];
        
        
        if ([airlines count]>1) {

            View4SubView * subV = [[View4SubView alloc] initWithFrame:CGRectMake(16, 3, 40, 45)];
            subV.tag = 0;
            subV._companyName.text = @"全部航空";
            subV._companyName.textColor = FontColor2585CF;
            subV._selectImageV.image = [UIImage imageNamed:@"FilterMoreSelected.png"];
            subV._companyImageV.image = [UIImage imageNamed:@"FilterSelectedAll.png"];
            [subV._clickButton addTarget:self action:@selector(selectAirlines:) forControlEvents:UIControlEventTouchUpInside];
            [self._view4 addSubview:subV];
            subV._isSelected = TRUE;
            [subV release];
            
            for ( int i=0; i< [airlines count];i++) {
                
                float xCoordinate = 76 + i * 60;
                float yCoordinate = 3;
                if (xCoordinate + 40 > ViewWidth) {
                    CGRect rect = self._view4.frame;
                    rect.size.height = 100;
                    self._view4.frame= rect;
                    
                    xCoordinate -= 300; 
                    yCoordinate = 50;
                }
                else {
                    CGRect rect = self._view4.frame;
                    rect.size.height = 50;
                    self._view4.frame= rect;
                  
                }
                
                View4SubView * subV = [[View4SubView alloc] initWithFrame:CGRectMake(xCoordinate, yCoordinate, 40, 45)];
                subV.tag = i+1;
                subV._companyName.text = [[airlines objectAtIndex:i] objectAtIndex:0];
                subV._companyName.textColor = FontColor333333;
                subV._selectImageV.image = [UIImage imageNamed:@"FilterMoreUnSelected.png"];
                subV._companyImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [[[airlines objectAtIndex:i] objectAtIndex:1] substringToIndex:2]]];
                subV._isSelected = FALSE;
                subV._clickButton.tag = i+1;
                [subV._clickButton addTarget:self action:@selector(selectAirlines:) forControlEvents:UIControlEventTouchUpInside];
                [self._view4 addSubview:subV];
                [subV release];
                
            }
        }
        else if([airlines count] == 1){
            View4SubView * subV = [[View4SubView alloc] initWithFrame:CGRectMake(16, 3, 40, 45)];
            subV.tag = 0;
            subV._companyName.text = [[airlines objectAtIndex:0] objectAtIndex:0];
            subV._companyName.textColor = FontColor2585CF;
            subV._selectImageV.image = [UIImage imageNamed:@"FilterMoreSelected.png"];
            subV._companyImageV.image = [UIImage imageNamed:@"FilterSelectedAll.png"];
            subV._isSelected = TRUE;
            [subV._clickButton addTarget:self action:@selector(selectAirlines:) forControlEvents:UIControlEventTouchUpInside];
            [self._view4 addSubview:subV];
            [subV release];
        }

    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        [self addSubview:[UIImageView ImageViewWithFrame:self.bounds image:[UIImage imageNamed:@"background.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"起飞时段" frame: CGRectMake(0, 2-2, ViewWidth, 25) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentCenter]];
        [self addSubview:[UISubLabel labelWithTitle:@"起飞机场" frame: CGRectMake(0, 100-2, ViewWidth, 25) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentCenter]];
        [self addSubview:[UISubLabel labelWithTitle:@"降落机场" frame: CGRectMake(0, 160-2, ViewWidth, 25) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentCenter]];
        [self addSubview:[UISubLabel labelWithTitle:@"航空公司" frame: CGRectMake(0, 220-2, ViewWidth, 25) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentCenter]];
        UIView * view1 =  [[UIView alloc] initWithFrame:CGRectMake(0, 24-2, ViewWidth, 77)];
        UIView * view2 =  [[UIView alloc] initWithFrame:CGRectMake(0, 121-2, ViewWidth, 38)];
        UIView * view3 =  [[UIView alloc] initWithFrame:CGRectMake(0, 183-2, ViewWidth, 37)];
        UIView * view4 =  [[UIView alloc] initWithFrame:CGRectMake(0, 242-2, ViewWidth, 50)];
        self._view1 =view1;
        self._view2 = view2;
        self._view3 = view3;
        self._view4 = view4;
        [view1 release];
        [view2 release];
        [view3 release];
        [view4 release];
        
        UIImageView * imageV1 = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 77) image:[UIImage imageNamed:@"FilterBackground1.png"]];
        imageV1.tag = -1;
        UIImageView * imageV2 = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 38) image:[UIImage imageNamed:@"FilterBackground2.png"]];
        imageV2.tag = -1;
        UIImageView * imageV3 = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 37) image:[UIImage imageNamed:@"FilterBackground2.png"]];
        imageV3.tag = -1;
        UIImageView * imageV4 = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 50) image:[UIImage imageNamed:@"FilterBackground3.png"]];
        imageV4.tag = -1;
        imageV4.autoresizesSubviews = YES;
        imageV4.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        
        [self._view1 addSubview:imageV1];
        [self._view2 addSubview:imageV2];
        [self._view3 addSubview:imageV3];
        [self._view4 addSubview:imageV4];
        
        [self addSubview:self._view1];
        [self addSubview:self._view2];
        [self addSubview:self._view3];
        [self addSubview:self._view4];
        self._FilterDownButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth-112)/2, frame.size.height - 40, 112, 35) backImage:[UIImage imageNamed:@"FilterDown.png"] target:self   action:@selector(filterDown)];//((320-112)/2, frame.size.height - 50, 112, 35) (113, 345, 93, 29)
        [self addSubview:self._FilterDownButton];
    }
    return self;
}
-(void)filterDown
{
    self._selectTimeRange = (NSMutableArray *)[NSArray arrayWithObjects:[NSString stringWithFormat:@"%02d:00",(int)(flightTimeSlider.selectedMinimumValue + 0.5)], [NSString stringWithFormat:@"%02d:00",(int)(flightTimeSlider.selectedMaximumValue + 0.5)],nil];
    self._selectStartAirport = [NSMutableArray array];
    self._selectEndAirport = [NSMutableArray array];
    self._selectAirlines = [NSMutableArray array];
    if ([self._startAirport count]>1) {
        BOOL isSelectedAll = FALSE;
        for (View23SubView * elem in [self._view2 subviews]) {
            if ([elem isKindOfClass:[View23SubView class]]) {
                if (elem .tag == 0 ) {
                    if (elem._isSelected) {
                        isSelectedAll = TRUE;
                        self._selectStartAirport = self._startAirport;
                        break;
                    }
                }
            }
        }
        if (!isSelectedAll) {
            for (View23SubView * elem in [self._view2 subviews]) {
                if ([elem isKindOfClass:[View23SubView class]]) {
                    if (elem .tag != 0 ) {
                        if (elem._isSelected) 
                            [self._selectStartAirport addObject:elem._airportLabel.text];
                        }
                    }
            }
            }
    }
    else if([self._startAirport count]==1){
        self._selectStartAirport = self._startAirport;
    }
    if ([self._endAirport count]>1) {
        BOOL isSelectedAll = FALSE;
        for (View23SubView * elem in [self._view3 subviews]) {
            if ([elem isKindOfClass:[View23SubView class]]) {
                if (elem .tag == 0 ) {
                    if (elem._isSelected) {
                        self._selectEndAirport = self._endAirport;
                        isSelectedAll = TRUE;
                        break;
                    }
                }
            }
        }
        if (!isSelectedAll) {
            for (View23SubView * elem in [self._view3 subviews]) {
                if ([elem isKindOfClass:[View23SubView class]]) {
                    if (elem .tag != 0 ) {
                        if (elem._isSelected) 
                            [self._selectEndAirport addObject:elem._airportLabel.text];
                    }
                }
            }
        }
    }
    else if ([self._endAirport count]==1) {
        self._selectEndAirport = self._endAirport;
    }
    if ([self._airlines count]>1) {
        BOOL isSelectedAll = FALSE;
        for (View4SubView * elem in [self._view4 subviews]) {
            if ([elem isKindOfClass:[View4SubView class]]) {
                if (elem .tag == 0 ) {
                    if (elem._isSelected) {
                        for (NSArray * elem in self._airlines) {
                            [self._selectAirlines addObject:[elem objectAtIndex:0]];
                        }
                        isSelectedAll = TRUE;
                        break;
                    }
                }
            }
        }
        if (!isSelectedAll) {
            for (View4SubView * elem in [self._view4 subviews]) {
                if ([elem isKindOfClass:[View4SubView class]]) {
                    if (elem .tag != 0 ) {
                        if (elem._isSelected) {
                            for (NSArray * elemArray in self._airlines) {
                                if ([[elemArray objectAtIndex:0] isEqualToString: elem._companyName.text ]) {
                                    [self._selectAirlines  addObject:elem._companyName.text];
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    else if ([self._airlines count]==1){
        [self._selectAirlines addObject:[[self._airlines objectAtIndex:0] objectAtIndex:0]];
    }
    NSLog(@"%@,%@,%@,%@",self._selectTimeRange,self._selectStartAirport,self._selectEndAirport,self._selectAirlines);
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterDown)]) {
        [self.delegate performSelector:@selector(filterDown)];
    }
}

@end

@interface TicketQueryDetailViewController ()

@end

@implementation TicketQueryDetailViewController
@synthesize myTable,dataArray,queryTicket,queryDataModel,selectedFlightInfo,filterView,filterDataArray,bottomView;
@synthesize flightsInfoArray;
@synthesize searchDate;
@synthesize sortArrayBy;
-(void)dealloc
{
    self.myTable = nil;
    self.dataArray = nil;
    self.filterDataArray = nil;

    self.queryTicket = nil;
    self.queryDataModel = nil;
    self.selectedFlightInfo = nil;
    self.filterView = nil;
    self.bottomView = nil;
    self.flightsInfoArray = nil;
    self.searchDate = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setBottomView:(BottomView *)_bottomView
{
     if (bottomView != _bottomView)
    {
        [bottomView release];
        bottomView = [_bottomView retain];
        
        NSString * nowDay =  [NSDate dateCode:[NSDate date]]; //2012-01-01
        NSLog(@"%@",nowDay);

        NSArray * nowDayArray = [nowDay componentsSeparatedByString:@"-"];
        NSString * lastDay =  [NSString stringWithFormat:@"%4d-%@-%@",[[nowDayArray objectAtIndex:0] intValue]+1,[nowDayArray objectAtIndex:1],[nowDayArray objectAtIndex:2]];
        if ([self.searchDate isEqualToString:lastDay]) {
            self.bottomView._nextButton.enabled = NO;
            self.bottomView._nextLabel.textColor = FontColor1C7CBC;
            self.bottomView._rightImageView.image = [UIImage imageNamed:@"TicketListBottomRight2.png"];
        }
        else {
            self.bottomView._nextButton.enabled = YES;
            self.bottomView._nextLabel.textColor = FontColorFFFFFF;
            self.bottomView._rightImageView.image = [UIImage imageNamed:@"TicketListBottomRight1.png"];
        }
        
        if ([self.searchDate isEqualToString:[NSDate dateCode:[NSDate date]]]) {
            self.bottomView._proButton.enabled = NO;
            self.bottomView._proLabel.textColor = FontColor1C7CBC;
            self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft2.png"];
        }
        else {
            self.bottomView._proButton.enabled = YES;
            self.bottomView._proLabel.textColor = FontColorFFFFFF;
            self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft1.png"];
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    selectButton = 1;
    sortDese = FALSE;
    self.searchDate = self.queryDataModel._startDate._nameCode;
    
    UIView * headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, ViewWidth, 35);
    
    timeButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListTimeNone.png"] target:self action:@selector(timeButton:)];
    filterButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth/3, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListFilterNone.png"] target:self action:@selector(filterButton:)];
    priceButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(ViewWidth*2/3, 0, ViewWidth/3, 35) backImage:[UIImage imageNamed:@"TicketListPriceNone.png"] target:self action:@selector(priceButton:)];
    [headView addSubview : timeButton];
    [headView addSubview : filterButton];
    [headView addSubview : priceButton];
    
    BottomView * bottomV = [[BottomView alloc] initWithFrame:CGRectMake(0, ViewHeight  - 44-41, ViewWidth, 41)];
    [bottomV._nextButton addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomV._proButton addTarget:self action:@selector(proButton:) forControlEvents:UIControlEventTouchUpInside];
    bottomV._dateLabel.text = self.queryDataModel._startDate._nameCode;
    bottomV._weekLabel.text = [NSDate getWeekDayLongStr:self.queryDataModel._startDate._nameCode];
    self.bottomView = bottomV;
    [bottomV release];
    
    [self sortDateArray];
    
    UITableView * tempTable = [[UITableView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height + 5, ViewWidth, ViewHeight-44-headView.frame.size.height - 5) style:UITableViewStylePlain];
    tempTable.backgroundColor = [UIColor clearColor];
    tempTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    tempTable.dataSource = self;
    tempTable.delegate = self;
    self.myTable =tempTable;
        
    [self.view addSubview:tempTable];
    [tempTable release];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:headView];
    [headView release];
    if (self.queryDataModel._flightType == SingleType) 
    {
        self.flightsInfoArray = [NSMutableArray arrayWithObjects:@"", nil];
    }

}
static NSInteger sortTicketArrayByPriceAesc(id item1, id item2, void *context){//升序
    
    FlightInfo *info1 = item1;
    FlightInfo *info2 = item2;
    int v1 = [info1._ticketPrice intValue];
    int v2 = [info2._ticketPrice intValue];
    
	if (v1 < v2)
        return NSOrderedAscending;//降序
    else if (v1 >v2)
        return NSOrderedDescending;//升序
    else
        return NSOrderedSame;

}

static NSInteger sortTicketArrayByPriceDesc(id item1, id item2, void *context){//降序
    
    FlightInfo *info1 = item1;
    FlightInfo *info2 = item2;
    int v1 = [info1._ticketPrice intValue];
    int v2 = [info2._ticketPrice intValue];
	if (v1 < v2)
        return NSOrderedDescending;//降序
    else if (v1 >v2)
        return NSOrderedAscending;//升序
    else
        return NSOrderedSame;
}

static NSInteger sortTicketArrayByTimeAesc(id item1, id item2, void *context){//升序
    FlightInfo *info1 = item1;
    FlightInfo *info2 = item2;
    if ([info1._startDate compare:info2._startDate] < 0)
        return NSOrderedAscending;
    else if ([info1._startDate compare:info2._startDate] > 0)
        return NSOrderedDescending;
    else
        return NSOrderedSame;    
}

static NSInteger sortTicketArrayByTimeDesc(id item1, id item2, void *context){//降序
    FlightInfo *info1 = item1;
    FlightInfo *info2 = item2;
    if ([info1._startDate compare:info2._startDate] >0)
        return NSOrderedAscending;
    else if ([info1._startDate compare:info2._startDate] < 0)
        return NSOrderedDescending;
    else
        return NSOrderedSame;    
}
-(void)sortDateArray
{
    if (sortArrayBy != Filter) {
        [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeNone.png"] forState:UIControlStateNormal];
        [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
        [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceNone.png"] forState:UIControlStateNormal];
    }
    
    switch (sortArrayBy) {
        case TimeAesc:
            [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeUp.png"] forState:UIControlStateNormal];
            for (FlightInfo * flightInfo in self.filterDataArray) {
                if ([flightInfo._soldout boolValue]) {
                    flightInfo._startDate = [NSString stringWithFormat:@"9000%@",[flightInfo._startDate substringFromIndex:4]];
                }
            }
            self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortTicketArrayByTimeAesc context:NULL];
            self.dataArray = (NSMutableArray *)[self.dataArray sortedArrayUsingFunction:sortTicketArrayByTimeAesc context:NULL];
            break;
        case TimeDesc:
            [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeDown.png"] forState:UIControlStateNormal];
            for (FlightInfo * flightInfo in self.filterDataArray) {
                if ([flightInfo._soldout boolValue]) {
                    flightInfo._startDate = [NSString stringWithFormat:@"1000%@",[flightInfo._startDate substringFromIndex:4]];
                }
            }
            self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortTicketArrayByTimeDesc context:NULL];
            self.dataArray = (NSMutableArray *)[self.dataArray sortedArrayUsingFunction:sortTicketArrayByTimeDesc context:NULL];
            break;
        case PriceAesc:
            [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceUp.png"] forState:UIControlStateNormal];
            for (FlightInfo * flightInfo in self.filterDataArray) {
                if ([flightInfo._soldout boolValue]) {
                    flightInfo._ticketPrice = [NSString stringWithFormat:@"%d",[flightInfo._ticketPrice intValue] + 1000000];
                }
            }
            self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortTicketArrayByPriceAesc context:NULL];
            self.dataArray = (NSMutableArray *)[self.dataArray sortedArrayUsingFunction:sortTicketArrayByPriceAesc context:NULL];
            break;
        case PriceDesc:
            [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceDown.png"] forState:UIControlStateNormal];
            for (FlightInfo * flightInfo in self.filterDataArray) {
                if ([flightInfo._soldout boolValue]) {
                    flightInfo._ticketPrice =@"0"; //[NSString stringWithFormat:@"%d",[flightInfo._ticketPrice intValue] + 1000000];
                }
            }
            self.filterDataArray = (NSMutableArray *)[self.filterDataArray sortedArrayUsingFunction:sortTicketArrayByPriceDesc context:NULL];
            self.dataArray = (NSMutableArray *)[self.dataArray sortedArrayUsingFunction:sortTicketArrayByPriceDesc context:NULL];
            break;
        case Filter:
            [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilter.png"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
     [myTable reloadData];

}
-(void)setSortArrayBy:(SortArrayBy)_sortArrayBy
{
    sortArrayBy = _sortArrayBy;
    [self sortDateArray];
}
-(void)timeButton:(UIButton *)sender
{
    NSLog(@"timeButton");
    [self.filterView removeFromSuperview];
    sortDese = !sortDese;
    selectButton = 1;
    if (sortDese) {
        self.sortArrayBy = TimeDesc;
//        [self sortDateArray];
    }
    else {
        self.sortArrayBy = TimeAesc;
//        [self sortDateArray];
    }

    [self.myTable reloadData];
}

-(void)filterButton:(UIButton *)sender
{
    
    NSLog(@"filterButton");
    [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeNone.png"] forState:UIControlStateNormal];
    [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceNone.png"] forState:UIControlStateNormal];
    
    self.sortArrayBy = Filter;
//    [self sortDateArray];
    
    if (self.filterView == nil) {
        FilterView * filterView1 = [[FilterView alloc] initWithFrame:CGRectMake(0,35,ViewWidth,ViewHeight - (IOS7_OR_LATER?15:35)  )];
        self.filterView = filterView1;
        self.filterView.delegate = self;
         [filterView1 release];
        NSMutableArray * timeRange = [NSMutableArray arrayWithObjects:@"6",@"24",nil];
        NSMutableArray * startAirport = [NSMutableArray array];
        NSMutableArray * endAirport = [NSMutableArray array];
        NSMutableArray * airlines = [NSMutableArray array];
        NSMutableArray * tempAirlines = [NSMutableArray array];
        for (FlightInfo * elem in self.dataArray) {
            if (![startAirport containsObject:elem._startAirport]) {
                [startAirport addObject:elem._startAirport];
            }
            if (![endAirport containsObject:elem._endAirport]) {
                [endAirport addObject:elem._endAirport];
            }
            if (![tempAirlines containsObject:elem._airline]) {
                [tempAirlines addObject:elem._airline];
                [airlines addObject:[NSArray arrayWithObjects:elem._airline,elem._flightNo, nil]];
            }
        }
        NSLog(@"%@,%@,%@",startAirport,endAirport,airlines);
        self.filterView._timeRange = timeRange;
        self.filterView._startAirport = startAirport;
        self.filterView._endAirport = endAirport;
        self.filterView._airlines = airlines;
    }

    self.filterView.frame = CGRectMake(0,35,ViewWidth,ViewHeight - (IOS7_OR_LATER?15:35)  );
    if (self.filterView.superview == nil) {
         [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilter.png"] forState:UIControlStateNormal];
        [self.view insertSubview:self.filterView atIndex: [[self.view subviews] count] -1 animated:YES ];
    }
    else
    {
        [self setTicketButtonTypeImage];
         [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
        [self.filterView removeFromSuperviewWithAnimated:YES];
    }
    
}
-(void)filterDown
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (FlightInfo * info in self.dataArray) {
        if ([[info._startDate substringFromIndex:11] compare: [self.filterView._selectTimeRange objectAtIndex:0]]>=0 && [[info._startDate substringFromIndex:11] compare: [self.filterView._selectTimeRange objectAtIndex:1]]<=0) {
            if ([self.filterView._selectStartAirport containsObject:info._startAirport]) {
                if ([self.filterView._selectEndAirport containsObject:info._endAirport]) {
                    if ([self.filterView._selectAirlines containsObject:info._airline]) {
                        [tmpArray addObject:info];
                    }
                }
            }
        }
    }
    [filterButton setBackgroundImage:[UIImage imageNamed:@"TicketListFilterNone.png"] forState:UIControlStateNormal];
    
    
    [self setTicketButtonTypeImage];
    if ([tmpArray count] == 0) {
        [self.filterView removeFromSuperviewWithAnimated:YES];
        [UIAlertView alertViewWithMessage:@"未找到符合您筛选条件经的航班，请修改筛选条件重新查询。" :@"提示"];
    }
    else {
        self.filterDataArray = tmpArray;
        [self.filterView removeFromSuperviewWithAnimated:YES];
        [myTable reloadData];
    }
}

-(void)priceButton:(UIButton *)sender
{
    [self.filterView removeFromSuperview];
    selectButton = 2;
    self.sortArrayBy = PriceAesc;
//    [self sortDateArray];
    [self.myTable reloadData];
}
-(void)nextOnPaseredResult:(NSDictionary *)resultDic
{
    self.queryTicket= [QueryFlightTicket QueryFlightTicket:resultDic];
    self.dataArray = (NSMutableArray *)self.queryTicket._firstFlightInfo;
    self.filterDataArray = self.dataArray;
    
    if ([self.dataArray count] == 0) {
        [UIAlertView alertViewWithMessage:@"您查询的航班起飞，或该航线当天无航班，请查询后一天的航班。" :@"提示"];
    }

    self.queryDataModel._startDate._nameCode = searchDate;
    self.queryDataModel._startDate._nameStr = [NSDate dateFormateTicketQuery:[NSDate dateFromString:searchDate]];
    
    self.searchDate = self.queryDataModel._startDate._nameCode;

    [myTable reloadData];
    
    NSString * nowDay =  [NSDate dateCode:[NSDate date]]; //2012-01-01
    
    if (self.queryDataModel._flightType == RoundTypeBack) {
        nowDay = [NSDate dateafterDay:[NSDate dateFromString:nowDay] day:Delay_Days type:1];
    }
    
    NSArray * nowDayArray = [nowDay componentsSeparatedByString:@"-"];
    NSString * lastDay =  [NSString stringWithFormat:@"%4d-%@-%@",[[nowDayArray objectAtIndex:0] intValue]+1,[nowDayArray objectAtIndex:1],[nowDayArray objectAtIndex:2]];
    if ([self.searchDate isEqualToString:lastDay]) {
        self.bottomView._nextButton.enabled = NO;
        self.bottomView._nextLabel.textColor = FontColor1C7CBC;
        self.bottomView._rightImageView.image = [UIImage imageNamed:@"TicketListBottomRight2.png"];
    }
    else {
        self.bottomView._nextButton.enabled = YES;
        self.bottomView._nextLabel.textColor = FontColorFFFFFF;
        self.bottomView._rightImageView.image = [UIImage imageNamed:@"TicketListBottomRight1.png"];
    }
    
    if ([self.searchDate isEqualToString:[NSDate dateCode:[NSDate date]]]) {
        self.bottomView._proButton.enabled = NO;
        self.bottomView._proLabel.textColor = FontColor1C7CBC;
        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft2.png"];
    }
    else {
        self.bottomView._proButton.enabled = YES;
        self.bottomView._proLabel.textColor = FontColorFFFFFF;
        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft1.png"];
    }
    self.bottomView._dateLabel.text = searchDate;
    self.bottomView._weekLabel.text = [NSDate getWeekDayLongStr:searchDate];
    
    [self sortDateArray];
}

-(void)nextButton:(UIButton *)sender
{
    NSLog(@"nextButton");
    
//    self.dataArray = nil;
//    self.filterDataArray = nil;
//    [myTable reloadData];
    
    self.searchDate = [NSDate dateafterDay:[NSDate dateFromString:self.queryDataModel._startDate._nameCode] day:1 type:1];
    
    if ([ActivityTimerView shareTimerView]._isAactivation && [self.searchDate compare:activeEndDate] > 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"不在活动订票时间范围内，没有畅达币赠送，是否继续订票" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 72;
        [alert show];
        [alert release];
        return;
    }

    NSString * nowDay =  [NSDate dateCode:[NSDate date]]; //2012-01-01
    
    if (self.queryDataModel._flightType == RoundTypeBack) {
        nowDay = [NSDate dateafterDay:[NSDate dateFromString:nowDay] day:Delay_Days type:1];
    }
    
//    NSArray * nowDayArray = [nowDay componentsSeparatedByString:@"-"];
//    NSString * lastDay =  [NSString stringWithFormat:@"%4d-%@-%@",[[nowDayArray objectAtIndex:0] intValue]+1,[nowDayArray objectAtIndex:1],[nowDayArray objectAtIndex:2]];
//    if ([self.searchDate isEqualToString:lastDay]) {
//        self.bottomView._nextButton.enabled = NO;
//        self.bottomView._nextLabel.textColor = FontColor1C7CBC;
//        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomRight2.png"];
//    }
//    else {
//        self.bottomView._nextButton.enabled = YES;
//        self.bottomView._nextLabel.textColor = FontColorFFFFFF;
//        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomRight1.png"];
//    }
//    
//    if ([self.searchDate isEqualToString:[NSDate dateCode:[NSDate date]]]) {
//        self.bottomView._proButton.enabled = NO;
//        self.bottomView._proLabel.textColor = FontColor1C7CBC;
//        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft2.png"];
//    }
//    else {
//        self.bottomView._proButton.enabled = YES;
//        self.bottomView._proLabel.textColor = FontColorFFFFFF;
//        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft1.png"];
//    }
//
//    self.bottomView._dateLabel.text = searchDate;
//    self.bottomView._weekLabel.text = [NSDate getWeekDayLongStr:searchDate];
    
    TicketQueryDataModelElem * dptDataModel = self.queryDataModel._fromCity;
    TicketQueryDataModelElem * dstDataModel = self.queryDataModel._toCity;
    NSString * fType = nil ;
    switch (self.queryDataModel._flightType) {
        case SingleType:
            fType = @"1";
            break;
        case RoundTypeGo :
        case  RoundTypeBack:
            fType = @"1";
            break;
        case ConnectTypeFirst :
        case ConnectTypeSecond:
            fType = @"3";
            break;
        default:
            break;
    }
    ASIFormDataRequest * theRequest = [InterfaceClass queryFlightTicketWithDeparture:dptDataModel._nameCode arrival:dstDataModel._nameCode transitCity:self.queryDataModel._transitCity._nameCode startDate:searchDate returnDate:self.queryDataModel._arriveDate._nameCode flightType:fType];
    
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(nextOnPaseredResult:) Delegate:self needUserType:Default];
}

-(void)proButton:(UIButton *)sender
{
    NSLog(@"proButton");
//    self.dataArray = nil;
//    self.filterDataArray = nil;
//    [myTable reloadData];
    
    self.searchDate = [NSDate dateafterDay:[NSDate dateFromString:self.queryDataModel._startDate._nameCode] day:-1 type:1];
    if ([ActivityTimerView shareTimerView]._isAactivation && [self.searchDate compare:activeStartDate] < 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"不在活动订票时间范围内，没有畅达币赠送，是否继续订票" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 71;
        [alert show];
        [alert release];
        return;
    }
    
    
//    NSString * nowDay =  [NSDate dateCode:[NSDate date]]; //2012-01-01
//    if (self.queryDataModel._flightType == RoundTypeBack) {
//        nowDay = [NSDate dateafterDay:[NSDate dateFromString:nowDay] day:Delay_Days type:1];
//    }
//    NSArray * nowDayArray = [nowDay componentsSeparatedByString:@"-"];
//    NSString * lastDay =  [NSString stringWithFormat:@"%4d-%@-%@",[[nowDayArray objectAtIndex:0] intValue]+1,[nowDayArray objectAtIndex:1],[nowDayArray objectAtIndex:2]];
//    if ([self.searchDate isEqualToString:lastDay]) {
//        self.bottomView._nextButton.enabled = NO;
//        self.bottomView._nextLabel.textColor = FontColor1C7CBC;
//        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomRight2.png"];
//    }
//    else {
//        self.bottomView._nextButton.enabled = YES;
//        self.bottomView._nextLabel.textColor = FontColorFFFFFF;
//        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomRight1.png"];
//    }
//
//    if ([self.searchDate isEqualToString:[NSDate dateCode:[NSDate date]]]) {
//        self.bottomView._proButton.enabled = NO;
//        self.bottomView._proLabel.textColor = FontColor1C7CBC;
//        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft2.png"];
//    }
//    else {
//        self.bottomView._proButton.enabled = YES;
//        self.bottomView._proLabel.textColor = FontColorFFFFFF;
//        self.bottomView._leftImageView.image = [UIImage imageNamed:@"TicketListBottomLeft1.png"];
//    }
//
//    self.bottomView._dateLabel.text = searchDate;
//    self.bottomView._weekLabel.text = [NSDate getWeekDayLongStr:searchDate];
    
    
    TicketQueryDataModelElem * dptDataModel = self.queryDataModel._fromCity;
    TicketQueryDataModelElem * dstDataModel = self.queryDataModel._toCity;
    
    NSString * fType = nil ;
    switch (self.queryDataModel._flightType) {
        case SingleType:
            fType = @"1";
            break;
        case RoundTypeGo :
        case  RoundTypeBack:
            fType = @"1";
            break;
        case ConnectTypeFirst :
        case ConnectTypeSecond:
            fType = @"3";
            break;
        default:
            break;
    }

   
    
    ASIFormDataRequest * theRequest = [InterfaceClass queryFlightTicketWithDeparture:dptDataModel._nameCode arrival:dstDataModel._nameCode transitCity:self.queryDataModel._transitCity._nameCode startDate:searchDate returnDate:self.queryDataModel._arriveDate._nameCode flightType:fType];
    
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(nextOnPaseredResult:) Delegate:self needUserType:Default];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.filterDataArray count ];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlightInfo * flightInfo = [self.filterDataArray objectAtIndex:indexPath.row];
    TicketQueryDetailCell * cell = nil;
    
    if (![flightInfo._soldout boolValue]) {
            static NSString * ticketQueryDetailCellIdentifier = @"ticketQueryDetailCellIdentifier";
            cell = [tableView dequeueReusableCellWithIdentifier:ticketQueryDetailCellIdentifier];
            if (cell == nil) {
                cell = [[[TicketQueryDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ticketQueryDetailCellIdentifier] autorelease];
            }
    }
    else{
        static NSString * ticketQueryDetailSaleOverCellIdentifier = @"ticketQueryDetailSaleOverCellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:ticketQueryDetailSaleOverCellIdentifier];
        if (cell == nil) {
            cell = [[[TicketQueryDetailSaleOverCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ticketQueryDetailSaleOverCellIdentifier] autorelease];
        }
    }

    cell._companyImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[flightInfo._flightNo substringToIndex:2]]];
    cell._startDate.text = [flightInfo._startDate substringFromIndex:11];
    cell._endTime.text = [flightInfo._endTime substringFromIndex:11];
    cell._startAirport.text =[NSString stringWithFormat:@"%@%@",flightInfo._startAirport,flightInfo._startTerminal] ;
    cell._endAirport.text = [NSString stringWithFormat:@"%@%@",flightInfo._endAirport,flightInfo._endTerminal] ;
    cell._flightNo.text = [NSString stringWithFormat:@"%@%@",flightInfo._airline,flightInfo._flightNo];
    cell._planeType.text = [NSString stringWithFormat:@"机型:%@",flightInfo._planeType]; 
    
    cell._lowerImageV.hidden = !flightInfo._isdrop;
//    if ([flightInfo._dropFee intValue] >0) {
//        cell._lowerImageV.hidden = NO;
//    }
//    else {
//        cell._lowerImageV.hidden = YES;
//    }
    
    if ([flightInfo._ticketCount length] > 1) {
        cell._ticketCount.text = @"充足";
        //cell._ticketCount.backgroundColor = [UIColor clearColor];
        cell._ticketCount.textColor = FontColor636363;
    }
    else  {
        cell._ticketCount.text = [NSString stringWithFormat:@"%@张",flightInfo._ticketCount];
        if ([flightInfo._ticketCount intValue]<=3)
        {
//            cell._ticketCount.backgroundColor = FontColorRed;
//            cell._ticketCount.textColor = FontColorFFFFFF;
            //cell._ticketCount.backgroundColor = [UIColor clearColor];
            cell._ticketCount.textColor = FontColorRed;
        }
        else {
            //cell._ticketCount.backgroundColor = [UIColor clearColor];
            cell._ticketCount.textColor = FontColorFF8813;
        }
    }
    cell._ticketPrice.text = flightInfo._ticketPrice;

//    cell._returnLcdFee.text = [NSString stringWithFormat:@"返%3d",[flightInfo._returnLcdFee intValue]]; 
//    cell._returnLcdImage.hidden = NO;
    
    if ([flightInfo._returnLcdFee intValue] > 0) {
        cell._returnLcdFee.text = [NSString stringWithFormat:@"返%3d",[flightInfo._returnLcdFee intValue]];
        cell._returnLcdImage.hidden = NO;
    }
    else {
        cell._returnLcdFee.text = @"";
        cell._returnLcdImage.hidden = YES;
    }
    
    if ([flightInfo._discount floatValue] < 100) {
        NSString * str = [NSString stringWithFormat:@"%.1f",[flightInfo._discount floatValue] / 10];
        NSArray * array = [str componentsSeparatedByString:@"."];
        if ([[array objectAtIndex:1] intValue]==0) {
            cell._discount.text = [NSString stringWithFormat:@"%.f折",[flightInfo._discount floatValue] / 10];
        }
        else {
            cell._discount.text = [NSString stringWithFormat:@"%.1f折",[flightInfo._discount floatValue] / 10];
        }
        
    }
    else if ([flightInfo._discount intValue] == 100) {
        cell._discount.text = [NSString stringWithFormat:@"全价"];
    }
    else {
        cell._discount.text = [NSString stringWithFormat:@"%.0f%@",[flightInfo._discount floatValue],@"%"];
    }
    return cell;
}
-(NSDate *)NSStringDateToNSDate:(NSString *)string {  
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [formatter dateFromString:string];
    [formatter release];
    return date;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    FlightInfo * selectFlight = [self.filterDataArray objectAtIndex:indexPath.row];
    self.selectedFlightInfo = selectFlight;
    
    if ([self.selectedFlightInfo._soldout boolValue])
    {
        return;
    }
    
    [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 0, 300, 74)];
    TicketInfoViewController * preVC = [NavigationController.viewControllers objectAtIndex:[NavigationController.viewControllers count] - 2];
    //if ((self.queryDataModel._flightType == RoundTypeBack)||(self.queryDataModel._flightType == ConnectTypeSecond)) 
    if ([preVC isKindOfClass:[TicketInfoViewController class]]) 
    {
        NSString * messageStr = @"第二航程的起飞时间必须在第一航程到达时间的2个小时后！";
        if (self.queryDataModel._flightType == RoundTypeBack) {
            messageStr = @"返程的起飞时间必须在往程到达时间的2个小时后！";
        }
        FlightInfo * firstFlight = [self.flightsInfoArray objectAtIndex:0];
        if ([(NSDate *)[[self NSStringDateToNSDate:firstFlight._endTime] dateByAddingTimeInterval:2*60*60.0f]  compare:[self NSStringDateToNSDate:selectFlight._startDate]] >0) {
            [UIAlertView alertViewWithMessage:messageStr :@"提示"];
            return;
        }
    }
    else {
        if ((self.queryDataModel._flightType == RoundTypeBack)) 
        {
            self.queryDataModel._flightType = RoundTypeGo;
        }
        else if ((self.queryDataModel._flightType == ConnectTypeSecond)) 
        {
            self.queryDataModel._flightType = ConnectTypeFirst;
        }
    }
    
    
    if (![self.selectedFlightInfo._soldout boolValue])
    {
        TicketQueryDataModelElem * dptDataModel = self.queryDataModel._fromCity;
        TicketQueryDataModelElem * dstDataModel = self.queryDataModel._toCity;
        TicketQueryDataModelElem * goDataModel = self.queryDataModel._startDate;
        //TicketQueryDataModelElem * backDataModel = self.queryDataModel._arriveDate;
        
        NSString * isadultTax = @"false";        //20150515判断是否需要查询成人基建燃油费
        if ([self.selectedFlightInfo._airportTaxForAdult intValue]==0 && [self.selectedFlightInfo._fuelTaxForAdult intValue]==0) {
            NSLog(@"%@,%@",self.selectedFlightInfo._airportTaxForAdult,self.selectedFlightInfo._fuelTaxForAdult);
            isadultTax = @"true";
        }
        ASIFormDataRequest * theRequest = [InterfaceClass queryFlightTicketDetailWithDeparture:dptDataModel._nameCode arrival:dstDataModel._nameCode flightNo:self.selectedFlightInfo._flightNo departureDate:goDataModel._nameCode airline:[self.selectedFlightInfo._flightNo substringToIndex:2] planeType:self.selectedFlightInfo._planeType isStop:[self.selectedFlightInfo._stopNum intValue]==0?@"false":@"true" startAirportCode:self.selectedFlightInfo._startAirportCode endAirportCode:self.selectedFlightInfo._endAirportCode isAdultTax:isadultTax];
        
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onqueryFlightTicketDetailWithDeparturePaseredResult:) Delegate:self needUserType:Default];
    }
}
-(void)pushTickeInfoVC
{
    TicketInfoViewController * ticketInfoVC = [[TicketInfoViewController alloc] init];
    ticketInfoVC.delegate = self;
    ticketInfoVC.queryTicket = self.selectedFlightInfo;
    ticketInfoVC.dataArray = self.selectedFlightInfo._cabinInfo;
    ticketInfoVC.queryDataModel = self.queryDataModel;
    ticketInfoVC.flightsInfoArray = self.flightsInfoArray;
    ticketInfoVC._fromWeather = self.queryTicket._departureWeather;
    ticketInfoVC._toWeather = self.queryTicket._arrivalWeather;
    [NavigationController pushViewController:ticketInfoVC animated:YES];
    [ticketInfoVC release];
}
-(void)onqueryFlightTicketDetailWithDeparturePaseredResult:(NSDictionary *)resultDic
{
    QueryFlightTicketDetail *  queryTicketDetail= [QueryFlightTicketDetail QueryFlightTicketDetail:resultDic];
    //20150515需要查询的时候才能获取到值，才能赋值
    if ([self.selectedFlightInfo._airportTaxForAdult intValue]==0 && [self.selectedFlightInfo._fuelTaxForAdult intValue]==0) {
        self.selectedFlightInfo._airportTaxForAdult = queryTicketDetail._airportTaxForAdult;
        self.selectedFlightInfo._fuelTaxForAdult = queryTicketDetail._fuelTaxForAdult;
    }
    self.selectedFlightInfo._airportTaxForChild = queryTicketDetail._airportTaxForChild;
    self.selectedFlightInfo._fuelTaxForChild = queryTicketDetail._fuelTaxForChild;
    self.selectedFlightInfo._stopCityInfo = queryTicketDetail._stopCityInfo;
    //20150515将天气获取信息放入该接口
    self.queryTicket._departureWeather = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"departureWeather"]];
    self.queryTicket._arrivalWeather = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"arrivalWeather"]];

    [self pushTickeInfoVC];
}
-(void)getOtherFlightData
{}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)setTicketButtonTypeImage
{
    if (selectButton == 1) {
        if (sortDese) {
            [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeDown.png"] forState:UIControlStateNormal];
        }
        else {
            [timeButton setBackgroundImage:[UIImage imageNamed:@"TicketListTimeUp.png"] forState:UIControlStateNormal];
        }
    }
    else if (selectButton == 2)
    {
        [priceButton setBackgroundImage:[UIImage imageNamed:@"TicketListPriceUp.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 71) {
        if (buttonIndex == 1) {
            [[ActivityTimerView shareTimerView] hiddenTimerView];
            [[ActivityTimerView shareTimerView] stopTimerView];
            [self proButton:nil];
        }
    }
    else if (alertView.tag == 72) {
        if (buttonIndex == 1) {
            [[ActivityTimerView shareTimerView] hiddenTimerView];
            [[ActivityTimerView shareTimerView] stopTimerView];
            [self nextButton:nil];
        }
    }
}
@end
