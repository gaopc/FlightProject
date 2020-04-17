//
//  AirportWeatherViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AirportWeatherViewController.h"
#import "InterfaceClass.h"

@implementation WeatherCell
@synthesize week,temperature,weather,imageView,dottedLine,backGroundImageView;

- (void)dealloc
{
    self.week = nil;
    self.temperature = nil;
    self.weather = nil;
    self.imageView = nil;
    self.dottedLine = nil;
    self.backGroundImageView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backGroundImageView = [UIImageView ImageViewWithFrame:CGRectMake(10, 0,ViewWidth - 20, 41) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]];
        self.week = [UISubLabel labelWithTitle:@"" frame:CGRectMake(40,10,40,17) font:FontSize24  color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.temperature = [UISubLabel labelWithTitle:@"" frame:CGRectMake(100,10,100,17) font:FontSize24  color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.weather = [UISubLabel labelWithTitle:@"" frame:CGRectMake(165,10,80,17) font:FontSize24  color:FontColor000000 alignment:NSTextAlignmentRight];
        self.imageView = [UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 60, 3, 27, 27) image:nil];
        self.dottedLine = [UIImageView ImageViewWithFrame:CGRectMake(22, 40, ViewWidth - 44, 1) image:[UIImage imageNamed:@"航班动态虚线.png"]];
        [self addSubview:self.backGroundImageView];
        [self addSubview:self.week];
        [self addSubview:self.temperature];
        [self addSubview:self.weather];
        [self addSubview:self.imageView];
        [self addSubview:self.dottedLine];
        
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@implementation WeatherDetailCell
@synthesize imageView,updateTime,weather,temperature,wind,visibility;

- (void)dealloc
{
    self.imageView = nil;
    self.updateTime = nil;
    self.weather = nil;
    self.temperature = nil;
    self.wind = nil;
    self.visibility = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 3, ViewWidth - 20, 89) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 87,ViewWidth - 20, 12) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        self.imageView = [UIImageView ImageViewWithFrame:CGRectMake(40, 7, 53.5, 53.5) image:[UIImage imageNamed:@"cabinTempWearther1.png"]];
        self.updateTime = [UISubLabel labelWithTitle:@"12:40" frame:CGRectMake(92,75,50,15) font:FontSize24  color:FontColor000000 alignment:NSTextAlignmentLeft];
        [self addSubview:[UISubLabel labelWithTitle:@"更新时间  " frame:CGRectMake(40,75,55,15) font:FontSize24  color:FontColor000000 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"天气：" frame:CGRectMake(144,9,37,15) font:FontSize24  color:FontColor000000 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"温度：" frame:CGRectMake(144,31,37,15) font:FontSize24  color:FontColor000000 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"风力：" frame:CGRectMake(144,53,37,15) font:FontSize24  color:FontColor000000 alignment:NSTextAlignmentLeft]];
        [self addSubview:[UISubLabel labelWithTitle:@"空气质量：" frame:CGRectMake(144,75,60,15) font:FontSize24  color:FontColor000000 alignment:NSTextAlignmentLeft]];
        self.weather = [UISubLabel labelWithTitle:@"" frame:CGRectMake(181,9,80,15) font:FontSize24  color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.temperature = [UISubLabel labelWithTitle:@"" frame:CGRectMake(181,31,ViewWidth - 220,15) font:FontSize24  color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.wind = [UISubLabel labelWithTitle:@"" frame:CGRectMake(181,53,125,15) font:FontSize24  color:FontColor000000 alignment:NSTextAlignmentLeft];
        self.visibility = [UISubLabel labelWithTitle:@"" frame:CGRectMake(200,75,80,15) font:FontSize24  color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self.imageView];
        [self addSubview:self.updateTime];
        [self addSubview:self.weather];
        [self addSubview:self.temperature];
        [self addSubview:self.wind];
        [self addSubview:self.visibility];
        
        
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@interface AirportWeatherViewController ()

@end

@implementation AirportWeatherViewController
@synthesize queryWeatherInfo,weekArray,myTable,data;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"机场天气";
    [self setNameLabelText:self.data];
    self.delegate = self;
    self.weekArray = [self theWeekOfToday];
	// Do any additional setup after loading the view.
    UITableView *aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 61, ViewWidth, ViewHeight-44-30) style:UITableViewStylePlain];
    aTableView.backgroundColor = [UIColor clearColor];
    aTableView.dataSource = self;
    aTableView.delegate = self;
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    aTableView.allowsSelection = NO;
    aTableView.bounces = NO;
    self.myTable = aTableView;
    [self setMyCureentView:self.myTable];
    [aTableView release];

}

- (void)dealloc
{
    self.queryWeatherInfo = nil;
    self.myTable = nil;
    self.weekArray = nil;
    self.data = nil;
    [super dealloc];
}

-(void)reloadViewData
{
    if(self.enterAirlinesVC)
    {
        [self.airportNameLabel setText:self.airPortData.airportName];
        self.queryWeatherInfo = nil;
        [self.myTable reloadData];
        ASIFormDataRequest * theRequest = [InterfaceClass queryWeatherInfoByAirportCode:self.airPortData.airportCode];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onWeatherInfoPaseredResult:) Delegate:self needUserType:Default]; 
    }
    self.enterAirlinesVC = NO;
}

- (NSArray*)theWeekOfToday
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | 
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:now];
    NSInteger week = [comps weekday];
    [calendar release];
    switch (week)
    {
        case 0:
            return [NSArray arrayWithObjects:@"星期六",@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五", nil];
            break;
        case 1:
            return [NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
            break;
        case 2:
            return [NSArray arrayWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
            break;
        case 3:
            return [NSArray arrayWithObjects:@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日",@"星期一", nil];
            break;
        case 4:
            return [NSArray arrayWithObjects:@"星期三",@"星期四",@"星期五",@"星期六",@"星期日",@"星期一",@"星期二", nil];
            break;
        case 5:
            return [NSArray arrayWithObjects:@"星期四",@"星期五",@"星期六",@"星期日",@"星期一",@"星期二",@"星期三", nil];
            break;
        case 6:
            return [NSArray arrayWithObjects:@"星期五",@"星期六",@"星期日",@"星期一",@"星期二",@"星期三",@"星期四", nil];
            break;    
        default:
            return [NSArray arrayWithObjects:@"星期六",@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五", nil];
            break;
    }
}

-(void)onWeatherInfoPaseredResult:(NSDictionary*)dic
{    
    if([(NSArray*)[dic objectForKey:@"weatherInfoList"] count] < 7)
    {
        self.queryWeatherInfo = nil;
    }
    else
    {
        self.queryWeatherInfo = (QueryWeatherInfo*)[QueryWeatherInfo GetQueryWeatherInfoByAirportCode:dic];
    }
    
    [self.myTable reloadData];
}



#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 98;
            break;
        default:
            return 40;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 if(indexPath.row == 0)
    {
        NSString * weatherDetailCellidentifier = @"weatherDetailCellidentifier";
        WeatherDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:weatherDetailCellidentifier];
        if (cell == nil) {
            cell = [[[WeatherDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:weatherDetailCellidentifier] autorelease];
        }
        if(self.queryWeatherInfo == nil)
        {
            cell.updateTime.text = @"";
            cell.imageView.image = nil;
            cell.weather.text = @"";
            cell.temperature.text = @"";
            cell.wind.text = @"";
            cell.visibility.text = @""; 
        }
        else {
            AirportWeatherInfo *airportWeatherInfo = [self.queryWeatherInfo.weatherInfoList objectAtIndex:0];
            cell.updateTime.text = self.queryWeatherInfo.updateDate;
            cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:airportWeatherInfo.imageUrl]]];
            cell.weather.text = airportWeatherInfo.weather;
            cell.temperature.text = [NSString stringWithFormat:@"%@ ～ %@",airportWeatherInfo.lowTemperature,airportWeatherInfo.topTemperature];
            cell.wind.text = airportWeatherInfo.wind;
            cell.visibility.text = airportWeatherInfo.airQuality;
        }
        return cell;
    }
    else 
    {
        NSString * weatherCellidentifier = @"weatherCellidentifier";
        WeatherCell * cell = [tableView dequeueReusableCellWithIdentifier:weatherCellidentifier];
        if (cell == nil) {
            cell = [[[WeatherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:weatherCellidentifier] autorelease];
        }
        if(self.queryWeatherInfo == nil)
        {
            cell.week.text = [self.weekArray objectAtIndex:indexPath.row-1];
            cell.temperature.text = @"";
            cell.weather.text = @"";
            cell.imageView.image = nil;
        }
        else {
            AirportWeatherInfo *airportWeatherInfo = [self.queryWeatherInfo.weatherInfoList objectAtIndex:indexPath.row];
            cell.week.text = [self.weekArray objectAtIndex:indexPath.row];
            cell.temperature.text = [NSString stringWithFormat:@"%@ ～ %@",airportWeatherInfo.lowTemperature,airportWeatherInfo.topTemperature];
            cell.weather.text = airportWeatherInfo.weather;
            cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:airportWeatherInfo.imageUrl]]];
        }

        if(indexPath.row == 6)
        {
            [cell.dottedLine setHidden:YES];
            cell.backGroundImageView.frame = CGRectMake(10, 0, 300, 33);
            [cell.contentView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(10, 33, 300, 12) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        }
        return cell;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
