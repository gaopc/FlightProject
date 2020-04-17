//
//  TaxiDatePickerViewController.m
//  FlightProject
//
//  Created by longcd mac mini 04 on 12-10-25.
//
//

#import "TaxiDatePickerViewController.h"
#import "TaxiHomeViewController.h"
#import "CustomScorllView.h"

@interface TaxiDatePickerViewController ()

@end

@implementation TaxiDatePickerViewController
@synthesize dateType,startDateTicketQueryDataModel,backDateTicketQueryDataModel;
@synthesize delegate;
@synthesize startTimeRange,backTimeRange,pushBackDay;
@synthesize _backDateCode,_backDateName,_startDateCode,_startDateName;
-(void)dealloc
{
    self.startDateTicketQueryDataModel = nil;
    self.backDateTicketQueryDataModel = nil;
    self.delegate = nil;
    self.startTimeRange = nil;
    self.backTimeRange = nil;
    self._startDateName = nil;
    self._startDateCode = nil;
    self._backDateCode = nil;
    self._backDateName = nil;
    [tempDate release];
    [currentDateStr release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//创建日历视图
-(void)createCalendarView
{
    tempDate = nil;
    showMonths = 0;
    showDays = 0;
    int temp = 0;
    if (self.dateType == StarDate)
    {
	    //tempDate = [[self.startDateTicketQueryDataModel._nameCode componentsSeparatedByString:@" "] objectAtIndex:0];
        tempDate = [[NSString alloc] initWithString:[[self._startDateCode componentsSeparatedByString:@" "] objectAtIndex:0]];
	    self.pushBackDay = PushBackNOneDay;
        showMonths = 1;
        showDays = 0;
    }
        
    if (self.dateType == BackDate)
    {
        tempDate = [[NSString alloc] initWithString:[[self._backDateCode componentsSeparatedByString:@" "] objectAtIndex:0]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
        NSLog(@"%@", strDate);
        [dateFormatter release];
        
        temp = [NSDate dayInterval:[NSDate dateFromString:strDate] withEndDay:[NSDate dateFromString:[[self._startDateCode componentsSeparatedByString:@" "] objectAtIndex:0]]];
        
	    self.pushBackDay = PushBackZeroDay;
        showMonths = 0;
        showDays = 89 + temp;
    }
	customScorllView.hidden = YES;
//    [calendarView removeFromSuperview];
//    calendarView = [[CalendarView alloc] initWithNSDate:[NSDate dateFromString:tempDate] allowShowMonths:showMonths withDayCount:showDays withPushBackDay:self.pushBackDay] ;
//    calendarView.frame = downView.bounds;
//    calendarView.delegate = self;
//    [downView addSubview:calendarView];
//    [calendarView release];
    
    [myTable removeFromSuperview];
    myTable = [[UITableView alloc] initWithFrame:downView.bounds style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.allowsSelection = YES;
    myTable.dataSource = self;
    myTable.delegate = self;
    [downView addSubview:myTable];
    [myTable release];
}
//创建时间段选择器
-(void)createAlertSubViewWithDataArray:(NSString *)dataRange selectStr:(NSString *)str
{
    NSMutableArray * array = [NSMutableArray array];
    NSString *defultStart = [[dataRange componentsSeparatedByString:@"-"] objectAtIndex:0];
    NSString * defultEnd =  [[dataRange componentsSeparatedByString:@"-"] objectAtIndex:1];
    while (1) {
        [array addObject:defultStart];
        NSInteger defultStartHore = [[[defultStart componentsSeparatedByString:@":"] objectAtIndex:0] intValue];
        NSInteger defultStartTime = [[[defultStart componentsSeparatedByString:@":"] objectAtIndex:1] intValue];
        defultStartTime += 30;
        defultStartHore += defultStartTime / 60;
        defultStartTime = defultStartTime % 60;
        defultStart = [NSString stringWithFormat:@"%02ld:%02d",(long)defultStartHore,defultStartTime];
        if ([defultStart compare:defultEnd] > 0) {
            NSString * lastArrayObject = [array lastObject];
            if ([defultEnd compare:lastArrayObject] > 0) {
                [array addObject:defultEnd];
            }
            break;
        }
    }

    myTable.hidden = YES;
    [customScorllView removeFromSuperview];
    customScorllView = [[CustomScorllView alloc] initWithTitle:@"时段选择" centerTitles:array frame:downView.bounds selectStr:str];
    customScorllView.delegate = self;
    [downView addSubview:customScorllView];
    [customScorllView release];    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"时间选择";
    UIButton  * rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(10, 7, 52, 30) backImage:[UIImage imageNamed:@"CompleteButton.png"] target:self action:@selector(finishSelect:)];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 130)];
    [self.view addSubview:upView];
    [upView release];
    
    self._startDateName = self.startDateTicketQueryDataModel._nameStr;
    self._startDateCode = self.startDateTicketQueryDataModel._nameCode;
    self._backDateName = self.backDateTicketQueryDataModel._nameStr;
    self._backDateCode = self.backDateTicketQueryDataModel._nameCode;
    
    downView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, ViewWidth, ViewHeight - 44 - 80)];
    downView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:downView];
    [downView release];
    [self createCalendarView];
    
    NSArray * labelTitleArray = [NSArray arrayWithObjects:@"取车日期",@"取车时段",@"还车日期",@"还车时段", nil];
    // 09月-28日-周五-10:00
    NSArray * startArray = [self.startDateTicketQueryDataModel._nameStr componentsSeparatedByString:@"-"];
    NSArray * backArray = [self.backDateTicketQueryDataModel._nameStr componentsSeparatedByString:@"-"];
    
    NSArray * buttonTitleArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@%@日",[startArray objectAtIndex:0],[startArray objectAtIndex:1]],[NSString stringWithFormat:@"%@",[startArray objectAtIndex:3]],[NSString stringWithFormat:@"%@%@日",[backArray objectAtIndex:0],[backArray objectAtIndex:1]],[NSString stringWithFormat:@"%@",[backArray objectAtIndex:3]], nil];
    
    for (int i = 0; i < [labelTitleArray count]; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom  tag:i+11 title:[buttonTitleArray objectAtIndex:i] backImage:[UIImage imageNamed:self.dateType == StarDate? i==0?@"carDataTitleSelected.png":@"carDataTitleUnSelected.png":i==2?@"carDataTitleSelected.png":@"carDataTitleUnSelected.png"  ] frame:CGRectMake(40+i%2*150, 6+ i/2*35, 120, 30)  font:FontSize32  color:FontColor333333 target:self action:@selector(selectDateTime:)];
        [upView addSubview: button];
        
        [upView addSubview:[UISubLabel labelWithTitle:[labelTitleArray objectAtIndex:i] frame:CGRectMake(10+i%2*150,6 + i/2*35,30,30) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        
        if (self.dateType == StarDate) {
            if (i == 0) {
                currentButton = button;
            }
        }
        else {
            if (i == 2) {
                currentButton = button;
            }
        }
        [currentButton setTitleColor:FontColor2585CF forState:UIControlStateNormal];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    currentDateStr = [[NSString alloc] initWithString:[dateFormatter stringFromDate:[NSDate date]]];
    [dateFormatter release];
}

- (void)viewDidAppear:(BOOL)animated
{
    int rowIndex = [self compareMonth:tempDate];
    if (rowIndex != 0) {
        NSIndexPath *lastRow = [NSIndexPath indexPathForRow:rowIndex inSection:0];
        [myTable scrollToRowAtIndexPath:lastRow
                       atScrollPosition:UITableViewScrollPositionBottom
                               animated:YES];
    }
}

#pragma mark - IBActionEvent

-(void)selectDateTime:(UIButton *)sender
{
    [currentButton setTitleColor:FontColor909090 forState:UIControlStateNormal];
    [currentButton setBackgroundImage:[UIImage imageNamed:@"carDataTitleUnSelected.png"]forState:UIControlStateNormal];
    
    currentButton = sender;
    [currentButton setTitleColor:FontColor2585CF forState:UIControlStateNormal];
    [currentButton setBackgroundImage:[UIImage imageNamed:@"carDataTitleSelected.png"]forState:UIControlStateNormal];
    
    if (sender.tag < 13) {
        self.dateType = StarDate;
    }
    else {
        self.dateType = BackDate;
    }
    
    if (sender.tag %2 == 0)  
    {
        if (sender.tag == 12) {
            [self createAlertSubViewWithDataArray:self.startTimeRange selectStr:[sender titleForState:UIControlStateNormal]];
        }
        else {
             [self createAlertSubViewWithDataArray:self.backTimeRange selectStr:[sender titleForState:UIControlStateNormal]];
        }
    }
    else
    {
         [self createCalendarView];
    }
}

#pragma mark - calendarViewDelegate
//代理方法 点击按钮后颜色改变
-(void)calendarView:(CalendarView *)acalendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated
{
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [acalendarView markDates:dates];
    }
    
}
//代理方法 点击按钮后获取日期
-(void)calendarView:(CalendarView *)acalendarView dateSelected:(NSDate *)date
{
    NSArray * dataStrArray = nil;
    NSString *dateStr = nil;
    NSString *dateCode = nil;
    
    if (self.dateType == StarDate) {
        
//        dataStrArray = [self.startDateTicketQueryDataModel._nameStr componentsSeparatedByString:@"-"];
//        dateStr = [NSString stringWithFormat:@"%@-%@",[NSDate dateFormateCarQuery:date],[dataStrArray objectAtIndex:3]];// 09月-28-周五-10:00
//        dateCode =[NSString stringWithFormat:@"%@ %@",[NSDate dateCode:date],[dataStrArray objectAtIndex:3]];// yyyy-MM-dd 10:00
//        
//        self.startDateTicketQueryDataModel._nameStr = dateStr;
//        self.startDateTicketQueryDataModel._nameCode = dateCode;
//        
//        //compare 逐字比较
//        if ([self.backDateTicketQueryDataModel._nameCode compare:dateCode] <0 ) {
//            self.backDateTicketQueryDataModel._nameStr =[NSString stringWithFormat:@"%@-%@", [NSDate dateafterDay:date day:Delay_Days-1 type:4],[dataStrArray objectAtIndex:3]]; // 09月-28-周五-10:00
//            self.backDateTicketQueryDataModel._nameCode = [NSString stringWithFormat:@"%@ %@",[NSDate dateafterDay:date day:Delay_Days-1 type:1],[dataStrArray objectAtIndex:3]];// yyyy-MM-dd 10:00
//            NSArray * dateArray = [self.backDateTicketQueryDataModel._nameStr componentsSeparatedByString:@"-"]; // 09月-28-周五-10:00
//            NSString *  buttonTitle = [NSString stringWithFormat:@"%@%@日",[dateArray objectAtIndex:0],[dateArray objectAtIndex:1]];
//            UIButton * button = (UIButton *) [upView viewWithTag:13];
//            [button setTitle:buttonTitle forState:UIControlStateNormal];
        //        }
        dataStrArray = [self._startDateName componentsSeparatedByString:@"-"];
        dateStr = [NSString stringWithFormat:@"%@-%@",[NSDate dateFormateCarQuery:date],[dataStrArray objectAtIndex:3]];// 09月-28-周五-10:00
        dateCode =[NSString stringWithFormat:@"%@ %@",[NSDate dateCode:date],[dataStrArray objectAtIndex:3]];// yyyy-MM-dd 10:00
        
        self._startDateName = dateStr;
        self._startDateCode = dateCode;
        
        //compare 逐字比较
        if ([self._backDateCode compare:dateCode] <0 ) {
            self._backDateName =[NSString stringWithFormat:@"%@-%@", [NSDate dateafterDay:date day:Delay_Days-1 type:4],[dataStrArray objectAtIndex:3]]; // 09月-28-周五-10:00
            self._backDateCode = [NSString stringWithFormat:@"%@ %@",[NSDate dateafterDay:date day:Delay_Days-1 type:1],[dataStrArray objectAtIndex:3]];// yyyy-MM-dd 10:00
            NSArray * dateArray = [self._backDateName componentsSeparatedByString:@"-"]; // 09月-28-周五-10:00
            NSString *  buttonTitle = [NSString stringWithFormat:@"%@%@日",[dateArray objectAtIndex:0],[dateArray objectAtIndex:1]];
            UIButton * button = (UIButton *) [upView viewWithTag:13];
            [button setTitle:buttonTitle forState:UIControlStateNormal];
        }

    }
    else if (self.dateType == BackDate) {
        
//        dataStrArray = [self.backDateTicketQueryDataModel._nameStr componentsSeparatedByString:@"-"];
//        dateStr = [NSString stringWithFormat:@"%@-%@",[NSDate dateFormateCarQuery:date],[dataStrArray objectAtIndex:3]];// 09月-28-周五-10:00
//        dateCode =[NSString stringWithFormat:@"%@ %@",[NSDate dateCode:date],[dataStrArray objectAtIndex:3]];// yyyy-MM-dd 10:00
//        
//        self.backDateTicketQueryDataModel._nameStr = dateStr;
//        self.backDateTicketQueryDataModel._nameCode = dateCode;
//        
//        if ([self.startDateTicketQueryDataModel._nameCode compare:dateCode] >0) {
//            self.startDateTicketQueryDataModel._nameStr = dateStr;
//            self.startDateTicketQueryDataModel._nameCode = dateCode;
//            NSArray * dateArray = [self.startDateTicketQueryDataModel._nameStr componentsSeparatedByString:@"-"]; // 09月-28-周五-10:00
//            NSString *  buttonTitle = [NSString stringWithFormat:@"%@%@日",[dateArray objectAtIndex:0],[dateArray objectAtIndex:1]];// yyyy-MM-dd 10:00
//            UIButton * button = (UIButton *) [upView viewWithTag:11];
//            [button setTitle:buttonTitle forState:UIControlStateNormal];
//        }
        dataStrArray = [self._backDateName componentsSeparatedByString:@"-"];
        dateStr = [NSString stringWithFormat:@"%@-%@",[NSDate dateFormateCarQuery:date],[dataStrArray objectAtIndex:3]];// 09月-28-周五-10:00
        dateCode =[NSString stringWithFormat:@"%@ %@",[NSDate dateCode:date],[dataStrArray objectAtIndex:3]];// yyyy-MM-dd 10:00
        
        self._backDateName = dateStr;
        self._backDateCode = dateCode;
        
        if ([self._startDateCode compare:dateCode] >0) {
            self._startDateName = dateStr;
            self._startDateCode = dateCode;
            NSArray * dateArray = [self._startDateName componentsSeparatedByString:@"-"]; // 09月-28-周五-10:00
            NSString *  buttonTitle = [NSString stringWithFormat:@"%@%@日",[dateArray objectAtIndex:0],[dateArray objectAtIndex:1]];// yyyy-MM-dd 10:00
            UIButton * button = (UIButton *) [upView viewWithTag:11];
            [button setTitle:buttonTitle forState:UIControlStateNormal];
        }

    }
    
    NSArray * dateArray = [dateStr componentsSeparatedByString:@"-"]; // 09月-28-周五-10:00
    NSString *  buttonTitle = [NSString stringWithFormat:@"%@%@日",[dateArray objectAtIndex:0],[dateArray objectAtIndex:1]];
    [currentButton setTitle:buttonTitle forState:UIControlStateNormal];
    
    myTable.hidden = YES;

}

#pragma mark - 自定义方法

-(void)sureButtonClick:(id)instance
{
//    NSLog(@"%s",__FUNCTION__);
//
//    TaxiHomeDataModelElem *currentCarDataModel = nil;
//    NSString * buttonTitle = (NSString *)instance;
//    
//    if (currentButton.tag ==12) {
//        currentCarDataModel = self.startDateTicketQueryDataModel;
//    }
//    else {
//        currentCarDataModel = self.backDateTicketQueryDataModel;
//    }
//    NSArray * dataStrArray = [currentCarDataModel._nameStr componentsSeparatedByString:@"-"];
//    NSArray * dataCodeArray = [currentCarDataModel._nameCode componentsSeparatedByString:@" "];
//    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@-%@",[dataStrArray objectAtIndex:0],[dataStrArray objectAtIndex:1],[dataStrArray objectAtIndex:2],buttonTitle];// 09月-28-周五-10:10
//    NSString *dateCode =[NSString stringWithFormat:@"%@ %@",[dataCodeArray objectAtIndex:0],buttonTitle];// yyyy-MM-dd 10:10
//    currentCarDataModel._nameStr = dateStr;
//    currentCarDataModel._nameCode = dateCode;
//    [currentButton setTitle:buttonTitle forState:UIControlStateNormal];
//    
//    if ([[backTimeRange substringFromIndex:6] compare:buttonTitle] >= 0 && [buttonTitle compare:[backTimeRange substringToIndex:5]] >= 0) {
//        
//        if (currentButton.tag == 12)  {
//            for (int i = 11; i < 15; i++) {
//                UIButton * button = (UIButton *)[upView viewWithTag:i];
//                if (button.tag == 14) {
//                    [button setTitle:buttonTitle forState:UIControlStateNormal];
//                    dataStrArray = [self.backDateTicketQueryDataModel._nameStr componentsSeparatedByString:@"-"];
//                    dataCodeArray = [self.backDateTicketQueryDataModel._nameCode componentsSeparatedByString:@" "];
//                    dateStr = [NSString stringWithFormat:@"%@-%@-%@-%@",[dataStrArray objectAtIndex:0],[dataStrArray objectAtIndex:1],[dataStrArray objectAtIndex:2],buttonTitle];// 09月-28-周五-10:10
//                    dateCode =[NSString stringWithFormat:@"%@ %@",[dataCodeArray objectAtIndex:0],buttonTitle];// yyyy-MM-dd 10:10
//                    self.backDateTicketQueryDataModel._nameStr = dateStr;
//                    self.backDateTicketQueryDataModel._nameCode = dateCode;
//                    break;
//                }
//            }
//        }
//    }
//    customScorllView.hidden = YES;
    
    NSLog(@"%s",__FUNCTION__);
    
    NSString * currentDataName = nil;
    NSString * currentDataCode = nil;
    
    NSString * buttonTitle = (NSString *)instance;
    
    if (currentButton.tag ==12) {
        currentDataName = self._startDateName;
        currentDataCode = self._startDateCode;
    }
    else {
        currentDataName = self._backDateName;
        currentDataCode = self._backDateCode;
    }
    NSArray * dataStrArray = [currentDataName componentsSeparatedByString:@"-"];
    NSArray * dataCodeArray = [currentDataCode componentsSeparatedByString:@" "];
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@-%@",[dataStrArray objectAtIndex:0],[dataStrArray objectAtIndex:1],[dataStrArray objectAtIndex:2],buttonTitle];// 09月-28-周五-10:10
    NSString *dateCode =[NSString stringWithFormat:@"%@ %@",[dataCodeArray objectAtIndex:0],buttonTitle];// yyyy-MM-dd 10:10
    currentDataName = dateStr;
    currentDataCode = dateCode;
    
    if (currentButton.tag ==12) {
         self._startDateName = currentDataName;
         self._startDateCode = currentDataCode;
    }
    else {
         self._backDateName = currentDataName;
         self._backDateCode = currentDataCode;
    }
    
    [currentButton setTitle:buttonTitle forState:UIControlStateNormal];
    
    if ([[backTimeRange substringFromIndex:6] compare:buttonTitle] >= 0 && [buttonTitle compare:[backTimeRange substringToIndex:5]] >= 0) {
        
        if (currentButton.tag == 12)  {
            for (int i = 11; i < 15; i++) {
                UIButton * button = (UIButton *)[upView viewWithTag:i];
                if (button.tag == 14) {
                    [button setTitle:buttonTitle forState:UIControlStateNormal];
                    dataStrArray = [self._backDateName componentsSeparatedByString:@"-"];
                    dataCodeArray = [self._backDateCode componentsSeparatedByString:@" "];
                    dateStr = [NSString stringWithFormat:@"%@-%@-%@-%@",[dataStrArray objectAtIndex:0],[dataStrArray objectAtIndex:1],[dataStrArray objectAtIndex:2],buttonTitle];// 09月-28-周五-10:10
                    dateCode =[NSString stringWithFormat:@"%@ %@",[dataCodeArray objectAtIndex:0],buttonTitle];// yyyy-MM-dd 10:10
                    self._backDateName = dateStr;
                    self._backDateCode = dateCode;
                    break;
                }
            }
        }
    }
    customScorllView.hidden = YES;
}

-(void)cancelButtonClick
{
    NSLog(@"%s",__FUNCTION__);
    customScorllView.hidden = YES;
}

-(void)finishSelect:(UIButton *)sender
{

    self.startDateTicketQueryDataModel._nameCode = self._startDateCode;
    self.startDateTicketQueryDataModel._nameStr = self._startDateName;
    self.backDateTicketQueryDataModel._nameCode = self._backDateCode;
    self.backDateTicketQueryDataModel._nameStr = self._backDateName;
    
    NSString * startDateTime = [NSString stringWithFormat:@"%@:00",self.startDateTicketQueryDataModel._nameCode];
    NSString * endDateTime = [NSString stringWithFormat:@"%@:00",self.backDateTicketQueryDataModel._nameCode];
    if ([[[startDateTime componentsSeparatedByString:@" "] objectAtIndex:1] isEqualToString:@"24:00:00"]) {
        startDateTime = [NSString stringWithFormat:@"%@ 00:00:00",[[startDateTime componentsSeparatedByString:@" "] objectAtIndex:0]];
        startDateTime = [NSDate dateafterDay:[NSDate dateFromString:startDateTime withFormat:@"yyyy-MM-dd HH:mm:ss"] day:1 type:6];
    }
    if ([[[endDateTime componentsSeparatedByString:@" "] objectAtIndex:1] isEqualToString:@"24:00:00"]) {
        endDateTime = [NSString stringWithFormat:@"%@ 00:00:00",[[endDateTime componentsSeparatedByString:@" "] objectAtIndex:0]];
        endDateTime = [NSDate dateafterDay:[NSDate dateFromString:endDateTime withFormat:@"yyyy-MM-dd HH:mm:ss"] day:1 type:6];
    }
    
    NSDate * startDate = [ NSDate dateFromString:startDateTime withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * endDate = [ NSDate dateFromString:endDateTime withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeInterval start = [startDate timeIntervalSinceNow] *1;
    NSTimeInterval end = [endDate timeIntervalSinceNow] *1;
    NSTimeInterval cha = end - start;
    NSTimeInterval nomalValue = 1;
    if (  (cha/3600) < nomalValue) {
        if ((int)(cha / 60) <= 30) {
            [UIAlertView alertViewWithMessage:@"还车时间必须大于取车时间30分钟以上" :@"提示"];
            return;
        }
    }
    else if ( (int)(cha/86400) >=1)
    {
        if (((int)(cha / 86400) > 89)  || ((int)(cha / 86400 *100) >89 *100 ) ){
            [UIAlertView alertViewWithMessage:@"租车天数最多为89天" :@"提示"];
            return;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedDateTimeFinshed:)]) {
        [self.delegate performSelector:@selector(didSelectedDateTimeFinshed:) ];
    }
    [NavigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dateType == StarDate)
    {
	    return showMonths + 1;
    }
    if (self.dateType == BackDate)
    {
        NSDate *dateafterDay=[NSDate dateafterDay:[NSDate date] day:showDays];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *afterDay = [dateFormatter stringFromDate:dateafterDay];
        [dateFormatter release];
        int height = [self compareMonth:afterDay] + 1;
        NSLog(@"时间控件个数：%d", height);
        return height;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *newDate = currentDateStr;
    if (indexPath.row > 0) {
        newDate = [self addMonths:indexPath.row withMonth:currentDateStr];
    }
    float lastBlock = [[NSDate dateFromString:newDate] numDaysInMonth]+([[NSDate dateFromString:newDate] firstWeekDayInMonth]) - 1;
    int numRows = ceilf(lastBlock/7);
    int height = CalendarViewTopBarHeight + numRows*(CalendarViewDayHeight+2 + 2)+1;
    NSLog(@"时间控件高度：%d", height);
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    NSString * identifier = [NSString stringWithFormat:@"identifier%d", row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *newDate = currentDateStr;
        if (indexPath.row > 0) {
            newDate = [self addMonths:row withMonth:currentDateStr];
        }
        CalendarView *calendarView = [[CalendarView alloc] initWithNSDate:[NSDate dateFromString:newDate] allowShowMonths:showMonths withDayCount:showDays withPushBackDay:self.pushBackDay withSelectDate:[NSDate dateFromString:tempDate]] ;
        calendarView.delegate=self;
        [cell addSubview:calendarView];
        [calendarView release];
    }
    return cell;
}

- (NSString *)addMonths:(int)addNum withMonth:(NSString *)month
{
    NSString *newMonth = nil;
    NSArray *arr = [month componentsSeparatedByString:@"-"];
    int days = 0;
    if ([arr[2] intValue] > 28) {
        days = 28;
    }
    else {
        days = [arr[2] intValue];
    }
    int num = [arr[1] intValue] + addNum;
    if (num > 12) {
        newMonth = [NSString stringWithFormat:@"%d-%d-%d", [arr[0] intValue] + num/12, num%12, days];
    }
    else {
        newMonth = [NSString stringWithFormat:@"%@-%d-%d", arr[0], num, days];
    }
    return newMonth;
}

- (int)compareMonth:(NSString *)date
{
    int result = 0;
    if ([[NSDate dateFromString:date] year] == [[NSDate dateFromString:currentDateStr] year]) {
        result = [[NSDate dateFromString:date] month] - [[NSDate dateFromString:currentDateStr] month];
    }
    else if ([[NSDate dateFromString:date] year] > [[NSDate dateFromString:currentDateStr] year]) {
        int yearNum = [[NSDate dateFromString:date] year] - [[NSDate dateFromString:currentDateStr] year];
        int monthNum = [[NSDate dateFromString:date] month] - [[NSDate dateFromString:currentDateStr] month];
        result = 12*yearNum + monthNum;
    }
    else {
        result = 0;
    }
    return result;
}
@end
