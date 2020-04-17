//
//  TrainListViewCell.m
//  FlightProject
//
//  Created by admin on 13-1-6.
//
//

#import "TrainListViewCell.h"

@implementation TrainListViewCell
@synthesize startView, reachView, trainView;
@synthesize startTimeLab, startStationLab, reachTimeLab, reachStationLab, trainNameLab, trainTypeLab, spendTimeLab, distanceLab, reachDayLab;

- (void)dealloc
{
    self.startTimeLab = nil;
    self.reachTimeLab = nil;
    self.startStationLab = nil;
    self.reachTimeLab = nil;
    self.trainNameLab = nil;
    self.trainTypeLab = nil;
    self.spendTimeLab = nil;
    self.distanceLab = nil;
    self.reachDayLab = nil;
    
    self.startView = nil;
    self.reachView = nil;
    self.trainView = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 0, ViewWidth-100, 75) image:[UIImage imageNamed:@"TicketListLeft.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-90, 0, 80, 75) image:[UIImage imageNamed:@"TicketListRight.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 52, ViewWidth-120, 1) image:[UIImage imageNamed:@"TicketListxuxian.png"]]];
        
        self.startView = [UIImageView ImageViewWithFrame:CGRectMake(25, 10, 15, 15) image:[UIImage imageNamed:@"trainIcon0.png"]];
        self.reachView = [UIImageView ImageViewWithFrame:CGRectMake(25, 32, 15, 15) image:[UIImage imageNamed:@"trainIcon2.png"]];
        
        self.startTimeLab = [UISubLabel labelWithTitle:@"06:30" frame:CGRectMake(10, 8, 90, 20) font:FontBlodSize42 color:FontColor2585CF alignment:NSTextAlignmentRight];
        self.reachTimeLab = [UISubLabel labelWithTitle:@"08:10" frame:CGRectMake(40, 30, 60, 20) font:FontBlodSize32 color:FontColorBlue alignment:NSTextAlignmentRight];
        self.reachDayLab = [UISubLabel labelWithTitle:@"(第2天)" frame:CGRectMake(103, 30, 60, 20) font:FontSize20 color:FontColor2585CF alignment:NSTextAlignmentLeft];
        self.startStationLab = [UISubLabel labelWithTitle:@"乌鲁木齐西" frame:CGRectMake(ViewWidth-190, 8, 90, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentRight];
        self.reachStationLab = [UISubLabel labelWithTitle:@"鄂尔多斯东" frame:CGRectMake(ViewWidth-190, 30, 90, 20) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentRight];
        
        self.spendTimeLab = [UISubLabel labelWithTitle:@"历时  22小时15分" frame:CGRectMake(20, 54, 150, 20) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentLeft];
        self.distanceLab = [UISubLabel labelWithTitle:@"里程1318KM" frame:CGRectMake(ViewWidth-180, 54, 80, 20) font:FontSize22 color:FontColor636363 alignment:NSTextAlignmentRight];
        
//        self.trainView = [UIImageView ImageViewWithFrame:CGRectMake(240, 8, 60, 15) image:[UIImage imageNamed:@"trainStart.png"]];
        self.trainNameLab = [UISubLabel labelWithTitle:@"K8888" frame:CGRectMake(ViewWidth-82, 5, 60, 50) font:FontBlodSize36 color:FontColorFF8813 alignment:NSTextAlignmentCenter];
        self.trainNameLab.minimumFontSize = 18;
        self.trainNameLab.adjustsFontSizeToFitWidth = YES;
        self.trainNameLab.lineBreakMode = UILineBreakModeCharacterWrap;
                                          
        self.trainTypeLab = [UISubLabel labelWithTitle:@"快速列车" frame:CGRectMake(ViewWidth-82, 50, 60, 20) font:FontSize26 color:FontColorFF8813 alignment:NSTextAlignmentCenter];
        
        [self addSubview:self.startView];
        [self addSubview:self.reachView];
        [self addSubview:self.startTimeLab];
        [self addSubview:self.reachTimeLab];
        [self addSubview:self.reachDayLab];
        [self addSubview:self.startStationLab];
        [self addSubview:self.reachStationLab];
        [self addSubview:self.spendTimeLab];
        [self addSubview:self.distanceLab];
        [self addSubview:self.trainView];
        [self addSubview:self.trainNameLab];
        [self addSubview:self.trainTypeLab];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end
