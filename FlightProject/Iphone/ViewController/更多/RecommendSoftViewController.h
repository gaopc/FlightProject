//
//  RecommendSoftViewController.h
//  FlightProject
//
//  Created by gaopengcheng on 13-6-28.
//
//

#import <UIKit/UIKit.h>
#import "RecommendSoftDataResponse.h"
#import "AsyncImageView.h"

@interface RecommendSoftViewController : RootViewController <UITableViewDataSource ,UITableViewDelegate>
{
    UITableView *myTable;
}
@property (nonatomic, retain) NSArray *_listArray;
@end


@interface RecommendSoftView : UITableViewCell
@property (nonatomic, retain) UISubLabel *_softTitle;
@property (nonatomic, retain) UISubLabel *_softContent;
@property (nonatomic, retain) AsyncImageView *_iconView;
@property (nonatomic, retain) UIImageView *_cellImgView;
@end