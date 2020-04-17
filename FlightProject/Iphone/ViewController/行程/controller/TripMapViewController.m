//
//  TripMapViewController.m
//  FlightProject
//
//  Created by gaopengcheng on 15-11-13.
//
//

#import "TripMapViewController.h"
#import "CustomAnnotation.h"

@interface TripMapViewController ()

@end

@implementation TripMapViewController
@synthesize _Lat, _lon, _address;

- (void)dealloc
{
    self._lon = nil;
    self._Lat = nil;
    self._address = nil;
    [_mapView release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_mapView == nil) {
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight - 44)];
        _mapView.delegate = self;
    }
    [self.view addSubview:_mapView];
    
    [self addMapPoint];
}

- (void)addMapPoint
{
    CLLocationCoordinate2D centerOff;
    [_mapView removeAnnotations:_mapView.annotations];
    CustomAnnotation* item = [[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake([self._Lat doubleValue], [self._lon doubleValue])];
    item.title = self._address;
    [_mapView addAnnotation:item];
    [item release];
    
    
    centerOff = CLLocationCoordinate2DMake([self._Lat doubleValue], [self._lon doubleValue]);
//    centerOff = CLLocationCoordinate2DMake(39.90960456049752, 116.3972282409668);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.2, 0.2);
    MKCoordinateRegion regin = MKCoordinateRegionMake(centerOff, span);
    [_mapView setRegion:regin animated:YES];
}

#pragma mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSString *AnnotationViewID = annotation.title;
    MKAnnotationView *pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (pinView == nil) {
        pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotation.title] autorelease];
    }
    else {
        pinView.annotation = annotation;
    }
    pinView.canShowCallout  = TRUE;
    pinView.selected = YES;
    return pinView;
}
@end
