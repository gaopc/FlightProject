//
//  AboutUsViewController.h
//  FlightProject
//
//  Created by green kevin on 12-10-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "VersionView.h"
#import "RecommendSoftDataResponse.h"
#import "WeiXinExport.h"
#import "WeiboSDK.h"
#import <Social/Social.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "AWActionSheet.h"

@class ValidateVersionResponse;
@interface AboutUsViewController :  RootViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,UITextViewDelegate,MFMessageComposeViewControllerDelegate,TencentSessionDelegate,AWActionSheetDelegate>
{
	UISubLabel *version;
	UIView *aboutBgView;
	UIActionSheet *actionSheet;
	UISubTextView *explainTextView;
	TencentOAuth *_oauth;

	
}

@property (nonatomic,retain) UITableView *a_tableView; 
@property (nonatomic,assign) int isShowNewIcon; 
@property (nonatomic,retain) NSString *versionMessage;

@end
