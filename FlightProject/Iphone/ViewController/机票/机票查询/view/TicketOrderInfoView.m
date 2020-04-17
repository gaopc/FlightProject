//
//  TicketOrderInfoView.m
//  FlightProject
//
//  Created by longcd on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TicketOrderInfoView.h"
@implementation FlightSingleInfo

@synthesize _toCity,_toTime,_flightNo,_fromCity,_fromDate,_fromTime,_companyImageV,_flightCabinName;
@synthesize _flightTypeImage;
-(void)dealloc
{
    self._toCity = nil;
    self._toTime = nil;
    self._flightNo = nil;
    self._fromCity = nil;
    self._fromDate = nil;
    self._fromTime = nil;
    self._companyImageV = nil;
    self._flightCabinName = nil;
    self._flightTypeImage = nil;
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self._fromCity = [UISubLabel labelWithTitle:@"北京" frame:CGRectMake(20, 0, 100, 20) font:FontSize18 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._toCity = [UISubLabel labelWithTitle:@"上海" frame:CGRectMake(75, 0, 100, 20) font:FontSize18 color:FontColor000000 alignment:NSTextAlignmentLeft];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(52, 10, 15, 15) image:[UIImage imageNamed:@"OrderInfoJiantou.png"]]];
        self._fromTime = [UISubLabel labelWithTitle:@"08:09" frame:CGRectMake(20, 20, 100, 20) font:FontSize18 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        self._toTime = [UISubLabel labelWithTitle:@"15:13" frame:CGRectMake(75, 20, 100, 20) font:FontSize18 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        
        self._fromDate = [UISubLabel labelWithTitle:@"2021-12-23" frame:CGRectMake(0, 20, ViewWidth, 20) font:FontSize18 color:FontColor000000 alignment:NSTextAlignmentCenter];
        self._companyImageV = [UIImageView ImageViewWithFrame:CGRectMake(220, 2, 15, 15) image:[UIImage imageNamed:@"MU.png"]];
        self._flightNo = [UISubLabel labelWithTitle:@"东航MU5162" frame:CGRectMake(0, 0, 310, 20) font:FontSize18 color:FontColor000000 alignment:NSTextAlignmentRight];
        self._flightCabinName = [UISubLabel labelWithTitle:@"钻石豪华头等舱(F)" frame:CGRectMake(0, 20, 310, 20) font:FontSize18 color:FontColor909090 alignment:NSTextAlignmentRight];
        
        self._flightTypeImage = [UIImageView ImageViewWithFrame:CGRectMake(136, 4, 36, 11) image:[UIImage imageNamed:@"去程.png"]];
        
        [self addSubview:self._fromCity];
        [self addSubview:self._toCity];
        [self addSubview:self._fromTime];
        [self addSubview:self._toTime];
        [self addSubview:self._fromDate];
        [self addSubview:self._companyImageV];
        [self addSubview:self._flightNo];
        [self addSubview:self._flightCabinName];
        
        [self addSubview:self._flightTypeImage];
        
    }
    return self;
}
@end

@implementation FlightHardInfo

@synthesize _toCity,_toTime,_flightNo,_fromCity,_fromDate,_fromTime,_planType,_ruleLabel,_toterminal,_fromterminal,_companyImageV,_flightCabinName;
@synthesize _flightTypeImage;
-(void)dealloc
{
    self._toCity = nil;
    self._toTime = nil;
    self._flightNo = nil;
    self._fromCity = nil;
    self._fromDate = nil;
    self._fromTime = nil;
    self._planType = nil;
    self._ruleLabel = nil;
    self._toterminal = nil;
    self._fromterminal = nil;
    self._companyImageV = nil;
    self._flightCabinName = nil;
    
    self._flightTypeImage = nil;
    
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self._planType = [UISubLabel labelWithTitle:@"中型机 空客330" frame:CGRectMake(20, 0, 100, 20) font:FontSize18 color:FontColor909090 alignment:NSTextAlignmentLeft];
        self._fromDate = [UISubLabel labelWithTitle:@"2012-08-16" frame:CGRectMake(0, 68, ViewWidth, 20) font:FontSize18 color:FontColor000000 alignment:NSTextAlignmentCenter];
        self._companyImageV = [UIImageView ImageViewWithFrame:CGRectMake(220, 2, 15, 15) image:[UIImage imageNamed:@"MU.png"]];

        self._flightNo = [UISubLabel labelWithTitle:@"东航MU5162" frame:CGRectMake(0, 0, 310, 20) font:FontSize18 color:FontColor000000 alignment:NSTextAlignmentRight];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(15, 20, 120, 43) image:[UIImage imageNamed:@"OrderInfoHeadBack.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(145, 25, 30, 30) image:[UIImage imageNamed:@"OrderInfoJiantou.png"]]];
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(185, 20, 120, 43)image:[UIImage imageNamed:@"OrderInfoHeadBack.png"]]];
        
        self._fromCity = [UISubLabel labelWithTitle:@"乌鲁木齐" frame:CGRectMake(20, 17, 100, 30) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._fromterminal = [UISubLabel labelWithTitle:@"乌鲁木齐机场t2" frame:CGRectMake(20, 40, 150, 20) font:FontSize18 color:FontColor909090 alignment:NSTextAlignmentLeft];
        self._fromTime = [UISubLabel labelWithTitle:@"08:12" frame:CGRectMake(100, 28, 100, 20) font:FontSize18 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        
        self._toCity = [UISubLabel labelWithTitle:@"上海" frame:CGRectMake(190, 17, 100, 30) font:FontSize32 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._toterminal = [UISubLabel labelWithTitle:@"浦东国际机场t1" frame:CGRectMake(190, 40, 150, 20) font:FontSize18 color:FontColor909090 alignment:NSTextAlignmentLeft];
        self._toTime = [UISubLabel labelWithTitle:@"09:12" frame:CGRectMake(275, 28, 100, 20) font:FontSize18 color:FontColor2387CF alignment:NSTextAlignmentLeft];
        
        [self addSubview:[UIImageView ImageViewWithFrame:CGRectMake(15, 70, 15, 15)image:[UIImage imageNamed:@"OrderInfoRule.png"]]];
        self._ruleLabel = [UISubLabel labelWithTitle:@"退改签规定" frame:CGRectMake(33, 68, 100, 20) font:FontSize18 color:FontColor000000 alignment:NSTextAlignmentLeft];
        self._flightCabinName =  [UISubLabel labelWithTitle:@"钻石豪华头等舱" frame:CGRectMake(0, 68, 310, 20) font:FontSize18 color:FontColor000000 alignment:NSTextAlignmentRight];
        
        self._flightTypeImage = [UIImageView ImageViewWithFrame:CGRectMake((ViewWidth-36)/2, 4, 36, 11) image:[UIImage imageNamed:@"去程.png"]];
        
        [self addSubview:self._planType];
        [self addSubview:self._fromDate];
        [self addSubview:self._companyImageV];
        [self addSubview:self._flightNo];
        [self addSubview:self._fromCity];
        [self addSubview:self._fromterminal];
        [self addSubview:self._fromTime];
        [self addSubview:self._toCity];
        [self addSubview:self._toterminal];
        [self addSubview:self._toTime];
        [self addSubview:self._ruleLabel];
        [self addSubview:self._flightCabinName];
        [self addSubview:self._flightTypeImage];
    }
    return self;
}
@end


@implementation TicketOrderInfoView
@synthesize centerView,headerView,isExpend,headerDataArray;
-(void)dealloc
{
    self.centerView = nil;
    self.headerView = nil;
    self.headerDataArray = nil;

    [super dealloc];
}

//-(void) assignedHeaderView:(FlightInfo * ) info sigleView:(FlightSingleInfo *)singleInfo hardView:(FlightHardInfo *)hardInfo index:(NSInteger)i :(TicketQueryDataModel * )queryDataModel
//{
//    singleInfo._fromTime.text = [info._startDate substringFromIndex:11];
//    
//    singleInfo._fromCity.text = queryDataModel._fromCity._nameStr;
//    singleInfo._toCity.text = queryDataModel._toCity._nameStr;
//    
//    if (queryDataModel._flightType == ConnectTypeSecond ) {
//        if (i == 0) {
//            singleInfo._fromCity.text = queryDataModel._fromCity._nameStr;
//            singleInfo._toCity.text = queryDataModel._transitCity._nameStr;
//        }
//        else {
//            singleInfo._fromCity.text = queryDataModel._transitCity._nameStr;
//            singleInfo._toCity.text = queryDataModel._toCity._nameStr;
//        }
//    }
//    else if (queryDataModel._flightType == RoundTypeBack) {
//        if (i == 0) {
//            singleInfo._fromCity.text = queryDataModel._toCity._nameStr;
//            singleInfo._toCity.text = queryDataModel._fromCity._nameStr;
//        }
//        else {
//            singleInfo._fromCity.text = queryDataModel._fromCity._nameStr;
//            singleInfo._toCity.text = queryDataModel._toCity._nameStr;
//        }
//    }
//    
//    singleInfo._toTime.text = [info._endTime substringFromIndex:11];
//    singleInfo._fromDate.text = [info._startDate substringToIndex:10];
//    singleInfo._companyImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[info._flightNo substringToIndex:2]]];
//    singleInfo._flightNo.text = [NSString stringWithFormat:@"%@%@",info._airline,info._flightNo];
//    singleInfo._flightCabinName.text = [NSString stringWithFormat:@"%@(%@)",info._selectedCabin._cabinTypeName,info._selectedCabin._cabinCode];
//    
//    hardInfo._planType.text = info._planeType;
//    hardInfo._fromDate.text = [info._startDate substringToIndex:10];
//    hardInfo._companyImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[info._flightNo substringToIndex:2]]];
//    hardInfo._flightNo.text =  [NSString stringWithFormat:@"%@%@",info._airline,info._flightNo];
//    hardInfo._fromCity.text = queryDataModel._fromCity._nameStr;
//    hardInfo._toCity.text = queryDataModel._toCity._nameStr;
//    
//    if (queryDataModel._flightType == ConnectTypeSecond ) {
//        if (i == 0) {
//            hardInfo._fromCity.text = queryDataModel._fromCity._nameStr;
//            hardInfo._toCity.text = queryDataModel._transitCity._nameStr;
//        }
//        else {
//            hardInfo._fromCity.text = queryDataModel._transitCity._nameStr;
//            hardInfo._toCity.text = queryDataModel._toCity._nameStr;
//        }
//    }  
//    else if (queryDataModel._flightType == RoundTypeBack) {
//        if (i == 0) {
//            hardInfo._fromCity.text = queryDataModel._toCity._nameStr;
//            hardInfo._toCity.text = queryDataModel._fromCity._nameStr;
//        }
//        else {
//            hardInfo._fromCity.text = queryDataModel._fromCity._nameStr;
//            hardInfo._toCity.text = queryDataModel._toCity._nameStr;
//        }
//    }
//    
//    hardInfo._fromterminal.text = [NSString stringWithFormat:@"%@%@",info._startAirport,info._startTerminal];
//    hardInfo._fromTime.text = [info._startDate substringFromIndex:11];
//    
//    hardInfo._toterminal.text = [NSString stringWithFormat:@"%@%@",info._endAirport,info._endTerminal];
//    hardInfo._toTime.text = [info._endTime substringFromIndex:11];
//    hardInfo._flightCabinName.text = [NSString stringWithFormat:@"%@(%@)",info._selectedCabin._cabinTypeName,info._selectedCabin._cabinCode];
//    
//}
-(void) initHeaderView:( FlightSingleInfo *)withSingleInfo :(FlightHardInfo *) withHardInfo
{
        singleInfo =withSingleInfo;// [[FlightSingleInfo alloc] initWithFrame:CGRectMake(0, 40, 320, 40)];    
        hardInfo = withHardInfo; //[[FlightHardInfo alloc] initWithFrame:CGRectMake(0, 90, 320, 90)];
        [self addSubview:hardInfo];
        [self addSubview:singleInfo];
        [singleInfo release];
        [hardInfo release];
//        
//        FlightInfo * info = [flightsInfoArray objectAtIndex:i];
//        [self assignedHeaderView:info sigleView:singleInfo hardView:hardInfo index:i :queryDataModel];

    self.headerView = singleInfo;
}
-(void) initCenterView
{
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(10, self.headerView.frame.size.height, self.frame.size.width, self.frame.size.height  - self.headerView.frame.size.height)];
    view2.backgroundColor = [UIColor clearColor];
    
    UIImageView * center1 = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, view2.frame.size.width, 7) image:[UIImage imageNamed:@"CenterView1.png"]];
    UIImageView * center2 = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, view2.frame.size.width, view2.frame.size.height) image:[UIImage imageNamed:@"CenterView2.png"]];
    UIImageView * footerShadow = [UIImageView ImageViewWithFrame:CGRectMake(0, view2.frame.size.height-6, view2.frame.size.width, 7) image:[UIImage imageNamed:@"CenterView3.png"]];
    
    [view2 addSubview:center2];
    [view2 addSubview:center1];
    [view2 addSubview:footerShadow];
    
    center2.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [view2 addSubview:[UIButton buttonWithTag:0 image:[UIImage imageNamed:@"抽屉.png"] title:nil  imageEdge:UIEdgeInsetsMake(0, (120-54) /2, 30-10, (120-54) /2)  frame:CGRectMake((view2.frame.size.width-120) / 2, 0, 120, 30) font:nil color:nil target:self action:@selector(expendHeaderView:)]];
    self.centerView = view2;
    [view2 release];

}
-(void)expendHeaderView:(UIButton *)sender
{
    self.isExpend = !self.isExpend;
    if (self.isExpend) {
        self.headerView = hardInfo;
        [sender setImage:[UIImage imageNamed:@"抽屉2.png"] forState:UIControlStateNormal];
    }
    else
    {
        self.headerView = singleInfo;
        [sender setImage:[UIImage imageNamed:@"抽屉.png"] forState:UIControlStateNormal];
    }
    
}

-(void)setHeaderView:(UIView *)_headerView
{
    if (headerView != _headerView) {
        [headerView release];
        [headerView setHidden:YES];
        headerView = [_headerView retain];
        [headerView setHidden:NO];
        [myTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
}
-(void)setHeaderDataArray:(NSArray *)_headerDataArray
{
    if (headerDataArray != _headerDataArray) {
        [headerDataArray release];
        headerDataArray = [_headerDataArray retain];
        [myTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        myTable = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        myTable.backgroundColor = [UIColor clearColor];
        myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        myTable.delegate = self;
        myTable.dataSource = self;
        [self addSubview:myTable];
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (self.headerDataArray) {
//        return [self.headerDataArray count] +1;
//    }
//    return 2;
    return [self.headerDataArray count] +1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString * idenfierHeader = @"idenfierHeader";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idenfierHeader];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfierHeader] autorelease];
            if (self.headerDataArray) {
                
            }
        }
	    cell.backgroundColor = [UIColor clearColor];

        return cell;
    }
    else {
        static NSString * idenfierCenter = @"idenfierCenter";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idenfierCenter];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfierCenter] autorelease];
            [self initCenterView];
            [cell addSubview:self.centerView];
        }
	    cell.backgroundColor = [UIColor clearColor];

        return cell;

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
