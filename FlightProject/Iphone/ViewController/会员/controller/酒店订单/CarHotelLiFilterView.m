//
//  CarHotelLiFilterView.m
//  FlightProject
//
//  Created by 小月 on 13-1-17.
//
//

#import "CarHotelLiFilterView.h"

@implementation FilterButtonView
@synthesize selectButton,aLabel,isSelecded;

- (void)dealloc
{
    self.selectButton = nil;
    self.aLabel = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame LabelText:(NSString*)text imageName:(NSString*)imageName tag:(NSInteger)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom tag:tag title:nil backImage:[UIImage imageNamed:imageName] frame:CGRectMake(0, 15, 20, 20) font:nil color:nil target:self action:nil];
        self.aLabel = [UISubLabel labelWithTitle:text frame:CGRectMake(25, 15, 100, 20) font:FontSize22 color:FontColor2585CF alignment:NSTextAlignmentLeft];
        self.isSelecded = NO;
        [self addSubview:self.selectButton];
        [self addSubview:self.aLabel];
        self.tag = tag;
    }
    return self;
}

@end




@implementation CarHotelLiFilterView
@synthesize delegate,filterDownButton,statusArray,bgImage;

- (void)dealloc
{
    self.delegate = nil;
    self.filterDownButton = nil;
    self.statusArray = nil;
    self.bgImage = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:self.bounds image:[UIImage imageNamed:@"background.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"订单状态" frame: CGRectMake(0, 2, ViewWidth, 25) font:FontSize20 color:FontColor696969 alignment:NSTextAlignmentCenter]];
        UIImageView * backGroundImageV = [UIImageView ImageViewWithFrame:CGRectMake(0, 30, ViewWidth, 77) image:[UIImage imageNamed:@"FilterBackground1.png"]];
        self.bgImage = backGroundImageV;
        [self addSubview:backGroundImageV];
        self.filterDownButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((ViewWidth-112)/2, frame.size.height - 50, 112, 35) backImage:[UIImage imageNamed:@"FilterDown.png"] target:self   action:@selector(filterDown)];
        [self addSubview:self.filterDownButton];
    }
    return self;
}


-(void)setButtons
{
    for (FilterButtonView * elem in [self subviews])
    {
        if ([elem isKindOfClass:[FilterButtonView class]]) {
            [elem removeFromSuperview];
        }
    }
    
    for(int i=0;i<[self.statusArray count];i++)
    {
        if (i>2) {
            CGRect rect = self.bgImage.frame;
            rect.size.height = 100;
            self.bgImage.frame = rect;
        }
        else{
            CGRect rect = self.bgImage.frame;
            rect.size.height = 50;
            self.bgImage.frame = rect;
        }
        
        int x;
        int y;
        (i == 3 || i==4 || i==5)?(x=105*(i-3) + 20):(x=105*i + 20);
        (i == 3 || i==4 || i==5)?(y=80):(y=30);
        NSString *imageName;
        (i == 0)?(imageName = @"FilterSingleSelected.png"):(imageName = @"FilterSingleUnSelected.png");
        
        FilterButtonView *filterButtonView = [[FilterButtonView alloc] initWithFrame:CGRectMake(x, y, 100, 50) LabelText:[self.statusArray objectAtIndex:i] imageName:imageName tag:i];
        if(i==0)
        {
            filterButtonView.aLabel.textColor = FontColor2585CF;
        }
        else
        {
            filterButtonView.aLabel.textColor = FontColor333333;
        }
        
        
        [filterButtonView.selectButton addTarget:self action:@selector(selectState:) forControlEvents:UIControlEventTouchUpInside];
        (i == 0)?(filterButtonView.isSelecded = YES):(filterButtonView.isSelecded = NO);
        [self addSubview:filterButtonView];
        [filterButtonView release];
        
        NSLog(@"==%@",filterButtonView);
    }
    
}
-(void)selectState:(UIButton*)sender
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectState:)]) {
        [self.delegate performSelector:@selector(selectState:) withObject:sender];
    }
}

-(void)filterDown
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterDown)]) {
        [self.delegate performSelector:@selector(filterDown)];
    }
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
