//
//  TaxiTakeCarShopViewController.h
//  FlightProject
//
//  Created by longcd mac mini 04 on 12-10-22.
//
//

#import <Foundation/Foundation.h>
#import "RootViewController.h"
#import "QueryCarStore.h"
#import "TicketHomeViewController.h"
#import "TaxiHomeViewController.h"

#define ButtonSection 100

@protocol TaxiTakeCarShopViewControllerDelegate <NSObject>

-(void) didSelectedStoreFinshed:(id)object;

@end

@interface TaxiTakeCarShopViewController :RootViewController
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    
    BOOL isExtendSectionTitle;
    BOOL isExtendAddress;
    
    NSInteger selectSection;
}

@property (nonatomic,retain) NSArray *carStoreArray;
@property (nonatomic,assign) id delegate;
@property (nonatomic,retain) NSIndexPath * selectAddressIndexPath;
@end
