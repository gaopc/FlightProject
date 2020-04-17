//
//  EditorMemberCell.m
//  FlightProject
//
//  Created by green kevin on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EditorMemberCell.h"

@implementation EditorMemberCell
@synthesize textField,textLabel,imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		self.textLabel = [UISubLabel labelWithTitle:@"" frame:CGRectMake(0.0f, 10.0f, 57.0f, 30.0f) font:FontSize26 alignment:NSTextAlignmentRight];
		self.textLabel.textColor = FontColor696969;
		[self.contentView addSubview:self.textLabel];
		
		
		self.imageView = [UIImageView ImageViewWithFrame:CGRectMake(65.0f, 5.0f, 200.0f, 36.5f)];
		[self.imageView setImage:[UIImage imageNamed:@"MemberLoginTextBox.png"]];
		[self.contentView addSubview:self.imageView];
		
		self.textField = [UISubTextField TextFieldWithFrame:CGRectMake(65.0f, 10.0f, 200.0f, 30.0f) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@""];
		self.textField.backgroundColor =[UIColor clearColor];
		self.textField.font = FontSize26;
		self.textField.keyboardType = UIKeyboardTypeDefault;
		//self.textField.returnKeyType = UIReturnKeyNext;
		self.textField.clearButtonMode = UITextFieldViewModeAlways;
		self.textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
		[self.contentView addSubview:self.textField];
		
	}
    self.backgroundColor = [UIColor clearColor];
	return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
