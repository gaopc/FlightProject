//
//  CustomScorllView.m
//  FlightProject
//
//  Created by longcd on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomScorllView.h"
#import "QueryFlightTicket.h"
#import "MyExtend.h"

@implementation CustomTableView

@synthesize dataArray,selectedIndex,delegate,dataSource,selectedStr;
-(void)dealloc
{
    self.dataArray = nil;
    self.delegate = nil;
    self.dataSource = nil;
    self.selectedStr = nil;
    [super dealloc];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        rowsCount = 0;
//        rowsHeight = 40.0f;
        rowsHeight = frame.size.height / 3;
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    NSInteger labelTag = (int)(scrollV.contentOffset.y / rowsHeight ) +1;
    for (UISubLabel * label in [scrollView subviews]) {
        if ([label isKindOfClass:[UISubLabel class]]) {
            if (label.tag == labelTag) {
                label.textColor = FontColor000000;
            }
            else {
                label.textColor = FontColor909090;
            }
        }
    }
    self.selectedIndex = labelTag - 1;
    if (self.selectedIndex == -1 || self.selectedIndex >= [self.dataArray count]) {
        return;
    }
    else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(customTableView:didSelectIndex:)]) {
            [self.delegate performSelector:@selector(customTableView:didSelectIndex:) withObject:self withObject:[NSString stringWithFormat:@"%d",self.selectedIndex]];
        }
    }
    //    [(CustomScorllView *)self.delegate setSelectedRow:labelTag-1];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollV.contentOffset.y >= scrollV.contentSize.height-rowsHeight) {
        scrollV.contentOffset = CGPointMake(0, scrollV.contentSize.height-rowsHeight);
    }
    else if (scrollV.contentOffset.y <= -rowsHeight*2) {
        scrollV.contentOffset = CGPointMake(0, -rowsHeight*2);
    }
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5f];
    
    if (((int)scrollV.contentOffset.y % (int)rowsHeight ) >= (rowsHeight/2)) {
        scrollV.contentOffset = CGPointMake(0, ((int)(scrollV.contentOffset.y / rowsHeight +1)) * rowsHeight);
    }
    else {
        scrollV.contentOffset = CGPointMake(0, ((int)(scrollV.contentOffset.y / rowsHeight)) * rowsHeight);
    }
//    [UIView commitAnimations];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollV.contentOffset.y >= scrollV.contentSize.height-rowsHeight) {
        scrollV.contentOffset = CGPointMake(0, scrollV.contentSize.height-rowsHeight);
    }
    else if (scrollV.contentOffset.y <= -rowsHeight*2) {
        scrollV.contentOffset = CGPointMake(0, -rowsHeight*2);
    }
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5f];
    
    if (((int)scrollV.contentOffset.y % (int)rowsHeight ) >= (rowsHeight/2)) {
        scrollV.contentOffset = CGPointMake(0, ((int)(scrollV.contentOffset.y / rowsHeight +1)) * rowsHeight);
    }
    else {
        scrollV.contentOffset = CGPointMake(0, ((int)(scrollV.contentOffset.y / rowsHeight)) * rowsHeight);
    }
//    [UIView commitAnimations];
}
-(void)setDelegate:(id<CustomTableViewDelegate>)_delegate
{
    if (delegate != _delegate) {
        [delegate release];
        delegate = [_delegate retain];
        [self heightForRow];
    }
}
-(void)setDataSource:(id<CustomTableViewDataSource>)_dataSource
{
    if (dataSource != _dataSource) {
        [dataSource release];
        dataSource = [_dataSource retain];
        [self numberOfRows];
    }
}
-(void)heightForRow
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForRow:)]) {
        rowsHeight = [self.delegate heightForRow:self];
        rowsHeight = self.bounds.size.height / 3;
    }
}
-(void)numberOfRows
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRows:)]) {
        rowsCount = [self.dataArray count]; //[self.dataSource numberOfRows:self];
    }
    centerView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - rowsHeight) / 2.0f, self.frame.size.width, rowsHeight)];
    centerView.backgroundColor = [UIColor clearColor];
    [self addSubview:centerView];
    [centerView release];
    
    scrollV = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.delegate = self;
    [self addSubview:scrollV];
    [scrollV release];
    scrollV.contentSize = CGSizeMake(self.frame.size.width, rowsHeight*(rowsCount+2));
    UISubLabel * selectLabel = nil;
    for (int i=0; i<rowsCount+2; i++) {
        NSString * titleForRow = nil;
        if ((i ==0) || (i==rowsCount +1)) {
            titleForRow = @"";
        }
        else if (self.dataSource && [self.dataSource respondsToSelector:@selector(customTableView:titleForHeaderInRow:)]) {
            titleForRow = [self.dataSource customTableView:self titleForHeaderInRow:i-1];
        }
        UISubLabel * label = [UISubLabel labelWithTitle:titleForRow frame:CGRectMake(0, i*rowsHeight, self.frame.size.width, rowsHeight) font:FontSize32 color:i==1?FontColor333333: FontColor707070 alignment:NSTextAlignmentCenter];
        label.tag = i;
        [scrollV addSubview:label];
        if ([self.selectedStr isKindOfClass:[NSString class]]) {
            if ([self.selectedStr isEqualToString:titleForRow]) {
                self.selectedIndex = i-1;
                selectLabel = label;
            }
        }
        else{
            if (i==1) {
                self.selectedIndex = 0;
                selectLabel = label;
            }
        }
    }
    if (selectLabel) {
	    CGPoint bottomOffset = CGPointMake(0, selectLabel.frame.origin.y-rowsHeight);
	    [scrollV setContentOffset:bottomOffset animated:NO];
    }else {
	    CGPoint bottomOffset = CGPointMake(0, rowsHeight*(rowsCount-1));
	    [scrollV setContentOffset:bottomOffset animated:NO];
    }
}

- (void)scrollToRow:(int)row
{
    scrollV.contentOffset = CGPointMake(0, row * rowsHeight);
}

@end

@interface CustomTableViewCell : UITableViewCell 
@property (nonatomic,retain) UIImageView * _imageV;
@property (nonatomic,retain) UISubLabel * _label;
@end

@implementation CustomTableViewCell
@synthesize _label,_imageV;
-(void)dealloc
{
    self._imageV = nil;
    self._label = nil;
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self._imageV = [UIImageView ImageViewWithFrame:CGRectMake(10, 12, 20, 20)];        
        self._label = [UISubLabel labelWithTitle:nil frame:CGRectMake(40, 0, 200, self.frame.size.height) font:[UIFont systemFontOfSize:16] alignment:NSTextAlignmentLeft];
        [self addSubview:self._imageV];
        [self addSubview:self._label];
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

@end

@implementation CustomScorllView
@synthesize dataArray,selectedRow,delegate;
-(void)dealloc
{
    self.dataArray = nil;
    self.delegate = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UIView *)initWithLeftTitle:(NSString *) leftTitle subLeftTitle:(NSString *) subLeftTitle centerTitle:(NSString *)centerTitle subCenterTitles:(NSArray *)subCenterTitles rightTitle:(NSString *)rightTitle subRightTitle:(NSString *)subRightTitle  frame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]){
        
        UIView * aView = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width - 283)/2, (frame.size.height - 247)/2, 283, 247)];
        aView.center = self.center;
        [self addSubview:aView];
        [aView release];
        
        [aView addSubview:[UIImageView ImageViewWithFrame:aView.bounds image:[UIImage imageNamed:@"TicketQueryConnectBackGround.png"]]];

        [aView addSubview:[UISubLabel labelWithTitle:leftTitle frame:CGRectMake(10, 80, 70, 20) font:FontSize20 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        [aView addSubview:[UISubLabel labelWithTitle:subLeftTitle frame:CGRectMake(10, 98, 70, 20) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        [aView addSubview:[UISubLabel labelWithTitle:rightTitle frame:CGRectMake(200, 80, 70, 20) font:FontSize20 color:FontColor909090 alignment:NSTextAlignmentCenter]];
        [aView addSubview: [UISubLabel labelWithTitle:subRightTitle frame:CGRectMake(200, 98, 70, 20) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        self.dataArray = subCenterTitles;
       
        [aView addSubview: [UISubLabel labelWithTitle:@"没有直达航线,请选择中转城市" frame:CGRectMake(0 , 15, aView.bounds.size.width , 20) font:FontSize32 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        [aView addSubview: [UISubLabel labelWithTitle:@"中转航线只能购买单程票" frame:CGRectMake(0 , 35, aView.bounds.size.width , 20) font:FontSize20 color:FontColor333333 alignment:NSTextAlignmentCenter]];
        
        table = [[CustomTableView alloc] initWithFrame:CGRectMake((283-118)/2, 60, 118, 114)];
        table.dataArray = self.dataArray;
        table.selectedStr = [self.dataArray objectAtIndex:0];
        table.delegate = self;
        table.dataSource = self;
        
        [aView addSubview:table];
        [table release];
        
        [aView addSubview:[UIImageView ImageViewWithFrame:CGRectMake(33, 247-60, 218, 36) image:[UIImage imageNamed:@"DoubleButtonBg.png"]]];
        [aView addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake(36, 247-60 +3, 101, 30) backImage:[UIImage imageNamed:@"TicketQueryConnectCancel.png"] target:self action:@selector(noButton)]];
        [aView addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(146, 247-60+3, 101, 30)  backImage:[UIImage imageNamed:@"TicketQueryConnectSure.png"] target:self action:@selector(yesButton)]];
    }
    return self;
}
-(UIView *)initWithTitle:(NSString *) title  centerTitles:(NSArray *)centerTitles  frame:(CGRect)frame  selectStr:(NSString *)str
{
    if (self == [super initWithFrame:frame]){
        
        UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0, (frame.size.height - frame.size.width*(438.0f/566.0f))/2, frame.size.width, 210)];
        aView.center = self.center;
        [self addSubview:aView];
        [aView release];
        
        [aView addSubview:[UIImageView ImageViewWithFrame:aView.bounds image:[UIImage imageNamed:@"carDateTimeView.png"]]];
        
        
        [aView addSubview:[UIImageView ImageViewWithFrame:CGRectMake((aView.frame.size.width-212-6)/2, 157, 212+6, 36) image:[UIImage imageNamed:@"DoubleButtonBg.png"]]];
        
        [aView addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:1 title:nil frame:CGRectMake((aView.frame.size.width-212)/2,  160, 101, 30) backImage:[UIImage imageNamed:@"TicketQueryConnectCancel.png"] target:self action:@selector(noButton)]];
        [aView addSubview:[UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake((aView.frame.size.width-212)/2+101+10,160, 101, 30)  backImage:[UIImage imageNamed:@"TicketQueryConnectSure.png"] target:self action:@selector(yesButton)]];
        
        self.dataArray = centerTitles;
       
        [aView addSubview: [UISubLabel labelWithTitle:title frame:CGRectMake(0 , 11, aView.bounds.size.width , 20) font:FontSize26 color:FontColor909090 alignment:NSTextAlignmentCenter]];


        table = [[CustomTableView alloc] initWithFrame:CGRectMake(70, 34, aView.frame.size.width-140, 108)];
        table.selectedStr = str;
        table.dataArray = self.dataArray;
        table.delegate = self;
        table.dataSource = self;
        [aView addSubview:table];
        [table release];
    }
    return self;

}
-(float)heightForRow:(CustomTableView *)tableView
{
    return 30.0f;
}
-(NSInteger)numberOfRows:(CustomTableView *)tableView
{
    return [tableView.dataArray count];
}
-(NSString *)customTableView:(CustomTableView *)tableView titleForHeaderInRow:(NSInteger)row
{
    id instance = [tableView.dataArray objectAtIndex:row];
    if ([instance isKindOfClass:[TransitCity class]]) {
        TransitCity * city = [tableView.dataArray objectAtIndex:row];
        return city._name;
    }
    else  if ([instance isKindOfClass:[NSString class]]){
        return  [tableView.dataArray objectAtIndex:row];
    }
    return nil;
}

-(void) yesButton
{
    self.selectedRow = table.selectedIndex;
    if (self.delegate && [self.delegate respondsToSelector:@selector(sureButtonClickWithIndex:)]) {
        [self.delegate performSelector:@selector(sureButtonClickWithIndex:) withObject:self];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sureButtonClick:)]) {
        id  instance = [self.dataArray objectAtIndex:self.selectedRow];
        [self.delegate performSelector:@selector(sureButtonClick:) withObject:instance];
    }
}
-(void) noButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClick)]) {
        [self.delegate performSelector:@selector(cancelButtonClick)];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
