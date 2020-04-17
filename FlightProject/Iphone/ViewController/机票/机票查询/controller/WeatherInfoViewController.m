//
//  WeatherInfoViewController.m
//  FlightProject
//
//  Created by longcd on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WeatherInfoViewController.h"

@implementation WeatherInfoCell

@synthesize imageV1,imageV2,weather,temperature,text;
-(void)dealloc
{
    self.imageV1 = nil;
    self.imageV2 = nil;
    self.weather = nil;
    self.temperature = nil;
    self.text = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV1 = [UIImageView ImageViewWithFrame:CGRectMake(20, 7, 30, 30)];
        self.imageV2 = [UIImageView ImageViewWithFrame:CGRectMake(60, 7, 30, 30)];
        self.weather = [UILabel labelWithTitle:@"" frame:CGRectMake(100, 7, 200, 30) font: [UIFont systemFontOfSize:16] alignment:UITextAlignmentLeft];
        self.temperature = [UILabel labelWithTitle:@"" frame:CGRectMake(200, 7, 100, 30) font: [UIFont systemFontOfSize:16] alignment:UITextAlignmentLeft];
        self.text = [UITextView  TextViewWithFrame:CGRectMake(20, 40, 280, 150) font:[UIFont systemFontOfSize:14] textColor:[UIColor grayColor]];
        [self addSubview:self.imageV1];
        [self addSubview:self.imageV2];
        [self addSubview:self.weather];
        [self addSubview:self.temperature];
        [self addSubview:self.text];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@implementation OtherWeatherInfoCell

@synthesize situation,imageV1,imageV2,wind,temperature;
-(void)dealloc
{
    self.situation = nil;
    self.imageV1 = nil;
    self.imageV2 = nil;
    self.wind = nil;
    self.temperature = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.situation = [UILabel labelWithTitle:@"" frame:CGRectMake(20,0, 280, 28) font: [UIFont systemFontOfSize:14] alignment:UITextAlignmentLeft];
        self.temperature = [UILabel labelWithTitle:@"" frame:CGRectMake(200, 0, 100, 28) font: [UIFont systemFontOfSize:14] alignment:UITextAlignmentLeft];
        
        self.imageV1 = [UIImageView ImageViewWithFrame:CGRectMake(20, 28, 30, 30)];
        self.imageV2 = [UIImageView ImageViewWithFrame:CGRectMake(60, 28, 30, 30)];
        self.wind = [UILabel labelWithTitle:@"" frame:CGRectMake(100, 28, 200, 30) font: [UIFont systemFontOfSize:14] alignment:UITextAlignmentLeft];
        
        [self addSubview:self.situation];
        [self addSubview:self.imageV1];
        [self addSubview:self.imageV2];
        [self addSubview:self.wind];
        [self addSubview:self.temperature];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@interface WeatherInfoViewController ()

@end

@implementation WeatherInfoViewController
@synthesize startWeather,arrivaWeather,costumWeatherInfo;
-(void)dealloc
{
    self.startWeather = nil;
    self.arrivaWeather = nil;
    self.costumWeatherInfo = nil;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"天气信息";
	// Do any additional setup after loading the view.
    
    UITableView * tempTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStyleGrouped];
    tempTable.backgroundColor = [UIColor clearColor];
    tempTable.dataSource = self;
    tempTable.delegate = self;
    [self.view addSubview:tempTable];
    [tempTable release];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [NSString stringWithFormat:@"%@ 更新时间:%@",self.startWeather.city,self.startWeather.updateDate];
    }
    return [NSString stringWithFormat:@"%@ 更新时间:%@",self.arrivaWeather.city,self.arrivaWeather.updateDate];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        self.costumWeatherInfo = self.startWeather;
    }
    else
    {
        self.costumWeatherInfo = self.arrivaWeather;
    }

    UIView * view = [[UIView alloc] init];
    [view addSubview : [UILabel labelWithTitle:self.costumWeatherInfo.city frame:CGRectMake(20, 0, 200, 30) font: [UIFont boldSystemFontOfSize:18] alignment:UITextAlignmentLeft]];
    [view addSubview : [UILabel labelWithTitle:[NSString stringWithFormat:@"更新时间:%@",self.costumWeatherInfo.updateDate] frame:CGRectMake(20, 0, 280, 30) font: [UIFont systemFontOfSize:14] alignment:UITextAlignmentRight]];
    return [view autorelease];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1 + [self.startWeather.otherWeathers count];
    }
    return 1 + [self.arrivaWeather.otherWeathers count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200.0f;
    }
    return 60.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        self.costumWeatherInfo = self.startWeather;
    }
    else
    {
        self.costumWeatherInfo = self.arrivaWeather;
    }

    if (indexPath.row == 0) {
        static NSString * wearthIdentifier = @"wearthIdentifier";
        WeatherInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:wearthIdentifier];
        if (cell == nil) {
            cell = [[[WeatherInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wearthIdentifier] autorelease];
        }
        cell.imageV1.image = [UIImage imageNamed:self.costumWeatherInfo.image1];
        cell.imageV2.image = [UIImage imageNamed:self.costumWeatherInfo.image2];
        cell.weather.text = [[self.costumWeatherInfo.weather componentsSeparatedByString:@"日"] objectAtIndex:1];
        cell.temperature.text = self.costumWeatherInfo.temperature;
        cell.text.text = [NSString stringWithFormat:@"%@\n%@\n%@",self.costumWeatherInfo.liveWeather,self.costumWeatherInfo.airQuality,self.costumWeatherInfo.weatherIndex];
        return cell;
    }
    static NSString * otherWearthIdentifier = @"otherWearthIdentifier";
    OtherWeatherInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:otherWearthIdentifier];
    if (cell == nil) {
        cell = [[[OtherWeatherInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherWearthIdentifier] autorelease];
    }
    OtherWeatherInfo * otherWeatherInfo = [self.costumWeatherInfo.otherWeathers objectAtIndex:indexPath.row-1];
    cell.situation.text = otherWeatherInfo.situation;
    cell.imageV1.image = [UIImage imageNamed:otherWeatherInfo.image1];
    cell.imageV2.image = [UIImage imageNamed:otherWeatherInfo.image2];
    cell.wind.text = otherWeatherInfo.wind;
    cell.temperature.text = otherWeatherInfo.temperature;
    return cell;

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
