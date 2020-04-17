//
//  HotelSearchViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
@class HotelInquiryDataResponse;
@class HotelHomeViewController;
@interface HotelInquiryViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	
	UIView *filterBgView;
	UISubTextField *filterTextField;
	
	HotelInquiryDataResponse *hotelInquiryData;
	NSEnumerator * enumeratorKey;
	
@public	
	HotelHomeViewController *hotelHomeVC;
}

@property (nonatomic, retain) UITableView *h_tableView;

@property(nonatomic, retain) NSMutableArray *filterArray;
@property (nonatomic, retain) NSMutableDictionary *filterHoteDictionary;
@property (nonatomic, retain) NSMutableDictionary *hoteNameDictionary;

@property (nonatomic, retain) NSString *cityTitle;
@property (nonatomic, retain) HotelRequestPara *hotelRequestPara;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic,retain) NSArray *textFieldArray;
@end
