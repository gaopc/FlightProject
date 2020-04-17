//
//  NumKeyBoardDoneButton.m
//  KeyBoardTopBar
//
//  Created by 月 小 on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NumKeyBoardDoneButton.h"

@implementation NumKeyBoardDoneButton
@synthesize doneButton;
-(id)init{
    if((self = [super init])){
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        [self setKeyBoardDelegate];
        currentTextField = nil;
        doneButton = [[UIButton alloc] init];
        [self setDoneButton];
    }
    return self;
}
//设置当前输入框
-(void)setTextField:(UISubTextField*)textField{
    currentTextField = textField;
}
//设置键盘观察者
-(void)setKeyBoardDelegate{
    if (systemVersion >= SecondSYSTEMVERSION) {
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(keyboardShow:) 
                                                     name:UIKeyboardDidShowNotification 
                                                   object:nil];		
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(keyboardShow:) 
                                                     name:UIKeyboardWillShowNotification 
                                                   object:nil];
    }
    if(systemVersion >= ThirdSYSTEMVERSION){
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardShow:) 
													 name:UITextInputCurrentInputModeDidChangeNotification 
												   object:nil];
    }
}
//添加完成按钮
-(void)addDoneButton{
    doneButton.hidden = NO;
    if([[[UIApplication sharedApplication] windows] count] < 2){
        return;
    }
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	UIView* keyboard;
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		keyboard = [tempWindow.subviews objectAtIndex:i];
		if (systemVersion >= SecondSYSTEMVERSION) {
			if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
				[keyboard addSubview:doneButton];
		} 
        else {
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
				[keyboard addSubview:doneButton];
		}
	}
}  
//设置完成按钮
-(void)setDoneButton{
    UIButton* adoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	adoneButton.frame = CGRectMake(0, 207, 106, 53);
	adoneButton.adjustsImageWhenHighlighted = NO;
	if (systemVersion >= FirstSYSTEMVERSION) {
		[adoneButton setImage:[UIImage imageNamed:@"DoneUp3.png"] forState:UIControlStateNormal];
		[adoneButton setImage:[UIImage imageNamed:@"DoneDown3.png"] forState:UIControlStateHighlighted];
	} 
    else {         
		[adoneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
		[adoneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
	}
	[adoneButton addTarget:self action:@selector(clickDone:) forControlEvents:UIControlEventTouchUpInside];
    doneButton = [adoneButton retain];
}
//判断显示的是系统键盘么(针对越狱机)
- (BOOL)isJailbroken {  
    NSString *keyboardName = [[UITextInputMode currentInputMode] primaryLanguage];
    if([keyboardName isEqualToString:@"en-US"] || [keyboardName isEqualToString:@"zh-Hans"]){
        
        return NO;//是系统键盘
    }
    else{
        return YES;
    }
} 
//判断键盘是否需要添加完成按钮
-(void)ifAddDoneButton{
    if(currentTextField.keyboardType == UIKeyboardTypeNumberPad){
        if(![self isJailbroken])
            [self addDoneButton];
    }
    else {
        doneButton.hidden = YES;
    }
}
//键盘显示后、输入法切换触发方法
- (void)keyboardShow:(NSNotification *)note{
    [self ifAddDoneButton];
}
//隐藏键盘
-(void)clickDone:(id)sender{
    doneButton.hidden = YES;
    [currentTextField resignFirstResponder];
}
-(void)dealloc{
    [super dealloc];
    if(currentTextField != nil)[currentTextField release];
    if(doneButton != nil)      [doneButton release];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
