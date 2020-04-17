//
//  DevicePositionMapViewController.h
//  FlightProject
//
//  Created by admin on 12-11-15.
//
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "CustomAnnotation.h"

#import "TSLocateView.h"
#import "DataClass.h"

#import "MapDataResponse.h"

@interface DevicePositionMapViewController : RootViewController<MKMapViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate>
{
    MKMapView * _mapView;
    TSLocateView *locateView;
    
    UIView *buttonView;
    UIButton *selectCityButton;
    UISubLabel *cityLab;
}
@property (nonatomic,retain) NSArray *_provinces;
@property (nonatomic,retain) NSArray *_terminalInfos;
@property (nonatomic,retain) TerminalCity * _selectCity;
@end
