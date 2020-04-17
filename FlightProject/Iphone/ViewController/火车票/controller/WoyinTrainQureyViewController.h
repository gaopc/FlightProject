//
//  WoyinTrainQureyViewController.h
//  FlightProject
//
//  Created by 张晓婷 on 15-6-4.
//
//

#import <UIKit/UIKit.h>
#import "CityListViewController.h"
#import "DatePickerViewController.h"
#import "TicketQueryViewController.h"
#import "TrainModel.h"
#import "WoyinTrainListViewController.h"
@interface WoyinTrainQureyViewController : RootViewController
@property(nonatomic,retain) NSArray *stationsHistory;
@property (assign) BOOL _isReturn;       //支付完成 返程更换往返城市
@end
