//
//  NoAutoDpreciateView.m
//  FlightProject
//
//  Created by 崔立东 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  未接收到自动降价通知页面
//

#import "NoAutoDpreciateView.h"

@implementation NoAutoDpreciateView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		self.backgroundColor = [UIColor clearColor];   
		
		noAutoDpreciateTitleLabel = [UISubLabel labelWithTitle:@"自动降价说明" frame:CGRectMake(70, 20, 180, 22)font:FontSize40 alignment:NSTextAlignmentCenter];    
		noAutoDpreciateTitleLabel.backgroundColor = [UIColor clearColor];
		noAutoDpreciateTitleLabel.textColor = FontColorFF8813;
		[self addSubview:noAutoDpreciateTitleLabel];
		
		NSString *directions =@"    系统会在您所关注的航班起飞前，自动查询相同日期、航程、航班上的票价情况，当符合条件的低价票出现，与已购票（扣除退票手续费）差额大于等于100元时 ，系统会发送短信提示您，您可以通过致电400-6858-999客服中心由客服人员为您重新购买机票，节约的机票款将以畅达币形式充值到您的会员账户中，用于您再次购买机票时抵扣机票款使用。\n友情提示：\n1）当您使用自动降价服务后，再次申请退票时，退还的票款将以畅达币形式返回到您的账户；\n2）儿童客票不参与自动降价服务；\n3）客票状态发生过改变后（改签、升舱）自动退出自动降价服务；";
		noAutoDpreciateDirectionsLabel = [[UISubTextView alloc] initWithFrame:CGRectMake(10, 50, 300, self.frame.size.height - 65.0f)];
		noAutoDpreciateDirectionsLabel.textColor = FontColor454545;
		noAutoDpreciateDirectionsLabel.font = FontSize30;
		noAutoDpreciateDirectionsLabel.editable = YES;
		noAutoDpreciateDirectionsLabel.text = directions;
		noAutoDpreciateDirectionsLabel.delegate = self;
		noAutoDpreciateDirectionsLabel.backgroundColor = [UIColor clearColor];
		//[self.mainView addSubview:self.mainPostAddress];
		
		
		[self addSubview:noAutoDpreciateDirectionsLabel];
		
	}
	return self;
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	return NO;
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
