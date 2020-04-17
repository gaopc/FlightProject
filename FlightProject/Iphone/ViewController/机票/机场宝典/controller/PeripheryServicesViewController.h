//
//  PeripheryServicesViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirportKnowledgeRootViewController.h"
#import "QueryFacilityService.h"

@interface ServiceCell : UITableViewCell
@property(nonatomic, retain)UISubLabel  *leftLabel;
@property(nonatomic, retain)UISubLabel  *rightLabel;
@property(nonatomic, retain)UIButton *leftButton;
@property(nonatomic, retain)UIButton *rightButton;
@end

@interface PeripheryServicesViewController : AirportKnowledgeRootViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)AirportData *data;
@property(nonatomic,retain)QueryFacilityService *queryFacilityService;
@property(nonatomic,retain)UITableView *myTable;
@end
