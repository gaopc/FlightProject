//
//  UICityPicker.h
//  DDMates
//
//  Created by Gaopengcheng  on 9/20/2012.
//  Copyright (c) 2011 TelenavSoftware, Inc. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "MapDataResponse.h"

@interface TSLocateView : UIActionSheet<UIPickerViewDelegate, UIPickerViewDataSource> {
    NSMutableArray *provinces;
    NSMutableArray	*cities;
    
    UISubLabel *titleLabel;
    UIButton *leftButton;
    UIButton *rightButton;
    UIPickerView *locatePicker;
    NSArray *dataArray;                 //存放数据
    NSMutableArray *selectArray;               //存放picker的各列的选择
}

@property (retain, nonatomic) UISubLabel *titleLabel;
@property (retain, nonatomic) UIPickerView *locatePicker;
@property (retain, nonatomic) NSMutableArray *selectArray;

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate data:(NSArray *)array;

- (void)showInView:(UIView *)view;

@end
