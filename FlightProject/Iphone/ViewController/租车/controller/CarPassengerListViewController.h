//
//  CarPassengerListViewController.h
//  FlightProject
//
//  Created by gaopengcheng on 13-5-3.
//
//

#import <UIKit/UIKit.h>
#import "CarPassengerCell.h"
#import "CarPassengerViewController.h"
#import "ASIFormDataRequest.h"
#import "CarPassengersResponse.h"

@interface CarPassengerListViewController : RootViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *myTale;
    UISubLabel *mylable;
    UIButton *addPassenger;
    UIButton *submitButton;
}

@property (nonatomic,retain) SubmitOrderCarInfo * queryDataModel;
@property (nonatomic,retain) CarModelDetail * selectedCarDetail;
@property (nonatomic, retain) NSMutableArray *data;
@property (assign) BOOL isEmpty;
@property (assign) int selectRow;
@property (nonatomic, retain) NSString *gateway;
@end
