//
//  UICityPicker.m
//  DDMates
//
//  Created by ShawnMa on 12/16/11.
//  Copyright (c) 2011 TelenavSoftware, Inc. All rights reserved.
//

#import "TSLocateView.h"

#define kDuration 0.3

@implementation TSLocateView

@synthesize titleLabel;
@synthesize locatePicker;
@synthesize selectArray;

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate data:(NSMutableArray *)array
{
    self = [super initWithFrame:CGRectMake(0, 0, ViewWidth, 260)];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 44)];
    [imgView setImage:[UIImage imageNamed:@"bg_023@2x.png"]];
    
    locatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, ViewWidth, 216)];
    locatePicker.backgroundColor = [UIColor whiteColor];
    locatePicker.alpha = 0.9;
    locatePicker.showsSelectionIndicator = YES;
    
    titleLabel = [[UISubLabel alloc] initWithFrame:imgView.frame];
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
    [self addSubview:locatePicker];
    
    
    self.delegate = delegate;
    self.titleLabel.text = title;
    self.locatePicker.dataSource = self;
    self.locatePicker.delegate = self;
    
    dataArray = [[NSArray alloc] initWithArray:array];
    
    provinces = [[NSMutableArray alloc] init];
    cities = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [dataArray count]; i ++) {
        TerminalProvince *provinceData = [dataArray objectAtIndex:i];
        [provinces addObject:provinceData._provinceName];

        if (i == 0) {
            for (int j = 0; j < [provinceData._citys count]; j ++) {
                TerminalCity *cityData = [provinceData._citys objectAtIndex:j];
                [cities addObject:cityData];
            }
        }
    }
    
    selectArray = [[NSMutableArray alloc] init];
    for (int i= 0; i < 2; i ++) {
        [selectArray addObject:@"0"];
    }
    
    [imgView release];
    return self;
}

- (void)showInView:(UIView *) view
{

//    for (int i = 0; i < 2; i ++) {
//        NSString *selectId = [NSString stringWithFormat:@"%d", 0];
//        [selectArray replaceObjectAtIndex:i withObject:selectId];
//    }
    
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

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{    
//    if (component < [dataArray count])
//    {
//        return [[dataArray objectAtIndex:component] count];
//    }
//    return 0;
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
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
            return [provinces objectAtIndex:row];
            break;
        case 1:
        {
            TerminalCity *cityInfoData = [cities objectAtIndex:row];
            return [NSString stringWithFormat:@"%@", cityInfoData._cityName];
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
            TerminalProvince *pData = [dataArray objectAtIndex:row];
            for (int j = 0; j < [pData._citys count]; j ++) {
                TerminalCity *cityData = [pData._citys objectAtIndex:j];
                [cities addObject:cityData];
            }
            
            [self.locatePicker selectRow:0 inComponent:1 animated:NO];
            [self.locatePicker reloadComponent:1];
            
            NSString *selectId = [NSString stringWithFormat:@"%d", row];
            [selectArray replaceObjectAtIndex:0 withObject:selectId];
            [selectArray replaceObjectAtIndex:1 withObject:@"0"];
            break;
        }
            
        case 1:
        {
            NSString *selectId = [NSString stringWithFormat:@"%d", row];
            [selectArray replaceObjectAtIndex:1 withObject:selectId];
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

- (void)dealloc
{
    [selectArray release];
    [titleLabel release];
    [locatePicker release];
    [super dealloc];
}
@end
