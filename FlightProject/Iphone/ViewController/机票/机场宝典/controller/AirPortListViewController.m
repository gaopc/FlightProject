//
//  AirPortListViewController.m
//  FlightProject
//
//  Created by 月 小 on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AirPortListViewController.h"

@interface AirPortListViewController ()

@end

@implementation AirPortListViewController
@synthesize alinesArray,airPortData,cureentArray,keyboardbar;
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
	// Do any additional setup after loading the view.
    self.title = @"机场列表";
    NSLog(@"机场列表");
    [self alinesArrayFromDB];
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-44) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view addSubview:myTable];
    [myTable release];
}

-(void) alinesArrayFromDB
{
    NSArray * dic = [DataClass selectFromAirportList];
    self.alinesArray = dic;
    self.cureentArray = dic;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.alinesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISubLabel * label = [[UISubLabel alloc] initWithFrame:CGRectMake(15, 5, 290, 30)];
        label.tag = 99;
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor blackColor];
        [cell.contentView addSubview:label];
        [label release];
	    cell.backgroundColor = [UIColor clearColor];
    }
    UISubLabel * textLabel = (UISubLabel *)[cell viewWithTag:99];
    textLabel.text = [[self.alinesArray objectAtIndex:indexPath.row] objectAtIndex:1] ;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.airPortData.airportName = [[self.alinesArray objectAtIndex:indexPath.row] objectAtIndex:1];
    self.airPortData.airportCode = [[self.alinesArray objectAtIndex:indexPath.row] objectAtIndex:0];
    [NavigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    myTable = nil;
    self.alinesArray = nil;
    self.airPortData = nil;
    self.cureentArray = nil;
    self.keyboardbar = nil;
    [super dealloc];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
