//
//  EditPersonnelViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EditPersonnelViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MyRegex.h"
#import "HotelPassengerDataResponse.h"
#import "PersonnelListViewController.h"
#import "NSDate+convenience.h"
@interface EditPersonnelViewController ()
- (void)addPassenger:(id)sender;
- (void)deletePassenger:(id)sender;
- (void)loadRequestData;
@end

@implementation EditPersonnelViewController

@synthesize passengerInfoData;
@synthesize passengerInfoItem,menberBirthday;
@synthesize index;
@synthesize delegate;
@synthesize textFieldArray;
@synthesize keyboardbar;
#pragma mark -
#pragma mark View系统方法

- (void)loadView{
	
	[super loadView];
	
	editorBgView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,0.0f,ViewWidth,ViewHeight-100.0f)];
	editorBgView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:editorBgView];
        [editorBgView release];
	
	UIImageView *nameImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 40.0f, 280.0f, 36.5f)];
	[nameImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[editorBgView addSubview:nameImageView];
	
	UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"入住人姓名:" frame:CGRectMake(25.0f, 46.0f, 80.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	titleLabel1.textColor = FontColor333333;
	[editorBgView addSubview:titleLabel1];
	
	//入住人姓名
	nameTextField = [UISubTextField TextFieldWithFrame:CGRectMake(112.0f, 43.0f, 180.0f, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"中文或英文(TOM/BUSH)"];
	nameTextField.font = FontSize32;
	nameTextField.keyboardType = UIKeyboardTypeDefault;
	nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
        nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
	nameTextField.tag = 100;
	nameTextField.delegate = self;
	[editorBgView addSubview:nameTextField];
	
	self.textFieldArray = [NSArray arrayWithObjects:nameTextField, nil];

	submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"" frame:CGRectMake(85.0f, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"HotelPersonne4.png"] target:self action:@selector(addPassenger:)];
	[self.view addSubview:submitButton];
	
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"新增入住人";	
}


- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

-(void)dealloc
{
	self.index = 0;
	self.menberBirthday = nil;
	self.passengerInfoData = nil;
        self.delegate = nil;
	self.textFieldArray = nil;
	self.keyboardbar = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark 数据加载方法



- (void)addPassenger:(id)sender {
	
	NSArray *parts = [nameTextField.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];  
	NSArray *filteredArray = [parts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];  
	nameTextField.text = [filteredArray componentsJoinedByString:@""]; 
	
	if (0 == [nameTextField.text length]) {
		[UIAlertView alertViewWithMessage:@"请输入姓名!" :@"提示"];
		
		
	}else if (![MyRegex checkname:nameTextField.text]) {
		[UIAlertView alertViewWithMessage:@"请输入正确的姓名!" :@"提示"];
		
	}else {
        if ([[UserInfo sharedUserInfo].userID isEqualToString:@""]) {
            HotelPersonnelInfo *infoItem = [[HotelPersonnelInfo alloc]init];
            infoItem._name = nameTextField.text;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(addHotelPersonOverWithPersonItem:)]) {
                [self.delegate performSelector:@selector(addHotelPersonOverWithPersonItem:) withObject:infoItem];
            }
            [infoItem release];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [self loadRequestData];
        }
	}
	
}

- (void)loadRequestData
{
	ASIFormDataRequest * theRequest = [InterfaceClass addCheckPersonnel:[UserInfo sharedUserInfo].userID withName:nameTextField.text];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onaddCheckPersonnelPaseredResult:) Delegate:self needUserType:NoMember];
	
}

- (void)deletePassenger:(id)sender {
	
	UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定删入住人么?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
	[alert show];
	[alert release];
	
	
}



//添加请求返回处理
- (void)onaddCheckPersonnelPaseredResult:(NSDictionary *)dic
{

	HotelPersonnelInfo *infoItem = [[HotelPersonnelInfo alloc]init];
	infoItem._id = [NSString stringWithFormat:@"%d",[HotelPassengerDataResponse addCheckPersonnel:dic]];
	infoItem._name = nameTextField.text;

	//添加到第一个
//	[passengersInfoVC.passengersInfoArray addObject:infoItem];
//	[passengersInfoVC.p_tableView reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addHotelPersonOverWithPersonItem:)]) {
        [self.delegate performSelector:@selector(addHotelPersonOverWithPersonItem:) withObject:infoItem];
    }
    
        [infoItem release];
    
	[self.navigationController popViewControllerAnimated:YES];
	
}


//删除请求返回处理
- (void)onDelPaseredResult:(NSDictionary *)dic
{
	[passengersInfoVC.passengersInfoArray removeObject:self.passengerInfoItem];
	[passengersInfoVC.p_tableView reloadData];
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark 自定义方法





#pragma -mark textField delegate  

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




#pragma mark -
#pragma mark UIAlertView
- (void) alertView:(UIAlertView *)alertview clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if (buttonIndex==1) {
		ASIFormDataRequest * theRequest = [InterfaceClass deleteCheckPersonnel:self.passengerInfoItem._id];
		[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelPaseredResult:) Delegate:self needUserType:Member];
	}
	
	
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
	
	switch (textField.tag) {
		case 100:
		{

			textFieldMaxLenth = HotelUserNameLenght;
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

@end
