//
//  HomePageAnimateView.h
//  FlightProject
//
//  Created by longcd on 12-9-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface HomePageAnimateView : UIView
{
    int groupIndex;
    int memberIndex;
}
@property (nonatomic,retain)NSArray * animateImageArray;
@end
