//
//  AirlineViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AirlineCell : UITableViewCell
@property(nonatomic,retain)UIImageView *iconImageView;
@property(nonatomic,retain)UIImageView *dottedLine;
@property(nonatomic,retain)UISubLabel *name;
@property(nonatomic,retain)UISubLabel *tel;
@property(nonatomic,retain)UIButton *callPhone;
@property(nonatomic,assign)id delegate;
@end
//机场宝典中不加春秋航空
@interface AirlineViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property(nonatomic,retain)NSArray *alinesArray;

-(void)gettFlightCompanys;
- (NSString*)infoWithIndex:(int)index;
@end
