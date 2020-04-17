//
//  IphoneHomeView.m
//  FlightProject
//
//  Created by 张晓婷 on 14-12-5.
//
//

#import "IphoneHomeView.h"



@implementation ActivityItem
@synthesize _id;
@synthesize _content,_imageUrl,_state,_titile;
- (void)dealloc
{
    self._id = nil;
    self._content = nil;
    self._imageUrl = nil;
    self._state = nil;
    self._titile = nil;

    [super dealloc];
}

+(ActivityItem *) ActivityItemWithDic:(NSDictionary *)dic
{
    ActivityItem * item = [[ActivityItem alloc] init];
    item._id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"activityId"]];
    item._content = [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
    item._imageUrl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"imageurl"]];
    item._state = [NSString stringWithFormat:@"%@",[dic objectForKey:@"state"]];
    item._titile = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];

    return [item autorelease];
}

@end


@interface IphoneHomeView ()
{
    UIScrollView * bannerView;
    UIScrollView * buttonView;
    UIPageControl * bannerPage;
    UIPageControl * buttonPage;
}
@property (nonatomic,retain)NSArray * _activityList;
@end

@implementation IphoneHomeView
@synthesize delegate,_activityList, _weatherData, _userTitleLab;
- (void)dealloc
{
    self._weatherData = nil;
    self.delegate = nil;
    self._activityList = nil;
    self._userTitleLab = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        int bannerCount = 1;
        actImageCount = bannerCount;
        int buttonVCount = 2;
        int offy = self.frame.size.height > 480 ? 20 : 0;
        
        bannerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, offy, frame.size.width, 110)];
        bannerView.pagingEnabled = YES;
        bannerView.showsHorizontalScrollIndicator = NO;
        bannerView.showsVerticalScrollIndicator = NO;
        bannerView.contentSize = CGSizeMake(frame.size.width*bannerCount, 110);
        bannerView.delegate = self;
        [bannerView addSubview:[UIImageView ImageViewWithFrame:bannerView.bounds image:[UIImage imageNamed:@"adBackGroundImage.png"]]];
        
        
//        buttonView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 180, frame.size.width, frame.size.height-180)];
        
        buttonView = [[UIScrollView alloc] initWithFrame:self.bounds];
        buttonView.showsHorizontalScrollIndicator = NO;
        buttonView.showsVerticalScrollIndicator = NO;
        buttonView.contentSize = CGSizeMake(frame.size.width*buttonVCount, frame.size.height-110);
        [self addSubview:buttonView];
        [buttonView release];
        
        [buttonView addSubview:bannerView];
        [bannerView release];
        
        bannerPage = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 80 + offy, frame.size.width, 30)];
        bannerPage.numberOfPages = bannerCount;
//        bannerPage.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
        [buttonView addSubview:bannerPage];
        [bannerPage release];
        
//        buttonPage = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-30, frame.size.width, 30)];
//        buttonPage.numberOfPages = buttonVCount;
//        buttonPage.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
//        [self addSubview:buttonPage];
//        [buttonPage release];
    
        float startY = 110 - 5 + offy;
        float startX = 5;
        
        float ticketWidth = (buttonView.frame.size.width-20)*13/30 + 4.5;
        float ticketHeight = ticketWidth * 100 / 130;
       
        UIButton * ticketBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(startX, startY+10, ticketWidth, ticketHeight) font:nil color:[UIColor blackColor] target:self action:@selector(ticketBtnClick:)];
        [ticketBtn setBackgroundImage:[UIImage imageNamed:@"改版机票.png"] forState:UIControlStateNormal];
        
        UIButton * carBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(startX+ticketBtn.frame.size.width+5, startY+10, ticketWidth*8/13, ticketHeight) font:nil color:[UIColor blackColor] target:self action:@selector(carBtnClick:)];
//        [carBtn setBackgroundColor:[UIColor colorWithRed:0x09/255.0 green:0xD7/255.0 blue:0xF6/255.0 alpha:1]];
//        [carBtn setImage:[UIImage imageNamed:@"租车.png"] forState:UIControlStateNormal];
//        [carBtn setImageEdgeInsets:UIEdgeInsetsMake(37, 15, 36, 14)]; //51*27
        
        UIButton * didiBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(carBtn.frame.origin.x+carBtn.frame.size.width+5, startY+10, ticketWidth*8/13, ticketHeight) font:nil color:[UIColor blackColor] target:self action:@selector(didiBtnClick:)];
//        [didiBtn setBackgroundColor:[UIColor colorWithRed:0x1E/255.0 green:0xD2/255.0 blue:0xD4/255.0 alpha:1]];
//        [didiBtn setImage:[UIImage imageNamed:@"打车.png"] forState:UIControlStateNormal];
//        [didiBtn setImageEdgeInsets:UIEdgeInsetsMake(43, 16, 43, 16)]; //96 × 65
        
        UIButton * hotelBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(startX, ticketBtn.frame.origin.y+ticketBtn.frame.size.height+5, ticketWidth, ticketHeight*1.2) font:nil color:[UIColor blackColor] target:self action:@selector(hotelBtnClick:)];
//        [hotelBtn setBackgroundColor:[UIColor colorWithRed:0x0C/255.0 green:0xEB/255.0 blue:0xB4/255.0 alpha:1]];
//        [hotelBtn setImage:[UIImage imageNamed:@"酒店.png"] forState:UIControlStateNormal];
//        [hotelBtn setImageEdgeInsets:UIEdgeInsetsMake(45, 39, 45, 38)]; //53 × 30
        
        UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(hotelBtn.frame.origin.x+hotelBtn.frame.size.width+5, ticketBtn.frame.origin.y+ticketBtn.frame.size.height+5, ticketWidth*8/13, ticketHeight*1.2) font:nil color:[UIColor blackColor] target:self action:@selector(myBtnClick:)];
//        [myBtn setImage:[UIImage imageNamed:@"会员.png"] forState:UIControlStateNormal];
//        [myBtn setImageEdgeInsets:UIEdgeInsetsMake(47, 28, 46, 27)]; //50 × 53

        UIButton * activtyBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(myBtn.frame.origin.x+myBtn.frame.size.width+5, ticketBtn.frame.origin.y+ticketBtn.frame.size.height+5, ticketWidth*8/13, ticketHeight*1.2) font:nil color:[UIColor blackColor] target:self action:@selector(activtyBtnClick:)];
//        [activtyBtn setBackgroundColor:[UIColor colorWithRed:0x89/255.0 green:0xDD/255.0 blue:0x11/255.0 alpha:1]];
//        [activtyBtn setImage:[UIImage imageNamed:@"活动.png"] forState:UIControlStateNormal];
//        [activtyBtn setImageEdgeInsets:UIEdgeInsetsMake(44, 45, 43, 45)]; //80 × 65

        UIButton * trainBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(startX, hotelBtn.frame.origin.y+hotelBtn.frame.size.height+5, ticketWidth, ticketHeight*1.2) font:nil color:[UIColor blackColor] target:self action:@selector(trainBtnClick:)];
//        [trainBtn setBackgroundColor:[UIColor colorWithRed:0x09/255.0 green:0xBB/255.0 blue:0xF6/255.0 alpha:1]];
//        [trainBtn setImage:[UIImage imageNamed:@"火车票.png"] forState:UIControlStateNormal];
//        [trainBtn setImageEdgeInsets:UIEdgeInsetsMake(24, 15, 32, 23)]; //33*36
        
        UIButton * xingchengBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(startX+trainBtn.frame.size.width+5, hotelBtn.frame.origin.y+hotelBtn.frame.size.height+5, ticketWidth*165/130, ticketHeight*0.6 - 2.5) font:nil color:[UIColor blackColor] target:self action:@selector(xingchengBtnClick:)];
        
        UIButton * weatherBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(startX+trainBtn.frame.size.width+5, xingchengBtn.frame.origin.y+xingchengBtn.frame.size.height+5, ticketWidth*165/130, ticketHeight*0.6 - 2.5) font:nil color:[UIColor blackColor] target:self action:@selector(weatherBtnClick:)];
//        [weatherBtn setBackgroundColor:[UIColor colorWithRed:0xED/255.0 green:0xB7/255.0 blue:0x27/255.0 alpha:1]];
        
        
        UIButton * kefuBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(startX+trainBtn.frame.size.width+5, weatherBtn.frame.origin.y+weatherBtn.frame.size.height+5, ticketWidth*165/130, ticketHeight/2) font:nil color:[UIColor blackColor] target:self action:@selector(kefuBtnClick:)];
//        [kefuBtn setBackgroundColor:[UIColor colorWithRed:0x11/255.0 green:0xDD/255.0 blue:0x76/255.0 alpha:1]];
//        [kefuBtn setImage:[UIImage imageNamed:@"客服.png"] forState:UIControlStateNormal];
//        [kefuBtn setImageEdgeInsets:UIEdgeInsetsMake(16, 67, 15, 66)]; //63 × 60
        
        UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(startX, trainBtn.frame.origin.y+trainBtn.frame.size.height+5, ticketWidth, ticketHeight/2) font:nil color:[UIColor whiteColor] target:self action:@selector(moreBtnClick:)];
//        [bangzhuBtn setBackgroundColor:[UIColor colorWithRed:0xFF/255.0 green:0x81/255.0 blue:0x50/255.0 alpha:1]];
        
//        UIButton * guanyuBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(bangzhuBtn.frame.origin.x+bangzhuBtn.frame.size.width+5, trainBtn.frame.origin.y+trainBtn.frame.size.height+5, ticketWidth*8/13, ticketHeight/2) font:nil color:[UIColor whiteColor] target:self action:@selector(guanyuBtnClick:)];
//        [guanyuBtn setBackgroundColor:[UIColor colorWithRed:0xFF/255.0 green:0x81/255.0 blue:0x50/255.0 alpha:1]];
        
//        UIButton * yijianBtn = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(guanyuBtn.frame.origin.x+guanyuBtn.frame.size.width+5, trainBtn.frame.origin.y+trainBtn.frame.size.height+5, ticketWidth*8/13, ticketHeight/2) font:nil color:[UIColor whiteColor] target:self action:@selector(yijianBtnClick:)];
//        [yijianBtn setBackgroundColor:[UIColor colorWithRed:0xFF/255.0 green:0x81/255.0 blue:0x50/255.0 alpha:1]];
        
//        ticketBtn trainBtn carBtn hotelBtn myBtn didiBtn activtyBtn weatherBtn kefuBtn bangzhuBtn guanyuBtn yijianBtn
        
        [carBtn setBackgroundImage:[UIImage imageNamed:@"改版租车.png"] forState:UIControlStateNormal];
        [trainBtn setBackgroundImage:[UIImage imageNamed:@"改版火车票.png"] forState:UIControlStateNormal];
        [hotelBtn setBackgroundImage:[UIImage imageNamed:@"改版酒店.png"] forState:UIControlStateNormal];
        [myBtn setBackgroundImage:[UIImage imageNamed:@"改版会员.png"] forState:UIControlStateNormal];
        [didiBtn setBackgroundImage:[UIImage imageNamed:@"改版打车.png"] forState:UIControlStateNormal];
        [activtyBtn setBackgroundImage:[UIImage imageNamed:@"改版活动.png"] forState:UIControlStateNormal];
        [xingchengBtn setBackgroundImage:[UIImage imageNamed:@"出发行程.png"] forState:UIControlStateNormal];
        [weatherBtn setBackgroundImage:[UIImage imageNamed:@"改版天气.png"] forState:UIControlStateNormal];
        [kefuBtn setBackgroundImage:[UIImage imageNamed:@"改版客服.png"] forState:UIControlStateNormal];
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"改版更多.png"] forState:UIControlStateNormal];
//        [guanyuBtn setBackgroundImage:[UIImage imageNamed:@"改版关于.png"] forState:UIControlStateNormal];
//        [yijianBtn setBackgroundImage:[UIImage imageNamed:@"改版意见.png"] forState:UIControlStateNormal];
        
        self._userTitleLab = [UILabel labelWithTitle:@"登录" frame:CGRectMake(hotelBtn.frame.origin.x+hotelBtn.frame.size.width+5, ticketBtn.frame.origin.y+ticketBtn.frame.size.height+5, ticketWidth*8/13, ticketHeight*0.5) font:FontBlodSize30 color:[UIColor colorWithRed:0xFF/255.0 green:0x96/255.0 blue:0x50/255.0 alpha:1] alignment:NSTextAlignmentCenter];
        
        weatherCity = [UILabel labelWithTitle:@"北京" frame:CGRectMake(10+trainBtn.frame.size.width+5 + 17, xingchengBtn.frame.origin.y+xingchengBtn.frame.size.height+5 + 11, 65, 15) font:FontSize28 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
        weatherQuality = [UILabel labelWithTitle:@"未知天气" frame:CGRectMake(10+trainBtn.frame.size.width+5 + 16, xingchengBtn.frame.origin.y+xingchengBtn.frame.size.height+5 + 34, 80, 18) font:FontSize26 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
        weatherTemperature = [UILabel labelWithTitle:@"" frame:CGRectMake(10+trainBtn.frame.size.width+10 + 115, xingchengBtn.frame.origin.y+xingchengBtn.frame.size.height+5 + 15, 150, 30) font:FontSize30 color:FontColorFFFFFF alignment:NSTextAlignmentLeft];
        weatherImage = [UIImageView ImageViewWithFrame:CGRectMake(10+trainBtn.frame.size.width+20 + 70 , xingchengBtn.frame.origin.y+xingchengBtn.frame.size.height + (ticketHeight*0.6 - 32.5)/2-5, 35, 35)];
        
        UIImageView *locationView = [UIImageView ImageViewWithFrame:CGRectMake(10+trainBtn.frame.size.width+5 + 5, xingchengBtn.frame.origin.y+xingchengBtn.frame.size.height+5 + 11, 12, 16.5) image:[UIImage imageNamed:@"改版定位.png"]];
        
        [buttonView addSubview:ticketBtn];
        [buttonView addSubview:trainBtn];
        [buttonView addSubview:hotelBtn];
        [buttonView addSubview:carBtn];
        [buttonView addSubview:myBtn];
        [buttonView addSubview:didiBtn];
        [buttonView addSubview:activtyBtn];
        [buttonView addSubview:xingchengBtn];
        [buttonView addSubview:weatherBtn];
//        [buttonView addSubview:yijianBtn];
//        [buttonView addSubview:guanyuBtn];
        [buttonView addSubview:kefuBtn];
        [buttonView addSubview:moreBtn];
        [buttonView addSubview:self._userTitleLab];
        [buttonView addSubview:weatherCity];
        [buttonView addSubview:weatherQuality];
        [buttonView addSubview:weatherTemperature];
        [buttonView addSubview:weatherImage];
        [buttonView addSubview:locationView];
        buttonView.contentSize = CGSizeMake(frame.size.width, kefuBtn.frame.origin.y+kefuBtn.frame.size.height+10);

    }
    return self;
}
-(void) activityViewWithList:(NSArray *)list
{
    actImageCount = list.count > 4 ? 4 : list.count;
    self._activityList = list;
    for (int i=0; i<[list count]; i++) {
        if (i==4) {
            break;
        }
        ActivityItem * item = [list objectAtIndex:i];
        AsyncImageView * iamgeV = [[AsyncImageView alloc] initWithFrame:CGRectMake(i*bannerView.frame.size.width, 0, bannerView.frame.size.width, bannerView.frame.size.height)];
        iamgeV.defaultImage = 2;
        iamgeV.backgroundColor = [UIColor colorWithRed:arc4random()%155/256.0 green:arc4random()%155/256.0 blue:arc4random()%155/256.0 alpha:1];
        iamgeV.tag = i;
        iamgeV.urlString = item._imageUrl;
        [iamgeV addTarget:self action:@selector(showActivityDetail:) forControlEvents:UIControlEventTouchUpInside];
        [bannerView addSubview:iamgeV];
        [iamgeV release];
    }
    bannerPage.numberOfPages = [list count]>4?4:[list count];
    bannerView.contentSize = CGSizeMake(bannerView.frame.size.width*actImageCount, bannerView.frame.size.height-110);
    [self performSelector:@selector(moveItem:) withObject:bannerView afterDelay:3];
}
-(void) showActivityDetail:(AsyncImageView *)sender
{
    ActivityItem * item = [self._activityList objectAtIndex:sender.tag];
    if (self.delegate && [self.delegate respondsToSelector:@selector(showActivityDetail:)]) {
        [self.delegate performSelector:@selector(showActivityDetail:) withObject:item];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    bannerPage.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
//    int scrollX = scrollView.contentOffset.x;
//    int scrollWidth = scrollView.frame.size.width;
//    if (scrollX % scrollWidth != 0) {
//        scrollView.contentOffset = CGPointMake(0, 0);
//    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(moveItem:) withObject:scrollView afterDelay:3];
}

- (void)moveItem:(UIScrollView *)scrollView
{
    if (actImageCount <= 1) {
        return;
    }
    CGPoint point = scrollView.contentOffset;
    if (scrollView.contentOffset.x/scrollView.frame.size.width == actImageCount - 1) {
        point.x = 0;
    }
    else {
        point.x = point.x + scrollView.frame.size.width;
    }
    [bannerView setContentOffset:point animated:YES];
}

-(void)ticketBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ticketBtnClick:)]) {
        [self.delegate performSelector:@selector(ticketBtnClick:)];
    }
}
-(void)trainBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(trainBtnClick:)]) {
        [self.delegate performSelector:@selector(trainBtnClick:)];
    }
}
-(void)hotelBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelBtnClick:)]) {
        [self.delegate performSelector:@selector(hotelBtnClick:)];
    }
}
-(void)carBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(carBtnClick:)]) {
        [self.delegate performSelector:@selector(carBtnClick:)];
    }
}
-(void)myBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(myBtnClick:)]) {
        [self.delegate performSelector:@selector(myBtnClick:)];
    }
}
-(void)didiBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didiBtnClick:)]) {
        [self.delegate performSelector:@selector(didiBtnClick:)];
    }
}
-(void)activtyBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(activtyBtnClick:)]) {
        [self.delegate performSelector:@selector(activtyBtnClick:)];
    }
}
-(void)weatherBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(weatherBtnClick:)]) {
        [self.delegate performSelector:@selector(weatherBtnClick:)];
    }
}

- (void)xingchengBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(xingchengBtnClick:)]) {
        [self.delegate performSelector:@selector(xingchengBtnClick:)];
    }
}

-(void)kefuBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(kefuBtnClick:)]) {
        [self.delegate performSelector:@selector(kefuBtnClick:)];
    }
}
-(void)moreBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(moreBtnClick:)]) {
        [self.delegate performSelector:@selector(moreBtnClick:)];
    }
}

- (void)changeUserTpye:(int)tpye withPointView:(OrderPointView *)view
{
    switch (tpye) {
        case 0:
        {
            self._userTitleLab.text = @"注册";
            break;
        }
        case 1:
        {
            self._userTitleLab.text = @"登录";
            break;
        }
        case 2:
        {
            BOOL isAddPointView = FALSE;
            for (UIView * elem in [buttonView subviews]) {
                if ([elem isKindOfClass:[OrderPointView class]]) {
                    
                    isAddPointView = YES;
                    break;
                }
            }
            if (!isAddPointView) {
                [buttonView addSubview:view];
                int offy = self.frame.size.height > 480 ? 20 : 0;
                view.frame = CGRectMake(200, 260 + offy, 15, 15);
            }
            self._userTitleLab.text = @"会员";
            break;
        }
            
        default:
            self._userTitleLab.text = @"登录";
            break;
    }
}

- (void)changeCityWeather:(QueryWeatherInfo *)queryData withCityName:(NSString *)cityName
{
    AirportWeatherInfo *selectWeatherData = [queryData.weatherInfoList objectAtIndex:0];
    weatherCity.text = cityName;
    weatherQuality.text = selectWeatherData.weather;
    weatherTemperature.text = selectWeatherData.topTemperature;
    weatherImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:selectWeatherData.imageUrl]]];
}

- (void)showPointView:(UIView *)view
{
    
}

- (void)pauseActImage
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)playActImage
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    bannerView.contentOffset = CGPointMake(0, 0);
    [self performSelector:@selector(moveItem:) withObject:bannerView afterDelay:3];
}
@end
