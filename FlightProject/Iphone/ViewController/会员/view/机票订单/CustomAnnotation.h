//
//  CustomAnnotation.h
//  FlightProject
//
//  Created by admin on 12-11-15.
//
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface CustomAnnotation : NSObject <MKAnnotation>   
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic) int tag;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coords;
@end
