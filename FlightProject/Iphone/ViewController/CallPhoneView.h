//
//  CallPhoneView.h
//  FlightProject
//
//  Created by 小月 on 12-11-9.
//
//

#import <UIKit/UIKit.h>

@interface CallPhoneView : UIView <UIActionSheetDelegate>

+(CallPhoneView*)getCallPhoneView:(CGRect)frame TitleArray:(NSArray*)titleArray;
@end
