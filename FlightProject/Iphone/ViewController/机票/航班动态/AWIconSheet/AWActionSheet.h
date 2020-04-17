//
//  AWActionSheet.h
//  FlightProject
//
//  Created by xiemengyue on 13-7-5.
//
//

#import <UIKit/UIKit.h>
@class AWActionSheetCell;

@protocol AWActionSheetDelegate <NSObject>

- (int)numberOfItemsInActionSheet;
- (AWActionSheetCell*)cellForActionAtIndex:(NSInteger)index;
- (void)DidTapOnItemAtIndex:(NSInteger)index;

@end

@interface AWActionSheet : UIActionSheet
-(id)initwithIconSheetDelegate:(id<AWActionSheetDelegate>)delegate ItemCount:(int)cout;
@end


@interface AWActionSheetCell : UIView
@property (nonatomic,retain)UIImageView* iconView;
@property (nonatomic,retain)UILabel*     titleLabel;
@property (nonatomic,assign)int          index;
@end