//
//  TrainListViewCell.h
//  FlightProject
//
//  Created by admin on 13-1-6.
//
//

#import <UIKit/UIKit.h>

@interface TrainListViewCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *startTimeLab;
@property (nonatomic, retain) UISubLabel *reachTimeLab;
@property (nonatomic, retain) UISubLabel *startStationLab;
@property (nonatomic, retain) UISubLabel *reachStationLab;
@property (nonatomic, retain) UISubLabel *spendTimeLab;
@property (nonatomic, retain) UISubLabel *distanceLab;
@property (nonatomic, retain) UISubLabel *trainNameLab;
@property (nonatomic, retain) UISubLabel *trainTypeLab;
@property (nonatomic, retain) UISubLabel *reachDayLab;

@property (nonatomic, retain) UIImageView *startView;
@property (nonatomic, retain) UIImageView *reachView;
@property (nonatomic, retain) UIImageView *trainView;
@end
