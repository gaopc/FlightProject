//
//  TicketOrderInfoView.h
//  FlightProject
//
//  Created by longcd on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketQueryViewController.h"
@interface FlightSingleInfo : UIView 
@property (nonatomic,retain) UISubLabel * _fromCity;
@property (nonatomic,retain) UISubLabel * _toCity;
@property (nonatomic,retain) UISubLabel * _fromTime;
@property (nonatomic,retain) UISubLabel * _toTime;
@property (nonatomic,retain) UISubLabel * _fromDate;
@property (nonatomic,retain) UIImageView * _companyImageV;
@property (nonatomic,retain) UISubLabel * _flightNo;
@property (nonatomic,retain) UISubLabel * _flightCabinName;
@property (nonatomic,retain) UIImageView * _flightTypeImage;
@end

@interface FlightHardInfo : UIView 
@property (nonatomic,retain) UISubLabel * _planType;
@property (nonatomic,retain) UISubLabel * _fromDate;
@property (nonatomic,retain) UIImageView * _companyImageV;
@property (nonatomic,retain) UISubLabel * _flightNo;
@property (nonatomic,retain) UISubLabel * _fromCity;
@property (nonatomic,retain) UISubLabel * _fromterminal;
@property (nonatomic,retain) UISubLabel * _fromTime;
@property (nonatomic,retain) UISubLabel * _toCity;
@property (nonatomic,retain) UISubLabel * _toterminal;
@property (nonatomic,retain) UISubLabel * _toTime;
@property (nonatomic,retain) UISubLabel * _ruleLabel;
@property (nonatomic,retain) UISubLabel * _flightCabinName;
@property (nonatomic,retain) UIImageView * _flightTypeImage;
@end

@interface TicketOrderInfoView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UIView * centerViewBottomView;
    UITableView * myTable;
    
    FlightSingleInfo * singleInfo ;    
    FlightHardInfo * hardInfo;
}
@property (nonatomic,retain) UIView * headerView;
@property (nonatomic,retain) UIView * centerView;
@property (nonatomic,assign) BOOL isExpend; 
@property (nonatomic,retain) NSArray * headerDataArray;

-(void) initHeaderView:( FlightSingleInfo *)withSingleInfo :(FlightHardInfo *) withHardInfo;
-(void) initCenterView;
@end
