//
//  RoomIntroViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomIntroViewController : RootViewController <UITableViewDelegate,UITableViewDataSource>

{
	
	UISubLabel *name;
	
	
	UISubLabel *address;
	
	UISubLabel *featureInfo;
	
	UISubLabel *generalAmenities;
	
	
	float cellTotalHeight;
	

}


@property (nonatomic,retain) HotelInfo * hotelInfo;
@property (nonatomic,retain) UIView *roomIntroView;
@end
