//
//  CarPassengerCell.h
//  FlightProject
//
//  Created by gaopengcheng on 13-5-3.
//
//

#import <UIKit/UIKit.h>

@interface CarPassengerCell : UITableViewCell
@property (nonatomic, retain) UISubLabel *_name;
@property (nonatomic, retain) UISubLabel *_cerNum;
@property (nonatomic, retain) UIImageView *_selectImg;
@property (nonatomic, retain) UIImageView *_unSelectImg;
@property (nonatomic, retain) UIButton *_selectName;
@end
