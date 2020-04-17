//
//  GCCustomSectionController.m
//  Demo
//
//  Created by Guillaume Campagna on 11-04-21.
//  Copyright 2011 LittleKiwi. All rights reserved.
//

#import "GCCustomSectionController.h"

@interface GCCustomSectionController ()

@end

@implementation GCCustomSectionController

@synthesize content,myTitle;

#pragma mark -
#pragma mark Simple subclass

- (NSString *)title {
    return NSLocalizedString(myTitle,);
}

- (NSUInteger)contentNumberOfRow {
    return [self.content count];
}

- (NSString *)titleContentForRow:(NSUInteger)row {
    return [self.content objectAtIndex:row];
}

- (void)didSelectContentCellAtRow:(NSUInteger)row {
    //Reaction to the selection
    NSLog(@"%@",[self.content objectAtIndex:row]);
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark -
#pragma mark Customization

- (UITableViewCell *)cellForRow:(NSUInteger)row {
    //All cells in the GCRetractableSectionController will be indented
    UITableViewCell* cell = [super cellForRow:row];
    
    cell.indentationLevel = 1;
    
    return cell;
}

- (UITableViewCell *)titleCell {
    //I removed the detail text here, but you can do whatever you want
    UITableViewCell* titleCell = [super titleCell];
    titleCell.detailTextLabel.text = nil;
    
    return titleCell;
}

- (UITableViewCell *)contentCellForRow:(NSUInteger)row {
    //You can reuse GCRetractableSectionController work by calling super, but you can start from scratch and give a new cell
    UITableViewCell* contentCell = [super contentCellForRow:row];
    
    contentCell.backgroundColor = [UIColor whiteColor];
    contentCell.accessoryView = nil;
    contentCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return contentCell;
}

#pragma mark -
#pragma mark Getters 

- (id)initWithArray:(NSArray*) array title:(NSString*)title viewController:(UIViewController *)givenViewController
{
    if ((self = [super initWithViewController:givenViewController])) {
        self.content = array;
        self.myTitle = title;
    }
    return self;
}

- (NSArray *)content {
    if (content == nil) {
//        content = [[NSArray alloc] initWithObjects:@"You can do", @"WHATEVER", @"you want!", nil];
    }
    return content;
}

- (void)dealloc {
    [content release];
    [myTitle release];
    content = nil;
    myTitle = nil;
    [super dealloc];
}

@end
