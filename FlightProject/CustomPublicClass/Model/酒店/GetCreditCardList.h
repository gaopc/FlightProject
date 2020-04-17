//
//  GetCreditCardList.h
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCreditCardList : NSObject
@property(nonatomic,retain)NSMutableArray *creditCardList;

+(GetCreditCardList*)GetCreditCardList:(NSDictionary*)dic;
@end

@interface CreditCardInfo : NSObject
@property(nonatomic,retain)NSString* ids;
@property(nonatomic,retain)NSString* userName;
@property(nonatomic,retain)NSString* idCard;
@property(nonatomic,retain)NSString* bank;
@property(nonatomic,retain)NSString* bankId;
@property(nonatomic,retain)NSString* bankIdCard;
@property(nonatomic,retain)NSString* validityDate;
@property(nonatomic,retain)NSString* cVV2Code;


@end
