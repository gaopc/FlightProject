//
//  OrderPointView.h
//  FlightProject
//
//  Created by admin on 12-11-7.
//
//

#import <UIKit/UIKit.h>
#import "MyExtend.h"

@interface OrderPointView : UIView
@property (nonatomic, retain)  UISubLabel*_pointLab;
+(OrderPointView *)shardOrderPointView:( CGRect ) frame;
@end
