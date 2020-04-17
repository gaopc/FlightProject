//
//  WoyinPassagerListViewController.m
//  FlightProject
//
//  Created by gaopengcheng on 15-7-10.
//
//

#import "WoyinPassagerListViewController.h"
//#import "PassengerInfoDataResponse.h"
#import "WoyinAddPassagerViewController.h"
#import "TrainModel.h"


@interface WoyinPassagerListViewController ()

@end

@implementation WoyinPassagerListViewController
@synthesize _promptlable, _passengersInfoArray, _stateDictionary;
@synthesize _actionState, _viewType;

- (void)dealloc
{
    self._viewType = nil;
    self._actionState = nil;
    self._stateDictionary = nil;
    self._promptlable = nil;
    self._passengersInfoArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self._viewType intValue] == 1) {
        self.title = @"旅客列表";
    }
    else {
        self.title = @"选择旅客";
    }
    
    UISubLabel *titleLabel = [UISubLabel labelWithTitle:@"常用旅客列表" frame:CGRectMake(15.0f, 15.0f, 140.0f, 40.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
    titleLabel.textColor = FontColor333333;
    [self.view addSubview:titleLabel];
    
    passengerAddButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(ViewWidth - 122, 18.0f, 115.0f, 32.0f) backImage:[UIImage imageNamed:@"addTrainPassenger.png"] target:self action:@selector(addPassenger:)];
    [self.view addSubview:passengerAddButton];
    
    self._promptlable = [UISubLabel labelWithTitle:@"您还没有常用旅客，请新增旅客。" frame:CGRectMake(15.0f, 60.0f, ViewWidth - 20, 25.0f) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
    self._promptlable.hidden = YES;
    [self.view addSubview: self._promptlable];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 60.0f, ViewWidth, ViewHeight-165.0f) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.separatorColor = [UIColor clearColor];
    [self.view addSubview:myTable];
    
    UIImageView *bottomButtonImgView=[UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight-100.0f, ViewWidth, 50.0f)];
    bottomButtonImgView.image=[UIImage imageNamed:@"PassBottomButtonBg.png"];
    [self.view addSubview:bottomButtonImgView];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake((ViewWidth - 145)/2, ViewHeight-90.0f, 145.0f, 38.0f) backImage:[UIImage imageNamed:@"ConfirmationPassButton.png"] target:self action:@selector(submitList:)];
    [self.view addSubview:submitButton];
    
    
    self._stateDictionary = [NSMutableDictionary dictionary];
    self._passengersInfoArray = [NSMutableArray array];
    self._actionState = @"1";
    
    if ([self._viewType intValue] == 1) {
        submitButton.hidden = YES;
        bottomButtonImgView.hidden = YES;
        myTable.frame = CGRectMake(0, 60, ViewWidth, ViewHeight - 110);
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self._actionState intValue] > 0) {
        [self getPassengersInfo];
    }
}

#pragma mark UITableView方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self._passengersInfoArray count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    PassengersInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[PassengersInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    TrainPassagerInfo *passInfo = [self._passengersInfoArray objectAtIndex:indexPath.row];
    cell.name.text = passInfo._passageName;
    
    if ([passInfo._idType isEqualToString:@"1"] || [passInfo._idType isEqualToString:@"2"]) {
        cell.identification.text = passInfo._idNo;
    }
    else {
        if ([ passInfo._idNo isEqualToString:@"<null>"] || [ passInfo._idNo isEqualToString:@""]) {
            passInfo._idNo =@"";
        }
        cell.identification.text = passInfo._idNo;
    }
    
    NSString *checked = @"0";
    id temp = [self._stateDictionary objectForKey:passInfo._passengerId];
    if ([temp isKindOfClass:[NSString class]]) {
        checked = temp;
    }
    
    [self._stateDictionary setObject:checked forKey:passInfo._passengerId];
    cell.btnView.hidden = checked.boolValue ? NO :YES;
    cell.editButton.tag = (100+indexPath.row);
    cell.delegate = self;
    
    if ([self._viewType intValue] == 1) {
        cell.choiceImgView.hidden = YES;
        cell.btnView.hidden = YES;
        cell.name.frame = CGRectMake(20, 22, 90, 25);
        cell.identification.frame = CGRectMake(110, 22, 185, 25);
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self._viewType intValue] == 1) {
        TrainPassagerInfo *passInfoItem = [self._passengersInfoArray objectAtIndex:indexPath.row];
        WoyinAddPassagerViewController *trainVC = [[WoyinAddPassagerViewController alloc] init];
        trainVC._isEdit = YES;
        trainVC._delegate = self;
        trainVC._viewType = self._viewType;
        trainVC._passagerData = passInfoItem;
        [NavigationController pushViewController:trainVC animated:YES];
        [trainVC release];
    }
    else {
        PassengersInfoCell *cell = (PassengersInfoCell*)[myTable cellForRowAtIndexPath:indexPath];
        TrainPassagerInfo *passInfoItem = [self._passengersInfoArray objectAtIndex:indexPath.row];
        
        if (passInfoItem._birthDay.length < 10 || !([passInfoItem._sex isEqualToString:@"M"] || [passInfoItem._sex isEqualToString:@"F"])) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写生日和性别信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertView.tag = indexPath.row;
            [alertView show];
            [alertView release];
            return;
        }
        
        NSString *kId = passInfoItem._passengerId;
        BOOL isChecked = !([[self._stateDictionary objectForKey:kId] boolValue]);
        [self._stateDictionary setObject:isChecked?@"1":@"0" forKey:kId];
        cell.btnView.hidden = isChecked ? NO : YES;
    }
}

#pragma mark - UIAlertView代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TrainPassagerInfo *passInfoItem = [self._passengersInfoArray objectAtIndex:alertView.tag];
    WoyinAddPassagerViewController *trainVC = [[WoyinAddPassagerViewController alloc] init];
    trainVC._isEdit = YES;
    trainVC._delegate = self;
    trainVC._viewType = self._viewType;
    trainVC._passagerData = passInfoItem;
    [NavigationController pushViewController:trainVC animated:YES];
    [trainVC release];
}

#pragma mark - UIButton方法实现
- (void)submitList:(id)sender
{
//    for (TrainPassagerInfo * pInfo in [BookingModel shareBookingModel]._passageInfoList) {
//        if ([pInfo._idNo isEqualToString:certNumTextField.text]) {
//            [UIAlertView alertViewWithMessage:@"该常用乘客已添加过！" :@"提示"];
//            return;
//        }
//    }
//    TrainPassagerInfo * info = [[TrainPassagerInfo alloc] init];
//    info._idNo = certNumTextField.text;
//    info._idType = self.selectCert._type;
//    info._passageName = nameTextField.text;
//    info._passengerId = @"";
//    info._passengerType = @"1";
//    info._sex=proBtn.tag==0?@"M":@"F";
//    info._birthDay = birthdayTextField.text;
//    info._seat = [BookingModel shareBookingModel]._selectTrain._selectSeat;
//    info._service = [BookingModel shareBookingModel]._service;
//    [[BookingModel shareBookingModel]._passageInfoList addObject:info];
//    [info release];
    int xcount = 0;
    for (TrainPassagerInfo *passagerInfo in self._passengersInfoArray) {
        if ([[self._stateDictionary objectForKey:passagerInfo._passengerId] boolValue]) {
            xcount ++;
        }
    }
    
    if (xcount > 5) {
        [UIAlertView alertViewWithMessage:@"最多只能订5人"];
        return;
    }
    
    [[BookingModel shareBookingModel]._passageInfoList removeAllObjects];
    for (TrainPassagerInfo *passagerInfo in self._passengersInfoArray) {
        if ([[self._stateDictionary objectForKey:passagerInfo._passengerId] boolValue]) {
            passagerInfo._seat = [BookingModel shareBookingModel]._selectTrain._selectSeat;
            passagerInfo._service = [BookingModel shareBookingModel]._service;
            [[BookingModel shareBookingModel]._passageInfoList addObject:passagerInfo];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addPassenger:(id)sender
{
    WoyinAddPassagerViewController *trainVC = [[WoyinAddPassagerViewController alloc] init];
    trainVC._delegate = self;
    trainVC._viewType = self._viewType;
    [NavigationController pushViewController:trainVC animated:YES];
    [trainVC release];
}

- (void)editClick:(UIButton *)sender
{
    TrainPassagerInfo *passInfoItem = [self._passengersInfoArray objectAtIndex:sender.tag - 100];
    WoyinAddPassagerViewController *trainVC = [[WoyinAddPassagerViewController alloc] init];
    trainVC._isEdit = YES;
    trainVC._delegate = self;
    trainVC._viewType = self._viewType;
    trainVC._passagerData = passInfoItem;
    [NavigationController pushViewController:trainVC animated:YES];
    [trainVC release];
}

#pragma mark -
#pragma mark 数据加载方法
- (void)getPassengersInfo // 获取乘机人列表
{
    if ([self._viewType isEqualToString:@"1"]) {
        
        ASIFormDataRequest * theRequest = [InterfaceClass getPassengerList:[UserInfo sharedUserInfo].userID]; //测试的UserID69743
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(ongetPassengerListPaseredResult:) Delegate:self needUserType:Member];
    }
    else {
        ASIFormDataRequest * theRequest = [InterfaceClass getTrainPasserngerList:[UserInfo sharedUserInfo].userID];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(ongetPassengerListPaseredResult:) Delegate:self needUserType:Member];
    }
}

- (void)ongetPassengerListPaseredResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];

    if ([statusCode isEqualToString:@"0"]) {
        
        if ([self._viewType intValue] == 1) {
            
            [self._passengersInfoArray removeAllObjects];
            NSArray *passengerArr = [dic objectForKey:@"passengerList"];
            for (int i = 0; i < passengerArr.count; i ++) {
                TrainPassagerInfo *item = [TrainPassagerInfo PassengerListInfoWithDic:passengerArr[i]];
                [self._passengersInfoArray addObject:item];
            }
            if (self._passengersInfoArray.count <=0) {
                self._promptlable.hidden = NO;
            }
        }
        else {
            if ([self._actionState intValue] == 1) {
                
                [self._passengersInfoArray removeAllObjects];
                [self._stateDictionary removeAllObjects];
                
                NSArray *passengerArr = [dic objectForKey:@"passengerList"];
                
                for (int i = 0; i < passengerArr.count; i ++) {
                    TrainPassagerInfo *item = [TrainPassagerInfo TrainListInfoWithDic:passengerArr[i]];
                    [self._passengersInfoArray addObject:item];
                    [self._stateDictionary setObject:@"0" forKey:item._passengerId];
                }
                if (self._passengersInfoArray.count <=0) {
                    self._promptlable.hidden = NO;
                }
                for (TrainPassagerInfo *passagerInfo in [BookingModel shareBookingModel]._passageInfoList) {
                    [self._stateDictionary setObject:@"1" forKey:passagerInfo._passengerId];
                }
            }
            else if ([self._actionState intValue] > 1) {
                
                [self._passengersInfoArray removeAllObjects];
                NSArray *passengerArr = [dic objectForKey:@"passengerList"];
                for (int i = 0; i < passengerArr.count; i ++) {
                    TrainPassagerInfo *item = [TrainPassagerInfo TrainListInfoWithDic:passengerArr[i]];
                    [self._passengersInfoArray addObject:item];
                }
                if (self._passengersInfoArray.count <=0) {
                    self._promptlable.hidden = NO;
                }
            }
        }
        
        self._actionState = @"0";
        [myTable reloadData];
    }
}

- (void)addPasserner:(NSString *)pId
{
    self._actionState = @"2";
}

- (void)updatePasserner:(NSString *)pId
{
    self._actionState = @"3";
}

- (void)delPasserner:(NSString *)pId
{
    self._actionState = @"4";
}
@end
