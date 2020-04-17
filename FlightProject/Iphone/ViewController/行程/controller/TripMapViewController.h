//
//  TripMapViewController.h
//  FlightProject
//
//  Created by gaopengcheng on 15-11-13.
//
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"

@interface TripMapViewController : RootViewController <MKMapViewDelegate>
{
    MKMapView * _mapView;
}
@property (nonatomic, retain) NSString *_Lat;
@property (nonatomic, retain) NSString *_lon;
@property (nonatomic, retain) NSString *_address;
@end
