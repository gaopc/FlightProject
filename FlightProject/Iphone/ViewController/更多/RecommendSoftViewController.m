//
//  RecommendSoftViewController.m
//  FlightProject
//
//  Created by gaopengcheng on 13-6-28.
//
//

#import "RecommendSoftViewController.h"

@interface RecommendSoftViewController ()

@end



@implementation RecommendSoftView
@synthesize _iconView, _softContent, _softTitle, _cellImgView;

-(void)dealloc
{
    self._iconView = nil;
    self._softContent = nil;
    self._softTitle = nil;
    self._cellImgView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self._cellImgView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 45.0f)];
        
        AsyncImageView *asyncImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(20, 10, 32, 32)];
        self._iconView = asyncImageView;
        [asyncImageView release];
        
        self._softTitle = [UISubLabel labelWithTitle:@"掌上航旅" frame:CGRectMake(65, 5, 230, 20) font:FontBlodSize32 alignment:NSTextAlignmentLeft];
        
        self._softContent = [UISubLabel labelWithTitle:@"一款用来旅游的软件一款用来旅游的软件一款用来旅游的软件" frame:CGRectMake(65, 25, 230, 20) font:FontSize30 color:FontColor696969 alignment:NSTextAlignmentLeft];
        
        [self addSubview:self._cellImgView];
        [self addSubview:self._iconView];
        [self addSubview:self._softTitle];
        [self addSubview:self._softContent];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
@end




@implementation RecommendSoftViewController
@synthesize _listArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"软件推荐";
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, ViewWidth, ViewHeight - 44 - 5) style:UITableViewStylePlain];
    myTable.backgroundView = nil;
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.separatorColor = [UIColor clearColor];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    
    [self.view addSubview:myTable];
}
#pragma mark - Table view dataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self._listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendSoftDataResponse *softData = [self._listArray objectAtIndex:indexPath.row];
    
    NSString * identifier = @"identifier";
    RecommendSoftView * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[RecommendSoftView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }

    if (indexPath.row == 0) {
        cell._cellImgView.image = [UIImage imageNamed:@"HotelFilterCellBg1.png"];
    }
    else if (indexPath.row == [self._listArray count] -1) {
        cell._cellImgView.image = [UIImage imageNamed:@"HotelFilterCellBg3.png"];
    }
    else {
        cell._cellImgView.image = [UIImage imageNamed:@"HotelFilterCellBg2.png"];
    }
    
    
    cell._softTitle.text = softData._softName;
    cell._softContent.text = softData._softDesc;
    cell._iconView.urlString = softData._softImgUrl;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath frame:CGRectMake(11, 0, 298, 49)];
    
    RecommendSoftDataResponse *softData = [self._listArray objectAtIndex:indexPath.row];
    
    ASIFormDataRequest * theRequest = [InterfaceClass softDownLoad:softData._softId];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onSoftNumResult:) Delegate:self needUserType:Default];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:softData._softDownUrl]];
}

- (void)onSoftNumResult:(NSDictionary *)dic
{
    NSLog(@"下载记数");
}
@end
