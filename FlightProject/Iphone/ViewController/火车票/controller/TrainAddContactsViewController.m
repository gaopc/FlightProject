//
//  TrainAddContactsViewController.m
//  FlightProject
//
//  Created by gaopengcheng on 15-7-17.
//
//

#import "TrainAddContactsViewController.h"
#import "MyRegex.h"

@interface TrainAddContactsViewController ()

@end

@implementation TrainAddContactsViewController
@synthesize _editItem;
@synthesize keyboardbar, textFieldArray;
@synthesize _delegate;

- (void)dealloc
{
    self._delegate = nil;
    self.keyboardbar = nil;
    self.textFieldArray = nil;
    self._editItem = nil;
    [super dealloc];
}

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
    
    if (self._editItem) {
        nameTextField.text = self._editItem._name;
        certNumTextField.text = self._editItem._phone;
        
        int offx = (ViewWidth - 296)/2;
        deleteButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(offx, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"deleteContacts.png"] target:self action:@selector(deleteContacts:)];
        [self.view addSubview:deleteButton];
        
        submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(offx + 150, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"EditPassengersButton.png"] target:self action:@selector(addContacts:)];
        [self.view addSubview:submitButton];
        
    }else {
        submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake((ViewWidth - 146)/2, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"SubmitButton.png"] target:self action:@selector(addContacts:)];
        [self.view addSubview:submitButton];
    }
    self.textFieldArray = [NSArray arrayWithObjects:nameTextField,certNumTextField, nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self._editItem){
        self.title = @"编辑联系人";
    }else {
        self.title = @"新增联系人";
    }
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - 按钮事件
- (void)deleteContacts:(id)sender
{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认删除联系人?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.tag = 202;
    [alert show];
    [alert release];
}

- (void)addContacts:(id)sender
{
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
    
    if (self._editItem) {
        ASIFormDataRequest * theRequest = [InterfaceClass updatePick:[UserInfo sharedUserInfo].userID ids:self._editItem._id name:nameTextField.text phone:certNumTextField.text];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onEditPaseredResult:) Delegate:self needUserType:Member];
        
    }else {
        
        ASIFormDataRequest * theRequest = [InterfaceClass addPick:[UserInfo sharedUserInfo].userID name:nameTextField.text phone:certNumTextField.text];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onAddPaseredResult:) Delegate:self needUserType:NoMember];
    }
}

#pragma -mark textField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.keyboardbar == nil) {
        KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
        self.keyboardbar = _keyboardbar;
        [_keyboardbar release];
    }else {
        [self.keyboardbar setTextFields:self.textFieldArray];
    }
    [self.keyboardbar showBar:textField];  //显示工具条
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

#pragma mark - UIAlertViewDelegate
- (void) alertView:(UIAlertView *)alertview clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        ASIFormDataRequest * theRequest = [InterfaceClass deletePick:[UserInfo sharedUserInfo].userID ids:self._editItem._id];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelPaseredResult:) Delegate:self needUserType:Member];
    }
}

#pragma mark - 网络请求事件返回
- (void)onDelPaseredResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *statusMess = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    if ([statusCode isEqualToString:@"0"]) {
        
        if (self._delegate && [self._delegate respondsToSelector:@selector(contactsOver:)]) {
            [self._delegate performSelector:@selector(contactsOver:) withObject:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [UIAlertView alertViewWithMessage:statusMess];
    }
}

- (void)onEditPaseredResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *statusMess = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    if ([statusCode isEqualToString:@"0"]) {
        
        if (self._delegate && [self._delegate respondsToSelector:@selector(contactsOver:)]) {
            [self._delegate performSelector:@selector(contactsOver:) withObject:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [UIAlertView alertViewWithMessage:statusMess];
    }
}

- (void)onAddPaseredResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *statusMess = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    if ([statusCode isEqualToString:@"0"]) {
        
        if (self._delegate && [self._delegate respondsToSelector:@selector(contactsOver:)]) {
            [self._delegate performSelector:@selector(contactsOver:) withObject:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [UIAlertView alertViewWithMessage:statusMess];
    }
}
@end
