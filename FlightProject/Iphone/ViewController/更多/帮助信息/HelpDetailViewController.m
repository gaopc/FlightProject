//
//  HelpDetailViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HelpDetailViewController.h"

@interface HelpDetailViewController ()

@end

@implementation HelpDetailViewController
@synthesize  imageNames;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc
{
    self.imageNames = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title =[self.imageNames objectAtIndex:0];
	// Do any additional setup after loading the view.
    UIScrollView *pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44-45)];
    pageScroll.delegate = self;
    pageScroll.contentSize = CGSizeMake(ViewWidth*[imageNames count], ViewHeight-44-45);
    pageScroll.pagingEnabled = YES;
    for(int i = 0;i<[imageNames count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth*i, 0, ViewWidth, ViewHeight-44-45)];
        [imageView setImage:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
        [pageScroll addSubview:imageView];
        [imageView release];
    }
    
    [self.view addSubview:pageScroll];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
    int page = floor((scrollView.contentOffset.x - ViewWidth / 3) / ViewWidth) + 1;
    if(page < 0)
    {
        page = 0;
    }
    if(page > 4)
    {
        page = 4;
    }
    self.title = [imageNames objectAtIndex:page];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
