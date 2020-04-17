//
//  TrainQureyViewController.h
//  FlightProject
//
//  Created by 小月 on 13-1-6.
//
//

#import <UIKit/UIKit.h>
#import "GetBasicInfoFromServer.h"
#import "KeyBoardTopBar.h"
#import "TrainListInfo.h"

@interface TrainQureyViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CityListDelegate>

@property(nonatomic,retain) UITableView *myTable;
@property(nonatomic,retain) NSArray *stationsHistory;
@property(nonatomic,retain) NSArray *trainNumHistory;
@property(nonatomic,assign) NSInteger currentViewTag;
@property(nonatomic,retain) NSString *startStation;
@property(nonatomic,retain) NSString *endStation;
@property(nonatomic,retain) NSString *trainNumber;
@property(nonatomic,retain) NSString *searchType;
@property(nonatomic,retain) GetBasicInfoFromServer *server;
@property(nonatomic,retain) NSString *buttonSelect;
@property(nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property(nonatomic,retain) NSArray *textFieldArray;
@property(nonatomic,retain) TrainListInfo * trainListInfo;//按车次查询 若只有一条记录，存储该车次信息
@property(nonatomic,retain) UISubTextField *myTextField;
@property(nonatomic,retain) UIButton *startStationBtn;
@property(nonatomic,retain) UIButton *endStationBtn;
@end
