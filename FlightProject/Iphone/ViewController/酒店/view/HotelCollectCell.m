//
//  HotelCollectCell.m
//  FlightProject
//
//  Created by z1 on 13-6-26.
//
//

#import "HotelCollectCell.h"



@implementation HotelCollectCell

@synthesize hotelName,rating,districtName;
@synthesize markValueView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
	  

	    [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(8, 3, 304, 100) image:[UIImage imageNamed:@"航班动态向下拉伸.png"]]];
	    [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(8, 98, 304, 13) image:[UIImage imageNamed:@"航班动态下部阴影.png"]]];
	    [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(32, 67, 180.0f, 0.5) image:[UIImage imageNamed:@"航班动态半段虚线.png"]]];
	
	    self.hotelName = [UISubLabel labelWithTitle:@"" frame:CGRectMake(35.0f, 10.0f, 180.0f, 30.0f) font:FontBlodSize32 color:FontColor333333 alignment:NSTextAlignmentLeft];
	    [self addSubview:self.hotelName];
	    
	    self.rating = [UISubLabel labelWithTitle:@"" frame:CGRectMake(35.0f, 75.0f, 70.0f, 28.0f) font:FontSize28 color:FontColor454545 alignment:NSTextAlignmentLeft];
	    
	    [self addSubview:self.rating];
	    
	    self.districtName = [UISubLabel labelWithTitle:@"" frame:CGRectMake(140.0f, 75.0f, 70.0f, 28.0f) font:FontSize28 color:FontColor454545 alignment:NSTextAlignmentRight];
	    
	    [self addSubview:self.districtName];
	    
	    UIImageView *iconView=[UIImageView ImageViewWithFrame:CGRectMake(288.0f, 45.0f, 8.0f, 13.0f)];
	    iconView.image=[UIImage imageNamed:@"CellArrow.png"];
	    [self addSubview:iconView];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawStarCodeView:(int) markValue{
	
	if (self.markValueView)
		[self.markValueView removeFromSuperview];
	
	self.markValueView= [[UIView alloc] initWithFrame:CGRectMake(35.0f, 45, 75, 18 )];
	
	for (int i=0; i<5; i++) {
		
		if (markValue>=1) {
			
		        UIImageView *starGreenImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*14.5, 0, 13, 13)];
			starGreenImg.image = [UIImage imageNamed:@"Star_Golden.png"]; //选中
			[self.markValueView addSubview:starGreenImg];
			[starGreenImg release];
			markValue--;
			continue;
			
	        }else {
			UIImageView *starWhiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*14.5, 0, 13, 13)];
			starWhiteImg.image = [UIImage imageNamed:@"Star_Gray.png"];
			[self.markValueView addSubview:starWhiteImg];
			[starWhiteImg release];
			
		}
	}
	[self addSubview:self.markValueView];
	[self.markValueView release];
	
}


-(void)drawDiamondCodeView:(int) markValue{
	
	if (self.markValueView)
		[self.markValueView removeFromSuperview];
	
	self.markValueView= [[UIView alloc] initWithFrame:CGRectMake(35.0f, 45, 75, 18 )];
	
	for (int i=0; i<5; i++) {
		
		if (markValue>=1) {
			
		        UIImageView *starGreenImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*13.5, 0, 12, 11)];
			starGreenImg.image = [UIImage imageNamed:@"Diamond_Golden.png"]; //选中
			[self.markValueView addSubview:starGreenImg];
			[starGreenImg release];
			markValue--;
			continue;
			
	        }else {
			UIImageView *starWhiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*13.5, 0, 12, 11)];
			starWhiteImg.image = [UIImage imageNamed:@"Diamond_Gray.png"];
			[self.markValueView addSubview:starWhiteImg];
			[starWhiteImg release];
			
		}
	}
	[self addSubview:self.markValueView];
	[self.markValueView release];
	
}


- (void) dealloc {
	
	self.hotelName = nil;
	self.rating = nil;
	self.districtName = nil;
	self.markValueView = nil;
	[super dealloc];
	
}

@end


