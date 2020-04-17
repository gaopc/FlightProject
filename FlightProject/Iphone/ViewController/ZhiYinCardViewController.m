//
//  ZhiYinCardViewController.m
//  FlightProject
//
//  Created by xiemengyue on 13-5-6.
//
//

#import "ZhiYinCardViewController.h"
#import "CustomUISwitch.h"
#import "KeyBoardTopBar.h"
#import "MyRegex.h"
#import "InterfaceClass.h"

@interface ZhiYinCardViewController ()

@end

@implementation ZhiYinCardViewController
@synthesize textFieldArray,keyboardbar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView{
	
	[super loadView];
    long origin_y = 10.0f;
	
	UIImageView *topView = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, 7.0f)] ;
	[topView setImage:[UIImage imageNamed:@"MemberLoginTop.png"]];
	[self.view addSubview:topView];
	origin_y += topView.frame.size.height;
	
	registerView = [[UIScrollView alloc]initWithFrame:CGRectMake(10.0f ,origin_y,ViewWidth-20.0f,ViewHeight-120.0f)];
    registerView.delegate = self;
	registerView.backgroundColor = [UIColor clearColor];
	registerView.contentSize = CGSizeMake(ViewWidth-20.0f, 460);
//姓名
	UIImageView *nameImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 3.0f, 275.5f, 35.0f)];
	[nameImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[registerView addSubview:nameImageView];
	
	[registerView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 16.0f, 12.0f, 14.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
    
    UISubLabel *nameTitle = [UISubLabel labelWithTitle:@"姓      名 :" frame:CGRectMake(28.0f, 5.0f, 80.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	nameTitle.textColor = FontColor333333;
	[registerView addSubview:nameTitle];
    
    nameTextField = [UISubTextField TextFieldWithFrame:CGRectMake(100.0f, 8.0f, 192.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"中文或英文（Tom/Bush）"];
	nameTextField.font = FontSize32;
	nameTextField.tag = 100;
	nameTextField.delegate = self;
	nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; 
	[registerView addSubview:nameTextField];
    
//性别
    [registerView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 55.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
    
    UISubLabel *sexTitle = [UISubLabel labelWithTitle:@"性      别 :" frame:CGRectMake(28.0f, 44.0f, 80.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	sexTitle.textColor = FontColor333333;
	[registerView addSubview:sexTitle];
    
    sexNan = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(110.0f, 49, 20.0f, 20.0f) backImage:[UIImage imageNamed:@"Radio_B.png"] target:self action:@selector(selectSex:)];
	[registerView addSubview:sexNan];
    
    [registerView addSubview:[UISubLabel labelWithTitle:@"男" frame:CGRectMake(135.0f, 44.0f, 30.0f, 30.0f) font:FontSize30 color:[UIColor blackColor] alignment:NSTextAlignmentLeft]];
    
    sexNv = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"" frame:CGRectMake(210.0f, 49.0f, 20.0f, 20.0f) backImage:[UIImage imageNamed:@"Radio_A.png"] target:self action:@selector(selectSex:)];
	[registerView addSubview:sexNv];
    
    [registerView addSubview:[UISubLabel labelWithTitle:@"女" frame:CGRectMake(235.0f, 44.0f, 30.0f, 30.0f) font:FontSize30 color:[UIColor blackColor] alignment:NSTextAlignmentLeft]];
    
//证件类型
    [registerView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 92.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
    
	UISubLabel *idCardTitle = [UISubLabel labelWithTitle:@"证件类型:" frame:CGRectMake(28.0f, 81.0f, 80.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	idCardTitle.textColor = FontColor333333;
	[registerView addSubview:idCardTitle];
    
    
    selectType1 = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"" frame:CGRectMake(110.0f, 86, 20.0f, 20.0f) backImage:[UIImage imageNamed:@"Radio_B.png"] target:self action:@selector(selectType:)];
    [registerView addSubview:selectType1];
    
    [registerView addSubview:[UISubLabel labelWithTitle:@"身份证" frame:CGRectMake(135.0f, 81.0f, 50.0f, 30.0f) font:FontSize30 color:[UIColor blackColor] alignment:NSTextAlignmentLeft]];
    
    selectType2 = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(210.0f, 86.0f, 20.0f, 20.0f) backImage:[UIImage imageNamed:@"Radio_A.png"] target:self action:@selector(selectType:)];
	[registerView addSubview:selectType2];
    
    [registerView addSubview:[UISubLabel labelWithTitle:@"护照" frame:CGRectMake(235.0f, 81.0f, 50.0f, 30.0f) font:FontSize30 color:[UIColor blackColor] alignment:NSTextAlignmentLeft]];

    
//证件号码
    UIImageView *idCardNumImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 117.0f, 275.5f, 35.0f)];
	[idCardNumImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[registerView addSubview:idCardNumImageView];
	
	[registerView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 130.0f, 12.0f, 14.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
    
    UISubLabel *idCardNumTitle = [UISubLabel labelWithTitle:@"证件号码:" frame:CGRectMake(28.0f, 119.0f, 80.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	nameTitle.textColor = FontColor333333;
	[registerView addSubview:idCardNumTitle];
    
    idCardNumTextField = [UISubTextField TextFieldWithFrame:CGRectMake(100.0f, 122.0f, 192.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入证件号码"];
	idCardNumTextField.font = FontSize32;
	idCardNumTextField.keyboardType = UIKeyboardTypeASCIICapable;
	idCardNumTextField.tag = 200;
	idCardNumTextField.delegate = self;
	idCardNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	idCardNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	[registerView addSubview:idCardNumTextField];
    
    
//出生日期
    
    UIImageView *birthdayImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 163.0f, 275.5f, 35.0f)];
	[birthdayImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[registerView addSubview:birthdayImageView];
    
    [registerView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 176.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
    
	UISubLabel *birthdayTitle = [UISubLabel labelWithTitle:@"出生日期:" frame:CGRectMake(28.0f, 165.0f, 80.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	birthdayTitle.textColor = FontColor333333;
	[registerView addSubview:birthdayTitle];
    
    birthdayTextField = [UISubTextField TextFieldWithFrame:CGRectMake(100.0f, 169.0f, 192.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请选择出生日期"];
	birthdayTextField.font = FontSize32;
	birthdayTextField.keyboardType = UIKeyboardTypeNumberPad;
	birthdayTextField.tag = 300;
	birthdayTextField.delegate = self;
	birthdayTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	birthdayTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    birthdayTextField.autocorrectionType = UITextAutocorrectionTypeNo;
	[registerView addSubview:birthdayTextField];
    
//手机号码
    UIImageView *telephoneImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 206.0f, 275.5f, 35.0f)];
	[telephoneImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[registerView addSubview:telephoneImageView];
    
    [registerView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 219.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
    
	UISubLabel *telephoneTitle = [UISubLabel labelWithTitle:@"手机号码:" frame:CGRectMake(28.0f, 208.0f, 80.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	telephoneTitle.textColor = FontColor333333;
	[registerView addSubview:telephoneTitle];
    
	telephoneTextField = [UISubTextField TextFieldWithFrame:CGRectMake(100.0f, 211.0f, 192.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入11位有效手机号码"];
	telephoneTextField.font = FontSize32;
	telephoneTextField.keyboardType = UIKeyboardTypeNumberPad;
	telephoneTextField.tag = 400;
	telephoneTextField.delegate = self;
	telephoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	telephoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	[registerView addSubview:telephoneTextField];
	

// 电话号码
    UIImageView *phoneImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 249.0f, 275.5f, 35.0f)];
	[phoneImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[registerView addSubview:phoneImageView];
    
    
    UISubLabel *phoneTitle = [UISubLabel labelWithTitle:@"电话号码:" frame:CGRectMake(28.0f, 251.0f, 80.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	phoneTitle.textColor = FontColor333333;
	[registerView addSubview:phoneTitle];
    
	phoneTextField = [UISubTextField TextFieldWithFrame:CGRectMake(100.0f, 254.0f, 192.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@""];
	phoneTextField.font = FontSize32;
	phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
	phoneTextField.tag = 500;
	phoneTextField.delegate = self;
	phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	[registerView addSubview:phoneTextField];
    
//邮箱
    UIImageView *emailImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 292.0f, 275.5f, 35.0f)];
	[emailImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[registerView addSubview:emailImageView];
    
    
    UISubLabel *emailTitle = [UISubLabel labelWithTitle:@"邮       箱:" frame:CGRectMake(28.0f, 294.0f, 80.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	emailTitle.textColor = FontColor333333;
	[registerView addSubview:emailTitle];
    
	emailTextField = [UISubTextField TextFieldWithFrame:CGRectMake(100.0f, 297.0f, 192.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@""];
	emailTextField.font = FontSize32;
	emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
	emailTextField.tag = 600;
	emailTextField.delegate = self;
	emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	emailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	[registerView addSubview:emailTextField];
    
    
    
//邮编
	UIImageView *zipCodeImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 335.0f, 275.5f, 35.0f)];
	[zipCodeImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[registerView addSubview:zipCodeImageView];
    
    [registerView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 348.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
    
	UISubLabel *zipCodeTitle = [UISubLabel labelWithTitle:@"邮       编:" frame:CGRectMake(28.0f, 337.0f, 80.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	zipCodeTitle.textColor = FontColor333333;
	[registerView addSubview:zipCodeTitle];
    
	zipCodeTextField = [UISubTextField TextFieldWithFrame:CGRectMake(100.0f, 340.0f, 192.0f, 25.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@""];
	zipCodeTextField.font = FontSize32;
	zipCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
	zipCodeTextField.tag = 700;
	zipCodeTextField.delegate = self;
	zipCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	zipCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	[registerView addSubview:zipCodeTextField];
	
//邮寄地址
    UIImageView *addressImageView = [UIImageView ImageViewWithFrame:CGRectMake(12.0f, 378.0f, 275.5f, 85.0f)];
	[addressImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
	[registerView addSubview:addressImageView];
    
    [registerView addSubview:[UISubLabel labelWithTitle:@"*" frame:CGRectMake(18.0f, 394.0f, 12.0f, 15.0f) font:FontSize32 color:[UIColor redColor] alignment:NSTextAlignmentLeft]];
    
	UISubLabel *addressTitle = [UISubLabel labelWithTitle:@"邮寄地址:" frame:CGRectMake(28.0f, 383.0f, 80.0f, 30.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
	addressTitle.textColor = FontColor333333;
	[registerView addSubview:addressTitle];
    

    addressTextView = [[UISubTextView alloc] initWithFrame:CGRectMake(100.0f, 381.0f, 192.0f, 80.0f)];
	addressTextView.tag = 800;
	addressTextView.backgroundColor = [UIColor clearColor];
	addressTextView.delegate = self;
	addressTextView.font = [UIFont fontWithName:@"Helvetica" size:16.5f];
	[registerView addSubview:addressTextView];
    
    
    
	UIImageView *centerView = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, registerView.frame.size.height)];
	[centerView setImage:[UIImage imageNamed:@"MemberLoginCenter.png"]];
	[self.view addSubview:centerView];
	[self.view addSubview:registerView];
	[registerView release];

	origin_y += centerView.frame.size.height;
	UIImageView *bottom = [UIImageView ImageViewWithFrame:CGRectMake(8.0f, origin_y, ViewWidth-16.0f, 7.0f)];
	[bottom setImage:[UIImage imageNamed:@"MemberLoginBottom.png"]];
	[self.view addSubview:bottom];
//提交
	submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(50.0f, ViewHeight-90.0f, 225.5f, 45.0f) backImage:[UIImage imageNamed:@"MemberRegisterSubmit.png"] target:self action:@selector(regist:)];
	[self.view addSubview:submitButton];
    
	self.textFieldArray = [NSArray arrayWithObjects: nameTextField,idCardNumTextField,birthdayTextField,telephoneTextField,phoneTextField,emailTextField,zipCodeTextField,addressTextView, nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"知音卡注册";
    sex = 0;
    type = 1;
}

- (void)selectSex:(UIButton*)sender
{
    if(sex == sender.tag)
        return;
    else
    {
        switch (sender.tag) {
            case 0:
            {
                [sexNan setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
                [sexNv setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
                sex = 0;
            }
                break;
                
            default:
            {
                [sexNv setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
                [sexNan setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
                sex = 1;
            }
                break;
        }
    
    }
    
}

- (void)selectType:(UIButton*)sender
{
    if(type == sender.tag)
        return;
    else
    {
        switch (sender.tag) {
            case 1:
            {
                [selectType1 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
                [selectType2 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
                type = 1;
                idCardNumTextField.text = @"";
            }
                break;
                
            default:
            {
                [selectType2 setImage:[UIImage imageNamed:@"Radio_B.png"] forState:UIControlStateNormal];
                [selectType1 setImage:[UIImage imageNamed:@"Radio_A.png"] forState:UIControlStateNormal];
                type = 0;
                idCardNumTextField.text = @"";
            }
                break;
        }
        
    }
}


-(void)sureButtonClick:(id)instance
{
	[birthdayTextField resignFirstResponder];
	[nameTextField resignFirstResponder];
	[keyboardbar HiddenKeyBoard];
	NSString *string = (NSString *)instance;
	birthdayTextField.text = string;
}

-(void)cancelButtonClick
{
	[birthdayTextField resignFirstResponder];
	[nameTextField resignFirstResponder];
	[keyboardbar HiddenKeyBoard];
	
}
-(void)regist:(id)sender
{
    
    if (0 == [nameTextField.text length]) {
		[UIAlertView alertViewWithMessage:@"请填写姓名！" :@"提示"];
		return;
		
	}else if (![MyRegex checkname:nameTextField.text]) {
		[UIAlertView alertViewWithMessage:@"请输入正确的姓名!" :@"提示"];
		return;
	}else if ([nameTextField.text isMatchedByRegex:ZHONGWEN_XINGMING]) {
		if ([nameTextField.text length] > 11) {
			[UIAlertView alertViewWithMessage:@"请输入正确的姓名！" :@"提示"];
			return;
		}
		
	}else if (![nameTextField.text isMatchedByRegex:ZHONGWEN_XINGMING]) {
		if ([nameTextField.text length] <= AirUserNameLenght) {
			if ([nameTextField.text length] >= 12) {
				if([[nameTextField.text substringWithRange:NSMakeRange(11, 1)] isMatchedByRegex:ZHONGWEN_XINGMING]){
					[UIAlertView alertViewWithMessage:@"请输入正确的姓名！" :@"提示"];
					return;
					
				}
			}
		}
	}
    
    
//    if (![nameTextField.text isMatchedByRegex:ZHONGWEN_XINGMING])
//    {
//        [UIAlertView alertViewWithMessage:@"请输入正确的姓名！"];
//        return;
//    }
//    if ([nameTextField.text length] == 0)
//    {
//        [UIAlertView alertViewWithMessage:@"请填写姓名！"];
//        return;
//    }
    
    
    if (![MyRegex checkIsCertificateNum:idCardNumTextField.text] && type == 1)
    {
        [UIAlertView alertViewWithMessage:@"请输入正确的身份证号码！"];
        return;
    }
    if ([idCardNumTextField.text length] == 0)
    {
        [UIAlertView alertViewWithMessage:@"请填写证件号码！"];
        return;
    }
    if ([birthdayTextField.text length] == 0)
    {
        [UIAlertView alertViewWithMessage:@"请选择出生日期！"];
        return;
    }
    if ([zipCodeTextField.text length] == 0)
    {
        [UIAlertView alertViewWithMessage:@"请填写邮编号码！"];
        return;
    }
    if ([addressTextView.text length] == 0)
    {
        [UIAlertView alertViewWithMessage:@"请填写邮寄地址！"];
        return;
    }
    
    ASIFormDataRequest * theRequest = [InterfaceClass registeredForZhiYinCard:[UserInfo sharedUserInfo].userID name:nameTextField.text sex:[NSString stringWithFormat:@"%d",sex] type:[NSString stringWithFormat:@"%d",type] idCard:idCardNumTextField.text birthday:birthdayTextField.text telePhone:telephoneTextField.text tel:phoneTextField.text email:emailTextField.text postCode:zipCodeTextField.text postalAddress:addressTextView.text];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onregisteredForZhiYinCardResult:) Delegate:self needUserType:Default];
}

-(void)onregisteredForZhiYinCardResult:(NSDictionary*)dic
{
    
    if([[dic objectForKey:@"statusCode"] intValue] == 0)
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"提交成功！"] tag:0 delegate:self];
    }
    else
    {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"提交失败！"] tag:1 delegate:self];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 0)
    [NavigationController popToRootViewControllerAnimated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    registerView.contentSize = CGSizeMake(ViewWidth-20.0f, 460);

}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	if (self.keyboardbar == nil) {
        registerView.contentSize = CGSizeMake(ViewWidth-20.0f, 400);

		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}
	[keyboardbar showBar:textView];  //显示工具条
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == nameTextField || textField == idCardNumTextField)
        registerView.contentSize = CGSizeMake(ViewWidth-20.0f, 350);
    else
        registerView.contentSize = CGSizeMake(ViewWidth-20.0f, 440);
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (textField == birthdayTextField) {
		YearMonthDayView *birthdayBgView = nil;
		NSDate *currentYear = [[NSDate alloc] init];
		NSMutableArray * array = [NSMutableArray array];
		
        NSString * year = [[NSDate dateCode:[NSDate dateFromString:@"1900-01-01"]] substringToIndex:4];
		int endYear = [currentYear year:[NSDate date]];
		int yearInterval = endYear - 1900;
		for (int i=0; i<yearInterval; i++) {
			[array addObject:[NSString stringWithFormat:@"%4d年",[year intValue]+i]];
		}
		
		if (textField.text.length>0) {
			NSString *birthdayYear = [[textField.text componentsSeparatedByString:@"-"] objectAtIndex:0];
			NSString *birthdayMonth = [[textField.text componentsSeparatedByString:@"-"] objectAtIndex:1];
			NSString *birthdayDay = [[textField.text componentsSeparatedByString:@"-"] objectAtIndex:2];
			birthdayBgView = [[YearMonthDayView alloc] initWithFrame:CGRectMake(0, ViewHeight, ViewWidth, 190) Title:@"生日选择" array:array selectYear:[NSString stringWithFormat:@"%@年",birthdayYear] selectMonth:[NSString stringWithFormat:@"%@月",birthdayMonth] selectDay:[NSString stringWithFormat:@"%@日",birthdayDay]];
			
            
		}else{
			birthdayBgView = [[YearMonthDayView alloc] initWithFrame:CGRectMake(0, ViewHeight, ViewWidth, 190) Title:@"生日选择" array:array selectYear:@"1980年" selectMonth:@"01月" selectDay:@"01日"];
			
		}
        
		birthdayBgView.delegate=self;
		birthdayBgView.tag = 10;
		textField.inputView = birthdayBgView;
		[currentYear release];
		
	}
	
	if (self.keyboardbar == nil) {
        registerView.contentSize = CGSizeMake(ViewWidth-20.0f,400);

		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}else {
        //		self.keyboardbar.textFields = self.textFieldArray;
        [self.keyboardbar setTextFields:self.textFieldArray];
	}
//    self.keyboardbar.currentView.frame.origin.y = 

    
	[keyboardbar showBar:textField];  //显示工具条
	
	
	return TRUE;
} 


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
	

    switch (textField.tag) {
        case 100://姓名
        {
            textFieldMaxLenth = 11;
        }
            break;
        case 200://证件号码
        {
            if(type == 1)//证件号码框输入必须为18个字符，只能输入数字和英文字母X（不限制大小写）；并做身份证的正确表达式判断
            {
                textFieldMaxLenth = 18;
            }
            else//当证件类型为护照时，输入框限制不得大于30个字符
            {
                textFieldMaxLenth = 30;
            }
        }
            break;
        case 400://手机号码     手机号项仅能输入数字,不能超过11位
        {
            textFieldMaxLenth = 11;
        }
            break;
        case 500://电话号码       电话项仅能输入数字，不能超过18位
        {
            textFieldMaxLenth = 18;
        }
            break;
        case 700://邮编      邮编项仅能输入数字，不能超过6位
        {
            textFieldMaxLenth = 6;
        }
            break;
        case 800://邮寄地址     邮寄地址项限制输入100个字符，包括汉字、数字、特殊字符
        {
            textFieldMaxLenth = 100;
        }
            break;
    }
    
    
    if(textFieldStrLength >= textFieldMaxLenth)
	{
        if(textField.tag == 600 || textField.tag == 300)
        {
            return YES;
        }
		textField.text = [textFieldStr substringToIndex:textFieldMaxLenth];
		return NO;
	}
	else 
		return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
