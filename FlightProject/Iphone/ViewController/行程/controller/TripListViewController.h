//
//  TripListViewController.h
//  FlightProject
//
//  Created by gaopengcheng on 15-11-5.
//
//

#import "RootViewController.h"

@interface TripListViewController : RootViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *myTable;
    UILabel *showLab;
}
@property (nonatomic, retain) NSMutableArray *_ticketArr;
@property (nonatomic, retain) NSMutableArray *_hotelArr;
@property (nonatomic, retain) NSString *_flightNum;
@end
