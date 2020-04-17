//
//  FlightTrendsViewController.m
//  FlightProject
//
//  Created by longcd on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlightTrendsViewController.h"
#import "GetFlightDynamicByFlightNo.h"
#import "GetFlightDynamicByStartArrival.h"
#import "DataClass.h"
#import "JSON.h"
#import "MemberLoginViewController.h"
#import "MyRegex.h"

@implementation TitleView
@synthesize titleBackGround,numbutton,citysButton,myAttentionButton,delegate;
- (void)dealloc
{
    self.titleBackGround = nil;
    self.numbutton = nil;
    self.citysButton = nil;
    self.myAttentionButton = nil;
    self.delegate = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        int offx = (ViewWidth - 304)/2;
        self.titleBackGround = [UIImageView ImageViewWithFrame:CGRectMake(offx, 0, 304, 62) image:nil];
        self.numbutton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(offx + 2,0,98,58) backImage:nil target:self action:@selector(changeCuurentView:)];
        self.citysButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(offx + 98 + 3,0,98,58) backImage:nil target:self action:@selector(changeCuurentView:)];
        self.myAttentionButton = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:nil frame:CGRectMake(offx + 98*2 + 3,0,98,58) backImage:nil target:self action:@selector(changeCuurentView:)];
        [self addSubview:self.titleBackGround];
        [self addSubview:self.numbutton];
        [self addSubview:self.citysButton];
        [self addSubview:self.myAttentionButton];

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
-(void)changeCuurentView:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeCuurentView:)]) {
        [self.delegate performSelector:@selector(changeCuurentView:) withObject:sender];
    }
}
@end

@implementation NumSearchTextField
@synthesize selectAirline,numTextField,delegate,butImageView,imageView,flightIcon;
-(void)dealloc
{
    self.butImageView = nil;
    self.selectAirline = nil;
    self.numTextField = nil;
    self.delegate = nil;
    self.imageView = nil;
    self.flightIcon = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        int offx = (ViewWidth - 304)/2;
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(offx, 0, 304, 55) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(offx, 50, 304, 12) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        self.butImageView = [UIImageView ImageViewWithFrame:CGRectMake(offx + 13, 10, 80, 35) image:[UIImage imageNamed:@"航班动态航班缩写按钮.png"]];
        [self addSubview:self.butImageView];
        
        
        self.selectAirline = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(offx + 13, 10, 80, 35) font:FontSize28 color:FontColor333333 target:self action:@selector(showSelectAlineView:)];
        self.flightIcon = [UIImageView ImageViewWithFrame:CGRectMake(offx + 18, 19, 15, 15)];
        self.numTextField = [UISubTextField TextFieldWithFrame:CGRectMake(offx + 92, 10, 196, 34) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentCenter placeholder:@"请输入3或4位数字"];
        self.numTextField.font = FontSize36;
        [self.numTextField setTextColor:FontColor636363];
        self.numTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.numTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.numTextField.returnKeyType = UIReturnKeyDone;
        self.numTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.numTextField.background = [UIImage imageNamed:@"航班动态输入框.png"];
        
        [self addSubview:self.selectAirline];
        [self addSubview:self.flightIcon];
        [self addSubview:self.numTextField];
        self.imageView = [UIImageView ImageViewWithFrame:CGRectMake(offx + 78, 25, 9, 5) image:[UIImage imageNamed:@"航班箭头下.png"]];
        [self addSubview:self.imageView];
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

-(void)showSelectAlineView:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showSelectAlineView:)]) {
        [self.delegate performSelector:@selector(showSelectAlineView:) withObject:sender];
    }
}
@end


@implementation CitySearchButtons
@synthesize startCity,arrCity,delegate,myStartCity,myEndCity;
-(void)dealloc
{
    self.startCity = nil;
    self.arrCity = nil;
    self.delegate = nil;
    self.myStartCity = nil;
    self.myEndCity = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        int offx = (ViewWidth - 304)/2;
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(offx, 0, 304, 55) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(offx, 50, 304, 12) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"出发城市" frame:CGRectMake(offx + 7,3,110,14) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];//(55, 3, 55, 14)
        [self addSubview:[UISubLabel labelWithTitle:@"到达城市" frame:CGRectMake(offx + 183,3,110,14) font:FontSize22 color:FontColor909090 alignment:NSTextAlignmentCenter]];//(215, 3, 55, 14)
        [self addSubview:[UIButton customButtonTitle:nil  image:[UIImage imageNamed:@"TicketQueryChange.png"] frame:CGRectMake(offx + 124, 0, 54, 54) target:self action:@selector(switchCitys:)]];
        self.startCity = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"北京" frame:CGRectMake(offx + 7,5,110,50) font:FontBlodSize42 color:FontColor333333 target:self action:@selector(selectCity:)];
        self.arrCity = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"上海" frame:CGRectMake(offx + 183,5,110,50) font:FontBlodSize42 color:FontColor333333 target:self action:@selector(selectCity:)];
        [self addSubview:self.startCity];
        [self addSubview:self.arrCity];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(offx + 110,24,8,14) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(offx + 286,24,8,14) image:[UIImage imageNamed:@"航班动态列表下级.png"]]];
        Citys * star = [[Citys alloc] init];
        Citys * arr = [[Citys alloc] init];
        star._city_code = @"PEK";
        star._city_name = @"北京";
        arr._city_code = @"SHA";
        arr._city_name = @"上海";
        self.myStartCity = star;
        self.myEndCity = arr;
        [star release];
        [arr release];
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
-(void)selectCity:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCity:)]) {
        [self.delegate performSelector:@selector(selectCity:) withObject:sender];
    }
}
-(void)switchCitys:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchCitys:)]) {
        NSString *citys = [NSString stringWithFormat:@"%@-%@",self.startCity.titleLabel.text,self.arrCity.titleLabel.text];
        [self.delegate performSelector:@selector(switchCitys:) withObject:citys];
    }
}
@end


@implementation NumSearchHistory
@synthesize leftNumber,rightNumber,leftCitys,rightCitys,lefttHistory,rightHistory,delegate;
-(void)dealloc{
  
    self.leftNumber = nil;
    self.rightNumber = nil;
    self.leftCitys = nil;
    self.rightCitys = nil;
    self.lefttHistory = nil;
    self.rightHistory = nil;
    self.delegate = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        int offx = (ViewWidth - 304)/2;
        self.leftNumber = [UISubLabel labelWithTitle:@"" frame:CGRectMake(offx,11,146,15) font:FontSize28 color:FontColor454545 alignment:NSTextAlignmentCenter];
        self.rightNumber = [UISubLabel labelWithTitle:@"" frame:CGRectMake(offx + 151,11,146,15) font:FontSize28 color:FontColor454545 alignment:NSTextAlignmentCenter];
        self.leftCitys = [UISubLabel labelWithTitle:@"" frame:CGRectMake(offx,28,146,12) font:FontSize28 color:FontColor707070 alignment:NSTextAlignmentCenter];
        self.leftCitys.numberOfLines = 1;
        self.rightCitys = [UISubLabel labelWithTitle:@"" frame:CGRectMake(offx + 151,28,146,12) font:FontSize28 color:FontColor707070 alignment:NSTextAlignmentCenter];
        self.rightCitys.numberOfLines = 1;
        
         self.lefttHistory = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"航班动态历史记录.png"] frame:CGRectMake(offx, 2, 146, 45) font:FontSize28 color:FontColor454545 target:self action:@selector(flightSearch:)];
        self.rightHistory = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil backImage:[UIImage imageNamed:@"航班动态历史记录.png"] frame:CGRectMake(offx + 151, 2, 146, 45) font:FontSize28 color:FontColor454545 target:self action:@selector(flightSearch:)];
        
        [self addSubview:self.lefttHistory];
        [self addSubview:self.rightHistory];
        [self addSubview:self.leftNumber];
        [self addSubview:self.rightNumber];
        [self addSubview:self.leftCitys];
        [self addSubview:self.rightCitys];
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
-(void)flightSearch:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(flightSearch:)]) {
        switch (sender.tag) {
            case 0:
                [self.delegate performSelector:@selector(flightSearch:) withObject:self.leftNumber.text];
                break;
            case 1:
                [self.delegate performSelector:@selector(flightSearch:) withObject:self.rightNumber.text];
                break; 
            default:
                break;
        }
        ;
    }
}
@end

@implementation CitySearchHistory
@synthesize leftButton,rightButton,leftCode,rightCode,delegate;
-(void)dealloc
{
    self.leftButton = nil;
    self.rightButton = nil;
    self.leftCode = nil;
    self.rightCode = nil;
    self.delegate = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        int offx = (ViewWidth - 304)/2;
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil backImage:[UIImage imageNamed:@"航班动态历史记录.png"] frame:CGRectMake(offx, 2, 146, 45) font:FontSize28 color:FontColor454545 target:self action:@selector(flightSearch:)];
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil backImage:[UIImage imageNamed:@"航班动态历史记录.png"] frame:CGRectMake(offx + 151, 2, 146, 45) font:FontSize28 color:FontColor454545 target:self action:@selector(flightSearch:)];
               
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];

        self.leftCode = @"HET-URCA";
        self.rightCode = @"PEK-CAN";
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
-(void)flightSearch:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(flightSearch:)]) {
        switch (sender.tag) {
            case 0:
                [self.delegate performSelector:@selector(flightSearch:) withObject:[NSString stringWithFormat:@"%@:%@",self.leftCode,self.leftButton.titleLabel.text]];
                break;
            case 1:
                [self.delegate performSelector:@selector(flightSearch:) withObject:[NSString stringWithFormat:@"%@:%@",self.rightCode,self.rightButton.titleLabel.text]];
                break; 
            default:
                break;
        }
        ;
    }
}
@end


@implementation MyAttentionCell
@synthesize ids,flightIcon,dottedLine,flightCompany,flightStartCity,flightArrivalCity,backGroundImageView,arrowImageView,subordinateImageView;
-(void)dealloc
{
    self.ids = nil;
    self.flightIcon = nil;
    self.flightCompany = nil;
    self.flightStartCity = nil;
    self.flightArrivalCity = nil;
    self.dottedLine = nil;
    self.backGroundImageView = nil;
    self.arrowImageView = nil;
    self.subordinateImageView = nil;
    
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        int offx = (ViewWidth - 304)/2;
        self.backGroundImageView = [UIImageView ImageViewWithFrame:CGRectMake(offx, 0, 304, 60) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]];
        [self addSubview:backGroundImageView];
        self.flightIcon = [UIImageView ImageViewWithFrame:CGRectMake(offx + 10, 7, 15, 15)];
        self.flightCompany = [UISubLabel labelWithTitle:@"" frame:CGRectMake(offx + 30, 9, 270, 12) font:FontSize24 color:FontColor333333 alignment:NSTextAlignmentLeft];
        self.flightStartCity = [UISubLabel labelWithTitle:@"" frame:CGRectMake(offx + 42, 25, 85, 23) font:FontSize28 color:FontColor0066CC alignment:NSTextAlignmentLeft];
        self.flightArrivalCity = [UISubLabel labelWithTitle:@"" frame:CGRectMake(offx + 192, 25, 85, 23) font:FontSize28 color:FontColor0066CC alignment:NSTextAlignmentLeft];
        self.arrowImageView = [UIImageView ImageViewWithFrame:CGRectMake(offx + 137, 25, 25, 23) image:[UIImage imageNamed:@"航班动态我的关注箭头.png"]];
        self.subordinateImageView = [UIImageView ImageViewWithFrame:CGRectMake(offx + 280, 30, 8, 12.5) image:[UIImage  imageNamed:@"航班动态列表下级.png"]];
        self.dottedLine = [UIImageView ImageViewWithFrame:CGRectMake(offx + 7, 60, 285, 0.5) image:[UIImage imageNamed:@"航班动态虚线.png"]];
        [self addSubview:self.flightIcon];
        [self addSubview:self.flightCompany];
        [self addSubview:self.flightStartCity];
        [self addSubview:self.flightArrivalCity];
        [self addSubview:self.arrowImageView];
         [self addSubview:self.subordinateImageView];
        [self addSubview:self.dottedLine];
        self.ids = @"";
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


@implementation SelectAlineCell
@synthesize rightImage,leftButton,rightButton,delegate,leftIcon,rightIcon;
-(void)dealloc
{
    self.rightImage = nil;
    self.leftIcon = nil;
    self.rightIcon = nil;
    self.leftButton = nil;
    self.rightButton = nil;
    self.delegate = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        int offx = (ViewWidth - 304)/2;
        self.rightImage = [UIImageView ImageViewWithFrame:CGRectMake(offx + 2, 38, 250, 1) image:[UIImage imageNamed:@"航班动态-横虚线.png"]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(offx + 127, 0, 1, 38) image:[UIImage imageNamed:@"航班动态-竖虚线.png"]]];
        self.leftIcon = [UIImageView ImageViewWithFrame:CGRectMake(offx + 7, 10, 15, 15)];
        self.rightIcon = [UIImageView ImageViewWithFrame:CGRectMake(offx + 142, 10, 15, 15)];
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(offx - 2, 5, 145, 25) font:FontSize26 color:FontColor636363 target:self action:@selector(selectAline:)];
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(offx + 137, 5, 130, 25) font:FontSize26 color:FontColor636363 target:self action:@selector(selectAline:)];
        
        [self addSubview:self.rightImage];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.leftIcon];
        [self addSubview:self.rightIcon];
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
-(void)selectAline:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectAline:)]) {
        [self.delegate performSelector:@selector(selectAline:) withObject:sender.titleLabel.text];
    }
}
@end

@interface FlightTrendsViewController ()
@end

@implementation FlightTrendsViewController
@synthesize numFlight,flightCompany,selectCitysArray,myTableView,selectAlineTableView,currentTextField,getMyAttentionList,numberHistory,citysHistory,flightCompanys,showSATableView,enterCityList,keyboardbar,selectAlineBackGround,isGetMyAttention;
@synthesize domesticAirBtn,internationalAirBtn;
@synthesize buttonSelect,server;
-(void)dealloc
{
    self.server  = nil;
    self.buttonSelect = nil;
    self.numFlight = nil;
    self.flightCompany = nil;
    self.myTableView = nil;
    self.selectCitysArray = nil;
    self.selectAlineTableView = nil;
    self.currentTextField = nil;
    self.getMyAttentionList = nil;
    self.numberHistory = nil;
    self.citysHistory = nil;
    self.flightCompanys= nil;
    self.keyboardbar = nil;
    self.selectAlineBackGround = nil;
    self.domesticAirBtn = nil;
    self.internationalAirBtn = nil;
    
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

//- (void)viewWillAppear:(BOOL)animated

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) image:[UIImage imageNamed:@"航班动态背景.png"]]];
    currentViewTag = 0;
    flightsType = 0;
    self.numberHistory = [NSMutableArray arrayWithArray:[DataClass selectFromFlight_Num_Historty]];
    
    UITableView *aTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44-44) style:UITableViewStylePlain];
    self.myTableView = aTable;
    [aTable release];
    self.myTableView.tag = 0;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];

    
    Citys * star = [[Citys alloc] init];
    Citys * arr = [[Citys alloc] init];
    star._city_code = @"PEK";
    star._city_name = @"北京";
    arr._city_code = @"SHA";
    arr._city_name = @"上海";
    NSMutableArray *ary = [[NSMutableArray alloc] initWithObjects:@"",@"", nil];
    self.selectCitysArray = ary;
    [self.selectCitysArray replaceObjectAtIndex:0 withObject:star];
    [self.selectCitysArray replaceObjectAtIndex:1 withObject:arr];
    
    myStartCity = star;
    myEndCity = arr;
    [star release];
    [arr release];
    [ary release];
    
    
    NSString *str = [[NSString alloc] init];
    self.numFlight = str;
    [str release];

    self.flightCompany = @"CZ";
    [self gettFlightCompanys:@"国内航空公司"];
    self.showSATableView = NO;
    self.enterCityList = NO;
    self.isGetMyAttention = NO;
    
}
- (NSString*)infoWithIndex:(int)index
{
    NSString* companyText=@"";
    if (index<[self.flightCompanys count])
    {
        NSString* name = [[self.flightCompanys objectAtIndex:index] objectForKey:@"name"];
        NSString* number = [[self.flightCompanys objectAtIndex:index] objectForKey:@"code"];
        companyText = [name stringByAppendingString:number];
    }
    return companyText;
}
-(void)gettFlightCompanys:(NSString*)resource
{
    NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:@"json"];
    NSString *str = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [str JSONValue];
    [str release];
    NSMutableArray *aArray = [[NSMutableArray alloc] init];
    for (id elem in array) 
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[elem objectForKey:@"code"] forKey:@"code"];
        [dic setObject:[elem objectForKey:@"name"] forKey:@"name"];
        [aArray addObject:dic];
        [dic release];
    }
    self.flightCompanys = aArray;
    [aArray release];
}
-(void)reloadTableView
{
    if(!self.enterCityList)
    {
        if(self.isGetMyAttention)
        {
            self.isGetMyAttention = NO;
            return;
        }
        else 
        {
            [self.getMyAttentionList.myAttentionList removeAllObjects];
            [self reloadTableView:currentViewTag];
        }
    }
    self.enterCityList = NO;
}

-(void)changeCuurentView:(UIButton*)sender
{
    [self reloadTableView:sender.tag];
}

-(void)reloadTableView:(NSInteger)tag
{
    NSLog(@"reloadTableView");
    if(self.showSATableView)
    {
        [self.selectAlineTableView setContentOffset:CGPointMake(0, 0)];
        self.showSATableView = NO;
        self.myTableView.scrollEnabled = YES;
        [self.selectAlineTableView removeFromSuperview];
        [self.selectAlineBackGround removeFromSuperview];
    }
    switch (tag) {
        case 0:
        {
            currentViewTag = 0;
            [self.numberHistory removeAllObjects];
            self.numberHistory = [NSMutableArray arrayWithArray:[DataClass selectFromFlight_Num_Historty]];
        }
            break;
        case 1:
        {
            currentViewTag = 1;
            [self.citysHistory removeAllObjects];
            self.citysHistory = [NSMutableArray arrayWithArray:[DataClass selectFromFlight_City_Historty]];
        }
            break;   
        case 2:
        {
//            currentViewTag = 2;
            if([self.getMyAttentionList.myAttentionList count] == 0)
            {
                self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                self._VCType = Member;
                if (self.isLogin) 
                {
                    [self.myTableView reloadData];
                    [self loginSuccessFul];
                    return;
                }
                else 
                {
                    self.isGetMyAttention = YES;
                    return;
                }
            }
            else {
                currentViewTag = 2;
                [self.myTableView reloadData];
            }
        }
            break;
        default:
            break;
    }
    [self.myTableView reloadData]; 
}

-(void)loginSuccessFul
{
    ASIFormDataRequest * theRequest = [InterfaceClass getMyAttentionListWithUserId:[UserInfo sharedUserInfo].userID];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onMyAttentionPaseredResult:) Delegate:self needUserType:Member];
}


#pragma mark textFielddelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(self.showSATableView)
    {
        [self.selectAlineTableView setContentOffset:CGPointMake(0, 0)];
        self.showSATableView = NO;
        self.myTableView.scrollEnabled = YES;
        [self.selectAlineTableView removeFromSuperview];
        [self.selectAlineBackGround removeFromSuperview];
    }
  
    if(self.keyboardbar == nil )
    {
        KeyBoardTopBar *aKeyboardbar = [[KeyBoardTopBar alloc] init:[NSArray arrayWithObject:textField] view:self.view ];
        self.keyboardbar = aKeyboardbar;
        [aKeyboardbar release];
    }
    
    //KeyBoardTopBar的实例对象调用显示键盘方法
    
    [self.keyboardbar showBar:textField];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
    
    
	if(!flightsType)
    {
        int textFieldMaxLent = 4;
        if(![string isMatchedByRegex:CREDIT_CARD] && ![string isEqualToString:@""])
        {
            return NO;
        }
        
        if(textFieldStrLength > textFieldMaxLent)
        {
            textField.text = [textFieldStr substringToIndex:textFieldMaxLent];
            return NO;
        }
        else {
            
            if([string isEqualToString:@""])
            {
                self.numFlight = [flightCompany stringByAppendingFormat:@"%@",[textField.text substringToIndex:[textField.text length]-1]];
            }
            else
            {
                self.numFlight = [flightCompany stringByAppendingFormat:@"%@",[textField.text stringByAppendingFormat:@"%@",string]];
            }
            
            return YES;
        }
    }
    else
    {
        int textFieldMaxLent = 6;
        if(![string isMatchedByRegex:PASSPORT_CARD] && ![string isEqualToString:@""])
        {
            return NO;
        }
        
        if(textFieldStrLength > textFieldMaxLent)
        {
            textField.text = [textFieldStr substringToIndex:textFieldMaxLent];
            return NO;
        }
        else {
            
            if([string isEqualToString:@""])
            {
                self.numFlight = [textField.text substringToIndex:[textField.text length]-1];
            }
            else
            {
                self.numFlight = [textField.text stringByAppendingFormat:@"%@",string];
            }
            
            return YES;
        }
    }
        
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.currentTextField resignFirstResponder];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.numFlight = [self.numFlight substringToIndex:2];
    return YES;
}


-(void)showSelectAlineView:(UIButton*)sender
{
    [self.currentTextField resignFirstResponder];
    if(self.showSATableView)
    {
        [self.selectAlineTableView setContentOffset:CGPointMake(0, 0)];
        self.showSATableView = NO;
        self.myTableView.scrollEnabled = YES;
        [self.selectAlineTableView removeFromSuperview];
        [self.selectAlineBackGround removeFromSuperview];
        [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if(self.selectAlineTableView == nil)
    {
        UITableView *aTable = [[UITableView alloc] initWithFrame:CGRectMake(22, 105, 274, 240) style:UITableViewStylePlain];
        self.selectAlineTableView = aTable;
        [aTable release];
    }
    if(self.selectAlineBackGround == nil)
    {
        self.selectAlineBackGround = [UIImageView ImageViewWithFrame:CGRectMake(22, 105, 274, 243) image:[UIImage imageNamed:@"航班动态下拉.png"]];
    }
    self.selectAlineTableView.tag = 1;
    self.selectAlineTableView.delegate = self;
    self.selectAlineTableView.dataSource = self;
    self.selectAlineTableView.backgroundColor = [UIColor clearColor];
                                        
    self.selectAlineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.selectAlineTableView.allowsSelection = NO;
    self.showSATableView = YES;
    self.myTableView.scrollEnabled = NO;
    [self.myTableView addSubview:self.selectAlineBackGround];
    [self.myTableView addSubview:self.selectAlineTableView];
    [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)selectAline:(NSString*)selectAline
{
    if(self.showSATableView)
    {
        [self.selectAlineTableView setContentOffset:CGPointMake(0, 0)];
        self.showSATableView = NO;
        self.myTableView.scrollEnabled = YES;
        [self.selectAlineTableView removeFromSuperview];
        [self.selectAlineBackGround removeFromSuperview];
    }
    flightsType = 0;
    [self.domesticAirBtn setImage:[UIImage imageNamed:@"domesticAir_blue.png"] forState:UIControlStateNormal];
    [self.internationalAirBtn setImage:[UIImage imageNamed:@"internationalAir_gray.png"] forState:UIControlStateNormal];
    
    
    self.flightCompany = [selectAline substringFromIndex:(selectAline.length-2)];
    NSLog(@"选择的航空公司是：%@",self.flightCompany);
    [self.myTableView reloadData];
}

-(void)flightSearch:(NSString*)historyStr{//mySelectAirline
    if(currentViewTag == 0){
        if(self.currentTextField)
        {
            [self.currentTextField resignFirstResponder];
        }
        NSString *flightNo = @"";
        if([historyStr isKindOfClass:[NSString class]])
        {
            flightNo = historyStr;//历史关注
            self.numFlight = historyStr;
            self.flightCompany = [self.numFlight substringToIndex:2];
        }
        else 
        {
            if(!flightsType)//国内航空
            {
                self.flightCompany = mySelectAirline.titleLabel.text;
                if(self.currentTextField != nil)
                {
                    self.numFlight = [flightCompany stringByAppendingFormat:@"%@",self.currentTextField.text];
                    flightNo = self.numFlight;
                }
            }
            else
            {
                if(self.currentTextField != nil)
                {
                    self.numFlight = self.currentTextField.text;
                    flightNo = self.numFlight;
                }
            }
         
        }
        self.numFlight = [self.numFlight uppercaseString];

        if(!flightsType)
        {
            if([flightNo length] <= 2)
            {
                [UIAlertView alertViewWithMessage:@"请输入航班号！" :@"提示"];
                return;
            }
            else if([ flightNo length] < 5)
            {
                [UIAlertView alertViewWithMessage:@"请至少输入三位数字！" :@"提示"];
                return;
            }
        }

        
        NSLog(@"查询航班号：%@",[flightNo uppercaseString]);
        
        ASIFormDataRequest * theRequest = [InterfaceClass getFlightDynamicByFlightNoWithUserId:[UserInfo sharedUserInfo].userID?[UserInfo sharedUserInfo].userID:@"" flightNo:[flightNo uppercaseString]];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onNumPaseredResult:) Delegate:self needUserType:Default];
    }
    else {
        if([historyStr isKindOfClass:[NSString class]])
        {
           //历史关注
            NSArray *array = [historyStr componentsSeparatedByString:@":"];
            Citys *citys1 = [[Citys alloc] init];
            citys1._city_code = [[[array objectAtIndex:0] componentsSeparatedByString:@"-"] objectAtIndex:0];
            citys1._city_name = [[[array objectAtIndex:1] componentsSeparatedByString:@"-"] objectAtIndex:0];
            Citys *citys2 = [[Citys alloc] init];
            citys2._city_code = [[[array objectAtIndex:0] componentsSeparatedByString:@"-"] objectAtIndex:1];
            citys2._city_name = [[[array objectAtIndex:1] componentsSeparatedByString:@"-"] objectAtIndex:1];
            [self.selectCitysArray replaceObjectAtIndex:0 withObject:citys1];//起飞地
            [self.selectCitysArray replaceObjectAtIndex:1 withObject:citys2];//降落地
            [citys1 release];
            [citys2 release];
        }
        else
        {
            [self.selectCitysArray replaceObjectAtIndex:0 withObject:myStartCity];//起飞地
            [self.selectCitysArray replaceObjectAtIndex:1 withObject:myEndCity];//降落地
        }

        
        if([(((Citys*)[self.selectCitysArray objectAtIndex:0])._city_code) isEqualToString:(((Citys*)[self.selectCitysArray objectAtIndex:1])._city_code)])
        {
            [UIAlertView alertViewWithMessage:@"出发城市和到达城市相同，请重新选择。" :@"提示"];
            return;
        }
        NSLog(@"起降地查询：%@---%@",(((Citys*)[self.selectCitysArray objectAtIndex:0])._city_code),(((Citys*)[self.selectCitysArray objectAtIndex:1])._city_code));
        ASIFormDataRequest * theRequest = [InterfaceClass getFlightDynamicByStartArrival:(((Citys*)[self.selectCitysArray objectAtIndex:0])._city_code) arrival:(((Citys*)[self.selectCitysArray objectAtIndex:1])._city_code)];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCityPaseredResult:) Delegate:self needUserType:Default];
    }   
}

-(void)switchCitys:(UIButton*)sender{
    NSLog(@"%@--%@",(((Citys*)[self.selectCitysArray objectAtIndex:0])._city_code),(((Citys*)[self.selectCitysArray objectAtIndex:1])._city_code));
    Citys *acitys = [self.selectCitysArray objectAtIndex:0];
    Citys *tempcitys = [Citys citysWithNameCode:acitys._city_name code:acitys._city_code];
    [self.selectCitysArray replaceObjectAtIndex:0 withObject:[self.selectCitysArray objectAtIndex:1]];
    [self.selectCitysArray replaceObjectAtIndex:1 withObject:tempcitys];
    NSLog(@"%@--%@",(((Citys*)[self.selectCitysArray objectAtIndex:0])._city_code),(((Citys*)[self.selectCitysArray objectAtIndex:1])._city_code));
    [self.myTableView reloadData];
}

-(void)selectCity:(UIButton *) sender // zxt 20121027  修改
{
    self.buttonSelect = [NSString stringWithFormat:@"%d", sender.tag];
    NSArray * array =  [DataClass selectFromAirportCityList];
    if ( [GetConfiguration shareGetConfiguration].needUpdateAirportCityInfo || [array count] == 0) {
        GetBasicInfoFromServer *serverInfo = [[GetBasicInfoFromServer alloc] init];
        serverInfo.cityDelegate = self;
        self.server = serverInfo;
        [self.server getAirportCityInfo];
        [serverInfo release];
        return;
    }
    else {
        [self didCityInfoResult:array];
    }
    currentCity = (Citys*)[self.selectCitysArray objectAtIndex:sender.tag];
    self.enterCityList = YES;
    
}

- (void)didCityInfoResult:(NSArray *)cityArray
{
    // 0出发城市 1到达城市
    currentCity = (Citys*)[self.selectCitysArray objectAtIndex:[self.buttonSelect intValue]];
    self.enterCityList = YES;
    CityListViewController * cityListVC = [[CityListViewController alloc] init];
    cityListVC.citysArray = cityArray;
    cityListVC.title = [self.buttonSelect intValue]==0?@"出发城市":@"到达城市";
    cityListVC.cityType = AirportCityList;
    cityListVC.delegate = self;
    [NavigationController pushViewController:cityListVC animated:YES];
    [cityListVC release];
}

-(void)didSelectedCityFinshed:(id)city // zxt 20121027 添加  选择完城市的代理方法
{
    Citys * _city = (Citys *)city;
    currentCity._city_name = _city._city_name;
    currentCity._city_code = _city._city_code;
    [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)onNumPaseredResult:(NSDictionary *)dic
{
    if (dic)
    {
        FlightTrendsDetailViewController * flightTrendsDetailVC = [[FlightTrendsDetailViewController alloc] init];
        flightTrendsDetailVC.flightDynamic = (GetFlightDynamicByFlightNo*)[GetFlightDynamicByFlightNo GetFlightDynamicByFlightNo:dic];
        flightTrendsDetailVC.flightNum = self.numFlight;
        if(currentViewTag == 0)
        {
            NSLog(@"%@",self.numFlight);
            NSArray *array = [NSArray arrayWithObjects:[NSArray arrayWithObjects:self.numFlight,((StopoverInfo*)[flightTrendsDetailVC.flightDynamic.stopoverInfos objectAtIndex:0]).departure,((StopoverInfo*)[flightTrendsDetailVC.flightDynamic.stopoverInfos objectAtIndex:0]).arrival,nil], nil];
            if([DataClass insertIntoFlight_Num_HistortyWithArray:array])
            {
                NSLog(@"OK");
            }
        }
        else
        {
            self.isGetMyAttention = NO;
            [self.getMyAttentionList.myAttentionList removeAllObjects];
        }
        [NavigationController pushViewController:flightTrendsDetailVC animated:YES];
        [flightTrendsDetailVC release];
    }  
}

-(void)onCityPaseredResult:(NSDictionary *)dic
{
    if(dic)
    {
        FlightTrendsListViewController * flightTrendsListVC = [[FlightTrendsListViewController alloc] init];
        flightTrendsListVC.flightDynamics = (GetFlightDynamicByStartArrival*)[GetFlightDynamicByStartArrival getFlightDynamicByStartArrival:dic];
        
        NSArray *array = [NSArray arrayWithObjects:[NSArray arrayWithObjects:(((Citys*)[self.selectCitysArray objectAtIndex:0])._city_code) ,(((Citys*)[self.selectCitysArray objectAtIndex:0])._city_name),(((Citys*)[self.selectCitysArray objectAtIndex:1])._city_code),(((Citys*)[self.selectCitysArray objectAtIndex:1])._city_name),nil], nil];
        if ([DataClass insertIntoFlight_City_HistortyWithArray:array]) {
            NSLog(@"ok");
        }
        [NavigationController pushViewController:flightTrendsListVC animated:YES];
        [flightTrendsListVC release];
    }
    
}

-(void)onMyAttentionPaseredResult:(NSDictionary*)dic
{
    if(dic)
    {
        currentViewTag = 2;
        self.getMyAttentionList = (GetMyAttentionList*)[GetMyAttentionList getMyAttentionList:dic];
    }
    [self.myTableView reloadData];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    delegate.numFlight = numTextField.text;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
   
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.currentTextField resignFirstResponder];
    if(self.showSATableView)
    {
        [self.selectAlineTableView setContentOffset:CGPointMake(0, 0)];
        self.showSATableView = NO;
        self.myTableView.scrollEnabled = YES;
        [self.selectAlineTableView removeFromSuperview];
        [self.selectAlineBackGround removeFromSuperview];
        return;
    }
}
#pragma mark tableviewdelegate 
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if(tableView.tag == 0)
    {
        if (section == 3 ) {
            return 30;
        }
        return 0;
    }
    else 
    {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *str = @"";
    if(currentViewTag == 0)
    {
        if([self.numberHistory count] > 0)
            str = @"历史关注";
    }
    else 
    {
        if([self.citysHistory count] > 0)
            str = @"历史关注";
    }

    return [UISubLabel labelWithTitle:str frame: CGRectMake(0, 0, ViewWidth, 30) font:FontSize24 color:FontColor636363 alignment:NSTextAlignmentCenter];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if(tableView.tag == 0)
    {
        if(currentViewTag == 0 || currentViewTag == 1)
        {
            if(section == 0)
            {
                return 62;
            }
            else if(section == 1)
            {
                return 62;
            }
            else if(section == 2)
            {
                return 45;
            }
            else 
            {
                return 50;
            }
        }
        else
        {
            if(section == 0)
            {
                return 62;
            }
            else
            {
                return 60;
            }
        }
    }
    else
    {
        return 40;
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
    if(tableView.tag == 0)
    {
        if(currentViewTag == 0)
        {
            return 4;
        }else if(currentViewTag == 1)
        {
            return 4;
        }
        else 
        {
            return 2;
        }
    }
    else
    {
        return 1;
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 0)
    {
        if(currentViewTag == 0 || currentViewTag == 1)
        {
            if(section == 3)
            {
                if(currentViewTag == 0)
                {
                    return ([self.numberHistory count]%2)==(0)?([self.numberHistory count]/2):([self.numberHistory count]/2+1);
                }
                else {
                    return ([self.citysHistory count]%2)==(0)?([self.citysHistory count]/2):([self.citysHistory count]/2+1);
                }
            }
            else 
            {
                return 1;
            }
        }
        else 
        {
            if(section == 0)
            {
                return 1;
            }
            else
            {
//                return [self.getMyAttentionList.myAttentionList count];//我的关注始终显示5条背景图
                return 5;
            }
        }
    }
    else
    {
        int num = ([self.flightCompanys count]%2)==(0)?([self.flightCompanys count]/2):([self.flightCompanys count]/2+1);
        NSLog(@"%d",num);
        return num+1;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if(tableView.tag == 0)
    {
        if(currentViewTag != 2)
        {
            if(section == 0)
            {
                static NSString * titleViewidentifier = @"titleViewidentifier";
                TitleView * cell = [tableView dequeueReusableCellWithIdentifier:titleViewidentifier];
                if (cell == nil) {
                    cell = [[[TitleView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleViewidentifier] autorelease];
                }
                if(currentViewTag == 0)
                {
                    [cell.titleBackGround setImage:[UIImage imageNamed:@"航班动态航班号.png"]];
                }
                else if(currentViewTag == 1)
                {
                    [cell.titleBackGround setImage:[UIImage imageNamed:@"航班动态起降地.png"]];
                }
                cell.delegate = self;
                return cell;
                
            }
            else if(section == 1)
            {
                if(currentViewTag == 0)
                {
                    static NSString *firstSectionIdentifier = @"firstSectionIdentifier";
                    NumSearchTextField *cell = [tableView dequeueReusableCellWithIdentifier:firstSectionIdentifier];
                    if(cell == nil){
                        cell = [[[NumSearchTextField alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstSectionIdentifier] autorelease];
                    }
                    cell.delegate = self;
                    cell.numTextField.delegate = self;
                    if(!flightsType)
                    {
                        cell.numTextField.placeholder = @"请输入3或4位数字";
                        cell.numTextField.keyboardType = UIKeyboardTypeNumberPad;
                    }
                    else
                    {
                        cell.numTextField.placeholder = @"请输入完整国际航班号";
                        cell.numTextField.keyboardType = UIKeyboardTypeDefault;
                    }
                    self.currentTextField = cell.numTextField;
                    if(self.numFlight.length > 2)
                    {
                        if(!flightsType)
                            cell.numTextField.text = [self.numFlight substringFromIndex:2];
                        else
                            cell.numTextField.text = self.numFlight;
                    }
                    else
                    {
                        cell.numTextField.text = @"";
                    }
                    NSLog(@"%@",cell.numTextField.text);
                    [cell.selectAirline setTitle:self.flightCompany forState:UIControlStateNormal];
                    cell.flightIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",self.flightCompany]];
                    if(!self.showSATableView)
                    {
                        cell.imageView.image = [UIImage imageNamed:@"航班箭头下.png"];
                    }
                    else
                    {
                        cell.imageView.image = [UIImage imageNamed:@"航班箭头上.png"];
                    }
                    mySelectAirline = cell.selectAirline;
                    return cell;
                }
                else
                {
                    static NSString *firstSectionIdentifier2 = @"firstSectionIdentifier2";
                    CitySearchButtons *cell = [tableView dequeueReusableCellWithIdentifier:firstSectionIdentifier2];
                    if(cell == nil){
                        cell = [[[CitySearchButtons alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstSectionIdentifier2] autorelease];
                    }
                    cell.delegate = self;
                    
                    cell.myStartCity = (Citys*)[self.selectCitysArray objectAtIndex:0];
                    cell.myEndCity = (Citys*)[self.selectCitysArray objectAtIndex:1];
                    myStartCity = cell.myStartCity;
                    myEndCity = cell.myEndCity;
                    
                    [cell.startCity setTitle:((Citys*)[self.selectCitysArray objectAtIndex:0])._city_name forState:UIControlStateNormal];
                    [cell.arrCity setTitle:((Citys*)[self.selectCitysArray objectAtIndex:1])._city_name forState:UIControlStateNormal];
                    return cell;
                }
            }
            else if(section == 2)
            {
                static NSString * sectionOneSearchIdentifier = @"sectionOneSearchIdentifier";
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:sectionOneSearchIdentifier];
                if (cell == nil) {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionOneSearchIdentifier] autorelease];
                    [cell.contentView addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:99 title:nil frame:CGRectMake((ViewWidth - 226)/2, 2, 226, 45) backImage:[UIImage imageNamed:@"航班动态查询按钮.png"]  target:self action:@selector(flightSearch:)]];
                    
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
		    cell.backgroundColor = [UIColor clearColor];

                return cell ;
            }
            else 
            {
                if(currentViewTag == 0)
                {
                    static NSString *thirdSectionIdentifier = @"thirdSectionIdentifier";
                    NumSearchHistory *cell = [tableView dequeueReusableCellWithIdentifier:thirdSectionIdentifier];
                    if(cell == nil){
                        cell = [[[NumSearchHistory alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdSectionIdentifier] autorelease];
                    }
                    cell.delegate = self;
                    int thenum = indexPath.row*2;
                    cell.leftNumber.text = [[self.numberHistory objectAtIndex:thenum] objectAtIndex:0];
                    cell.leftCitys.text = [NSString stringWithFormat:@"%@-%@",[[self.numberHistory objectAtIndex:thenum] objectAtIndex:1],[[self.numberHistory objectAtIndex:thenum] objectAtIndex:2]];

                    if (!([self.numberHistory count] % 2 == 1 && [self.numberHistory count] - thenum == 1)) {
                        cell.rightNumber.text = [[self.numberHistory objectAtIndex:thenum+1] objectAtIndex:0];
                        cell.rightCitys.text = [NSString stringWithFormat:@"%@-%@",[[self.numberHistory objectAtIndex:thenum+1] objectAtIndex:1],[[self.numberHistory objectAtIndex:thenum+1] objectAtIndex:2]];
                        [cell.rightNumber setHidden:NO];
                        [cell.rightCitys setHidden:NO];
                        [cell.rightHistory setHidden:NO];
                    }
                    else
                    {
                        [cell.rightNumber setHidden:YES];
                        [cell.rightCitys setHidden:YES];
                        [cell.rightHistory setHidden:YES];
                    }
                    
                    return cell;
                }
                else
                {
                    static NSString *thirdSectionIdentifier2 = @"thirdSectionIdentifier2";
                    CitySearchHistory *cell = [tableView dequeueReusableCellWithIdentifier:thirdSectionIdentifier2];
                    if(cell == nil){
                        cell = [[[CitySearchHistory alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdSectionIdentifier2] autorelease];
                    }
                    cell.delegate = self;
                    int thenum = indexPath.row*2;
                    [cell.leftButton setTitle:[NSString stringWithFormat:@"%@-%@",[[self.citysHistory objectAtIndex:thenum]objectAtIndex:1],[[self.citysHistory objectAtIndex:thenum]objectAtIndex:3]] forState:UIControlStateNormal];
                    cell.leftCode = [NSString stringWithFormat:@"%@-%@",[[self.citysHistory objectAtIndex:thenum]objectAtIndex:0],[[self.citysHistory objectAtIndex:thenum]objectAtIndex:2]];
                    
                    if (!([self.citysHistory count] % 2 == 1 && [self.citysHistory count] - thenum == 1)) {
                        [cell.rightButton setTitle:[NSString stringWithFormat:@"%@-%@",[[self.citysHistory objectAtIndex:thenum+1]objectAtIndex:1],[[self.citysHistory objectAtIndex:thenum+1]objectAtIndex:3]] forState:UIControlStateNormal];
                        cell.rightCode = [NSString stringWithFormat:@"%@-%@",[[self.citysHistory objectAtIndex:thenum+1]objectAtIndex:0],[[self.citysHistory objectAtIndex:thenum+1]objectAtIndex:2]];
                        
                        [cell.rightButton setHidden:NO];
                    }
                    else
                    {
                        [cell.rightButton setHidden:YES];
                    }
                    
                    return cell;
                }
                
            }
        }
        else
        {
            if(section == 0)
            {
                static NSString * titleViewidentifier = @"titleViewidentifier";
                TitleView * cell = [tableView dequeueReusableCellWithIdentifier:titleViewidentifier];
                if (cell == nil) {
                    cell = [[[TitleView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleViewidentifier] autorelease];
                }
                [cell.titleBackGround setImage:[UIImage imageNamed:@"航班动态我的关注.png"]];
                cell.delegate = self;
                return cell;
            }
            else 
            {
                static NSString *myAttentionCellIdentifier = @"myAttentionCellIdentifier";
                MyAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:myAttentionCellIdentifier];
                if(cell == nil){
                    cell = [[[MyAttentionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myAttentionCellIdentifier] autorelease];
                }
                if(indexPath.row == 4)
                {
                    cell.dottedLine.hidden = YES;
                    cell.backGroundImageView.frame = CGRectMake(8, 0, 304, 55);
                    [cell.contentView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(8, 54, 304, 12) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
                }
                if(indexPath.row+1 <= [self.getMyAttentionList.myAttentionList count])//我的关注始终显示5条背景图
                {
                    MyAttention *myAttention = (MyAttention*)[self.getMyAttentionList.myAttentionList objectAtIndex:indexPath.row];
                    cell.ids = myAttention.ids;
                    NSURL *url = [NSURL URLWithString:myAttention.flightLogo];
                    cell.flightIcon.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                    cell.flightCompany.text = [NSString stringWithFormat:@"%@%@",myAttention.flightCompang,myAttention.flightNo];
                    cell.flightStartCity.text = myAttention.departure;
                    cell.flightArrivalCity.text = myAttention.arrival;
                    cell.arrowImageView.hidden = NO;
                    cell.subordinateImageView.hidden = NO;
                }
                else {
                    cell.ids = nil;
                    cell.flightIcon.image = nil;
                    cell.flightCompany.text = nil;
                    cell.flightStartCity.text = nil;
                    cell.flightArrivalCity.text = nil;
                    cell.arrowImageView.hidden = YES;
                    cell.subordinateImageView.hidden = YES;
                }
                if((indexPath.row+1) == 5)
                {
                    cell.dottedLine.hidden = YES;
                }
                return cell;
            }
        }
    }
    else
    {
        if(indexPath.row == 0)
        {
            static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
            if (cell == nil)
            {
                int offx = (ViewWidth - 304)/2;
                // Create a cell to display an ingredient.
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                               reuseIdentifier:showUserInfoCellIdentifier]
                        autorelease];
                self.domesticAirBtn = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"domesticAir_blue.png"] frame:CGRectMake(offx + 13, 5, 115, 30) target:self action:@selector(changeFlights:)];
                self.internationalAirBtn = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"internationalAir_gray.png"] frame:CGRectMake(offx + 127, 5, 115, 30) target:self action:@selector(changeFlights:)];
                self.domesticAirBtn.tag = 0;
                self.internationalAirBtn.tag = 1;
                [cell.contentView addSubview:self.domesticAirBtn];
                [cell.contentView addSubview:self.internationalAirBtn];
            }
             cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
        else
        {
            NSString * selectAlineidentifier = [NSString stringWithFormat:@"selectAlineidentifier%d", indexPath.row];
            SelectAlineCell * cell = [tableView dequeueReusableCellWithIdentifier:selectAlineidentifier];
            if (cell == nil) {
                cell = [[[SelectAlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectAlineidentifier] autorelease];
            }
            cell.delegate = self;
            int thenum = (indexPath.row-1)*2;
            [cell.leftButton setTitle:[self infoWithIndex:thenum] forState:UIControlStateNormal];
            cell.leftIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[cell.leftButton.titleLabel.text substringFromIndex:cell.leftButton.titleLabel.text.length-2]]];
            if (!([self.flightCompanys count] % 2 == 1 && [self.flightCompanys count] - thenum == 1)) {
                [cell.rightButton setTitle:[self infoWithIndex:thenum+1] forState:UIControlStateNormal];
                cell.rightIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[cell.rightButton.titleLabel.text substringFromIndex:cell.rightButton.titleLabel.text.length-2]]];
                [cell.rightButton setHidden:NO];
                [cell.rightIcon setHidden:NO];
            }
            else
            {
                [cell.rightImage setHidden:YES];
                [cell.rightButton setHidden:YES];
                [cell.rightIcon setHidden:YES];
            }
            return cell;

        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
	
	return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if(currentViewTag == 2)
    {
        if(indexPath.section != 0 && (indexPath.row <= [self.getMyAttentionList.myAttentionList count]-1))
        {
            return YES;
        }
        else {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		NSLog(@"%d",indexPath.row);
        deleteNUm = indexPath.row;
        MyAttention *myAttention = (MyAttention*)[self.getMyAttentionList.myAttentionList objectAtIndex:indexPath.row];
        ASIFormDataRequest * theRequest = [InterfaceClass cancelAttentionStateWithUserId:[UserInfo sharedUserInfo].userID ids:myAttention.ids];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCancelPaseredResult:) Delegate:self needUserType:Member];
		
	}
	else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	}
}

-(void)changeFlights:(UIButton*)sender
{
    if(sender.tag)
    {
        [self.domesticAirBtn setImage:[UIImage imageNamed:@"domesticAir_gray.png"] forState:UIControlStateNormal];
        [self.internationalAirBtn setImage:[UIImage imageNamed:@"internationalAir_blue.png"] forState:UIControlStateNormal];
//        [self gettFlightCompanys:@"国际航空公司"];
//        [self.selectAlineTableView reloadData];
        
        flightsType = 1;
    
        if(self.showSATableView)
        {
            [self.selectAlineTableView setContentOffset:CGPointMake(0, 0)];
            self.showSATableView = NO;
            self.myTableView.scrollEnabled = YES;
            [self.selectAlineTableView removeFromSuperview];
            [self.selectAlineBackGround removeFromSuperview];
        }
        self.flightCompany = [NSString stringWithFormat:@"国际"];
        
    }
    else
    {
        flightsType = 0;
        self.numFlight = @"CZ";
        [self.domesticAirBtn setImage:[UIImage imageNamed:@"domesticAir_blue.png"] forState:UIControlStateNormal];
        [self.internationalAirBtn setImage:[UIImage imageNamed:@"internationalAir_gray.png"] forState:UIControlStateNormal];
//        [self gettFlightCompanys:@"国内航空公司"];
//        [self.selectAlineTableView reloadData];
    }
    [self.myTableView reloadData];
}

-(void)onCancelPaseredResult:(NSDictionary *)dic
{
    NSLog(@"取消!");
    if([[dic objectForKey:@"statusCode"] intValue] == -99999)
    {
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
    }
    else
    {
        [self.getMyAttentionList.myAttentionList removeObjectAtIndex:deleteNUm];
        [self.myTableView reloadData];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(currentViewTag == 2 && indexPath.section!= 0)
    {
        MyAttentionCell* cell = (MyAttentionCell*)[tableView cellForRowAtIndexPath:indexPath];
        if(![cell.flightCompany.text isEqualToString:@""] && (cell.flightCompany.text!= nil))
        {
            [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(10, 0, 300, 60)];
            
              MyAttention *myAttention = (MyAttention*)[self.getMyAttentionList.myAttentionList objectAtIndex:indexPath.row];
            self.numFlight = myAttention.flightNo;
            ASIFormDataRequest * theRequest = [InterfaceClass getFlightDynamicByFlightNoWithUserId:[UserInfo sharedUserInfo].userID flightNo:self.numFlight];
            [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onNumPaseredResult:) Delegate:self needUserType:Member];
        }
        NSLog(@"查询航班号：===%@===",cell.flightCompany.text);
    }
}
@end
