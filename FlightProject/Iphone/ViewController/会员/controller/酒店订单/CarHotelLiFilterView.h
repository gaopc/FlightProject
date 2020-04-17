//
//  CarHotelLiFilterView.h
//  FlightProject
//
//  Created by 小月 on 13-1-17.
//
//

#import <UIKit/UIKit.h>

@interface FilterButtonView : UIView
@property (nonatomic,retain)UIButton *selectButton;
@property (nonatomic,retain)UISubLabel *aLabel;
@property (nonatomic,assign)BOOL isSelecded;

- (id)initWithFrame:(CGRect)frame LabelText:(NSString*)text imageName:(NSString*)imageName tag:(NSInteger)tag;
@end


@interface CarHotelLiFilterView : UIView
@property (nonatomic,assign)id delegate;
@property (nonatomic,retain)UIButton *filterDownButton;
@property (nonatomic,retain)NSArray *statusArray;
@property (nonatomic,retain)UIImageView *bgImage;
-(void)setButtons;
@end
