//
//  FirstInAlertViewController.h
//  FlightProject
//
//  Created by green kevin on 12-9-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETFirstInAlertItem.h"
#import "ETFirstAlertDelegate.h"
@interface FirstInAlertViewController : UIViewController<UIScrollViewDelegate> 
{
	UIScrollView* _scrollView;
	NSArray* _itemsPageArray;
	ETFirstInAlertItem* item;
}
+ (BOOL) isFirstShow;

- (id) initWithItem:(ETFirstInAlertItem*) item;
- (id) initWithArray:(NSArray*) itemArray;

@property (nonatomic, assign ) id<ETFirstAlertDelegate> delegate;

@property (nonatomic, retain) NSArray* itemsPageArray;
@property (nonatomic, retain) UIScrollView* scrollView;


@end
