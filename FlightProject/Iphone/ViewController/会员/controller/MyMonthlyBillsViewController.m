//
//  MyMonthlyBillsViewController.m
//  FlightProject
//
//  Created by xiemengyue on 13-5-2.
//
//

#import "MyMonthlyBillsViewController.h"
#import "MyMonthlyBills.h"
#import "InterfaceClass.h"

@implementation MonthBillTitleCell
@synthesize menuButton,monthLabel,amountLabel,lcdCoinLabel,cangLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
        self.backgroundColor = [UIColor redColor];
        
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, ViewWidth - 16, 56) image:[UIImage imageNamed:@"bills2.png"]]];
        
		self.menuButton = [UIButton customButtonTitle:nil image:[UIImage imageNamed:@"bills4.png"] frame:CGRectMake(15, 15, 18, 18) target:nil action:nil];
        self.monthLabel = [UISubLabel labelWithTitle:@"4月" frame:CGRectMake(25, 10, 60, 30) font:FontBlodSize36 color:FontColor707070 alignment:NSTextAlignmentCenter];
        self.amountLabel = [UISubLabel labelWithTitle:@"￥1000" frame:CGRectMake((ViewWidth - 80)/2 - 20, 10, 80, 30) font:FontBlodSize36 color:FontColor707070 alignment:NSTextAlignmentCenter];
        self.lcdCoinLabel = [UISubLabel labelWithTitle:@"5000" frame:CGRectMake(ViewWidth - 140, 10, 60, 30) font:FontBlodSize36 color:FontColorFF8813 alignment:NSTextAlignmentRight];
        self.cangLabel = [UISubLabel labelWithTitle:@"(机票)" frame:CGRectMake(ViewWidth - 68, 9, 50, 30) font:FontSize26 color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
        [self addSubview:self.menuButton];
        [self addSubview:self.monthLabel];
        [self addSubview:self.amountLabel];
        [self addSubview:self.lcdCoinLabel];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(ViewWidth - 78, 18, 15, 15) image:[UIImage imageNamed:@"DollarIcon.png"]]];
        [self addSubview:self.cangLabel];
	}
    self.backgroundColor = [UIColor clearColor];
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

- (void)dealloc
{
    self.menuButton = nil;
    self.monthLabel = nil;
    self.amountLabel = nil;
    self.lcdCoinLabel = nil;
	[super dealloc];
}

@end

@implementation MonthBillDetailCell
@synthesize flightLabel,hotelLabel,carLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(3, 0, 298, 85) image:[UIImage imageNamed:@"bills3.png"]]];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(20, 12, 15, 17) image:[UIImage imageNamed:@"bills6.png"]]];
		[self addSubview:[UISubLabel labelWithTitle:@"机票" frame:CGRectMake(40, 10, 30, 20) font:FontSize30 color:FontColor707070 alignment:NSTextAlignmentCenter]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake((ViewWidth -80)/2 - 5, 13, 12, 15) image:[UIImage imageNamed:@"bills7.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"酒店" frame:CGRectMake((ViewWidth -80)/2 - 10, 10, 80, 20) font:FontSize30 color:FontColor707070 alignment:NSTextAlignmentCenter]];
         [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(210, 15, 19, 10) image:[UIImage imageNamed:@"bills8.png"]]];
        [self addSubview:[UISubLabel labelWithTitle:@"租车" frame:CGRectMake(ViewWidth - 120, 10, 100, 20) font:FontSize30 color:FontColor707070 alignment:NSTextAlignmentCenter]];
        self.flightLabel = [UISubLabel labelWithTitle:@"￥800" frame:CGRectMake(5, 47, 100, 30) font:FontSize30 color:FontColor707070 alignment:NSTextAlignmentCenter];
        self.hotelLabel = [UISubLabel labelWithTitle:@"￥100" frame:CGRectMake((ViewWidth -80)/2 - 30, 47, 100, 30) font:FontSize30 color:FontColor707070 alignment:NSTextAlignmentCenter];
        self.carLabel = [UISubLabel labelWithTitle:@"￥200" frame:CGRectMake(ViewWidth - 140, 47, 100, 30) font:FontSize30 color:FontColor707070 alignment:NSTextAlignmentCenter];
        [self addSubview:self.flightLabel];
        [self addSubview:self.hotelLabel];
        [self addSubview:self.carLabel];
	}
    self.backgroundColor = [UIColor clearColor];
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

- (void)dealloc
{
    self.flightLabel = nil;
    self.hotelLabel = nil;
    self.carLabel = nil;
	[super dealloc];
}

@end


@interface MyMonthlyBillsViewController ()

@end

@implementation MyMonthlyBillsViewController
@synthesize monthlyBills;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}
- (void)loadView{
	[super loadView];
    self.title =@"账单";
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, ViewWidth - 16, ViewHeight-60) style:UITableViewStylePlain] ;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myTableView];
    [myTableView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    zhankai = NO;
    ASIFormDataRequest * theRequest = [InterfaceClass getBill:[UserInfo sharedUserInfo].userID];
	[[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onMyMonthlyBillsdResult:) Delegate:self needUserType:Member];

}

-(void)onMyMonthlyBillsdResult:(NSDictionary*)dic
{
    self.monthlyBills = [MyMonthlyBills GetMyMonthlyBills:dic];
    MonthlyBill *amonthlyBill = [monthlyBills.monthsArray objectAtIndex:0];
    int all = [amonthlyBill.flight intValue]+[amonthlyBill.hotel intValue]+[amonthlyBill.car intValue];
    if(all > 0)
    {
        zhankai = YES;
        selectSection = 1;
    }
    [myTableView reloadData];
}
-(void)clickMenu:(UIButton*)button
{
    NSLog(@"clickMenu--%d",button.tag);

    if(zhankai && selectSection == button.tag)
    {
        zhankai = NO;
    }
    else
    {
        MonthlyBill *amonthlyBill = [monthlyBills.monthsArray objectAtIndex:button.tag-1];
        int all = [amonthlyBill.flight intValue]+[amonthlyBill.hotel intValue]+[amonthlyBill.car intValue];
        if(all == 0)
            return;
        
        zhankai = YES;
        selectSection = button.tag;
    }
    [myTableView reloadData];

}
#pragma mark -
#pragma mark UITableViewDataSourceDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.monthlyBills.monthsArray count]+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (selectSection == section && zhankai)
        return 2;
    else
        return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if(indexPath.section == 0)
        {
            return 55;
        }
        if(selectSection == indexPath.section && zhankai)  return 50;
        else  return 60;
    }
    else {
        return 90.0f;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if(indexPath.section == 0)
        {
            NSString * cellIdentifier = [NSString stringWithFormat:@"cellIdentifier"];
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
                [cell addSubview:[UIImageView ImageViewWithFrame:CGRectMake(0, 0, myTableView.frame.size.width, 55) image:[UIImage imageNamed:@"bills1.png"]]];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.backgroundColor = [UIColor clearColor];

            return cell;
        }
        NSString * monthBillTitleCellIdentifier = [NSString stringWithFormat:@"Identifier%d", indexPath.section];
        MonthBillTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:monthBillTitleCellIdentifier ];
        if (cell == nil) {
            cell = [[[MonthBillTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:monthBillTitleCellIdentifier] autorelease];
            cell.menuButton.tag = indexPath.section;
            [cell.menuButton addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
        }
        if(selectSection == indexPath.section && zhankai)
        {
            cell.cangLabel.hidden = NO;
            [cell.menuButton setImage:[UIImage imageNamed:@"bills5.png"] forState:UIControlStateNormal];
        }
        else
        {
            cell.cangLabel.hidden = YES;
            [cell.menuButton setImage:[UIImage imageNamed:@"bills4.png"] forState:UIControlStateNormal];
        }
        MonthlyBill *amonthlyBill = [monthlyBills.monthsArray objectAtIndex:indexPath.section-1];
        cell.monthLabel.text = amonthlyBill.month;
        int all = [amonthlyBill.flight intValue]+[amonthlyBill.hotel intValue]+[amonthlyBill.car intValue];
        cell.amountLabel.text = [NSString stringWithFormat:@"￥%d",all];
        cell.lcdCoinLabel.text = [NSString stringWithFormat:@"%@",amonthlyBill.lcdCurrency];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        static NSString * monthBillDetailCellIdentifier = @"monthBillDetailCellIdentifier";
        MonthBillDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:monthBillDetailCellIdentifier];
        if (cell == nil) {
            cell = [[[MonthBillDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:monthBillDetailCellIdentifier] autorelease];
        }
         MonthlyBill *amonthlyBill = [monthlyBills.monthsArray objectAtIndex:indexPath.section-1];
        cell.flightLabel.text = [NSString stringWithFormat:@"￥%@",amonthlyBill.flight];
        cell.hotelLabel.text = [NSString stringWithFormat:@"￥%@",amonthlyBill.hotel];
        cell.carLabel.text = [NSString stringWithFormat:@"￥%@",amonthlyBill.car];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"clickMenu--%d",indexPath.section);

    if(indexPath.row == 0)
    {
        if(indexPath.section == 0)
        {
            return;
        }
        
        if(zhankai && selectSection == indexPath.section)
        {
            zhankai = NO;
        }
        else
        {
            MonthlyBill *amonthlyBill = [monthlyBills.monthsArray objectAtIndex:indexPath.section-1];
            int all = [amonthlyBill.flight intValue]+[amonthlyBill.hotel intValue]+[amonthlyBill.car intValue];
            if(all == 0)
                return;
           
            zhankai = YES;
            selectSection = indexPath.section;
        }
        [myTableView reloadData];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
