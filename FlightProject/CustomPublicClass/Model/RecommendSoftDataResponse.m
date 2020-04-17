//
//  RecommendSoftDataResponse.m
//  FlightProject
//
//  Created by gaopengcheng on 13-7-1.
//
//

#import "RecommendSoftDataResponse.h"

@implementation RecommendSoftDataResponse
@synthesize _softDesc, _softDownUrl, _softImgUrl, _softName, _totalPage, _softId;

+ (RecommendSoftDataResponse *)setSoftInfo:(NSDictionary *)dic withPage:(NSString *)page
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    RecommendSoftDataResponse * recommendSoftInfo = [[RecommendSoftDataResponse alloc] init];
    recommendSoftInfo._softName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
    recommendSoftInfo._softDesc = [NSString stringWithFormat:@"%@", [dic objectForKey:@"desc"]];
    recommendSoftInfo._softId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"softId"]];
    recommendSoftInfo._softImgUrl = [NSString stringWithFormat:@"%@", [dic objectForKey:@"image"]];
    recommendSoftInfo._softDownUrl = [NSString stringWithFormat:@"%@", [dic objectForKey:@"downUrl"]];
    recommendSoftInfo._totalPage = page;
    
    return [recommendSoftInfo autorelease];
}

+ (NSArray *)setSoftList:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray * array = [dic objectForKey:@"softList"];
    NSString * totalPage = [NSString stringWithFormat:@"%@", [dic objectForKey:@"totalPage"]];
    if (![array isKindOfClass:[NSArray class]] ) {
        return nil;
    }
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary * elem in array) {
        [marray addObject:[self setSoftInfo:elem withPage:totalPage]];
    }
    return marray;
}
@end
