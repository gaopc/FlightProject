//
//  RoomMapViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoomMapViewController.h"

@interface RoomMapViewController ()

@end

@implementation RoomMapViewController
@synthesize _mapInfoArray;

- (void)dealloc
{
    self._mapInfoArray = nil;
    [_mapView release];
     _mapView.delegate = nil;
//    [_mapManager release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"酒店位置";
    
    // 设置mapView的Delegate
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight - 44 - 44)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    [self setAnnotation];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *AnnotationViewID = @"annotationViewID";
    MKAnnotationView *pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (pinView == nil) {
        pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotation.title] autorelease];
    }
    else {
        pinView.annotation = annotation;
    }
    pinView.selected = YES;
    pinView.canShowCallout  = TRUE;
    return pinView;
}

- (void)setAnnotation
{
    CLLocationCoordinate2D center;
    
    double subLongitude = 0;
    double subLatitude = 0;
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    for (int i = 0; i < self._mapInfoArray.count; i++) 
    {
        HotelInfo *hotelData = [self._mapInfoArray objectAtIndex:i];
        
        center.longitude = [hotelData._longitude doubleValue];
        center.latitude = [hotelData._latitude doubleValue]; 
        
        CustomAnnotation* item = [[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake([hotelData._latitude doubleValue], [hotelData._longitude doubleValue])];
	item.title = hotelData._hotelName;
	item.subtitle = hotelData._address;
        [_mapView addAnnotation:item];
        [item release];
        
        subLongitude += center.longitude;
        subLatitude += center.latitude;
    }
    
    CLLocationCoordinate2D centerOff = CLLocationCoordinate2DMake(subLatitude/self._mapInfoArray.count, subLongitude/self._mapInfoArray.count);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.2, 0.2);
    MKCoordinateRegion regin = MKCoordinateRegionMake(centerOff, span);
    [_mapView setRegion:[_mapView regionThatFits:regin] animated:YES];
}

@end
