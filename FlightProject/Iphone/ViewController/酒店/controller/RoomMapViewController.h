//
//  RoomMapViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "CustomAnnotation.h"

#import "HotelQueryDataResponse.h"
#import "DevicePositionMapViewController.h"

@interface RoomMapViewController :RootViewController <MKMapViewDelegate>
{
    MKMapView* _mapView;
}
@property(nonatomic, retain) NSArray *_mapInfoArray;
@end
