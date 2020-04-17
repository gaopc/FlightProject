//
//  TooltipView.m
//  FlightProject
//
//  Created by admin on 12-11-20.
//
//

#import "TooltipView.h"

@implementation TooltipView
@synthesize _backView, _cancelButton, _toolSubTitle, _toolTitle;

- (void)dealloc
{
    self._backView = nil;
    self._cancelButton = nil;
    self._toolSubTitle = nil;
    self._toolTitle = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self._backView = [UIImageView ImageViewWithFrame:self.bounds];
        
        self._backView.image = [UIImage imageNamed:@"弹出层.png"];
        self._cancelButton = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(self.frame.size.width - 40, 10, 30, 30) backImage:[UIImage imageNamed:@"关闭按钮.png"] target:nil action:nil];
        self._toolTitle = [UISubLabel labelWithTitle:@"保险说明" frame:CGRectMake(0, 5, self.frame.size.width, 20) font:FontSize30 color:FontColor909090 alignment:NSTextAlignmentCenter];
//        self._toolSubTitle = [UISubLabel labelWithTitle:@"1.保险名称：平安航空旅客意外伤害保险\n2.保险金额：航空意外6万人民币，航空意外医疗6万人民币\n3.保险期限：当次航班" frame:CGRectMake(30, 50, self.frame.size.width - 60, 20) font:FontSize24 color:FontColor656565 alignment:NSTextAlignmentLeft autoSize:YES];
        
        UISubTextView * textview = [[UISubTextView alloc] initWithFrame:CGRectMake(15, 40, self.frame.size.width - 30, self.frame.size.height - 65)];
        self._toolSubTitle = textview;
        [textview release];
        self._toolSubTitle.editable = YES;
        self._toolSubTitle.font = FontSize24;
        self._toolSubTitle.textColor = FontColor656565;
        self._toolSubTitle.delegate = self;
        self._toolSubTitle.backgroundColor = [UIColor clearColor];
        self._toolSubTitle.text = @"1.保险名称：平安航空旅客意外伤害保险\n2.保险金额：航空意外伤害保障保额80万元人民币\n3.保险期限：当次航班";
        
        [self addSubview:self._backView];
        [self addSubview:self._cancelButton];
        [self addSubview:self._toolTitle];
        [self addSubview:self._toolSubTitle];

    }
    return self;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView

{
	return NO;
}

@end
