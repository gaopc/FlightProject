//
//  CarPassengerListViewController.m
//  FlightProject
//
//  Created by gaopengcheng on 13-5-3.
//
//

#import "CarPassengerListViewController.h"
#import "CarVerificationViewController.h"

@interface CarPassengerListViewController ()

@end

@implementation CarPassengerListViewController
@synthesize isEmpty, selectRow, data;
@synthesize queryDataModel, selectedCarDetail;
@synthesize gateway;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    self.data = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    selectRow = -1;
	
    UISubLabel *titleLabel = [UISubLabel labelWithTitle:@"常用租车人列表" frame:CGRectMake(15.0f, 15.0f, 140.0f, 40.0f) font:FontSize32 alignment:NSTextAlignmentLeft];
	titleLabel.textColor = FontColor333333;
	[self.view addSubview:titleLabel];
	
	addPassenger = [UIButton buttonWithType:UIButtonTypeCustom tag:10 title:@"" frame:CGRectMake(ViewWidth - 130, 18.0f, 115.0f, 32.0f) backImage:[UIImage imageNamed:@"新增租车人.png"] target:self action:@selector(addPassenger:)];
	[self.view addSubview:addPassenger];
	
	myTale = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 60.0f, ViewWidth, ViewHeight-122.0f) style:UITableViewStylePlain];
	myTale.backgroundColor = [UIColor clearColor];
	myTale.dataSource = self;
	myTale.delegate = self;
	myTale.separatorColor = [UIColor clearColor];
    
    mylable = [UISubLabel labelWithTitle:@"您还没有常用租车人，请新增租车人。" frame:CGRectMake(15.0f, 60.0f, ViewWidth - 20, 25.0f) font:FontSize26 color:FontColor333333 alignment:NSTextAlignmentLeft];
    mylable.hidden = YES;
    
    [self.view addSubview: mylable];
    [self.view addSubview:myTale];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    selectRow = -1;
    ASIFormDataRequest * theRequest = [InterfaceClass getCarRentalList:[UserInfo sharedUserInfo].userID];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onGetCarRentalListResult:) Delegate:self needUserType:Default];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarPassengersResponse *carPasspersInfo = nil;
    if ([self.data count] > 0) {
        carPasspersInfo = [self.data objectAtIndex:indexPath.row];
    }
    
    NSString * identifier = [NSString stringWithFormat:@"identifier%d", indexPath.row];
    CarPassengerCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[CarPassengerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell._selectName addTarget:self action:@selector(editPassenger:) forControlEvents:UIControlEventTouchUpInside];
        cell._selectName.tag = indexPath.row;
    }
    
    cell._name.text = carPasspersInfo._name;
    cell._cerNum.text = carPasspersInfo._identityNumber;
    
    if ([gateway intValue] == 0) {
        if (selectRow == indexPath.row) {
            cell._selectImg.hidden = NO;
        }
        else {
            cell._selectImg.hidden = YES;
        }
    }
    else {
        cell._unSelectImg.hidden = YES;
        cell._selectImg.hidden = YES;
        cell._name.frame = CGRectMake(25, 11, 80, 20);
    }
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
	
	return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
        CarPassengersResponse *passengersInfo = [self.data objectAtIndex:indexPath.row];
		[self loadDelDataSource : passengersInfo._id];
		[self.data removeObjectAtIndex:indexPath.row];
		[myTale deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		
	}
	else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	}
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell点击事件");
    
    if ([gateway intValue] == 0) {
        selectRow = indexPath.row;
        [myTale reloadData];
        
        CarPassengersResponse *passengersInfo = [self.data objectAtIndex:indexPath.row];
        self.queryDataModel._userId = [UserInfo sharedUserInfo].userID;
        self.queryDataModel._name = passengersInfo._name;
        self.queryDataModel._identityNumber = passengersInfo._identityNumber;
        self.queryDataModel._mobileNumber = passengersInfo._tel;
//
//        ASIFormDataRequest * theRequest = [InterfaceClass queryCarService:self.queryDataModel];
//        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onQueryCarServicePaseredResult:) Delegate:self needUserType:Default];
        
        CarVerificationViewController *verificationVC = [[CarVerificationViewController alloc] init];
        verificationVC._carInfo = self.queryDataModel;
        verificationVC._selectedCarDetail = self.selectedCarDetail;
        [self.navigationController pushViewController:verificationVC animated:YES];
        [verificationVC release];
    }
    else {
        NSLog(@"编辑租车人");
        CarPassengerViewController * carPassengerVC = [[CarPassengerViewController alloc] init];
        carPassengerVC.gateway = self.gateway;
        carPassengerVC.actionType = @"1";
        carPassengerVC.carPassengersInfo = [self.data objectAtIndex:indexPath.row];
        carPassengerVC.carDetail = self.selectedCarDetail;
        carPassengerVC.queryDataModel = self.queryDataModel;
        [NavigationController pushViewController:carPassengerVC animated:YES];
        [carPassengerVC release];
    }
}

#pragma mark - Self
- (void)editPassenger:(UIButton *)sender
{
    NSLog(@"编辑租车人");
    CarPassengerViewController * carPassengerVC = [[CarPassengerViewController alloc] init];
    carPassengerVC.gateway = self.gateway;
    carPassengerVC.actionType = @"1";
    carPassengerVC.carPassengersInfo = [self.data objectAtIndex:sender.tag];
    carPassengerVC.carDetail = self.selectedCarDetail;
    carPassengerVC.queryDataModel = self.queryDataModel;
    [NavigationController pushViewController:carPassengerVC animated:YES];
    [carPassengerVC release];
}

- (void)addPassenger:(id)sender
{
    NSLog(@"新增租车人");
    CarPassengerViewController * carPassengerVC = [[CarPassengerViewController alloc] init];
    carPassengerVC.gateway = self.gateway;
    carPassengerVC.actionType = @"0";
    carPassengerVC.carDetail = self.selectedCarDetail;
    carPassengerVC.queryDataModel = self.queryDataModel;
    [NavigationController pushViewController:carPassengerVC animated:YES];
    [carPassengerVC release];
}

- (void)onGetCarRentalListResult:(NSDictionary *)dic
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([[dic objectForKey:@"statusCode"] intValue] == 0) {
            self.data = (NSMutableArray *)[CarPassengersResponse CarPassengersList:dic];
            
            if ([self.data count] == 0) {
                mylable.hidden = NO;
                [myTale reloadData];
            }
            else {
                mylable.hidden = YES;
                [myTale reloadData];
            }
        }
        else if ([[dic objectForKey:@"statusCode"] intValue] == 100) {
            mylable.hidden = NO;
            [myTale reloadData];
        }
        else {
            [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
        }
    }
    
}

- (void)loadDelDataSource :(NSString *)orderId
{
    ASIFormDataRequest * theRequest = [InterfaceClass removeCarRental:[UserInfo sharedUserInfo].userID orderId:orderId];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onRemoveCarRentalResult:) Delegate:self needUserType:Member];
}

- (void)onRemoveCarRentalResult:(NSDictionary *)dic
{
    if ([self.data count] == 0) {
        mylable.hidden = NO;
    }
}

-(void)onQueryCarServicePaseredResult:(NSDictionary *)resultDic
{
    QueryCarServiceResponse * carServiceRes = [QueryCarServiceResponse QueryCarServiceResponse:resultDic];
    CarServicesViewController * carServicesVC = [[CarServicesViewController alloc] init];
    carServicesVC.carDetail = self.selectedCarDetail;
    carServicesVC.carService = carServiceRes;
    carServicesVC.queryDataModel = self.queryDataModel;
    [NavigationController pushViewController:carServicesVC animated:YES];
    [carServicesVC release];
}
@end
