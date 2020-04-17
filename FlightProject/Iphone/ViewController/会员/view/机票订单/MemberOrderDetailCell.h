//
//  MemberOrderDetailCell.h
//  FlightProject
//
//  Created by admin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUISwitch.h"
@interface MemberOrderDetailCell : UITableViewCell
@end

@interface MemberOrderPersonCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_personName;
@property (nonatomic, retain) UISubLabel *_personType;
@property (nonatomic, retain) UISubLabel *_cerType;
@property (nonatomic, retain) UISubLabel *_cerNum;
@property (nonatomic, retain) UISubLabel *_birthday;
@property (nonatomic, retain) UISubLabel *_ticketNum1;
@property (nonatomic, retain) UISubLabel *_ticketState1;
@property (nonatomic, retain) UISubLabel *_ticketNum2;
@property (nonatomic, retain) UISubLabel *_ticketState2;

@property (nonatomic, retain) UIButton *_returnTicket1;
@property (nonatomic, retain) UIButton *_returnTicket2;
@property (nonatomic, retain) UIButton *_phoneButton1;
@property (nonatomic, retain) UIButton *_phoneButton2;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type;
@end

@interface MemberOrderContactCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_contactNum;
@end

@interface MemberOrdercancelCell : UITableViewCell
@property (nonatomic, retain) UIButton *_allCancelButton;
@end

@interface MemberOrderModifyTelephoneCell : UITableViewCell
@property (nonatomic, retain) UISubTextField *_phoneNumTF;
@end

@interface MemberOrderModifyItineraryCell : UITableViewCell
@property (nonatomic, retain) UIImageView *_areaView;
@property (nonatomic, retain) UIButton *_leftButton1;
@property (nonatomic, retain) UIButton *_leftButton2;
@property (nonatomic, retain) UIButton *_terminalButton;
@property (nonatomic, retain) UIButton *_mailButton;
@property (nonatomic, retain) CustomUISwitch *_itinerarySwitch;
@property (nonatomic, retain) UISubLabel  *_mailAddressLabel;
@end

@interface MemberOrderModifyServiceCell : UITableViewCell
@property (nonatomic, retain) UISubLabel  *_serviceState;
@property (nonatomic, retain) UIButton *_moreButton;
@property (nonatomic, retain) CustomUISwitch *_serviceSwitch;
@end

@interface MemberOrderTicketInfoCell : UITableViewCell
@property (nonatomic, retain) UISubLabel  *_ticketNum;
@property (nonatomic, retain) UISubLabel  *_totailPrice;
@property (nonatomic, retain) UISubLabel  *_fee;
@property (nonatomic, retain) UISubLabel  *_returnPrice;
@end

@interface MemberOrderRulesInfoCell : UITableViewCell
@property (nonatomic, retain) UISubLabel       *_rulesContect;
@property (nonatomic, retain) UIImageView   *_boxView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withRule:(NSString *)rules;
@end

@interface MemberOrderReturnCell : UITableViewCell
@property (nonatomic, retain) UIButton *_normalReturn;
@property (nonatomic, retain) UIButton *_lcdReturn;
@end

@interface MemberOrderItineraryCell : UITableViewCell
@property (nonatomic, retain) UIImageView *_areaView;
@property (nonatomic, retain) UIImageView *_iconView;
@property (nonatomic, retain) UIButton *_mapButton;
@property (nonatomic, retain) UISubLabel  *_mailAddressLabel;
@property (nonatomic, retain) UISubLabel  *_stateInfoLabel;
@property (nonatomic, retain) UISubLabel  *_itineraryLabel;
@end