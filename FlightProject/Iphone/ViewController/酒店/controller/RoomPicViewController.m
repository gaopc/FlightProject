//
//  RoomPicViewController.m
//  FlightProject
//
//  Created by green kevin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoomPicViewController.h"
#import "HotelQueryDataResponse.h"
#import "RoomRevealPicViewController.h"
@interface RoomPicViewController ()

@end

@implementation RoomPicViewController
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize picUrlArray,hotelInfo;
- (void)loadView{
	
	[super loadView];
	
	if (self.picUrlArray.count<=0) {
		
	[self.view addSubview:[UISubLabel labelWithTitle:@"该酒店暂无图片" frame:CGRectMake(60, 160, ViewWidth-120, 30) font:FontBlodSize32 color:FontColor636363 alignment:NSTextAlignmentCenter]];
		return;
	}
	
	_scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(5.0f, 10.0f, ViewWidth-5.0f, ViewHeight - 120.0f)];
	self.scrollView.pagingEnabled = YES;
	self.scrollView.clipsToBounds=NO;
	self.scrollView.showsVerticalScrollIndicator = NO;
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.delegate=self;
	self.scrollView.contentSize = CGSizeZero;
	[self.view addSubview:self.scrollView];
	
	_pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(60.0f, ViewHeight - 130.0f, ViewWidth-120, 20.0f)];
	self.pageControl.hidesForSinglePage=YES;  
	[self.view addSubview:self.pageControl];
	self.pageControl.currentPage = 0;
	
	int page = self.picUrlArray.count%9 == 0 ? self.picUrlArray.count/9 : (int)(self.picUrlArray.count/9 + 1.0);
	self.pageControl.numberOfPages = page;
	self.scrollView.contentSize = CGSizeMake(page * ViewWidth, self.scrollView.frame.size.height);
	int scrollPage = 0; 
	HotelPicUrl *hotelPicUrl = nil;
	int w = 0;
	int h = 0;
	
	for (int i= 0; i< self.picUrlArray.count; i++) {
		hotelPicUrl = (HotelPicUrl *)[self.picUrlArray objectAtIndex:i];
		
		if (i!=0 && i%9==0) {scrollPage++; h = -1;}
		
		if (i!=0 && i%3==0) { w = 0; h++; }else{ if(i!=0) w++;}
		
		picImg = [UIImageView ImageViewWithFrame:CGRectMake(((ViewWidth/3 * w)+4.0f)+(scrollPage*(ViewWidth-5.0f)), (100.0f * h)+10.0f, 90.0f, 90.0f)];
		picImg.image=[UIImage imageNamed:@"HotelGridDefaultImg.png"];
		[self.scrollView addSubview:picImg];
		
		
                hotelImageView =[[AsyncImageView alloc]initWithFrame:CGRectMake(((ViewWidth/3 * w)+7.0f)+(scrollPage*(ViewWidth-5.0f)), (100.0f * h)+12.0f, 84.0f, 85.0f)];
	        hotelImageView.defaultImage = 1;
		[self.scrollView addSubview:hotelImageView];
		
		picButton  = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" frame:CGRectMake(((ViewWidth/3 * w)+4.0f)+(scrollPage*ViewWidth-5.0f), (100.0f * h)+10.0f, 90.0f, 90.0f) backImage:nil target:self action:@selector(reveal:)];
		picButton.tag = 100+i;
		[self.scrollView addSubview:picButton];
		
		[hotelImageView setUrlString:hotelPicUrl._smallPicUrls];
	}

}

//滑动促发事件
- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
{
	CGPoint offset = aScrollView.contentOffset;
	self.pageControl.currentPage = (int)(offset.x/ 315.0f);
}
-(void)reveal:(UIButton *)sender
{
	UIButton *button = (UIButton*)sender;
	int page = (button.tag-100);
	
	RoomRevealPicViewController *revealPicVC = [[RoomRevealPicViewController alloc]init];
	revealPicVC.picUrlArray = self.picUrlArray;
	revealPicVC.currentPage = page;
	revealPicVC.hotelInfo = self.hotelInfo;
	[NavigationController pushViewController:revealPicVC animated:YES];
	[revealPicVC release];
	
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

- (void) dealloc {
	
     	if (self.picUrlArray) {
		self.picUrlArray = nil;
	}
	[_pageControl release];
	[_scrollView release];
	self.hotelInfo = nil;
	self.pageControl = nil;
	self.scrollView = nil;
	[super dealloc];
	
}



@end
