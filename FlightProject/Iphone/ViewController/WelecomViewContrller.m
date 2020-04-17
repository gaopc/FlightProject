//
//  WelecomViewContrller.m
//  FlightProject
//
//  Created by longcd on 12-11-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WelecomViewContrller.h"
#import "GetConfiguration.h"
#import "WelecomImagesView.h"
#import "MemberRegisterViewController.h"
@interface WelecomViewContrller ()

@end

@implementation WelecomViewContrller
@synthesize basicInfo,_backgroundImage,_hasFirstImages;
-(void)dealloc
{
    self.basicInfo.cityDelegate = nil;
    self.basicInfo = nil;
    self._backgroundImage = nil;
    self._hasFirstImages = FALSE;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//关于新版本的提示
-(BOOL) showFirstInAlert{
	
	if ([WelecomImagesView isFirstShow] == NO) {
		return NO;
	}
    else {
        WelecomImagesView * imagesV = [[WelecomImagesView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight+ViewStartY)];
        imagesV.delegate = self;
        [self.view addSubview:imagesV];
        [imagesV release];
	    
	[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:keyShowGrade];
	[[NSUserDefaults standardUserDefaults] synchronize];
	    
        return YES;
    }
}

//关于评分的提示 崔立东 2013年3月5日添加
-(void) showGradeAlert{
	
	NSString* tempStr = [[NSUserDefaults standardUserDefaults] stringForKey:keyIsFirstGradeMark];
	if ([WelecomImagesView isShowGrade] == YES && ![tempStr isEqualToString:@"1"]) {
	[self performSelector:@selector(toFirstGrade) withObject:nil afterDelay:0.3];
	//[self toFirstGrade];
	}
}

-(void)scrollViewFinished 
{
    [self showHome];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    times = 5;
    
    activityIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIV startAnimating];

    self._hasFirstImages = [self showFirstInAlert];
    //崔立东 2013年3月5日添加
    if (ViewHeight > 480) {
        self._backgroundImage = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 568) image:[UIImage imageNamed:@"Default-568h@2x.png"]];
        activityIV.frame = CGRectMake((ViewWidth-30)/2, ViewHeight - 170 +ViewStartY, 30, 30);
    }
    else {
        self._backgroundImage = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth, 480) image:[UIImage imageNamed:@"Default.png"]];
        activityIV.frame = CGRectMake((ViewWidth-30)/2, ViewHeight - 120 , 30, 30);
    }
    [self.view addSubview:self._backgroundImage];
    [self.view addSubview:activityIV];
    [activityIV release];
    
    GetBasicInfoFromServer *_basicInfo = [[GetBasicInfoFromServer alloc] init];
    self.basicInfo = _basicInfo;
    [_basicInfo release];
    self.basicInfo.cityDelegate = self;
    [self.basicInfo getConfiguration:[UserInfo sharedUserInfo].deviceToken];
 
}
-(void)didCityInfoResult:(NSArray *)cityArray
{
}
- (void)didBasicInfoResult:(NSDictionary *)dic
{
    NSLog(@"统一配置返回");
    NSString * errorMessage = [dic objectForKey:@"errorMessage"];
    
    if (errorMessage) {
        [self._backgroundImage removeFromSuperview];
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@%@",NetFailMessage,errorMessage] :@"提示"];
        if (!self._hasFirstImages) {
            [activityIV removeFromSuperview];
            activityIV =nil;
            [self showHome];
        }
        else{
            [activityIV removeFromSuperview];
            activityIV =nil;

        }
    }
    else {
        NSLog(@"是否注册：%@", [GetConfiguration shareGetConfiguration]._isFirst);
        [[NSUserDefaults standardUserDefaults] setObject:[GetConfiguration shareGetConfiguration]._isFirst forKey:keyAudioRegister];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        self._pointView._pointLab.tag = [[GetConfiguration shareGetConfiguration]._unPayOrders intValue];
        
        if ([[GetConfiguration shareGetConfiguration]._version._mandatoryCode intValue] > MyVersionCode) {
            
            [[VersionView shareVersionView] hideCancelButton];
            [VersionView shareVersionView].versionView.text = [GetConfiguration shareGetConfiguration]._version._desc;
            [[VersionView shareVersionView] showVersionView];
            [activityIV removeFromSuperview];            activityIV =nil;

        }
        else if ([[GetConfiguration shareGetConfiguration]._version._code intValue] > MyVersionCode){
            
            [VersionView shareVersionView].delegate = self;
            [VersionView shareVersionView].versionView.text = [GetConfiguration shareGetConfiguration]._version._desc;
            [[VersionView shareVersionView] showVersionView];
            [activityIV removeFromSuperview];            activityIV =nil;

        }
        else{
            [self._backgroundImage removeFromSuperview];
            if (!self._hasFirstImages) {
                [activityIV removeFromSuperview];           activityIV =nil;

                [self showHome];
            }
            else{
                [activityIV removeFromSuperview];           activityIV =nil;

            }
        }
    }
}

- (void)removeVersionView
{
    [VersionView shareVersionView].delegate = nil;
//    [activityIV removeFromSuperview];
    [self._backgroundImage removeFromSuperview];
    if (!self._hasFirstImages) {
        [self showHome];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

        if (buttonIndex == 0) {
            NSString *updateurl = @"http://itunes.apple.com/cn/app/zhang-shang-hang-lu/id433135814?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateurl]];
            exit(0);
        }
        else {
            [activityIV removeFromSuperview];            activityIV =nil;

            [self._backgroundImage removeFromSuperview];
            if (!self._hasFirstImages) {
                [self showHome];
            }
        }
}


//评分 崔立东 2013年3月5日添加
-(void)toFirstGrade  
{
	[[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:keyShowGrade];
	[[NSUserDefaults standardUserDefaults] synchronize];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"亲，喜欢掌上航旅就给我们的新版本评分吧！" delegate:[self retain] cancelButtonTitle:@"不，谢谢！" otherButtonTitles:@"去评分",nil];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
	if (buttonIndex == 1)
	{
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%d",433135814 ]]]; 
		
	}

	[self release];
}

-(void)showHome
{
//    AdvertisementView *advertisementView = [[AdvertisementView alloc] initWithFrame:self.view.bounds];
//    if (ViewHeight > 480) {
//        advertisementView._imgUrl = [GetConfiguration shareGetConfiguration]._advertisingImgBig;
//    }
//    else {
////        advertisementView._imgUrl = [GetConfiguration shareGetConfiguration]._advertisingImg;
//        advertisementView._imgUrl = @"http://ht3.itkt.com:5050/BTSF/baseinfo/plane/photoview?url=Android.jpg";
//    }
//    [self.view addSubview:advertisementView];
//    [advertisementView release];
    
    NSString *temp = @"";
    //        temp = @"http://image.s1979.com/allimg/130321/1A3251G2-0.jpg";
    
    if (ViewHeight > 480) {
        temp = [GetConfiguration shareGetConfiguration]._advertisingImgBig;
    }
    else {
        temp = [GetConfiguration shareGetConfiguration]._advertisingImg;
    }
    
    [self setPhotoToPath:temp];
    
    if (self.advertisementImage) {
        UIImageView *img = [UIImageView ImageViewWithFrame:self.view.bounds image:self.advertisementImage];
        img.tag = 11;
        img.userInteractionEnabled = NO;
        
        secondLab = [UILabel labelWithTitle:@"5s" frame:CGRectMake(ViewWidth - 60, 20, 40, 20) font:FontSize20 color:FontColor000000 alignment:NSTextAlignmentCenter];
        secondLab.layer.borderColor = [UIColor grayColor].CGColor;
        secondLab.layer.borderWidth = 1;
        secondLab.layer.cornerRadius = 3;
        
        [self.view addSubview:img];
        [self.view addSubview:secondLab];
        
        if (!timer) {
            timer = [[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES] retain];
        }
    }
    else {
        [NavigationController popViewControllerAnimated:NO];
        [self showGradeAlert];
    }
}
-(void)showRegister
{
    [NavigationController setNavigationBarHidden:NO animated:YES];
    MemberRegisterViewController * vc = [[MemberRegisterViewController alloc] init];
    [NavigationController pushViewController:vc animated:YES];
    [vc release];
    [self performSelector:@selector(deleteWelecom)];
}
-(void) deleteWelecom
{
    NSMutableArray * mArray = [NSMutableArray array];
    [mArray addObjectsFromArray:NavigationController.viewControllers];
    [mArray removeObjectAtIndex:[mArray count]-2];
    NavigationController.viewControllers = mArray;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch事件！！！！！！");
    if (self.advertisementImage) {
        self.advertisementImage = nil;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDelegate:self];
        UIView *tagview = [self.view viewWithTag:11];
        tagview.alpha = 0.3;
        [UIView setAnimationDidStopSelector:@selector(removeAdvertisementImage)];
        [UIView commitAnimations];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchMove事件！！！！！！");
    if (self.advertisementImage) {
        self.advertisementImage = nil;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDelegate:self];
        UIView *tagview = [self.view viewWithTag:11];
        tagview.alpha = 0.3;
        [UIView setAnimationDidStopSelector:@selector(removeAdvertisementImage)];
        [UIView commitAnimations];
    }
}

- (UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[fileURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    result = [UIImage imageWithData:data];
    return result;
}

-(BOOL) setPhotoToPath:(NSString *)imgUrl
{
    if (imgUrl.length < 8) {
        self.advertisementImage = nil;
        return NO;
    }
    NSString *imgName = [NSString stringWithFormat:@"%@.png",[imgUrl stringByReplacingOccurrencesOfString:@"/" withString:@"-"]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:imgName];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (blHave) {
        self.advertisementImage = [UIImage imageWithContentsOfFile:uniquePath];
        return NO;
    }

    self.advertisementImage = [self getImageFromURL:imgUrl];
    NSData *data = UIImageJPEGRepresentation(self.advertisementImage, 0);
//    NSData *data = UIImagePNGRepresentation(self.advertisementImage);
    BOOL result = [data writeToFile:uniquePath atomically:YES];
    if (result) {
        
        NSString *oldName = [[NSUserDefaults standardUserDefaults] objectForKey:keyAdvertisementImg];
        if (oldName) {
            [self deleteFromName:oldName];
        }
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:imgName forKey:keyAdvertisementImg];
        [defaults synchronize];
        
        NSLog(@"success");
        
        
        return YES;
    }else {
        NSString *oldName = [[NSUserDefaults standardUserDefaults] objectForKey:keyAdvertisementImg];
        if (oldName) {
            uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:oldName];
            self.advertisementImage = [UIImage imageWithContentsOfFile:uniquePath];
        }
        
        NSLog(@"no success");
        return NO;
    }
}

-(BOOL)deleteFromName:(NSString *)name
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:name];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        //NSLog(@"no  have");
        return NO;
    }else {
        //NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            NSLog(@"dele success");
            return YES;
        }else {
            //NSLog(@"dele fail");
            return NO;
        }
    }
}

//执行自定义逻辑
- (void)onTimer
{
    
    times--;

    NSLog(@"times = %d", times);
    if (times < 0) {
        [self stopTimer];
        if (self.advertisementImage) {
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            [UIView setAnimationDelegate:self];
            UIView *tagview = [self.view viewWithTag:11];
//            [tagview setFrame:CGRectMake(0, - ViewHeight - 20, ViewWidth, ViewHeight)];
            tagview.alpha = 0.3;
            [UIView setAnimationDidStopSelector:@selector(removeAdvertisementImage)];
            [UIView commitAnimations];
        }
    }
    else {
        secondLab.text = [NSString stringWithFormat:@"%ds", times];
    }
}

//废弃定时器
- (void)stopTimer
{
    if(timer != nil){
        [timer invalidate];
        [timer release];
        timer = nil;
    }
}

- (void)removeAdvertisementImage
{
    UIView *tagview = [self.view viewWithTag:11];
    [tagview removeFromSuperview];
    
    [NavigationController popViewControllerAnimated:NO];
    [self showGradeAlert];
}
@end
