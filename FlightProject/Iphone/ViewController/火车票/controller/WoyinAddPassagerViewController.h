//
//  WoyinAddPassagerViewController.h
//  FlightProject
//
//  Created by 张晓婷 on 15-6-5.
//
//

#import <UIKit/UIKit.h>
#import "TrainModel.h"

@interface WoyinAddPassagerViewController : RootViewController <UIAlertViewDelegate>
@property (nonatomic, assign) BOOL _isEdit;
@property (nonatomic, retain) TrainPassagerInfo *_passagerData;
@property (nonatomic, assign) id _delegate;
@property (nonatomic, retain) NSString *_viewType;
@property(nonatomic,retain)TrainPassagerInfo * _childInfo;

@end
