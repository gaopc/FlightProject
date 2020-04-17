//
//  TrainContactsTableViewCell.h
//  FlightProject
//
//  Created by gaopengcheng on 15-7-17.
//
//

#import <UIKit/UIKit.h>

@interface TrainContactsTableViewCell : UITableViewCell
@property (nonatomic,retain) UIButton * _addPickUpPerson;
@property (nonatomic,retain) UISubLabel * _labelDescription;
@end

@interface TrainContactsInfoCell : UITableViewCell

@property (nonatomic,retain) UISubLabel * _labelDescription;
@property (nonatomic,retain) UISubLabel * _passengerLabel;
@property (nonatomic,retain) UISubLabel * _passengerNumLabel;
@property (nonatomic,retain) UIImageView * _backGroundImageV;
@end
