//
//  SearchHelpProblemByClassResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.52	查询使用帮助问题接口
#import <Foundation/Foundation.h>

@interface HelpProblem : NSObject
@property (nonatomic,retain) NSString * problem;
@property (nonatomic,retain) NSString * problemID;

@end

@interface SearchHelpProblemByClassResponse : NSObject

+(NSArray *)searchHelpProblemByClassResponseWithArray:(NSArray *)resultArray;

@end
