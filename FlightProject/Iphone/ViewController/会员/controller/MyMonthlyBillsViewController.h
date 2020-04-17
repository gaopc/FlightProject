//
//  MyMonthlyBillsViewController.h
//  FlightProject
//
//  Created by xiemengyue on 13-5-2.
//
//

#import <UIKit/UIKit.h>
@class MyMonthlyBills;
@interface MyMonthlyBillsViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    int selectSection;
    BOOL zhankai;
}
@property(nonatomic,retain)MyMonthlyBills *monthlyBills;
@end

@interface MonthBillTitleCell : UITableViewCell
@property(nonatomic,retain)UIButton *menuButton;
@property(nonatomic,retain)UILabel *monthLabel;
@property(nonatomic,retain)UILabel *amountLabel;
@property(nonatomic,retain)UILabel *lcdCoinLabel;
@property(nonatomic,retain)UILabel *cangLabel;
@end

@interface MonthBillDetailCell : UITableViewCell
@property(nonatomic,retain)UILabel *flightLabel;
@property(nonatomic,retain)UILabel *hotelLabel;
@property(nonatomic,retain)UILabel *carLabel;
@end
