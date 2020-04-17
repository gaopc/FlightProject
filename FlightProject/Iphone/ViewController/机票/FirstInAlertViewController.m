//
//  FirstInAlertViewController.m
//  FlightProject
//
//  Created by green kevin on 12-9-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstInAlertViewController.h"
#define MOVE_MIN_DISTANCE 50

@interface FirstInAlertViewController ()
{
	int currentPageIndex;
}
  

- (void) initFirstInAlertView;
- (UIImageView*) getImgViewByIndex:(int)index;

@end

@implementation FirstInAlertViewController

@synthesize itemsPageArray = _itemsPageArray;
@synthesize scrollView = _scrollView;
@synthesize delegate;
- (id)init {
	self = [super init];
	if (self) {
		
		[self initFirstInAlertView];
		// Initialization code here.
	}
	
	return self;
}

- (id)initWithItem:(ETFirstInAlertItem *)item {
	self = [super init];
	if (self) {
		
		[self initFirstInAlertView];
		// Initialization code here.
	}
	
	return self;
}

- (id)initWithArray:(NSArray *)itemArray {
	self = [super init];
	if (self) {
		
		if (_itemsPageArray) {
			[_itemsPageArray release];
		}
		
		_itemsPageArray = [[NSArray alloc] initWithArray:itemArray];
		NSLog(@"_itemsPageArray0= %d",[_itemsPageArray count]);
		[self initFirstInAlertView];
		// Initialization code here.
	}
	
	return self;
}


- (void) initFirstInAlertView {
	
	currentPageIndex = 0;
}

-(void) loadView {
	[super loadView];
	
	if (_scrollView == nil) {
		_scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
		
		[_scrollView setDelegate:self];
		[self.view addSubview:_scrollView];
		
		_scrollView.scrollEnabled = YES;
		_scrollView.pagingEnabled = YES;
		_scrollView.showsHorizontalScrollIndicator=NO; //水平滚动条隐藏
		_scrollView.showsVerticalScrollIndicator=NO;//垂直滚动条隐藏
		//_scrollView.scrollsToTop = YES;
		[_scrollView setBackgroundColor:[UIColor colorWithRed:53/255.0f green:57/255.0 blue:65/255.0f alpha:1]];
	}
	
	[_scrollView setContentSize:CGSizeMake(320*_itemsPageArray.count,460)];
	
	for (int i=0; i<_itemsPageArray.count; i++) {
		UIImageView* imgView = [self getImgViewByIndex:i];
		[imgView setFrame:CGRectMake(320*i, 0, 320, 460)];
		[_scrollView addSubview:imgView];        
	}
}

+ (BOOL) isFirstShow {
	//__FIRSTINALERT__   
	NSString* tempStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"__FIRSTINALERT__"];
	if ([tempStr isEqualToString:@"__FIRSTINALERT__"]) {
		return NO;
	}
	
	return YES;
}


- (void) showFinished {
	[[NSUserDefaults standardUserDefaults] setObject:@"__FIRSTINALERT__" forKey:@"__FIRSTINALERT__"];    
	
	if ([delegate respondsToSelector:@selector(finishedDispaly)]) {
		[delegate performSelector:@selector(finishedDispaly)withObject:self];
	}
	
	[self.navigationController popViewControllerAnimated:NO];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if ([scrollView isKindOfClass:[UITableView class]]) {
		return;
	}
	
	int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
	
	currentPageIndex = index;
	//index为当前页码
	
	if (currentPageIndex == [_itemsPageArray count]-1) {
		
		int offset = ((int)scrollView.contentOffset.x)%((int)scrollView.frame.size.width);
		NSString* tempStr = [NSString stringWithFormat:@"__%d__", offset];
		
		NSLog(tempStr,nil);
		
		if (((int)scrollView.contentOffset.x)%((int)scrollView.frame.size.width) > 100) {
			[self showFinished];
		}
	}
}




- (UIImageView*) getImgViewByIndex:(int)index {
	if ([_itemsPageArray count] <= index) {
		return nil;
	}
	
	item = [_itemsPageArray objectAtIndex:index];
	NSLog(@"imgName= %@",item.imgName);
	//    if (nil == currentItem) {
	//        return nil;
	//    }
	
	if ([item view] == nil) {
		
		if ([item imgName] == nil) {
			return nil;
		}
		
		item.view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:item.imgName]];
		//        [self.view addSubview:currentItem.view];
	}
	
	return item.view;
}


- (void) pageBack {
	if (currentPageIndex == 0) {
		return;
	}
	
	currentPageIndex--;
	//    [self disPlayCurrentView];
}


-(void) dealloc {
	
	[_itemsPageArray release];
	[_scrollView release];
	//    [currentImgView release];
	//    [tmpImageView release];
	//    [imgView1 release];
	//    [imgView2 release];
	
	[super dealloc];
}

@end
