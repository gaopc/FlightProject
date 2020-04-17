//
//  CarPayForSuccessViewController.h
//  FlightProject
//
//  Created by admin on 12-10-29.
//
//

#import <UIKit/UIKit.h>
#import "OrderPayForSuccessCell.h"
#import "TicketQueryViewController.h"
#import "RecommendClass.h"
#import "SubmitOrderCarInfo.h"
#import "ZhiYinCardViewController.h"
#import "AWActionSheet.h"
#import "TrainModel.h"

typedef enum{
    Ticket,
    Car,
    Hotel,
    Train,
} WhoPaySuccess;

@interface PayForSuccessViewController : RootViewController<UITableViewDelegate, UITableViewDataSource, AWActionSheetDelegate>
{
    UITableView *myTable;
    RecommendClass * recommend;
}
@property (nonatomic,retain) NSArray * _hotelList;
@property (nonatomic,retain) QueryFlightTicket  * _ticketList;
@property (nonatomic,retain) NSArray  * _carList;
@property (nonatomic,retain) NSArray  * _recommendfirstRow;
@property (nonatomic,retain) NSArray  * _recommendsecRow;
@property (nonatomic,retain) TicketQueryDataModel * _hotelQuery ;
@property (nonatomic,retain) TicketQueryDataModel * _ticketQuery;
@property (nonatomic,retain) SubmitOrderCarInfo * _carQuery;
@property (nonatomic,retain) id _firstInstance;
@property (nonatomic,retain) id _seconInstance;
@property (nonatomic,assign)  WhoPaySuccess _whoPaySuccess;
@property (nonatomic,retain) HotelQueryDataResponse * _hotelQueryDataResponse ;

@property (nonatomic,retain) NSString * _messageTitle;
@property (nonatomic,retain) NSString * _message;
@property (nonatomic,retain) NSString * _orderId;

@property (nonatomic, retain) NSString *_retainLcdNum;
@property (nonatomic, retain) NSString *_actitySecond;
@property (assign) BOOL _isActivity;

@property (assign) BOOL _CAFlight;
@property (nonatomic, retain) TrainOrderItem * _trainData;
@end
