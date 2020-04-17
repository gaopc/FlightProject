//
//  RecommendSoftDataResponse.h
//  FlightProject
//
//  Created by gaopengcheng on 13-7-1.
//
//

#import <Foundation/Foundation.h>

@interface RecommendSoftDataResponse : NSObject
@property (nonatomic, retain) NSString *_softName;
@property (nonatomic, retain) NSString *_softDesc;
@property (nonatomic, retain) NSString *_softDownUrl;
@property (nonatomic, retain) NSString *_softImgUrl;
@property (nonatomic, retain) NSString *_totalPage;
@property (nonatomic, retain) NSString *_softId;

+ (NSArray *)setSoftList:(NSDictionary *)dic;
@end
