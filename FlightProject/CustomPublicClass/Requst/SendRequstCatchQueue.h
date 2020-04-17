//
//  SendRequstCatchQueue.h
//  FlightProject
//
//  Created by longcd on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/* 本类用于生成请求队列 */
#import <UIKit/UIKit.h>
#import "SendRequst.h"
#import "WaitView.h"
#import "MyExtend.h"
#import "GetBasicInfoFromServer.h"

typedef enum {
    Default,
    Member,
    NoMember,
    DidNoMember,
} UserType;

@interface SendRequstCatchQueue : NSObject<SendRequstDelegate,WaitViewDelegate>

@property (nonatomic,retain) NSMutableArray * catchArray;
@property (nonatomic,retain) NSString *  currentViewController;
@property (nonatomic,retain) GetBasicInfoFromServer *basicInfo;
@property (nonatomic,retain) NSMutableArray * endOption;

+(SendRequstCatchQueue *)shareSendRequstCatchQueue;
// 三期
-(void)sendRequstCatchQueue:(ASIFormDataRequest *)theRequest Selector:(SEL)aselector Delegate :(id)adelegate needUserType:(UserType)needUserType;

@end
