//
//  AdvertisementView.h
//  FlightProject
//
//  Created by gaopengcheng on 13-7-1.
//
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface AdvertisementView : UIView
@property (nonatomic, retain) NSString *_imgUrl;
@property (nonatomic, retain) AsyncImageView *imgView;
@end
