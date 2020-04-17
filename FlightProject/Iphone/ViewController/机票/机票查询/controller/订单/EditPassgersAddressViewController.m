//
//  EditPassgersAddressViewController.m
//  FlightProject
//
//  Created by lidong  cui on 12-10-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EditPassgersAddressViewController.h"
#import "MyRegex.h"
#import <QuartzCore/QuartzCore.h>
#import "PassengersAddressViewController.h"
#import "TicketOrderInfoViewController.h"
#import "MemberOrderPayInfoViewController.h"
@interface PassengersAddressViewController ()

@end

@implementation EditPassgersAddressViewController
@synthesize index;
@synthesize passengerAddressItem;

@synthesize textFieldArray,keyboardbar;
@synthesize delegate;
@synthesize _cityData;

-(void)dealloc
{
	
	self.index = 0 ;
	
	self.textFieldArray = nil;
	self.passengerAddressItem = nil;
	self.keyboardbar = nil;
	self.delegate = nil;
    [myScroll release];
    [_cityData release];
	[super dealloc];
}


#pragma mark -
#pragma mark View系统方法


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	[super loadView];
    
    provinceName = @"";
    cityName = @"";
    countyName = @"";
    int offy = 55;
	
    myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight - 44 - 50)];
    myScroll.showsVerticalScrollIndicator = NO;
    myScroll.delegate = self;
    myScroll.backgroundColor = [UIColor whiteColor];
    myScroll.contentSize = CGSizeMake(0, 420);
    [self.view addSubview:myScroll];
    
    
	editorBgView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,ViewHeight-100.0f)];
	editorBgView.backgroundColor = [UIColor whiteColor];
	[myScroll addSubview:editorBgView];
	
	UIImageView *nameImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 40.0f, ViewWidth - 40, 36.5f)];
	[nameImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[editorBgView addSubview:nameImageView];
	
        UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"姓       名: " frame:CGRectMake(25.0f, 47.0f, 70.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	titleLabel1.textColor = FontColor333333;
	[editorBgView addSubview:titleLabel1];
	
	//收件人姓名
	nameTextField = [UISubTextField TextFieldWithFrame:CGRectMake(98.0f, 44.0f, ViewWidth - 125, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"中文或英文(TOM/BUSH)"];
	nameTextField.font = FontSize32;
	nameTextField.tag = 100;
	nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	nameTextField.delegate = self;
	nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
	[editorBgView addSubview:nameTextField];
	
        UIImageView *lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 92.0f, ViewWidth - 40, 1.0f)];
	[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
	[editorBgView addSubview:lineImageView];
	
	
	UIImageView *cityImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 110.0f, ViewWidth - 40, 36.5f)];
	[cityImageView setImage:[UIImage imageNamed:@"MemberAddressTextBox.png"]];
	[myScroll addSubview:cityImageView];
    
    UISubLabel *addressLabel = [UISubLabel labelWithTitle:@"地       区: " frame:CGRectMake(25.0f, 117.0f, 70.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	addressLabel.textColor = FontColor333333;
	[myScroll addSubview:addressLabel];
    
    UIImageView *iconView=[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 50, 117.0f + 5, 15, 10)];
    iconView.image=[UIImage imageNamed:@"down.png"];
    [myScroll addSubview:iconView];
    
    selectCity = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"请选择城市" frame:CGRectMake(98.0f, 114.0f, ViewWidth - 125, 28) font:FontSize32 color:[UIColor colorWithWhite:0.7 alpha:0.8] target:self action:@selector(selectCityInfo)];
    [selectCity setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [myScroll addSubview:selectCity];

	UIImageView *addressImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 110.0f + offy, ViewWidth - 40, 71.5f)];
	[addressImageView setImage:[UIImage imageNamed:@"MemberAddressTextBox.png"]];
	[myScroll addSubview:addressImageView];
    
    UISubLabel *titleLabel2 = [UISubLabel labelWithTitle:@"详细地址: " frame:CGRectMake(25.0f, 117.0f + offy, 70.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	titleLabel2.textColor = FontColor333333;
	[myScroll addSubview:titleLabel2];
	
	placeHolderLabel = [UISubLabel labelWithTitle:@"请输入常用邮寄地址:" frame:CGRectMake(92.0f, 117.0f + offy, 150.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	placeHolderLabel.textColor = FontColor333333;
	placeHolderLabel.textColor = [UIColor lightGrayColor];
	
	//[myScroll addSubview:placeHolderLabel];
	
	//详细地址
	addressTextView = [[UISubTextView alloc] initWithFrame:CGRectMake(91.0f, 110.0f + offy, ViewWidth - 113, 70.0f)];
	addressTextView.tag = 200;
	addressTextView.delegate = self;
	addressTextView.returnKeyType = UIReturnKeyDefault;
	addressTextView.font = [UIFont fontWithName:@"Helvetica" size:16.5f];
	addressTextView.backgroundColor = [UIColor clearColor];
	addressTextView.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
        [myScroll addSubview:addressTextView];
	
	
        lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 200.0f + offy, ViewWidth - 40, 1.0f)];
	[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
	[myScroll addSubview:lineImageView];
	
	UIImageView *postCodeImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 223.0f + offy, ViewWidth - 40, 36.5f)];
	[postCodeImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[myScroll addSubview:postCodeImageView];
	
	UISubLabel *titleLabel3 = [UISubLabel labelWithTitle:@"邮       编: " frame:CGRectMake(25.0f, 230.0f + offy, 70.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	titleLabel3.textColor = FontColor333333;
	[myScroll addSubview:titleLabel3];
	
	
	
	//邮政编码
	postCodeTextField = [UISubTextField TextFieldWithFrame:CGRectMake(98.0f, 226.0f + offy, ViewWidth - 25, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入6位邮政编码"];
	postCodeTextField.font = FontSize32;
	postCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
	postCodeTextField.tag = 101;
	postCodeTextField.delegate = self;
	postCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	postCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	[myScroll addSubview:postCodeTextField];
	
	lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 273.0f + offy, ViewWidth - 40, 1.0f)];
	[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
	[myScroll addSubview:lineImageView];
	
	UIImageView *mobileImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 298.0f + offy, ViewWidth - 40, 36.5f)];
	[mobileImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[myScroll addSubview:mobileImageView];
	
	
	UISubLabel *titleLabel4 = [UISubLabel labelWithTitle:@"联系电话:" frame:CGRectMake(25.0f, 303.0f + offy, 70.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	titleLabel4.textColor = FontColor333333;
	
	[myScroll addSubview:titleLabel4];
	
	
	
	//联系电话
	mobileTextField = [UISubTextField TextFieldWithFrame:CGRectMake(98.0f, 299.0f + offy, ViewWidth - 25, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入电话号码"];
	mobileTextField.font = FontSize32;
	mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
	mobileTextField.tag = 102;
	mobileTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	mobileTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	mobileTextField.delegate = self;
	[myScroll addSubview:mobileTextField];
	
	
	
	
	UIImageView *bottomButtonImgView=[UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight-100.0f, ViewWidth, 50.0f)];
	bottomButtonImgView.image=[UIImage imageNamed:@"PassBottomButtonBg.png"];
	[self.view addSubview:bottomButtonImgView];
	
	if (self.passengerAddressItem) {
		
		nameTextField.text = self.passengerAddressItem._name;
		addressTextView.text = self.passengerAddressItem._postAddress;
		mobileTextField.text = self.passengerAddressItem._mobile;
		postCodeTextField.text = self.passengerAddressItem._postCode;
        
        if (self.passengerAddressItem._province.length > 0) {
            [selectCity setTitle:[NSString stringWithFormat:@"%@/%@%@", self.passengerAddressItem._province, self.passengerAddressItem._city, self.passengerAddressItem._county] forState:UIControlStateNormal];
            [selectCity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            provinceName = self.passengerAddressItem._province;
            cityName = self.passengerAddressItem._city;
            countyName = self.passengerAddressItem._county;
        }
        
		UIImageView *doubleButtonImgView=[UIImageView ImageViewWithFrame:CGRectMake(2.0f, ViewHeight-92.0f+3, 313.0f, 38.0f)];
		doubleButtonImgView.image=[UIImage imageNamed:@"appInfoBottom.png"];
		[self.view addSubview:doubleButtonImgView];
		
        int offx = (ViewWidth - 296)/2;
		deleteButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(offx, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"DeleteAddRessButton.png"] target:self action:@selector(deleteAddress:)];
		[self.view addSubview:deleteButton];
		
		submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(offx + 150, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"EditPassengersButton.png"] target:self action:@selector(addAddress:)];
		[self.view addSubview:submitButton];
		

		
	}else {
		
		mobileTextField.text = [UserInfo sharedUserInfo].telePhone;
		submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake((ViewWidth - 146)/2, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"SubmitButton.png"] target:self action:@selector(addAddress:)];
		[self.view addSubview:submitButton];
	}
	
	self.textFieldArray = [NSArray arrayWithObjects:nameTextField,addressTextView,postCodeTextField,mobileTextField, nil];
//	cityData = [[NSDictionary alloc] init];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	[super viewDidLoad];
	if (self.passengerAddressItem){
		self.title = @"编辑邮寄地址";
	}else {
		self.title = @"新增邮寄地址";
	}
	
	self.navigationItem.rightBarButtonItem = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    ASIFormDataRequest * theRequest = [InterfaceClass getCityList];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCityListPaseredResult:) Delegate:self needUserType:NoMember];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	if (self.keyboardbar == nil) {
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}
	[keyboardbar showBar:textView];  //显示工具条
	return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (self.keyboardbar == nil) {
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}
	[keyboardbar showBar:textField];  //显示工具条
	return YES;
}


- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}
- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark 数据加载方法

- (void)addAddress:(id)sender {
	
	NSArray *parts = [nameTextField.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
	NSArray *filteredArray = [parts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
	nameTextField.text = [filteredArray componentsJoinedByString:@""];
	
	if (0 == [nameTextField.text length]) {
		[UIAlertView alertViewWithMessage:@"请输入姓名!" :@"提示"];
		
	}else if (![MyRegex checkname:nameTextField.text]) {
		
		[UIAlertView alertViewWithMessage:@"请输入正确的收件人姓名!" :@"提示"];
		
	}
    else if (provinceName.length == 0) {
        [UIAlertView alertViewWithMessage:@"请选择城市!" :@"提示"];
    }
    else if (0==[addressTextView.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入邮寄地址!" :@"提示"];
		
	}else if (0==[postCodeTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入邮政编码!" :@"提示"];
		
	}else if (![postCodeTextField.text isMatchedByRegex:ZIP_CODE]) {
		
		[UIAlertView alertViewWithMessage:@"请输入6位邮政编码!" :@"提示"];
		
	}else if (0==[mobileTextField.text length]) {
		
		[UIAlertView alertViewWithMessage:@"请输入联系电话!" :@"提示"];
		
	}else if ([mobileTextField.text length]< 11) {
		
		[UIAlertView alertViewWithMessage:@"请输入11位手机号码!" :@"提示"];
		
	}else if (![mobileTextField.text isMatchedByRegex:PHONENO]) {
		
		[UIAlertView alertViewWithMessage:@"请输入正确的联系电话!" :@"提示"];
		
	}else {
		
		if (self.passengerAddressItem)
		{
			ASIFormDataRequest * theRequest = [InterfaceClass updateUserAddress:[UserInfo sharedUserInfo].userID withId:self.passengerAddressItem._id withName:nameTextField.text withPostCode:postCodeTextField.text withPostalAddress:addressTextView.text withMobile:mobileTextField.text withProvince:provinceName withCity:cityName withCounty:countyName];
			[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUpdateUserAddressPaseredResult:) Delegate:self needUserType:Member];
		}else
		{
			ASIFormDataRequest * theRequest = [InterfaceClass addUserAddress:[UserInfo sharedUserInfo].userID withName:nameTextField.text withPostCode:postCodeTextField.text withPostalAddress:addressTextView.text withMobile:mobileTextField.text withProvince:provinceName withCity:cityName withCounty:countyName];
			[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUserAddressPaseredResult:) Delegate:self needUserType:NoMember];
		}
	}
}


//添加/编辑邮寄地址请求返回处理
- (void)onUserAddressPaseredResult:(NSDictionary *)dic
{
	PassengerAddressItem *infoItem = [[PassengerAddressItem alloc]init];
	infoItem._id = [NSString stringWithFormat:@"%d",[PassengerAddressDataResponse addPassengerAddress:dic]];
	infoItem._name = nameTextField.text;
	infoItem._postAddress = addressTextView.text;
	infoItem._mobile =  mobileTextField.text;
	infoItem._postCode =  postCodeTextField.text;
    infoItem._province = cityPickerView._selectProvince;
    infoItem._city = cityPickerView._selectCity;
    infoItem._county = cityPickerView._selectCounty;
	
	if (self.delegate && [self.delegate respondsToSelector:@selector(addAddressOverWithAddressItem:)]) {
		[self.delegate performSelector:@selector(addAddressOverWithAddressItem:) withObject:infoItem];
	}
	if (passengersAddressVC.sourceType == OrderSourceType) {
		
	
		if ([passengersAddressVC respondsToSelector:@selector(addAddressOverWithAddressItem:)]) {
			[passengersAddressVC performSelector:@selector(addAddressOverWithAddressItem:) withObject:infoItem];
		}

		[infoItem release];
		
		for (int i = 0; i < [self.navigationController.viewControllers count]-1; i++) {
			if ([[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[TicketOrderInfoViewController class]] ) {
				TicketOrderInfoViewController *passAddressVC =  [self.navigationController.viewControllers objectAtIndex:i];
				[self.navigationController popToViewController:passAddressVC animated:YES];
				return;
			}
			if ([[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberOrderPayInfoViewController class]] ) {
				MemberOrderPayInfoViewController *passAddressVC =  [self.navigationController.viewControllers objectAtIndex:i];
				[self.navigationController popToViewController:passAddressVC animated:YES];
				return;
			}
		}
	}else{
		[infoItem release];
		[self.navigationController popViewControllerAnimated:YES];
	}
	//[self.navigationController popViewControllerAnimated:YES];
	
}

- (void)onUpdateUserAddressPaseredResult:(NSDictionary *)dic
{
	
	PassengerAddressItem *infoItem = [[PassengerAddressItem alloc]init];
	infoItem._id = self.passengerAddressItem._id;
	infoItem._name = nameTextField.text;
	infoItem._postAddress = addressTextView.text;
	infoItem._mobile =  mobileTextField.text;
	infoItem._postCode =  postCodeTextField.text;
	
	//[passengersAddressVC.addressDataArray replaceObjectAtIndex:self.index withObject:infoItem];
	if (self.delegate && [self.delegate respondsToSelector:@selector(addAddressOverWithAddressItem:)]) {
		[self.delegate performSelector:@selector(addAddressOverWithAddressItem:) withObject:infoItem];
	}
	
	if ([self.passengerAddressItem._selected isEqualToString:@"1"]) {
		if ([passengersAddressVC respondsToSelector:@selector(addAddressOverWithAddressItem:)]) {
			[passengersAddressVC performSelector:@selector(addAddressOverWithAddressItem:) withObject:infoItem];
		}
	}
	
	[infoItem release];
	if ([self.passengerAddressItem._selected isEqualToString:@"1"]) {
		for (int i = 0; i < [self.navigationController.viewControllers count]-1; i++) {
			if ([[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[TicketOrderInfoViewController class]] ) {
				TicketOrderInfoViewController *passAddressVC =  [self.navigationController.viewControllers objectAtIndex:i];
				[self.navigationController popToViewController:passAddressVC animated:YES];
				return;
			}
			if ([[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberOrderPayInfoViewController class]] ) {
				MemberOrderPayInfoViewController *passAddressVC =  [self.navigationController.viewControllers objectAtIndex:i];
				[self.navigationController popToViewController:passAddressVC animated:YES];
				return;
			}
		}
	}
	[self.navigationController popViewControllerAnimated:YES];
}

//删除邮寄地址请求返回处理
- (void)onPaseredDelResult:(NSDictionary *)dic
{
	if (passengersAddressVC.addressDataArray.count==1) {
		[passengersAddressVC.addressDataArray removeObject:self.passengerAddressItem];
		[passengersAddressVC.a_tableView reloadData];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark 自定义方法
- (void)deleteAddress:(id)sender {
        
	UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认删除邮寄地址么?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
	[alert show];
	[alert release];
}

#pragma mark -
#pragma mark UITextField



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
	
	switch (textField.tag) {
		case 100:
		{
			
			textFieldMaxLenth = AddressUserNameLenght;
		}
			break;
		case 101:
		{
			
			textFieldMaxLenth = 6;
		}
			break;
		case 102:
		{
			
			textFieldMaxLenth = 11;
		}
			
			
			break;
		default:
			
			break;
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	NSString * textFieldStr = [[textView.text stringByReplacingCharactersInRange:range withString:text] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 100;
	
	if (textFieldStrLength>=textFieldMaxLenth)
	{
		textView.text =  [textFieldStr substringToIndex:textFieldMaxLenth];
		
		return  NO;
	}
	else
	{
		return YES;
	}
}

#pragma mark -
#pragma mark UIAlertView
- (void) alertView:(UIAlertView *)alertview clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if (buttonIndex==1) {
		ASIFormDataRequest * theRequest = [InterfaceClass deleteUserAddress:[UserInfo sharedUserInfo].userID withIds:[NSString stringWithFormat:@"%@", self.passengerAddressItem._id]];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredDelResult:) Delegate:self needUserType:Member];
	}
	
	
}

- (void)selectCityInfo
{
    NSLog(@"城市选择");
    [self.keyboardbar HiddenKeyBoard];
    if (cityPickerView == nil)
    {
        NSArray *cityArr = [self._cityData objectForKey:@"provinceList"];
        cityPickerView = [[CityPickerView alloc] initWithTitle:@"城市选择" delegate:self data:cityArr withProvince:provinceName withCity:cityName withCounty:countyName];
        cityPickerView.tag = 0;
    }
    [cityPickerView showInView:self.view];
}

- (void)onCityListPaseredResult:(NSDictionary *)dic
{
    NSString *codeState = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    
    NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *doucumentsDirectiory = [storeFilePath objectAtIndex:0];
    NSString *plistPath =[doucumentsDirectiory stringByAppendingPathComponent:@"cityInfo.json"];
    
    if ([codeState isEqualToString:@"0"]) {
        
        
        NSFileManager *file = [NSFileManager defaultManager];
        if ([file fileExistsAtPath:plistPath])
        {
            NSLog(@"you");
        }
        else //若沙盒中没有
        {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"cityInfo" ofType:@"json"];
            [fileManager createFileAtPath:bundle contents:nil attributes:nil];
        }
        
        NSString *data = [NSString stringWithFormat:@"%@", dic];
        BOOL result = [data writeToFile:plistPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        if (!result) {
            NSLog(@"写入失败");
        }
        
        self._cityData = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
    else {
        self._cityData = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [selectCity setTitle:cityPickerView._selectItem forState:UIControlStateNormal];
        [selectCity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        provinceName = cityPickerView._selectProvince;
        cityName = cityPickerView._selectCity;
        countyName = cityPickerView._selectCounty;
    }
}
@end
