//
//  EditorMemberCell.h
//  FlightProject
//
//  Created by green kevin on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditorMemberCell : UITableViewCell
{
	UISubLabel *textLabel;
	
	UISubTextField *textField;
	UIImageView *imageView;
}
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UISubLabel *textLabel;
@property(nonatomic,retain)UISubTextField *textField; 
@end
