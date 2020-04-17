//
//  CityPickerView.m
//  FlightProject
//
//  Created by gaopengcheng on 14-9-4.
//
//

#import "CityPickerView.h"

#define kDuration 0.3

@implementation CityPickerView
@synthesize _selectItem, _selectCounty, _selectCity, _selectProvince;

- (void)dealloc
{
    self._selectProvince = nil;
    self._selectCity = nil;
    self._selectItem = nil;
    self._selectCounty = nil;
    [provinces release];
    [cities release];
    [counties release];
    [super dealloc];
}

- (id)initWithTitle:(NSString *)title delegate:(id)delegate data:(NSArray *)array withProvince:(NSString *)province withCity:(NSString *)city withCounty:(NSString *)county
{
    self = [super initWithFrame:CGRectMake(0, 0, ViewWidth, 260)];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 44)];
    [imgView setImage:[UIImage imageNamed:@"bg_023@2x.png"]];
    
    myPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, ViewWidth, 216)];
    myPicker.backgroundColor = [UIColor whiteColor];
    myPicker.alpha = 0.9;
    myPicker.showsSelectionIndicator = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:imgView.frame];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"btn_021@2x.png"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"btn_021.press@2x.png"] forState:UIControlStateHighlighted];
    leftButton.frame = CGRectMake(10, 1, 42, 42);
    [leftButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"btn_020@2x.png"] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"btn_020.press@2x.png"] forState:UIControlStateHighlighted];
    rightButton.frame = CGRectMake(268, 1, 42, 42);
    [rightButton addTarget:self action:@selector(locate:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:imgView];
    [self addSubview:titleLabel];
    [self addSubview:leftButton];
    [self addSubview:rightButton];
    [self addSubview:myPicker];
    
    
    self.delegate = delegate;
    myPicker.dataSource = self;
    myPicker.delegate = self;
    
    dataArray = [[NSArray alloc] initWithArray:array];
    
    provinces = [[NSMutableArray alloc] init];
    cities = [[NSMutableArray alloc] init];
    counties = [[NSMutableArray alloc] init];
    int provinceIndex = 0;
    int cityIndex = 0;
    int countyIndex = 0;
    
    for (int i = 0; i < [dataArray count]; i ++) {
        TsProvince *provinceData = [TsProvince setProvinceData:[dataArray objectAtIndex:i]];
        [provinces addObject:provinceData];
        
        if ([provinceData._provinceName isEqualToString:province] || (province.length == 0 && i == 0)) {
            provinceIndex = i;

            provinceName = provinceData._provinceName;
            
            for (int j = 0; j < [provinceData._citys count]; j ++) {
                TsCity *cityData = [TsCity setCityData:[provinceData._citys objectAtIndex:j]];
                [cities addObject:cityData];
                
                if ([cityData._cityName isEqualToString:city] || (city.length == 0 && j == 0)) {
                    cityIndex = j;
               
                    cityName = cityData._cityName;
                    
                    for (int k = 0; k < [cityData._county count]; k ++) {
                        TsCounty *countyData = [TsCounty setCountyData:[cityData._county objectAtIndex:k]];
                        [counties addObject:countyData];
                        
                        if ([countyData._countyName isEqualToString:county] || (county.length == 0 && k == 0)) {
                            countyIndex = k;
                        
                            countyName = countyData._countyName;
                        }
                    }
                }
            }
        }
    }
    
    [imgView release];
    
    [myPicker selectRow:provinceIndex inComponent:0 animated:NO];
    [myPicker selectRow:cityIndex inComponent:1 animated:NO];
    [myPicker selectRow:countyIndex inComponent:2 animated:NO];
    return self;
}

- (void)showInView:(UIView *) view
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DDLocateView"];
    
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    
    [view addSubview:self];
}

- (void)closeView
{
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
}

#pragma mark - PickerView lifecycle
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
            return [counties count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            TsProvince *provinceInfoData = [provinces objectAtIndex:row];
            return [NSString stringWithFormat:@"%@", provinceInfoData._provinceName];
            break;
        }
        case 1:
        {
            TsCity *cityInfoData = [cities objectAtIndex:row];
            return [NSString stringWithFormat:@"%@", cityInfoData._cityName];
            break;
        }
        case 2:
        {
            TsCounty *countyInfoData = [counties objectAtIndex:row];
            return [NSString stringWithFormat:@"%@", countyInfoData._countyName];
            break;
        }
            
        default:
            return nil;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
        {
            [cities removeAllObjects];
            [counties removeAllObjects];
            
            TsProvince *provinceData = [provinces objectAtIndex:row];
            for (int i = 0; i < [provinceData._citys count]; i ++) {
                TsCity *cityData = [TsCity setCityData:[provinceData._citys objectAtIndex:i]];
                [cities addObject:cityData];
                
                if (i == 0) {
                    cityName = cityData._cityName;
                    
                    for (int k = 0; k < [cityData._county count]; k ++) {
                        TsCounty *countyData = [TsCounty setCountyData:[cityData._county objectAtIndex:k]];
                        [counties addObject:countyData];
                        
                        if (k == 0) {
                            countyName = countyData._countyName;
                        }
                    }
                }
            }
            
            [myPicker reloadAllComponents];
            [myPicker selectRow:0 inComponent:1 animated:YES];
            [myPicker selectRow:0 inComponent:2 animated:YES];
            
            provinceName = provinceData._provinceName;
            break;
        }
            
        case 1:
        {
            [counties removeAllObjects];
            
            TsCity *cityData = [cities objectAtIndex:row];
            for (int i = 0; i < [cityData._county count]; i ++) {
                TsCounty *countyData = [TsCounty setCountyData:[cityData._county objectAtIndex:i]];
                [counties addObject:countyData];
                
                if (i == 0) {
                    countyName = countyData._countyName;
                }
            }
            
            [myPicker reloadComponent:2];
            [myPicker selectRow:0 inComponent:2 animated:YES];
            
            cityName = cityData._cityName;
            break;
        }
        case 2:
        {
            TsCounty *countyData = [counties objectAtIndex:row];
            countyName = countyData._countyName;
            break;
        }
        default:
            break;
    }
}


#pragma mark - Button lifecycle

- (void)cancel:(id)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"TSLocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}

- (void)locate:(id)sender {
    self._selectItem = [NSString stringWithFormat:@"%@/%@%@", provinceName, cityName, countyName];
    self._selectCounty = countyName;
    self._selectCity = cityName;
    self._selectProvince = provinceName;
    
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"TSLocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
}
@end
