//
//  PickUpPersonDetailViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 14-4-15.
//
//

#import "PickUpPersonDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MyRegex.h"
#import "PassengerInfoDataResponse.h"
#import "PickUpPersonListViewController.h"

@interface PickUpPersonDetailViewController ()
- (void)addPassenger:(id)sender;
- (void)deletePassenger:(id)sender;
- (void)loadRequestData;

@end

@implementation PickUpPersonDetailViewController
@synthesize passengerInfoData;
@synthesize passengerInfoItem;
@synthesize index;
@synthesize keyboardbar,textFieldArray;
@synthesize delegate;

-(void)dealloc
{
	self.index = 0;
	self.passengerInfoData = nil;
        self.keyboardbar = nil;
        self.textFieldArray = nil;
        self.delegate = nil;
	
	[super dealloc];
}


#pragma mark -
#pragma mark View系统方法

- (void)loadView{
	
	[super loadView];
	
	editorBgView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,ViewHeight-100.0f)];
	editorBgView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:editorBgView];
	
	UIImageView *nameImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 60.0f, ViewWidth - 40, 36.5f)];
	[nameImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[editorBgView addSubview:nameImageView];
	
	UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"姓名:" frame:CGRectMake(25.0f, 67.0f, 80.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	titleLabel1.textColor = FontColor333333;
	[editorBgView addSubview:titleLabel1];
	
	//乘机人姓名
	nameTextField = [UISubTextField TextFieldWithFrame:CGRectMake(102.0f, 64.0f, ViewWidth - 140, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"中文或英文(TOM/BUSH)"];
	nameTextField.font = FontSize32;
	nameTextField.tag = 100;
	nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
	nameTextField.delegate = self;
	nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	[editorBgView addSubview:nameTextField];
	

	

	
	certNumView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,140.0f,ViewWidth-20.0f,115.0f)];
	certNumView.backgroundColor = [UIColor clearColor];
	[editorBgView addSubview:certNumView];
	
	UIImageView *certNumImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 27.0f, ViewWidth - 40, 36.5f)];
	[certNumImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[certNumView addSubview:certNumImageView];
	
	
	UISubLabel *titleLabel4 = [UISubLabel labelWithTitle:@"手机号码:" frame:CGRectMake(23.0f, 34.0f, 80.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	titleLabel4.textColor = FontColor333333;
	[certNumView addSubview:titleLabel4];
	
	
	certNumTextField = [UISubTextField TextFieldWithFrame:CGRectMake(102.0f, 31.0f, ViewWidth - 140, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入手机号码"];
	certNumTextField.font = FontSize32;
	certNumTextField.keyboardType = UIKeyboardTypeNumberPad;
	certNumTextField.tag = 101;
	certNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	certNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	certNumTextField.delegate = self;
	[certNumView addSubview:certNumTextField];
	[certNumView release];
	
	
	UIImageView *bottomButtonImgView=[UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight-100.0f, ViewWidth, 50.0f)];
	bottomButtonImgView.image=[UIImage imageNamed:@"PassBottomButtonBg.png"];
	[self.view addSubview:bottomButtonImgView];
	
	//	int currentYearValue = [self.currentYear year:[NSDate date]];
	//	int startYear = currentYearValue - 12;
	//	NSString *stringYear = [NSString stringWithFormat:@"%d%@",startYear,@"-01-01"];
	
        if (self.passengerInfoItem) {
		nameTextField.text = self.passengerInfoItem._name;
		certNumTextField.text = self.passengerInfoItem._phone;
				
        int offx = (ViewWidth - 296)/2;
		deleteButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(offx, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"DeletePickButton.png"] target:self action:@selector(deletePassenger:)];
		[self.view addSubview:deleteButton];
		
		submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(offx + 150, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"EditPassengersButton.png"] target:self action:@selector(addPassenger:)];
		[self.view addSubview:submitButton];
		
		
		
		
	}else {
		submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake((ViewWidth - 146)/2, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"SubmitButton.png"] target:self action:@selector(addPassenger:)];
		[self.view addSubview:submitButton];
	}
	
	self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField, nil];
	
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	if (self.passengerInfoItem){
		self.title = @"编辑联系人";
	}else {
		self.title = @"新增联系人";
	}
	self.navigationItem.rightBarButtonItem = nil;
}


- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}



#pragma mark -
#pragma mark 数据加载方法



- (void)addPassenger:(id)sender {
	
	
	NSArray *parts = [nameTextField.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
	NSArray *filteredArray = [parts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
	nameTextField.text = [filteredArray componentsJoinedByString:@""];
	
	NSArray *certParts = [certNumTextField.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
	NSArray *certFilteredArray = [certParts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
	certNumTextField.text = [certFilteredArray componentsJoinedByString:@""];
	
	if (0 == [nameTextField.text length]) {
		[UIAlertView alertViewWithMessage:@"请输入姓名!" :@"提示"];
		return;
		
	}else if (![MyRegex checkname:nameTextField.text]) {
		[UIAlertView alertViewWithMessage:@"请输入正确的联系人姓名!" :@"提示"];
		return;
	}else if ([nameTextField.text isMatchedByRegex:ZHONGWEN_XINGMING]) {
		if ([nameTextField.text length] > 11) {
			[UIAlertView alertViewWithMessage:@"联系人姓名长度不能超过11个汉字!" :@"提示"];
			return;
		}
		
	}else if (![nameTextField.text isMatchedByRegex:ZHONGWEN_XINGMING]) {
		if ([nameTextField.text length] <= AirUserNameLenght) {
			if ([nameTextField.text length] >= 12) {
				if([[nameTextField.text substringWithRange:NSMakeRange(11, 1)] isMatchedByRegex:ZHONGWEN_XINGMING]){
					[UIAlertView alertViewWithMessage:@"联系人姓名长度不能超过11个汉字!" :@"提示"];
					return;
					
				}
			}
		}
	}
	
	if (0 == [certNumTextField.text length]) {
		[UIAlertView alertViewWithMessage:@"请填写手机号码!" :@"提示"];
		return;
	}
	else if ([certNumTextField.text length] < 11) {
		[UIAlertView alertViewWithMessage:@"请输入11位手机号码!" :@"提示"];
		return;
	
	}else if (![certNumTextField.text isMatchedByRegex:PHONENO]) {
			[UIAlertView alertViewWithMessage:@"请输入正确的手机号码!" :@"提示"];
			return;
	}
	

	
	[self loadRequestData];
	
	
}


- (void)loadRequestData
{
	if (self.passengerInfoItem) {
		ASIFormDataRequest * theRequest = [InterfaceClass updatePick:[UserInfo sharedUserInfo].userID ids:self.passengerInfoItem._id name:nameTextField.text phone:certNumTextField.text];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onEditPaseredResult:) Delegate:self needUserType:Member];
		
	}else {

		ASIFormDataRequest * theRequest = [InterfaceClass addPick:[UserInfo sharedUserInfo].userID name:nameTextField.text phone:certNumTextField.text];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onAddPaseredResult:) Delegate:self needUserType:NoMember];
		
	}
}

- (void)deletePassenger:(id)sender {
	
	UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认删接乘机人么?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
	alert.tag = 202;
	[alert show];
	[alert release];
	
	
}



//添加请求返回处理
- (void)onAddPaseredResult:(NSDictionary *)dic
{
	
	PickPersonInfoItem *infoItem = [[PickPersonInfoItem alloc]init];
	infoItem._id = [NSString stringWithFormat:@"%d",[PassengerInfoDataResponse addPickPerson:dic]];
	infoItem._name = nameTextField.text;
	infoItem._phone = certNumTextField.text;
	infoItem._selected = @"0";
	if (self.delegate && [self.delegate respondsToSelector:@selector(addPickUpPersonDelegateWithItem:)]) {
		[self.delegate performSelector:@selector(addPickUpPersonDelegateWithItem:) withObject:infoItem];
	}
	
	[infoItem release];
	
	[self.navigationController popViewControllerAnimated:YES];
	
	//[passengersInfoVC.p_tableView reloadData];
	
}
-(void) addPickUpPersonDelegateWithItem :(id)parm{}
//修改请求返回处理
- (void)onEditPaseredResult:(NSDictionary *)dic
{
	PickPersonInfoItem *infoItem = [[PickPersonInfoItem alloc]init];
	infoItem._id = self.passengerInfoItem._id;
	infoItem._name = nameTextField.text;
	infoItem._phone = certNumTextField.text;
	if (self.delegate && [self.delegate respondsToSelector:@selector(addPickUpPersonDelegateWithItem:)]) {
		[self.delegate performSelector:@selector(addPickUpPersonDelegateWithItem:) withObject:infoItem];
	}
	[infoItem release];
	[self.navigationController popViewControllerAnimated:YES];
	
}

//删除请求返回处理
- (void)onDelPaseredResult:(NSDictionary *)dic
{
	if (passengersInfoVC.passengersInfoArray.count==1) {
		[passengersInfoVC.passengersInfoArray removeObject:self.passengerInfoItem];
		[passengersInfoVC.p_tableView reloadData];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark 自定义方法

-(void)sureButtonClick:(id)instance
{
	[nameTextField resignFirstResponder];
	[keyboardbar HiddenKeyBoard];
}

-(void)cancelButtonClick
{
	[nameTextField resignFirstResponder];
	[keyboardbar HiddenKeyBoard];
}


#pragma -mark textField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (self.keyboardbar == nil) {
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}else {
		//		self.keyboardbar.textFields = self.textFieldArray;
		[self.keyboardbar setTextFields:self.textFieldArray];
	}
	[keyboardbar showBar:textField];  //显示工具条
	
	
	return TRUE;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
	
	switch (textField.tag) {
		case 100:
		{
			
			textFieldMaxLenth = AirUserNameLenght;
		}
			break;
		case 101:
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




#pragma mark -
#pragma mark UIAlertView
- (void) alertView:(UIAlertView *)alertview clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if (buttonIndex==1) {
		ASIFormDataRequest * theRequest = [InterfaceClass deletePick:[UserInfo sharedUserInfo].userID ids:self.passengerInfoItem._id];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelPaseredResult:) Delegate:self needUserType:Member];
		
	}
}
@end
