//
//  GCCustomSectionController.h
//  Demo
//
//  Created by Guillaume Campagna on 11-04-21.
//  Copyright 2011 LittleKiwi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCRetractableSectionController.h"

//That example show more advense cutomization

@interface GCCustomSectionController : GCRetractableSectionController
@property (nonatomic, retain) NSArray* content;
@property (nonatomic, retain)NSString* myTitle;

- (id)initWithArray:(NSArray*) array title:(NSString*)title viewController:(UIViewController *)givenViewController;

@end
