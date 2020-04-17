//
//  OnLineQuestionViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OnLineQuestionViewController.h"
#import "OnLineQuestionDataResponse.h"
#import "MyRegex.h"

@implementation OnLineQuestionViewController
@synthesize textFieldArray,keyboardbar;
-(void)dealloc
{
	self.textFieldArray = nil;
	self.keyboardbar = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark View系统方法

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	[super loadView];
	
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 10.0f, ViewWidth-20.0f, 7.0f)] ;
	[topView setImage:[UIImage imageNamed:@"MemberLoginTop.png"]];
	[self.view addSubview:topView];
	
	editorBgView = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 10.0f, ViewWidth-20.0f,ViewHeight-130.0f)];
	editorBgView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:editorBgView];
	
	
	UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"您的意见将帮助我们改进产品与服务" frame:CGRectMake(20.0f, 10.0f, 220.0f, 20.0f) font:FontBlodSize26 alignment:NSTextAlignmentLeft];
	titleLabel1.textColor = FontColor696969;
	[editorBgView addSubview:titleLabel1];
	
	
	UIImageView *addressImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 40.0f, ViewWidth-45, 81.5f)];
	[addressImageView setImage:[UIImage imageNamed:@"MemberAddressTextBox.png"]];
	[editorBgView addSubview:addressImageView];
	
        UISubLabel *titleLabel2 = [UISubLabel labelWithTitle:@"意  见: " frame:CGRectMake(20.0f, 47.0f, 60.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	titleLabel2.textColor = FontColor333333;
	[editorBgView addSubview:titleLabel2];
	
	
	//意见
	problemTextView = [[UISubTextView alloc] initWithFrame:CGRectMake(72.0f, 40.0f, ViewWidth-120, 80.0f)];
    
	problemTextView.tag = 100;
	problemTextView.delegate = self;
	problemTextView.returnKeyType = UIReturnKeyDefault;	
	problemTextView.font = [UIFont fontWithName:@"Helvetica" size:16.5f];
	problemTextView.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
	problemTextView.backgroundColor = [UIColor clearColor];
        [editorBgView addSubview:problemTextView];
	
	
        UIImageView *lineImageView =  [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 140.0f, ViewWidth-45, 1.0f)];
	[lineImageView setImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]];
	[editorBgView addSubview:lineImageView];
	
	
	UIImageView *telephoneImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 160.0f, ViewWidth-45, 36.5f)];
	[telephoneImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[editorBgView addSubview:telephoneImageView];
	
        UISubLabel *titleLabel3 = [UISubLabel labelWithTitle:@"手  机: " frame:CGRectMake(20.0f, 167.0f, 70.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	titleLabel3.textColor = FontColor333333;
	[editorBgView addSubview:titleLabel3];
	
	//手机
	telephoneTextField = [UISubTextField TextFieldWithFrame:CGRectMake(73.0f, 163.0f, ViewWidth-130, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入真实手机号(可填)"];
	telephoneTextField.backgroundColor = [UIColor clearColor];
	telephoneTextField.font = FontSize32;
	telephoneTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	telephoneTextField.keyboardType = UIKeyboardTypeNumberPad;
	telephoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	telephoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	telephoneTextField.tag = 101;
	telephoneTextField.text = [UserInfo sharedUserInfo].telePhone;
	telephoneTextField.delegate = self;
	[editorBgView addSubview:telephoneTextField];
	
	
	UIImageView *emailImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 215.0f, ViewWidth-45, 36.5f)];
	[emailImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[editorBgView addSubview:emailImageView];
	
        UISubLabel *titleLabel4 = [UISubLabel labelWithTitle:@"邮  箱: " frame:CGRectMake(20.0f, 222.0f, 70.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	titleLabel4.textColor = FontColor333333;
	[editorBgView addSubview:titleLabel4];
	
	//邮箱
	emailTextField = [UISubTextField TextFieldWithFrame:CGRectMake(73.0f, 218.0f, ViewWidth-130, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入真实邮箱(可填)"];
	emailTextField.font = FontSize30;
	emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
	emailTextField.tag = 102;
	emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	emailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	emailTextField.delegate = self;
    emailTextField.text = [UserInfo sharedUserInfo].email;
	[editorBgView addSubview:emailTextField];
	
	submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(80.0f, ViewHeight-180.0f, ViewWidth-180, 38.0f) backImage:[UIImage imageNamed:@"ProposalSubmit.png"] target:self action:@selector(submit:)];
	[editorBgView addSubview:submitButton];
	
	
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 10.0f, ViewWidth-20.0f, editorBgView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"MemberLoginCenter.png"]];
	[self.view addSubview:centerView];
        [self.view addSubview:editorBgView];
	
	
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, centerView.frame.size.height+10.0f, ViewWidth-20.0f, 7.0f)];
	[bottom setImage:[UIImage imageNamed:@"MemberLoginBottom.png"]];
	[self.view addSubview:bottom];
	
	[editorBgView release];
	
	callButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(75.0f, ViewHeight-90.0f, ViewWidth-145, 38.0f) backImage:[UIImage imageNamed:@"CallSubmit.png"] target:self action:@selector(call:)];
	[self.view addSubview:callButton];
	
	self.textFieldArray = [NSArray arrayWithObjects:problemTextView,telephoneTextField,emailTextField, nil];
	
}
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"意见反馈";
	// Do any additional setup after loading the view.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
	
	switch (textField.tag) {
		case 101:
		{

			textFieldMaxLenth = 11;
		}
			break;
		case 102:
		{

			textFieldMaxLenth = 50;
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
	int textFieldMaxLenth = 350;
	
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (self.keyboardbar == nil) {
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}
	[keyboardbar showBar:textField];  //显示工具条 
	return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	if (self.keyboardbar == nil) {
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}
	[keyboardbar showBar:textView];  //显示工具条 
	return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
	int maxLenth = 100;
	if (textView.text.length > maxLenth) {
		return;
	}
}
- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}



#pragma mark -
#pragma mark 数据加载方法

- (void)submit:(id)sender {
	
//	if (0 == [problemTextView.text length]) {
//		[UIAlertView alertViewWithMessage:@"请留下您宝贵的意见!" :@"提示"];
//		
//	}else if (0==[telephoneTextField.text length]) {
//		
//		[UIAlertView alertViewWithMessage:@"请输入手机号!" :@"提示"];
//		
//	}else if (11 > [telephoneTextField.text length]) {
//		
//		[UIAlertView alertViewWithMessage:@"请输入11位手机号码!" :@"提示"];
//		
//	}else if (![telephoneTextField.text isMatchedByRegex:PHONENO]) {
//		
//		[UIAlertView alertViewWithMessage:@"请输入正确的手机号!" :@"提示"];
//		
//	}else if (0==[emailTextField.text length]) {
//		
//		[UIAlertView alertViewWithMessage:@"请输入邮箱地址!" :@"提示"];
//		
//	}else if (![emailTextField.text isMatchedByRegex:EMAIL] ) { 
//		
//		[UIAlertView alertViewWithMessage:@"请输入有效的邮箱!" :@"提示"];
//		
//	}

    if (0 == [problemTextView.text length]) {
        [UIAlertView alertViewWithMessage:@"请留下您宝贵的意见!" :@"提示"];
        return;
    }

    if (([telephoneTextField.text length] >0)&&([telephoneTextField.text length]<11)){
        [UIAlertView alertViewWithMessage:@"请输入11位手机号码!" :@"提示"];
        return;
    }
    if (([telephoneTextField.text length]==11)&&(![telephoneTextField.text isMatchedByRegex:PHONENO])) {
        [UIAlertView alertViewWithMessage:@"请输入正确的手机号!" :@"提示"];
        return;
    }
    if (([emailTextField.text length]>0)&&(![emailTextField.text isMatchedByRegex:EMAIL] )) {
        		
        [UIAlertView alertViewWithMessage:@"请输入有效的邮箱!" :@"提示"];
        return;
    }
		
    ASIFormDataRequest * theRequest = [InterfaceClass submitAdvise:[UserInfo sharedUserInfo].userID withProblem:problemTextView.text? problemTextView.text:@"" withMobilNumber:telephoneTextField.text?telephoneTextField.text:@"" withEmail:emailTextField.text?emailTextField.text:@""];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onsubmitAdvisePaseredResult:) Delegate:self needUserType:Default];

}


//添加请求返回处理
- (void)onsubmitAdvisePaseredResult:(NSDictionary *)dic
{
	NSString *messsage = [OnLineQuestionDataResponse submitAdvise:dic];
	problemTextView.text = @"";
	telephoneTextField.text = @"";
	emailTextField.text = @"";
	
	[UIAlertView alertViewWithMessage:messsage];
	
	//[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark UITextField





//拨打客服电话
-(void)call:(id)sender
{
    [self callTel:@"400-6858-999"];
}

@end
