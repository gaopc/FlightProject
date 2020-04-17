//
//  RoomRevealPicViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoomRevealPicViewController.h"

@interface RoomRevealPicViewController ()
- (void) addPage:(int) i;
@end

@implementation RoomRevealPicViewController
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize picUrlArray,hotelInfo,currentPage;

- (void)loadView{
	
	[super loadView];
	
	_scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, ViewWidth, ViewHeight - 160.0f)];
	
	self.scrollView.pagingEnabled = YES;
	self.scrollView.clipsToBounds=NO;
	self.scrollView.showsVerticalScrollIndicator = NO;
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.delegate=self;
	self.scrollView.contentSize = CGSizeZero;
	
	[self.view addSubview:self.scrollView];
	
	_pageControl = [[UIPageControl alloc] init];
	
	UIImageView *bottomButtonImgView=[UIImageView ImageViewWithFrame:CGRectMake(0, ViewHeight-100.0f, ViewWidth, 50.0f)];
	bottomButtonImgView.image=[UIImage imageNamed:@"PassBottomButtonBg.png"];
	[self.view addSubview:bottomButtonImgView];
	
	leftArrowsImageView=[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-232, ViewHeight - 80.0f, 22.0f, 22.0f)];
	leftArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomLeft1.png"];
	[self.view addSubview:leftArrowsImageView];
	
	leftArrowsButton = [UIButton buttonWithType:UIButtonTypeCustom tag:200 title:@"" frame:CGRectMake(ViewWidth-232, ViewHeight - 80.0f, 45.0f, 45.0f) backImage:nil target:self action:@selector(arrows:)];
	[self.view addSubview:leftArrowsButton];
	
	showNumberLabel =  [UISubLabel labelWithTitle:@"" frame:CGRectMake(ViewWidth-215, ViewHeight - 80.0f, 120.0f, 22.0f) font:FontSize30 color:FontColor454545 alignment:NSTextAlignmentCenter];
	[self.view addSubview:showNumberLabel];
	
	rightArrowsImageView=[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth-100, ViewHeight - 80.0f, 22.0f, 22.0f)];
	rightArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomRight1.png"];
	[self.view addSubview:rightArrowsImageView];
	
	rightArrowsButton = [UIButton buttonWithType:UIButtonTypeCustom tag:201 title:@"" frame:CGRectMake(ViewWidth-100, ViewHeight - 80.0f, 45.0f, 45.0f) backImage:nil target:self action:@selector(arrows:)];
	[self.view addSubview:rightArrowsButton];
	
	
	
}
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = self.hotelInfo._hotelName;
	
	// Do any additional setup after loading the view.
	if ([self.picUrlArray count] <=0) {
		
		return;
	}
	int pagesum = [self.picUrlArray count];
	self.pageControl.numberOfPages = 0;
	//加载视图
	for (int i = 0; i < pagesum; i++) [self addPage:i];
	
	self.pageControl.currentPage = self.currentPage;
	
	self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * self.currentPage, 0.0f);
	[self.pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
	
	showNumberLabel.text = [NSString stringWithFormat:@"%d / %d",(self.pageControl.currentPage+1),[self.picUrlArray count]];
	if ((self.pageControl.currentPage+1)==1) {
		
		leftArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomLeft2.png"];
	}else {
		leftArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomLeft1.png"];
	}
	
	if ((self.pageControl.currentPage+1)==[self.picUrlArray count]) {
		rightArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomRight2.png"];
	}else {
		rightArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomRight1.png"];
	}
	
}

//滑动对页面进行操作
- (void) addPage:(int) i
{
	self.pageControl.numberOfPages = self.pageControl.numberOfPages + 1;
	self.pageControl.currentPage =self.pageControl.numberOfPages - 1;
	self.scrollView.contentSize = CGSizeMake(self.pageControl.numberOfPages * ViewWidth, self.scrollView.frame.size.height);
	//异步加载图片
	hotelPicUrl =  (HotelPicUrl *)[self.picUrlArray objectAtIndex:i];
	AsyncImageView *hotelBigImageView =[[AsyncImageView alloc]initWithFrame:CGRectMake(self.pageControl.currentPage * ViewWidth, 0.0f,  ViewWidth, self.scrollView.frame.size.height)];
	hotelBigImageView.autoImage = YES;
	[hotelBigImageView setUrlString:hotelPicUrl._picUrls];
	[self.scrollView addSubview:hotelBigImageView];
	[hotelBigImageView release];
	
	
	
}


- (void) pageTurn: (UIPageControl *) aPageControl
{
	int whichPage = aPageControl.currentPage;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * whichPage, 0.0f);
	[UIView commitAnimations];
}


-(void)arrows:(id)sender
{
	int whichPage = self.pageControl.currentPage;
	
	UIButton *button = (UIButton*)sender;
	
	switch (button.tag) {
		case 200:
			if (whichPage>0) {
				whichPage = whichPage-1;
			}
			break;
		case 201:
			if (whichPage<([self.picUrlArray count]-1)) {
				whichPage = whichPage+1;
			}
			break;
			
		default:
			break;
	}
	
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * whichPage, 0.0f);
	[UIView commitAnimations];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

- (void) dealloc {
	
	self.currentPage = 0;
        
	if (self.picUrlArray) {
		self.picUrlArray = nil;
	}
	
	self.hotelInfo = nil;
	self.scrollView = nil;
	self.pageControl = nil;
	[_scrollView release];
	[_pageControl release];
	[super dealloc];
	
}

//滑动促发事件
- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
{
	CGPoint offset = aScrollView.contentOffset;
	self.pageControl.currentPage = offset.x / self.view.frame.size.width;
	showNumberLabel.text = [NSString stringWithFormat:@"%d / %d",(self.pageControl.currentPage+1),[self.picUrlArray count]];
	
	if ((self.pageControl.currentPage+1)==1) {
		
		leftArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomLeft2.png"];
	}else {
		leftArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomLeft1.png"];
	}
	
	if ((self.pageControl.currentPage+1)==[self.picUrlArray count]) {
		rightArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomRight2.png"];
	}else {
		rightArrowsImageView.image=[UIImage imageNamed:@"TicketListBottomRight1.png"];
	}
	
}



@end
