//
//  CarVerificationViewController.m
//  FlightProject
//
//  Created by gaopengcheng on 14-10-23.
//
//

#import "CarVerificationViewController.h"
#import "CarServicesViewController.h"

@implementation CarVerificationViewController
@synthesize _phoneLab;
@synthesize _keyboardbar, _textFieldArray;
@synthesize _carInfo, _selectedCarDetail;
@synthesize _showSecond;

- (void)dealloc
{
    self._showSecond = nil;
    self._carInfo = nil;
    self._phoneLab = nil;
    self._textFieldArray = nil;
    self._keyboardbar = nil;
    self._selectedCarDetail = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"输入验证码";
    
    self._promptLab = [UILabel labelWithTitle:@"提示：系统已发送验证码到租车人手机，请您在下方填写正确的验证码信息" frame:CGRectMake(12.0f, 18.0f, 275.5f, 36.5f) font:FontSize26 color:FontColor656565 alignment:NSTextAlignmentLeft autoSize:YES];
    self._promptLab.hidden = YES;
    [self.view addSubview:self._promptLab];
    
    UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, 60, ViewWidth-16.0f, 7.0f)] ;
    [topView setImage:[UIImage imageNamed:@"MemberLoginTop.png"]];
    [self.view addSubview:topView];
    
    UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, 67, ViewWidth-16.0f, 130)];
    [centerView setImage:[UIImage imageNamed:@"MemberLoginCenter.png"]];
    [self.view addSubview:centerView];
    
    UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, 197, ViewWidth-16.0f, 7.0f)];
    [bottom setImage:[UIImage imageNamed:@"MemberLoginBottom.png"]];
    [self.view addSubview:bottom];
    
    
    [self.view addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(28.0f, 92.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
    
    UISubLabel *userNameTitle = [UISubLabel labelWithTitle:@"手机号 :" frame:CGRectMake(38.0f, 80.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
    userNameTitle.textColor = FontColor333333;
    [self.view addSubview:userNameTitle];
    
    self._phoneLab = [UILabel labelWithTitle:self._carInfo._mobileNumber frame:CGRectMake(120.0f, 83.0f, 200.0f, 25.0f) font:FontSize30 color:FontColor656565 alignment:NSTextAlignmentLeft];
    [self.view addSubview:self._phoneLab];
    
    UIImageView *verificationImageView = [UIImageView ImageViewWithFrame:CGRectMake(22.0f, 133.0f, 167.5f, 33.5f)];
    [verificationImageView setImage:[UIImage imageNamed:@"VerificationTextBox.png"]];
    [self.view addSubview:verificationImageView];
    
    [self.view addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(28.0f, 146.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
    
    UISubLabel *verificationCodeTitle = [UISubLabel labelWithTitle:@"验证码 :" frame:CGRectMake(38.0f, 134.0f, 60.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
    userNameTitle.textColor = FontColor333333;
    [self.view addSubview:verificationCodeTitle];
    
    //短信验证码
    verificationCodeTextField = [UISubTextField TextFieldWithFrame:CGRectMake(95.0f, 138.0f, 93.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入验证码"];
    verificationCodeTextField.font = FontSize30;
    verificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    verificationCodeTextField.tag = 101;
    verificationCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    verificationCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
    verificationCodeTextField.delegate = self;
    verificationButton.enabled = NO;
    [self.view addSubview:verificationCodeTextField];
    
    verificationButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(195.0f, 133.0f, 104.0f, 34.0f) backImage:[UIImage imageNamed:@"VerificationButtonA.png"] target:self action:@selector(getCode)];
    [self.view addSubview:verificationButton];
    
    self._showSecond = [UISubLabel labelWithTitle:@"" frame:CGRectMake(215.0f, 136.0f, 60.0f, 25.0f) font:FontBlodSize32 alignment:NSTextAlignmentCenter];
    self._showSecond.textColor = FontColorABABAB;
    self._showSecond.hidden = YES;
    [self.view addSubview:self._showSecond];

    UIButton *submitBut = [UIButton buttonWithTag:0 frame:CGRectMake((ViewWidth - 152)/2, 260, 152, 40) target:self action:@selector(submitCode)];
    [submitBut setBackgroundImage:[UIImage imageNamed:@"ConfirmationPassButton.png"] forState:UIControlStateNormal];
    [self.view addSubview:submitBut];
    
    self._textFieldArray = [NSArray arrayWithObjects: verificationCodeTextField, nil];
    
//    [self getCode];
}

-(void) backHome
{
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
        [NavigationController popViewControllerAnimated:YES];
        return;
    }
    for (int i = 0; i < [NavigationController.viewControllers count]; i ++) {
        if ([[NavigationController.viewControllers objectAtIndex:i] isKindOfClass:[CarPassengerListViewController class]]) {
            [NavigationController popToViewController:[NavigationController.viewControllers objectAtIndex:i] animated:YES];
        }
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSInteger textFieldStrLength = textFieldStr.length;
    int textFieldMaxLenth = 6;
    
    if(textFieldStrLength >= textFieldMaxLenth)
    {
        textField.text = [textFieldStr substringToIndex:textFieldMaxLenth];
        return NO;
    }
    else {
        return YES;
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self._keyboardbar == nil) {
        KeyBoardTopBar * keyboardbar = [[KeyBoardTopBar alloc] init:self._textFieldArray view:self.view ];
        self._keyboardbar = keyboardbar;
        [keyboardbar release];
    }
    [self._keyboardbar showBar:textField];  //显示工具条
    return YES;
}

- (void)getCode {
    
    [self._keyboardbar HiddenKeyBoard];
    ASIFormDataRequest * theRequest = [InterfaceClass getValidCode:self._carInfo._mobileNumber];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onVerCodeResult:) Delegate:self needUserType:Default];
}

- (void)onVerCodeResult:(NSDictionary *)dic
{
    verificationCodeTextField.text = @"";
    NSString *statueCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *message   = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    if ([statueCode intValue]==0){
        self._carInfo._uuid = [NSString stringWithFormat:@"%@", [dic objectForKey:@"uuid"]];
        self._carInfo._validId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"validId"]];
//        verificationCodeTextField.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"validCode"]];
        [self startTimer];
    }
    else {
        [UIAlertView alertViewWithMessage:message];
    }
}

- (void)submitCode
{
    if (verificationCodeTextField.text.length != 6) {
        [UIAlertView alertViewWithMessage:@"请输入6位验证码！"];
        return;
    }
    ASIFormDataRequest * theRequest = [InterfaceClass queryCarService:self._carInfo withCode:verificationCodeTextField.text];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onQueryCarServicePaseredResult:) Delegate:self needUserType:Default];
}

-(void)onQueryCarServicePaseredResult:(NSDictionary *)resultDic
{
    QueryCarServiceResponse * carServiceRes = [QueryCarServiceResponse QueryCarServiceResponse:resultDic];
    CarServicesViewController * carServicesVC = [[CarServicesViewController alloc] init];
    carServicesVC.carDetail = self._selectedCarDetail;
    carServicesVC.carService = carServiceRes;
    carServicesVC.queryDataModel = self._carInfo;
    [NavigationController pushViewController:carServicesVC animated:YES];
    [carServicesVC release];
}

//启动定时器
- (void)startTimer
{
    self.times= 91;
    _timer = [[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES] retain];
}
//执行自定义逻辑
- (void)onTimer
{
    
    self.times--;
    if (self.times == 90) {
        verificationButton.enabled = NO;
        self._showSecond.hidden = NO;
        self._promptLab.hidden = NO;
        [verificationButton setBackgroundImage:[UIImage imageNamed:@"VerificationButtonC.png"]  forState:UIControlStateNormal];
    }
    self._showSecond.text = [NSString stringWithFormat:@"（%d）",self.times];
    if (self.times ==0) {
        verificationButton.enabled = YES;
        self._showSecond.hidden = YES;
        self._promptLab.hidden = YES;
        [verificationButton setBackgroundImage:[UIImage imageNamed:@"VerificationButtonA.png"]  forState:UIControlStateNormal];
        [self stopTimer];
    }
    
}


//废弃定时器
- (void)stopTimer
{
    if(_timer != nil){
        [_timer invalidate];
        [_timer release];
        _timer = nil;
    }
}
@end
