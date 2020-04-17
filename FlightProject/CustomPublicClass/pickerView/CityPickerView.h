//
//  CityPickerView.h
//  FlightProject
//
//  Created by gaopengcheng on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CityPickerViewModel.h"

@interface CityPickerView : UIActionSheet<UIPickerViewDelegate, UIPickerViewDataSource> {
    NSMutableArray *provinces;
    NSMutableArray	*cities;
    NSMutableArray	*counties;
    
    UIButton *leftButton;
    UIButton *rightButton;
    UIPickerView *myPicker;
    NSArray *dataArray;                 //存放数据
    
    NSString *provinceName;
    NSString *cityName;
    NSString *countyName;
}
@property (retain, nonatomic) NSString *_selectItem;
@property (retain, nonatomic) NSString *_selectCounty;
@property (retain, nonatomic) NSString *_selectProvince;
@property (retain, nonatomic) NSString *_selectCity;

- (id)initWithTitle:(NSString *)title delegate:(id)delegate data:(NSArray *)array withProvince:(NSString *)province withCity:(NSString *)city withCounty:(NSString *)county;
- (void)showInView:(UIView *)view;
- (void)closeView;
@end
