//
//  NumKeyBoardDoneButton.h
//  KeyBoardTopBar
//
//  Created by 月 小 on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define FirstSYSTEMVERSION  3.0
#define SecondSYSTEMVERSION 3.2
#define ThirdSYSTEMVERSION  4.2

@interface NumKeyBoardDoneButton : NSObject{
    NSInteger     systemVersion;             //当前系统版本号
    UISubTextField   *currentTextField;         //当前输入框
    UIButton      *doneButton;               //完成按钮
}
@property(nonatomic,retain)UIButton *doneButton;
-(id)init;
-(void)setKeyBoardDelegate;                  //设置键盘观察者
-(void)setTextField:(UISubTextField*)textField; //设置当前输入框
-(void)addDoneButton;                        //添加完成按钮
-(void)setDoneButton;                        //设置完成按钮
-(void)ifAddDoneButton;                      //判断键盘是否需要添加完成按钮
-(void)clickDone:(id)sender;                 //隐藏键盘
@end
