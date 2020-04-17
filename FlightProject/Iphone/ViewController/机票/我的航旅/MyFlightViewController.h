//
//  MyFlightViewController.h
//  FlightProject
//
//  Created by longcd on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFlightCell : UITableViewCell
@property (nonatomic,retain) UIImageView * imageV;
@property (nonatomic,retain) UILabel * titleLabel;
@property (nonatomic,retain) UILabel * detailLabel;
@end

@interface MyFlightViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , retain) NSArray * dataArray;
@end
