//
//  AirPortListViewController.h
//  FlightProject
//
//  Created by 月 小 on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirportKnowledgeRootViewController.h"
#import "KeyBoardTopBar.h"

@interface AirPortListViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView * myTable;
}
@property (nonatomic, retain) NSArray *alinesArray;
@property (nonatomic, retain) NSArray *cureentArray;
@property (nonatomic, retain) AirportData *airPortData;
@property (nonatomic, retain) KeyBoardTopBar *keyboardbar;

@end
