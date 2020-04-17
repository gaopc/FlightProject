//
//  OrderTicketInfoCell.h
//  FlightProject
//
//  Created by 高鹏程 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTicketInfoCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *userName;
@property (nonatomic, retain) UISubLabel *ticketName;
@property (nonatomic, retain) UISubLabel *paperwork;
@property (nonatomic, retain) UISubLabel *paperworkNum;
@end

@interface OrderTicketClickCell : UITableViewCell
@property (nonatomic, retain) UIButton *moveButton;
@end

@interface OrderTicketPhoneCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *telNum;
@end

@interface OrderTicketAddresCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_ifPrint;
@property (nonatomic, retain) UISubLabel *ticketState;
@property (nonatomic, retain) UISubLabel *ticketType;
@property (nonatomic, retain) UISubLabel *ticketAddress;
@property (nonatomic, retain) UIButton *positionButton;
@property (nonatomic, retain) UIImageView *areaView;
@property (nonatomic, retain) UIImageView *addView;
@end

@interface OrderTicketServiceCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *serviceState;
@property (nonatomic, retain) UIButton *moreButton;
@end

@interface OrderTicketHeadCell : UITableViewCell
@end

@interface OrderTicketTitleCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *titleLab;
@property (nonatomic, retain) UISubLabel *contentLab;
@end

@interface OrderTicketTotalMoneyCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *priceLab;
@end

@interface OrderTicketWaitManCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_waiterName;
@property (nonatomic, retain) UISubLabel *_waiterPhone;
@end

@interface OrderTicketDoubleWaitManCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_waiterName;
@property (nonatomic, retain) UISubLabel *_waiterPhone;
@property (nonatomic, retain) UISubLabel *_waiterName1;
@property (nonatomic, retain) UISubLabel *_waiterPhone1;
@end