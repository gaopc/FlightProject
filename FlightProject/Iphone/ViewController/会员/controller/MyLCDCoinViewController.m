//
//  MyLCDCoinViewController.m
//  FlightProject
//
//  Created by lidong  cui on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyLCDCoinViewController.h"
#import "MyLCDCoinCell.h"
#import "MyLCDCoinDataResponse.h"
@interface MyLCDCoinViewController ()

@end

@implementation MyLCDCoinViewController

@synthesize l_tableView = _l_tableView;
@synthesize myLcdDataArray = _myLcdDataArray;
@synthesize myLCDCoinInfo;
- (void)loadView{
	
	[super loadView];
	
	long origin_y = 8.0f;
	
	availableLcdCurrency = [NSString stringWithFormat:@"%d",[self.myLCDCoinInfo._availableLcdCurrency intValue]];



    	lcdCurrency = [NSString stringWithFormat:@"%d",[self.myLCDCoinInfo._lcdCurrency intValue]];

	
	useLcdCurrency = [NSString stringWithFormat:@"%d",[self.myLCDCoinInfo._useLcdCurrency intValue]];

	
	notReturnLcdCurrency = [NSString stringWithFormat:@"%d",[self.myLCDCoinInfo._notReturnLcdCurrency intValue]];

	
	UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(10.0f,origin_y, ViewWidth-20.0f, 85.0f)];
	topView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:topView];
	
	UIImageView *topBg = [UIImageView ImageViewWithFrame:CGRectMake(0.0f, 0.0f, topView.frame.size.width, topView.frame.size.height) image:[UIImage imageNamed:@"DollarTopBg.png"]];
	[topView addSubview: topBg];
	
	UISubLabel *titleTopLabel1 = [UISubLabel labelWithTitle:@"可用畅达币数量: " frame:CGRectMake(2.0f, 8.0f, 120.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentCenter];
	titleTopLabel1.textColor = FontColor333333;
	[topView addSubview:titleTopLabel1];
	
	
	UISubLabel *titleTopLabel5 = [UISubLabel labelWithTitle:@"畅达币规则" frame:CGRectMake((ViewWidth/2 - 70)/2 + ViewWidth/2 + 10, 11.0f, 70.0f, 22.0f) font:FontSize26 alignment:NSTextAlignmentCenter];
	titleTopLabel5.textColor = FontColorFF8813;
	[topView addSubview:titleTopLabel5];
	
	explainButton = [UIButton buttonWithType:UIButtonTypeCustom tag:20 title:@"" frame:CGRectMake((ViewWidth/2 - 80)/2 + ViewWidth/2 + 10, 8.0f, 80.0f, 25.0f) backImage:nil target:self action:@selector(explain:)];
	[topView addSubview:explainButton];
	
	
	UISubLabel *titleTopLabel2 = [UISubLabel labelWithTitle:@"累计获取畅达币" frame:CGRectMake(10.0f, 36.0f, 100.0f, 22.0f) font:FontSize26 alignment:NSTextAlignmentCenter];
	titleTopLabel2.textColor = FontColor333333;
	[topView addSubview:titleTopLabel2];
	
        currencyLabel =  [UISubLabel labelWithTitle:lcdCurrency frame:CGRectMake(30.0f, 62.0f, 60.0f, 18.0f) font:FontSize30 alignment:NSTextAlignmentCenter];
	currencyLabel.textColor = FontColor333333;
	
	
	[topView addSubview:currencyLabel];
	
	
	UISubLabel *titleTopLabel3 = [UISubLabel labelWithTitle:@"已使用畅达币" frame:CGRectMake((ViewWidth - 80)/2, 36.0f, 80.0f, 22.0f) font:FontSize26 alignment:NSTextAlignmentCenter];
	titleTopLabel3.textColor = FontColor333333;
	[topView addSubview:titleTopLabel3];
	
	useCurrencyLabel =  [UISubLabel labelWithTitle:useLcdCurrency frame:CGRectMake((ViewWidth - 60)/2, 62.0f, 60.0f, 18.0f) font:FontSize30 alignment:NSTextAlignmentCenter];
	useCurrencyLabel.textColor = FontColor333333;
	[topView addSubview:useCurrencyLabel];
	
	UISubLabel *titleTopLabel4 = [UISubLabel labelWithTitle:@"未返还畅达币" frame:CGRectMake((ViewWidth/2 - 70)/2 + ViewWidth/2 + 10, 36.0f, 80.0f, 22.0f) font:FontSize26 alignment:NSTextAlignmentCenter];
	titleTopLabel4.textColor = FontColor333333;
	[topView addSubview:titleTopLabel4];
	
	notReturnCurrencyLabel =  [UISubLabel labelWithTitle:notReturnLcdCurrency frame:CGRectMake((ViewWidth/2 - 60)/2 + ViewWidth/2 + 10, 62.0f, 60.0f, 18.0f) font:FontSize30 alignment:NSTextAlignmentCenter];
	notReturnCurrencyLabel.textColor = FontColor333333;
	[topView addSubview:notReturnCurrencyLabel];
	
        UIImageView *numberImageView = [UIImageView ImageViewWithFrame:CGRectMake((ViewWidth - 82)/2, 0.0f, 82.0f, 36.0f)];
	[numberImageView setImage:[UIImage imageNamed:@"DollarNumberBg.png"]];
	[topView addSubview:numberImageView];
	
        UIImageView *iconImageView = [UIImageView ImageViewWithFrame:CGRectMake((ViewWidth - 82)/2 + 82 - 25, 10.5f, 20.0f, 20.0f)];
	[iconImageView setImage:[UIImage imageNamed:@"DollarIcon.png"]];
	[topView addSubview:iconImageView];
	
	
	origin_y += topView.frame.size.height +15.0f;
	[topView release];
	
	availableLabel = [UISubLabel labelWithTitle:availableLcdCurrency frame:CGRectMake(2.0f, 8.0f, 55.0f, 25.0f) font:FontBlodSize38 alignment:NSTextAlignmentCenter];
	availableLabel.textColor = FontColorFFFFFF;
	[numberImageView addSubview:availableLabel];
	
	UIImageView *tableImageView = [UIImageView ImageViewWithFrame:CGRectMake(10.0f, origin_y, ViewWidth-20.0f, ViewHeight-160.0f)];
	[tableImageView setImage:[UIImage imageNamed:@"DollarTableViewBg.png"]];
	[self.view addSubview:tableImageView];
	
	
	
	UISubLabel *titleTopLabel6 = [UISubLabel labelWithTitle:@"畅达币交易纪录" frame:CGRectMake(10.0f, 2.0f, 120.0f, 25.0f) font:FontSize30 alignment:NSTextAlignmentCenter];
	titleTopLabel6.textColor = FontColor454545;
	[tableImageView addSubview:titleTopLabel6];
	
	
    UIView *tableTitleView = [[[UIView alloc]initWithFrame:CGRectMake(10.0f, 138.0f, ViewWidth-20.0f, 20.0f)]autorelease];
	tableTitleView.backgroundColor = [UIColor clearColor];
	
	
	UISubLabel *titleLabel1 = [UISubLabel labelWithTitle:@"交易类型" frame:CGRectMake(0, 1.0f, (ViewWidth-20.0f)/4, 20.0f) font:FontSize22 alignment:NSTextAlignmentCenter];
	titleLabel1.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel1];
	
	UISubLabel *titleLabel2 = [UISubLabel labelWithTitle:@"交易内容" frame:CGRectMake((ViewWidth-20.0f)/4, 1.0f, (ViewWidth-20.0f)/4, 20.0f) font:FontSize22 alignment:NSTextAlignmentCenter];
	titleLabel2.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel2];
	
	UISubLabel *titleLabel3 = [UISubLabel labelWithTitle:@"交易数量" frame:CGRectMake((ViewWidth-20.0f)/2, 1.0f, (ViewWidth-20.0f)/4, 20.0f) font:FontSize22 alignment:NSTextAlignmentCenter];
	titleLabel3.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel3];
	
	UISubLabel *titleLabel4 = [UISubLabel labelWithTitle:@"交易日期" frame:CGRectMake((ViewWidth-20.0f)*3/4, 1.0f, (ViewWidth-20.0f)/4, 20.0f) font:FontSize22 alignment:NSTextAlignmentCenter];
	titleLabel4.textColor = FontColor454545;
	[tableTitleView addSubview:titleLabel4];
	
	UIImageView *lineImageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TicketQueryDottedLine.png"]] autorelease];
	lineImageView.frame= CGRectMake(10.0f, 20.0f, tableTitleView.frame.size.width-20, 1.0f);
	[tableTitleView addSubview:lineImageView];
	
	[self.view addSubview:tableTitleView];
	
	_l_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f ,160.0f,ViewWidth,ViewHeight-220.0f) style:UITableViewStylePlain];
	self.l_tableView .backgroundColor = [UIColor clearColor];
	self.l_tableView .dataSource = self;
	self.l_tableView .delegate = self;
	self.l_tableView.separatorColor = [UIColor clearColor];
	[self.view addSubview:self.l_tableView];
	
	
	
	
}


- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */
- (void)dealloc
{
	//[_l_tableView release];
	//[_myLcdDataArray release];
	self.l_tableView = nil;
	self.myLCDCoinInfo = nil;
	[super dealloc];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title=@"我的畅达币";
	
}


- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



- (void)explain:(id)sender 
{
	[UIAlertView alertViewWithMessage:@"（1）1个畅达币=1元人民币，畅达币不能提现、转让；\n（2）为保证您方便快捷使用畅达币，我们在机票预订过程中提供实时的抵扣服务；\n（3）注册或推荐好友获赠的畅达币在未曾购买机票并起飞过，不得抵用退费手续费票款。\n（4）畅达币永久有效。                        ":@"畅达币规则"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
	// Return the number of rows in the section.
	return [self.myLcdDataArray count] ; 
	//return 15;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 53.0f;
	
}


- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	
	static NSString *cellIndentifierOnline=@"MyLCDCoinCell";
	MyLCDCoinCell *myLCDCoinCell=(MyLCDCoinCell *)[self.l_tableView dequeueReusableCellWithIdentifier:cellIndentifierOnline];
	if (myLCDCoinCell == nil){
		myLCDCoinCell=[[[MyLCDCoinCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil] autorelease];
		myLCDCoinCell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	MyLCDCoinDetailInfo *myLCDCoinDetailInfo = nil;
	myLCDCoinDetailInfo = (MyLCDCoinDetailInfo *)[self.myLcdDataArray objectAtIndex:indexPath.row];
	
        (indexPath.row % 2) ? (myLCDCoinCell.lcdBgView.image = [UIImage imageNamed:@"DollarCellBg.png"]) : (myLCDCoinCell.lcdBgView.image = nil);
	
	myLCDCoinCell.typeLabel.text = myLCDCoinDetailInfo._type;
	myLCDCoinCell.content.text = myLCDCoinDetailInfo._content;
	//incomeOrExpenses//表示收入
	if ([myLCDCoinDetailInfo._incomeOrExpenses intValue]==0) {
		myLCDCoinCell.amountFlagLabel.text = @"+";
		myLCDCoinCell.amountFlagLabel.textColor = [UIColor greenColor];
	}else {
		myLCDCoinCell.amountFlagLabel.text = @"-";
		myLCDCoinCell.amountFlagLabel.textColor = FontColorD50505;
	}
	
	myLCDCoinCell.amountLabel.text = [NSString stringWithFormat:@"%d",[myLCDCoinDetailInfo._amount intValue]];

	
	myLCDCoinCell.dateLabel.text = myLCDCoinDetailInfo._date;
	
	return myLCDCoinCell;
}

@end
