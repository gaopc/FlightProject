//
//  AWActionSheet.m
//  FlightProject
//
//  Created by xiemengyue on 13-7-5.
//
//

#import "AWActionSheet.h"
#import <QuartzCore/QuartzCore.h>
#define itemPerPage 12

@interface AWActionSheet()<UIScrollViewDelegate>
@property (nonatomic, retain)UIScrollView* scrollView;
@property (nonatomic, retain)UIPageControl* pageControl;
@property (nonatomic, retain)NSMutableArray* items;
@property (nonatomic, assign)id<AWActionSheetDelegate> IconDelegate;
@end
@implementation AWActionSheet
@synthesize scrollView;
@synthesize pageControl;
@synthesize items;
@synthesize IconDelegate;
-(void)dealloc
{
    IconDelegate= nil;
    [scrollView release];
    [pageControl release];
    [items release];
    [super dealloc];
}


-(id)initwithIconSheetDelegate:(id<AWActionSheetDelegate>)delegate ItemCount:(int)cout
{
    int rowCount = 3;
    if (cout <=4) {
        rowCount = 1;
    } else if (cout <=8) {
        rowCount = 2;
    }
    NSString* titleBlank = @"\n\n\n\n\n\n";
    for (int i = 1 ; i<rowCount; i++) {
        titleBlank = [NSString stringWithFormat:@"%@%@",titleBlank,@"\n\n\n\n\n\n"];
    }
    self = [super initWithTitle:titleBlank
                       delegate:nil
              cancelButtonTitle:@"取消"
         destructiveButtonTitle:nil
              otherButtonTitles:nil];
    if (self) {
        [self setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        IconDelegate = delegate;
        self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, ViewWidth, 105*rowCount)] autorelease];
        [scrollView setPagingEnabled:YES];
        [scrollView setBackgroundColor:[UIColor clearColor]];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setDelegate:self];
        [scrollView setScrollEnabled:YES];
        [scrollView setBounces:NO];
        
        [self addSubview:scrollView];
        
        if (cout > 12) {
            self.pageControl = [[[UIPageControl alloc] initWithFrame:CGRectMake(0, 105*rowCount, 0, 20)] autorelease];
            [pageControl setNumberOfPages:0];
            [pageControl setCurrentPage:0];
            [pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
            [self addSubview:pageControl];
        }
        
        
        self.items = [[[NSMutableArray alloc] initWithCapacity:cout] autorelease];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)showInView:(UIView *)view
{
    [super showInView:view];
    [self reloadData];
}

- (void)reloadData
{
    for (AWActionSheetCell* cell in items) {
        [cell removeFromSuperview];
        [items removeObject:cell];
    }

    int count = [IconDelegate numberOfItemsInActionSheet];
    
    if (count <= 0) {
        return;
    }
    
    int rowCount = 3;
    
    if (count <= 4) {
        [self setTitle:@"\n\n\n\n\n\n"];
        [scrollView setFrame:CGRectMake(0, 10, ViewWidth, 105)];
        rowCount = 1;
    } else if (count <= 8) {
        [self setTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n"];
        [scrollView setFrame:CGRectMake(0, 10, ViewWidth, 210)];
        rowCount = 2;
    }
    [scrollView setContentSize:CGSizeMake(ViewWidth*(count/itemPerPage+1), scrollView.frame.size.height)];
    [pageControl setNumberOfPages:count/itemPerPage+1];
    [pageControl setCurrentPage:0];
    
    
    for (int i = 0; i< count; i++) {
        AWActionSheetCell* cell = [IconDelegate cellForActionAtIndex:i];
        int PageNo = i/itemPerPage;
        int index  = i%itemPerPage;
        
        if (itemPerPage == 12) {
            
            int row = index/4;
            int column = index%4;
            
            
            float centerY = (1+row*2)*self.scrollView.frame.size.height/(2*rowCount);
            float centerX = (1+column*2)*self.scrollView.frame.size.width/8;
            
            
            [cell setCenter:CGPointMake(centerX+ViewWidth*PageNo, centerY)];
            [self.scrollView addSubview:cell];
            
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForItem:)];
            [cell addGestureRecognizer:tap];
            [tap release];

        }
        
        [items addObject:cell];
    }
    
}

- (void)actionForItem:(UITapGestureRecognizer*)recongizer
{
    AWActionSheetCell* cell = (AWActionSheetCell*)[recongizer view];
    [IconDelegate DidTapOnItemAtIndex:cell.index];
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    [scrollView setContentOffset:CGPointMake(ViewWidth * page, 0)];
}
#pragma mark -
#pragma scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    int page = scrollView.contentOffset.x /ViewWidth;
    pageControl.currentPage = page;
}


@end

#pragma mark - AWActionSheetCell
@interface AWActionSheetCell ()
@end
@implementation AWActionSheetCell
@synthesize iconView;
@synthesize titleLabel;

- (void)dealloc
{
    [iconView release];
    [titleLabel release];
    
    [super dealloc];
}

-(id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 70, 70)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.iconView = [[[UIImageView alloc] initWithFrame:CGRectMake(6.5, 0, 57, 57)] autorelease];
        [iconView setBackgroundColor:[UIColor clearColor]];
        [[iconView layer] setCornerRadius:8.0f];
        [[iconView layer] setMasksToBounds:YES];
        
        [self addSubview:iconView];
        
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 63, 70, 13)] autorelease];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        if(IOS7_OR_LATER)//7之后
        {
            [titleLabel setTextColor:[UIColor blackColor]];
            [titleLabel setShadowColor:[UIColor whiteColor]];
        }
        else
        {
            [titleLabel setTextColor:[UIColor whiteColor]];
            [titleLabel setShadowColor:[UIColor blackColor]];
        }
 
        [titleLabel setShadowOffset:CGSizeMake(0, 0.5)];
        [titleLabel setText:@""];
        [self addSubview:titleLabel];
    }
    return self;
}

@end


