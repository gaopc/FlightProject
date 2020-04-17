//
//  MemberCarCell.h
//  FlightProject
//
//  Created by admin on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberCarCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_orderNumber;
@property (nonatomic, retain) UISubLabel *_orderStatus;
@property (nonatomic, retain) UISubLabel *_orderType;
@property (nonatomic, retain) UISubLabel *_submitDate;
@property (nonatomic, retain) UISubLabel *_priceInfo;
@property (nonatomic, retain) UISubLabel *_lcdFee;
@property (nonatomic, retain) UISubLabel *_totalCarRentMoney;
@property (nonatomic,retain) UIView * _returnLcdView;
@end



@interface MemberCarInfoCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_peopleName;
@property (nonatomic, retain) UISubLabel *_cellNum;
@property (nonatomic, retain) UISubLabel *_telephone;
@property (nonatomic, retain) UISubLabel *_typeName;
@property (nonatomic, retain) UISubLabel *_typeDesc;
@property (nonatomic, retain) UISubLabel *_takeDate;
@property (nonatomic, retain) UISubLabel *_returnDate;
@property (nonatomic, retain) UISubLabel *_takeShop;
@property (nonatomic, retain) UISubLabel *_returnShop;
@property (nonatomic, retain) UISubLabel *_takeTime;
@property (nonatomic, retain) UISubLabel *_returnTime;
@end

@interface MemberCarInsuranceCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_insuranceAmount;
@end

@interface MemberCarServiceTitleCell : UITableViewCell
@property (nonatomic,retain) UISubLabel * _serviceLabel;
@end

@interface MemberCarServiceInfoCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_serviceType;
@property (nonatomic, retain) UISubLabel *_servicePrice;
@end


@interface MemberCarSubmitCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_priceInfo;
@property (nonatomic, retain) UISubLabel *_lcdFee;
@property (nonatomic, retain) UISubLabel *_totalCarRentMoney;
@property (nonatomic,retain) UIView * _memberLcdView;
@end


@interface MemberCarPackageInfoCell : UITableViewCell

@end