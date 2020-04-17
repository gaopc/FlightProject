//
//  WoyinAddPassagerViewController.m
//  FlightProject
//
//  Created by 张晓婷 on 15-6-5.
//
//

#import "WoyinAddPassagerViewController.h"
#import "KeyBoardTopBar.h"
#import "MyRegex.h"
#import "KeyBoardTopBar.h"
#import "CustomScorllView.h"
#import "YearMonthDayView.h"

@interface Cert : NSObject
@property (nonatomic,retain) NSString *_type;
@property (nonatomic,retain) NSString *_name;

@end

@implementation Cert

@synthesize _name,_type;
- (void)dealloc
{
    self._type = nil;
    self._name = nil;
    [super dealloc];
}

@end

@interface WoyinAddPassagerViewController ()<UITextFieldDelegate,YearMonthDayViewDelegate,CustomScorllViewDelegate>
{
    UISubTextField *nameTextField; //姓名
    UISubTextField *certTypeTextField; //证件类型
    UISubTextField *certNumTextField; //证件号
    UISubTextField *birthdayTextField;//出生日期
    UISubTextField *nowTextField;//当前编辑
    
    UIView *middleView;
    UIView *bottomView;

    UIButton * proBtn;
    UIButton *femaleBtn;
    UIButton *addBtn;
    UIButton *delBtn;
    UIButton *updateBtn;
    UIButton *adultBtn;
    UIButton *childrenBtn;
    
    BOOL isEditGender;
}
@property (nonatomic,retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic,retain) NSDictionary *certDic;
@property (nonatomic ,retain) NSArray *certArr;
@property (nonatomic,retain) Cert *selectCert;

@end

@implementation WoyinAddPassagerViewController
@synthesize keyboardbar,selectCert;
@synthesize certDic, certArr;
@synthesize _passagerData, _delegate, _viewType;


- (void)dealloc
{
    self._viewType = nil;
    self._delegate = nil;
    self._passagerData = nil;
    self.keyboardbar = nil;
    self.selectCert = nil;
    self.certDic = nil;
    self.certArr = nil;
    [selectCert release];
    [super dealloc];
}
-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat startY = 0;
    
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,startY,ViewWidth,70)];
    aView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:aView];
    [aView release];
    
    UIImageView *nameImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 20, ViewWidth - 40, 36.5f)];
    [nameImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
    [aView addSubview:nameImageView];
    
    UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"乘客姓名:" frame:CGRectMake(25.0f, 20.0f, 80.0f, 36.5f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
    titleLabel1.textColor = FontColor333333;
    [aView addSubview:titleLabel1];
    
    //乘客姓名
    nameTextField = [UISubTextField TextFieldWithFrame:CGRectMake(100.0f, 25.0f, ViewWidth - 140, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"中文或英文(TOM/BUSH)"];
    nameTextField.font = FontSize32;
    nameTextField.tag = 100;
    nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; //首字母小写
    nameTextField.delegate = self;
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
    [aView addSubview:nameTextField];
    
    startY += 70;
    
    middleView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,startY,ViewWidth,50.0f)];
    middleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:middleView];
    [middleView release];
    
    adultBtn = [UIButton buttonWithTag:5 image:[UIImage imageNamed:@"FilterSingleSelected.png"] title:@"成人" imageEdge:UIEdgeInsetsMake(0, 0, 0, 30) frame:CGRectMake(30.0f, 0.0f, 50.0f, 36.0f) font:FontBlodSize30 color:FontColor333333 target:self action:@selector(changTypeBtn:)];
    [middleView addSubview:adultBtn];
    
    childrenBtn = [UIButton buttonWithTag:6 image:[UIImage imageNamed:@"FilterSingleUnSelected.png"] title:@"儿童" imageEdge:UIEdgeInsetsMake(0, 0, 0, 30) frame:CGRectMake(130.0f, 0.0f, 50.0f, 36.0f) font:FontBlodSize30 color:FontColor333333 target:self action:@selector(changTypeBtn:)];
    [middleView addSubview:childrenBtn];
    
    UIButton *explainButton = [UIButton buttonWithType:UIButtonTypeCustom tag:20 title:@"儿童购票说明" frame:CGRectMake(200, 5, 120.0f, 30.0f) backImage:nil target:self action:@selector(explain:)];
    [explainButton setTitleColor:FontColor2B8DD0 forState:UIControlStateNormal];
    explainButton.titleLabel.font = FontSize20;
    [middleView addSubview:explainButton];
    
    
    startY += 50;
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, startY, ViewWidth, 300)];
    [self.view addSubview:bottomView];
    [bottomView release];
    
    startY = 0;
    aView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,startY,ViewWidth,50.0f)];
    aView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:aView];
    [aView release];
    
    nameImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 0.0f, ViewWidth - 40, 36.5f)];
    [nameImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
    [aView addSubview:nameImageView];
    UISubLabel *titleLabel4 = [UISubLabel labelWithTitle:@"证件类型:" frame:CGRectMake(25.0f, 7.0f, 80.0f, 20.0f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
    titleLabel4.textColor = FontColor333333;
    [aView addSubview:titleLabel4];
    /*
     1:二代身份证，2:一代身份证，C:
     港澳通行证，G:台湾通行证，B:
     护照
     */
    if ([self._viewType intValue] == 1) {
        self.certArr = [NSArray arrayWithObjects:@"二代身份证", @"港澳通行证",@"台湾通行证", @"护照", @"其它", nil];
        self.certDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"7",@"8", @"1", @"9", nil] forKeys:[NSArray arrayWithObjects:@"二代身份证", @"港澳通行证", @"台湾通行证", @"护照", @"其它", nil]];
    }
    else {
        self.certArr = [NSArray arrayWithObjects:@"二代身份证", @"港澳通行证",@"台湾通行证", @"护照", nil];
        self.certDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"C",@"G", @"B", nil] forKeys:[NSArray arrayWithObjects:@"二代身份证", @"港澳通行证",@"台湾通行证", @"护照", nil]];
    }
    
    CustomScorllView * inputView = [[CustomScorllView alloc] initWithTitle:@"证件类型" centerTitles:self.certArr frame:CGRectMake(0.0f, 0.0f, ViewWidth, 230) selectStr:@"二代身份证"];
    inputView.delegate = self;
    
    certTypeTextField = [UISubTextField TextFieldWithFrame:CGRectMake(100.0f, 5.0f, ViewWidth - 140, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请选择证件类型"];
    certTypeTextField.font = FontSize32;
    certTypeTextField.keyboardType = UIKeyboardTypeASCIICapable;
    certTypeTextField.tag = 101;
    certTypeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    certTypeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
    certTypeTextField.delegate = self;
    certTypeTextField.inputView = inputView;
    [aView addSubview:certTypeTextField];
    
    startY += 50;
    aView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,startY,ViewWidth,50.0f)];
    aView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:aView];
    [aView release];

    nameImageView = [UIImageView ImageViewWithFrame:CGRectMake(20.0f, 0.0f, ViewWidth - 40, 36.5f)];
    [nameImageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
    [aView addSubview:nameImageView];
    titleLabel4 = [UISubLabel labelWithTitle:@"证件号码:" frame:CGRectMake(25.0f, 0.0f, 80.0f, 36.5f) font:FontBlodSize30 alignment:NSTextAlignmentLeft];
    titleLabel4.textColor = FontColor333333;
    [aView addSubview:titleLabel4];
    
    
    certNumTextField = [UISubTextField TextFieldWithFrame:CGRectMake(100.0f, 5.0f, ViewWidth - 140, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入证件号码"];
    certNumTextField.font = FontSize32;
    certNumTextField.keyboardType = UIKeyboardTypeASCIICapable;
    certNumTextField.tag = 102;
    certNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    certNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
    certNumTextField.delegate = self;
    [aView addSubview:certNumTextField];
    
    startY += 50;
    aView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,startY,ViewWidth,50.0f)];
    aView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:aView];
    [aView release];
    
    [aView addSubview:[UISubLabel labelWithTitle:@"旅客性别:" frame:CGRectMake(25.0f, 0.0f, 80.0f, 36.5f) font:FontBlodSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];
    
    proBtn = [UIButton buttonWithTag:0 image:[UIImage imageNamed:@"FilterSingleSelected.png"] title:@"男" imageEdge:UIEdgeInsetsMake(0, 0, 0, 30) frame:CGRectMake(100.0f, 0.0f, 50.0f, 36.0f) font:FontBlodSize30 color:FontColor333333 target:self action:@selector(changSexBtn:)];
    [aView addSubview:proBtn];
    
    femaleBtn = [UIButton buttonWithTag:1 image:[UIImage imageNamed:@"FilterSingleUnSelected.png"] title:@"女" imageEdge:UIEdgeInsetsMake(0, 0, 0, 30) frame:CGRectMake(180.0f, 0.0f, 50.0f, 36.0f) font:FontBlodSize30 color:FontColor333333 target:self action:@selector(changSexBtn:)];
    [aView addSubview:femaleBtn];
    
    startY += 50;
    aView = [[UIView alloc]initWithFrame:CGRectMake(0.0f ,startY,ViewWidth,50.0f)];
    aView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:aView];
    [aView release];

    [aView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20.0f, 0.0f, ViewWidth - 40, 36.5f) image:[UIImage imageNamed:@"MemberLoginTextBox.png"]]];
    [aView addSubview:[UISubLabel labelWithTitle:@"出生日期:" frame:CGRectMake(25.0f, 0.0f, 80.0f, 36.5f) font:FontBlodSize30 color:FontColor333333 alignment:NSTextAlignmentLeft]];

    birthdayTextField = [UISubTextField TextFieldWithFrame:CGRectMake(102.0f, 5.0f, ViewWidth - 140, 28.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请选择出生日期"];
    NSMutableArray * array = [NSMutableArray array];
    int currentYearValue = [[NSDate date] year];
    int yearInterval = 100;
    int startYear = currentYearValue - yearInterval;
    
    for (int i=0; i<yearInterval; i++) {
        [array addObject:[NSString stringWithFormat:@"%4d年",startYear+i]];
    }
    YearMonthDayView * input = [[YearMonthDayView alloc] initWithFrame:CGRectMake(0, ViewHeight, ViewWidth, 200) Title:@"生日选择" array:array selectYear:[NSString stringWithFormat:@"%4d年",[[NSDate date] year]] selectMonth:@"01月" selectDay:@"01日"];
    input.delegate = self;
    birthdayTextField.inputView = input;
    birthdayTextField.font = FontSize32;
    birthdayTextField.tag = 103;
    birthdayTextField.delegate = self;
    [aView addSubview:birthdayTextField];
    
    
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake((ViewWidth - 146)/2, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"SubmitButton.png"] target:self action:@selector(addPassenger)];
    [self.view addSubview:addBtn];
    
    delBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake((ViewWidth - 296)/2, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"deleteTrainPassenger.png"] target:self action:@selector(deletePassenger)];
    delBtn.hidden = YES;
    [self.view addSubview:delBtn];
    
    updateBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake((ViewWidth - 296)/2 + 150, ViewHeight-87.0f, 146.0f, 38.0f) backImage:[UIImage imageNamed:@"EditPassengersButton.png"] target:self action:@selector(addPassenger)];
    updateBtn.hidden = YES;
    [self.view addSubview:updateBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectCert = [[Cert alloc] init];
    
    if (self._isEdit) {
        self.title = @"编辑旅客";
        nameTextField.text = self._passagerData._passageName;
        certNumTextField.text = self._passagerData._idNo;
        birthdayTextField.text = self._passagerData._birthDay.length > 9 ? self._passagerData._birthDay : @"";
        
        if ([self._viewType intValue] == 1) {
            switch ([self._passagerData._idType intValue]) {
                case 0:
                    certTypeTextField.text = @"二代身份证";
                    break;
                case 1:
                    certTypeTextField.text = @"护照";
                    break;
                case 7:
                    certTypeTextField.text = @"港澳通行证";
                    break;
                case 8:
                    certTypeTextField.text = @"台湾通行证";
                    break;
                case 9:
                    certTypeTextField.text = @"其它";
                    break;
                    
                default:
                    certTypeTextField.text = @"其它";
                    break;
            }
            self.selectCert._name = certTypeTextField.text;
            self.selectCert._type = [self.certDic objectForKey:certTypeTextField.text];
            
            if ([self._passagerData._passengerType intValue] == 1) {
                [self changTypeBtn:childrenBtn];
            }
        }
        else {
            
            if ([self._passagerData._idType isEqualToString:@"1"]) {
                certTypeTextField.text = @"二代身份证";
            }
            else if ([self._passagerData._idType isEqualToString:@"2"]) {
                certTypeTextField.text = @"一代身份证";
            }
            else if ([self._passagerData._idType isEqualToString:@"C"]) {
                certTypeTextField.text = @"港澳通行证";
            }
            else if ([self._passagerData._idType isEqualToString:@"G"]) {
                certTypeTextField.text = @"台湾通行证";
            }
            else if ([self._passagerData._idType isEqualToString:@"B"]) {
                certTypeTextField.text = @"护照";
            }
            else {
                certTypeTextField.text = @"";
            }
            
            self.selectCert._name = certTypeTextField.text;
            self.selectCert._type = [self.certDic objectForKey:certTypeTextField.text];
        }
        
        if ([self._passagerData._sex isEqualToString:@"F"] || [self._passagerData._sex isEqualToString:@"0"]) {
            [self changSexBtn:femaleBtn];
        }
        if (self._passagerData._sex.length == 0) {
            [self setSexNone:nil];
        }
        
        addBtn.hidden = YES;
        delBtn.hidden = NO;
        updateBtn.hidden = NO;
        
        if ([self._viewType intValue] == 2) {
            
            self.title = @"添加儿童姓名";
            nameTextField.text = @"";
            addBtn.hidden = NO;
            delBtn.hidden = YES;
            updateBtn.hidden = YES;
            
            proBtn.enabled = NO;
            femaleBtn.enabled = NO;
            childrenBtn.enabled = NO;
            adultBtn.enabled = NO;
            certTypeTextField.enabled = NO;
            certNumTextField.enabled = NO;
            birthdayTextField.enabled = NO;
            
            [self changTypeBtn:childrenBtn];
        }
    }
    else {
        self.title = @"新增旅客";
    }
    
    if ([self._viewType intValue] == 0 || [self._viewType intValue] == 2) {
        middleView.hidden = YES;
        CGRect bFrame = bottomView.frame;
        bFrame.origin.y -= 50;
        bottomView.frame = bFrame;
    }
}
-(void)changSexBtn:(UIButton *)sender
{
    [proBtn setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
    proBtn = sender;
    isEditGender = NO;
}

-(void)setSexNone:(UIButton *)sender
{
    [proBtn setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
    [femaleBtn setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
    isEditGender = YES;
}

- (void)changTypeBtn:(UIButton *)sender
{
    [adultBtn setImage:[UIImage imageNamed:@"FilterSingleUnSelected.png"] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"FilterSingleSelected.png"] forState:UIControlStateNormal];
    adultBtn = sender;
}

- (void)explain:(UIButton *)sender
{
    [UIAlertView alertViewWithMessage:@"儿童票要求在乘机日期时，年龄为2-12周岁的儿童。\n温馨提醒： 儿童票票价为全价票的一半价格，机场建设费免收，燃油税为成人价的一半。儿童乘机需要有成人陪伴，每1名成人最多携带2名儿童乘机。":@"儿童购票说明"];
}

- (void)deletePassenger
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除提示" message:@"是否删除乘客信息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    [alertView show];
    [alertView release];
}

-(void)addPassenger
{
    NSArray *parts = [nameTextField.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    nameTextField.text = [filteredArray componentsJoinedByString:@""];
    
    NSArray *certParts = [certNumTextField.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    NSArray *certFilteredArray = [certParts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    certNumTextField.text = [certFilteredArray componentsJoinedByString:@""];
    
    if (0 == [nameTextField.text length]) {
        [UIAlertView alertViewWithMessage:@"请填写乘客姓名!" :@"提示"];
        return;
        
    }else if (![MyRegex checkname:nameTextField.text]) {
        [UIAlertView alertViewWithMessage:@"请输入正确的乘客姓名!" :@"提示"];
        return;
    }
    if ([nameTextField.text length] > 28) {
        [UIAlertView alertViewWithMessage:@"乘客姓名长度不能超过28个!" :@"提示"];
        return;
    }
//    else if ([nameTextField.text isMatchedByRegex:ZHONGWEN_XINGMING]) {
//        if ([nameTextField.text length] > 11) {
//            [UIAlertView alertViewWithMessage:@"乘客姓名长度不能超过11个汉字!" :@"提示"];
//            return;
//        }
//        
//    }else if (![nameTextField.text isMatchedByRegex:ZHONGWEN_XINGMING]) {
//        if ([nameTextField.text length] <= AirUserNameLenght) {
//            if ([nameTextField.text length] >= 12) {
//                if([[nameTextField.text substringWithRange:NSMakeRange(11, 1)] isMatchedByRegex:ZHONGWEN_XINGMING]){
//                    [UIAlertView alertViewWithMessage:@"乘客姓名长度不能超过11个汉字!" :@"提示"];
//                    return;
//                    
//                }
//            }
//        }
//    }
    if (0 == [certTypeTextField.text length]) {
        [UIAlertView alertViewWithMessage:@"请选择证件类型!" :@"提示"];
        return;
    }
    if (0 == [certNumTextField.text length]) {
        [UIAlertView alertViewWithMessage:@"请填写证件号码!" :@"提示"];
        return;
    }
    else if (([self.selectCert._type isEqualToString:@"1"] && [self._viewType intValue] == 0) || ([self.selectCert._type isEqualToString:@"0"] && [self._viewType intValue] == 1)) {
        if (![MyRegex checkIsCertificateNum:certNumTextField.text]) {
            [UIAlertView alertViewWithMessage:@"请输入正确的身份证号码!" :@"提示"];
            return;
        }
    }else if([self.selectCert._type isEqualToString:@"B"] || ([self.selectCert._type isEqualToString:@"1"] && [self._viewType intValue] == 1)){
        if (![certNumTextField.text isMatchedByRegex:PASSPORT_CARD]) {
            [UIAlertView alertViewWithMessage:@"请输入正确的证件号码!" :@"提示"];
            return;
        }
    }
    if (isEditGender) {
        [UIAlertView alertViewWithMessage:@"请选择旅客性别!" :@"提示"];
        return;
    }
    if (0 == [birthdayTextField.text length]) {
        [UIAlertView alertViewWithMessage:@"请输入出生日期!" :@"提示"];
        return;
    }
    /*
     1:二代身份证，2:一代身份证，C:
     港澳通行证，G:台湾通行证，B:
     护照
     */
    
    /*
    for (TrainPassagerInfo * pInfo in [BookingModel shareBookingModel]._passageInfoList) {
        if ([pInfo._idNo isEqualToString:certNumTextField.text]) {
            [UIAlertView alertViewWithMessage:@"该常用乘客已添加过！" :@"提示"];
            return;
        }
    }
    TrainPassagerInfo * info = [[TrainPassagerInfo alloc] init];
    info._idNo = certNumTextField.text;
    info._idType = self.selectCert._type;
    info._passageName = nameTextField.text;
    info._passengerId = @"";
    info._passengerType = @"1";
    info._sex=proBtn.tag==0?@"M":@"F";
    info._birthDay = birthdayTextField.text;
    info._seat = [BookingModel shareBookingModel]._selectTrain._selectSeat;
    info._service = [BookingModel shareBookingModel]._service;
    [[BookingModel shareBookingModel]._passageInfoList addObject:info];
    [info release];
     
     [self.navigationController popViewControllerAnimated:YES];
     */
    
    
    if ([self._viewType intValue] == 2) {
        TrainPassagerInfo *info = self._passagerData;
        TrainPassagerInfo * child = [[TrainPassagerInfo alloc] init];
        child._idNo = info._idNo;
        child._idType = info._idType;
        child._childrenName = nameTextField.text;
        child._passageName = info._passageName;
        child._passengerId = info._passengerId;
        child._passengerType = @"2";
        child._sex=info._sex;
        child._birthDay = info._birthDay;
        child._seat = info._seat;
        child._service = info._service;
        [[BookingModel shareBookingModel]._passageInfoList addObject:child];
        [child release];
        
        if ([info._childs count]==0) {
            info._childs = [NSMutableArray arrayWithObject:child];
        }
        else
        {
            [info._childs addObject:child];
        }
        
        if (self._delegate && [self._delegate respondsToSelector:@selector(addChildrenName:)]) {
            [self._delegate performSelector:@selector(addChildrenName:) withObject:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if (self._isEdit) {
        if ([self._viewType intValue] == 1) {
            ASIFormDataRequest * theRequest = [InterfaceClass updatePassengers:[UserInfo sharedUserInfo].userID withId:self._passagerData._passengerId withName:nameTextField.text withType:adultBtn.tag==5?@"0":@"1" withCertType:self.selectCert._type withCertNum:certNumTextField.text withBirthday:birthdayTextField.text withGender:proBtn.tag==0?@"1":@"0"];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUpdateTrainPassernerResult:) Delegate:self needUserType:Member];
        }
        else {
            ASIFormDataRequest * theRequest = [InterfaceClass updateTrainPasserngerInfo:[UserInfo sharedUserInfo].userID withPassergerId:self._passagerData._passengerId withName:nameTextField.text withType:self.selectCert._type withNo:certNumTextField.text withBirthday:birthdayTextField.text withGender:proBtn.tag==0?@"M":@"F"];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onUpdateTrainPassernerResult:) Delegate:self needUserType:Default];
        }
    }
    else {
        if ([self._viewType intValue] == 1) {
            ASIFormDataRequest * theRequest = [InterfaceClass addPassengers:[UserInfo sharedUserInfo].userID withName:nameTextField.text withType:adultBtn.tag==5?@"0":@"1" withCertType:self.selectCert._type withCertNum:certNumTextField.text withBirthday:birthdayTextField.text withSex:proBtn.tag==0?@"1":@"0"];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onAddTrainPassernerResult:) Delegate:self needUserType:NoMember];
        }
        else {
            ASIFormDataRequest * theRequest = [InterfaceClass addTrainPasserngerInfo:[UserInfo sharedUserInfo].userID withName:nameTextField.text withType:self.selectCert._type withNo:certNumTextField.text withBirthday:birthdayTextField.text withGender:proBtn.tag==0?@"M":@"F"];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onAddTrainPassernerResult:) Delegate:self needUserType:Default];
        }
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        ASIFormDataRequest *theRequest = [InterfaceClass delTrainPassernger:[UserInfo sharedUserInfo].userID withPassergerId:self._passagerData._passengerId];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onDelTrainPassernerResult:) Delegate:self needUserType:Default];
    }
}

#pragma -mark textField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (certNumTextField == textField) {
        
        if (([self.selectCert._type isEqualToString:@"1"] && [self._viewType intValue] == 0) || ([self.selectCert._type isEqualToString:@"0"] && [self._viewType intValue] == 1)) {
            if ([MyRegex checkIsCertificateNum:certNumTextField.text]) {
                
                NSString *birthdayStr = [certNumTextField.text substringWithRange:NSMakeRange(6, 8)];
                NSString *yearStr = [birthdayStr substringToIndex:4];
                NSString *monthStr = [birthdayStr substringWithRange:NSMakeRange(4, 2)];
                NSString *dayStr = [birthdayStr substringFromIndex:6];
                
                NSLog(@"-----%@------", birthdayStr);
                birthdayTextField.text = [NSString stringWithFormat:@"%@-%@-%@", yearStr, monthStr, dayStr];
                
                YearMonthDayView *inputView = (YearMonthDayView *)birthdayTextField.inputView;
                [inputView tableViewPosition:yearStr withMonth:monthStr withDay:dayStr];
            }
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    nowTextField = textField;
    NSArray *barArr = [NSArray arrayWithObjects:nameTextField,certTypeTextField,certNumTextField,birthdayTextField, nil];
    
    if ([self._viewType intValue] == 2) {
        barArr = [NSArray arrayWithObjects:nameTextField, nil];
    }
    
    if (self.keyboardbar == nil) {
        KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:barArr view:self.view ];
        self.keyboardbar = _keyboardbar;
        [_keyboardbar release];
    }else {
        [self.keyboardbar setTextFields:barArr];
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
        case 102:
        {
            if (([self.selectCert._type isEqualToString:@"1"] && [self._viewType intValue] == 0) || ([self.selectCert._type isEqualToString:@"0"] && [self._viewType intValue] == 1)) {
                textFieldMaxLenth = 18;
            }
             textFieldMaxLenth = 30;
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

-(void)sureButtonClick:(id)instance
{
    [nowTextField resignFirstResponder];
    [keyboardbar HiddenKeyBoard];
    
    NSString *string = (NSString *)instance;
    nowTextField.text = string;
    
    if (nowTextField == certTypeTextField) {
        
        self.selectCert._name = string;
        self.selectCert._type = [self.certDic objectForKey:string];
    }
}

-(void)cancelButtonClick
{
    [nowTextField resignFirstResponder];
    [keyboardbar HiddenKeyBoard];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络协议请求结果
- (void)onAddTrainPassernerResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *statusMess = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    
    if (![statusCode isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:statusMess];
    }
    else {
        if (self._delegate && [self._delegate respondsToSelector:@selector(addPasserner:)]) {
            [self._delegate performSelector:@selector(addPasserner:) withObject:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)onUpdateTrainPassernerResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *statusMess = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    
    if (![statusCode isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:statusMess];
    }
    else {
        if ([self._viewType intValue] == 0) {
            for (TrainPassagerInfo *passagerInfo in [BookingModel shareBookingModel]._passageInfoList) {
                if ([passagerInfo._passengerId isEqualToString:self._passagerData._passengerId]) {
                    passagerInfo._passageName = nameTextField.text;
                    passagerInfo._idNo = certNumTextField.text;
                    passagerInfo._birthDay = birthdayTextField.text;
                    passagerInfo._sex = proBtn.tag==0?@"M":@"F";
                    passagerInfo._idType = self.selectCert._type;
                }
            }
        }
        
        if (self._delegate && [self._delegate respondsToSelector:@selector(updatePasserner:)]) {
            [self._delegate performSelector:@selector(updatePasserner:) withObject:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)onDelTrainPassernerResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *statusMess = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    
    if (![statusCode isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:statusMess];
    }
    else {
        
        for (TrainPassagerInfo *passagerInfo in [BookingModel shareBookingModel]._passageInfoList) {
            if ([passagerInfo._passengerId isEqualToString:self._passagerData._passengerId]) {
                [[BookingModel shareBookingModel]._passageInfoList removeObject:passagerInfo];
            }
        }
        if (self._delegate && [self._delegate respondsToSelector:@selector(delPasserner:)]) {
            [self._delegate performSelector:@selector(delPasserner:) withObject:nil];
        }
        
        NSLog(@"删除成功调转");
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
