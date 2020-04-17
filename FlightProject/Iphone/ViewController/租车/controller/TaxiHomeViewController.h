//
//  TaxiHomeViewController.h
//  FlightProject
//
//  Created by longcd on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaxiDatePickerViewController.h"
#import "QueryCarStore.h"
#import "GetBasicInfoFromServer.h"
#import "CustomUISwitch.h"
@interface TaxiHomeDataModelElem : NSObject
@property (nonatomic,retain) NSString * _nameStr;
@property (nonatomic,retain) NSString * _nameCode;
+(TaxiHomeDataModelElem *)TaxiHomeDataModelElemWithStr:(NSString *)str  code:(NSString *)code;
@end
@interface TaxiHomeDataModel  : NSObject
@property (nonatomic,retain) TaxiHomeDataModelElem * _startDate;
@property (nonatomic,retain) TaxiHomeDataModelElem * _endData;
@property (nonatomic,retain) TaxiHomeDataModelElem * _takeCity;
@property (nonatomic,retain) TaxiHomeDataModelElem * _sendCity;
@property (nonatomic,retain) Shops * _takeDoor;
@property (nonatomic,retain) Shops * _sendDoor;
@end

@interface TaxiHomeViewController : RootViewController

<UITableViewDataSource,UITableViewDelegate, CityListDelegate,CustomUISwitchDelegate>
{
    BOOL isSameDoor;    
    UITableView * myTable;
    
}
@property (nonatomic,retain) NSMutableArray *dataSourceArray;
@property (nonatomic,retain) NSArray * allKeys;
@property (nonatomic,retain) NSArray * imageVArray;
@property (nonatomic,retain) TaxiHomeDataModel * carDataModel;
@property (nonatomic, retain) NSString *buttonSelect;
@property (nonatomic, retain) GetBasicInfoFromServer *server;
@property (nonatomic,retain) UISubLabel * alertLabel;
@property (nonatomic,retain) SubmitOrderCarInfo * queryDataModel;
@property (nonatomic,retain) id currentDataModelElem;
@end
