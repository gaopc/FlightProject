//
//  AirportKnowledgeRootViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetBasicInfoFromServer.h"
#import "CityListViewController.h"

@interface AirportData : NSObject
@property(nonatomic,retain)NSString *airportName;
@property(nonatomic,retain)NSString *airportCode;


+(AirportData*)AirportDataWithName:(NSString*)name CODE:(NSString*)code;

@end

@interface AirportKnowledgeRootViewController : RootViewController<CityListDelegate>
@property (nonatomic, retain) UISubLabel *airportNameLabel;
@property (nonatomic, retain) AirportData *airPortData;
@property (nonatomic, assign) BOOL enterAirlinesVC;
@property(nonatomic,assign)id delegate;
@property (nonatomic,retain) GetBasicInfoFromServer * server;

-(void)setMyCureentView:(UIView*)_view;
-(void)setNameLabelText:(AirportData*)data;

@end
