//
//  SendRequst.h
//  FlightProject
//
//  Created by longcd on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/* 本类用于向服务器发送请求 */
#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MyExtend.h"

#define ShowNetErrorMessage 0

@protocol SendRequstDelegate;

@interface SendRequst : NSObject <NSXMLParserDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,ASIHTTPRequestDelegate>


@property (nonatomic,assign) id <SendRequstDelegate> delegate;
@property (nonatomic,assign) id delegateVC;
@property (nonatomic,assign) SEL delegateSelector;

@property (nonatomic,retain) NSString *  currentViewController;

@property (nonatomic,retain) ASIFormDataRequest * myRequest;

-(void)sendRequstAsiFormHttp:(ASIFormDataRequest *)theRequest;
-(void)sendRequstAsiFormHttps:(ASIFormDataRequest *)theRequest;

@end

@protocol SendRequstDelegate <NSObject>
//-(void)requestResultStr:(NSString *) resultStr Dic:(NSDictionary *)resultDic ;
-(void)requestResult:(SendRequst *)sendR;

@end