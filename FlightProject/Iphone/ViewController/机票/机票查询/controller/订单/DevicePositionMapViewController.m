//
//  DevicePositionMapViewController.m
//  FlightProject
//
//  Created by admin on 12-11-15.
//
//

#import "DevicePositionMapViewController.h"

@interface DevicePositionMapViewController ()

@end

@implementation DevicePositionMapViewController

@synthesize _provinces,_terminalInfos;
@synthesize _selectCity;

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
    self._provinces = nil;
    self._terminalInfos = nil;
    self._selectCity = nil;
    
    [_mapView release];
    [locateView release];
    //    [_mapManager release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"终端机位置";
    
    // 设置mapView的Delegate
    if (_mapView == nil) {
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight - 44)];
        _mapView.delegate = self;
    }
    
    [self.view addSubview:_mapView];
    
    buttonView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, ViewWidth - 20, 30)];
    buttonView.backgroundColor = [UIColor whiteColor];
    buttonView.alpha = 0.9;
    
    UISubLabel *titleLab = [[UISubLabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
    titleLab.text = @"终端城市选择:";
    titleLab.font = [UIFont boldSystemFontOfSize:15];
    titleLab.backgroundColor = [UIColor clearColor];
    
    UISubLabel *endLab = [[UISubLabel alloc] initWithFrame:CGRectMake(buttonView.frame.size.width - 30, 5, 20, 20)];
    endLab.text = @">";
    endLab.font = [UIFont systemFontOfSize:12];
    endLab.backgroundColor = [UIColor clearColor];
    
    cityLab = [[UISubLabel alloc] initWithFrame:CGRectMake(140, 5, 100, 20)];
    cityLab.backgroundColor = [UIColor clearColor];
    cityLab.font = [UIFont systemFontOfSize:12];
    cityLab.text = @"北京";
    
    selectCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectCityButton.frame = CGRectMake(10, 5, ViewWidth - 20, 30);
    selectCityButton.backgroundColor = [UIColor clearColor];
    [selectCityButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonView addSubview:endLab];
    [buttonView addSubview:titleLab];
    [buttonView addSubview:cityLab];
    
    [self.view addSubview:buttonView];
    [self.view addSubview:selectCityButton];
    
    [endLab release];
    [titleLab release];
    [cityLab release];
    [buttonView release];
    
    [self selectCity];
}

- (void)clickButton:(id)sender
{
    if ([self._provinces count] == 0)
    {
        [UIAlertView alertViewWithMessage:@"无法获取到城市数据，请再次请求网络数据！" tag:0 delegate:self];
    }
    else {
        if (locateView == nil)
        {
            locateView = [[TSLocateView alloc] initWithTitle:@"定位城市" delegate:self data:self._provinces];
        }
        
        buttonView.backgroundColor = [UIColor brownColor];
        selectCityButton.hidden = YES;
        [locateView showInView:self.view];
    }
}

- (void)selectCity
{
    ASIFormDataRequest * theRequest = [InterfaceClass getTerminalCityList];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCitylistPaseredResult:) Delegate:self needUserType:Default];
}

- (void)onCitylistPaseredResult:(NSDictionary *)dic
{
    self._provinces = [TerminalProvince TerminalProvince:dic];
    TerminalProvince * province = [self._provinces objectAtIndex:0];
    TerminalCity * city = [province._citys objectAtIndex:0];
    self._selectCity = city;
    cityLab.text = city._cityName;
    [self getCityInfo:city._cityCode];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    buttonView.backgroundColor = [UIColor whiteColor];
    selectCityButton.hidden = NO;
    if (buttonIndex == 1) {
        NSArray * selectArray = locateView.selectArray;
        TerminalProvince * province = [self._provinces objectAtIndex:[[selectArray objectAtIndex:0] intValue]];
        TerminalCity * city = [province._citys objectAtIndex:[[selectArray objectAtIndex:1] intValue]];
        NSString * selectCityCode = city._cityCode;
        [self getCityInfo:selectCityCode];
        self._selectCity = city;
    }
}

- (void)getCityInfo:(NSString *)cityCode
{
    ASIFormDataRequest * theRequest = [InterfaceClass getTerminalInfoByCity:cityCode];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onCityInfoPaseredResult:) Delegate:self needUserType:Default];
}

- (void)onCityInfoPaseredResult:(NSDictionary *)dic
{
    cityLab.text = self._selectCity._cityName;
    self._terminalInfos = [TerminalInfo TerminalInfo:dic];
    [self showAnnotationInMap];
}

-(void) showAnnotationInMap
{
    CLLocationCoordinate2D centerOff;
    [_mapView removeAnnotations:_mapView.annotations];
    TerminalInfo *firstAnnotation = [self._terminalInfos objectAtIndex:0];
    for (TerminalInfo * info in self._terminalInfos) {
        if ([firstAnnotation._address rangeOfString:self._selectCity._cityName].length == 0) {
            if ([info._address rangeOfString:self._selectCity._cityName].length> 0) {
                firstAnnotation = info;
            }
        }
        CustomAnnotation* item = [[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake([info._latitude doubleValue], [info._longitude doubleValue])];
        item.title = info._address;
        [_mapView addAnnotation:item];
        [item release];
    }
    
    if ([self._terminalInfos count] > 0) {

        centerOff = CLLocationCoordinate2DMake([firstAnnotation._latitude doubleValue], [firstAnnotation._longitude doubleValue]);
    }
    else{
        centerOff = CLLocationCoordinate2DMake(39.90960456049752, 116.3972282409668);
    }
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.2, 0.2);
    MKCoordinateRegion regin = MKCoordinateRegionMake(centerOff, span);
    [_mapView setRegion:regin animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSString *AnnotationViewID = annotation.title;
    MKAnnotationView *pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (pinView == nil) {
        pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotation.title] autorelease];
    }
    else {
        pinView.annotation = annotation;
    }
    pinView.canShowCallout  = TRUE;
    return pinView;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}

@end
