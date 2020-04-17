//
//  TrainContactsViewController.h
//  FlightProject
//
//  Created by gaopengcheng on 15-7-17.
//
//

#import <UIKit/UIKit.h>
#import "PassengerInfoDataResponse.h"
#import "PassengersInfoCell.h"

@interface TrainContactsViewController : RootViewController <UITableViewDataSource, UITableViewDelegate, PassengersInfoDelegate>
{
    UIButton *passengerAddButton;
    UIButton *submitButton;
    UITableView *myTable;
    
    int maximum;
    int counts;
    
    BOOL isRefresh;
}
@property (assign) id _delegate;
@property (nonatomic, retain) PickPersonInfoItem *_personData;
@property (nonatomic, retain) UILabel *_promptlable;
@property (nonatomic, retain) UILabel *_cPersonLabel;
@property (nonatomic, retain) NSMutableArray *_passengersInfoArray;
@end
