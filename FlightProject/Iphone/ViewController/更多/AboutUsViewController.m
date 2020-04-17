//
//  AboutUsViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AboutUsViewController.h"
#import "ServiceTermViewController.h"
#import "ValidateVersionResponse.h"
#import "RecommendSoftViewController.h"
#import "ShareToSinaViewController.h"
#import "AWActionSheet.h"

@interface  AboutUsCellForFirstSection: UITableViewCell

@property (nonatomic,retain) UISubLabel *version;
@property (nonatomic,retain) UIView *aboutBgView;

@end

@interface  AboutUsCellForSecondSection: UITableViewCell
@property (nonatomic,retain) UIView *aboutBgView;
@property (nonatomic,retain) UISubTextView *explainTextView;

@end


@implementation AboutUsCellForFirstSection
@synthesize version,aboutBgView;
-(void)dealloc
{
	self.version = nil;
	self.aboutBgView = nil;
    
	[super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 10.0f, ViewWidth-20, 7.0f)] ;
		[topView setImage:[UIImage imageNamed:@"MemberLoginTop.png"]];
		[self addSubview:topView];
		
		aboutBgView = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 12.0f, ViewWidth-20,100.0f)];
		self.aboutBgView.backgroundColor = [UIColor clearColor];
		
		UIImageView *aboutOurBg = [UIImageView ImageViewWithFrame:CGRectMake(28.0f, 5.0f, 224.0f, 85.0f)] ;
		[aboutOurBg setImage:[UIImage imageNamed:@"AboutOurTopBg.png"]];
		[self.aboutBgView addSubview:aboutOurBg];
		
		UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 10.0f, 300.0f, aboutBgView.frame.size.height)];
		[centerView setImage:[UIImage imageNamed:@"MemberLoginCenter.png"]];
		[self addSubview:centerView];
		[self addSubview:self.aboutBgView];
		
		
		UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, centerView.frame.size.height+10.0f, 300.0f, 7.0f)];
		[bottom setImage:[UIImage imageNamed:@"MemberLoginBottom.png"]];
		[self addSubview:bottom];
		
		self.version = [UISubLabel labelWithTitle:[NSString stringWithFormat:@"%@",MyVersion] frame:CGRectMake(175.0f, 77.0f, 70.0f, 20.0f) font:FontBlodSize26 alignment:NSTextAlignmentCenter];
		self.version.backgroundColor = [UIColor clearColor];
		self.version.textColor = FontColor1F7EBF;
		[self addSubview:version];
		
	}
	self.accessoryType = UITableViewCellAccessoryNone;
	self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];

	return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

@end

@implementation AboutUsCellForSecondSection
@synthesize explainTextView,aboutBgView;
-(void)dealloc
{
	self.explainTextView = nil;
	self.aboutBgView = nil;
	[super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		
		UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 10.0f, ViewWidth-20, 7.0f)] ;
		[topView setImage:[UIImage imageNamed:@"MemberLoginTop.png"]];
		[self addSubview:topView];
		
		aboutBgView = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 10.0f, ViewWidth-20,246.0f)];
		self.aboutBgView.backgroundColor = [UIColor clearColor];
		
		
		//说明
		UISubTextView *_explainTextView = [[UISubTextView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, ViewWidth-30, aboutBgView.frame.size.height)];
		_explainTextView.font = FontSize28;
		_explainTextView.text = @"        “掌上航旅”是畅e航旅品牌旗下、由北京隆畅达科技有限公司研发的一款移动旅行应用软件。丰富的旅行产品、良好的用户体验、人性化的功能设置，可为您提供全自助、全流程、全线上的机票、酒店、火车票、租车及打车产品查询、预订和交易服务。软件广泛适用于采用IOS系统的手机和平板电脑，操作简单便捷，同时具有实时退票、最低票价推送、特价机票预约、补打行程单等优势服务。\n        掌上航旅，轻松点触，随时随地获取机票、航班动态及机场周边信息，您旅途中最贴心的伴侣。";
		_explainTextView.editable = FALSE;
		_explainTextView.userInteractionEnabled = NO;
		_explainTextView.backgroundColor = [UIColor clearColor];
		[self.aboutBgView addSubview:_explainTextView];
		self.explainTextView = _explainTextView;
		[_explainTextView release];
		
		
		UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 10.0f, ViewWidth-20, aboutBgView.frame.size.height)];
		[centerView setImage:[UIImage imageNamed:@"MemberLoginCenter.png"]];
		[self addSubview:centerView];
		[self addSubview:self.aboutBgView];
		
		
		
		UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, centerView.frame.size.height+10.0f, ViewWidth-20, 7.0f)];
		[bottom setImage:[UIImage imageNamed:@"MemberLoginBottom.png"]];
		[self addSubview:bottom];
		
	}
	self.accessoryType = UITableViewCellAccessoryNone;
	self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];

	return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

@end


@interface AboutUsViewController ()
//评分
//-(void)toGrade;
//服务协议
-(void)loadWebApp;
//短信提醒
-(void)toSendSMG;
//发送邮件
-(void)launchMailApp;
-(void)sendSMS;
@end

@implementation AboutUsViewController
@synthesize a_tableView,isShowNewIcon,versionMessage;

#pragma mark -
#pragma mark View系统方法

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	[super loadView];
	
	if ([[GetConfiguration shareGetConfiguration]._version._code intValue] > MyVersionCode)
	self.isShowNewIcon = 1;
	

	
	self.a_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,5.0f,ViewWidth,ViewHeight-63.0f) style:UITableViewStylePlain];  
	self.a_tableView.backgroundColor = [UIColor clearColor];
	self.a_tableView.dataSource = self;
	self.a_tableView.delegate = self;
	self.a_tableView.separatorColor = [UIColor clearColor];
	[self.view addSubview:self.a_tableView];
	
}

- (void) dealloc {
	
	self.a_tableView = nil;
	self.versionMessage = nil;
    
     _oauth = nil;
	[super dealloc];
	
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"关于我们";
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}



- (void)loadValidateVersion
{
	ASIFormDataRequest * theRequest = [InterfaceClass validateVersion:@"2" versionCode:[NSString stringWithFormat:@"%d",MyVersionCode]];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onValidateVersionResult:) Delegate:self needUserType:Default];
	
}

//获取验证码请求返回处理
- (void)onValidateVersionResult:(NSDictionary *)dic
{
	if ([[[ValidateVersionResponse getValidateVersion:dic] objectAtIndex:0] intValue]==0){
		self.isShowNewIcon = 1;
		self.versionMessage = [[ValidateVersionResponse getValidateVersion:dic] objectAtIndex:1];
	}else{
		self.isShowNewIcon = 0;
	}
	
	[self.a_tableView reloadData];
	[self checkerVersion];
	

}

-(void) checkerVersion
{
	if (self.isShowNewIcon==0){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没有检测到新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}else {
	[VersionView shareVersionView].versionView.text=self.versionMessage;
        [[VersionView shareVersionView] showVersionView];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
	// Return the number of sections.
	return 1;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
	return NO;
} 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
	// Return the number of rows in the section.
	return 10;
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{		
	if (indexPath.row==0) {
		return 120.0f;
	}else if(indexPath.row ==9){
		return 270.0f;
	}else {
		return 45.0f;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (indexPath.row == 0) {
		static NSString * firstidentifier = @"firstidentifier";
		AboutUsCellForFirstSection * cell = [tableView dequeueReusableCellWithIdentifier:firstidentifier];
		if (cell == nil) {
			cell = [[[AboutUsCellForFirstSection alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstidentifier] autorelease];
			cell.backgroundColor = [UIColor clearColor];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
		}
		return cell ;
		
	}else if (indexPath.row == 9) {
		static NSString * secondidentifier = @"secondidentifier";
		AboutUsCellForSecondSection * cell = [tableView dequeueReusableCellWithIdentifier:secondidentifier];
		if (cell == nil) {
			cell = [[[AboutUsCellForSecondSection alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondidentifier] autorelease];
			cell.backgroundColor = [UIColor clearColor];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
		}
		return cell ;
		
	}else {
		
		static NSString * otheridentifier = @"otheridentifier";
		UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:otheridentifier];
		UISubLabel *titleLabel1 = nil;
		UISubLabel *titleLabel2 = nil;
		UIImageView *newIcon = nil;
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otheridentifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.backgroundColor = [UIColor clearColor];
			if (indexPath.row == 1) {
				[cell.contentView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 45.0f) image:[UIImage imageNamed:@"HotelFilterCellBg1.png"]]];
				
			}else if (indexPath.row == 8) {
				[cell.contentView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 45.0f) image:[UIImage imageNamed:@"HotelFilterCellBg3.png"]]];
				
			}else {
				[cell.contentView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 45.0f) image:[UIImage imageNamed:@"HotelFilterCellBg2.png"]]];
			}
			titleLabel1 = [UISubLabel labelWithTitle:@"" frame:CGRectMake(30.0, 10.0f, 80.0f, 25.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
			titleLabel1.textColor = FontColor333333;
			[cell.contentView addSubview:titleLabel1];
			
			titleLabel2 = [UISubLabel labelWithTitle:@"" frame:CGRectMake(105.0, 10.0f, 180.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentLeft];
			titleLabel2.textColor = FontColor333333;
			[cell.contentView addSubview:titleLabel2];
			
			newIcon = [UIImageView ImageViewWithFrame:CGRectMake(235.0f, 10.0f, 45.0f, 23.0f)];
			[newIcon setImage:[UIImage imageNamed:@"NewIcon.png"]];
			newIcon.hidden = YES;
			[cell.contentView addSubview:newIcon];
			
		}

		switch (indexPath.row) {
			case 1:
				titleLabel1.text = @"好友推荐";
				titleLabel2.text = @"赶紧分享给好友";
				break;
			case 2:
				titleLabel1.text =@"打       分";
				titleLabel2.text = @"去评个分，鼓励一下";
				break;
			case 3:
				titleLabel1.text = @"客服热线";
				titleLabel2.text = @"400-6858-999";
				break;
			case 4:
				titleLabel1.text = @"网       址";
				titleLabel2.text = @"www.itkt.com";
				break;
			case 5:
				titleLabel1.text = @"新浪微博";
				titleLabel2.text = @"http://e.weibo.com/itkt";
				break;
			case 6:
				titleLabel1.text = @"电子邮箱";
				titleLabel2.text = @"3G@itkt.com";
				break;
			case 7:
				titleLabel1.text = @"服务协议";
				titleLabel2.text = @"掌上航旅服务条款";
				break;
//			case 8:
//				titleLabel1.text = @"版本检测";
//				if (self.isShowNewIcon==0) {
//					titleLabel2.text = @"检测新版本";
//				}else {
//					titleLabel2.textColor = FontColor1F7EBF;
//					titleLabel2.text = @"发现新版本";
//					newIcon.hidden = NO;
//				}
//
//				break;
            case 8:
				titleLabel1.text = @"软件推荐";
				titleLabel2.text = @"精品软件下载";
				break;
			default:
				break;
		}
		return cell;
	}
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	switch (indexPath.row) {
		case 1:
        {
            [self showAWSheet];
        }
			break;
		case 2:
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%d",433135814 ]]];
			break;
		case 3:
			[self callTel:@"400-6858-999"];
			break;
		case 4:
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.itkt.com"]];
			break;
		case 5:
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://e.weibo.com/itkt"]];
			break;
		case 6:
			[self launchMailApp];
			break;
		case 7:
			[self loadWebApp];
			break;
//		case 8:
//			[self loadValidateVersion];
//			break;
        case 8:
			[self recommendSoft];
			break;
		default:
			break;
	}
	
}

//评分
//-(void)toGrade  
//{
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"亲，喜欢掌上航旅就给我们的新版本评分吧！" delegate:self cancelButtonTitle:@"不，谢谢！" otherButtonTitles:@"去评分",nil];
//	[alert show];
//	[alert release];
//}
//
//- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//
//	if (buttonIndex == 1)
//	{
//		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%d",433135814 ]]]; 
//		
//	}
//}

//服务协议
-(void)loadWebApp   
{
	ServiceTermViewController *serviceTermVC = [[ServiceTermViewController alloc]init];
	[NavigationController pushViewController:serviceTermVC animated:YES];
	[serviceTermVC release];
	
}
//发送邮件
-(void)launchMailApp   
{     
	NSMutableString *mailUrl = [[[NSMutableString alloc]init]autorelease];   
	//添加收件人   
	NSArray *toRecipients = [NSArray arrayWithObject:@"3G@itkt.com"];   
	[mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];   
	//添加抄送   
	NSArray *ccRecipients = [NSArray arrayWithObjects:@"", nil];     
	[mailUrl appendFormat:@"?cc=%@", [ccRecipients componentsJoinedByString:@","]];   
	//添加密送   
	NSArray *bccRecipients = [NSArray arrayWithObjects:@"", nil];     
	[mailUrl appendFormat:@"&bcc=%@", [bccRecipients componentsJoinedByString:@","]];   
	//添加主题   
	[mailUrl appendString:@"&subject="];   
	//添加邮件内容   
	[mailUrl appendString:@"&body="];   
	NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];     
	[[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];       
}  

#pragma mark-showAWSheet
- (void)showAWSheet
{
    if (IOS8_OR_LATER)
    {
        UIActionSheet *acitonSheet = [[UIActionSheet alloc] initWithTitle:@"好友分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"短信息", @"QQ", @"微信", @"朋友圈", @"新浪微博", nil];
        acitonSheet.tag = 50;
        [acitonSheet showInView:self.view];
        [acitonSheet release];
    }
    else {
        AWActionSheet *sheet = [[AWActionSheet alloc] initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
        sheet.tag = 100;
        [sheet showInView:self.view];
        [sheet release];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 5) {
        [self DidTapOnItemAtIndex:buttonIndex];
    }
}

- (BOOL)isWeChatHave
{
    if (![WXApi isWXAppInstalled]) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:@"您还没有安装微信客户端，请安装后进行分享。点击确定，立即安装。"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"确定",nil];
        [alertView setTag:123];
        [alertView show];
        [alertView release];
        return NO;
    }
    return YES;
}

#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 123) {//微信
        if (buttonIndex == 1) {
            
            NSString *weChatUrl = [WXApi getWXAppInstallUrl];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weChatUrl]];
        }
    }
    //    else if (alertView.tag == 124) {//微信
    //        if (buttonIndex == 1) {
    //
    //            NSString *weChatUrl = [WXApi getWXAppInstallUrl];
    //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weChatUrl]];
    //        }
    //    }
}

-(int)numberOfItemsInActionSheet
{
    return 5;
}

-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[[AWActionSheetCell alloc] init] autorelease];
    switch (index) {
        case 0:
        {
            cell.iconView.image = [UIImage imageNamed:@"message.png"];
            [[cell titleLabel] setText:[NSString stringWithFormat:@"短信息"]];
        }
            break;
        case 1:
        {
            cell.iconView.image = [UIImage imageNamed:@"QQ.png"];
            [[cell titleLabel] setText:[NSString stringWithFormat:@"QQ"]];
        }
            break;
        case 2:
        {
            cell.iconView.image = [UIImage imageNamed:@"weChat.png"];
            [[cell titleLabel] setText:[NSString stringWithFormat:@"微信"]];
        }
            break;
        case 3:
        {
            cell.iconView.image = [UIImage imageNamed:@"wechatQuan.png"];
            [[cell titleLabel] setText:[NSString stringWithFormat:@"微信朋友圈"]];
        }
            break;
        default:
        {
            cell.iconView.image = [UIImage imageNamed:@"sina.png"];
            [[cell titleLabel] setText:[NSString stringWithFormat:@"新浪微博"]];
        }
            
            break;
    }
    
    
    cell.index = index;
    return cell;
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    NSString *wxTitle = @"分享给你一个好软件";
    NSString *destDateString = @"我下载了掌上航旅软件，它能够方便预定机票、酒店、火车票、租车和打车，同时提供天气预报和航班动态查询，注册预定享大礼，还有更多优惠等你来拿哦，快来试试吧！点击http://m.itkt.com下载";

    switch (index) {
        case 0:
            [self toSendSMG];
            break;
            
        case 1:
        {
            _oauth = [[TencentOAuth alloc] initWithAppId:QQAPPID
                                             andDelegate:self];
            NSString *des = [NSString stringWithFormat:@"分享给你一个好软件\n我下载了掌上航旅软件，它能够方便预定机票、酒店、火车票、租车和打车，同时提供天气预报和航班动态查询，注册预定享大礼，还有更多优惠等你来拿哦，快来试试吧！点击http://m.itkt.com下载"];
           
            QQApiTextObject *txtObj = [QQApiTextObject objectWithText:des];
            QQApiObject *_qqApiObject = txtObj;
            
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:_qqApiObject];
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            
            [self handleSendResult:sent];
        }
            break;
        case 2:
        {
            if ([self isWeChatHave]) {
                [UserInfo sharedUserInfo]._isActivityShare = NO;
                [WeiXinExport sendAppContent:wxTitle withDes:destDateString withImg:[UIImage imageNamed:@"icon.png"] withUrl:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/zhang-shang-hang-lu/id433135814?mt=8"]];
            }
        }
            break;
        case 3:
        {
            if ([self isWeChatHave]) {
                [UserInfo sharedUserInfo]._isActivityShare = NO;
                [WeiXinExport sendAppContentTo:wxTitle withDes:destDateString withImg:[UIImage imageNamed:@"icon.png"] withUrl:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/zhang-shang-hang-lu/id433135814?mt=8"]];
            }
        }
            break;
        case 4://新浪微博
        {
            double aVersion = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
            if(aVersion >=6.0f)
            {
                SLComposeViewController *slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
                [slComposerSheet setInitialText:destDateString];
                [slComposerSheet addImage:[UIImage imageNamed:@"icon.png"]];
                [slComposerSheet addURL:[NSURL URLWithString:@"http://www.itkt.com/jsp/phone.jsp"]];
                
                SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
                    NSLog(@"start completion block");
                    NSString *output;
                    switch (result) {
                        case SLComposeViewControllerResultCancelled:
                            output = @"取消分享";
                            break;
                        case SLComposeViewControllerResultDone:
                            output = @"分享成功";
                            break;
                        default:
                            break;
                    }
                    if (result != SLComposeViewControllerResultCancelled)
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                    }
                    [slComposerSheet dismissViewControllerAnimated:YES completion:Nil];
                };
                slComposerSheet.completionHandler = myBlock;
                [self presentViewController:slComposerSheet animated:YES completion:nil];
            }
            else
            {
                
                if ([WeiboSDK isWeiboAppInstalled] ) {
                    WBMessageObject *message = [WBMessageObject message];
                    message.text = destDateString;
                    WBSendMessageToWeiboRequest *sendMessageRequest = [WBSendMessageToWeiboRequest requestWithMessage:message];
                    sendMessageRequest.userInfo = @{@"ShareMessageFrom": @"FlightTrendsDetailViewController",
                                                    @"Other_Info_1": [NSNumber numberWithInt:123],
                                                    @"Other_Info_2": @[@"obj1", @"obj2"],
                                                    @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
                    
                    [WeiboSDK sendRequest:sendMessageRequest];
                }
                else{
                    NSString * urlStr = [NSString stringWithFormat:@"http://v.t.sina.com.cn/share/share.php?title=%@ @掌上航旅",destDateString];
                    ShareToSinaViewController * shareVC  = [[ShareToSinaViewController alloc] init];
                    shareVC._url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    [self.navigationController pushViewController:shareVC animated:YES];
                    [shareVC release];
                }
                
            }
        }
            break;
        default:
            break;
    }

}


#pragma mark - SMS alerts
//短信提醒
-(void)toSendSMG
{
	BOOL canSendSMS = [MFMessageComposeViewController canSendText];
	if(canSendSMS)
	{
		[self sendSMS];
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"该设备不支持发送短信！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

#pragma mark-QQ
- (void)tencentDidLogin
{

}

- (void)showInvalidTokenOrOpenIDMessage{
    UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
    [alert show];
}

//非网络错误导致登录失败
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
}

- (void)tencentDidNotNetWork
{
    
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"请安装手机QQ客户端" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
//        case EQQAPISENDFAILD:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//            [msgbox show];
//            break;
//        }
//        case   EQQAPISENDSUCESS:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:nil message:@"分享成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [msgbox show];
//            break;
//        }
        default:
        {
            break;
        }
    }
}

- (void)sendSMS
{	
	BOOL canSendSMS = [MFMessageComposeViewController canSendText];
	//if (DEBUG) NSLog(@"can send SMS [%d]", canSendSMS);	
	if (canSendSMS) {
		
		MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
		picker.messageComposeDelegate = self;
		picker.navigationBar.tintColor = [UIColor blackColor];
		@try {
			picker.body =@"我下载了掌上航旅软件，它能够方便预定机票、酒店、火车票、租车和打车，同时提供天气预报和航班动态查询，注册预定享大礼，还有更多优惠等你来拿哦，快来试试吧！点击http://m.itkt.com/ 下载";
		}
		@catch (NSException * e) {
			picker.body = @"please input flight number";
		}
		@finally {
			
		}
		picker.recipients = [NSArray array];
//		[self presentModalViewController:picker animated:YES];
        [self presentViewController:picker animated:YES completion:^{}];
		[picker release];		
	}	
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			//if (DEBUG) NSLog(@"Result: canceled");
			break;
		case MessageComposeResultSent:
			//if (DEBUG) NSLog(@"Result: Sent");
			break;
		case MessageComposeResultFailed:
			//if (DEBUG) NSLog(@"Result: Failed");
			break;
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];	
}

- (void)removeVersionView
{
}

- (void)recommendSoft
{
    ASIFormDataRequest * theRequest = [InterfaceClass recommendSoft:@"1"]; //分页 从1开始
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onRecommendSoftResult:) Delegate:self needUserType:Default];
}

- (void)onRecommendSoftResult:(NSDictionary *)dic
{
    RecommendSoftViewController *vc = [[RecommendSoftViewController alloc] init];
    vc._listArray = [RecommendSoftDataResponse setSoftList:dic];
    [NavigationController pushViewController:vc animated:YES];
    [vc release];
}
@end
