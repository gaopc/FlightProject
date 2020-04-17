//
//  WoyinPassagerListViewController.h
//  FlightProject
//
//  Created by gaopengcheng on 15-7-10.
//
//

#import "RootViewController.h"
#import "PassengersInfoCell.h"

@interface WoyinPassagerListViewController : RootViewController <UITableViewDataSource, UITableViewDelegate, PassengersInfoDelegate, UIAlertViewDelegate>
{
    UITableView *myTable;
    
    UIButton *passengerAddButton;           //添加乘客按钮
    UIButton *submitButton;                 //提交选中的列表数据
}
@property (nonatomic, retain) UILabel *_promptlable;                        //无列表信息，提示内容
@property (nonatomic, retain) NSMutableArray *_passengersInfoArray;         //盛放旅客数据
@property (nonatomic, retain) NSMutableDictionary *_stateDictionary;        //盛放列表是否选中
@property (nonatomic, retain) NSString *_actionState;                       //1、首次进入 2、添加 3、修改 4、删除
@property (nonatomic, retain) NSString *_viewType;                          //0、火车票旅客列表 1、个人中心旅客列表
@end
