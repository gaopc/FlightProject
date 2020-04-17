//
//  TripForTicketTableViewCell.h
//  FlightProject
//
//  Created by gaopengcheng on 15-11-9.
//
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface TripForTicketTableViewCell : UITableViewCell
@property (nonatomic, retain) UIImageView * _companyImageV;
@property (nonatomic, retain) UISubLabel * _flightNo;
@property (nonatomic, retain) UISubLabel * _startDate;

@property (nonatomic, retain) AsyncImageView* _fromWearther;
@property (nonatomic, retain) AsyncImageView * _toWearther;
@property (nonatomic, retain) UISubLabel * _fromCity;
@property (nonatomic, retain) UISubLabel * _toCity;
@property (nonatomic, retain) UISubLabel * _startTime;
@property (nonatomic, retain) UISubLabel * _arrivlTime;
@property (nonatomic, retain) UISubLabel * _fromAirport;
@property (nonatomic, retain) UISubLabel * _toAirport;
@property (nonatomic, retain) UISubLabel * _planType;
@property (nonatomic, retain) UILabel * _cabinType;
@end

@interface TripForHotelTableViewCell : UITableViewCell
@property (nonatomic, retain) UILabel *_hotelNameLab;
@property (nonatomic, retain) UILabel *_roomTypeLab;
@property (nonatomic, retain) UILabel *_hotelAddressLab;
@property (nonatomic, retain) UILabel *_checkInDateLab;
@property (nonatomic, retain) UILabel *_checkOutDateLab;
@property (nonatomic, retain) UILabel *_peopleNameLab;
@end
