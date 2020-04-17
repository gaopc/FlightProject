//
//  MoreItemViewController.m
//  FlightProject
//
//  Created by gaopengcheng on 15-11-9.
//
//

#import "MoreItemViewController.h"
#import "HelpListViewController.h"
#import "AboutUsViewController.h"
#import "OnLineQuestionViewController.h"

@interface MoreItemViewController ()

@end

@implementation MoreItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 航班动态历史记录
    
    self.title = @"更多";
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, ViewWidth, ViewHeight - 54) style:UITableViewStylePlain];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.delegate = self;
    myTable.dataSource = self;
    [self.view addSubview:myTable];
    [myTable release];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *groundView = [UIImageView ImageViewWithFrame:CGRectMake(10, 5, ViewWidth - 20, 50) image:[[UIImage imageNamed:@"MembertableViewCell.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        UIImageView *iconView = [UIImageView ImageViewWithFrame:CGRectMake(30, 20   , 20, 20) image:[UIImage imageNamed:@"帮助.png"]];
        UILabel *titleLab = [UILabel labelWithTitle:@"帮助中心" frame:CGRectMake(60, 15, 100, 30) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft];
        
        iconView.tag = 88;
        titleLab.tag = 89;
        
        [cell addSubview:groundView];
        [cell addSubview:iconView];
        [cell addSubview:titleLab];
    }
    
    UIImageView *icoView = (UIImageView *)[cell viewWithTag:88];
    UILabel *desLab = (UILabel *)[cell viewWithTag:89];
    
    if (indexPath.row == 0) {
        icoView.image = [UIImage imageNamed:@"帮助.png"];
        desLab.text = @"帮助中心";
    }
    else if (indexPath.row == 1) {
        icoView.image = [UIImage imageNamed:@"关于.png"];
        desLab.text = @"关于我们";
    }
    else {
        icoView.image = [UIImage imageNamed:@"意见.png"];
        desLab.text = @"意见反馈";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [myTable deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        
        HelpListViewController *helpViewCtr = [[HelpListViewController alloc] init];
        [NavigationController pushViewController:helpViewCtr animated:YES];
        [helpViewCtr release];
    }
    else if (indexPath.row == 1) {
        
        AboutUsViewController *hotelViewCtr = [[AboutUsViewController alloc] init];
        [NavigationController pushViewController:hotelViewCtr animated:YES];
        [hotelViewCtr release];
    }
    else if (indexPath.row == 2) {
        
        OnLineQuestionViewController *onLineQuesCtr = [[OnLineQuestionViewController alloc] init];
        [self.navigationController pushViewController:onLineQuesCtr animated:YES];
        [onLineQuesCtr release];
    }
}
@end
