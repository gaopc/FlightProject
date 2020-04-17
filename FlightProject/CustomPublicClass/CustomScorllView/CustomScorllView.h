//
//  CustomScorllView.h
//  FlightProject
//
//  Created by longcd on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomTableViewDelegate;
@protocol CustomTableViewDataSource;

@interface CustomTableView : UIView <UIScrollViewDelegate> {
@private
    NSInteger rowsCount;
    float rowsHeight;
    UIScrollView * scrollV;
    UIView * centerView;
}
@property (nonatomic,retain) id <CustomTableViewDelegate> delegate;
@property (nonatomic,retain) id <CustomTableViewDataSource> dataSource;
@property (nonatomic,retain)NSArray * dataArray;
@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,retain) NSString * selectedStr;

-(void)heightForRow;
-(void)numberOfRows;
- (void)scrollToRow:(int)row;

@end

@protocol CustomTableViewDelegate <NSObject>
-(float)heightForRow:(CustomTableView *)tableView;
@optional
- (void)customTableView:(CustomTableView *)tableView didSelectIndex:(NSString *)indexStr;
@end

@protocol CustomTableViewDataSource <NSObject>
-(NSInteger)numberOfRows:(CustomTableView *)tableView;
- (NSString *)customTableView:(CustomTableView *)tableView titleForHeaderInRow:(NSInteger)row;
@end

@class CustomScorllView;

@protocol CustomScorllViewDelegate <NSObject>
@optional
-(void)sureButtonClick:(id) instance;
-(void)cancelButtonClick;
-(void)sureButtonClickWithIndex:(CustomScorllView*)sender;
@end

@interface CustomScorllView : UIView<CustomTableViewDelegate,CustomTableViewDataSource>
{
    CustomTableView *table;
}

@property(nonatomic,retain) NSArray * dataArray;
@property(nonatomic,assign) NSInteger  selectedRow;
@property (nonatomic,assign) id <CustomScorllViewDelegate> delegate;

-(UIView *)initWithLeftTitle:(NSString *) leftTitle subLeftTitle:(NSString *) subLeftTitle centerTitle:(NSString *)centerTitle subCenterTitles:(NSArray *)subCenterTitles rightTitle:(NSString *)rightTitle subRightTitle:(NSString *)subRightTitle frame:(CGRect)frame;
-(UIView *)initWithTitle:(NSString *) title  centerTitles:(NSArray *)centerTitles  frame:(CGRect)frame selectStr:(NSString *)str;
@end

















