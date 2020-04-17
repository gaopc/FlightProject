//
//  RootViewController.h
//  FlightProject
//
//  Created by longcd on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/* 本类是所有试图控制器的基类，用于处理公共情况，例如navagation的样式，软件支持的硬件方向*/
#import <UIKit/UIKit.h>
#import "OrderPointView.h"
#import "SendRequstCatchQueue.h"
#import "GetBasicInfoFromServer.h"
#import "ActivityTimerView.h"


@interface RootViewController : UIViewController<CityListDelegate,UIActionSheetDelegate>

@property (nonatomic, retain) OrderPointView *_pointView;
@property (nonatomic, assign) UserType  _VCType;
@property (nonatomic, retain) UIView * _moveView;
-(BOOL)isLogin;
- (NSString*)theWeekOfToday:(NSString*)aDate;
- (NSString *) theStrOfToday;
-(void)goHome;
-(void) backHome;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  frame: (CGRect) frame;
- (void)callTel:(NSString *)telNum;
@end
