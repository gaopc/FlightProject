//
//  FlightTrendsViewController.h
//  FlightProject
//
//  Created by longcd on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityListViewController.h"
#import "Citys.h"

#import "InterfaceClass.h"
#import "SendRequstCatchQueue.h"
#import "FlightTrendsListViewController.h"
#import "GetMyAttentionList.h"
#import "KeyBoardTopBar.h"
#import "GetBasicInfoFromServer.h"

@interface TitleView : UITableViewCell
@property(nonatomic, retain)UIImageView *titleBackGround;
@property(nonatomic, retain)UIButton *numbutton;
@property(nonatomic, retain)UIButton *citysButton;
@property(nonatomic, retain)UIButton *myAttentionButton;
@property(nonatomic, assign)id delegate;
@end

@interface NumSearchTextField : UITableViewCell
@property(nonatomic, retain)UIImageView *butImageView;
@property(nonatomic, retain)UIImageView *imageView;
@property(nonatomic, retain)UIImageView *flightIcon;
@property(nonatomic, retain)UIButton *selectAirline;
@property(nonatomic, retain)UISubTextField * numTextField;
@property(nonatomic, assign)id delegate;
@end

@interface CitySearchButtons : UITableViewCell
@property(nonatomic, retain)UIButton *startCity;
@property(nonatomic, retain)UIButton *arrCity;
@property(nonatomic, retain)Citys *myStartCity;
@property(nonatomic, retain)Citys *myEndCity;
@property(nonatomic, assign)id delegate;
@end

@interface NumSearchHistory : UITableViewCell
@property(nonatomic, retain) UISubLabel *leftNumber;
@property(nonatomic, retain) UISubLabel *rightNumber;
@property(nonatomic, retain) UISubLabel *leftCitys;
@property(nonatomic, retain) UISubLabel *rightCitys;
@property(nonatomic, retain) UIButton *lefttHistory;
@property(nonatomic, retain) UIButton *rightHistory;
@property(nonatomic, assign) id delegate;
@end

@interface CitySearchHistory : UITableViewCell
@property(nonatomic, retain) UIButton *leftButton;
@property(nonatomic, retain) UIButton *rightButton;
@property(nonatomic, retain) NSString *leftCode;
@property(nonatomic, retain) NSString *rightCode;
@property(nonatomic, assign) id delegate;
@end

@interface MyAttentionCell : UITableViewCell
@property(nonatomic, retain) NSString *ids;
@property(nonatomic, retain) UIImageView *flightIcon;
@property(nonatomic, retain) UISubLabel *flightCompany;
@property(nonatomic, retain) UISubLabel *flightStartCity;
@property(nonatomic, retain) UISubLabel *flightArrivalCity;
@property(nonatomic, retain) UIImageView *dottedLine;
@property(nonatomic, retain) UIImageView *backGroundImageView;
@property(nonatomic, retain) UIImageView *arrowImageView;
@property(nonatomic, retain) UIImageView *subordinateImageView;
@end

@interface SelectAlineCell : UITableViewCell
@property(nonatomic, retain)UIImageView *rightImage;
@property(nonatomic, retain)UIImageView *leftIcon;
@property(nonatomic, retain)UIImageView *rightIcon;
@property(nonatomic, retain)UIButton *leftButton;
@property(nonatomic, retain)UIButton *rightButton;
@property(nonatomic, assign)id delegate;
@end

@interface FlightTrendsViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CityListDelegate>
{
    NSString *numFlight;//选择查询的航班号
    NSString *flightCompany;//选择的航空公司三字码
    NSMutableArray *selectCitysArray;//选择查询的起降地数组（0:起飞地  1:降落地）
    UITableView *myTableView;
    NSInteger currentViewTag;
    UITableView *selectAlineTableView;
    BOOL showSATableView;//航空公司选择列表此时显示否
    UISubTextField *currentTextField;
    GetMyAttentionList *getMyAttentionList;
    NSMutableArray *numberHistory;//航班号查询历史展示数据 数组
    NSMutableArray *citysHistory;//起降地查询历史展示数据 数组
    NSArray *flightCompanys;//航空公司三子码、名称存储至数组
    
    KeyBoardTopBar *keyboardbar;
    BOOL enterCityList;
    
    Citys * currentCity; // zxt 20121027 add
    
    UIButton *mySelectAirline;
    Citys *myStartCity;//记录当前显示在页面的出发地
    Citys *myEndCity;//记录当前显示在页面的到达地
    int deleteNUm;//关注列表滑动删除的是数组中第几条
    
    NSInteger flightsType;//0 ,国内航空；1,国际航空
}
@property (nonatomic,retain) NSString *numFlight;
@property (nonatomic,retain) NSString *flightCompany;
@property (nonatomic,retain) NSMutableArray *selectCitysArray;
@property (nonatomic,retain) UITableView *myTableView;
@property (nonatomic,retain) UITableView *selectAlineTableView;
@property (nonatomic,retain) UIImageView *selectAlineBackGround;
@property (nonatomic,retain) UISubTextField *currentTextField;
@property (nonatomic,retain) GetMyAttentionList *getMyAttentionList;
@property (nonatomic,retain) NSMutableArray *numberHistory;
@property (nonatomic,retain) NSMutableArray *citysHistory;
@property (nonatomic,retain) NSArray *flightCompanys;
@property (nonatomic,assign) BOOL showSATableView;
@property (nonatomic,assign) BOOL enterCityList;
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic, retain) NSString *buttonSelect;
@property (nonatomic, retain) GetBasicInfoFromServer *server;
@property (nonatomic, assign) BOOL isGetMyAttention;//防止，登陆后请求完，返回页面又一次请求

@property (nonatomic, retain) UIButton *domesticAirBtn;
@property (nonatomic, retain) UIButton *internationalAirBtn;

-(void)changeCuurentView:(UIButton*)sender;
-(void)showSelectAlineView:(UIButton*)sender;
-(void)selectAline:(NSString*)selectAline;
-(void)selectCity:(UIButton *) sender;
-(void)switchCitys:(UIButton*)sender;
-(void)flightSearch:(NSString*)sender;

-(void)onNumPaseredResult:(NSDictionary *)dic;
-(void)onCityPaseredResult:(NSDictionary *)dic;
@end
