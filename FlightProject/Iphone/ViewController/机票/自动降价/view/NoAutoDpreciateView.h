//
//  NoAutoDpreciateView.h
//  FlightProject
//
//  Created by 崔立东 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  未接收到自动降价通知页面
//

#import <UIKit/UIKit.h>

@interface NoAutoDpreciateView : UIView <UITextViewDelegate>
{
	UISubLabel *noAutoDpreciateTitleLabel;      //自动降价说明
	UISubTextView *noAutoDpreciateDirectionsLabel; //自动降价内容
	
	
}
@end
