//
//  FlightTrendsDetailViewController.h
//  FlightProject
//
//  Created by longcd on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataClass.h"
#import "GetFlightDynamicByFlightNo.h"
#import "AWActionSheet.h"
#import <Social/Social.h>
#import "WeiXinExport.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApiNewsObject>

@interface FlightDetailsCell : UITableViewCell
@property(nonatomic,retain)UISubLabel *flightNum;
@property(nonatomic,retain)UISubLabel *flightCompany;
@property(nonatomic,retain)UISubLabel *startCity;
@property(nonatomic,retain)UISubLabel *arrivalCity;
@property(nonatomic,retain)UISubLabel *flightdate;
@property(nonatomic,retain)UISubLabel *weekDay;
@property(nonatomic,retain)UIImageView *flightStatus;
@end

@interface DepartureAirportDetailsCell : UITableViewCell
@property(nonatomic,retain)UISubLabel *airPortName;
@property(nonatomic,retain)UISubLabel *planTime;
@property(nonatomic,retain)UISubLabel *forecastTime;
@property(nonatomic,retain)UISubLabel *actualTime;
@property(nonatomic,retain)UISubLabel *timeDifference;
@property(nonatomic,retain)UIImageView *timeDifferenceImageView;
@end

@interface ArrivalAirportDetailsCell : UITableViewCell
@property(nonatomic,retain)UISubLabel *airPortName;
@property(nonatomic,retain)UISubLabel *planTime;
@property(nonatomic,retain)UISubLabel *forecastTime;
@property(nonatomic,retain)UISubLabel *actualTime;
@property(nonatomic,retain)UISubLabel *timeDifference;
@property(nonatomic,retain)UIImageView *timeDifferenceImageView;
@end

@interface AgoFlightCell : UITableViewCell
@property(nonatomic,retain)UISubLabel *agoFlightDesc;
@end

@interface FlightTrendsDetailViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,AWActionSheetDelegate, UIAlertViewDelegate,TencentSessionDelegate>
{
    TencentOAuth *_oauth;
}
@property (nonatomic,retain) UIScrollView *pageScroll;
@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,retain) NSString *flightNum;
@property (nonatomic,retain) NSArray *cityArray;
@property (nonatomic,retain) GetFlightDynamicByFlightNo *flightDynamic;
@property (nonatomic,retain) NSDictionary * strImageDic;
@property (nonatomic,retain) UIButton *attentionBtn;
@property (nonatomic,assign) BOOL showTerminal;
@property (nonatomic, retain) UIImage *weixinImg;
@property (nonatomic,assign) NSInteger reload;//未登录时 点击“关注”登陆成功后，reload不为0 viewWillAppear方法执行刷新功能；否则不执行
@property (nonatomic, retain) NSString *shareData;//分享内容
@end
