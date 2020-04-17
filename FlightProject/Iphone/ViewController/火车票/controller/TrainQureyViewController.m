//
//  TrainQureyViewController.m
//  FlightProject
//
//  Created by 小月 on 13-1-6.
//
//

#import "TrainQureyViewController.h"
#import "InterfaceClass.h"
#import "TrainListInfo.h"
#import "TrainListViewController.h"
#import "CityListViewController.h"
#import "TrainTitleViewCell.h"
#import "StationsViewCell.h"
#import "TrainNumberViewCell.h"
#import "StationsHistoryCell.h"
#import "TrainNumberHistoryCell.h"
#import "MyRegex.h"

@interface TrainQureyViewController ()

@end

@implementation TrainQureyViewController
@synthesize myTable,stationsHistory,trainNumHistory,currentViewTag,startStation,endStation,trainNumber,searchType,server,buttonSelect,keyboardbar,textFieldArray,trainListInfo,myTextField,startStationBtn,endStationBtn;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.myTable = nil;
    self.stationsHistory = nil;
    self.trainNumHistory = nil;
    self.startStation = nil;
    self.endStation = nil;
    self.trainNumber = nil;
    self.searchType = nil;
    self.buttonSelect = nil;
    self.keyboardbar = nil;
    self.textFieldArray = nil;
    self.trainListInfo = nil;
    self.myTextField = nil;
    self.startStationBtn = nil;
    self.endStationBtn = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"列车查询";
    // Do any additional setup after loading the view.
    self.currentViewTag = 0;
    
    self.startStation = @"北京";
    self.endStation = @"上海";
    self.trainNumber = @"t108";
    self.trainNumber = [self.trainNumber uppercaseString];
    
    self.stationsHistory = [NSArray arrayWithArray:[DataClass selectFromTrain_Station_History]];
    self.trainNumHistory = [NSArray arrayWithArray:[DataClass selectFromTrain_Num_History]];
    
    self.trainNumber = @"";
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTable];
    [myTable release];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.stationsHistory = [NSArray arrayWithArray:[DataClass selectFromTrain_Station_History]];
    self.trainNumHistory = [NSArray arrayWithArray:[DataClass selectFromTrain_Num_History]];
    [myTable reloadData];
}

-(void)changeModel:(UIButton *)sender
{
    if([self.textFieldArray count] == 1)
    {
        [keyboardbar HiddenKeyBoard];
        [[self.textFieldArray objectAtIndex:0] resignFirstResponder];
    }
    switch (sender.tag) {
        case 0:
            currentViewTag = 0;
            break;
        case 1:
            currentViewTag = 1;
            break;
        default:
            break;
    }
    [self.myTable reloadData];
}

-(void)stationsChange:(UIButton*)sender
{
    NSString *str = startStation;
    self.startStation = endStation;
    self.endStation = str;

    [self.myTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)selectStation:(UIButton*)sender{
    
    self.buttonSelect = [NSString stringWithFormat:@"%d",sender.tag];

    NSArray * array =  [DataClass selectFromTrainCitysList];
    if ( [GetConfiguration shareGetConfiguration].needUpdateTrainCitysList || [array count] == 0) {
        GetBasicInfoFromServer *temp = [[GetBasicInfoFromServer alloc] init];
        temp.cityDelegate = self;
        self.server = temp;
        [self.server getTrainCitysList];
        [temp release];
    }
    else {
        [self didCityInfoResult:array];
    }
}
- (void)didCityInfoResult:(NSArray *)cityArray
{
    CityListViewController * cityListVC = [[CityListViewController alloc] init];
    cityListVC.citysArray = cityArray;
    cityListVC.title = [self.buttonSelect intValue]==0?@"选择出发":@"选择到达";
    cityListVC.cityType = TrainCityList;
    cityListVC.delegate = self;
    [NavigationController pushViewController:cityListVC animated:YES];
    [cityListVC release];
}

-(void)didSelectedCityFinshed:(id)city
{
    TrainCitysList * _city = (TrainCitysList *)city;
    if([self.buttonSelect intValue] == 0)
    {
        self.startStation = _city._city_name;
    }
    else
    {
        self.endStation = _city._city_name;
    }
    
    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)searchTrain:(UIButton*)sender
{
    self.searchType = self.currentViewTag==0?@"0":@"1";
    if(sender.tag != 99)
    {
        if(self.currentViewTag == 0)
        {
            self.startStation = [[self.stationsHistory objectAtIndex:sender.tag] objectAtIndex:0];
            self.endStation = [[self.stationsHistory objectAtIndex:sender.tag] objectAtIndex:1];
        }
        else
        {
            self.trainNumber = [[self.trainNumHistory objectAtIndex:sender.tag] objectAtIndex:2];
        }
    }
    else
    {
        if(self.currentViewTag == 1)
        {
            self.trainNumber = self.myTextField.text;
            if (![self.trainNumber isMatchedByRegex:PASSPORT_CARD]) {
                [UIAlertView alertViewWithMessage:@"请输入正确的车次"];
                return;
            }
        }
        else
        {
            self.startStation = self.startStationBtn.titleLabel.text;
            self.endStation = self.endStationBtn.titleLabel.text;
            if([startStation isEqualToString:endStation])
            {
                [UIAlertView alertViewWithMessage:@"出发城市和到达城市相同，请重新选择"];
                return;
            }
        }
    }
    ASIFormDataRequest * theRequest = [InterfaceClass searchTrain:startStation endStation:endStation trainNumber:trainNumber searchType:searchType];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSearchTrainResult:) Delegate:self needUserType:Default];
}

-(void)onSearchTrainResult:(NSDictionary*)dic
{
    NSArray *array = [TrainListInfo setTrainListInfo:dic];
    if([array count] == 0)
    {
        if(self.currentViewTag == 0)
            [UIAlertView alertViewWithMessage:@"没有找到符合条件的直达车辆，请重新查询"];
        else
            [UIAlertView alertViewWithMessage:@"没有找到您查询的车次，请重新查询"];
        
        return;
    }
    self.trainListInfo = (TrainListInfo*)[array objectAtIndex:0];
    if(self.currentViewTag == 0)
    {
        NSArray *array1 = [NSArray arrayWithObjects:[NSArray arrayWithObjects:self.startStation,self.endStation,[NSString stringWithFormat:@""],nil], nil];
        [DataClass insertIntoTrain_Station_HistoryWithArray:array1];
    }
    else
    {
        self.trainNumber = [self.trainNumber uppercaseString];
        if([array count] > 1)
        {
            NSArray *array2 = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"",@"",self.trainNumber,nil], nil];
            [DataClass insertIntoTrain_Num_HistoryWithArray:array2];
        }
        else
        {
            self.trainNumber = [self.trainListInfo._trainNumber uppercaseString];
            NSArray *array2 = [NSArray arrayWithObjects:[NSArray arrayWithObjects:self.trainListInfo._originatingStation,self.trainListInfo._terminalStation,self.trainNumber,nil], nil];
            [DataClass insertIntoTrain_Num_HistoryWithArray:array2];
        }

    }
    
    if([array count] > 1)
    {
        TrainListViewController *trainListVC = [[TrainListViewController alloc] init];
        trainListVC.data = (NSMutableArray*)[TrainListInfo setTrainListInfo:dic];
        trainListVC.filterDataArray = (NSMutableArray*)[TrainListInfo setTrainListInfo:dic];
        trainListVC.searchType = self.searchType;
        trainListVC.startStation = self.startStation;
        trainListVC.endStation = self.endStation;
        [NavigationController pushViewController:trainListVC animated:YES];
        [trainListVC release];
    }
    else
    {
        ASIFormDataRequest * theRequest = [InterfaceClass searchTrainDetail:self.trainListInfo._trainNumber];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onTrainDetailsResult:) Delegate:self needUserType:Default];
    }
    
}

- (void)onTrainDetailsResult:(NSDictionary *)dic
{
    TrainTicketInfoViewController *trainDetailVC = [[TrainTicketInfoViewController alloc] init];
    trainDetailVC.title = self.trainListInfo._trainNumber;
    trainDetailVC.stationInfoArray = (NSMutableArray *)[SearchTrainDetail setTrainDetailInfo:dic];//接口有问题
    trainDetailVC.trainListInfo = self.trainListInfo;
    trainDetailVC.searchType = self.searchType;
    [NavigationController pushViewController:trainDetailVC animated:YES];
    [trainDetailVC release];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (self.keyboardbar == nil) {
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
		
	}
    else
    {
        [keyboardbar setTextFields:self.textFieldArray];
    }
	[keyboardbar showBar:textField];  //显示工具条
	return  YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//{  //string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反
//    NSLog(@"range.location %d ",range.location);
//    NSLog(@"string %@ ",string);
//	
//    if ( string.length == 0)
//    {
//        return YES;
//    }
//    NSLog(@"textField.text %@ ",textField.text);
//    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
//    if (![toBeString isEqualToString:textField.text] && ![textField.text isEqualToString:@""]) {
//	toBeString = textField.text;
//    }
//    if (![toBeString isMatchedByRegex:PASSPORT_CARD]) {
//        return NO;
//    }
//    if ([toBeString length] >= 5) { 
//        textField.text = [toBeString substringToIndex:5];
//        return NO;
//    }
//    return YES;
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString * textFieldStr = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
	switch (textField.tag) {
		case 100:
		{
			textFieldMaxLenth = 5;
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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.trainNumber = textField.text;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section == 0) {
        return 0;
    }
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *str = @"";
    if(self.currentViewTag == 0)
    {
        if([self.stationsHistory count] > 0)
            str = @"历史查询";
    }
    else
    {
        if([self.trainNumHistory count] > 0)
            str = @"历史查询";
    }
    
    return [UISubLabel labelWithTitle:str frame: CGRectMake(0, 0, ViewWidth, 30) font:FontSize24 color:FontColor636363 alignment:NSTextAlignmentCenter];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 60;
        }
        else if(indexPath.row == 1)
        {
            return 140;
        }
    }
    return 60;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    else {
        if(currentViewTag == 0)
        {
            return ([self.stationsHistory count]%2)==(0)?([self.stationsHistory count]/2):([self.stationsHistory count]/2+1);
        }
        else {
            return ([self.trainNumHistory count]%2)==(0)?([self.trainNumHistory count]/2):([self.trainNumHistory count]/2+1);
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString * trainTitleViewIdentifier = @"trainTitleViewIdentifier";
            TrainTitleViewCell * cell = [tableView dequeueReusableCellWithIdentifier:trainTitleViewIdentifier];
            if (cell == nil) {
                cell = [[[TrainTitleViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:trainTitleViewIdentifier] autorelease];
            }
            if (self.currentViewTag == 0) {
                cell.titleBackGround.image = [UIImage imageNamed:@"查询页站站.png"];
            }
            else
            {
                cell.titleBackGround.image = [UIImage imageNamed:@"查询页车次.png"];
            }
            [cell.stationsButton addTarget:self action:@selector(changeModel:) forControlEvents:UIControlEventTouchUpInside];
            [cell.trainNumberButton addTarget:self action:@selector(changeModel:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell ;
        }
        else if(indexPath.row == 1)
        {
            if(self.currentViewTag == 0)
            {
                static NSString * stationsViewIdentifier = @"stationsViewIdentifier";
                StationsViewCell * cell = [tableView dequeueReusableCellWithIdentifier:stationsViewIdentifier];
                if (cell == nil) {
                    cell = [[[StationsViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:stationsViewIdentifier] autorelease];
                }
                [cell.stationsChange addTarget:self action:@selector(stationsChange:) forControlEvents:UIControlEventTouchUpInside];
                [cell.startStationButton addTarget:self action:@selector(selectStation:) forControlEvents:UIControlEventTouchUpInside];
                [cell.endStationButton addTarget:self action:@selector(selectStation:) forControlEvents:UIControlEventTouchUpInside];
                [cell.startStationButton setTitle:self.startStation forState:UIControlStateNormal];
                [cell.endStationButton setTitle:self.endStation forState:UIControlStateNormal];
                cell.startStationButton.tag = 0;
                cell.endStationButton.tag= 1;
                self.startStationBtn = cell.startStationButton;
                self.endStationBtn = cell.endStationButton;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell ;
            }
            else
            {
                static NSString * trainNumberViewIdentifier = @"trainNumberViewIdentifier";
                TrainNumberViewCell * cell = [tableView dequeueReusableCellWithIdentifier:trainNumberViewIdentifier];
                if (cell == nil) {
                    cell = [[[TrainNumberViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:trainNumberViewIdentifier] autorelease];
                }
                cell.trainNumberText.tag = 100;
                cell.trainNumberText.delegate = self;
                cell.trainNumberText.returnKeyType = UIReturnKeyDefault;
                cell.trainNumberText.clearButtonMode = UITextFieldViewModeWhileEditing;
                cell.trainNumberText.keyboardType = UIKeyboardTypeASCIICapable;
                cell.trainNumberText.secureTextEntry = YES;
                cell.trainNumberText.secureTextEntry = NO;
                
                
                cell.trainNumberText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //对齐方式
                cell.trainNumberText.autocapitalizationType = UITextAutocapitalizationTypeWords; //首字母大写
                self.textFieldArray = [NSArray arrayWithObject:cell.trainNumberText];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                self.myTextField = cell.trainNumberText;
                return cell ;
            }
        }
        else{
            static NSString * sectionOneSearchIdentifier = @"sectionOneSearchIdentifier";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:sectionOneSearchIdentifier];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionOneSearchIdentifier] autorelease];
                if(self.currentViewTag == 0)
                {
                    [cell.contentView addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:99 title:nil frame:CGRectMake((ViewWidth-226)/2, 2, ViewWidth-94, 45) backImage:[UIImage imageNamed:@"WhenRealQuery.png"]  target:self action:@selector(searchTrain:)]];
                }
                else
                {
                    [cell.contentView addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:99 title:nil frame:CGRectMake((ViewWidth-226)/2, 2, ViewWidth-94, 45) backImage:[UIImage imageNamed:@"WhenRealQuery.png"]  target:self action:@selector(searchTrain:)]];
                }
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.backgroundColor = [UIColor clearColor];

            return cell ;
        }
    }
    else {
        if(self.currentViewTag == 0)
        {
            static NSString *thirdSectionIdentifier2 = @"thirdSectionIdentifier2";
            StationsHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdSectionIdentifier2];
            if(cell == nil){
                cell = [[[StationsHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdSectionIdentifier2] autorelease];
            }
            int thenum = indexPath.row*2;
        
            [cell.leftButton setTitle:[NSString stringWithFormat:@"%@-%@",[[self.stationsHistory objectAtIndex:thenum] objectAtIndex:0],[[self.stationsHistory objectAtIndex:thenum] objectAtIndex:1]] forState:UIControlStateNormal];
            cell.leftButton.tag = thenum;
            [cell.leftButton addTarget:self action:@selector(searchTrain:) forControlEvents:UIControlEventTouchUpInside];
            if (!([self.stationsHistory count] % 2 == 1 && [self.stationsHistory count] - thenum == 1)) {
                [cell.rightButton setTitle:[NSString stringWithFormat:@"%@-%@",[[self.stationsHistory objectAtIndex:thenum+1] objectAtIndex:0],[[self.stationsHistory objectAtIndex:thenum+1] objectAtIndex:1]] forState:UIControlStateNormal];
                [cell.rightButton addTarget:self action:@selector(searchTrain:) forControlEvents:UIControlEventTouchUpInside];
                cell.rightButton.tag = thenum+1;
                [cell.rightButton setHidden:NO];
            }
            else
            {
                [cell.rightButton setHidden:YES];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
       else
       {
           static NSString *trainNumberHistorydentifier = @"trainNumberHistorydentifier";
           TrainNumberHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:trainNumberHistorydentifier];
           if(cell == nil){
               cell = [[[TrainNumberHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:trainNumberHistorydentifier] autorelease];
           }
           int thenum = indexPath.row*2;
           
           if(((NSString*)[[self.trainNumHistory objectAtIndex:thenum] objectAtIndex:0]).length == 0 )
           {
               cell.leftNumber.frame = CGRectMake(15, 0, ViewWidth/2-30, 48);
               cell.leftNumber.text = [[self.trainNumHistory objectAtIndex:thenum] objectAtIndex:2];
               cell.leftStation.hidden = YES;
            }
           else
           {
               cell.leftNumber.frame = CGRectMake(8,9,ViewWidth/2-14,15);
               cell.leftStation.frame = CGRectMake(8,28,ViewWidth/2-14,12);
               cell.leftStation.hidden = NO;
               cell.leftNumber.text = [[self.trainNumHistory objectAtIndex:thenum] objectAtIndex:2];
               cell.leftStation.text = [NSString stringWithFormat:@"%@-%@",[[self.trainNumHistory objectAtIndex:thenum] objectAtIndex:0],[[self.trainNumHistory objectAtIndex:thenum] objectAtIndex:1]];
           }
           [cell.leftButton addTarget:self action:@selector(searchTrain:) forControlEvents:UIControlEventTouchUpInside];
           cell.leftButton.tag = thenum;
           if (!([self.trainNumHistory count] % 2 == 1 && [self.trainNumHistory count] - thenum == 1)) {
               if(((NSString*)[[self.trainNumHistory objectAtIndex:thenum+1] objectAtIndex:0]).length == 0)
               {
                   cell.rightNumber.frame = CGRectMake(ViewWidth/2+6, 0, ViewWidth/2-30, 48);
                   cell.rightNumber.text = [[self.trainNumHistory objectAtIndex:thenum+1] objectAtIndex:2];
                   cell.rightStation.hidden = YES;
               }
               else
               {
                   cell.rightNumber.frame = CGRectMake(ViewWidth/2-1,9,ViewWidth/2-14,15);
                   cell.rightStation.frame = CGRectMake(ViewWidth/2-1,28,ViewWidth/2-14,12);
                   cell.rightStation.hidden = NO;
                   cell.rightNumber.text = [[self.trainNumHistory objectAtIndex:thenum+1] objectAtIndex:2];
                   cell.rightStation.text = [NSString stringWithFormat:@"%@-%@",[[self.trainNumHistory objectAtIndex:thenum+1] objectAtIndex:0],[[self.trainNumHistory objectAtIndex:thenum+1] objectAtIndex:1]];
               }
               [cell.rightButton addTarget:self action:@selector(searchTrain:) forControlEvents:UIControlEventTouchUpInside];
               cell.rightButton.tag = thenum+1;
               
               [cell.rightButton setHidden:NO];
               [cell.rightNumber setHidden:NO];
           }
           else
           {
               [cell.rightButton setHidden:YES];
               [cell.rightNumber setHidden:YES];
               [cell.rightStation setHidden:YES];
           }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           return cell;
       }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
