//
//  GetTexiShopCell.h
//  FlightProject
//
//  Created by longcd mac mini 04 on 12-10-22.
//
//

#import <UIKit/UIKit.h>

@interface CarShopTitleCell : UITableViewCell
@property (nonatomic,retain) UISubLabel * _shopTitle;
@property (nonatomic,retain) UIImageView * _imageV;
@end

@interface CarShopNameCell : UITableViewCell
@property (nonatomic,retain) UISubLabel * _shopName;
@property (nonatomic,retain) UISubLabel * _shopOpenTime;
@property (nonatomic,retain) UIImageView * _shopAddressImageV;
@property (nonatomic,retain) UIButton * _shopAddressButton;
@property (nonatomic,retain) UISubLabel * _shopAddressDetail;
@property (nonatomic,retain) UIImageView * _backgroundV;
@end