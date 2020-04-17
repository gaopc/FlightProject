//
//  UIAlertSubView.h
//  AlertViewController
//
//  Created by 晓婷 张 on 12-10-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  270  210

#import <UIKit/UIKit.h>
#import "CustomScorllView.h"

@protocol UIAlertSubViewDelegate <NSObject>
-(void) sureButtonClick:(id ) instance;
-(void)cancelButtonClick;
@end

@interface UIAlertSubView : UIView<CustomScorllViewDelegate>
{
    UIActivityIndicatorView * activityIV;
    UIView * aView;
    UITableView * myTable;
    UIPickerView * myPickerView;

}
@property(nonatomic,assign) id <UIAlertSubViewDelegate> delegate;

-(id)initWithLeftTitle:(NSString *) leftTitle subLeftTitle:(NSString *) subLeftTitle centerTitle:(NSString *)centerTitle subCenterTitles:(NSArray *)subCenterTitles rightTitle:(NSString *)rightTitle subRightTitle:(NSString *)subRightTitle  frame:(CGRect)frame;
-(void)showWaitView;
-(void)hiddenWaitView;


@end



