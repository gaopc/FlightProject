//
//  AdvertisementView.m
//  FlightProject
//
//  Created by gaopengcheng on 13-7-1.
//
//

#import "AdvertisementView.h"

@implementation AdvertisementView
@synthesize _imgUrl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        AsyncImageView *asyncImageView = [[AsyncImageView alloc] initWithFrame:self.bounds];
        self.imgView = asyncImageView;
        
        [self addSubview:self.imgView];
        [asyncImageView release];
    }
    return self;
}

- (void)set_imgUrl:(NSString *)url
{
    self.imgView.urlString = url;
}

@end
