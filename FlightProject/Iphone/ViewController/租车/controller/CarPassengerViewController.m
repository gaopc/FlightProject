//
//  CarPassengerViewController.m
//  FlightProject
//
//  Created by longcd on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarPassengerViewController.h"
#import "CarSubmitOrderViewController.h"
#import "CarVerificationViewController.h"

@interface CarPassengerViewController ()

@end

@implementation CarPassengerViewController
@synthesize keyboardbar,textFieldArray;
@synthesize queryDataModel;
@synthesize carDetail, carService;
@synthesize actionType, carPassengersInfo, gateway;
- (void)dealloc
{
    self.carDetail = nil;
    self.carService = nil;
    
    self.keyboardbar = nil;
    self.textFieldArray = nil;
    self.queryDataModel = nil;
    self.carPassengersInfo = nil;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.actionType intValue] == 0) {
        self.title = @"新增租车人";
    }
    else if ([self.actionType intValue] == 1) {
        self.title = @"编辑租车人";
    }

    [self.view addSubview:[UISubLabel labelWithframe:CGRectMake(0, 0, ViewWidth, ViewHeight-44-50-6) backgroundColor:FontColorFFFFFF]];
    
    NSArray * titleArray = [NSArray arrayWithObjects:@"姓       名:",@"证件号码:",@"联系电话:", nil];
    NSArray * placeArray = [NSArray arrayWithObjects:@"请输入取车人姓名",@"请输入身份证号码",@"请输入联系电话", nil];
    for (int i=0; i<3; i++) {
        [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake((ViewWidth-276) /2, 50+i*65, 276, 40) image:[UIImage imageNamed:@"输入框.png"]]];
        [self.view addSubview:[UISubLabel labelWithTitle:[titleArray objectAtIndex:i] frame:CGRectMake((ViewWidth-276) /2+5 , 50+i*65,70, 40) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentRight]];
    }
    
    _nameField = [UISubTextField TextFieldWithFrame:CGRectMake((ViewWidth-276) /2 +70+20, 50+0*65, 276-80-10, 40) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:[placeArray objectAtIndex:0] font:FontSize28];
    _identityNumberField = [UISubTextField TextFieldWithFrame:CGRectMake((ViewWidth-276) /2 +70+20, 50+1*65, 276-80-10, 40) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:[placeArray objectAtIndex:1] font:FontSize28];
    _mobileNumberField = [UISubTextField TextFieldWithFrame:CGRectMake((ViewWidth-276) /2 +70+20, 50+2*65, 276-80-10, 40) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:[placeArray objectAtIndex:2] font:FontSize28];
    
    _nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _identityNumberField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _mobileNumberField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _nameField.delegate = self;
    _identityNumberField.delegate = self;
    _mobileNumberField.delegate = self;
    
    _identityNumberField.keyboardType = UIKeyboardTypeASCIICapable;
    _mobileNumberField.keyboardType = UIKeyboardTypeNumberPad;
    
    _nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _identityNumberField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _mobileNumberField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.textFieldArray = [NSArray arrayWithObjects:_nameField, _identityNumberField, _mobileNumberField, nil];
    
    if ( [UserInfo sharedUserInfo].userID && ![[UserInfo sharedUserInfo].userID isEqualToString:@""])
    {
        if ([MyRegex checkname:[UserInfo sharedUserInfo].name]) {
            _nameField.text = [UserInfo sharedUserInfo].name;
        }
        else{
            _nameField.text =nil;
        }
        _identityNumberField.text = [UserInfo sharedUserInfo].cardNo;
        _mobileNumberField.text = [UserInfo sharedUserInfo].telePhone;
    }
    else
    {
        _nameField.text =nil;
        _identityNumberField.text = nil;
        _mobileNumberField.text = nil;
    }

    
    [self.view addSubview:_nameField];
    [self.view addSubview:_identityNumberField];
    [self.view addSubview:_mobileNumberField];
    
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, ViewHeight-44-50-5, 300, 5) image:[UIImage imageNamed:@"分割线.png"]]];
    
    subButton = [UIButton buttonWithType:UIButtonTypeCustom  tag:0 title:nil backImage:[UIImage imageNamed:@"EditPassengersButton.png"] frame:CGRectMake((ViewWidth - 145) / 2, ViewHeight - 44 - 50 + 5, 145, 37.5) font:nil  color:nil target:self action:@selector(addPassengerDown:)];
    delButton = [UIButton buttonWithType:UIButtonTypeCustom  tag:0 title:nil backImage:[UIImage imageNamed:@"删除租车人.png"] frame:CGRectMake((ViewWidth - 145) / 2, ViewHeight - 44 - 50 + 5, 145, 37.5) font:nil  color:nil target:self action:@selector(deletePassenper:)];
    delButton.hidden = YES;
    
    doubleButtonImgView = [UIImageView ImageViewWithFrame:CGRectMake(2.0f,  ViewHeight - 44 - 50, 313.0f, 45.0f) image:[UIImage imageNamed:@"appInfoBottom.png"]];
    doubleButtonImgView.hidden = YES;

    [self.view addSubview:doubleButtonImgView];    
    [self.view addSubview:delButton];
    [self.view addSubview:subButton];
    
    if ([self.actionType intValue] == 1) {
        _nameField.text = carPassengersInfo._name;
        _identityNumberField.text = carPassengersInfo._identityNumber;
        _mobileNumberField.text = carPassengersInfo._tel;
        
        subButton.frame = CGRectMake(15, ViewHeight  - 44 - 50 + 5, 145, 37.5);
        delButton.frame = CGRectMake(160, ViewHeight  - 44 - 50 + 5, 145, 37.5);
        delButton.hidden = NO;
        doubleButtonImgView.hidden = NO;
    }
    else if ([self.actionType intValue] == 0) {
        _nameField.text = nil;
        _identityNumberField.text = nil;
        _mobileNumberField.text = nil;
        
        [subButton setImage:[UIImage imageNamed:@"HotelPersonne4.png"] forState:UIControlStateNormal];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if ([self.actionType intValue] == 1) {
//        _nameField.text = carPassengersInfo._name;
//        _identityNumberField.text = carPassengersInfo._identityNumber;
//        _mobileNumberField.text = carPassengersInfo._tel;
//        
//        subButton.frame = CGRectMake(15, ViewHeight - 50 + 5, 145, 37.5);
//        delButton.frame = CGRectMake(160, ViewHeight - 50 + 5, 145, 37.5);
//        delButton.hidden = NO;
//        doubleButtonImgView.hidden = NO;
//    }
//    else if ([self.actionType intValue] == 0) {
//        _nameField.text = nil;
//        _identityNumberField.text = nil;
//        _mobileNumberField.text = nil;
//    
//        [subButton setImage:[UIImage imageNamed:@"HotelPersonne4.png"] forState:UIControlStateNormal];
//    }
}

- (void)deletePassenper:(UIButton *)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认删除当前租车人信息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    [self.view addSubview:alertView];
    [alertView release];
}

- (void)onRemoveCarRentalResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    if ([statusCode intValue] != 0) {
        [UIAlertView alertViewWithMessage:message];
    }
    else {
        [NavigationController popViewControllerAnimated:YES];
    }
}

-(void)addPassengerDown:(UIButton *)sender
{

	NSArray *parts = [_nameField.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];  
	NSArray *filteredArray = [parts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];  
	_nameField.text = [filteredArray componentsJoinedByString:@""]; 
    
    if (_nameField.text.length == 0) {
        [UIAlertView alertViewWithMessage:@"请输入租车人姓名" :@"提示"];
        return;
    }
    else if (![MyRegex checkname:_nameField.text]) {
        [UIAlertView alertViewWithMessage:@"请输入正确姓名!" :@"提示"];
        return;
    }
    else if (_identityNumberField.text.length == 0){
        [UIAlertView alertViewWithMessage:@"请填写证件号码！" :@"提示"];
        return;
    }
    else if (![MyRegex checkIsCertificateNum:_identityNumberField.text]) {
        [UIAlertView alertViewWithMessage:@"请输入正确的证件号码!" :@"提示"];
        return;
    }
    else if (_mobileNumberField.text.length == 0){
        [UIAlertView alertViewWithMessage:@"请输入联系电话" :@"提示"];
        return;
    }
    else if (![_mobileNumberField.text isMatchedByRegex:PHONENO]) {
		[UIAlertView alertViewWithMessage:@"请输入正确的手机号码！" :@"提示"];
		return;
	}
    
    
    self.queryDataModel._userId = [UserInfo sharedUserInfo].userID;
    
    self.queryDataModel._name = _nameField.text;
    self.queryDataModel._identityNumber = _identityNumberField.text;
    self.queryDataModel._mobileNumber = _mobileNumberField.text;
    
    if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
        
//        ASIFormDataRequest * theRequest = [InterfaceClass queryCarService:self.queryDataModel];
//        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onQueryCarServicePaseredResult:) Delegate:self needUserType:Default];
        
        CarVerificationViewController *verificationVC = [[CarVerificationViewController alloc] init];
        verificationVC._carInfo = self.queryDataModel;
        verificationVC._selectedCarDetail = self.carDetail;
        [self.navigationController pushViewController:verificationVC animated:YES];
        [verificationVC release];
        return;
    }
    
    if ([self.actionType intValue] == 0) {
        ASIFormDataRequest * theRequest = [InterfaceClass addCarRental:[UserInfo sharedUserInfo].userID name:_nameField.text identityNumber:_identityNumberField.text telePhone:_mobileNumberField.text];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPassengersInfoResult:) Delegate:self needUserType:NoMember];
    }
    else {
        ASIFormDataRequest * theRequest = [InterfaceClass updateCarRental:[UserInfo sharedUserInfo].userID orderId:carPassengersInfo._id name:_nameField.text identityNumber:_identityNumberField.text telePhone:_mobileNumberField.text];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPassengersInfoResult:) Delegate:self needUserType:Member];
    }
}

-(void)onPassengersInfoResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    
    if ([statusCode intValue] != 0)
    {
        [UIAlertView alertViewWithMessage:message];
    }
    else {
        if ([self.gateway intValue] == 0) {
            
            //        ASIFormDataRequest * theRequest = [InterfaceClass queryCarService:self.queryDataModel];
            //        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onQueryCarServicePaseredResult:) Delegate:self needUserType:Default];
            
            CarVerificationViewController *verificationVC = [[CarVerificationViewController alloc] init];
            verificationVC._carInfo = self.queryDataModel;
            verificationVC._selectedCarDetail = self.carDetail;
            [self.navigationController pushViewController:verificationVC animated:YES];
            [verificationVC release];
        }
        else {
            [NavigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)onQueryCarServicePaseredResult:(NSDictionary *)resultDic
{
    QueryCarServiceResponse * carServiceRes = [QueryCarServiceResponse QueryCarServiceResponse:resultDic];    
    CarServicesViewController * carServicesVC = [[CarServicesViewController alloc] init];
    carServicesVC.carDetail = self.carDetail;
    carServicesVC.carService = carServiceRes;
    carServicesVC.queryDataModel = self.queryDataModel;
    [NavigationController pushViewController:carServicesVC animated:YES];
    [carServicesVC release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - textFild delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.keyboardbar == nil) {
        KeyBoardTopBar * _tempkeyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
        self.keyboardbar = _tempkeyboardbar;
        [_tempkeyboardbar release];
    }
    [keyboardbar showBar:textField];  //显示工具条
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
	
	if (_nameField == textField) {
		
		textFieldMaxLenth = CarUserNameLenght;
	}
    else if (_identityNumberField == textField) {

		textFieldMaxLenth = 18;
	}
	else if (_mobileNumberField == textField) {
  
	    textFieldMaxLenth = 11;
  
	}
    
	if(textFieldStrLength >= textFieldMaxLenth)
	{
		textField.text = [textFieldStr substringToIndex:textFieldMaxLenth];
		return NO;
	}
	else {
		return YES;
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if (textField == _identityNumberField) {
		if (textField.text.length>=18) {
			NSString * text = [textField.text substringFromIndex:17];  
			textField.text = [textField.text stringByReplacingOccurrencesOfString :text withString:[text uppercaseString]];   
		}
	}
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        ASIFormDataRequest * theRequest = [InterfaceClass removeCarRental:[UserInfo sharedUserInfo].userID orderId:carPassengersInfo._id];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onRemoveCarRentalResult:) Delegate:self needUserType:Member];
    }
}
@end
