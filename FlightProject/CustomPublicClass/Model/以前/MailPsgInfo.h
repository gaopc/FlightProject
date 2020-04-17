//
//  MailInfo.h
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MailPsgInfo : NSObject
@property (nonatomic, retain) NSString *mailName;
@property (nonatomic, retain) NSString *postalAddress;
@property (nonatomic, retain) NSString *postCode;
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic,retain) NSString * addressID; // 删除时使用

@end
