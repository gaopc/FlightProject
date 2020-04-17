//
//  CallPhoneView.m
//  FlightProject
//
//  Created by 小月 on 12-11-9.
//
//

#import "CallPhoneView.h"

@implementation CallPhoneView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}

+(CallPhoneView*)getCallPhoneView:(CGRect)frame TitleArray:(NSArray*)titleArray
{
    CallPhoneView *callPhoneView = [[CallPhoneView alloc] initWithFrame:CGRectMake(0,0 , frame.size.width, frame.size.height+20)];
    callPhoneView.backgroundColor = [UIColor clearColor];
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"发现新版本,升级体验下吧" delegate:callPhoneView
                                             cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil,nil];
    for(int i=0;i<[titleArray count];i++)
    {
        [sheet addButtonWithTitle:[titleArray objectAtIndex:i]];
    }
    
    [sheet showInView:callPhoneView];
    [sheet release];
    return [callPhoneView autorelease];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"CallPhoneView---actionSheet");
    NSLog(@"%@",[actionSheet buttonTitleAtIndex:buttonIndex]);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
