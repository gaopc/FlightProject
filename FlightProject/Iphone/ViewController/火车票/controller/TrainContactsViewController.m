//
//  TrainContactsViewController.m
//  FlightProject
//
//  Created by gaopengcheng on 15-7-17.
//
//

#import "TrainContactsViewController.h"
#import "TrainAddContactsViewController.h"


@interface TrainContactsViewController ()

@end

@implementation TrainContactsViewController
@synthesize _delegate, _personData, _promptlable, _cPersonLabel, _passengersInfoArray;

- (void)dealloc
{
    self._passengersInfoArray = nil;
    self._cPersonLabel = nil;
    self._promptlable = nil;
    self._personData = nil;
    self._delegate = nil;
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    UISubLabel *titleLabel = [UISubLabel labelWithTitle:@"常用联系人列表" frame:CGRectMake(15.0f, 15.0f, 140.0f, 40.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
    titleLabel.textColor = FontColor333333;
    [self.view addSubview:titleLabel];
    
    passengerAddButton = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(ViewWidth - 125, 18.0f, 115.0f, 32.0f) backImage:[UIImage imageNamed:@"addContacts.png"] target:self action:@selector(addPassenger:)];
    [self.view addSubview:passengerAddButton];
    
    self._promptlable = [UISubLabel labelWithTitle:@"您还没有常用联系人，请新增联系人。" frame:CGRectMake(15.0f, 60.0f, ViewWidth - 20, 25.0f) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
    self._promptlable.hidden = YES;
    [self.view addSubview: self._promptlable];
    
    self._cPersonLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(15.0f, 60.0f, ViewWidth - 20, 25.0f) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
    self._cPersonLabel.hidden = YES;
    [self.view addSubview: self._cPersonLabel];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 100.0f, ViewWidth, ViewHeight-145.0f) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    myTable.separatorColor = [UIColor clearColor];
    [self.view addSubview:myTable];
    [myTable release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"常用联系人";
    isRefresh = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (isRefresh) {
        isRefresh = NO;
        [self getPassengersInfo];
    }
}

#pragma mark - 按钮事件
- (void)addPassenger:(UIButton *)sender
{
    if (counts >= maximum) {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"常用联系人最多能保存%d条!", maximum] :@"提示"];
        return;
        
    }
    TrainAddContactsViewController * addContactsVC = [[TrainAddContactsViewController alloc] init];
    addContactsVC._delegate = self;
    [self.navigationController pushViewController:addContactsVC animated:YES];
    [addContactsVC release];
}

-(void)editClick:(id)sender
{
    UIButton *button = (UIButton*)sender;
    PickPersonInfoItem * passengerInfoItem =  (PickPersonInfoItem *)[self._passengersInfoArray objectAtIndex:(button.tag-100)];
    TrainAddContactsViewController * editContactsVC = [[TrainAddContactsViewController alloc] init];
    editContactsVC._editItem = passengerInfoItem;
    editContactsVC._delegate = self;
    [NavigationController pushViewController:editContactsVC animated:YES];
    [editContactsVC release];
}

#pragma mark -
#pragma mark 数据加载方法
- (void)getPassengersInfo // 获取乘机人列表
{
    ASIFormDataRequest * theRequest = [InterfaceClass getPickList:[UserInfo sharedUserInfo].userID]; //测试的UserID69743
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(ongetPassengerListPaseredResult:) Delegate:self needUserType:Member];
}

- (void)ongetPassengerListPaseredResult:(NSDictionary *)dic
{
    [self._passengersInfoArray removeAllObjects];
    PassengerInfoDataResponse *passengerInfoDR = [[[PassengerInfoDataResponse alloc] init] autorelease];
    [passengerInfoDR queryPickPersonInfoList:dic];
    self._passengersInfoArray = passengerInfoDR._pickPersonInfoArray;
    maximum = [passengerInfoDR._maximum intValue];
    if (maximum == 0)
        maximum = 20;
    
    counts = [passengerInfoDR._total intValue];
    if (self._passengersInfoArray.count <=0) {
        self._promptlable.hidden = NO;
        self._cPersonLabel.hidden = YES;
    }else{
        self._promptlable.hidden = YES;
        self._cPersonLabel.hidden = NO;
        self._cPersonLabel.text = [NSString stringWithFormat:@"常用联系人最多能保存%d条，您已经保存了%d条", maximum, counts];
        
    }
    [myTable reloadData];
}

#pragma mark - UITableView方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
    PickPersonInfoItem *passInfo = nil;
    passInfo = (PickPersonInfoItem *)[self._passengersInfoArray objectAtIndex:indexPath.row];
    cell.name.text = passInfo._name;
    cell.identification.text = passInfo._phone;
    cell.editButton.tag = (100+indexPath.row);
    cell.delegate = self;
    if ([self._personData._id intValue] == [passInfo._id intValue])
    {
        cell.btnView.hidden = NO;
        passInfo._selected = @"1";
    }else {
        cell.btnView.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    int i = 0;
//    for (PassengersInfoCell* cell in [myTable visibleCells]) {
//        PickPersonInfoItem *tempPassItem = [self._passengersInfoArray objectAtIndex:i];
//        tempPassItem._selected = @"0";
//        cell.btnView.hidden = YES;
//        i++;
//        tempPassItem = nil;
//        
//    }
//    [myTable deselectRowAtIndexPath:indexPath animated:YES];
    
    PickPersonInfoItem *passInfoItem = [self._passengersInfoArray objectAtIndex:indexPath.row];
    passInfoItem._selected = @"1";
    
    ((PassengersInfoCell*)[myTable cellForRowAtIndexPath:indexPath]).btnView.hidden = NO;
    
    if (self._delegate && [self._delegate respondsToSelector:@selector(selectContacts:)]) {
        [self._delegate performSelector:@selector(selectContacts:) withObject:passInfoItem];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)contactsOver:(id)sender
{
    isRefresh = YES;
}
@end
