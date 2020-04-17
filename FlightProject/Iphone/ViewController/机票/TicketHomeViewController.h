//
//  TicketHomeViewController.h
//  FlightProject
//
//  Created by longcd on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TicketQueryDataModel;

@protocol TicketHomeViewControllerDelegate;

@protocol TicketHomeViewControllerDelegate <NSObject>
@optional
-(void)changeModel:(UISegmentedControl *)sender;
-(void)reloadTableView;
@end

@protocol CustomTabbarViewDelegate <NSObject>
- (void)customTabbarViewDidSelectViewController:(UIViewController *)viewController;
@end

@interface CustomTabbarView : UIView
@property (nonatomic,retain) NSArray * viewControllers;
@property (nonatomic,retain) NSArray * defultImages;
@property (nonatomic,retain) NSArray * selectedImages;
@property (nonatomic,assign) id<CustomTabbarViewDelegate>tabbarDelegate;
-(void) changSelectedV:(NSInteger ) index;
@end

@interface TicketHomeViewController : RootViewController <CustomTabbarViewDelegate>
{
	//id <TicketHomeViewControllerDelegate> ticketDelegate;
    CustomTabbarView * tabbarV;
}
@property (nonatomic,retain) UIViewController * ticketDelegate;//<TicketHomeViewControllerDelegate>
@property (nonatomic,retain) UIView * activeView;
@property (nonatomic,retain) UIView * preView;
@property (nonatomic,retain) TicketQueryDataModel * ticketDataModel;
@end


